/* Settings */
PVector gridSize = new PVector(50, 50);
int mines = 10;  // In percentage (can vary)
/* -------- */

PVector cellSize;

Cell[][] cells;

int mineCount;
int flagCount;

void setup() {
  size(800, 800);
  
  mineCount = 0;
  flagCount = 0;
  
  cellSize = new PVector(width / gridSize.x, height / gridSize.y);
  
  textAlign(CENTER, CENTER);
  textSize(cellSize.y / 8 + cellSize.y / 8 * 6);
  
  cells = new Cell[Double.valueOf(this.gridSize.x).intValue()][Double.valueOf(this.gridSize.y).intValue()];
  for (int i = 0; i < cells.length; i++) for (int j = 0; j < cells[i].length; j++) cells[i][j] = new Cell(i, j);
  for (int i = 0; i < cells.length; i++) for (int j = 0; j < cells[i].length; j++) cells[i][j].setNumber();
  
  println(mineCount);
}

void draw() {
  for (Cell[] cellLine : cells) for (Cell cell : cellLine) cell.show();
}

void mousePressed() {
  if (mouseButton == LEFT) for (Cell[] cellLine : cells) for (Cell cell : cellLine) if (mouseX >= cell.pos.x && mouseX <= cell.pos.x + cellSize.x && mouseY >= cell.pos.y && mouseY <= cell.pos.y + cellSize.y) if (cell.state == State.COVERED) cell.pressed();
  if (mouseButton == RIGHT) for (Cell[] cellLine : cells) for (Cell cell : cellLine) if (mouseX >= cell.pos.x && mouseX <= cell.pos.x + cellSize.x && mouseY >= cell.pos.y && mouseY <= cell.pos.y + cellSize.y) if (cell.state == State.COVERED) {
    if (flagCount < mineCount) {
      cell.state = State.FLAG;
      flagCount++;
      checkIfWin();
    }
  }
  else if (cell.state == State.FLAG) cell.state = State.COVERED;
}

void showMines() {
  for (Cell[] cellLine : cells) for (Cell cell : cellLine) cell.uncover();
}

void checkIfWin() {
  int n = mineCount;
  for (Cell[] cellLine : cells) for (Cell cell : cellLine) if (cell.mine && cell.state == State.FLAG) n--;
  if (n == 0) showMines();
}

class Cell {
  PVector pos;
  PVector gridPos;
  State state;
  int number;
  boolean mine;
  
  Cell(float x, float y) {
    pos = new PVector(x * cellSize.x, y * cellSize.y);
    gridPos = new PVector(x, y);
    state = State.COVERED;
    mine = (Math.random() * 100) / mines < 1;
    if (mine) mineCount++;
  }
  
  void setNumber() {
    number = 0;
    if (gridPos.x > 0) {
      if (gridPos.y > 0) if (cells[Double.valueOf(gridPos.x - 1).intValue()][Double.valueOf(gridPos.y - 1).intValue()].mine) number++;
      if (cells[Double.valueOf(gridPos.x - 1).intValue()][Double.valueOf(gridPos.y).intValue()].mine) number++;
      if (gridPos.y < gridSize.y - 1)  if (cells[Double.valueOf(gridPos.x - 1).intValue()][Double.valueOf(gridPos.y + 1).intValue()].mine) number++;
    }
    if (gridPos.y > 0) if (cells[Double.valueOf(gridPos.x).intValue()][Double.valueOf(gridPos.y - 1).intValue()].mine) number++;
    if (gridPos.x < gridSize.x - 1) {
      if (gridPos.y > 0) if (cells[Double.valueOf(gridPos.x + 1).intValue()][Double.valueOf(gridPos.y - 1).intValue()].mine) number++;
      if (cells[Double.valueOf(gridPos.x + 1).intValue()][Double.valueOf(gridPos.y).intValue()].mine) number++;
      if (gridPos.y < gridSize.y - 1)  if (cells[Double.valueOf(gridPos.x + 1).intValue()][Double.valueOf(gridPos.y + 1).intValue()].mine) number++;
    }
    if (gridPos.y < gridSize.y - 1) if (cells[Double.valueOf(gridPos.x).intValue()][Double.valueOf(gridPos.y + 1).intValue()].mine) number++;
  }
  
