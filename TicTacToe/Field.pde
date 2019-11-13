class Field {
  String val = "";
  boolean clickable = false;
  color colour = color(51);
  PVector pos;
  PVector size = new PVector(50, 50);
  
  Field(float x, float y) {
    this.pos = new PVector(x * 54, y * 54);
  }
  
  void show() {
    fill(this.colour);
    rect(this.pos.x, this.pos.y, this.size.x, this.size.y);
    fill(0);
    textAlign(LEFT, TOP);
    text(this.val, this.pos.x + 4, this.pos.y);
  }
}
