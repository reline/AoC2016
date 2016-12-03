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

    @Override
    public int hashCode() {
        int a = biject(x);
        int b = biject(y);
        return 1/2*(a + b)*(a + b + 1) + b;
    }

    public int getAbsoluteDistance() {
        return Math.abs(x) + Math.abs(y);
    }

    private int biject(int z) {
        return z >= 0 ? z * 2 : -z * 2 - 1;
    }
}
