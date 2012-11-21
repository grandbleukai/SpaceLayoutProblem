class Room 
{
	int[][] roomValue;
	int xPos, yPos; // Top left position of a room
	int type;

	//--------------------------------------
	//  CONSTRUCTOR
	//--------------------------------------
	Room (PVector gene){
		// PVector elements are float by default
		xPos = int(gene.x);
		yPos = int(gene.y);
		int type = (int) gene.z;
		
		switch (type){
			// Bedroom
			case 0 :
				int[][] roomValue = {{1,1,1},{1,1,1}};
			break;
		}


		if (type == 0){
			int[][] roomValue = {{1,1,1},{1,1,1}};
		}
	}
}