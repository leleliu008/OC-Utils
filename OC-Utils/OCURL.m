//http://blog.fpliu.com/it/data/text/coding/URL
//与Java中的java.net.URLEncoder实现相同

#import "OCURL.h"

@implementation OCURL

+ (NSString *) encodeWithNSString:(NSString *)input {
    return [OCURL encodeWithNSString:input isBlackCode2Plus:YES];
}

+ (NSString *) encodeWithNSString:(NSString *)input
               isBlackCode2Plus:(BOOL)isBlackCode2Plus {
    return [OCURL encodeWithNSString:input isBlackCode2Plus:isBlackCode2Plus toUpperCase:YES];
}

+ (NSString *) encodeWithNSString:(NSString *)input
               isBlackCode2Plus:(BOOL)isBlackCode2Plus
               toUpperCase:(BOOL)toUpperCase {
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    return [OCURL encodeWithNSData:data
                  isBlackCode2Plus:isBlackCode2Plus
                  toUpperCase:toUpperCase];
}

+ (NSString *) encodeWithNSString:(NSString *)input
               isBlackCode2Plus:(BOOL)isBlackCode2Plus
               toUpperCase:(BOOL)toUpperCase
               keep:(BOOL (^)(unichar))keep {
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    return [OCURL encodeWithNSData:data isBlackCode2Plus:isBlackCode2Plus toUpperCase:toUpperCase keep:keep];
}

+ (NSString*) encodeWithNSData:(NSData*)input {
    return [OCURL encodeWithNSData:input isBlackCode2Plus:YES toUpperCase:YES];
}

+ (NSString*) encodeWithNSData:(NSData*)input
              isBlackCode2Plus:(BOOL)isBlackCode2Plus {
    return [OCURL encodeWithNSData:input isBlackCode2Plus:isBlackCode2Plus toUpperCase:YES];
}

+ (NSString*) encodeWithNSData:(NSData*)input
              isBlackCode2Plus:(BOOL)isBlackCode2Plus
              toUpperCase:(BOOL)toUpperCase {
    return [OCURL encodeWithNSData:input
                  isBlackCode2Plus:isBlackCode2Plus
                  toUpperCase:toUpperCase
                  keep:^BOOL(unichar c) {
        return (c >= '0' && c <= '9') ||
        (c >= 'a' && c <= 'z') ||
        (c >= 'A' && c <= 'Z') ||
        c == '-' || c == '_' || c == '.' || c == '*';
    }];
}

+ (NSString*) encodeWithNSData:(NSData*)input
              isBlackCode2Plus:(BOOL)isBlackCode2Plus
              toUpperCase:(BOOL)toUpperCase
              keep:(BOOL (^)(unichar))keep {
    NSString *table = toUpperCase? @"0123456789ABCDEF" : @"0123456789abcdef";

    NSInteger inputLength = input.length;
    Byte *inputBytes = (Byte*)input.bytes;
    
    //以最坏的情况分配内存
    Byte outputBytes[3 * inputLength];
    NSInteger outputLength = 0;
    
    for (int i = 0; i < inputLength; i++) {
        unichar c = inputBytes[i];
        if (keep(c)) { //过滤掉安全字符（安全字符保持原样）
            outputBytes[outputLength++] = c;
        } else if (c == ' ' && isBlackCode2Plus) { //把空格编码成+
            outputBytes[outputLength++] = '+';
        } else {
            //向右移动4bit，获得高4bit
            NSInteger highByte = inputBytes[i] >> 4;
            //与0x0F做位与运算，获得低4bit
            NSInteger lowByte = inputBytes[i] & 0x0F;
            outputBytes[outputLength++] = '%';
            outputBytes[outputLength++] = [table characterAtIndex: highByte];
            outputBytes[outputLength++] = [table characterAtIndex: lowByte];
        }
    }
    NSData *data = [[NSData alloc] initWithBytes:outputBytes length:outputLength];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSString*) decodeToNSString:(NSString*)input {
    NSData *data = [OCURL decode:input];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSData *)decode:(NSString *)input {
    if (input) {
        NSInteger inputLength = input.length;
        NSInteger outputLength = 0;
        Byte outputBytes[inputLength];
        for (int i = 0; i < inputLength; i++) {
            unichar c = [input characterAtIndex:i];
            if (c == '%') {
                unichar c1 = [input characterAtIndex:++i];
                unichar c0 = [input characterAtIndex:++i];
                outputBytes[outputLength++] = ([OCURL hex2dec:c1] << 4) + [OCURL hex2dec:c0];
            } else if(c == '+') {
                outputBytes[outputLength++] = ' ';
            } else {
                outputBytes[outputLength++] = c;
            }
        }
        return [[NSData alloc] initWithBytes:outputBytes length:outputLength];
    }
    return nil;
}

//把16进制字符转换成10进制表示的数字
+ (NSInteger) hex2dec:(unichar) c {
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

@end
