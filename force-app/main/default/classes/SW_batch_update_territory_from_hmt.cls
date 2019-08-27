global class SW_batch_update_territory_from_hmt implements Database.Batchable<sObject> ,Database.Stateful{
    
    Map<String,HMT_Master__c> hmtentityMap = new Map<String,HMT_Master__c>();//put hmt ent id as key to get object
    
    Map<String,Territory2> terMap = new Map<String,Territory2>();
    
    Map<String,HMT_Master__c> terEntityMap = new Map<String,HMT_Master__c>();
    
    Map<String,Territory2> terEUMap = new Map<String,Territory2>();
    
    Map<String,Territory2> terMap1 = new Map<String,Territory2>();
    
    Map<Integer, String> errorMsg = new map<Integer, String>();
    
    Map<String,HMT_Master__c> hmtentity = new Map<String,HMT_Master__c>();
    
    Map<String,String> ssomap = new Map<String,String>();
    
    // Map<String,Hierarchy_User__c> usrhmtMap = new Map<String,Hierarchy_User__c>();
    
    Map<String,User> usrmap = new Map<String,User>();
    
    Set<Id> hmtid = new Set<Id>();
    public final Map<String, Id> terParents = new Map<String, Id>();
    
    map<string,string> errorsMap = new map<string,string>();
    set<String> terDeveloperNameSet = new set<String>();
    list<HMT_Entity_Batch_Report__c>  errosOnHmtIntegrationList;
    list<HMT_Entity_Batch_Report__c>  errosOnHmtIntegrationFinalList  = new list<HMT_Entity_Batch_Report__c>();
    
    list<string> errorsList ;
    
    global database.querylocator start(Database.BatchableContext BC)
    {    
        list<string> poleList = new List<string>();
        string polestring = Label.Pole_Name;
        string poleType = 'Pole';
        poleList = polestring.split(':');
        system.debug('poleList..'+poleList);
        //and SW_Entity_Type__c != poleType
        String query = 'SELECT Id,SW_Hmt_Sequence__c,Name,SW_Hierarchy_Type__c,SW_Entity_Name__c,SW_Pole_TM__c,SW_Geo_TM__c,SW_Area_TM__c,SW_Parent_ID__c,Primary_User_Name__c,SW_Region_TM__c,SW_Entity_Type__c,SW_Parent_ID__r.SW_No_SFDC_Integration__c,SW_No_SFDC_Integration__c,SW_Parent_ID__r.name,LastModifiedDate from HMT_Master__c where SW_Pole_TM__c in ';
        query+=': poleList and SW_No_SFDC_Integration__c = false order by SW_Hmt_Sequence__c asc' ;  //Addedd by Gaurav Jain  
        //system.debug('data..'+Database.getQueryLocator(query));
        system.debug('query'+query);
        system.debug('data..'+Database.getQueryLocator(query));
        return Database.getQueryLocator(query);
        
    }
    
    global void execute(Database.BatchableContext BC, Sobject[] scope)
    {  
        
        
        //string terDevRemoveKey;
        map<string,HMT_Master__c> mapDeltedHMTData = new map<string,HMT_Master__c>();
        string pole = Label.Pole_Name;
        list<HMT_Master__c> deleteedHmtRecords = [ SELECT Id,SW_Hmt_Sequence__c,IsDeleted,Name,SW_Hierarchy_Type__c,SW_Entity_Name__c,SW_Pole_TM__c,SW_Geo_TM__c,SW_Area_TM__c,SW_Parent_ID__c,Primary_User_Name__c,SW_Region_TM__c,SW_Entity_Type__c,SW_Parent_ID__r.SW_No_SFDC_Integration__c,SW_No_SFDC_Integration__c,SW_Parent_ID__r.name,LastModifiedDate from HMT_Master__c  where (SW_Pole_TM__c =:pole and SW_No_SFDC_Integration__c = false and IsDeleted = true) ALL ROWS];
        if(deleteedHmtRecords.size() > 0  ){
            for(HMT_Master__c hmtDeleted:deleteedHmtRecords){
                mapDeltedHMTData.put(hmtDeleted.name,hmtDeleted);
            }
        }
        system.debug('mapDeltedHMTData..'+mapDeltedHMTData);
        system.debug('mapDeltedHMTData..'+mapDeltedHMTData.size());
        set<string> setDeveloperName = new set<string>();
         for(HMT_Master__c hmtmas : (List<HMT_Master__c>)scope)
        {   
            hmtentityMap.put(hmtmas.Name,hmtmas);
            hmtid.add(hmtmas.id); 
            
            
        }
        
       
        setDeveloperName.add(getDevelperNAME(hmtentityMap));
        system.debug('setDeveloperName..'+setDeveloperName);
        for(Territory2 terr: [Select id,Name,Territory2ModelId,ParentTerritory2Id,HMT_Entity__c,DeveloperName,GEW_Pole__c,GEW_Geo__c,GEW_Region_District__c,GEW_Area__c from Territory2 where (HMT_Entity__c IN :hmtentityMap.keyset() or DeveloperName IN :setDeveloperName)])
        {
            terMap.put(terr.HMT_Entity__c,terr);
            terMap1.put(terr.ParentTerritory2Id,terr);
            
            terParents.put(terr.HMT_Entity__c,terr.id);
            
            terDeveloperNameSet.add(terr.DeveloperName);
            
        }
        
        system.debug('terMap..'+terMap);
        
        
        
       
        
        
        Map<String,Territory2> terMaptobeins = new Map<String,Territory2>();
        Map<String,Territory2> terMaptobeinsForNew = new Map<String,Territory2>();
        Map<String,Territory2> terMaptobeinsForUpDate = new Map<String,Territory2>();
        
        
        HMT_Master__c tempEntity;
        checkDelteEntityInHmtMaster(terMap);
        terMaptobeinsForNew = insertTerritory(hmtentityMap,terMap);
        system.debug('terMaptobeinsForNew..'+terMaptobeinsForNew);
        terMaptobeinsForUpDate = updateTerritory(hmtentityMap,terMap);
        terMaptobeinsForNew.putAll(terMaptobeinsForUpDate);
        //terMaptobeinsForNew.putAll(terMaptobeinsForUpDate);
        system.debug('terMaptobeinsForUpDate..'+terMaptobeinsForUpDate);
        system.debug('final upsert ter MaptobeinsForUpDate..'+terMaptobeinsForUpDate);
        system.debug('Final errors on excete'+errosOnHmtIntegrationList);
        system.debug('Final Final errosOnHmtIntegrationFinalList'+errosOnHmtIntegrationFinalList);
        
        
        system.debug('terMaptobeinsForNew ..'+terMaptobeinsForNew );
        for(string testTerritory2:terMaptobeinsForNew .keyset()){
            system.debug('testTerritory2'+testTerritory2);
            system.debug('testterritory'+terMaptobeinsForNew .values());
            system.debug('testTerritory2'+testTerritory2+'testterritory.. Name..'+terMaptobeinsForNew .get(testterritory2).Name);
            system.debug('testterritory.. DeveloperName..'+terMaptobeinsForNew .get(testterritory2).DeveloperName);
            
        }
        try{
        if(!terMaptobeinsForNew .isempty()){
            if(terMaptobeinsForNew .values() != null){
                //system.debug('before insert'+terMaptobeins.values());
                Database.upsert(terMaptobeinsForNew .values());
                //system.debug('after insert'+terMaptobeins.values());
            }
        }
        }catch(exception e){
            HMT_Entity_Batch_Report__c hmtEntityBatch = new HMT_Entity_Batch_Report__c(); 
            hmtEntityBatch.Error_Message__c = e.getMessage();
            errosOnHmtIntegrationList.add(hmtEntityBatch);
            system.debug('error in catch..'+hmtEntityBatch.Error_Message__c );
            system.debug('error in catch..list'+hmtEntityBatch.Error_Message__c );
                
            
            
        }
        
        
    }
    
    
    global void finish(Database.BatchableContext BC)
    {
        system.debug('err....final...'+errorsMap);
        list<HMT_Entity_Batch_Report__c > hmtBatchlist = [select id,name from HMT_Entity_Batch_Report__c];
        map<string,HMT_Entity_Batch_Report__c > hmtBatchlistMap = new map<string,HMT_Entity_Batch_Report__c >();
        system.debug('hmtBatchlist..'+hmtBatchlist);
        system.debug('errosOnHmtIntegrationFinalList..'+errosOnHmtIntegrationFinalList);
        system.debug('errosOnHmtIntegrationFinalList..size'+errosOnHmtIntegrationFinalList.size());
        
        delete hmtBatchlist;
        
        List<HMT_Entity_Batch_Report__c> hmtEntityBatchList = new List<HMT_Entity_Batch_Report__c> (); 
        HMT_Entity_Batch_Report__c hmtEntityBatch = new HMT_Entity_Batch_Report__c(); 
        List<HMT_Entity_Batch_Report__c> hmtEntityBatchListzp2 = new List<HMT_Entity_Batch_Report__c> ();
        //system.debug('err....final...'+errosOnHmtIntegrationList);
        //system.debug('err....final...list size..'+errosOnHmtIntegrationList.size());
        if(!errosOnHmtIntegrationFinalList.isempty()){
            for(HMT_Entity_Batch_Report__c er: errosOnHmtIntegrationFinalList){
                system.debug('Error Entity_ID__c'+er.Entity_ID__c);
                system.debug('Error message'+er.Error_Message__c);
                hmtBatchlistMap.put(er.Entity_ID__c, er);
            }
            system.debug('before insert..errosOnHmtIntegrationFinalList'+errosOnHmtIntegrationFinalList);
            
            insert hmtBatchlistMap.values();
            
        }
        
        
        
    }
    public Map<String,Territory2> insertTerritory(Map<String,HMT_Master__c> hmtentityMap,Map<String,Territory2> Territory2Map){
        map<string,Territory2> finalInsertTerritory = new map<string,Territory2>();
        errosOnHmtIntegrationList = new  list<HMT_Entity_Batch_Report__c>();
        list<string> errorList = new list<string>();
        for(String keyId: hmtentityMap.Keyset()){
            system.debug('keyId..'+keyId);
            //tempEntity = new HMT_Master__c();
            HMT_Master__c tempEntity = new HMT_Master__c();
            tempEntity =  hmtentityMap.get(keyId);
            if(!terMap.keyset().contains(keyId))
            {
                system.debug('key'+keyId);
                
                string terDevRemoveKey;
                for(string terDevelperName: terDeveloperNameSet){
                    if(terDevelperName.contains(keyId)  ){
                        terDevRemoveKey = keyId;
                        system.debug('terDevRemoveKey..'+terDevRemoveKey);
                        
                        //errorList.add(terDevRemoveKey);
                        HMT_Entity_Batch_Report__c hmtErrorReport = new HMT_Entity_Batch_Report__c();
                        hmtErrorReport.Entity_ID__c = hmtentityMap.get(terDevRemoveKey).Name;
                        hmtErrorReport.Pole__c = hmtentityMap.get(terDevRemoveKey).SW_Pole_TM__c;
                        hmtErrorReport.Geo__c = hmtentityMap.get(terDevRemoveKey).SW_Geo_TM__c;
                        hmtErrorReport.Region__c = hmtentityMap.get(terDevRemoveKey).SW_Region_TM__c;
                        hmtErrorReport.Area__c = hmtentityMap.get(terDevRemoveKey).SW_Area_TM__c;
                        
                        
                        hmtErrorReport.Error_Message__c = 'The territory '+terDevRemoveKey+'Developer name..'+terDevelperName+' in SFDC has same Entity ID and Entity name, but it \'s not linked to the HMT entity. Enter the HMT Entity ID into SFDC before the record can be updated.';
                        errosOnHmtIntegrationList.add(hmtErrorReport);
                        system.debug('error in insert..'+hmtErrorReport.Error_Message__c);
                        system.debug('errosOnHmtIntegrationList in insert..'+errosOnHmtIntegrationList);
                        
                        
                        
                        
                    }
                }
                
                
                
                
                Territory2 terr = new Territory2();
                //UserTerritory2 usrterr = new UserTerritory2();
                
                // Create new terrritory based on Entity type.
                if(tempEntity != null){
                    system.debug('in if....tempEntity'+tempEntity);
                    if(tempEntity.SW_Entity_Type__c != null && tempEntity.SW_Entity_Type__c != 'Service/Growth' ) {
                        //if(tempEntity.SW_Parent_ID__c != null  )
                        if(tempEntity.SW_No_SFDC_Integration__c != true ) {
                            
                            
                            if(tempEntity.SW_Entity_Type__c == 'Geo'){//If Entity type is Geo
                                system.debug('Geo');
                                terr.Name = 'W'+tempEntity.SW_Hierarchy_Type__c+' '+tempEntity.Name+' '+tempEntity.SW_Entity_Name__c+' '+'- Geo';
                                 terr.DeveloperName = getDevelperNAME(hmtentityMap);
                                system.debug('terr.DeveloperName..'+terr.DeveloperName);
                            }
                            if(tempEntity.SW_Entity_Type__c == 'Region'){//If Entity type is Region
                                system.debug('Region');
                                terr.Name = 'W'+tempEntity.SW_Hierarchy_Type__c+' '+tempEntity.Name+' '+tempEntity.SW_Entity_Name__c+' '+'- Region';
                                 terr.DeveloperName = getDevelperNAME(hmtentityMap);
                                system.debug('terr.DeveloperName..'+terr.DeveloperName );
                            }
                            if(( tempEntity.SW_Entity_Name__c != null) && tempEntity.SW_Entity_Type__c == 'Area'){//If Entity type is Area and Entity name is not empty
                                system.debug('Area null');
                                terr.Name = 'W'+tempEntity.SW_Hierarchy_Type__c+' '+tempEntity.Name+' '+tempEntity.SW_Entity_Name__c+' '+'- Area';
                                 terr.DeveloperName = getDevelperNAME(hmtentityMap);
                                system.debug('terr.DeveloperName..'+terr.DeveloperName );
                            }
                            else if(( tempEntity.SW_Entity_Name__c == null) && tempEntity.SW_Entity_Type__c == 'Area'   ){//If Entity type is Area and Entity name is empty
                                system.debug('Area not null');
                                terr.Name = 'W'+tempEntity.SW_Hierarchy_Type__c+' '+tempEntity.Name+' '+'- Area';
                                
                                 terr.DeveloperName = getDevelperNAME(hmtentityMap);
                                
                                system.debug('terr.DeveloperName..'+terr.DeveloperName );
                                
                            }
                            if(( tempEntity.SW_Entity_Name__c != null ) && tempEntity.SW_Entity_Type__c == 'Acct Mgr' ){//If Entity type is Acct Mgr and Entity name is not empty
                                terr.Name = 'W'+tempEntity.SW_Hierarchy_Type__c+' '+tempEntity.Name+' '+tempEntity.SW_Entity_Name__c+' '+'- AcM';
                                terr.DeveloperName = getDevelperNAME(hmtentityMap);
                                system.debug('terr.DeveloperName..'+terr.DeveloperName );
                                
                                
                            }
                            else if( ( tempEntity.SW_Entity_Name__c == null) && tempEntity.SW_Entity_Type__c == 'Acct Mgr' ){//If Entity type is Acct Mgr and Entity name is empty
                                terr.Name = 'W'+tempEntity.SW_Hierarchy_Type__c+' '+tempEntity.Name+' ' +tempEntity.Primary_User_Name__c+' '+'- AcM';
                                
                                terr.DeveloperName = getDevelperNAME(hmtentityMap);
                                system.debug('terr.DeveloperName..'+terr.DeveloperName );
                            }
                            
                            //if(tempEntity.SW_Entity_Type__c == 'Service/Growth')//If Entity type is Region
                            //terr.Name = 'W'+tempEntity.SW_Hierarchy_Type__c+' '+tempEntity.Name+' '+tempEntity.SW_Entity_Name__c+' '+'- Service/Growth';
                            
                            terr.HMT_Entity__c = tempEntity.Name;
                            terr.GEW_Pole__c = tempEntity.SW_Pole_TM__c;
                            terr.GEW_Geo__c = tempEntity.SW_Geo_TM__c;
                            terr.Territory2ModelId='0MA6F000000LF6UWAW';
                            terr.Territory2TypeId = '0M56F000000L1btSAC';
                            //terr.GEW_Region_District__c = tempEntity.SW_Region_TM__c;
                            terr.GEW_Area__c = tempEntity.SW_Area_TM__c;
                            system.debug('parent name..'+tempEntity.SW_Parent_ID__r.name);
                            
                            //rama added new code starts here
                            if(tempEntity.name != terDevRemoveKey){
                                if(terParents.containsKey(tempEntity.SW_Parent_ID__r.name)){
                                    system.debug('parent name..in'+tempEntity.SW_Parent_ID__r.name);
                                    Territory2 territoryObj = terMap.get(tempEntity.SW_Parent_ID__r.name);//tempEntity.SW_Parent_ID__c;
                                    terr.ParentTerritory2Id = territoryObj.id;
                                    //terr.ParentTerritory2Id = terParents.get(tempEntity.SW_Parent_ID__r.name);//tempEntity.SW_Parent_ID__c;
                                    
                                    finalInsertTerritory.put(keyId,terr);
                                    
                                    system.debug('terMaptobeins insert..'+finalInsertTerritory);
                                    system.debug('new child value..'+tempEntity.name +'parent value'+tempEntity.SW_Parent_ID__r.name +'terr.HMT_Entity__c.'+terr.HMT_Entity__c);
                                }else{
                                    system.debug('Else part in insert..');
                                    HMT_Entity_Batch_Report__c hmtErrorReport = new HMT_Entity_Batch_Report__c();
                                    
                                    hmtErrorReport.Entity_ID__c = tempEntity.Name;
                                    hmtErrorReport.Pole__c = tempEntity.SW_Pole_TM__c;
                                    hmtErrorReport.Geo__c = tempEntity.SW_Geo_TM__c;
                                    hmtErrorReport.Region__c = tempEntity.SW_Region_TM__c;
                                    hmtErrorReport.Area__c = tempEntity.SW_Area_TM__c;
                                    hmtErrorReport.Error_Message__c = 'Parent "'+tempEntity.Name +'" of the Parent" not in SFDC. insert';
                                    errosOnHmtIntegrationList.add(hmtErrorReport);
                                    system.debug('Pole..'+tempEntity.SW_Pole_TM__c+'new child value..'+tempEntity.name +'parent value'+tempEntity.SW_Parent_ID__r.name +'terr.HMT_Entity__c.'+terr.HMT_Entity__c);
                                    
                                }
                            }
                            
                        }   
                    }   
                }
            }
        }
        errosOnHmtIntegrationFinalList.addAll(errosOnHmtIntegrationList);
        system.debug('final error list in insert..'+errosOnHmtIntegrationFinalList);
        //errosOnHmtIntegrationFinalList.addAll(errosOnHmtIntegrationList);
        system.debug('terMaptobeins insert..final'+finalInsertTerritory);
        return finalInsertTerritory;
    }
    public Map<String,Territory2> updateTerritory(Map<String,HMT_Master__c> hmtentityMap,Map<String,Territory2> Territory2Map){
        map<string,Territory2> finalUpdateTerritory = new map<string,Territory2>();
        errosOnHmtIntegrationList = new  list<HMT_Entity_Batch_Report__c>();
        for(String keyId: hmtentityMap.Keyset()){
            system.debug('keyId..'+keyId);
            //tempEntity = new HMT_Master__c();
            HMT_Master__c tempEntity = new HMT_Master__c();
            tempEntity =  hmtentityMap.get(keyId);
            if(Territory2Map.keyset().contains(keyId))
            {
                Territory2 terrUpdate = new Territory2();
                if(terrUpdate != null){
                    if( tempEntity.SW_Entity_Type__c != 'Pole' || tempEntity.SW_Entity_Type__c != 'Service/Growth'){
                        
                        
                        if(tempEntity.SW_No_SFDC_Integration__c != true ){
                            if(Territory2Map.get(keyId).HMT_Entity__c == tempEntity.Name){
                                
                                
                                if(Territory2Map.get(keyId).GEW_Pole__c != tempEntity.SW_Pole_TM__c){
                                    
                                    terrUpdate.GEW_Pole__c = tempEntity.SW_Pole_TM__c;
                                }
                                if(Territory2Map.get(keyId).GEW_Region_District__c != tempEntity.SW_Region_TM__c){
                                    terrUpdate.GEW_Region_District__c = tempEntity.SW_Region_TM__c;
                                }
                                
                                if(Territory2Map.get(keyId).GEW_Geo__c != tempEntity.SW_Geo_TM__c){
                                    terrUpdate.GEW_Geo__c = tempEntity.SW_Geo_TM__c;
                                }
                                if(Territory2Map.get(keyId).GEW_Area__c != tempEntity.SW_Area_TM__c){
                                    terrUpdate.GEW_Area__c = tempEntity.SW_Area_TM__c;
                                }    
                                //} 
                                if(Territory2Map.containsKey(tempEntity.Name)){
                                    system.debug('if terMap1.'+tempEntity.Name);
                                    system.debug('parent id..'+tempEntity.SW_Parent_ID__r.name);
                                    if(Territory2Map.containsKey(tempEntity.SW_Parent_ID__r.name)){
                                        system.debug(' parent id in if');
                                        //system.debug('tempEntity.get(s).SW_Parent_ID__r.name..'+tempEntity.get(s).SW_Parent_ID__r.name +'terDevRemoveKey..'+terDevRemoveKey);
                                        // if(tempEntity.get(s).SW_Parent_ID__r.name != terDevRemoveKey)
                                        terrUpdate.id =Territory2Map.get(keyId).id;
                                        system.debug(' parent final id'+Territory2Map.get(keyId).HMT_Entity__c);
                                        //finalUpdateTerritory.put(keyId,terrUpdate);
                                        //if(!terrUpdate.isempty()){
                                        system.debug(' parent final id update if 1');
                                        if(terrUpdate != null){
                                            system.debug(' parent final id update if '+terrUpdate);
                                            //system.debug('before insert'+terMaptobeins.values());
                                            finalUpdateTerritory.put(Territory2Map.get(keyId).HMT_Entity__c,terrUpdate);
                                        }
                                        
                                    }
                                    else{
                                        HMT_Entity_Batch_Report__c hmtErrorReport = new HMT_Entity_Batch_Report__c();
                                        hmtErrorReport.Entity_ID__c = tempEntity.Name;
                                        hmtErrorReport.Pole__c = tempEntity.SW_Pole_TM__c;
                                        hmtErrorReport.Geo__c = tempEntity.SW_Geo_TM__c;
                                        hmtErrorReport.Region__c = tempEntity.SW_Region_TM__c;
                                        hmtErrorReport.Area__c = tempEntity.SW_Area_TM__c;
                                        
                                        hmtErrorReport.Error_Message__c = 'Parent ID '+tempEntity.SW_Parent_ID__r.name+': "'+tempEntity.Name+'" of the Parent" not in SFDC. update ';
                                        errosOnHmtIntegrationList.add(hmtErrorReport);  
                                        
                                    }
                                    
                                }
                            }
                            
                        } 
                        
                    }
                    
                }
            }
            
        }
        errosOnHmtIntegrationFinalList.addAll(errosOnHmtIntegrationList);
        system.debug('final error list in insert..'+errosOnHmtIntegrationFinalList);
        system.debug('finalUpdateTerritory..'+finalUpdateTerritory);
        
        return finalUpdateTerritory;
    }
    public void checkDelteEntityInHmtMaster(Map<String,Territory2> terMap){
        system.debug('In checkDelteEntityInHmtMaster');
        
        errosOnHmtIntegrationList = new  list<HMT_Entity_Batch_Report__c>();
        map<string,HMT_Master__c> mapDeltedHMTData = new map<string,HMT_Master__c>();
        //errosOnHmtIntegrationList = new  list<HMT_Entity_Batch_Report__c>();
        string pole = 'EU';
        list<HMT_Master__c> deleteedHmtRecords = [ SELECT Id,SW_Hmt_Sequence__c,IsDeleted,Name,SW_Hierarchy_Type__c,SW_Entity_Name__c,SW_Pole_TM__c,SW_Geo_TM__c,SW_Area_TM__c,SW_Parent_ID__c,Primary_User_Name__c,SW_Region_TM__c,SW_Entity_Type__c,SW_Parent_ID__r.SW_No_SFDC_Integration__c,SW_No_SFDC_Integration__c,SW_Parent_ID__r.name,LastModifiedDate from HMT_Master__c  where (SW_Pole_TM__c =:pole and SW_No_SFDC_Integration__c = false and IsDeleted = true) ALL ROWS];
        if(deleteedHmtRecords.size() > 0  ){
            for(HMT_Master__c hmtDeleted:deleteedHmtRecords){
                mapDeltedHMTData.put(hmtDeleted.name,hmtDeleted);
            }
        }
        system.debug('mapDeltedHMTData..'+mapDeltedHMTData);
        system.debug('mapDeltedHMTData..'+mapDeltedHMTData.size());
        for(string terrDeleteKey : terMap.keySet()){
            
            if(terrDeleteKey != null){
                if(mapDeltedHMTData.keyset().contains(terrDeleteKey))
                {
                    string errormessage = 'Territory (' 
                        +terMap.get(terrDeleteKey).name+' - '+ terrDeleteKey +  
                        ') not in HMT. Move all entities linked to this territoy in SFDC and delete the territory.';
                    HMT_Entity_Batch_Report__c hmtErrorReport = new HMT_Entity_Batch_Report__c();
                    hmtErrorReport.Entity_ID__c = terMap.get(terrDeleteKey).HMT_Entity__c;   
                    hmtErrorReport.Pole__c = terMap.get(terrDeleteKey).GEW_Pole__c;
                    hmtErrorReport.Geo__c = terMap.get(terrDeleteKey).GEW_Geo__c;
                    hmtErrorReport.Region__c = terMap.get(terrDeleteKey).GEW_Region_District__c;
                    hmtErrorReport.Area__c = terMap.get(terrDeleteKey).GEW_Area__c;
                    
                    hmtErrorReport.Error_Message__c = errormessage;
                    system.debug('hmtErrorReport.Error_Message__c..'+hmtErrorReport.Error_Message__c);
                    errosOnHmtIntegrationList.add(hmtErrorReport);
                    
                    system.debug('errosOnHmtIntegrationList in delete'+errosOnHmtIntegrationList);                        
                }
            }
            
        }
        
        errosOnHmtIntegrationFinalList.addAll(errosOnHmtIntegrationList);
        system.debug('final error list in insert..'+errosOnHmtIntegrationFinalList);
        
    }
    public string getDevelperNAME(Map<String,HMT_Master__c> hmtentityMap){
       String devName='';
        for(String keyId: hmtentityMap.Keyset()){
            system.debug('keyId..'+keyId);
            //tempEntity = new HMT_Master__c();
            HMT_Master__c tempEntity = new HMT_Master__c();
            tempEntity =  hmtentityMap.get(keyId);
            
            
             
            if(tempEntity.SW_Entity_Type__c == 'Pole'){//If Entity type is Pole
                system.debug('Pole');
                
                string entityName = tempEntity.SW_Entity_Name__c;
                entityName = entityName.replaceAll('[^a-zA-Z0-9\\s+]',' ');
                entityName =  entityName.replaceALL(' ','_').removeEnd('_');
                
                string entityId = tempEntity.Name;
                entityId = entityId.replaceAll('[^a-zA-Z0-9\\s+]',' ');
                entityId =  entityId.replaceALL(' ','_').removeEnd('_');
                devName = entityName + '_' + entityId;
                
                
            }
            if(tempEntity.SW_Entity_Type__c == 'Geo'){//If Entity type is Geo
                system.debug('Geo');
                
                string entityName = tempEntity.SW_Entity_Name__c;
                entityName = entityName.replaceAll('[^a-zA-Z0-9\\s+]',' ');
                entityName =  entityName.replaceALL(' ','_').removeEnd('_');
                
                string entityId = tempEntity.Name;
                entityId = entityId.replaceAll('[^a-zA-Z0-9\\s+]',' ');
                entityId =  entityId.replaceALL(' ','_').removeEnd('_');
                devName = entityName + '_' + entityId;
                
                
            }
            if(tempEntity.SW_Entity_Type__c == 'Region'){//If Entity type is Region
                system.debug('Region');
                
                string entityName = tempEntity.SW_Entity_Name__c;
                entityName = entityName.replaceAll('[^a-zA-Z0-9\\s+]',' ');
                entityName =  entityName.replaceALL(' ','_').removeEnd('_');
                
                string entityId = tempEntity.Name;
                entityId = entityId.replaceAll('[^a-zA-Z0-9\\s+]',' ');
                entityId =  entityId.replaceALL(' ','_').removeEnd('_');
                devName = entityName + '_' + entityId;
                
                
            }
            if(( tempEntity.SW_Entity_Name__c != null) && tempEntity.SW_Entity_Type__c == 'Area'){//If Entity type is Area and Entity name is not empty
                system.debug('Area null');
                
                string entityName = tempEntity.SW_Entity_Name__c;
                entityName = entityName.replaceAll('[^a-zA-Z0-9\\s+]',' ');
                entityName =  entityName.replaceALL(' ','_').removeEnd('_');
                
                string entityId = tempEntity.Name;
                entityId = entityId.replaceAll('[^a-zA-Z0-9\\s+]',' ');
                entityId =  entityId.replaceALL(' ','_').removeEnd('_');
                
                devName = entityName + '_' + entityId;
                
            }
            else if(( tempEntity.SW_Entity_Name__c == null) && tempEntity.SW_Entity_Type__c == 'Area'   ){//If Entity type is Area and Entity name is empty
                system.debug('Area not null');
                
                
                string entityId = tempEntity.Name;
                entityId = entityId.replaceAll('[^a-zA-Z0-9\\s+]',' ');
                entityId =  entityId.replaceALL(' ','_').removeEnd('_');
                
                devName = 'Area'+'_'+entityId;
                
                
                
            }
            if(( tempEntity.SW_Entity_Name__c != null ) && tempEntity.SW_Entity_Type__c == 'Acct Mgr' ){//If Entity type is Acct Mgr and Entity name is not empty
                
                //terr.DeveloperName ='AcctMgr';
                string entityName = tempEntity.SW_Entity_Name__c;
                entityName = entityName.replaceAll('[^a-zA-Z0-9\\s+]',' ');
                entityName =  entityName.replaceALL(' ','_').removeEnd('_');
                
                string entityId = tempEntity.Name;
                entityId = entityId.replaceAll('[^a-zA-Z0-9\\s+]',' ');
                entityId =  entityId.replaceALL(' ','_').removeEnd('_');
                
                devName = entityName + '_' + entityId;
                
                
                
            }
            else if( ( tempEntity.SW_Entity_Name__c == null) && tempEntity.SW_Entity_Type__c == 'Acct Mgr' ){//If Entity type is Acct Mgr and Entity name is empty
                
                string entityId = tempEntity.Name;
                entityId = entityId.replaceAll('[^a-zA-Z0-9\\s+]',' ');
                entityId =  entityId.replaceALL(' ','_').removeEnd('_');
                devName = 'AcM'+'_'+entityId;
                
                
            }
        }
        
        return devNAme;
    }
    
    
}