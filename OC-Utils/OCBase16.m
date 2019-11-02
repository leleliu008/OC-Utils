//http://blog.fpliu.com/it/data/text/coding/Base16

#import "OCBase16.h"

@implementation OCBase16

+ (NSString*)encodeWithNSData:(NSData*)data {
    return [OCBase16 encodeWithNSData:data toUpperCase:YES];
}

+ (NSString*)encodeWithNSData:(NSData*)data toUpperCase:(BOOL)toUpperCase {
    NSString *table = toUpperCase? @"0123456789ABCDEF" : @"0123456789abcdef";
    
    Byte *inputBytes = (Byte*)[data bytes];
    NSInteger inputLength = data.length;
    
    NSInteger outputLength = inputLength << 1;
    Byte outputBytes[outputLength];
    
    for (int i = 0; i < inputLength; i++) {
        //向右移动4bit，获得高4bit
        NSInteger highByte = inputBytes[i] >> 4;
        //与0x0F做位与运算，获得低4bit
        NSInteger lowByte  = inputBytes[i] & 0x0F;
        int j = i << 1;
        outputBytes[j]     = [table characterAtIndex: highByte];
        outputBytes[j + 1] = [table characterAtIndex: lowByte];
    }
    
    NSData *outputData = [[NSData alloc] initWithBytes:outputBytes length:outputLength];
    return [[NSString alloc] initWithData:outputData
                                 encoding:(NSUTF8StringEncoding)];
}

//把16进制字符转换成10进制表示的数字
+ (NSInteger) hex2dec:(unichar)c {
    if ('0' <= c && c <= '9') {
        return c - '0';
    } else if ('a' <= c && c <= 'f') {
        return c - 'a' + 10;
    } else if ('A' <= c && c <= 'F') {
        return c - 'A' + 10;
    } else {
        return 0;
    }
}

//input指向的字符串长度必须是2的整数倍
+ (NSData*)decodeWithNSString:(NSString*)input {
    if (input) {
        NSInteger inputLength = input.length;
        NSInteger halfInputLength = inputLength >> 1;
        Byte outputBytes[halfInputLength];
        for (int i = 0; i < halfInputLength; i++) {
            int j = i << 1;
            unichar c1 = [input characterAtIndex:j];
            unichar c0 = [input characterAtIndex:j + 1];
            //16进制数字转换为10进制数字的过程
            outputBytes[i] = ([OCBase16 hex2dec:c1] << 4) + [OCBase16 hex2dec:c0];
        }
        return [[NSData alloc] initWithBytes:outputBytes length:halfInputLength];
    }
    return nil;
}

@end
