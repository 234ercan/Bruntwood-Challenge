import { LightningElement, api } from 'lwc';
import fetchUserInfo from "@salesforce/apex/ContactUsersController.fetchUserInfo";

const columns = [
    {
        label: 'Name',
        fieldName: 'nameLink',
        type: 'url',
        typeAttributes: { label: { fieldName: 'name' }, target: '_blank' }
    }, {
        label: 'Email',
        fieldName: 'email',
        type: 'email',
    }, {
        label: 'Phone',
        fieldName: 'phone',
        type: 'phone',
    }, {
        label: 'Profile Name',
        fieldName: 'profileName',
        type: 'text'
    }
];

export default class DisplayUserInfo extends LightningElement {

    @api recordId;
    objUserInfo;
    error;
    messageString = '';
    isExist = false;
    columns = columns;
    
    connectedCallback(){
        console.log('recordId =>' + this.recordId);
        this.fetchUserDetails();
    }

    fetchUserDetails() {
        fetchUserInfo({ contactId: this.recordId })
          .then((result) => {
            console.log('Related User =>' + JSON.stringify(result));
            if(result){
                console.log('Related User =>' + JSON.stringify(result[0].errorMessage));
                if(result[0].errorMessage){
                    this.isExist = false;
                    this.messageString = result[0].errorMessage;
                }
                else{
                    this.isExist = true;
                    this.objUserInfo = result;
                    this.error = undefined;
                }
            }
            else{
                this.isExist = false;
                this.messageString = 'User does not exist for the current contact.'
            }
          })
          .catch((error) => {
            this.error = error;
            this.contacts = undefined;
          });
      }
}