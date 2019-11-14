PImage img;
PImage sorted;

void settings() {
  img = loadImage("data/fermat.png");
  size(img.width * 2, img.height);
  
  sorted = img.copy();
  sorted.loadPixels();
  sorted.pixels = sort(sorted.pixels);
  sorted.updatePixels();
}

void draw() {
  background(51);
  image(img, 0, 0);
  image(sorted, width / 2, 0);
  
  noLoop();
}
