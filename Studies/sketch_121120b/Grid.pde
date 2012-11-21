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

  void setPos(int s, int x, int y){
    this.unitSize = s;
    this.xTop = x;
    this.yTop = y;
  }

  void render(){
    for (int s = 0; s<extraGridWidth; s++){
      for (int t = 0; t<extraGridHeight; t++){
        // println(gridValue[s][t]);
        noStroke();
        stroke(240);
        fill(255-50*gridValue[s][t]);
        rect(xTop+unitSize*s, yTop+unitSize*t, unitSize, unitSize);
      }
    }
    for (int i = gridWidth; i<gridWidth*2; i++){
      for (int j = gridHeight; j<gridHeight*2; j++){
        noFill();
        stroke(0);
        rect(xTop+unitSize*i, yTop+unitSize*j, unitSize, unitSize);
      }
    }
  }
}