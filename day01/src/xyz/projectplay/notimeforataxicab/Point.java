package xyz.projectplay.notimeforataxicab;

public class Point {

    int x;
    int y;

    public Point(int x, int y) {
        this.x = x;
        this.y = y;
    }

    @Override
    public boolean equals(Object obj) {
        if (!(obj instanceof Point)) {
            return false;
        }
        Point p = (Point) obj;
        return this.x == p.x && this.y == p.y;
    }
    
    public int getAbsoluteDistance() {
        return Math.abs(x) + Math.abs(y);
    }
}
