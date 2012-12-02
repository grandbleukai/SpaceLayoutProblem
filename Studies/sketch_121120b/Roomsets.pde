// Define phenotype from dna
class Roomsets 
{
	// Geometrical Properties

	int[][]	roomValue;  // Room shape
	Room[] rooms;
	Grid grid;
	int[][] gridValue;
	int gridEvaluated;
	int insideValue;	// Sum of all elements inside the main grid (house frame)
	int doubleNumber; // Sum of all elements more than 2 (each-1)
	int allValue;	// Sum of all value
	boolean gridFilled;

	// Fitness and DNA
	float fitness;	// Fitness for a roomset
	DNA dna;
	
	//--------------------------------------
	//  CONSTRUCTOR
	//--------------------------------------
	Roomsets (DNA dna_) {
		// expression
		dna = dna_;
		grid = new Grid();
		rooms = new Room[roomArray.length];
		for (int i = 0; i<roomArray.length; i++){
			rooms[i] = new Room(dna_.genes[i]);
		}

		setGridValue();
		checkFilled();
	}

	Roomsets(){

	}

	void setGridValue(){
		int[][] gridValue = grid.gridValue;

		//　最初に定位置の室を配置する
		grid.setInitialValue(initX,initY,initW,initH);

		allValue = initW*initH;

		for (int k = 0; k<rooms.length; k++){
			for (int i = 0; i<rooms[k].roomValue[rooms[k].type].length; i++){
				for (int j = 0; j<rooms[k].roomValue[rooms[k].type][i].length; j++){
					int xi = i+rooms[k].xPos;
					int yj = j+rooms[k].yPos;
					gridValue[xi][yj] += rooms[k].roomValue[rooms[k].type][i][j];
					allValue += rooms[k].roomValue[rooms[k].type][i][j];
				}
			}
		}
		doubleNumber = 0;
		insideValue = 0;
		for (int i = 0; i<gridWidth; i++){
			for (int j = 0; j<gridHeight; j++){
				insideValue += gridValue[i][j];
			}
		}
		for (int i = 0; i<extraGridWidth; i++){
			for (int j = 0; j<extraGridHeight; j++){
				if (gridValue[i][j] >= 2){
					doubleNumber += gridValue[i][j] -1;
				}
			}
		}
	}

	boolean checkFilled() {
		if (doubleNumber==0 && allValue == insideValue){
			gridFilled = true;
		}else {
			gridFilled = false;
		}
		return gridFilled;
	}

	// Fitness Function
	void fitness(){
		int outsideValue = allValue - insideValue;
		int fitnessRev = doubleNumber;

		int outlineValue = 0;
		for (int i = 0; i<gridWidth; i++){
			for (int j = 0; j<gridHeight; j++){
				outlineValue += grid.gridValue[i][0] + grid.gridValue[i][gridHeight-1] + grid.gridValue[0][j] + grid.gridValue[gridWidth-1][j];
			}
		}
		fitness = gridWidth*gridHeight + insideValue - allValue - doubleNumber*2 + outlineValue;
	}

	float getFitness(){
		fitness();
		return fitness;
	}

	void renderGrid(int size,int x, int y){
		grid.setPos(size,x,y);
		grid.render();
		fill(0);
		text("fitness="+getFitness(), x, y + size*gridHeight+15);
	}

	DNA getDNA(){
		return dna;
	}
}










