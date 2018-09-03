public class ProductDetail {

   
    public ProductDetail() {

    }


    public ProductDetail(ProductOrder controller) {

    }


List<Product_Table__c> products;
public List<Product_Table__c> getProducts() {
if(products == null) {
products = [SELECT Id,  Name,Product_Description__c,Image__c,Units_Available__c,Unit_Price__c FROM Product_Table__c WHERE id=:ApexPages.CurrentPage().getparameters().get('id')]; 
}
return products;
}
public PageReference redirectBack() { 
        PageReference actFuncPage = Page.Products;     
        actFuncPage.setRedirect(true);
        return actFuncPage;
    }  
   public PageReference buy() {    
        PageReference page = Page.Order;     
        page.getParameters().get('id');
        page.setRedirect(true);
        
        return page;
    }
     

}