Slider slider;
int [] anni = {1947, 1972, 1978, 1985, 1991, 1995, 1998, 2004, 2009, 2014, 2017};
int INTERVALLI_SLIDER = anni.length;
Location [] locations = {};
Milestone [] milestones = new Milestone [anni.length];
PFont font;
PFont fontBold;

void setup () {
  //size (1200, 700);
  fullScreen ();
  background (255);

  font = createFont ("Arial", 13);
  fontBold = createFont ("Arial Bold", 15);
  int margine = 100;
  slider = new Slider (new Punto (margine, height - margine), width - margine*2, INTERVALLI_SLIDER);
  setMilestones ();
}


void draw () {
  background (255);
  slider.draw ();
  slider.detectMouseInteraction ();
  disegnaGrafici ();
}


void disegnaGrafici () {
  noFill();
  // esterno
  strokeWeight (2);
  arc(100, 155, 100, 100, - radians (90), radians (90));
  // superficie totale
  strokeWeight (2);
  arc(100, 155, 85, 85, - radians (80), radians (70));
  // superficie produttiva
  strokeWeight (2);
  arc(100, 155, 70, 70, - radians (65), radians (40));
  
}


void setMilestones () {
  // int anno, String titolo, String descrizione, Location coordinate, float zoom
  int anno;
  String titolo, descrizione;
  Location coordinate;
  float zoom;

  // 1
  anno = anni [0];
  titolo = "Foundation";
  descrizione = "Opening a small machine shop in the Pordenone area"; 
  coordinate = new Location (1, 1);
  zoom = 1;
  milestones [0] = new Milestone (anno, titolo, descrizione, coordinate, zoom);

  // 2
  anno = anni [1];
  titolo = "Acquired";
  descrizione = "Brovedani is acquired by B. Zollia"; 
  coordinate = new Location (1, 1);
  zoom = 1;
  milestones [1] = new Milestone (anno, titolo, descrizione, coordinate, zoom);

  // 3
  anno = anni [2];
  titolo = "Entry";
  descrizione = "Entry into the Automotive Industry"; 
  coordinate = new Location (1, 1);
  zoom = 1;
  milestones [2] = new Milestone (anno, titolo, descrizione, coordinate, zoom);

  // 4
  anno = anni [3];
  titolo = "Production";
  descrizione = "Production of micro-components for computer hard disk drives"; 
  coordinate = new Location (1, 1);
  zoom = 1;
  milestones [3] = new Milestone (anno, titolo, descrizione, coordinate, zoom);

  // 5
  anno = anni [4];
  titolo = "Entry";
  descrizione = "Entry into the gasoline injection systems market. Brovedani technologies include laser welding, localized hard chrome deposits and high-vacuum annealing"; 
  coordinate = new Location (1, 1);
  zoom = 1;
  milestones [4] = new Milestone (anno, titolo, descrizione, coordinate, zoom);

  // 6
  anno = anni [5];
  titolo = "New Site:";
  descrizione = "Modugno (Bari)"; 
  coordinate = new Location (1, 1);
  zoom = 1;
  milestones [5] = new Milestone (anno, titolo, descrizione, coordinate, zoom);

  // 7
  anno = anni [6];
  titolo = "Innovation:";
  descrizione = "First Common Rail module production for Diesel systems"; 
  coordinate = new Location (1, 1);
  zoom = 1;
  milestones [6] = new Milestone (anno, titolo, descrizione, coordinate, zoom);

  // 8
  anno = anni [7];
  titolo = "Expansion is Slovakia:";
  descrizione = "Brovedani expands its production facilities to Eastern Europe (Slovakia)"; 
  coordinate = new Location (1, 1);
  zoom = 1;
  milestones [7] = new Milestone (anno, titolo, descrizione, coordinate, zoom);

  // 9
  anno = anni [8];
  titolo = "Expansion in Mexico:";
  descrizione = "Inauguration of new plant in Mexico to serve the NAFTA region"; 
  coordinate = new Location (1, 1);
  zoom = 1;
  milestones [8] = new Milestone (anno, titolo, descrizione, coordinate, zoom);

  // 10
  anno = anni [9];
  titolo = "Gasoline:";
  descrizione = "Leader for Gasoline Direct Injection System"; 
  coordinate = new Location (1, 1);
  zoom = 1;
  milestones [9] = new Milestone (anno, titolo, descrizione, coordinate, zoom);

  // 11
  anno = anni [10];
  titolo = "Now:";
  descrizione = "Bo"; 
  coordinate = new Location (1, 1);
  zoom = 1;
  milestones [10] = new Milestone (anno, titolo, descrizione, coordinate, zoom);
}