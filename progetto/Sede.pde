int DIAMETRO = 320;
color colore_principale = color (20, 151, 24);
color colore_secondario = color (138, 203, 140);
color colore_terziario = color (255);
int distanza_tra_imgs = 20;

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
  int max_diametro, min_diametro;
  float diametro;
  float angolo_superficie_produzione;
  int n_omini;
  int n_rotelle;
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
    int spessore = 12;
    strokeWeight (spessore);
    stroke(colore_principale);
    noFill ();
    arc (pos.x, pos.y, DIAMETRO, DIAMETRO, angolo_iniziale, angolo_finale);
    pushMatrix();
    translate(pos.x + cos(radians (90)) * DIAMETRO/2 + spessore/3, pos.y - sin(radians(90)) * DIAMETRO/2 - spessore/3);
    rotate (radians (-45));
    strokeWeight (15);
    line(0, 0, textWidth (nome) + 30 + textWidth (anno_fondazione+""), 0); 
    fill (colore_terziario);
    text (nome +", " + anno_fondazione, 10, 5);
    popMatrix();

    // superficie totale
    int distanza = 10;
    int spessore_superficie = spessore - 5;
    noFill ();
    stroke(colore_secondario);
    strokeWeight (spessore_superficie);
    ellipse(pos.x, pos.y, diametro-spessore-distanza, diametro-spessore-distanza);
    pushMatrix();
    stroke(colore_secondario);
    translate(pos.x + cos(radians (40)) * diametro/2, pos.y - sin(radians(40)) * diametro/2 + spessore_superficie*2 - 5);
    rotate (radians (-45));
    strokeWeight(spessore);
    strokeWeight (15);
    line(0, 0, 250, 0); 
    fill (colore_terziario);
    text ("Superficie totale : " + superficie_totale + " sqm", 10, 5);
    popMatrix ();

    // superficie produzione
    strokeWeight (spessore_superficie + 2);
    noFill ();
    stroke(colore_principale, 150);
    arc(pos.x, pos.y, diametro-spessore-distanza, diametro-spessore-distanza, angolo_iniziale, angolo_superficie_produzione);
    pushMatrix();
    translate(pos.x + cos(radians (70)) * diametro/2, pos.y - sin(radians(70)) * diametro/2 + spessore_superficie*2 - 5);
    rotate (radians (-45));
    fill (colore_principale, 150);
    strokeWeight (15);
    line(0, 0, 300, 0); 
    fill (255);
    text ("Superficie di produzione : " + superficie_produzione + " sqm", 10, 5);
    popMatrix ();

    // impiegati
    for (int i = 0; i < n_omini; i++) {
      image (img_employee, pos.x + DIAMETRO/2 + 10 + distanza_tra_imgs * i, pos.y - 20, 25, 25);
    }

    // produzione annuale
    for (int i = 0; i < n_rotelle; i++) {
      image (img_gear, pos.x + DIAMETRO/2 + 10 + distanza_tra_imgs * i, pos.y + 10, 25, 25);
    }

    // vendite annuali
    for (int i = 0; i < n_monete; i++) {
      image (img_euro, pos.x + DIAMETRO/2 + 10 + distanza_tra_imgs * i, pos.y + 40, 25, 25);
    }

    displayInfos ();
  }

  void displayInfos () {
    if (isBetween (mouseX, pos.x + DIAMETRO/2, pos.x + DIAMETRO/2 + n_rotelle * distanza_tra_imgs + 10) 
      && isBetween (mouseY, pos.y - 20, pos.y + 40)) {
      cursor (HAND);
      fill (colore_principale);
      text (n_impiegati + " impiegati", pos.x + DIAMETRO/2 + n_rotelle * distanza_tra_imgs + 30, mouseY);
      text (pezzi_annuali + " mln pezzi per anno", pos.x + DIAMETRO/2 + n_rotelle * distanza_tra_imgs + 30, mouseY +30);
      text (vendite_annuali + "mln € volume di vendita ", pos.x + DIAMETRO/2 + n_rotelle * distanza_tra_imgs + 30, mouseY + 60);
    } else {
      //cursor (ARROW);
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
    angolo_finale = map (anno_fondazione, min (tot_anni_fondazione), max(tot_anni_fondazione), 2*PI, angolo_iniziale/2);

    // curva superficie
    max_diametro = DIAMETRO - 10;
    min_diametro = 130;
    diametro = map (superficie_totale, min (tot_superfici_totali), max (tot_superfici_totali), min_diametro, max_diametro);
    angolo_superficie_produzione = map (superficie_produzione, 0, superficie_totale, 0, 2*PI);

    // omini impiegati
    n_omini = int (map (n_impiegati, min (tot_n_impiegati), max (tot_n_impiegati), 1, max(tot_n_impiegati)/min(tot_n_impiegati)));

    // rotelle generate
    n_rotelle = int (map (pezzi_annuali, min (tot_prezzi_annuali), max (tot_prezzi_annuali), 1, max(tot_prezzi_annuali)/min(tot_prezzi_annuali)));

    // monete guadagnate
    n_monete = int (map (vendite_annuali, min (tot_vendite_annuali), max (tot_vendite_annuali), 1, max(tot_vendite_annuali)/min(tot_vendite_annuali)));
  }
}