#import <Foundation/Foundation.h>

@interface OCURL : NSObject

+ (NSString*) encodeWithNSString:(NSString*)input;

+ (NSString*) encodeWithNSString:(NSString*)input toUpperCase:(BOOL)toUpperCase;

+ (NSString*) encodeWithNSString:(NSString*)input toUpperCase:(BOOL)toUpperCase filter:(BOOL (^)(unichar))filter;

+ (NSString*) encodeWithNSData:(NSData*)input;

+ (NSString*) encodeWithNSData:(NSData*)input toUpperCase:(BOOL)toUpperCase;

+ (NSString*) encodeWithNSData:(NSData*)input toUpperCase:(BOOL)toUpperCase filter:(BOOL (^)(unichar))filter;

+ (NSData*) decode:(NSString*)input;

+ (NSString*) decodeToNSString:(NSString*)input;

@end
