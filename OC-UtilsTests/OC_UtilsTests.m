#import <XCTest/XCTest.h>
#import "OCURL.h"
#import "OCBase16.h"

@interface OC_UtilsTests : XCTestCase

@end

@implementation OC_UtilsTests

//http://tool.chinaz.com/tools/urlencode.aspx

- (void)testOCURLEncode1 {
    NSString *str = @"http://blog.fpliu.com/a-b_+* haha中国";
    NSString *urlEncodedStr = [OCURL encodeWithNSString:str];
    XCTAssertTrue([@"http%3A%2F%2Fblog.fpliu.com%2Fa-b_%2B*+haha%E4%B8%AD%E5%9B%BD" isEqualToString: urlEncodedStr]);
}

- (void)testOCURLEncode2 {
    NSString *str = @"http://blog.fpliu.com/a-b_+* haha中国";
    NSString *urlEncodedStr = [OCURL encodeWithNSString:str toUpperCase:NO];
    XCTAssertTrue([@"http%3a%2f%2fblog.fpliu.com%2fa-b_%2b*+haha%e4%b8%ad%e5%9b%bd" isEqualToString: urlEncodedStr]);
}

- (void)testOCURLEncode3 {
    NSString *str = @"http://blog.fpliu.com/a-b_+* haha中国";
    NSString *urlEncodedStr = [OCURL encodeWithNSString:str toUpperCase:NO filter:^BOOL(unichar c) {
        return YES;
    }];
    XCTAssertTrue([str isEqualToString: urlEncodedStr]);
}

- (void)testOCURLDecode {
    NSString *str = @"http%3a%2f%2fblog.fpliu.com%2fa-b_%2b*+haha%e4%b8%ad%e5%9b%bd";
    NSData *urlDecodedData = [OCURL decode:str];
    NSString *urlDecodedStr = [[NSString alloc] initWithData:urlDecodedData encoding:NSUTF8StringEncoding];
    XCTAssertTrue([@"http://blog.fpliu.com/a-b_+* haha中国" isEqualToString: urlDecodedStr]);
}

- (void)testOCURLDecodeToNSString {
    NSString *str = @"http%3a%2f%2fblog.fpliu.com%2fa-b_%2b*+haha%e4%b8%ad%e5%9b%bd";
    NSString *urlDecodedStr = [OCURL decodeToNSString:str];
    XCTAssertTrue([@"http://blog.fpliu.com/a-b_+* haha中国" isEqualToString: urlDecodedStr]);
}

//https://www.qqxiuzi.cn/bianma/base.php?type=16

- (void)testBase16EncodeWithNSDataToUpperCase {
    NSString *str = @"中国";
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base16EncodedStr = [OCBase16 encodeWithNSData:data];
    XCTAssertTrue([@"E4B8ADE59BBD" isEqualToString: base16EncodedStr]);
}

- (void)testBase16EncodeWithNSDataToLowerCase {
    NSString *str = @"中国";
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base16EncodedStr = [OCBase16 encodeWithNSData:data toUpperCase:NO];
    XCTAssertTrue([@"e4b8ade59bbd" isEqualToString: base16EncodedStr]);
}

- (void)testBase16Decode1 {
    NSString *str = @"E4B8ADE59BBD";
    NSData *base16DecodedData = [OCBase16 decodeWithNSString:str];
    NSString *base16DecodedStr = [[NSString alloc] initWithData:base16DecodedData encoding:NSUTF8StringEncoding];
    XCTAssertTrue([@"中国" isEqualToString: base16DecodedStr]);
}

- (void)testBase16Decode2 {
    NSString *str = @"e4b8ade59bbd";
    NSData *base16DecodedData = [OCBase16 decodeWithNSString:str];
    NSString *base16DecodedStr = [[NSString alloc] initWithData:base16DecodedData encoding:NSUTF8StringEncoding];
    XCTAssertTrue([@"中国" isEqualToString: base16DecodedStr]);
}

- (void)testBase16Decode3 {
    NSString *str = @"E4B8ADE59bbd";
    NSData *base16DecodedData = [OCBase16 decodeWithNSString:str];
    NSString *base16DecodedStr = [[NSString alloc] initWithData:base16DecodedData encoding:NSUTF8StringEncoding];
    XCTAssertTrue([@"中国" isEqualToString: base16DecodedStr]);
}

@end
