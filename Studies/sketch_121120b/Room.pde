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
		// 縦向き
		int[][] rv0 = {{1,1},{0,0}};
		int[][] rv1 = {{1,1},{1,1}};
		int[][] rv2 = {{1,1},{1,1},{1,1},{1,1}};
		// 横向き
		int[][] rv3 = {{1,0},{1,0}};  //トイレ、階段
		int[][] rv4 = {{1,1,1},{1,1,1}};  //寝室
		int[][] rv5 = {{1,1,1,1},{1,1,1,1}};  //寝室
		int[][] rv6 = {{1,1,1,1,1,1},{1,1,1,1,1,1},{1,1,1,1,1,1},{1,1,1,1,1,1}};  //家族室

		roomValue[0] = rv0;
		roomValue[1] = rv1;
		roomValue[2] = rv2;
		roomValue[3] = rv3;
		roomValue[4] = rv4;
		roomValue[5] = rv5;
		roomValue[6] = rv6;
		// はみ出さないようにmapする
		xPos = (int)map(gene.x, 0, gridWidth, 0, gridWidth-this.roomValue[type].length+2);
		yPos = (int)map(gene.y, 0, gridWidth, 0, gridWidth-this.roomValue[type][0].length+2);
	}
}
