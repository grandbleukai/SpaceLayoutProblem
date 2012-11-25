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
		yPos = int(gene.y);
		type = int(gene.z);

		int index = 30; // Number of room typesZ
		roomValue = new int[index][][];
		// とりあえず全部一緒にしてみる
		int[][] rv0 = {{1,1,1,1,1},{1,1,0,0,0}};
		int[][] rv1 = {{1,1},{1,1},{1,1}};
		roomValue[0] = rv0;
		roomValue[1] = rv1;
		// はみ出さないようにmapする
		xPos = (int)map(gene.x, 0, gridWidth, 0, gridWidth-this.roomValue[type].length+1);
		yPos = (int)map(gene.y, 0, gridWidth, 0, gridWidth-this.roomValue[type][0].length+1);
	}
}
