import { LightningElement,api, track } from 'lwc';

export default class ZipCodeChild extends LightningElement {

  @api info;
  @track data;

  connectedCallback(){
    if ( this.info ){
      const jsonData = JSON.parse(this.info);

      let formatedJSON = {}

      Object.keys(jsonData).forEach( key => {

        if ( key === 'places' ){
          let places = [];
          jsonData[key].forEach( place => {
            let placeData = {};
            
            Object.keys(place).forEach( keyField => {
              placeData[keyField.split(' ').join('_')] = place[keyField];
            })

            places.push(placeData);
          })

          formatedJSON.places = places;
        }else{
          formatedJSON[key.split(' ').join('_')] = jsonData[key];
        }
      })

      this.data = formatedJSON;
    }
  }

}