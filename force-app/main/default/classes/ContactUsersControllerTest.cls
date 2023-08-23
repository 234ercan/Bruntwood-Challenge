@isTest
public class ContactUsersControllerTest {
    static testMethod void testMethod1() 
    {
        //select a role
        UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
        system.debug('portalRole is ' + portalRole);
        //select a profile
        Profile profile1 = [Select Id from Profile where name = 'System Administrator'];
        //create a user
        User portalAccountOwner1 = new User(
            UserRoleId = portalRole.Id,
            ProfileId = profile1.Id,
            Username = System.now().millisecond() + 'test123@test.com',
            Alias = 'batman',
            Email='test.email@test.com',
            EmailEncodingKey='UTF-8',
            Firstname='Robert',
            Lastname='Brown',
            LanguageLocaleKey='en_US',
            LocaleSidKey='en_GB',
            TimeZoneSidKey='Europe/London'
        );
        Database.insert(portalAccountOwner1);
        
        //User u1 = [Select ID From User Where Id =: portalAccountOwner1.Id];
       List<Contact> listCnts = new List<Contact>();
        System.runAs ( portalAccountOwner1 ) {
            //Create account
            Account portalAccount1 = new Account(
                Name = 'TestAccount',
                OwnerId = portalAccountOwner1.Id
            );
            Database.insert(portalAccount1);
            
            //Create contact with email
            listCnts.add(new Contact(
                FirstName = 'Test',
                Lastname = 'McTesty',
                AccountId = portalAccount1.Id,
                Email = 'test12345@test.com'
            ));
            //contact with email;
            listCnts.add(new Contact(
                FirstName = 'Test1',
                Lastname = 'McTesty1',
                AccountId = portalAccount1.Id,
                Email = 'test12001@test.com'
            ));
            //contact with no email;
            listCnts.add(new Contact(
                FirstName = 'Test2',
                Lastname = 'McTesty2',
                AccountId = portalAccount1.Id
            ));
            Database.insert(listCnts);
            //Create user with the contacts email
            Profile portalProfile = [SELECT Id FROM Profile Where Name='System Administrator' Limit 1];
            User user1 = new User(
                ProfileId = portalProfile.Id,
                Alias = 'test123',
                Username = System.now().millisecond() + 'test321@test.com',
                Email = 'test12345@test.com',
                EmailEncodingKey = 'UTF-8',
                LastName = 'McTesty',
                CommunityNickname = 'test12345',
                TimeZoneSidKey = 'America/Los_Angeles',
                LocaleSidKey = 'en_US',
                LanguageLocaleKey = 'en_US'
            );
            Database.insert(user1);
        }
        Test.StartTest(); 
			ContactUsersController.fetchUserInfo(listCnts[0].Id);
        	ContactUsersController.fetchUserInfo(listCnts[1].Id);
        	ContactUsersController.fetchUserInfo(listCnts[2].Id);
		Test.StopTest();
    }
}