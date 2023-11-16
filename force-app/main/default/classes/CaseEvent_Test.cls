@isTest
private class CaseEvent_Test {
    
    @isTest
    static void test_triggerCaseEventAndCreateCase(){

        Account newAccount = new Account();
        newAccount.Name = 'Cuenta Prueba';
        newAccount.Risk__c = 'High';
        insert newAccount;
        
        CaseEvent__e caseEvent = new CaseEvent__e();
        caseEvent.Account_Id__c = newAccount.Id;

        Test.startTest();

            Database.SaveResult sr = EventBus.publish(caseEvent);
        Test.stopTest();

        List<Case> caseCreatedByTrigger = [SELECT Id FROM Case WHERE AccountId = :newAccount.Id];

        Assert.isFalse(caseCreatedByTrigger.isEmpty());
    }

}