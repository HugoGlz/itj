@isTest
private class ZipCodeController_Test {
    
    @isTest
    static void test_getUSZipCode(){
        Test.setMock(HttpCalloutMock.class, new US_ZipCodeCalloutMock());

        Map<String,Object> response = ZipCodeController.getZipCodeData('US','89109');

        Assert.isFalse(response.isEmpty());
        System.assertEquals('success', response.get('status'));
        Assert.isTrue(response.containsKey('data'));
    }

    @isTest
    static void test_getNonUSZipCode(){
        Test.setMock(HttpCalloutMock.class, new NonUS_ZipCodeCalloutMock());

        Map<String,Object> response = ZipCodeController.getZipCodeData('MX','10379');

        Assert.isFalse(response.isEmpty());
        System.assertEquals('success', response.get('status'));
        Assert.isFalse(response.containsKey('data'));
    }

    @isTest
    static void test_zipCodeNotFound(){
        Test.setMock(HttpCalloutMock.class, new NotFound_ZipCodeCalloutMock());

        Map<String,Object> response = ZipCodeController.getZipCodeData('MX','00000');
        
        Assert.isFalse(response.isEmpty());
        System.assertEquals('warning', response.get('status'));
        System.assertEquals('Zip Code not found.', response.get('message'));
    }

    @isTest
    static void test_fail(){
        Test.setMock(HttpCalloutMock.class, new Error_ZipCodeCalloutMock());
        
        Map<String,Object> response = ZipCodeController.getZipCodeData(null,null);

        Assert.isFalse(response.isEmpty());
        System.assertEquals('error', response.get('status'));
    }

}