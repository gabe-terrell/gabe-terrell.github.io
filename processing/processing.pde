// Stellation[] stellations = new Stellation[6];

// void setup() {
// 	// Use this size() for compiling on Processing
// 	// size(1200, 800);
// 	// Use this size() for compiling on Processing.js (16 -> 8, 5, 6, 7, 9)
// 	size(window.innerWidth, window.innerHeight); 
// 	for (int i = 0; i < stellations.length; ++i) {
// 		stellations[i] = new Stellation(width / 6 * i, random(0, height));
// 	}
// }

// void draw() {
// 	background(color(#FAEBD7), 0); 
// 	for (int i = 0; i < stellations.length; ++i) {
// 		stellations[i].drawStellation();
// 	}
// }

Stellation stellation;
Animation animation;

void setup() {
	// Use this size() for compiling on Processing
	// size(1200, 800);
	// Use this size() for compiling on Processing.js (16 -> 8, 5, 6, 7, 9)
	size(window.innerWidth, window.innerHeight); 
	stellation = new Stellation(width / 2.0, height / 2.0);
	animation = stellation.drawingAnimation(1);
	background(color(#FAEBD7), 0); 
}

void draw() {
	//background(color(#FAEBD7), 0); 
	animation.animate();
	if (animation.finished) {
		int time = millis();
		while (millis() < time + 5000) {
			// wait 5 seconds
		}
		background(color(#FAEBD7), 0); 
		stellation = new Stellation(width / 2.0, height / 2.0);
		animation = stellation.drawingAnimation(5);
	}
}