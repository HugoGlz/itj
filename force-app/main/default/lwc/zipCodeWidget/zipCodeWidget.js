import { LightningElement, wire } from 'lwc';
import { getObjectInfo, getPicklistValues } from "lightning/uiObjectInfoApi";

import COUNTRY_FIELD from "@salesforce/schema/Zip_Code__c.Country__c";
import ZIP_CODE_OBJECT from '@salesforce/schema/Zip_Code__c';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import getZipCodeData from '@salesforce/apex/ZipCodeController.getZipCodeData';

export default class ZipCodeWidget extends LightningElement {

  countryCode;
  zipCode;
  picklistValues;
  childData;

  @wire(getObjectInfo, { objectApiName: ZIP_CODE_OBJECT }) zipCodeObject;

  @wire(getPicklistValues, { recordTypeId: "$zipCodeObject.data.defaultRecordTypeId", fieldApiName: COUNTRY_FIELD }) 
  parseData({ error, data }) {
    if ( data ){ 
      this.picklistValues = data;
    }
  };

  get countryCodeOptions(){
    return  this.picklistValues?.values;
  }

  handleChangeCountryCode(event){
    this.countryCode = event.currentTarget.value;
  }

  handleChangeZipCode(event){
    this.zipCode = event.currentTarget.value;
  }

  handleSearchButton(){

    this.childData = null;

    if ( !this.countryCode ){
      return this.dispatchEvent(
        new ShowToastEvent({
          title: 'Error',
          message: 'The country code field is required',
          variant: 'error',
        })
      );
    }

    if ( !this.zipCode ){
      return this.dispatchEvent(
        new ShowToastEvent({
          title: 'Error',
          message: 'The zip code field is required',
          variant: 'error',
        })
      );
    }

    getZipCodeData({countryCode:this.countryCode, zipCode:this.zipCode})
    .then(response =>{
      if ( response.status === 'warning' || response.status === 'error'){
        return this.dispatchEvent(
          new ShowToastEvent({
            title: response.status.toUpperCase(),
            message: response.message,
            variant: response.status,
          })
        );
      }

      if ( !response.data ){
        return this.dispatchEvent(
          new ShowToastEvent({
            title: "Success",
            message: "The record external US zip code has been created/updated.",
            variant: "success",
          })
        );
      }

      this.childData = response.data;
    })
    .catch( errorMessage => {
      this.dispatchEvent(
        new ShowToastEvent({
          title: 'Error',
          message: 'An error occurred when trying to search the zip code: ' + JSON.stringify(errorMessage),
          variant: 'error',
        })
      );
    })
    
  }

}