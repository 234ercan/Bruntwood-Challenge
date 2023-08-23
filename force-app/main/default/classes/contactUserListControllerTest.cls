@isTest
public class contactUserListControllerTest {

    @isTest
    static void noUserWithEmail() {
        // Create a test Contact
        Contact testContact = new Contact(LastName='Test', Email = 'test@example.com');
        insert testContact;
		//create a test User
      User testUser = new User();   
        testUser.FirstName = 'John';
        testUser.LastName = 'Doe';
        testUser.Alias = 'JD';
        testUser.Email = 'test@example.com';
        testUser.Username = 'johndoe_987@example.com';
        testUser.CommunityNickname = 'johndoe123456';  
        testUser.ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User'].Id;    
        testUser.TimeZoneSidKey = 'Europe/London';
        testUser.LocaleSidKey = 'en_GB';
        testUser.EmailEncodingKey = 'UTF-8';   
        testUser.LanguageLocaleKey = 'en_US';

		insert testUser;

        Test.startTest();
        // Call the method being tested
        List<contactUserListController.userWrapper> result = contactUserListController.getUserInfoByEmail(testContact.Id);
        Test.stopTest();

        // Verify the results
        System.assertEquals(1, result.size());
       
    }
     @isTest
    static void UserWithSameEmail() {
        // Create a test Contact and User
        Contact testContact = new Contact(LastName='Test1', Email = 'test1@example.com');
        insert testContact;

      User testUser = new User();   
        testUser.FirstName = 'John';
        testUser.LastName = 'Doe';
        testUser.Alias = 'JD';
        testUser.Email = 'test1@example.com';
        testUser.Username = 'test1@example.com';
        testUser.CommunityNickname = 'johndoe123456';  
        testUser.ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User'].Id;    
        testUser.TimeZoneSidKey = 'Europe/London';
        testUser.LocaleSidKey = 'en_GB';
        testUser.EmailEncodingKey = 'UTF-8';   
        testUser.LanguageLocaleKey = 'en_US';

		insert testUser;

        Test.startTest();
        // Call the method being tested
        List<contactUserListController.userWrapper> result1 = contactUserListController.getUserInfoByEmail(testContact.Id);
        Test.stopTest();

        // Verify the results
        System.assertEquals(1, result1.size());
        contactUserListController.userWrapper wrapper = result1[0];
        System.assertEquals(testUser.Id, wrapper.userId);
        System.assertEquals(testUser.userName, 'test1@example.com');
        System.assertEquals(testUser.FirstName, wrapper.firstName);
        System.assertEquals(testUser.LastName, wrapper.lastName);
        System.assertEquals(testUser.Email, wrapper.email);
    }
    @isTest
static void contactEmailIsEmpty() {
    // Create a test Contact with an empty email
    Contact testContact = new Contact(LastName='Test', Email = '');
    insert testContact;

    Test.startTest();
    // Call getUserInfoByEmail with the test Contact Id
    List<contactUserListController.userWrapper> result = contactUserListController.getUserInfoByEmail(testContact.Id);
    Test.stopTest();
}
    @isTest
static void noUserFound() {
    // Create a test Contact with a valid email
    Contact testContact = new Contact(LastName='Test', Email = 'test@example.com');
    insert testContact;

    // Call getUserInfoByEmail, but don't insert any users
    Test.startTest();
    List<contactUserListController.userWrapper> result = contactUserListController.getUserInfoByEmail(testContact.Id);
    Test.stopTest();  
}
}