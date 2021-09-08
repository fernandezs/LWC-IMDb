import { api, LightningElement } from 'lwc';

export default class OmdbMovieCard extends LightningElement {
    @api
    movie;

    handleClick(evt) {
        console.log(JSON.stringify(this.movie));
        this.dispatchEvent(new CustomEvent("movieclick",{detail : this.movie}));
    }
    
}