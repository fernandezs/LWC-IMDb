import { api, LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import searchMovie from '@salesforce/apex/OMDbSearchController.searchMovie';
import searchMovieBtId from '@salesforce/apex/OMDbSearchController.findMovieById';
import { reduceErrors } from 'c/ldsUtils';

const MOVIE_NOT_FOUND = 'Movie not found!';

export default class OmdbSearchMovies extends LightningElement {
    
    searchParam;
    @track
    searchResult;
    isLoading = false;
    requestingMovie = false;
    movie;
    
    handleSearch() {
        if (this.searchParam == null || this.searchParam == '') {
            this.showToast('Ups!','Por favor ingresa una busqueda y luego presiona enter','warning');
            return;
        } 
        this.isLoading = true;
        searchMovie({searchParam : this.searchParam}).then(response => {
            if (response.success) {
                this.searchResult = JSON.parse(response.result);
            }
            else if (response.error == MOVIE_NOT_FOUND) {
                this.showToast('Ups!','No encontramos tu pelicula, puedes realizar otra busqueda','warning');
                this.searchResult = undefined;
                this.movie = undefined;
                const illustration = this.template.querySelector('c-illustration');
                if (illustration) {
                    illustration.title = 'Pelicula no encontrada';
                    illustration.subtitle = 'Por favor intenta con otra busqueda!';
                    illustration.template = 'no-data';
                }
            }
            else {
                this.showToast('Error!',`'Ocurrio un error en la busqueda: ${response.error}`,'error');
                this.searchResult = undefined;
            }
        }).catch(error => {
            this.showToast('Error',`Ocurrio un error en el servidor: ${reduceErrors(error)}`,'error');
        }).finally(()=> {
            this.isLoading = false;
        });
    }

    handleKeyUp(evt) {
        const isEnterKey = evt.keyCode === 13;
        if (isEnterKey) {
            this.searchParam = evt.target.value;
            this.handleSearch();
        }
    }

    handleChange(evt) {
        const val = evt.target.value;
        if (!val && this.searchResult) {
            this.searchResult = undefined;
            this.movie = undefined;
        }
    }

    handleShowMovie(evt) {
        this.requestingMovie = true;
        searchMovieBtId({imdbID : evt.detail.imdbID}).then(response => {
            this.movie = JSON.parse(response.result);
        }).catch(error => {
            this.movie = undefined;
            this.showToast('Error!',`'Ocurrio un error en la busqueda: ${response.error}`,'error');
        }).finally(()=> {
            this.requestingMovie = false;
        });
    }

    showToast(title,message,varian,mode ='dismissable') {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: varian,
            mode: mode
        });
        this.dispatchEvent(event);
    }


    get movies() {
        return this.searchResult?.Search || false;
    }
}