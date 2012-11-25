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

		// とりあえず全部一緒にしてみる
		int[][] rv = {{1,1,1,1,1},{1,1,1,1,1}};
		this.roomValue = rv;
	}
}
