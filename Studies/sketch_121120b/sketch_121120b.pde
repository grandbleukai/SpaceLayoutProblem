/*
*  Grid layout system
*
*  @author Nishimura Kai
*  @since  2012-11-20
*/
//------------------------
//	部屋の形はRoom.pdeで記述されている
//------------------------

int gridWidth = 10;
int gridHeight = 5;
int extraGridWidth = gridWidth*2;
int extraGridHeight = gridHeight*2;
int[] roomArray = {5,5,5,6};	//部屋の数と種類
int populationNumber = 200;

// 最初に配置する定位置の室
int initX = 2;
int initY = 4;
int initW = 6;
int initH = 4;

int lifetime; // Howlong should each generation live
Population population; // Population
int lifecycle; // Timer for cycle of generation
int recordtime; // Fastest time to target
Roomsets[] topFitsEver;	//それまでで一番fitnessが高かったroomsetを記憶する

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
  frameRate(10);
}

void draw(){
	background(255);

	boolean go = true;
	for (int i = 0; i<populationNumber; i++){
		if (population.getRoomsets(i).gridFilled){
			go = false;

		}
	}

	if (go){
		population.fitness();
		for (int i = 0; i<min(5, populationNumber); i++){
			population.getRoomsets(i).renderGrid(5,400,120*i+100);
			Roomsets r = population.getRoomsets(i);
			fill(0);
			text("fitness="+r.getFitness() +" doubleNumber="+r.doubleNumber + " insideValue=" +r.insideValue, 400, 120*(1+i)+65);
		}
		Roomsets rt = population.getTopSet();
		rt.renderGrid(12,80,100);
		fill(0);
		text("fitness="+rt.getFitness()+ " doubleNumber="+rt.doubleNumber + " insideValue=" +rt.insideValue, 20, 410);
		population.selection();
		population.reproduction();
	}
	else {
		population.getTopSet().renderGrid(12,80,100);
		for (int i = 0; i<min(5, populationNumber); i++){
			population.getRoomsets(i).renderGrid(5,400,120*i+100);
			Roomsets r = population.getRoomsets(i);
			fill(0);
			text("fitness="+r.getFitness()+" doubleNumber="+r.doubleNumber + " insideValue=" +r.insideValue, 400, 120*(1+i)+65);
		}
		Roomsets rt = population.getTopSet();
		rt.renderGrid(12,80,100);
		fill(0);
		text("fitness="+rt.getFitness()+ " doubleNumber="+rt.doubleNumber + " insideValue=" +rt.insideValue, 20, 310);
	}

	// Display some info
	fill(0);
	float fitSum = 0;
	for (int i = 0; i<populationNumber; i++){
		fitSum += population.getRoomsets(i).getFitness();
	}
	float fitAve = fitSum/populationNumber;
	text("Generation #: " + population.getGenerations(), 10, 18);
	text("fitness: " + population.getTopSet().getFitness(), 10, 36);
	text("fitness average: " + fitSum/populationNumber, 10, 54);
}

void mousePressed(){
	stop();
}

