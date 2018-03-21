Slider slider;
int INTERVALLI_SLIDER = 11;

void setup () {
  size (1200, 700);
  background (255);

  int margine = 100;
  slider = new Slider (new Punto (margine, height - margine), width - margine*2, INTERVALLI_SLIDER);
}

void draw () {
  background (255);
  slider.draw ();
  slider.detectMouseInteraction ();
}