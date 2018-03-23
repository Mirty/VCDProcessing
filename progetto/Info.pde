class Info {
  int x;
  int y;
  float altezza;
  float larghezza;
  String descrizione;
  String titolo;
  String scritta;

  Info(int x, int y, String descrizione, String titolo) {
    this.x = x;
    this.y = y;
    this.larghezza = 400;
    this.descrizione = descrizione;
    this.titolo = titolo;
    this.scritta = titolo.toUpperCase()+ "\n" + descrizione;
    this.altezza = 70+ scritta.length()/60*21;
  }   

  void disegnaRect() {
    fill(colore_principale, 200);
    noStroke();
    rect(x, y, larghezza, altezza, 15);
    fill(255);
    textSize(14);
    text(scritta, x+10, y+5, larghezza-18, altezza-5); 
  }
}