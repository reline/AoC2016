#import <Foundation/Foundation.h>


@interface Bot : NSObject

@property (readonly) NSString *number;
@property (readonly) int lowChip;
@property NSString *lowTarget;
@property NSString *lowBotNumber;
@property (readonly) int highChip;
@property NSString *highTarget;
@property NSString *highBotNumber;
@property int output;

- (Bot *)initWithNumberAndValue:(NSString *)number chip:(int)aChip;
- (Bot *)initWithNumberAndInstructions:(NSString *)number lowTarget:(NSString *)lowTarget lowBotNum:(NSString *)lowNum highTarget:(NSString *)highTarget highBotNum:(NSString *)highNum;

- (void)receiveChip:(int)chip;
- (int)giveLowChip;
- (int)giveHighChip;

- (bool)hasTwoChips;

@end