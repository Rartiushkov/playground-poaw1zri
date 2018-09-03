public with sharing class ProductOrder {
    
    public List <Product_Table__c> products {get; set;} 
    public String paramValue {get;set;}
    
    String LastName, FirstName, Email;
    Integer UnitsAvailable;
    
    public ProductOrder() {
        paramValue = ApexPages.currentPage().getParameters().get('Id');
        
        products = [
            SELECT id, Name, Unit_Price__c
            FROM Product_Table__c 
            WHERE Id = : paramValue
        ];       
    }  
    
    Public String getEmail() {
        return Email;
    }
    Public void setEmail(String value) {
        Email = value;
    }
    
    Public String getFirstName() {
        return FirstName;
    }
    Public void setFirstName(String value) {
        FirstName = value;
    }
    
    Public String getLastName() {
        return LastName;
    }
    Public void setLastName(String value) {
        LastName = value;
    }
    
    Public Integer getUnitsAvailable() {
        return UnitsAvailable;
    }
    Public void setUnitsAvailable(Integer value) {
        UnitsAvailable = value;
    }
    
    public PageReference redirectBack() { 
        PageReference actFuncPage = Page.Product_List;     
        actFuncPage.setRedirect(true);
        return actFuncPage;
    }  
    
    public string checkOut() {
        
        List <Contact> contacts = [
            SELECT Email, FirstName, LastName 
            FROM Contact 
            WHERE Email = : Email
        ];
        
        List <Product_Table__c> products = [
            SELECT Unit_Price__c 
            FROM Product_Table__c
            WHERE id = : paramValue
        ];
        
        if(contacts.size() == 0) {
            Contact contact_new = new Contact(FirstName = FirstName, LastName = LastName, Email = Email);
            try {
                insert contact_new;
            }
            catch (DmlException ex) {
                return null;
            } 
        }
        else {              
            for (Integer i = 0; i < contacts.size(); i++) {         
                contacts[i].FirstName = FirstName;
                contacts[i].LastName = LastName;        
                try {
                    update contacts;
                }
                catch (DmlException ex) {
                    return null;
                }           
            }               
        }
   
        List <Contact> contactId = [
            SELECT id 
            FROM Contact 
            WHERE Email = : Email
        ];
        
        
        
        decimal Order_Amount = (UnitsAvailable * products[0].Unit_Price__c);
        
     
        OrderTable__c orderTables = new OrderTable__c (Field1__c= contactId[0].Id, Product__c = paramValue,
                                                          Units__c = UnitsAvailable, Order_Amount__c = Order_Amount); 
        insert orderTables;
        
        List <Product_Table__c> productUnits = [SELECT Units_Available__c FROM Product_Table__c WHERE id =:paramValue];
       
        productUnits[0].Units_Available__c = productUnits[0].Units_Available__c - decimal.valueOf(UnitsAvailable);
       
        if(productUnits[0].Units_Available__c > 0) {
        
            update productUnits;    
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Заказ принят'));             
        }
        else {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Не достаточно товара'));
        } 
        return null;
    }
}