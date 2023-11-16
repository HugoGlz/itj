/*
 * Controller to look for zip codes 
 *  
*/

public with sharing class ZipCodeController {

    @AuraEnabled(cacheable=true)
    public static Map<String,Object> getZipCodeData(String countryCode, String zipCode){
         Map<String,Object>responseWrapper = new Map<String,Object>();
        
        try {
            HttpRequest request = new HttpRequest();
            
            request.setEndpoint('https://api.zippopotam.us/' + countryCode + '/' + zipCode);
            request.setMethod('GET');
            request.setHeader('Accept', 'application/json');

            HttpResponse respoonse = new Http().send(request);
            String bodyJSON = respoonse.getBody();
            
            System.debug(bodyJSON);

            if ( bodyJSON.equals('{}') ){
                responseWrapper.put('status','warning');
                responseWrapper.put('message', 'Zip Code not found.');
                return responseWrapper;
            }
            
            Map<String, Object> mappedResponse = (Map<String, Object>) JSON.deserializeUntyped(bodyJSON);
            
            if ( mappedResponse.containsKey('country abbreviation') && mappedResponse.get('country abbreviation').equals('US')){
                responseWrapper.put('status','success');
                responseWrapper.put('data',bodyJSON);
            }else{
                upsertZipCode(bodyJSON);
                responseWrapper.put('status','success');
            }
        } catch (Exception e) {
            responseWrapper.put('status','error');
            responseWrapper.put('message', e.getMessage());
        }

        return responseWrapper;
    }


    @future
    public static void upsertZipCode(String bodyJSON){
        Map<String, Object> mappedResponse = (Map<String, Object>) JSON.deserializeUntyped(bodyJSON);
        Zip_Code__c zp = new Zip_Code__c();
        zp.Name = mappedResponse.get('post code').toString();
        zp.Country__c = mappedResponse.get('country abbreviation').toString();
        zp.Places__c = mappedResponse.get('places').toString();
        upsert zp Zip_Code__c.Name;
    }
}