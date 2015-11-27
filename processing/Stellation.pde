class Point {
    float x;
    float y;

    Point (float _x, float _y) {
        x = _x;
        y = _y;
    }

    void connect (Point p) {
        line(x, y, p.x, p.y);
    }

    void draw() {
        point(x, y);
    }

    Point pointBetween (Point p1, Point p2, float pct) {
        if (pct <= 0.0) {
            return p1;
        }
        if (pct >= 1.0) {
            return p2;
        }
        float x = lerp(p1.x, p2.x, pct);
        float y = lerp(p1.y, p2.y, pct);
        return new Point(x, y);
    }
}

class Stellation {
    Point center;
    float radius;
    Point[] points;
    float angle;
    float spacing;
    float delta = 0;
    int[] gaps;

    Stellation (float x, float y) {
        center = new Point(x, y);
        radius = height / 2.0 - 10;
        int numPoints = floor(random(15, 26));
        spacing = TWO_PI / numPoints;
        angle = 0.0;
        points = new Point[numPoints];
        placePoints();

        int cycles = floor(random(3, 5));
        gaps = new int[cycles];
        for (int i = 0; i < cycles; i++) {
            gaps[i] = floor(random(2, 12));
        }
    }

    // Places points based on current angle
    void placePoints() {
        for (int i = 0; i < points.length; ++i) {
            float x = center.x + radius * cos(angle);
            float y = center.y + radius * sin(angle);
            points[i] = new Point(x, y);
            angle = (angle + spacing) % TWO_PI;
        }
    }

    // Adjusts angle based on last mouse movement and places points
    void placePointsBasedOnMouse() {
        delta = (pmouseY - mouseY) / 500.0;
        angle = (angle + delta) % TWO_PI;
        placePoints();
    }

    void connectPoints (int gap) {
        int startingPoint = 0;
        int remainingConnections = points.length;
        
        while (remainingConnections > 0) {
            int currentPoint = startingPoint;
            int nextPoint = -1;

            while (nextPoint != startingPoint) {
                nextPoint = (currentPoint + gap) % points.length;
                points[currentPoint].connect(points[nextPoint]);

                remainingConnections--;
                currentPoint = nextPoint;
            }

            startingPoint += 1;
        }
    }

    Animation drawingAnimation (int frames) {
        AnimationQueue animation = new AnimationQueue();

        // Dot creating animations
        AnimationBatch pointsAnimation = new AnimationBatch();
        for (Point p : points) {
            pointsAnimation.addAnimation(new PointAnimation(center, p, frames));
        }
        animation.addAnimation(pointsAnimation);

        // Line connecting animations
        for (int gap : gaps) {
            animation.addAnimation(gapAnimation(gap, frames));
        }

        return animation;
    }

    Animation gapAnimation (int gap, int frames) {
        AnimationQueue animation = new AnimationQueue();

        int startingPoint = 0;
        int remainingConnections = points.length;
        
        while (remainingConnections > 0) {
            int currentPoint = startingPoint;
            int nextPoint = -1;

            while (nextPoint != startingPoint) {
                nextPoint = (currentPoint + gap) % points.length;

                Point p1 = points[currentPoint];
                Point p2 = points[nextPoint];
                animation.addAnimation(new LineAnimation(p1, p2, frames));

                remainingConnections--;
                currentPoint = nextPoint;
            }

            startingPoint += 1;
        }

        return animation;
    }

    void drawStellation() {
        placePointsBasedOnMouse();
        for (int gap : gaps) {
            connectPoints(gap);
        }
    }
}