class Grid 
{
	int unitSize;
	int xPos,yPos;
	int[][] gridValue;

	//--------------------------------------
	//  CONSTRUCTOR
	//--------------------------------------
	Grid (int s, int x, int y) {
		// expression
		unitSize = s;
		xPos = x;
		yPos = y;
    gridValue = new int[gridWidth][gridHeight];
		for (int i = 0; i<gridWidth; i++){
			for (int j = 0; j<gridHeight; j++){
				gridValue[i][j] = 0;
			}
		}
	}

	void render(){
    for (int i = 0; i<gridWidth; i++){
      for (int j = 0; j<gridHeight; j++){
        rect(xPos+unitSize*i, yPos+unitSize*j, unitSize, unitSize);
      }
    }
	}
}