  void pressed() {
    if (mine) showMines();
    uncover();
    
    if (number == 0) {
      if (gridPos.x > 0) {
        
        // Top left
        if (gridPos.y > 0) if (cells[Double.valueOf(gridPos.x - 1).intValue()][Double.valueOf(gridPos.y - 1).intValue()].state == State.COVERED) if (cells[Double.valueOf(gridPos.x - 1).intValue()][Double.valueOf(gridPos.y - 1).intValue()].number == 0) cells[Double.valueOf(gridPos.x - 1).intValue()][Double.valueOf(gridPos.y - 1).intValue()].pressed();
        else cells[Double.valueOf(gridPos.x - 1).intValue()][Double.valueOf(gridPos.y - 1).intValue()].uncover();
        
        // Left
        if (cells[Double.valueOf(gridPos.x - 1).intValue()][Double.valueOf(gridPos.y).intValue()].state == State.COVERED) if (cells[Double.valueOf(gridPos.x - 1).intValue()][Double.valueOf(gridPos.y).intValue()].number == 0) cells[Double.valueOf(gridPos.x - 1).intValue()][Double.valueOf(gridPos.y).intValue()].pressed();
        else cells[Double.valueOf(gridPos.x - 1).intValue()][Double.valueOf(gridPos.y).intValue()].uncover();
        
        // Top right
        if (gridPos.y < gridSize.y - 1) if (cells[Double.valueOf(gridPos.x - 1).intValue()][Double.valueOf(gridPos.y + 1).intValue()].state == State.COVERED) if (cells[Double.valueOf(gridPos.x - 1).intValue()][Double.valueOf(gridPos.y + 1).intValue()].number == 0) cells[Double.valueOf(gridPos.x - 1).intValue()][Double.valueOf(gridPos.y + 1).intValue()].pressed();
        else cells[Double.valueOf(gridPos.x - 1).intValue()][Double.valueOf(gridPos.y + 1).intValue()].uncover();
        
      }
      
      // Top
      if (gridPos.y > 0) if (cells[Double.valueOf(gridPos.x).intValue()][Double.valueOf(gridPos.y - 1).intValue()].state == State.COVERED) if (cells[Double.valueOf(gridPos.x).intValue()][Double.valueOf(gridPos.y - 1).intValue()].number == 0) cells[Double.valueOf(gridPos.x).intValue()][Double.valueOf(gridPos.y - 1).intValue()].pressed();
      else cells[Double.valueOf(gridPos.x).intValue()][Double.valueOf(gridPos.y - 1).intValue()].uncover();
      
      if (gridPos.x < gridSize.x - 1) {
        
        // Bottom left
        if (gridPos.y < gridSize.y - 1)  if (cells[Double.valueOf(gridPos.x + 1).intValue()][Double.valueOf(gridPos.y + 1).intValue()].state == State.COVERED) if (cells[Double.valueOf(gridPos.x + 1).intValue()][Double.valueOf(gridPos.y + 1).intValue()].number == 0) cells[Double.valueOf(gridPos.x + 1).intValue()][Double.valueOf(gridPos.y + 1).intValue()].pressed();
        else cells[Double.valueOf(gridPos.x + 1).intValue()][Double.valueOf(gridPos.y + 1).intValue()].uncover();
        
        // Right
        if (cells[Double.valueOf(gridPos.x + 1).intValue()][Double.valueOf(gridPos.y).intValue()].state == State.COVERED) if (cells[Double.valueOf(gridPos.x + 1).intValue()][Double.valueOf(gridPos.y).intValue()].number == 0) cells[Double.valueOf(gridPos.x + 1).intValue()][Double.valueOf(gridPos.y).intValue()].pressed();
        else cells[Double.valueOf(gridPos.x + 1).intValue()][Double.valueOf(gridPos.y).intValue()].uncover();
        
        // Bottom right
        if (gridPos.y > 0) if (cells[Double.valueOf(gridPos.x + 1).intValue()][Double.valueOf(gridPos.y - 1).intValue()].state == State.COVERED) if (cells[Double.valueOf(gridPos.x + 1).intValue()][Double.valueOf(gridPos.y - 1).intValue()].number == 0) cells[Double.valueOf(gridPos.x + 1).intValue()][Double.valueOf(gridPos.y - 1).intValue()].pressed();
        else cells[Double.valueOf(gridPos.x + 1).intValue()][Double.valueOf(gridPos.y - 1).intValue()].uncover();
        
      }
      
      // Bottom
      if (gridPos.y < gridSize.y - 1) if (cells[Double.valueOf(gridPos.x).intValue()][Double.valueOf(gridPos.y + 1).intValue()].state == State.COVERED) if (cells[Double.valueOf(gridPos.x).intValue()][Double.valueOf(gridPos.y + 1).intValue()].number == 0) cells[Double.valueOf(gridPos.x).intValue()][Double.valueOf(gridPos.y + 1).intValue()].pressed();
      else cells[Double.valueOf(gridPos.x).intValue()][Double.valueOf(gridPos.y + 1).intValue()].uncover();
      
    }
  }
  
  void uncover() {
    if (mine) {
      if (state == State.FLAG) state = State.FLAGGEDMINE;
      else state = State.MINE;
    }
    else if (number == 0) state = State.UNCOVERED;
    else if (number > 0) state = State.NUMBER;
  }
  
  void show() {
    if (state == State.COVERED) {
      fill(200);
      rect(pos.x, pos.y, cellSize.x, cellSize.y);
    } else if (state == State.UNCOVERED) {
      fill(255);
      rect(pos.x, pos.y, cellSize.x, cellSize.y);
    } else if (state == State.NUMBER) {
      fill(255);
      rect(pos.x, pos.y, cellSize.x, cellSize.y);
      fill(0);
      text(number, pos.x + cellSize.x / 2, pos.y + cellSize.y / 2);
    } else if (state == State.FLAG) {
      fill(200);
      rect(pos.x, pos.y, cellSize.x, cellSize.y);
      fill(255, 0, 0);
      rect(pos.x + cellSize.x / 4, pos.y + cellSize.y / 4, cellSize.x / 2, cellSize.y / 2);
    } else if (state == State.MINE) {
      fill(51);
      rect(pos.x, pos.y, cellSize.x, cellSize.y);
    } else if (state == State.FLAGGEDMINE) {
      fill(51);
      rect(pos.x, pos.y, cellSize.x, cellSize.y);
      fill(255, 0, 0);
      rect(pos.x + cellSize.x / 4, pos.y + cellSize.y / 4, cellSize.x / 2, cellSize.y / 2);
    }
  }
}

enum State {
  COVERED,
  UNCOVERED,
  NUMBER,
  FLAG,
  MINE,
  FLAGGEDMINE
}
