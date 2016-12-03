from keypad_one import KeypadOne
from keypad_two import KeypadTwo

keypad_one = KeypadOne(3, 3, 5)
keypad_two = KeypadTwo(3, 3, 1)

code_one = []
code_two = []

with open('puzzle_input.txt', 'r') as f:
    for line in f:
        for char in line:
            keypad_one.move(char)
            keypad_two.move(char)
        code_one.append(keypad_one.current_key)
        code_two.append(keypad_two.key())

print code_one
print code_two
