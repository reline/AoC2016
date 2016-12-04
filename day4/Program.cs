using System;
using System.Text.RegularExpressions;

namespace SecurityThroughObscurity
{
    public class Program
    {
        public static void Main(string[] args)
        {
            string[] lines = System.IO.File.ReadAllLines(@"puzzle_input.txt");
            string pattern = @"(^.*)-(\d+)\[(.*)\]";
            Regex regex = new Regex(pattern);
            int sum = 0;
            foreach (string line in lines) {
                Match match = regex.Match(line);   
                string[] names = regex.GetGroupNames();
                Room room = new Room(match.Groups[names[1]].Value, Convert.ToInt32(match.Groups[names[2]].Value), match.Groups[names[3]].Value);
                if (room.isReal()) {
                    sum += room.getSectorId();
                    if (room.getDecryptedName().Contains("northpole")) {
                        System.Console.WriteLine(room.getSectorId());
                    }
                }
            }
            System.Console.WriteLine(Convert.ToString(sum));
        }
    }
}
