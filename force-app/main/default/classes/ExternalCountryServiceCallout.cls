public class ExternalCountryServiceCallout {
    /*************************************
     * @Name          getCountryDetails
     * @Description   This method is performing as a callout.
     * @Param		  null
     * @Return        void
     * **********************************/
    public static void getCountryDetails(){
        HttpRequest request = new HttpRequest();
        Http http = new Http();
        HttpResponse response = new HttpResponse();
        request.setMethod('GET');
        string url='http://api.countrylayer.com/v2/all?access_key=b5db3d1c2a1af5ef0160bad73d02caa6';
        request.setEndpoint(url);
        response = http.send(request);
        system.debug('===response==='+response);
        system.debug('===response==='+response.getBody());
        CountryWrapper[] CountryList = (List<CountryWrapper>)JSON.deserialize(response.getBody(), List<CountryWrapper>.class);
        system.debug('===CountryList==='+CountryList);
        upsertCountryDetails(CountryList);
    }
    /*************************************
     * @Name          upsertCountryDetails
     * @Description   This method is updating the country details.
     * @Param		  CountryList
     * @Return        void
     * **********************************/
    public static void upsertCountryDetails(List<CountryWrapper> CountryList){
        List<Country__c> countriesInSF = new List<Country__c> ([SELECT id,Name,alpha2code__c,alpha3code__c,Capital_city__c,region__c,regionalBlocs__c from Country__c]);
        Map<string,CountryWrapper> con_Wrap = new Map<string,CountryWrapper>();
        for(CountryWrapper wrap:CountryList){
            con_Wrap.put(wrap.name,wrap);
        }
        Map<string,Country__c> conInSF_Con = new Map<string,Country__c>();
        for(Country__c con:countriesInSF){
            conInSF_Con.put(con.name,con);
        }
        List<Country__c> contryToInsert = new List<Country__c>();
        for(string key : con_Wrap.keyset()){   
            if(!conInSF_Con.containsKey(key)){
                Country__c con  = new Country__c();
                con.Name = con_Wrap.get(key).Name;
                con.alpha2code__c = con_Wrap.get(key).alpha2Code;
                con.alpha3code__c = con_Wrap.get(key).alpha3Code;
                con.Capital_city__c = con_Wrap.get(key).capital;
                con.region__c = con_Wrap.get(key).region;
                contryToInsert.add(con); 
            }
        }
        insert contryToInsert;
        List<Country__c> contryToUpdate = new List<Country__c>();
        for(string cnName : con_Wrap.keyset()){   
            if(conInSF_Con.containsKey(cnName)){
                if(con_Wrap.get(cnName).alpha2Code != conInSF_Con.get(cnName).alpha2code__c
                   || con_Wrap.get(cnName).alpha3Code != conInSF_Con.get(cnName).alpha3code__c
                   || con_Wrap.get(cnName).capital != conInSF_Con.get(cnName).Capital_city__c
                   || con_Wrap.get(cnName).region != conInSF_Con.get(cnName).region__c
                  ){
                      conInSF_Con.get(cnName).alpha2code__c = con_Wrap.get(cnName).alpha2Code;
                      conInSF_Con.get(cnName).alpha3code__c = con_Wrap.get(cnName).alpha3Code;
                      conInSF_Con.get(cnName).Capital_city__c = con_Wrap.get(cnName).capital;
                      conInSF_Con.get(cnName).region__c = con_Wrap.get(cnName).region;
                  }
                contryToUpdate.add(conInSF_Con.get(cnName)); 
            }
        }
        update contryToUpdate;
    }
    
    
}