<?php include("triangle.php"); ?>
<?php
$file = fopen("puzzle_input.txt", "r") or die("Unable to open file");
echo readHorizontally($file);
fclose($file);
echo "\n";
$file = fopen("puzzle_input.txt", "r") or die("Unable to open file");
echo readVertically($file);
fclose($file);

function readHorizontally($file) {
    $valid_count = 0;
    while(!feof($file)) {
        $line = fgets($file);
        $sides = preg_split('/\s+/', $line);
        $triangle = new triangle();
        $triangle->setSideOne($sides[1]);
        $triangle->setSideTwo($sides[2]);
        $triangle->setSideThree($sides[3]);
        $triangles[sizeof($triangles)] = $triangle;
        if ($triangle->isValid()) {
            $valid_count++;
        }
    }
    return $valid_count;
}

function readVertically($file) {
    $valid_count = 0;
    $total_count = 0;
    $triangle1 = new triangle();
    $triangle2 = new triangle();
    $triangle3 = new triangle();
    $pass = 1;
    while(!feof($file)) {
        $line = fgets($file);
        $sides = preg_split('/\s+/', $line);

        if ($pass == 1) {
            $triangle1->setSideOne($sides[1]);
            $triangle2->setSideOne($sides[2]);
            $triangle3->setSideOne($sides[3]);
            $pass++;
        } elseif ($pass == 2) {
            $triangle1->setSideTwo($sides[1]);
            $triangle2->setSideTwo($sides[2]);
            $triangle3->setSideTwo($sides[3]);
            $pass++;
        } elseif ($pass == 3) {
            $total_count += 3;
            $triangle1->setSideThree($sides[1]);
            $triangle2->setSideThree($sides[2]);
            $triangle3->setSideThree($sides[3]);
            $pass = 1;
            if ($triangle1->isValid()) {
                $valid_count++;
            }
            if ($triangle2->isValid()) {
                $valid_count++;
            }
            if ($triangle3->isValid()) {
                $valid_count++;
            }
        }
    }
    return $valid_count;
}