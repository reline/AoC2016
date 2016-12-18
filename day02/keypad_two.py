class KeypadTwo:
    def __init__(self, size, init_row, init_col):
        self.size = size
        self.current_row = init_row - 1
        self.current_col = init_col - 1
        self.diamond = []
        button = 1
        prev_row_size = 0
        for y in range(size * 2):
            if y == 0:
                continue
            row = []
            if y > size:
                x = prev_row_size - 2
            else:
                x = y * 2 - 1
            for i in range(x + 1):
                if i == 0:
                    continue
                prev_row_size = i
                row.append(button)
                button += 1
            self.diamond.append(row)
        self.set_key()

    def move(self, direction):
        if direction == 'U' and self.current_row > 0:
            next_row_size = len(self.diamond[self.current_row - 1])
            current_row_size = len(self.diamond[self.current_row])
            if next_row_size > current_row_size:
                self.current_row -= 1
                self.current_col += 1
            elif self.current_col != 0 and self.current_col != current_row_size - 1:
                self.current_row -= 1
                self.current_col -= 1
        elif direction == 'D' and self.current_row < len(self.diamond) - 1:
            next_row_size = len(self.diamond[self.current_row + 1])
            current_row_size = len(self.diamond[self.current_row])
            if next_row_size > current_row_size:
                self.current_row += 1
                self.current_col += 1
            elif self.current_col != 0 and self.current_col != current_row_size - 1:
                self.current_row += 1
                self.current_col -= 1
        elif direction == 'L' and self.current_col > 0:
            self.current_col -= 1
            pass
        elif direction == 'R' and self.current_col < len(self.diamond[self.current_row]) - 1:
            self.current_col += 1
            pass
        self.set_key()

    def set_key(self):
        self.current_key = self.diamond[self.current_row][self.current_col]

    # todo: dynamically print hex values
    def key(self):
        if self.current_key == 10:
            return 'A'
        elif self.current_key == 11:
            return 'B'
        elif self.current_key == 12:
            return 'C'
        elif self.current_key == 13:
            return 'D'
        else:
            return self.current_key

