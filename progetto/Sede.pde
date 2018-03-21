class Sede {
  // proprietà
  int anno_fondazione;
  float superficie_totale;
  float superficie_produzione;
  int n_impiegati;
  float pezzi_annuali;
  float vendite_annuali;
  Location coordinate;
  
  // costruttori
  Sede (int anno_fondazione, float superficie_totale, float superficie_produzione, int n_impiegati, float pezzi_annuali, float vendite_annuali, Location coordinate) {
    this.anno_fondazione = anno_fondazione;
    this.superficie_totale = superficie_totale;
    this.superficie_produzione = superficie_produzione;
    this.n_impiegati = n_impiegati;
    this.pezzi_annuali = pezzi_annuali;
    this.vendite_annuali = vendite_annuali;
    this.coordinate = coordinate;
  }
  
  // metodi e funzioni
  void draw () {
    
  }
}