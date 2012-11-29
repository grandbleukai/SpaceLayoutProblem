Thread thread;
Color color[];
int npiece = 12;
int offx = 30, offy = 30;
int ps = 30, po = 1;    
int board_x = 10, board_y = 6;
int board[][];
Piece piece[][];
int bcopy[][];
boolean show_progress = false;
static int shape[][][] = {
	{{0, 0}, {-1, 1}, {0, 1}, {1, 1}, {0, 2}}, // +
	{{0, 0}, {1, 0}, {1, 1}, {2, 1}, {1, 2}}, // F
	{{0, 0}, {1, 0}, {1, 1}, {2, 0}, {2, 1}}, // P
	{{0, 0}, {0, 1}, {1, 1}, {0, 2}, {0, 3}}, // ト
	{{0, 0}, {1, 0}, {0, 1}, {0, 2}, {0, 3}}, // L
	{{0, 0}, {1, 0}, {2, 0}, {0, 1}, {2, 1}}, // U
	{{0, 0}, {1, 0}, {1, 1}, {2, 1}, {3, 1}}, // kagi
	{{0, 0}, {0, 1}, {1, 1}, {1, 2}, {2, 2}}, // w
	{{0, 0}, {1, 0}, {2, 0}, {1, 1}, {1, 2}}, // T
	{{0, 0}, {1, 0}, {2, 0}, {0, 1}, {0, 2}}, // V
	{{0, 0}, {1, 0}, {1, 1}, {1, 2}, {2, 2}}, // s
	{{0, 0}, {0, 1}, {0, 2}, {0, 3}, {0, 4}}, // I
};

public Pentomino() {
	this(10, 6);
}

public Pentomino(int col, int row) {
	background(black);
	color = new float[npiece];
	for (int i = 0; i < color.length; i++)
	color[i] = ((float)i)/((float)npiece);
	board_x = col;
	board_y = row;
	npiece = shape.length;
	initBoard();
	initPiece();
}

public void init() {
	try {		
		String row = getParameter("row");
		String col = getParameter("col");
		String progress = getParameter("progress");
		if (row != null) board_x = Integer.parseInt(col);
		if (col != null) board_y = Integer.parseInt(row);
		if (progress != null && progress.equals("true"))show_progress = true;
		} catch (Exception e) {}
		initBoard();
		initPiece();
		start();
	}
}

public Dimension getMinimumSize() {
	return new Dimension(
		offx * 2 + po * (board_x - 1) + ps * board_x,
		offy * 2 + po * (board_y - 1) + ps * board_y);
}

public Dimension getPreferredSize() {
	return getMinimumSize();
}

public void start() {
	if (thread == null) {
		thread = new Thread(this);
		thread.start();
	}
}

public void run() {
	solve();
	repaint();
	dbg("finish:" + total);
}

public void initBoard() {
	board = new int[board_x][board_y];
	bcopy = new int[board_x][board_y];
	for (int i = 0; i < board_x; i++)
	for (int j = 0; j < board_y; j++)
	bcopy[i][j] = board[i][j] = -1;
}

/** piece を左上角に寄せる **/
protected void leftupper(int p[][]) {
	int minx = 100, miny = 100;
	for (int i = 0; i < p.length; i++) {
		if (p[i][0] < minx) minx = p[i][0];
		if (p[i][1] < miny) miny = p[i][1];
	}
	for (int i = 0; i < p.length; i++) {
		p[i][0] -= minx;
		p[i][1] -= miny;
	}
}

/** piece形状を左右反転 **/
protected int[][] flip(int p[][]) {
	int np[][] = new int[p.length][2];
	for (int i = 0; i < p.length; i++) {
		np[i][0] = -p[i][0];
		np[i][1] = p[i][1];
	}
	leftupper(np);
	return np;
}

/** pieceを90度回転 */
protected int[][] rotate(int p[][]) {
	int np[][] = new int[p.length][2];
	for (int i = 0; i < p.length; i++) {
		np[i][0] = -p[i][1];  np[i][1] = p[i][0];
	}
	leftupper(np);
	return np;
}

/** pieceの可能な置き方をリストアップする **/
public void initPiece() {
	piece = new Piece[shape.length][];
	for (int i = 0; i < shape.length; i++) {
		piece[i] = initPieceOne(i, shape[i]);
	}
}

