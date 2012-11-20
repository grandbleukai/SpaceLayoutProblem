int gridWidth = 8;
int gridHeight = 8;
int[] roomArray = {0,0};
Roomsets roomsets;

void setup(){
	size(512, 512);
  DNA dna = new DNA(roomArray);
  roomsets = new Roomsets(dna);
}

void draw(){
	roomsets.renderGrid(20,20,20);
}
