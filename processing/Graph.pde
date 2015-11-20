class Point {
    float x;
    float y;

    Point(float _x, float _y) {
        x = _x;
        y = _y;
    }

    void connect(Point p) {
        line(x, y, p.x, p.y);
    }
}

class Graph {
    Point center;
    float radius;
    Point[] points;
    float angle;
    float spacing;
    float delta = 0;
    int[] gaps;

    Graph (float x, float y) {
        center = new Point(x, y);
        radius = random(100, 200);
        int numPoints = floor(random(15, 26));
        spacing = TWO_PI / numPoints;
        angle = 0.0;
        points = new Point[numPoints];

        int cycles = floor(random(3, 5));
        gaps = new int[cycles];
        for (int i = 0; i < cycles; i++) {
            gaps[i] = floor(random(2, 12));
        }
    }

    void placePoints() {
        delta = (pmouseY - mouseY) / 500.0;
        angle = (angle + delta) % TWO_PI;
        for (int i = 0; i < points.length; ++i) {
            float x = center.x + radius * cos(angle);
            float y = center.y + radius * sin(angle);
            points[i] = new Point(x, y);
            angle = (angle + spacing) % TWO_PI;
        }
    }

    void connectPoints (int gap) {
        int startingPoint = 0;
        int remainingConnections = points.length;
        
        while (remainingConnections > 0) {
            int currentPoint = startingPoint;
            int nextPoint = -1;

            while (remainingConnections > 0 && nextPoint != startingPoint) {
                nextPoint = (currentPoint + gap) % points.length;
                points[currentPoint].connect(points[nextPoint]);

                remainingConnections--;
                currentPoint = nextPoint;
            }

            startingPoint += 1;
        }
    }

    void drawGraph() {
        placePoints();
        for (int i = 0; i < gaps.length; ++i) {
            connectPoints(gaps[i]);
        }
    }
}