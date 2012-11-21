// Define phenotype from dna
class Roomsets 
{
	// Geometrical Properties

	int[][]	roomValue;  // Room shape
	Room[] rooms;
	Grid grid;
	int gridEvaluated;
	int insideValue;

	// hoge is for test I can delete when success
	int hoge;

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
		fitness();
	}

	// Fitness Function
	void fitness(){
		int[][] gridValue = grid.gridValue;
		for (int k = 0; k<rooms.length; k++){
			for (int i = 0; i<rooms[k].roomValue.length; i++){
				for (int j = 0; j<rooms[k].roomValue[0].length; j++){
					int xi = i+rooms[k].xPos;
					int yj = j+rooms[k].yPos;
					gridValue[xi][yj] += rooms[k].roomValue[i][j];
				}
			}
		}
		hoge = gridWidth + rooms[0].xPos;
		int gridEvaluated =0;
		for (int i = 0; i<gridWidth; i++){
			for (int j = 0; j<gridHeight; j++){
				gridEvaluated += gridValue[i][j];
			}
		}
		insideValue = gridEvaluated;
		fitness = gridEvaluated;
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










