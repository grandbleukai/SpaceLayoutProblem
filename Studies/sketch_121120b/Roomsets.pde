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
	}

	Roomsets(){
		
	}

	void setGridValue(){
		int[][] gridValue = grid.gridValue;
		allValue = 0;
		for (int k = 0; k<rooms.length; k++){
			for (int i = 0; i<rooms[k].roomValue.length; i++){
				for (int j = 0; j<rooms[k].roomValue[0].length; j++){
					int xi = i+rooms[k].xPos;
					int yj = j+rooms[k].yPos;
					gridValue[xi][yj] += rooms[k].roomValue[i][j];
					allValue += rooms[k].roomValue[i][j];
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
		println(doubleNumber);
	}

	// Fitness Function
	void fitness(){
		int outsideValue = allValue - insideValue;
		int fitnessRev = outsideValue+doubleNumber;
		fitness = allValue - fitnessRev;
		// For debugここで表示される情報はreproductionされたあとの
		// println("doubleNumber="+doubleNumber + " insideValue=" +insideValue + " allValue=" + allValue);
	}

	float getFitness(){
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










