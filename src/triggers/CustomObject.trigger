trigger CustomObject on Custom__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	//Online trigger implementation helps us to maitain and  test coverage easily
	TriggerDispatcher.Run(new CustomObjectTriggerHandler());
}