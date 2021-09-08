import { api, LightningElement } from 'lwc';
import noData from './noData.html';
import empty from './empty.html';

export default class Illustration extends LightningElement {    
    @api
    template;
    @api
    title;
    @api
    subtitle;

    render() {
        return this.switchTemplate(this.template);
    }

    switchTemplate(type) {
        const templates = {
            'empty' : empty,
            'no-data' : noData
        }
        return templates[type] || empty;
      }
}