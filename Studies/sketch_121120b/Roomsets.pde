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

	// For debug
	int hoge;

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
		allValue = 0;

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
				// For debug
				// println("[i,j]=["+i+","+j+"] gv="+gridValue[i][j]);
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
		fitness = gridWidth*gridHeight + insideValue - allValue - doubleNumber*2;
	}

	float getFitness(){
		fitness();
		return fitness;
	}

	void renderGrid(int size,int x, int y){
		grid.setPos(size,x,y);
		grid.render();
	}

	DNA getDNA(){
		return dna;
	}
}










