public class Piece {
  int id;
  int pos[][];
  int x, y;
  boolean placed;
  int len;
  
  public Piece(int id, int pos[][]) {
    this.id = id;
    this.pos = new int[pos.length][2];
    this.len = pos.length;
    for (int i = 0; i < pos.length; i++) {
      this.pos[i][0] = pos[i][0];
      this.pos[i][1] = pos[i][1];
    }
  }
  
  public boolean equals(Piece p) {
    for (int i = 0; i < len; i++) {
      int j = 0;
      for (j = 0; j < p.pos.length; j++)
      if (pos[i][0] == p.pos[j][0] && pos[i][1] == p.pos[j][1])
      break;
      if (j >= p.pos.length)
      return false;
    }
    return true;
  }
  
  /** posの先頭が原点(0, 0)となり、左上に来るように位置をシフトする **/
  public void resetOrigin() {
    int ox = pos[0][0], oy = pos[0][1];
    int mini = 0;
    for (int i = 0; i < pos.length; i++) {
      if (pos[i][0] < ox) {
        ox = pos[i][0];
        oy = pos[i][1];
        mini = i;
      }
      if (pos[i][1] < oy && pos[i][0] <= ox) {
        ox = pos[i][0];
        oy = pos[i][1];
        mini = i;
      }
    }
    for (int i = 0; i < pos.length; i++) {
      pos[i][0] -= ox;
      pos[i][1] -= oy;
    }
    int tx = pos[0][0], ty = pos[0][1];
    pos[0][0] = pos[mini][0];
    pos[0][1] = pos[mini][1];
    pos[mini][0] = tx;  pos[mini][1] = ty;
  }
  
  public boolean place(int board[][], int x, int y) {
    try {
      for (int i = 0; i < len; i++)
      if (board[x+pos[i][0]][y+pos[i][1]] != -1) return false;
      for (int i = 0; i < len; i++)
      board[x+pos[i][0]][y+pos[i][1]] = id;
      } catch (Exception ex) {return false;}
      this.x = x;  this.y = y;
      placed = true;
      return true;
    }

    public void remove(int board[][]) {
      if (!placed) {
      System.out.println("not placed " + id);//
      return;
    }
    for (int i = 0; i < len; i++)
    board[x+pos[i][0]][y+pos[i][1]] = -1;
    placed = false;
    return;
  }
}
