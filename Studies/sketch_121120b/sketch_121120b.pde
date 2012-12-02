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
int gridHeight = 10;
int extraGridWidth = gridWidth*2;
int extraGridHeight = gridHeight*2;
int[] roomArray = {5,5,5,6};	//部屋の数と種類
int populationNumber = 100;
boolean go = true;
int us = 5; //右側の探索中のグリッドのサイズ


color c1 = color(31, 54, 66);
color c2 = color(109, 150, 141);
color c3 = color(182, 204, 184);
color c4 = color(255, 226, 179);
color c5 = color(86, 73, 63);




Roomsets top1,top2,top3,top4,top5;

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

void setup(){
	size(800, 800);
	smooth();

  // The number of cycles we will allow a generation to live
  lifetime = 300;

  // Initialize variables
  lifecycle = 0;
  recordtime = lifetime;

  top1 = new Roomsets();
  top2 = new Roomsets();
  top3 = new Roomsets();
  top4 = new Roomsets();
  top5 = new Roomsets();

  // Create a population with a mutation rate, and population max
  float mutationRate = 0.1;
  population = new Population(mutationRate, populationNumber);

  // noLoop();
  // frameRate(10);
}

void draw(){
	background(255);

	if (go){
		population.fitness();
		population.selection();
		population.reproduction();
	}
	for (int i = 0; i<min(3, populationNumber); i++){
		population.getRoomsets(i).renderGrid(us,400,(us*gridHeight*2+40)*i+100);
		Roomsets r = population.getRoomsets(i);
	}
	Roomsets rt = population.getTopSet();
	rt.renderGrid(12,80,100);

	if (population.getGenerations()<5){
		top1 = population.getRoomsets(1);
		top2 = top1;
		top3 = top1;
		top4 = top1;
		top5 = top1;
	}else {
		setTopSets();
		top1.renderGrid(5,50,600);
		top2.renderGrid(5,150,600);
		top3.renderGrid(5,250,600);
		top4.renderGrid(5,350,600);
		top5.renderGrid(5,450,600);
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

void setTopSets() {
	Roomsets rt = population.getTopSet();
	if (rt.doubleNumber == 0){
		if (rt.getFitness()>top1.getFitness()){
			top5 = top4;
			top4 = top3;
			top3 = top2;
			top2 = top1;
			top1 = rt;
		}
		else if (rt.getFitness()>top2.getFitness()) {
			top5 = top4;
			top4 = top3;
			top3 = top2;
			top2 = rt;
		}
		else if (rt.getFitness()>top3.getFitness()) {
			top5 = top4;
			top4 = top3;
			top3 = rt;
		}
		else if (rt.getFitness()>top4.getFitness()) {
			top5 = top4;
			top4 = rt;
		}
		else if (rt.getFitness()>top5.getFitness()) {
			top5 = rt;
		}		
	}
}

void mousePressed(){
	go =! go;
}

