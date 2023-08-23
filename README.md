BRUNTWOOD SALESFORCE DEVELOPER CODDING CHALLENGE DOCUMENTATION
This documentation outlines the process and steps undertaken to complete the Salesforce Development challenge presented by Bruntwood. The challenge involves developing a Lightning Web Component (LWC) to display user details that share the same email address as a contact record. 

1. Setting up the Development Environment
a- Creating a New Salesforce Developer Org.
To complete this challenge, a new Salesforce Developer Edition Org was created. This org served as the development environment for building and testing the required components and functionality.

b- Creating a Salesforce User
A new user was created within the Salesforce Developer Org. This user was assigned the Salesforce Administrator profile and given the email address chatter@bruntwood.co.uk.

2. Developing the Lightning Web Components
Depending on the business requirement there might be different approach for the solution. From UI perspective, I produced three different approach:
a- LWC for Single User Details
In this approach, LWC displays details for a single user. Obviously, we can display any field of the user depends on business need.  I displayed some basic field values retrieved from the Salesforce database by using wrapper class and Apex class.
 

b- Multiple User Details displayed with data table
In this approach, another LWC was developed to retrieve and display details for multiple users who shared the same email address as the contact. This component provided a list view of user details. I used HTML data table to display the results. 
 
c- Multiple User Details displayed with lightning data table
First implementation is showing only the details of the first user; second implementation is displaying the details of all related users. However, none of them is providing a dynamic link for easy access to the users. In this implementation, I used Lightning data table. This allow me to click on the value of a field and access to user details. In case of need, we can select one or more of the users from the list and use them as input values.
 

3. Backend Development Approaches
From backend perspective two main approaches are considered for LWC development:
a. Wired Approach
In this approach, the "wire" decorator was employed along with the "AuraEnabled(cacheable=true)" annotation to efficiently retrieve data from Salesforce. 
b. Imperative Approach
In the second approach, the "wire" decorator was not used. Instead, the "connectedCallback" life cycle hook was utilized to fetch data from Salesforce and populate the component.
In both approach, to interact with the Salesforce database and retrieve user details, AuraEnabled Apex classes were created. These classes provided the necessary data to the Lightning Web Components.
I also used wrapper class to return data into component. The wrapper class is created as an inner class. It could be also used as a separate class. 
The code details can be found here. 

4. Displaying Alternative Messages  
When the user is not exist with the contact email, the wrapper class return null value and LWC has no data to display. In this case, I display a message for users. There are two messages here: first one is shown when the contact has an email but there is no user has the same email. Second case is occurs when there is no email on contact record. To display the relevant message to the user, there are different methods. In my implementation, I used some of them. The messages can be given from JS file, HTML file or on Apex class. Obviously, I could style the message text separately including text color, font size, font weight etc. I styled it with inline styling. It could be done via css class as well.
   
There is one more solution to display dynamic message. This is creating a custom label and refer the custom label in the JS or Apex class. In this approach, Salesforce Administrators can change the message without opening any code page. I have created two custom labels and referred them in Apex classes.

5. Unit Testing
Unit tests were developed for each Apex class to ensure maximum test coverage. This rigorous testing approach helped guarantee the reliability and robustness of the code.
 

7. Security
The components set for utilizing in Record_Page. The page design is visible to System Administrator only. I set component visibility filters for each LWC. Access for Apex classes are given to System Administrator. To grant right access for the right user, I used with sharing keywords for Apex classes. 
     

6. GitHub Repository
Finally, a GitHub repository was created to manage version control and code sharing. All development work, including Lightning Web Components, Apex classes, and unit tests, was pushed to this repository for collaboration and documentation.
Here is the repo link: 

This documentation serves as a comprehensive guide to the development process and steps taken to complete the Salesforce Development challenge presented by Bruntwood. It covers the setup of the development environment, LWC creation, Apex classes, wrapper classes, unit testing, and code management through GitHub.

Prepared by Ercan Yilmaz

