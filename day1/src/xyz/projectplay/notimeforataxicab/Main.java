package xyz.projectplay.notimeforataxicab;

import java.util.ArrayList;

public class Main {
    private static final String puzzleInput = "R5, R4, R2, L3, R1, R1, L4, L5, R3, L1, L1, R4, L2, R1, R4, R4, L2, L2, R4, L4, R1, R3, L3, L1, L2, R1, R5, L5, L1, L1, R3, R5, L1, R4, L5, R5, R1, L185, R4, L1, R51, R3, L2, R78, R1, L4, R188, R1, L5, R5, R2, R3, L5, R3, R4, L1, R2, R2, L4, L4, L5, R5, R4, L4, R2, L5, R2, L1, L4, R4, L4, R2, L3, L4, R2, L3, R3, R2, L2, L3, R4, R3, R1, L4, L2, L5, R4, R4, L1, R1, L5, L1, R3, R1, L2, R1, R1, R3, L4, L1, L3, R2, R4, R2, L2, R1, L5, R3, L3, R3, L1, R4, L3, L3, R4, L2, L1, L3, R2, R3, L2, L1, R4, L3, L5, L2, L4, R1, L4, L4, R3, R5, L4, L1, L1, R4, L2, R5, R1, R1, R2, R1, R5, L1, L3, L5, R2";
    private static ArrayList<Point> points = new ArrayList<>();
    private static int repeatPointDistance = 0;
    private static boolean foundRepeatPoint = false;

    enum CardinalDirection {
        NORTH, EAST, SOUTH, WEST;

        CardinalDirection turnRight() {
            if (this == NORTH) {
                return EAST;
            } else if (this == EAST) {
                return SOUTH;
            } else if (this == SOUTH) {
                return WEST;
            } else {
                return NORTH;
            }
        }

        CardinalDirection turnLeft() {
            if (this == WEST) {
                return SOUTH;
            } else if (this == SOUTH) {
                return EAST;
            } else if (this == EAST) {
                return NORTH;
            } else {
                return WEST;
            }
        }
    }

    public static void main(String[] args) {
        int answerOne = solve();
        int answerTwo = repeatPointDistance;

        System.out.println("Answer One: " + String.valueOf(answerOne));
        System.out.println("Answer Two: " + String.valueOf(answerTwo));
    }

    private static int solve() {
        Point currentPoint = new Point(0, 0);
        points.add(currentPoint);
        CardinalDirection facing = CardinalDirection.NORTH;
        String[] directions = puzzleInput.split(", ");
        for (String direction : directions) {
            if (direction.contains("R")) {
                facing = facing.turnRight();
            } else {
                facing = facing.turnLeft();
            }
            int y = currentPoint.y;
            int x = currentPoint.x;
            int distanceTraveled = Integer.parseInt(direction.substring(1));
            distanceTraveled = facing == CardinalDirection.WEST || facing == CardinalDirection.SOUTH ? -distanceTraveled : distanceTraveled;
            for (int i = Math.abs(distanceTraveled); i > 0; i--) {
                if (facing == CardinalDirection.NORTH || facing == CardinalDirection.SOUTH) {
                    y += distanceTraveled < 0 ? -1 : 1;
                } else {
                    x += distanceTraveled < 0 ? -1 : 1;
                }
                currentPoint = new Point(x, y);
                if (!foundRepeatPoint) {
                    for (Point p : points) {
                        if (currentPoint.equals(p)) {
                            repeatPointDistance = currentPoint.getAbsoluteDistance();
                            foundRepeatPoint = true;
                        }
                    }
                    points.add(currentPoint);
                }
            }
        }
        return currentPoint.getAbsoluteDistance();
    }
}
