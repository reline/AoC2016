<?php

class triangle
{
    private $side_one;
    private $side_two;
    private $side_three;

    public function setSideOne($side_one)
    {
        $this->side_one = $side_one;
    }

    public function setSideTwo($side_two)
    {
        $this->side_two = $side_two;
    }

    public function setSideThree($side_three)
    {
        $this->side_three = $side_three;
    }

    public function isValid() {
        return $this->side_one + $this->side_two > $this->side_three &&
        $this->side_one + $this->side_three > $this->side_two &&
        $this->side_two + $this->side_three > $this->side_one;
    }
}
