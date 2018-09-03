public class ProductController {
List<Product_Table__c> products;
public List<Product_Table__c> getProducts() {
if(products == null) {
products = [SELECT Id, Image__c, Name, Product_Description__c, Unit_Price__c FROM Product_Table__c];
}
return products;
}
public PageReference buy() {    
        PageReference page = Page.Order;     
        page.getParameters().get('id');
        page.setRedirect(true);
        
        return page;
    }
}