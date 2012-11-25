/*
*  Grid layout system
*
*  @author Nishimura Kai
*  @since  2012-11-20
*/

int gridWidth = 8;
int gridHeight = 8;
int extraGridWidth = gridWidth*2;
int extraGridHeight = gridHeight*2;
int[] roomArray = {0,0,0};
int populationNumber = 40;

int lifetime; // Howlong should each generation live
Population population; // Population
int lifecycle; // Timer for cycle of generation
int recordtime; // Fastest time to target


boolean go = false;
boolean outsideOk = false;


void setup(){
	size(800, 800);
	smooth();

  // The number of cycles we will allow a generation to live
  lifetime = 300;

  // Initialize variables
  lifecycle = 0;
  recordtime = lifetime;

  // Create a population with a mutation rate, and population max
  float mutationRate = 0.1;
  population = new Population(mutationRate, populationNumber);

  // noLoop();
  // frameRate(10);
}

void draw(){
	background(255);

	// 行列の中に２がある限りGO!!!
	for (int i = 0; i<populationNumber; i++){
		int[][] gv = population.getRoomsets(i).grid.gridValue;
		// 最初はGO
		go = false;
		outsideOk = false;
		int gvSum = 0;
		for (int j = 0; j<gv.length; j++){
			for (int k = 0; k<gv[j].length; k++){
				gvSum += gv[j][k];
				if (gv[j][k] >= 2){
					go = true;
				}
			}
		}
		if (population.getRoomsets(i).insideValue != gvSum){
			outsideOk = true;
			}else {
			// println(population.getRoomsets(i).insideValue+"|"+gvSum);			
		}
	}


	if (outsideOk | go){
		population.fitness();
		for (int i = 0; i<min(5, populationNumber); i++){
			population.getRoomsets(i).renderGrid(5,400,120*i+100);
			Roomsets r = population.getRoomsets(i);
			fill(0);
			text("doubleNumber="+r.doubleNumber + " insideValue=" +r.insideValue, 400, 120*(1+i)+65);
		}
		population.getTopSets().renderGrid(12,80,100);
		population.selection();
		population.reproduction();
		}else {
			population.getTopSets().renderGrid(12,80,100);
			for (int i = 0; i<min(5, populationNumber); i++){
				population.getRoomsets(i).renderGrid(5,400,120*i+100);
				Roomsets r = population.getRoomsets(i);
				fill(0);
				text("doubleNumber="+r.doubleNumber + " insideValue=" +r.insideValue, 400, 120*(1+i)+65);
			}
		}

	// Draw first grids
	// if (population.getGenerations() == 0){
	// 	for (int i = 0; i<populationNumber; i++){
	// 		population.getRoomsets(i).renderGrid(5,150*i+100,200);		
	// 	}		
	// }


  // Display some info
  fill(0);
  text("Generation #: " + population.getGenerations(), 10, 18);
  text("Cycles left: " + (lifetime-lifecycle), 10, 36);
  text("value: " + population.getRoomsets(0).getFitness(), 10, 54);
  text("xi0: " + population.getRoomsets(0).hoge, 10, 18*4);
}

void mousePressed(){
	stop();
}

