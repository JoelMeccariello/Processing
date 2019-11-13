import java.util.List;

Field[] fields = new Field[9];
boolean playersTurn;
int[][] wins;
int count;
boolean gameEnd;

void setup() {
  size(154, 154);
  for (int i = 0; i < 3; i++) for (int j = 0; j < 3; j++) fields[j + i * 3] = new Field(j, i);
  noStroke();
  background(51);
  textSize(60);
  playersTurn = true;
  wins = new int[][]{
    new int[] {0, 1, 2}, 
    new int[] {3, 4, 5}, 
    new int[] {6, 7, 8}, 
    new int[] {0, 3, 6}, 
    new int[] {1, 4, 7}, 
    new int[] {2, 5, 8}, 
    new int[] {0, 4, 8}, 
    new int[] {2, 4, 6}
  };
  count = 4;
  gameEnd = false;
}

void draw() {
  drawBoard();
  for (int i = 0; i < fields.length; i++) fields[i].show();
}

void drawBoard() {
  fill(0);
  for (int i = 0; i < 4; i++) rect(i < 2 ? 50 + 54 * i : 0, i > 1 ? 50 + 54 * (i - 2) : 0, i < 2 ? 4 : 154, i > 1 ? 4 : 154);
}

void mouseClicked() {
  if (mouseX <= 154 && mouseX >= 0 && mouseY <= 154 && mouseY >= 0) for (int i = 0; i < fields.length; i++) if (mouseX >= fields[i].pos.x && mouseX <= fields[i].pos.x + fields[i].size.x && mouseY >= fields[i].pos.y && mouseY <= fields[i].pos.y + fields[i].size.y) if (fields[i].val == "") if (playersTurn) {
    fields[i].val = "X";
    println("field " + i + " clicked");
    playersTurn = false;
    minimaxAI();
    if (!gameEnd) retardedAI();
  }
}

void minimaxAI() {
  fields[minimax(fields, "O").index].val = "O";
}

void retardedAI() {
  if (count >= 1) {
    boolean done = false;
    do {
      int n = (int) (Math.random() * 9);
      if (fields[n].val == "") {
        fields[n].val = "O";
        count--;
        done = true;
      }
    } while (!done);
  }
  checkIfWin("O");

  if (!gameEnd) playersTurn = true;
}

Move minimax(Field[] board, String player) {
  List<Integer> availableSquares = new ArrayList<Integer>();
  for (int i = 0; i < board.length; i++) {
    if (board[i].val == "") {
      availableSquares.add(i);
    }
  }
  
  Move res = new Move();
  if (availableSquares.size() == 0) {
    res.score = 0;
    res.index = -1;
    return res;
  } else if (onCheckWin(board, "O")) {
    res.score = 1;
    res.index = -1;
    return res;
  } else if (onCheckWin(board, "X")) {
    res.score = -1;
    res.index = -1;
    return res;
  }

  List<Move> moves = new ArrayList<Move>();

  for (int i = 0; i < availableSquares.size(); i++) {
    Move move = new Move();
    move.index = availableSquares.get(i);
    board[availableSquares.get(i)].val = player;
    if (player == "O") {
      move.score = minimax(board, "X").score;
    } else {
      move.score = minimax(board, "O").score;
    }
    moves.add(move);
  }

  int bestMove = (int) (Math.random() * 9);
  if (player == "O") {
    int bestScore = -8;
    for (int i = 0; i < moves.size(); i++) {
      if (moves.get(i).score > bestScore) {
        bestScore = moves.get(i).score;
        bestMove = i;
      }
    }
  } else if (player == "X") {
    int bestScore = 8;
    for (int i = 0; i < moves.size(); i++) {
      if (moves.get(i).score < bestScore) {
        bestScore = moves.get(i).score;
        bestMove = i;
      }
    }
  }

  return moves.get(bestMove);
}

boolean onCheckWin(Field[] board, String player) {
  for (int i = 0; i < wins.length; i++) {
    if (player == board[wins[i][0]].val && player == board[wins[i][1]].val && player == board[wins[i][2]].val) {
      return true;
    }
  }
  return false;
}

void checkIfWin(String player) {
  for (int i = 0; i < wins.length; i++) {
    if (player == fields[wins[i][0]].val && player == fields[wins[i][1]].val && player == fields[wins[i][2]].val) {
      for (int j = 0; j < wins[i].length; j++) {
        fields[wins[i][j]].colour = color(0, 255, 0);
      }
      gameEnd = true;
    }
  }
}
