class Slider {
  // proprietà
  Punto inizio_barra;
  int lunghezza;
  int intervalli;
  color colore;
  int diametro;
  Punto pallino;
  Punto [] punti;
  int errore;

  // costruttori 
  Slider (Punto inizio, int lunghezza, int divisioni) {
    inizio_barra = new Punto (inizio);
    pallino = new Punto (inizio.x + lunghezza/(divisioni+1), inizio.y);
    this.lunghezza = lunghezza;
    this.intervalli = divisioni;
    colore = color (20, 151, 24);
    diametro = 10;
    errore = 20;
    punti = new Punto [intervalli];
    for (int i = 0; i < intervalli; i++) {
      punti [i] = new Punto (inizio_barra.x + lunghezza/(intervalli+1) + lunghezza/(intervalli+1) * i, inizio_barra.y);
    }
  }

  // metodi e funzioni
  void draw () {
    fill (colore);
    stroke (colore);
    rect (inizio_barra.x, inizio_barra.y- 1.4/2, lunghezza, 1.4, 5);
    for (int i = 0; i < intervalli; i++) {
      ellipse (punti [i].x, punti[i].y, 5, 5);
    }
    ellipse (pallino.x, pallino.y, diametro, diametro);
  }

  void detectMouseInteraction () {
    if (mousePressed) { 
      // determino la nuova posizione della barra tenendo conto dei divisori
      if (isBetween (mouseY, inizio_barra.y - errore, inizio_barra.y + errore) 
        && isBetween (mouseX, inizio_barra.x - errore, inizio_barra.x + lunghezza + errore)) {
        Punto new_point = new Punto (mouseX, pallino.y);
        pallino.x = getClosestPoint(new_point).x;
      }
    }

    if (isMouseOver()) cursor (HAND);
    else cursor (ARROW);
  }

  boolean isMouseOver () {
    return isBetween (mouseY, inizio_barra.y - errore, inizio_barra.y + errore) 
      && isBetween (mouseX, inizio_barra.x - errore, inizio_barra.x + lunghezza + errore);
  }

  Punto getClosestPoint (Punto point) {
    float min_dist = MAX_FLOAT;
    Punto closestPoint = new Punto (0, 0);

    for (int i = 0; i < punti.length; i ++) {
      float dist = dist (punti[i].x, punti[i].y, point.x, point.y);
      if (dist  < min_dist) {
        min_dist = dist; 
        closestPoint = punti[i];
      }
    }
    return closestPoint;
  }
}