class PointAnimation extends Animation {
	Point start, end;

	PointAnimation (Point _start, Point _end, int frames) {
		start = _start;
		end = _end;
		// Workaround for 1 frame option
		super(frames + 1);
		frame++;
	}

	void animateFrame() {
		start.lerp(start, end, frame / 1.0 / totalFrames).draw();
	}
}

class LineAnimation extends Animation {
	Point p1, p2;

	LineAnimation (Point _p1, Point _p2, int frames) {
		p1 = _p1;
		p2 = _p2;
		// Workaround for 1 frame option
		super(frames + 1);
		frame++;
	}

	void animateFrame() {
		p1.connect(p1.lerp(p1, p2, frame / 1.0 / totalFrames));
	}
}