class Grid 
{
	int unitSize;
	int xTop,yTop;
	int[][][] gridValue; //[x][y][value,color]

	//--------------------------------------
	//  CONSTRUCTOR
	//--------------------------------------
	Grid (int s, int x, int y) {
		// expression
		unitSize = s;
		xTop = x;
		yTop = y;
    gridValue = new int[extraGridWidth][extraGridHeight][2];
    for (int i = 0; i<extraGridWidth; i++){
      for (int j = 0; j<extraGridHeight; j++){
        gridValue[i][j][0] = 0;
      }
    }
  }

  Grid (){
    gridValue = new int[extraGridWidth][extraGridHeight][2];
    for (int i = 0; i<extraGridWidth; i++){
      for (int j = 0; j<extraGridHeight; j++){
        gridValue[i][j][0] = 0;
      }
    }
  }

  void setInitialValue(int x, int y, int w, int h) {
    for (int i = x; i<x+w; i++){
      for (int j = y; j<y+h; j++){
        gridValue[i][j][0] = 1;
      }
    }
  }

  void setPos(int s, int x, int y){
    this.unitSize = s;
    this.xTop = x;
    this.yTop = y;
  }

  void render(){
     for (int i = 0; i<gridWidth; i++){
      for (int j = 0; j<gridHeight; j++){
        fill(225);
        stroke(0);
        rect(xTop+unitSize*i, yTop+unitSize*j, unitSize, unitSize);
      }
    }
    for (int s = 0; s<gridWidth; s++){
      for (int t = 0; t<gridHeight; t++){
        noStroke();
        stroke(240);
        if (gridValue[s][t][1]==6){
          fill(c1);
          stroke(c1);
        }
        else if (gridValue[s][t][1]==5) {
          fill(c2);
          stroke(c2);
        }
        else {
          fill(255);
        }

        //かぶってる部分をグレーにする
        if (gridValue[s][t][0]>1){  
            fill(255-20*gridValue[s][t][0]);
            stroke(255-20*gridValue[s][t][0]);
        }
        rect(xTop+unitSize*s, yTop+unitSize*t, unitSize, unitSize);
      }
    }

  }
}
