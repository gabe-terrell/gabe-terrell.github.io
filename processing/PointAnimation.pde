class PointAnimation extends Animation {
	Point start, end;

	PointAnimation (Point _start, Point _end, int frames) {
		// Workaround for 1 frame option
		super(frames + 1);
		frame++;

		start = _start;
		end = _end;
	}

	void animateFrame() {
		start.pointBetween(start, end, frame / 1.0 / totalFrames).draw();
	}
}

class LineAnimation extends Animation {
	Point start, end;

	LineAnimation (Point _start, Point _end, int frames) {
		// Workaround for 1 frame option
		super(frames + 1);
		frame++;

		start = _start;
		end = _end;
	}

	void animateFrame() {
		start.connect(start.pointBetween(start, end, frame / 1.0 / totalFrames));
	}
}