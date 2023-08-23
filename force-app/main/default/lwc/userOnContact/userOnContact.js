import { LightningElement, wire, api, track } from 'lwc';
import getUserInfoByEmail from '@salesforce/apex/contactUserController.getUserInfoByEmail';

export default class ContactUserInfo extends LightningElement {
    @api recordId;
    @api userFound = false;
    @api contactHasNoEmail = false;
    @api userNotFound = false;
    @track userInfo ;

    @wire(getUserInfoByEmail, { contactId: '$recordId'})
    handleUserResponse({ error, data }) {
        if (data) {
            this.userFound = true;
            this.userInfo = data;
        } else if (error) {
            console.error(error);
        } else {
            // User not found or contact doesn't have an email
            const contactWithoutEmail = this.recordId && !this.userInfo.email;
            this.contactHasNoEmail = contactWithoutEmail;
            this.userNotFound = !contactWithoutEmail;
        }
    }
}