#import <Foundation/Foundation.h>

@interface OCURL : NSObject

+ (NSString*) encodeWithNSString:(NSString*)input;

+ (NSString*) encodeWithNSString:(NSString*)input
              isBlackCode2Plus:(BOOL)isBlackCode2Plus;

+ (NSString*) encodeWithNSString:(NSString*)input
              isBlackCode2Plus:(BOOL)isBlackCode2Plus
              toUpperCase:(BOOL)toUpperCase;

+ (NSString*) encodeWithNSString:(NSString*)input
              isBlackCode2Plus:(BOOL)isBlackCode2Plus
              toUpperCase:(BOOL)toUpperCase
              keep:(BOOL (^)(unichar))keep;

+ (NSString*) encodeWithNSData:(NSData*)input;

+ (NSString*) encodeWithNSData:(NSData*)input
              isBlackCode2Plus:(BOOL)isBlackCode2Plus;

+ (NSString*) encodeWithNSData:(NSData*)input
              isBlackCode2Plus:(BOOL)isBlackCode2Plus
              toUpperCase:(BOOL)toUpperCase;

+ (NSString*) encodeWithNSData:(NSData*)input
              isBlackCode2Plus:(BOOL)isBlackCode2Plus
              toUpperCase:(BOOL)toUpperCase
              keep:(BOOL (^)(unichar))keep;

+ (NSData*) decode:(NSString*)input;

+ (NSString*) decodeToNSString:(NSString*)input;

@end
