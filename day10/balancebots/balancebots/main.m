#import <Foundation/Foundation.h>
#import "Bot.h"

NSString *readline(FILE *pFILE);
bool findNextBot();
void giveAwayChips(Bot* bot);

NSMutableDictionary *bots;

int main(int argc, const char * argv[]) {
    bots = [NSMutableDictionary dictionary];
    FILE *file = fopen("puzzle_input.txt", "r");
    NSError *error1;
    NSRegularExpression *goesToRegex = [NSRegularExpression
            regularExpressionWithPattern:@"value ([0-9]+) goes to bot ([0-9]+)"
                                 options:0 error:&error1];
    NSError *error2;
    NSRegularExpression *givesRegex = [NSRegularExpression
            regularExpressionWithPattern:@"bot ([0-9]+) gives low to ([a-z]+) ([0-9]+) and high to ([a-z]+) ([0-9]+)"
                                 options:0 error:&error2];

    // bot 97 gets two chips first
    while (!feof(file)) {
        NSString *line = readline(file);
        NSArray *matches = [goesToRegex
                matchesInString:line
                        options:0
                          range:NSMakeRange(0, [line length])];

        if ([matches count] > 0) {
            NSString *chip = [line substringWithRange:[matches[0] rangeAtIndex:1]];
            NSString *number = [line substringWithRange:[matches[0] rangeAtIndex:2]];

            Bot *oldBot = bots[number];
            if (oldBot == nil) {
                Bot *bot = [[Bot alloc] initWithNumberAndValue:number chip:[chip intValue]];
                bots[number] = bot;
            } else {
                [oldBot receiveChip:[chip intValue]];
            }
        } else {
            NSArray *m = [givesRegex
                    matchesInString:line
                            options:0
                              range:NSMakeRange(0, [line length])];

            if ([m count] > 0) {
                NSString *botNumber = [line substringWithRange:[m[0] rangeAtIndex:1]];
                NSString *lowTarget = [line substringWithRange:[m[0] rangeAtIndex:2]];
                NSString *lowTargetNumber = [line substringWithRange:[m[0] rangeAtIndex:3]];
                NSString *highTarget = [line substringWithRange:[m[0] rangeAtIndex:4]];
                NSString *highTargetNumber = [line substringWithRange:[m[0] rangeAtIndex:5]];

                Bot *oldBot = bots[botNumber];
                if (oldBot == nil) {
                    Bot *bot = [[Bot alloc]
                            initWithNumberAndInstructions:botNumber
                                                lowTarget:lowTarget
                                                lowBotNum:lowTargetNumber
                                               highTarget:highTarget
                                               highBotNum:highTargetNumber];
                    bots[botNumber] = bot;
                } else {
                    oldBot.lowTarget = lowTarget;
                    oldBot.lowBotNumber = lowTargetNumber;
                    oldBot.highTarget = highTarget;
                    oldBot.highBotNumber = highTargetNumber;
                }
            }
        }
    }

    while (findNextBot()) {}
    printf("Output 0 * Output 1 * Output 2 = %d\n", [bots[@"0"] output] * [bots[@"1"] output] * [bots[@"2"] output]);
    return 0;
}

bool findNextBot() {
    for (Bot* botNumber in bots) {
        Bot* bot = bots[botNumber];
        if ([bot hasTwoChips]) {
            giveAwayChips(bot);
            return true;
        }
    }
    return false;
}

void giveAwayChips(Bot *bot) {
    if (bot.lowChip == 17 && bot.highChip == 61) {
        printf("%s\n", [[bot description] UTF8String]);
    }

    Bot* lowBot = bots[[bots[bot.number] lowBotNumber]];
    if ([bot.lowTarget isEqualToString:@"bot"]) {
        [lowBot receiveChip:[bot giveLowChip]];
        if ([lowBot hasTwoChips]) {
            giveAwayChips(lowBot);
        }
    } else if ([bot.lowTarget isEqualToString:@"output"]){
        lowBot.output = [bot giveLowChip];
    }

    Bot* highBot = bots[[bots[bot.number] highBotNumber]];
    if ([bot.highTarget isEqualToString:@"bot"]) {
        [highBot receiveChip:[bot giveHighChip]];
        if ([highBot hasTwoChips]) {
            giveAwayChips(highBot);
        }
    } else if ([bot.highTarget isEqualToString:@"output"]){
        highBot.output = [bot giveHighChip];
    }
}

NSString *readline(FILE *pFILE) {
    char buffer[8192];
    NSMutableString *s = [NSMutableString stringWithCapacity:512];
    int i;
    do
    {
        if (fscanf(pFILE, "%8191[^\n]%n%*c", buffer, &i) == 1)
            [s appendFormat:@"%s", buffer];
        else
            break;
    } while (i == 8192);
    return s;
}
