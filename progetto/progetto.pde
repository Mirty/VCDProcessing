Slider slider;
String [] anni = new String [0];
int INTERVALLI_SLIDER = 18;
Location [] locations = {};
Milestone [] milestones;
Sede [] sedi = new Sede [5];
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
  loadMilestones ();
  setSedi ();
}


void draw () {
  background (255);
  
  slider.draw ();
  slider.detectMouseInteraction ();
}

/*
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
  
}*/


void setSedi () {
  
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
    printArray(anni);
    String title = milestone.getString("title");
    String description = milestone.getString("description");
    String nation = milestone.getString("nation");

    // Put the Bubble objects into an array.
    milestones[i] = new Milestone(year, title, description, nation);
  }
}