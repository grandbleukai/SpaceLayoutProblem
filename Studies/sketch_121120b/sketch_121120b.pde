/**
 *  Grid layout system
 *
 *  @author Nishimura Kai
 *  @since  2012-11-20
 */

 int gridWidth = 8;
 int gridHeight = 8;
 int extraGridWidth = gridWidth*3;
 int extraGridHeight = gridHeight*3;
 int[] roomArray = {0,0};

int lifetime; // Howlong should each generation live
Population population; // Population
int lifecycle; // Timer for cycle of generation
int recordtime; // Fastest time to target


void setup(){
	size(800, 800);
	smooth();

  // The number of cycles we will allow a generation to live
  lifetime = 300;

  // Initialize variables
  lifecycle = 0;
  recordtime = lifetime;

  // Create a population with a mutation rate, and population max
  float mutationRate = 0.01;
  population = new Population(mutationRate, 5);

  // noLoop();
  // frameRate(2);
}

void draw(){
	background(255);

	population.fitness();
	population.selection();
	population.reproduction();

	// Draw grids
	population.getRoomsets(0).renderGrid(20,200,200);

  // Display some info
  fill(0);
  text("Generation #: " + population.getGenerations(), 10, 18);
  text("Cycles left: " + (lifetime-lifecycle), 10, 36);
  text("value: " + population.getRoomsets(0).getFitness(), 10, 54);
  text("xi0: " + population.getRoomsets(0).hoge, 10, 18*4);
}
