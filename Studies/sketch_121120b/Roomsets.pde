// Define phenotype from dna
class Roomsets 
{
	// Geometrical Properties

	int[][]	roomValue;  // Room shape
	Room[] rooms;
	Grid grid;
	int gridEvaluated;

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
		// println("print room length =" + rooms.length);
		// println("print roomValue length =" + rooms[0].roomValue.length);
		// println("print roomvalue[] length =" + rooms[0].roomValue[0].length);
		// println("print gridValue length =" + gridValue.length + "*" + gridValue[0].length);

		for (int k = 0; k<rooms.length; k++){
			for (int i = 0; i<rooms[k].roomValue.length; i++){
				for (int j = 0; j<rooms[k].roomValue[0].length; j++){
					// println(" xPos"+ rooms[k].xPos +" yPos"+ rooms[k].yPos);
					int xi = gridWidth+i+rooms[k].xPos;
					int yj = gridHeight+j+rooms[k].yPos;
					// println("xi"+ xi +"yj"+ yj +"k"+ k +"i"+ i +"j"+ j);
					gridValue[xi][yj] += rooms[k].roomValue[i][j];
				}
			}
		}
		hoge = gridWidth + rooms[0].xPos;
		int gridEvaluated =0;
		for (int i = gridWidth; i<gridWidth*2; i++){
			for (int j = gridHeight; j<gridHeight*2; j++){
				gridEvaluated += gridValue[i][j];
			}
		}
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










