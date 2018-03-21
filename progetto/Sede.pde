class Sede {
  // proprietà
  String nome;
  int anno_fondazione;
  float superficie_totale;
  float superficie_produzione;
  int n_impiegati;
  float pezzi_annuali;
  float vendite_annuali;
  Location coordinate;
  // altre proprieta utili
  float angolo_iniziale;
  float angolo_finale;
  int max_raggio;
  float raggio;
  float angolo_superficie_produzione;
  int n_omini;
  float grandezza_rotella;
  int n_monete;

  // costruttori
  Sede (String nome, int anno_fondazione, float superficie_totale, float superficie_produzione, int n_impiegati, float pezzi_annuali, float vendite_annuali, Location coordinate) {
    this.nome = nome;
    this.anno_fondazione = anno_fondazione;
    this.superficie_totale = superficie_totale;
    this.superficie_produzione = superficie_produzione;
    this.n_impiegati = n_impiegati;
    this.pezzi_annuali = pezzi_annuali;
    this.vendite_annuali = vendite_annuali;
    this.coordinate = coordinate;
    setVariables ();
  }

  // metodi e funzioni
  void draw () {
    
  }

  void setVariables () {
    int [] tot_anni_fondazione = new int [sedi.length - 1];
    float [] tot_superfici_totali = new float  [sedi.length - 1];
    int []  tot_n_impiegati = new int [sedi.length - 1];
    float [] tot_prezzi_annuali = new float  [sedi.length - 1];
    float [] tot_vendite_annuali = new float  [sedi.length - 1];

    // curva fondazione   
    angolo_iniziale = 0;
    angolo_finale = map (anno_fondazione, min (tot_anni_fondazione), max(tot_anni_fondazione), angolo_iniziale, 2*PI);

    // curva superficie
    max_raggio = 100;
    raggio = map (superficie_totale, min (tot_superfici_totali), max (tot_superfici_totali), 0, max_raggio);
    angolo_superficie_produzione = map (superficie_produzione, 0, superficie_totale, 0, 2*PI);

    // omini impiegati
    n_omini = int (map (n_impiegati, min (tot_n_impiegati), max (tot_n_impiegati), 1, max(tot_n_impiegati)/min(tot_n_impiegati)));

    // grandezza rotella
    grandezza_rotella = map (pezzi_annuali, min (tot_prezzi_annuali), max (tot_prezzi_annuali), 10, 50);

    // monete guadagnate
    n_monete = int (map (vendite_annuali, min (tot_vendite_annuali), max (tot_vendite_annuali), 1, max(tot_vendite_annuali)/min(tot_vendite_annuali)));
  }
}