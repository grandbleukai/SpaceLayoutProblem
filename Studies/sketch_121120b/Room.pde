class Room 
{
	int[][][] roomValue;
	int xPos, yPos; // Top left position of a room
	int type;

	//--------------------------------------
	//  CONSTRUCTOR
	//--------------------------------------
	Room (PVector gene){
		// PVector elements are float by default
		xPos = int(gene.x);
		yPos = int(gene.y);
		type = int(gene.z);

		int index = 30; // Number of room typesZ
		roomValue = new int[index][][];
		// とりあえず全部一緒にしてみる
		int[][] rv0 = {{1,1,1},{1,1,0}};
		int[][] rv1 = {{1,1},{1,1},{1,1}};
		roomValue[0] = rv0;
		roomValue[1] = rv1;
	}
}
