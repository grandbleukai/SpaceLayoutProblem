// grid horizontal number and vertical number
int xNumber, yNumber;

int popmax;
float mutationRate;
int roomNumber;
int[] roomType;


void setup() {
  size(600, 200);
  popmax = 150;
  mutationRate = 0.01;

  // Create a roomation with a target phrase, mutation rate, and roomation max
  room = new Room(target, mutationRate, popmax);
  room = new Room(width, height,1)
}

void draw() {
  // Generate mating pool
  room.naturalSelection();
  //Create next generation
  room.generate();
  // Calculate fitness
  room.calcFitness();
  displayInfo();

  // If we found the target phrase, stop
  if (room.finished()) {
    println(millis()/1000.0);
    noLoop();
  }
}

void displayInfo() {
  background(255);
  // Display current status of roomation
  String answer = room.getBest();
  textFont(f);
  textAlign(LEFT);
  fill(0);
}


