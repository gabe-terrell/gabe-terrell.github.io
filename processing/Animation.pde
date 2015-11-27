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
		this(1);
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
		return frame > totalFrames + 1;
	}

	void resetAnimation() {
		frame = 0;
		finished = false;
	}
}

class AnimationQueue extends Animation {
	ArrayList<Animation> queue;
	ArrayList<Animation> done;

	AnimationQueue () {
		queue = new ArrayList<Animation>();
		done = new ArrayList<Animation>();
	}

	AnimationQueue (Animation[] animations) {
		this();
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
		animation.animate();
		if (animation.finished) {
			done.add(animation);
			queue.remove(0);
		}
	}

	boolean finishedAnimation() {
		return queue.isEmpty();
	}

	void resetAnimation() {
		ArrayList<Animation> allAnimations = new ArrayList<Animation>();

		for (Animation animation : done) {
			animation.resetAnimation();
			allAnimations.add(animation);
		}
		for (Animation animation : queue) {
			animation.resetAnimation();
			allAnimations.add(animation);
		}

		queue = allAnimations;
		done = new ArrayList<Animation>();
		finished = false;
	}
}

class AnimationBatch extends AnimationQueue {
	void animateFrame() {
		ArrayList<Animation> finishedAnimations = new ArrayList<Animation>();

		for (Animation animation : queue) {
			animation.animate();
			if (animation.finished) {
				finishedAnimations.add(animation);
			}
		}

		for (Animation animation : finishedAnimations) {
			done.add(animation);
			queue.remove(animation);
		}
	}
}