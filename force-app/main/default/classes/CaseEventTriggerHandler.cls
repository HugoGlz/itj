public with sharing class CaseEventTriggerHandler {
    
    public static void onAfterInsert(List<CaseEvent__e> events) {

        try{

            Set<String> accountIds = new Set<String>();
            
            for( CaseEvent__e event : events ){
                accountIds.add(event.Account_Id__c);
            }

            Map<Id,Account> accountsByID = new Map<Id,Account>([SELECT Id,Name,OwnerId FROM Account WHERE Id IN :accountIds]);
            List<User> users = [SELECT Id FROM User WHERE IsActive = TRUE];

            List<Case> cases = new List<Case>();
    
            for( CaseEvent__e event : events ){
                Account account = accountsByID.get(event.Account_Id__c);
                
                Id userID = null;

                for (User user : users ){
                    if ( account.OwnerId != user.Id){
                        userID = user.Id;
                        break;
                    }
                }

                Case newCase = new Case();
                newCase.Subject = account.Name;
                newCase.OwnerId = userID;
                newCase.AccountId = account.Id;

                cases.add(newCase);
            }

            Database.insert(cases,false);
        }catch(Exception e){
            System.debug('Unexpected error on creating of cases :' + e.getMessage());
        }


    }
}