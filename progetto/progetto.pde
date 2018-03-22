import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;

import org.openkinect.freenect.*;
import org.openkinect.processing.*;

Slider slider;
String [] anni = new String [0];
int INTERVALLI_SLIDER = 19;
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

UnfoldingMap map;
ArrayList<Location> Italia = new ArrayList<Location>();
ArrayList<Location> Slovakia = new ArrayList<Location>();
ArrayList<Location> Messico = new ArrayList<Location>();
ArrayList<Location> ItaliaSlovakia = new ArrayList<Location>();
ArrayList<Location> Mondo = new ArrayList<Location>();

Location SanVito = new Location(45.94, 12.87);
Location Bari = new Location(41.11, 16.77);
Location Galanta = new Location(48.18, 17.73);
Location Queretaro = new Location(20.82, -100.42);

SimplePointMarker sanVitoMarker;
SimplePointMarker galantaMarker;
SimplePointMarker queretaroMarker;
SimplePointMarker bariMarker;

void setup () {
  //size (1200, 700);
  fullScreen (P2D);
  //background (255);

  map = new UnfoldingMap(this);
  map.setTweening(true);

  Italia.add(new Location(47.51, 12.50));
  Italia.add(new Location(36.92, 12.50));
  Slovakia.add(new Location(50.18, 17.73));
  Slovakia.add(new Location(46.18, 17.73));
  Messico.add(new Location(33.82, -100.42));
  Messico.add(new Location(7.82, -100.42));
  ItaliaSlovakia.add(new Location(52.43, 12.86));
  ItaliaSlovakia.add(new Location(36.0, 12.86));
  Mondo.add(new Location(62.92, -120.83));
  Mondo.add(new Location(-8.27, 38.74));

  map.zoomAndPanToFit(Italia);

  sanVitoMarker = new SimplePointMarker(SanVito);
  galantaMarker = new SimplePointMarker(Galanta);
  queretaroMarker = new SimplePointMarker(Queretaro);
  bariMarker = new SimplePointMarker(Bari);
  map.addMarkers(sanVitoMarker, bariMarker, galantaMarker, queretaroMarker);
  bariMarker.setHidden(true);
  galantaMarker.setHidden(true);
  queretaroMarker.setHidden(true);
  sanVitoMarker.setColor(color(0, 153, 0));
  sanVitoMarker.setStrokeColor(color(0, 153, 0));
  sanVitoMarker.setStrokeWeight(5);
  galantaMarker.setColor(color(0, 153, 0));
  queretaroMarker.setColor(color(0, 153, 0));
  bariMarker.setColor(color(0, 153, 0));

  MapUtils.createDefaultEventDispatcher(this, map);

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
  loadSedi ();
}

int indicePunto;

void draw () {
  background (255);

  map.draw();

  tracker.track();
  PVector v1 = tracker.getPos();
  fill(100, 100, 250, 70);
  noStroke();
  ellipse(v1.x, v1.y, 50, 50);

  slider.draw ();
  indicePunto = slider.detectMouseInteraction ();
 
  for (int i = 0; i < sedi.length; i++) {
    sedi[i].draw ();
  }
}

void mouseClicked() {
  Milestone current = milestones[indicePunto];

    switch(current.nation) {
    case "Queretaro":
      map.zoomAndPanToFit(Messico);
      println(Messico.toString());
      break;
    case "Galanta":
      map.zoomAndPanToFit(Slovakia);
      break;
    case "Bari":
      map.zoomAndPanToFit(Italia);
      break;
    case "San Vito":
      map.zoomAndPanToFit(Italia);
      break;
    case "San Vito - Galanta":
      map.zoomAndPanToFit(ItaliaSlovakia);
      break;
    default:
      map.zoomAndPanToFit(Mondo);
      break;
    }

    if (indicePunto < 7) {
      bariMarker.setHidden(true);
      galantaMarker.setHidden(true);
      queretaroMarker.setHidden(true);
    } else if (indicePunto >=7 && indicePunto < 12) {
      bariMarker.setHidden(false);
      galantaMarker.setHidden(true);
      queretaroMarker.setHidden(true);
    } else if (indicePunto >= 12 && indicePunto < 14) {
      bariMarker.setHidden(false);
      galantaMarker.setHidden(false);
      queretaroMarker.setHidden(true);
    } else {
      bariMarker.setHidden(false);
      galantaMarker.setHidden(false);
      queretaroMarker.setHidden(false);
    }
  

  
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
    //println (milestones[i].year);
  }
}

void loadSedi() {
  // Load the JSON file and grab the array.
  JSONObject json = loadJSONObject("Sedi.json");
  JSONArray sediData = json.getJSONArray("sedi");

  // The size of the array of Bubble objects is determined by the length of the JSON array.
  sedi = new Sede[sediData.size()]; 

  for (int i = 0; i<sediData.size(); i++) {

    // Iterate through the array, grabbing each JSON object one at a time.
    JSONObject sede = sediData.getJSONObject(i);

    String nome = sede.getString("nome");
    int fondazione = sede.getInt("anno_fondazione");
    float sup_tot = sede.getFloat("superficie_totale");
    float sup_prod = sede.getFloat("superficie_produzione");
    int impiegati = sede.getInt("n_impiegati");
    float pezzi_annuali = sede.getFloat("pezzi_annuali");
    float vendite_annuali = sede.getFloat("vendite_annuali");
    float coordinatax = sede.getFloat("coordinatex");
    float coordinatay = sede.getFloat("coordinatey");
    Location coordinate = new Location (coordinatax, coordinatay);
    sedi [i] = new Sede (nome, fondazione, sup_tot, sup_prod, impiegati, pezzi_annuali, vendite_annuali, coordinate);
  }
}
