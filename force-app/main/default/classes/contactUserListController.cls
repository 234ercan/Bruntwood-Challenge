public class contactUserListController {
    @AuraEnabled (cacheable=true)
    public static List<userWrapper> getUserInfoByEmail(String contactId){
        Contact contact=[SELECT Id, Email FROM Contact WHERE Id=:contactId LIMIT 1];
         List<userWrapper> userWrapperList = new List<userWrapper>(); 
        if(contact!=null){
          List<User> userList = [SELECT Id, Name, FirstName, LastName, Email FROM User WHERE Email=:contact.Email];
            if(contact.Email!=null && contact.Email!=''){
               	if(userList.size()>0){
                    for(User user:userList){
                    userWrapper wrapper = new userWrapper();
                        wrapper.userId = user.Id;
                        wrapper.userName = user.Name;
                        wrapper.firstName = user.FirstName;
                        wrapper.lastName = user.LastName;
                        wrapper.email = user.Email;
                        wrapper.contactEmail = contact.Email;
                        userWrapperList.add(wrapper);
                        }
                    return userWrapperList;
            }else{
                 userWrapper wrapper = new userWrapper();
            	wrapper.message= system.label.NoUserMessage;
            	userWrapperList.add(wrapper);
            	return userWrapperList; 
            }
            }else{
            userWrapper wrapper = new userWrapper();
            wrapper.message= system.label.ContactHasNoEmail;
            userWrapperList.add(wrapper);
            return userWrapperList; 
        	}
        }
        return null;
    }
    public class userWrapper {
        @AuraEnabled public string userId { get ; set; }
        @AuraEnabled public string userName { get ; set; }
        @AuraEnabled public string firstName { get ; set; }
        @AuraEnabled public string lastName { get ; set; }
        @AuraEnabled public string email { get ; set; }
        @AuraEnabled public string contactEmail {get; set;}
        @AuraEnabled public string message {get; set;}
    }
}