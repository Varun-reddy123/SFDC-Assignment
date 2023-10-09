global class ExternalServicesCalloutBatch implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) { 
        String query = 'SELECT Id,Name,alpha2code__c,alpha3code__c,Capital_city__c,region__c,regionalBlocs__c FROM Country__c' ;
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<Country__c> scope) {
         
    }   
    
    global void finish(Database.BatchableContext BC) {
    }

}