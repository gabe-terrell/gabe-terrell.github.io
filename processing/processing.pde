Graph[] graphs = new Graph[10];

void setup() {
	// Use this size() for compiling on Processing
	// size(1200, 800);
	// Use this size() for compiling on Processing.js (16 -> 8, 5, 6, 7, 9)
	size(window.innerWidth, window.innerHeight); 
	for (int i = 0; i < graphs.length; ++i) {
		graphs[i] = new Graph(random(0, width), random(0, height));
	}
}

void draw() {
	background(color(#FAEBD7)); 
	for (int i = 0; i < graphs.length; ++i) {
		graphs[i].drawGraph();
	}
}