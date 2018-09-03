@isTest
private class ProductOrder_Test { 
    @isTest static void ProductOrder_Test1(){
    ProductOrder controller = new ProductOrder();        
    }  
    
    @isTest static void setEmailTest() {
        ProductOrder test = new ProductOrder();
        test.setEmail('TonyStark@gmail.com');
        string set_test = test.getEmail();
        System.assertEquals('rartiushkov@gmail.com', set_test);
    }
    
    @isTest static void setFirstNameTest() {
        ProductOrder test = new ProductOrder();
        test.setFirstName('Tony');
        string set_test = test.getFirstName();
        System.assertEquals('Tony', set_test);
    }
    
    @isTest static void setLastNameTest() {
        ProductOrder test = new ProductOrder();
        test.setLastName('Stark');
        string set_test = test.getLastName();
        System.assertEquals('Stark', set_test);
    }
    
    @isTest static void setUnitsAvailableTest() {
        ProductOrder test = new ProductOrder();
        test.setUnitsAvailable(2);
        integer set_test = test.getUnitsAvailable();
        System.assertEquals(2, set_test);
    }
    
    @isTest static void redirectBack_Test() {
        ProductOrder test = new ProductOrder();
        test.redirectBack();
    }
    
    @isTest static void checkOutTest1() {
        Product_Table__c newCont = new Product_Table__c(name = 'tony', Unit_Price__c = 2700, Units_Available__c = 100);
        insert newCont;    
        
        List <Product_Table__c> product= [SELECT  id  
                                          FROM Product_Table__c
                                          WHERE name =:newCont.name];
        
        ProductOrder test = new ProductOrder();
        
        test.paramValue = product[0].id;
        
        Contact newContact = new Contact(LastName = 'Piter',Email ='roman@tyt.by');
        insert newContact;
        
        test.setEmail('TonyStark@gmail.com');
        test.setFirstName('Tony');
        test.setLastName('Stark');
        test.setUnitsAvailable(2); 
        test.checkOut();
    }
    @isTest static void checkOutTest1_1() {
        Product_Table__c newCont = new Product_Table__c(name = 'tony', Unit_Price__c = 1700, Units_Available__c = 100);
        insert newCont;    
        
        List <Product_Table__c> product= [SELECT  id  
                                          FROM Product_Table__c
                                          WHERE name =:newCont.name];
        
        ProductOrder test = new ProductOrder();
        
        test.paramValue = product[0].id;
        
        Contact newContact = new Contact(LastName = 'tony',Email ='roman@tyt.by');
        insert newContact;
        
        test.setEmail('roman@tyt.by');
        test.setFirstName('');
        test.setLastName('');
        test.setUnitsAvailable(2); 
        test.checkOut();
    }
    @isTest static void checkOutTest2() {
        Product_Table__c newCont = new Product_Table__c(name = 'roma', Unit_Price__c = 3300, Units_Available__c = 100);
        insert newCont;    
        
        List <Product_Table__c> products= [SELECT  id  
                                          FROM Product_Table__c
                                          WHERE name =:newCont.name];
        
        ProductOrder test = new ProductOrder();
        
        
        Contact newContact = new Contact(LastName = 'Piter',Email ='TonyStark@gmail.com');
        insert newContact;
        
        test.setEmail('TonyStark@gmail.com');
        test.setFirstName('Tony');
        test.setLastName('Stark');
        test.setUnitsAvailable(3301); 
        test.checkOut();
    } 
    @isTest static void checkOutTest2_1() {
        Product_Table__c newCont = new Product_Table__c(name = 'tony', Unit_Price__c = 2700, Units_Available__c = 100);
        insert newCont;    
        
        List <Product_Table__c> products= [SELECT  id  
                                          FROM Product_Table__c
                                          WHERE name =:newCont.name];
        
       ProductOrder test = new ProductOrder();
        
        
        
        Contact newContact = new Contact(LastName = 'Piter',Email ='PiterParkergmail.com');
        insert newContact;
        
        test.setEmail('');
        test.setFirstName('');
        test.setLastName('');
        test.setUnitsAvailable(3301); 
        test.checkOut();
    }
}