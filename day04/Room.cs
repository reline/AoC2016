using System;
using System.Linq;
using System.Collections.Generic;
using System.Text;

namespace SecurityThroughObscurity
{
    public class Room 
    {
        private string encryptedName;
        private int sectorId;
        private string checksum;
        public Room(string encryptedName, int sectorId, string checksum)
        {
            this.encryptedName = encryptedName;
            this.sectorId = sectorId;
            this.checksum = checksum;
        }

        public int getSectorId() 
        {
            return sectorId;
        }

        // A room is real (not a decoy) if the checksum is the five most common letters in the encrypted name, in order, with ties broken by alphabetization
        public bool isReal()
        {
            Dictionary<char, int> dictionary = new Dictionary<char, int>();
            foreach (char c in encryptedName) {
                if (!c.Equals('-')) {
                    if (dictionary.ContainsKey(c)) {
                        dictionary[c]++;
                    } else {
                        dictionary.Add(c, 1);
                    }
                }
            }
            if (dictionary.Keys.Count >= 5) {
                var sortedDictByChar = from entry in dictionary orderby entry.Key ascending select entry;
                var sortedDictByOccurences = from entry in sortedDictByChar orderby entry.Value descending select entry;
                StringBuilder generatedChecksum = new StringBuilder();
                int i = 0;
                foreach (KeyValuePair<char, int> pair in sortedDictByOccurences) {
                    if (i >= 5) {
                        break;
                    } else {
                        generatedChecksum.Append(pair.Key);
                        i++;
                    }
                }
                return checksum.Equals(generatedChecksum.ToString());
            }
            return false;
        }

        public string getDecryptedName()
        {
            int increment = sectorId % 26;
            StringBuilder decryptedName = new StringBuilder();
            foreach (char c in encryptedName) {
                if (c.Equals('-')) {
                    decryptedName.Append(' ');
                } else {
                    char x = (Char)(Convert.ToUInt16(c) + increment);
                    if (x > 'z') {
                        x = (Char)(Convert.ToUInt16(x) - 26);
                    }
                    decryptedName.Append(x);
                }
            }
            return decryptedName.ToString();
        }
    }
}