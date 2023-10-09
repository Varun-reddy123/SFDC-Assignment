@isTest
public class ExternalCountryServiceCalloutTest {
    @isTest
    static void testGetCountryDetails() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ExternalCountryServiceCalloutMockTest());
        ExternalCountryServiceCallout.getCountryDetails();
        Test.stopTest();
        Country__c updatedCountry = [SELECT alpha2code__c, alpha3code__c, Capital_city__c, region__c FROM Country__c WHERE Name = 'United States of America' LIMIT 1];
        System.assertEquals('AC22', updatedCountry.alpha2code__c);
        System.assertEquals('AC33', updatedCountry.alpha3code__c);
        System.assertEquals('Washington', updatedCountry.Capital_city__c);
        System.assertEquals('Region11', updatedCountry.region__c);  
    } 
    @isTest
    static void testGetCountryDetailUpdate() {
        Country__c testCountry = new Country__c(Name = 'United States of America',alpha2code__c = 'AC2',alpha3code__c = 'AC3',Capital_city__c = 'Capital1',region__c = 'Region1');
        insert testCountry;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ExternalCountryServiceCalloutMockTest());
        ExternalCountryServiceCallout.getCountryDetails();
        Test.stopTest();
        Country__c updatedCountry = [SELECT alpha2code__c, alpha3code__c, Capital_city__c, region__c FROM Country__c WHERE Name = 'United States of America' LIMIT 1];
        System.assertEquals('Washington', updatedCountry.Capital_city__c);
        System.assertEquals('Region11', updatedCountry.region__c);  
    }
}