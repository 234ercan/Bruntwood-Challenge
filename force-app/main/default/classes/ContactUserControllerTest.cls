@isTest
public class ContactUserControllerTest {

    @isTest
    static void testGetUserInfoByEmail() {
        // Create a test Contact
        Contact testContact = new Contact();
        testContact.FirstName = 'TestFirstName';
        testContact.LastName = 'TestLastName';
        testContact.Email = 'test@example.com';
        insert testContact;

        // Create a test User with the same email address as the Contact
        User testUser = new User();
        
        testUser.FirstName = 'John';
        testUser.LastName = 'Doe';
        testUser.Alias = 'JD';
        testUser.Email = 'test@example.com';
        testUser.Username = 'johndoe_test@example.com';
        testUser.CommunityNickname = 'johndoeTest';
        testUser.ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User'].Id;    
        testUser.TimeZoneSidKey = 'Europe/London';
        testUser.LocaleSidKey = 'en_GB';
        testUser.EmailEncodingKey = 'UTF-8';   
        testUser.LanguageLocaleKey = 'en_US';

		insert testUser;

        // Call the getUserInfoByEmail method with the test Contact's Id
        ContactUserController.UserWrapper result = ContactUserController.getUserInfoByEmail(testContact.Id);

        // Verify that the result is not null (user found)
        System.assertNotEquals(null, result);
        // Verify that the user's username matches the expected value
        System.assertEquals('johndoe_test@example.com', result.username);
        // Verify that the user's first name matches the expected value
        System.assertEquals('John', result.firstName);
        // Verify that the user's last name matches the expected value
        System.assertEquals('Doe', result.lastName);
        // Verify that the user's email matches the expected value
        System.assertEquals('test@example.com', result.email);
    }

    @isTest
    static void testGetUserInfoByEmail_NoContactEmail() {
        // Create a test Contact without an email address
        Contact testContact = new Contact();
        testContact.FirstName = 'Jane';
        testContact.LastName = 'Smith';
        insert testContact;

        // Call the getUserInfoByEmail method with the test Contact's Id
        ContactUserController.UserWrapper result = ContactUserController.getUserInfoByEmail(testContact.Id);

        // Verify that the result is null (no email address in the contact)
        System.assertEquals(null, result);
    }

    @isTest
    static void testGetUserInfoByEmail_NoUserFound() {
        // Create a test Contact with an email address
        Contact testContact = new Contact();
        testContact.FirstName = 'Michael';
        testContact.LastName = 'Johnson';
        testContact.Email = 'michael@example.com';
        insert testContact;

        // Call the getUserInfoByEmail method with the test Contact's Id
        ContactUserController.UserWrapper result = ContactUserController.getUserInfoByEmail(testContact.Id);

        // Verify that the result is null (no user found with matching email)
        System.assertEquals(null, result);
    }
}