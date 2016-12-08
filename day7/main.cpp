#include <iostream>
#include <fstream>
#include <regex>

int main() {
    std::ifstream file;
    std::string line;
    std::cmatch res;
    std::regex exp("(.)(.)\\2\\1.*?(\\n|\\]|\\[|$)");

    file.open("puzzle_input.txt");
    if (file.is_open())
    {
        int c = 0;
        while (getline(file, line))
        {
            int m = false;
            while (std::regex_search(line.c_str(), res, exp))
            {
                m = res.str(1) != res.str(2) && res.str(3) != "]";
                if (!m) break;
                line = res.suffix();
            }
            c+=m;
        }
        file.close();
        printf("%d\n", c);
    }
    return 0;
}