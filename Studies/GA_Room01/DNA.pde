class DNA {
  float genes;
  float fitness;
  
  DNA(int num) {
    genes = new float[num];
    for (int i = 0; i<genes.length; i++){
      genes[i] = float(1);
    }
  }
  
  void fitness () {
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