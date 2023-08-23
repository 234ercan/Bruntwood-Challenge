import { LightningElement, api, track, wire} from 'lwc';
import getUserByEmail from '@salesforce/apex/contactUserListController.getUserInfoByEmail';

export default class ContactUserTable extends LightningElement {

   @api recordId;
   @api Message='';
   @api showData=false;
   @track data;
   @wire (getUserByEmail, { contactId: '$recordId' })
   handleUserResponse({ error, data }) {
      if (data && !data[0].message) {
          this.data = data;
          this.showData=true;
      } else if(data&& data[0].message) {
         this.showData=false;
         this.Message=data[0].message;
      }else if(error){
          console.error(error);
      }
           
      }
}
