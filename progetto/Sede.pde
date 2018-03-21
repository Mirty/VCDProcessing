int DIAMETRO = 100;

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
  }

  // metodi e funzioni
  void draw () {
    // fondazione
    strokeWeight (2);
    stroke(#718A62);
    noFill ();
    arc (coordinate.x, coordinate.y, DIAMETRO, DIAMETRO, angolo_iniziale, angolo_finale);
    pushMatrix();
    translate(coordinate.x + DIAMETRO, coordinate.y - DIAMETRO*1.25);
    rotate(radians(54)); 
    strokeWeight(4);
    line(0, 0, 10, 120); 
    popMatrix();

    // superficie totale
    stroke(#669900);
    strokeWeight (1);
    ellipse(coordinate.x, coordinate.y, raggio, raggio);

    // superficie produzione
    strokeWeight (3);
    stroke(#006699, 150);
    arc(coordinate.x, coordinate.y, raggio, raggio, angolo_iniziale, angolo_superficie_produzione);

    // impiegati
    int distanza_tra_imgs = 20;
    for (int i = 0; i < n_omini; i++) {
      image (img_employee, coordinate.x + DIAMETRO/2 + 10 + distanza_tra_imgs * i, coordinate.y - 20, 20, 20);
    }

    // produzione annuale
    image (img_gear, coordinate.x + DIAMETRO/2 + 10 + grandezza_rotella/2, coordinate.y + grandezza_rotella/2, grandezza_rotella, grandezza_rotella);

    // vendite annuali
    for (int i = 0; i < n_monete; i++) {
      image (img_euro, coordinate.x + DIAMETRO/2 + 10 + distanza_tra_imgs * i, coordinate.y + grandezza_rotella/2 + 20, 30, 30);
    }
  }

  void setVariables () {
    int [] tot_anni_fondazione = new int [sedi.length];
    float [] tot_superfici_totali = new float  [sedi.length];
    int []  tot_n_impiegati = new int [sedi.length];
    float [] tot_prezzi_annuali = new float  [sedi.length];
    float [] tot_vendite_annuali = new float  [sedi.length];
    
    for (int i = 0; i < sedi.length; i++) {
      tot_anni_fondazione [i] = sedi[i].anno_fondazione;
      tot_superfici_totali [i] = sedi[i].superficie_totale;
      tot_n_impiegati [i] = sedi[i].n_impiegati;
      tot_prezzi_annuali [i] = sedi[i].pezzi_annuali;
      tot_vendite_annuali [i] = sedi[i].vendite_annuali;
    }

    // curva fondazione   
    angolo_iniziale = - PI;
    angolo_finale = map (anno_fondazione, min (tot_anni_fondazione), max(tot_anni_fondazione), angolo_iniziale/2, 2*PI);

    // curva superficie
    max_raggio = 100;
    raggio = map (superficie_totale, min (tot_superfici_totali), max (tot_superfici_totali), 0, max_raggio);
    angolo_superficie_produzione = map (superficie_produzione, 0, superficie_totale, 0, 2*PI);

    // omini impiegati
    n_omini = int (map (n_impiegati, min (tot_n_impiegati), max (tot_n_impiegati), 1, max(tot_n_impiegati)/min(tot_n_impiegati)));

    // grandezza rotella
    grandezza_rotella = map (pezzi_annuali, min (tot_prezzi_annuali), max (tot_prezzi_annuali), 10, 30);

    // monete guadagnate
    n_monete = int (map (vendite_annuali, min (tot_vendite_annuali), max (tot_vendite_annuali), 1, max(tot_vendite_annuali)/min(tot_vendite_annuali)));
  }
}