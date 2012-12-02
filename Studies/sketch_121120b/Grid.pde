class Grid 
{
	int unitSize;
	int xTop,yTop;
	int[][] gridValue;

	//--------------------------------------
	//  CONSTRUCTOR
	//--------------------------------------
	Grid (int s, int x, int y) {
		// expression
		unitSize = s;
		xTop = x;
		yTop = y;
    gridValue = new int[extraGridWidth][extraGridHeight];
    for (int i = 0; i<extraGridWidth; i++){
      for (int j = 0; j<extraGridHeight; j++){
        gridValue[i][j] = 0;
      }
    }
  }

  Grid (){
    gridValue = new int[extraGridWidth][extraGridHeight];
    for (int i = 0; i<extraGridWidth; i++){
      for (int j = 0; j<extraGridHeight; j++){
        gridValue[i][j] = 0;
      }
    }
  }

  void setInitialValue(int x, int y, int w, int h) {
    for (int i = x; i<x+w; i++){
      for (int j = y; j<y+h; j++){
        gridValue[i][j] = 1;
      }
    }
  }

  void setPos(int s, int x, int y){
    this.unitSize = s;
    this.xTop = x;
    this.yTop = y;
  }

  void render(){
    for (int s = 0; s<extraGridWidth; s++){
      for (int t = 0; t<extraGridHeight; t++){
        noStroke();
        stroke(240);
        fill(255-50*gridValue[s][t]);
        rect(xTop+unitSize*s, yTop+unitSize*t, unitSize, unitSize);
      }
    }
    for (int i = 0; i<gridWidth; i++){
      for (int j = 0; j<gridHeight; j++){
        noFill();
        stroke(0);
        rect(xTop+unitSize*i, yTop+unitSize*j, unitSize, unitSize);
      }
    }
  }
}