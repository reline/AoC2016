#include <iostream>
#include <fstream>
#include <regex>

int is_tsl(std::string basic_string);

int is_ssl(std::string basic_string);

int main() {
    std::ifstream file;
    std::string line;

    file.open("puzzle_input.txt");
    if (file.is_open())
    {
        int tsl_count = 0;
        int ssl_count = 0;
        while (getline(file, line))
        {
            tsl_count += is_tsl(line);
            ssl_count += is_ssl(line);
        }
        file.close();

        printf("%d\n", tsl_count);
        printf("%d\n", ssl_count);
    }
    return 0;
}

int is_tsl(std::string line) {
    std::cmatch tls_matcher;
    std::regex tls_exp("(.)(.)\\2\\1.*?(\\n|\\]|\\[|$)");

    int tsl_match = false;
    while (std::regex_search(line.c_str(), tls_matcher, tls_exp))
    {
        tsl_match = tls_matcher.str(1) != tls_matcher.str(2) && tls_matcher.str(3) != "]";
        if (!tsl_match) break;
        line = tls_matcher.suffix();
    }
    return tsl_match;
}

int is_ssl(std::string line) {
    std::cmatch ssl_matcher;
    std::regex ssl_exp("(.)(.)\\1.*?(\\n|\\]|\\[|$)");
    std::string ssl_second_exp(".*?(\\n|\\[|\\]|$)");

    while (std::regex_search(line.c_str(), ssl_matcher, ssl_exp)) {
        std::string x = ssl_matcher.str(1);
        std::string y = ssl_matcher.str(2);
        std::string match_end_one = ssl_matcher.str(3);

        std::string original(line.c_str());

        if (x != y && x != "]" && x != "[" && y != "]" && y != "[") {

            std::string char_one = ssl_matcher.str(1).c_str();
            std::string char_two = ssl_matcher.str(2).c_str();
            std::string s = char_two + char_one + char_two + ssl_second_exp.c_str();
            std::regex exp(s.c_str());
            std::cmatch m;

            while (std::regex_search(line.c_str(), m, exp)) {
                std::string match_end_two = m.str(1);
                int ssl_match = (match_end_one == "]" || match_end_two == "]") && match_end_one != match_end_two;

                if (ssl_match) {
                    return ssl_match;
                }
                line = line.substr(1);
            }
        }
        line = original.c_str();
        line = line.substr(1);
    }
    return 0;
}