public Piece[] initPieceOne(int id, int shape[][]) {
	int n = 0;
	Piece[] piece = new Piece[4 * 2];
	boolean duplicate = false;

	int tshape[][] = shape;

	// 回転させながら重複しない置き方をリストアップする
	for (int j = 0; j < 4; j++) {
		tshape = rotate(tshape);
		Piece npiece = new Piece(id, tshape);
		duplicate = false;
		for (int k = 0; k < n; k++) {
			if (npiece.equals(piece[k])) {
				duplicate = true;
				break;
			}
		}
		if (!duplicate)
		piece[n++] = npiece;
	}

	// 反転形状についても同様な処理
	tshape = flip(shape);
	for (int j = 0; j < 4; j++) {
		tshape = rotate(tshape);
		Piece npiece = new Piece(id, tshape);
		duplicate = false;
		for (int k = 0; k < n; k++) {
			if (npiece.equals(piece[k])) {
				duplicate = true;
				break;
			}
		}
		if (!duplicate)
		piece[n++] = npiece;
	}

	Piece npiece[] = new Piece[n];
	for (int i = 0; i < n; i++) {
		piece[i].resetOrigin();
		npiece[i] = piece[i];
	}
	return npiece;
}

boolean placed[];
int total = 0;
long init_time;

/** 解を求める **/	
public void solve() {
	placed = new boolean[npiece];
	total = 0;
	init_time = System.currentTimeMillis();
	solveOneLevel(0, 0, 0);
}

void copyBoard() {
	synchronized (bcopy) {
		for (int x = 0; x < board_x; x++)
		for (int y = 0; y < board_y; y++)
		bcopy[x][y] = board[x][y];
	}
}

public void solveOneLevel(int level, int x, int y) {
	for (int i = 0; i < npiece; i++) {
		if (placed[i]) continue;
		if (i == 0 && (y >= (board_y +1)/ 2 || x >= ((board_x +1)/ 2) - 1))
		continue;

		for (int j = 0; j < piece[i].length; j++) {
			if (piece[i][j].place(board, x, y)) {
				if (show_progress && level >= npiece-2) {
					repaint();
				}
				if (level >= npiece-1) { // solved 
					total++;
					long t = System.currentTimeMillis();
					dbg("fond:" + total + " " + (t - init_time));//
					copyBoard();
					repaint();
					try {Thread.sleep(50);} catch (InterruptedException e) {}						
					} else {					
						int x2 = 0, y2 = 0;
						boolean found = false;
						for (int xx = x; (!found) && xx < board_x; xx++) {
							for (int yy = 0; (!found) && yy < board_y; yy++) {
								if (board[xx][yy] == -1) {
									x2 = xx;  y2 = yy;
									found = true;
								}
							}
						}
						if (found) {
							placed[i] = true;
							solveOneLevel(level+1, x2, y2);
							placed[i] = false;
						}
					}
					piece[i][j].remove(board);
				}
			}
		}
	}

	public synchronized void paint(Graphics g) {

		for (int i = 0; i < placed.length; i++) {
			if (placed[i]) {
				g.setColor(color[i]);
				g.fillRect(offx + i*4, 8, 4, 4);
			}
		}

		synchronized (bcopy) {
			for (int i = 0; i < board_x; i++) {
				for (int j = 0; j < board_y; j++) {
					int x = offx + i * (ps + po);
					int y = offy + j * (ps + po);
					if (bcopy[i][j] < 0) {
						g.setColor(Color.darkGray);
						g.fillRect(x, y, ps, ps);
						} else {				
							g.setColor(color[bcopy[i][j]]);
							g.fillRect(x, y, ps, ps);
							if (i < board_x - 1 && bcopy[i][j] == bcopy[i+1][j])
							g.fillRect(x+ps, y, po, ps);
							if (j < board_y - 1 && bcopy[i][j] == bcopy[i][j+1])
							g.fillRect(x, y + ps, ps, po);
							if (i < board_x - 1 && j < board_y - 1 &&
								bcopy[i][j] == bcopy[i+1][j+1] &&
								bcopy[i][j] == bcopy[i+1][j] && 
								bcopy[i][j] == bcopy[i][j+1])
							g.fillRect(x + ps, y + ps, po, po);
						}
					}
				}
			}
			g.setColor(Color.white);
			g.drawString("No." + total, 30, offy - 5);
		}

		protected Graphics offg;
		protected Image offscreen;
		protected int imagewidth, imageheight;

		/** オフスクリーンイメージを作る **/
		protected void checkOffscreen(Dimension d) {
			if ((offscreen == null) ||
				((imagewidth != d.width) || (imageheight != d.height))) {
				offscreen = this.createImage(d.width, d.height);
				imagewidth = d.width;
				imageheight = d.height;
				offg = offscreen.getGraphics();
			}
		}

		public void update(Graphics g) {
			Dimension d = getSize();
			checkOffscreen(d);
			offg.clearRect(0, 0, d.width, d.height);
			paint(offg);
			g.drawImage(offscreen, 0, 0, this);
		}	

		public static void main(String argv[]) {
			Frame f = new Frame();
			Pentomino app = new Pentomino(20, 3);
			f.add(app);
			app.init();
			f.pack();
			f.show();
		}

