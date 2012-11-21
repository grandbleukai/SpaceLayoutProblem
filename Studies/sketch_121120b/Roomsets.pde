// Define phenotype from dna
class Roomsets 
{
	// Geometrical Properties

	int[][]	roomValue;  // Room shape
	Room[] rooms;
	Grid grid;

	// Fitness and DNA
	int fitness;	// Fitness for a roomset
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
	}

	// Fitness Function
	void fitness(){
		int[][] gridValue = grid.gridValue;
		for (int k = 0; k<rooms.length; k++){
			for (int i = 0; i<rooms[k].roomValue.length; i++){
				for (int j = 0; j<rooms[k].roomValue[i].length; j++){
					gridValue[i+rooms[k].xPos][j+rooms[k].yPos] += rooms[k].roomValue[i][j];
				}
			}
		}
		int gridEvaluated =0;
		for (int i = 0; i<gridValue.length; i++){
			for (int j = 0; j<gridValue[i].length; j++){
				gridEvaluated += gridValue[i][j] -1;
			}
		}
		fitness = gridEvaluated; // Minimize this value
	}

	float getFitness(){
		return fitness;
	}

	void renderGrid(int s,int x, int y){
		grid.setPos(s,x,y);
		grid.render();
	}

	DNA getDNA(){
		return dna;
	}
}










