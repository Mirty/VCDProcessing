import org.openkinect.freenect.*;
import org.openkinect.processing.*;

Slider slider;
String [] anni = new String [0];
int INTERVALLI_SLIDER = 18;
Location [] locations = {};
Milestone [] milestones;
Sede [] sedi = new Sede [5];
int MARGINE = 100;
PFont font;
PFont fontBold;
PImage img_gear;
PImage img_employee;
PImage img_euro;
KinectTracker tracker;
Kinect kinect;

void setup () {
  //size (1200, 700);
  fullScreen ();
  background (255);

  font = createFont ("Arial", 13);
  fontBold = createFont ("Arial Bold", 15);
  kinect = new Kinect(this);
  tracker = new KinectTracker();
  //parametri - custom parameters
  tracker.threshold = 650;
  tracker.kinect_limits = 100;      //machine dependent
  tracker.click_time = 80;
  slider = new Slider (new Punto (MARGINE, height - MARGINE), width - MARGINE*2, INTERVALLI_SLIDER);
  img_gear = loadImage("gear.png");
  img_employee = loadImage("employee.png");
  img_euro = loadImage("euro.png");
  loadMilestones ();
  setSedi ();
}


void draw () {
  background (255);

  tracker.track();
  PVector v1 = tracker.getPos();
  fill(100, 100, 250, 70);
  noStroke();
  ellipse(v1.x, v1.y, 50, 50);

  slider.draw ();
  slider.detectMouseInteraction ();

  for (int i = 0; i < sedi.length; i++) {
    sedi[i].draw ();
  }
}

//test (da eliminare)
void bottone() {

  if (tracker.getPos().x<400&&tracker.getPos().x>200&&tracker.getPos().y<400&&tracker.getPos().y>200) {
    tracker.init_time++;
  } else {
    tracker.init_time=0;
  }
  if (tracker.init_time>=tracker.click_time) {
    ellipse(300, 300, 70, 70);
  } else {
    ellipse(300, 300, 100, 100);
  }
}


void setSedi () {
  // prova con dati random
  for (int i=0; i<sedi.length; i++) {
    // nome, anno_fondazione, superficie_totale, superficie_produzione, 
    // n_impiegati, pezzi_annuali, vendite_annuali, coordinate
    String nome = "Sede "+ (i+1);
    int fondazione = int(random (1947, 2017));
    float sup_tot = random (100, 200);
    float sup_prod = random (30, 80);
    int impiegati = int(random (30, 300));
    int pezzi_annuali = int (random (6, 76));
    float vendite_annuali = random (7.54, 36.7);
    Location coordinate = new Location (random (MARGINE*2, width - MARGINE*2), random (MARGINE*2, height - MARGINE*2));
    sedi [i] = new Sede (nome, fondazione, sup_tot, sup_prod, impiegati, pezzi_annuali, vendite_annuali, coordinate);
  }
  
  for (int i=0; i<sedi.length; i++) sedi[i].setVariables();
}


void loadMilestones() {
  // Load the JSON file and grab the array.
  JSONObject json = loadJSONObject("Milestones.json");
  JSONArray milestoneData = json.getJSONArray("milestones");

  // The size of the array of Bubble objects is determined by the length of the JSON array.
  milestones = new Milestone[milestoneData.size()]; 

  for (int i = 0; i<milestoneData.size(); i++) {

    // Iterate through the array, grabbing each JSON object one at a time.
    JSONObject milestone = milestoneData.getJSONObject(i);

    // Get informations
    String year = milestone.getString("year");
    anni = append(anni, year);
    String title = milestone.getString("title");
    String description = milestone.getString("description");
    String nation = milestone.getString("nation");

    // Put the Bubble objects into an array.
    milestones[i] = new Milestone(year, title, description, nation);
  }
}