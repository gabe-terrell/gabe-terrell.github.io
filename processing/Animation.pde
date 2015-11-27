class Animation {
	int frame;
	int totalFrames;
	boolean finished;

	Animation (int frames) {
		frame = 0;
		totalFrames = frames;
		finished = false;
	}

	Animation () {
		self(1);
	}

	void animate() {
		if (!finished) {
			animateFrame();
			frame++;
			if (finishedAnimation()) {
				finished = true;
			}
		}
	}

	void animateFrame() {
		// To be overloaded by child
	}

	boolean finishedAnimation() {
		return frame == totalFrames;
	}

	void resetAnimation() {
		frame = 0;
		finished = false;
	}
}

class AnimationQueue extends Animation {
	ArrayList<Animation> queue;
	ArrayList<Animation> finished;

	AnimationQueue () {
		queue = new ArrayList<Animation>();
		finished = new ArrayList<Animation>();
	}

	AnimationQueue (Animation[] animations) {
		self();
		addAnimations(animations);
	}

	void addAnimation (Animation animation) {
		queue.add(animation);
		finished = false;
	}

	void addAnimations (Animation[] animations) {
		for (Animation animation : animations) {
			queue.add(animation);
		}
		finished = false;
	}

	void animateFrame() {
		Animation animation = queue.get(0);
		animation.animate()
		if (animation.finished) {
			finished.add(animation);
			queue.remove(0);
		}
	}

	boolean finishedAnimation() {
		return queue.isEmpty();
	}

	void resetAnimation() {
		ArrayList<Animation> allAnimations = new ArrayList<Animation>();

		for (Animation animation : finished) {
			allAnimations.add(animation);
		}
		for (Animation animation : queue) {
			allAnimations.add(animation);
		}
		
		queue = allAnimations;
		finished = new ArrayList<Animation>();
	}
}