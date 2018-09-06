public class CustomObjectTriggerHandler implements TriggerHandler {
    
   public static Boolean TriggerDisabled = false;
    
   public Boolean IsDisabled()
    {
        return false;//false means - Trigger hasn't disabled
        /* Use below to control the trigger enabale/disable using settings
        if (cusstomsetting.settingname = true)
            return true;
        else
            return TriggerDisabled;
		*/
    }
 
    public void BeforeInsert(List<SObject> newItems) {
        //We can access specific Helper/Utility classes to execute the business logic
        System.debug('Accessing before Insert');
    }
 
    public void BeforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
        System.debug('Accessing before Update');
    }
 
    public void BeforeDelete(Map<Id, SObject> oldItems) {
        System.debug('Accessing before Delete');
    }
 
    public void AfterInsert(Map<Id, SObject> newItems) {
        System.debug('Accessing after Insert');
    }
 
    public void AfterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
        System.debug('Accessing after Update');
    }
 
    public void AfterDelete(Map<Id, SObject> oldItems) {
        System.debug('Accessing after Delete');
    }
 
    public void AfterUndelete(Map<Id, SObject> oldItems) {
        System.debug('Accessing after Undelete');
    }

 

}