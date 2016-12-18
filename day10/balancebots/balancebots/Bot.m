#import "Bot.h"


@implementation Bot

- (Bot *)initWithNumberAndValue:(NSString *)number chip:(int)aChip {
    _number = number;
    _lowChip = aChip;
    return self;
}

- (Bot *)initWithNumberAndInstructions:(NSString *)number lowTarget:(NSString *)lowTarget lowBotNum:(NSString *)lowNum highTarget:(NSString *)highTarget highBotNum:(NSString *)highNum {
    _number = number;
    _lowTarget = lowTarget;
    _lowBotNumber = lowNum;
    _highTarget = highTarget;
    _highBotNumber = highNum;
    return self;
}

- (void)receiveChip:(int)chip {
    if (_lowChip == 0) {
        _lowChip = chip;
    } else if (_lowChip > chip) {
        _highChip = _lowChip;
        _lowChip = chip;
    } else if (chip > _lowChip) {
        _highChip = chip;
    }
}

- (int)giveLowChip {
    int chip = _lowChip;
    _lowChip = 0;
    return chip;
}

- (int)giveHighChip {
    int chip = _highChip;
    _highChip = 0;
    return chip;
}

- (bool)hasTwoChips {
    return (_lowChip != 0 && _highChip != 0);
}

- (NSString *)description {
    return [NSString stringWithFormat: @"Bot %@ is responsible for comparing chip %d and chip %d", _number, _lowChip, _highChip];
}

@end