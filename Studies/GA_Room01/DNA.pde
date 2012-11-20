class DNA {
  // The genetic sequence
  // set PVector x as room xPos, y as yPos, z as room type
  PVector[] genes;
  float fitness;
  int[] roomType;
  
  // Constructor ( makes a random DNA)
  // num = Number of genes (= room number)
  // roomType.length = Room Number
  DNA(int[] roomType) {
    this.roomType = roomType;
    genes = new PVector[roomType.length];
    for (int i = 0; i<genes.length; i++){
      genes[i].set(random(0,1),random(0,1),roomType[i]);
    }
  }
  
  void fitness () {

  }

  int calcGridValue(){
    for (int i = 0; i<this.roomValue().length; i++){
      for (int j = 0; j<this.roomValue()[i].length; j++){
        gridValue[this.x+i][this.y+j] += this.roomValue[i][j];
      }
    }
  }

  // Define room type
  int[][] roomValue(){
    for (int i = 0; i<room.length; i++){
      if (this.genes[i].z = 0){
        roomValue num[][] = {{1, 3, 5}, {2, 4, 6}};
      }
      return roomValue;
    }
  }
  
  // Crossover
  DNA crossover(DNA partner) {
    // A new child
    DNA child = new DNA(genes.length);
    
    int midpoint = int(random(genes.length)); // Pick a midpoint
    
    // Half from one, half from the other
    for (int i = 0; i < genes.length; i++) {
      if (i > midpoint) child.genes[i] = genes[i];
      else              child.genes[i] = partner.genes[i];
    }
    return child;
  }
  
  void mutate(float mutationRate) {
    for (int i = 0; i < genes.length; i++) {
      if (random(1) < mutationRate) {
        genes[i] = (float) random(0,1);
      }
    }
  }
}