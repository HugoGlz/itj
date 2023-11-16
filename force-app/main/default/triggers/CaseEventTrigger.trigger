trigger CaseEventTrigger on CaseEvent__e (after insert) {

  if ( Trigger.operationType == TriggerOperation.AFTER_INSERT){
    CaseEventTriggerHandler.onAfterInsert(Trigger.new);
  }


}