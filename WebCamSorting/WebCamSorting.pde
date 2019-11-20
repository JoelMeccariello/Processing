import processing.video.*;

PImage img;
PImage sorted;

Capture cam;

void setup() {
  size(640, 240);
  cam = new Capture(this, 320, 240, 30);
  cam.start();
}

void draw() {
  if (cam.available() == true) cam.read();
  image(cam, 0, 0);
  sorted = cam.copy();
  sorted.loadPixels();
  sorted.pixels = sort(sorted.pixels);
  sorted.updatePixels();
  image(sorted, width / 2, 0);
}
