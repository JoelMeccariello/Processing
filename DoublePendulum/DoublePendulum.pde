float rTop;
float rBot;
float mTop;
float mBot;
float aTop = PI / 2;
float aBot = PI / 2;
float aTopVel = 0;
float aBotVel = 0;
float aTopAcc = 0;
float aBotAcc = 0;
float g = 0.981;

PVector pTop;
PVector pBot;

PGraphics graph;

void setup() {
  frameRate(300);
  fullScreen();
  graph = createGraphics(width, height);
  
  rTop = (width + height) / 8;
  rBot = (width + height) / 8;
  mTop = (width + height) / 40;
  mBot = (width + height) / 40;
  
  graph.beginDraw();
  graph.background(0);
  graph.endDraw();
}

void draw() {
  image(graph, 0, 0);
  stroke(255);
  strokeWeight(2);
  
  translate(width / 2, height / 16);
  
  float xTop = rTop * sin(aTop);
  float yTop = rTop * cos(aTop);
  
  float xBot = xTop + rBot * sin(aBot);
  float yBot = yTop + rBot * cos(aBot);
  
  if (pTop == null) pTop = new PVector(xTop, yTop);
  if (pBot == null) pBot = new PVector(xBot, yBot);
  
  line(0, 0, xTop, yTop);
  ellipse(xTop, yTop, mTop, mTop);
  
  line(xTop, yTop, xBot, yBot);
  ellipse(xBot, yBot, mBot, mBot);
  
  aTopAcc = (-g * (2 * mTop + mBot) * sin(aTop) - mBot * g * sin(aTop - 2 * aBot) - 2 * sin(aTop - aBot) * mBot * (aBotVel * aBotVel * rBot + aTopVel * aTopVel * rTop * cos(aTop - aBot))) / (rTop * (2 * mTop + mBot - mBot * cos(2 * aTop - 2 * aBot)));
  aBotAcc = (2 * sin(aTop - aBot) * (aTopVel * aTopVel * rTop * (mTop + mBot) + g * (mTop + mBot) * cos(aTop) + aBotVel * aBotVel * rBot * mBot * cos(aTop - aBot))) / (rBot * (2 * mTop + mBot - mBot * cos(2 * aTop - 2 * aBot))); 
  
  aTopVel += aTopAcc;
  aBotVel += aBotAcc;
  aTop += aTopVel;
  aBot += aBotVel;
  
  graph.beginDraw();
  graph.translate(width / 2, height / 16);
  graph.strokeWeight((width + height) / 400);
  graph.stroke(0, 0, 100);
  graph.line(pTop.x, pTop.y, xTop, yTop);
  graph.stroke(100, 0, 0);
  graph.line(pBot.x, pBot.y, xBot, yBot);
  graph.endDraw();
  
  pTop = new PVector(xTop, yTop);
  pBot = new PVector(xBot, yBot);
}
