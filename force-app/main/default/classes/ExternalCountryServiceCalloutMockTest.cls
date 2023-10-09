@isTest
public class ExternalCountryServiceCalloutMockTest implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('[{"name": "United States of America", "alpha2Code": "AC22", "alpha3Code": "AC33", "capital": "Washington", "region": "Region11"}]');
            res.setStatusCode(200);
            return res;
        }
}