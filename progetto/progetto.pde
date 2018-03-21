import org.openkinect.freenect.*;
import org.openkinect.processing.*;

Slider slider;
String [] anni = new String [0];
int INTERVALLI_SLIDER = 18;
Location [] locations = {};
Milestone [] milestones;
Sede [] sedi = new Sede [5];
PFont font;
PFont fontBold;
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
  int margine = 100;
  slider = new Slider (new Punto (margine, height - margine), width - margine*2, INTERVALLI_SLIDER);
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