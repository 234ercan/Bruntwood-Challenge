public with sharing class contactUserController {
	@AuraEnabled(cacheable=true)
    public static UserWrapper getUserInfoByEmail(String contactId) {
        try{
        Contact contact = [SELECT Id, Email FROM Contact WHERE Id=:contactId AND Email != null LIMIT 1];
        if(contact != null) {
            User user = [SELECT Id, Username, FirstName, LastName, Email FROM User WHERE Email=:contact.Email  LIMIT 1];
            if(user != null) {
                UserWrapper wrapper = new UserWrapper();
                wrapper.userId = user.Id;
                wrapper.userName = user.Username;
                wrapper.firstName = user.FirstName;
                wrapper.lastname = user.LastName;
                wrapper.email = user.Email;
                return wrapper;
            }
        }
        }catch(Exception e){
            System.debug('Error: '+e.getMessage());
        }
        return null; // user not found or contact does not have email
    }
     public class UserWrapper {
        @AuraEnabled public string userId {get; set;}
        @AuraEnabled public String username { get; set; }
        @AuraEnabled public String firstName { get; set; }
        @AuraEnabled public String lastName { get; set; }
        @AuraEnabled public String email { get; set; }
    }
}