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
    triangle(inizio_barra.x + lunghezza - 10, inizio_barra.y - 5, inizio_barra.x + lunghezza + 2, inizio_barra.y, inizio_barra.x + lunghezza - 10, inizio_barra.y + 5);
    textSize (14);
    for (int i = 0; i < intervalli; i++) {
      if (pallino.x == punti[i].x) textFont (fontBold);
      else textFont (font);
      ellipse (punti [i].x, punti[i].y, 5, 5);
      pushMatrix ();
      translate (punti [i].x, inizio_barra.y + 20); 
      rotate (radians(40));
      text (anni[i], 0, 0);
      popMatrix ();
    }
    ellipse (pallino.x, pallino.y, diametro, diametro);
  }

  void detectMouseInteraction () {
    if (isBetween (tracker.getPos().y, inizio_barra.y - errore, inizio_barra.y + errore) 
        && isBetween (tracker.getPos().x, inizio_barra.x - errore, inizio_barra.x + lunghezza + errore)) {
        Punto new_point = new Punto (int(tracker.getPos().x), pallino.y);
        pallino.x = getClosestPoint(new_point).x;
        //tracker.init_time++;
        
      }
  }

  boolean isMouseOver () {
    return isBetween (mouseY, inizio_barra.y - errore, inizio_barra.y + errore*2) 
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