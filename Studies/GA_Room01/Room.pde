class Room 
{
  float roomWidth, roomHeight;
  float centerX, centerY;
  int populationNum;
  DNA[] population;  // Array to hold the current population

  public Room (int populationNum) {
    population = new DNA(roomNumber)[populationNum];
    for (int i = 0; i<roomNumber; i++){
      roomPos[i] = new DNA(roomNumber);
    }
  }

  // Fill our fitness array with a value for every member of the room
  void calcFitness(){
    for (int i = 0; i<len; i++){
      
    }
    for (int i = 0; i<population.length; i++){
      for (int j = 0; j<population[i].genes.length; j++){
        for (int k = 0; k<population[i].roomValue[j][k].length; k++){
          gridValue[population[i].x+j][population[i].y+k] += population[i].genes[j].roomValue();
        }
      }
    }
  }


}