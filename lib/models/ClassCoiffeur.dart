class Coiffeur {
  Coiffeur(this.nameCoiffeur, this.imageCardUrl, this.descriptionBio,
      this.imageBioUrl, this.tempAttente, this.nbrPerson, this.timeHaircut);

  String nameCoiffeur;
  String imageCardUrl;
  String descriptionBio;
  String imageBioUrl;
  int tempAttente;
  int nbrPerson;
  int timeHaircut;

  void calculateWaitingTime() {
    this.tempAttente = this.timeHaircut * this.nbrPerson;
  }
}
