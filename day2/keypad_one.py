class KeypadOne:
    def __init__(self, vertical_keys, horizontal_keys, initial_key):
        self.current_key = initial_key
        self.vertical_keys = vertical_keys
        self.horizontal_keys = horizontal_keys

    def move(self, direction):
        if direction == 'U' and self.current_key > self.horizontal_keys:
            self.current_key -= self.horizontal_keys
        elif direction == 'D' and self.current_key <= self.horizontal_keys * self.vertical_keys - self.horizontal_keys:
            self.current_key += self.horizontal_keys
        elif direction == 'L' and self.current_key % self.horizontal_keys != 1:
            self.current_key -= 1
        elif direction == 'R' and self.current_key % self.horizontal_keys > 0:
            self.current_key += 1
