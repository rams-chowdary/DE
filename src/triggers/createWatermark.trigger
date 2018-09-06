trigger createWatermark on Custom__c (after Insert, after Update) {
    for(Custom__c custObjRec : Trigger.New){
        if(custObjRec.RamsChowdary__Watermark__c != null || custObjRec.RamsChowdary__Watermark__c != ''){
            if(Trigger.isInsert || (Trigger.Isupdate && Trigger.newMap.get(custObjRec.id).RamsChowdary__Watermark__c != Trigger.oldMap.get(custObjRec.id).RamsChowdary__Watermark__c)){
               FutureClassforCallout.createWaterMarkFutureCallout(custObjRec.id);
            }  
        }
    }

}