class DNA 
{
	PVector[] genes; // A gene contains xPos, yPos, roomType

	//--------------------------------------
	//  CONSTRUCTOR #1
  //  create random instance based on an array of room type
	//--------------------------------------
	public DNA(int[] roomType){
		// expression
		genes = new PVector[roomType.length]; //Create roomType number of genes
		for (int i = 0; i<genes.length; i++){
			PVector v = new PVector(int(random(gridWidth)),int(random(gridHeight)),(int)roomType[i]);
			for (int j = 0; j<i; j++){
				while (genes[j].x == v.x && genes[j].y == v.y){
					v = new PVector(int(random(gridWidth)),int(random(gridHeight)),(int)roomType[i]);
				}
				// if (genes[j].x == genes[i].x && genes[j].y == genes[j].y){
				// 	v = new PVector(int(random(gridWidth)),int(random(gridHeight)),(int)roomType[i]);
				// }
			}
			genes[i] = v;
		}
	}

	// boolean checkSamePosition(PVector gene){
	// 	// Make sure that same position will not occur
	// 	for (int i = 0; i<genes.length; i++){
	// 		PVector v = new PVector(int(random(gridWidth)),int(random(gridHeight)),(int)roomType[i]);
	// 		for (int j = 0; j<i; j++){
	// 			while (genes[j].x == v.x && genes[j].y == v.y){
	// 				v = new PVector(int(random(gridWidth)),int(random(gridHeight)),(int)roomType[i]);
	// 			}
	// 			// if (genes[j].x == genes[i].x && genes[j].y == genes[j].y){
	// 			// 	v = new PVector(int(random(gridWidth)),int(random(gridHeight)),(int)roomType[i]);
	// 			// }
	// 		}
	// 		genes[i] = v;
	// 	}
	// 	return true;
	// }

	//--------------------------------------
	//  CONSTRUCTOR #2
  //  create the instance based on an existing array
	//--------------------------------------
	DNA (PVector[] newgenes){
		genes = newgenes;
	}

	// CROSSOVER
	DNA crossover(DNA partner){
		PVector[] child = new PVector[genes.length];
		// Pick a midpoint
		int crossover = int(random(genes.length));
		// Take half from one and half from the other
		for (int i = 0; i<genes.length; i++){
			if (i > crossover){
				child[i] = genes[i];
			}
			else {
				child[i] = partner.genes[i];
			}
		}
		DNA newgenes = new DNA(child);
		return newgenes;
	}

	// MUTATION
	void mutate(float m){
		for (int i = 0; i<genes.length; i++){
			if(random(1) < m){
				genes[i].x = (int) random(0, gridWidth);
				genes[i].y = (int) random(0, gridHeight);
			}
		}
	}
}


















