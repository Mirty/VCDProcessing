import processing.core.*;
import de.fhpotsdam.unfolding.geo.Location;
import de.fhpotsdam.unfolding.marker.SimplePointMarker;

public class BMarker extends SimplePointMarker {
  //PGraphics pg;
  public BMarker(Location location) {
    super(location);
  }

  public void draw(PGraphics pg, float x, float y) {
    if (isHidden())
      return;
    pg.pushStyle();
    pg.fill(20, 151, 24);
    pg.stroke(20, 151, 24);
    pg.triangle(x, y, x - 15, y-30, x+15, y-30);
    pg.ellipse(x, y-30, 30, 30);
    pg.fill(255);
    pg.textAlign(CENTER);
    pg.textFont(fontBold);
    pg.textSize(22);
    pg.text("B", x, y - 23);
    pg.popStyle();
  }
}