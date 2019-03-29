#import <Foundation/Foundation.h>

@interface OCBase16 : NSObject

+ (NSString*) encodeWithNSData:(NSData*)data;

+ (NSString*) encodeWithNSData:(NSData*)data toUpperCase:(BOOL)toUpperCase;

+ (NSData*) decodeWithNSString:(NSString*)input;

@end
