class Population 
{

	float mutationRate;          // Mutation rate
	Roomsets[] population;         // Array to hold the current population
	ArrayList<Roomsets> matingPool;    // ArrayList which we will use for our "mating pool"
	int generations;             // Number of generations

	//--------------------------------------
	//  CONSTRUCTOR
	//--------------------------------------
	
	Population (float m, int num) {
		// expression
		mutationRate = m;
		matingPool = new ArrayList<Roomsets>();
		generations = 0;	// Counter for generation
		population = new Roomsets[num];
		for (int i = 0; i<population.length; i++){
			DNA dna = new DNA(roomArray);
			population[i] = new Roomsets(dna);
		}
	}

	// Calculate fitness for ezch creature
	void fitness(){
		for (int i = 0; i<population.length; i++){
			population[i].fitness();
		}
	}

	// Generate a mating pool
	void selection(){
		// Clear the ArrayList
		matingPool.clear();

		// Calculate total fitness of whole population
		float maxFitness = getMaxFitness();
	}

	// Making the next generation
	void reproduction(){
		for (int i = 0; i<population.length; i++){
			// Spring the wheel of fortune to pick two parents
			int m = int(random(matingPool.size()));
			int d = int(random(matingPool.size()));
			// Pick two parents
			Roomsets mon = matingPool.get(m);
			Roomsets dad = matingPool.get(d);
			// Get their genes
			DNA mongenes = mon.getDNA();
			DNA dadgenes = dad.getDNA();
			// Mate their genes
			DNA child = mongenes.crossover(dadgenes);
			// Mutate their genes
			child.mutate(mutationRate);
			// Fill the new population with the new child
			population[i] = new Roomsets(child);
		}
		generations++;
	}

	int getGenerations(){
		return generations;
	}


	// Find highest fitness for the population
	float getMaxFitness(){
		float record = 0;
		for (int i = 0; i<population.length; i++){
			if (population[i].getFitness() > record){
				record = population[i].getFitness();
			}
		}
		return record;
	}
}