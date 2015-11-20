Graph[] graphs = new Graph[10];

void settings() {
  fullScreen();
}

void setup() {
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