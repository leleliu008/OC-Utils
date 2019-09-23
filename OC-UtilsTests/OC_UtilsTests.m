#import <XCTest/XCTest.h>
#import "OCURL.h"
#import "OCBase16.h"

@interface OC_UtilsTests : XCTestCase

@end

@implementation OC_UtilsTests

//http://tool.chinaz.com/tools/urlencode.aspx

- (void)testOCURLEncode1 {
    XCTAssertTrue([@"http%3A%2F%2Fblog.fpliu.com%2Fa-b_%2B*+haha%E4%B8%AD%E5%9B%BD" isEqualToString: [OCURL encodeWithNSString:@"http://blog.fpliu.com/a-b_+* haha中国"]]);
    XCTAssertTrue([@"%E5%8D%8E%E4%B8%BA%E6%96%B9%E8%88%9F%E7%BC%96%E8%AF%91%E5%99%A8" isEqualToString: [OCURL encodeWithNSString:@"华为方舟编译器"]]);
    XCTAssertTrue([@"%E7%B5%A6%E9%BB%9E%E9%99%BD%E5%85%89%E6%88%91%E5%B0%B1%E8%85%90%E7%88%9B" isEqualToString: [OCURL encodeWithNSString:@"給點陽光我就腐爛"]]);
    
    XCTAssertTrue([@"0.5" isEqualToString: [OCURL encodeWithNSString:@"0.5"]]);
    
    XCTAssertTrue([@"%F0%9F%98%80%F0%9F%98%80%F0%9F%98%80%F0%9F%98%82%F0%9F%98%82" isEqualToString: [OCURL encodeWithNSString:@"😀😀😀😂😂"]]);
    
    XCTAssertTrue([@"%F0%9F%94%A5%F0%9F%8D%89haha" isEqualToString: [OCURL encodeWithNSString:@"🔥🍉haha"]]);
    
    XCTAssertTrue([@"welcome%20to%20%E4%B8%AD%E5%9B%BD" isEqualToString: [OCURL encodeWithNSString:@"welcome to 中国" isBlackCode2Plus:NO]]);
    
    XCTAssertTrue([@"%E3%81%93%E3%82%93%E3%81%AB%E3%81%A1%E3%81%AF%F0%9F%92%AF" isEqualToString: [OCURL encodeWithNSString:@"こんにちは💯"]]);
}

- (void)testOCURLEncode2 {
    NSString *str = @"http://blog.fpliu.com/a-b_+* haha中国";
    NSString *urlEncodedStr = [OCURL encodeWithNSString:str isBlackCode2Plus:YES toUpperCase:NO];
    XCTAssertTrue([@"http%3a%2f%2fblog.fpliu.com%2fa-b_%2b*+haha%e4%b8%ad%e5%9b%bd" isEqualToString: urlEncodedStr]);
}

- (void)testOCURLEncode3 {
    NSString *str = @"http://blog.fpliu.com/a-b_+* haha中国";
    NSString *urlEncodedStr = [OCURL encodeWithNSString:str
                                    isBlackCode2Plus:YES
                                    toUpperCase:NO
                                    keep:^BOOL(unichar c) {
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
    XCTAssertTrue([@"E4B8ADE59BBD" isEqualToString: [OCBase16 encodeWithNSData:[@"中国" dataUsingEncoding:NSUTF8StringEncoding] toUpperCase:YES]]);
    
    XCTAssertTrue([@"30" isEqualToString:[OCBase16 encodeWithNSData:[@"0" dataUsingEncoding:NSUTF8StringEncoding] toUpperCase:YES]]);
    
    XCTAssertTrue([@"302E35" isEqualToString:[OCBase16 encodeWithNSData:[@"0.5" dataUsingEncoding:NSUTF8StringEncoding] toUpperCase:YES]]);
    
    XCTAssertTrue([@"E7B5A6E9BB9EE999BDE58589E68891E5B0B1E88590E7889B" isEqualToString:[OCBase16 encodeWithNSData:[@"給點陽光我就腐爛" dataUsingEncoding:NSUTF8StringEncoding] toUpperCase:YES]]);
    
    XCTAssertTrue([@"F09F9880F09F9880F09F9880F09F9882F09F9882" isEqualToString:[OCBase16 encodeWithNSData:[@"😀😀😀😂😂" dataUsingEncoding:NSUTF8StringEncoding] toUpperCase:YES]]);
    
    XCTAssertTrue([@"F09F94A5F09F8D8968616861" isEqualToString:[OCBase16 encodeWithNSData:[@"🔥🍉haha" dataUsingEncoding:NSUTF8StringEncoding] toUpperCase:YES]]);
    
    XCTAssertTrue([@"77656C636F6D6520746F20E4B8ADE59BBD" isEqualToString:[OCBase16 encodeWithNSData:[@"welcome to 中国" dataUsingEncoding:NSUTF8StringEncoding] toUpperCase:YES]]);
    
   XCTAssertTrue([@"E38193E38293E381ABE381A1E381AFF09F92AF" isEqualToString:[OCBase16 encodeWithNSData:[@"こんにちは💯" dataUsingEncoding:NSUTF8StringEncoding] toUpperCase:YES]]);
}

- (void)testBase16EncodeWithNSDataToLowerCase {
    XCTAssertTrue([@"e4b8ade59bbd" isEqualToString: [OCBase16 encodeWithNSData:[@"中国" dataUsingEncoding:NSUTF8StringEncoding] toUpperCase:NO]]);
     
     XCTAssertTrue([@"30" isEqualToString:[OCBase16 encodeWithNSData:[@"0" dataUsingEncoding:NSUTF8StringEncoding] toUpperCase:NO]]);
     
     XCTAssertTrue([@"302e35" isEqualToString:[OCBase16 encodeWithNSData:[@"0.5" dataUsingEncoding:NSUTF8StringEncoding] toUpperCase:NO]]);
     
     XCTAssertTrue([@"e7b5a6e9bb9ee999bde58589e68891e5b0b1e88590e7889b" isEqualToString:[OCBase16 encodeWithNSData:[@"給點陽光我就腐爛" dataUsingEncoding:NSUTF8StringEncoding] toUpperCase:NO]]);
     
     XCTAssertTrue([@"f09f9880f09f9880f09f9880f09f9882f09f9882" isEqualToString:[OCBase16 encodeWithNSData:[@"😀😀😀😂😂" dataUsingEncoding:NSUTF8StringEncoding] toUpperCase:NO]]);
     
     XCTAssertTrue([@"f09f94a5f09f8d8968616861" isEqualToString:[OCBase16 encodeWithNSData:[@"🔥🍉haha" dataUsingEncoding:NSUTF8StringEncoding] toUpperCase:NO]]);
     
     XCTAssertTrue([@"77656c636f6d6520746f20e4b8ade59bbd" isEqualToString:[OCBase16 encodeWithNSData:[@"welcome to 中国" dataUsingEncoding:NSUTF8StringEncoding] toUpperCase:NO]]);
     
    XCTAssertTrue([@"e38193e38293e381abe381a1e381aff09f92af" isEqualToString:[OCBase16 encodeWithNSData:[@"こんにちは💯" dataUsingEncoding:NSUTF8StringEncoding] toUpperCase:NO]]);
}

- (void)testBase16Decode1 {
    XCTAssertTrue([@"中国" isEqualToString: [[NSString alloc] initWithData:[OCBase16 decodeWithNSString:@"E4B8ADE59BBD"] encoding:NSUTF8StringEncoding]]);
    
    XCTAssertTrue([@"0" isEqualToString: [[NSString alloc] initWithData:[OCBase16 decodeWithNSString:@"30"] encoding:NSUTF8StringEncoding]]);
    
    XCTAssertTrue([@"0.5" isEqualToString: [[NSString alloc] initWithData:[OCBase16 decodeWithNSString:@"302E35"] encoding:NSUTF8StringEncoding]]);
    
    XCTAssertTrue([@"給點陽光我就腐爛" isEqualToString: [[NSString alloc] initWithData:[OCBase16 decodeWithNSString:@"E7B5A6E9BB9EE999BDE58589E68891E5B0B1E88590E7889B"] encoding:NSUTF8StringEncoding]]);
       
    XCTAssertTrue([@"😀😀😀😂😂" isEqualToString: [[NSString alloc] initWithData:[OCBase16 decodeWithNSString:@"F09F9880F09F9880F09F9880F09F9882F09F9882"] encoding:NSUTF8StringEncoding]]);

    XCTAssertTrue([@"🔥🍉haha" isEqualToString: [[NSString alloc] initWithData:[OCBase16 decodeWithNSString:@"F09F94A5F09F8D8968616861"] encoding:NSUTF8StringEncoding]]);
       
    XCTAssertTrue([@"welcome to 中国" isEqualToString: [[NSString alloc] initWithData:[OCBase16 decodeWithNSString:@"77656C636F6D6520746F20E4B8ADE59BBD"] encoding:NSUTF8StringEncoding]]);
    
    XCTAssertTrue([@"こんにちは💯" isEqualToString: [[NSString alloc] initWithData:[OCBase16 decodeWithNSString:@"E38193E38293E381ABE381A1E381AFF09F92AF"] encoding:NSUTF8StringEncoding]]);
}

- (void)testBase16Decode2 {
   XCTAssertTrue([@"中国" isEqualToString: [[NSString alloc] initWithData:[OCBase16 decodeWithNSString:@"e4b8ade59bbd"] encoding:NSUTF8StringEncoding]]);
    
    XCTAssertTrue([@"0" isEqualToString: [[NSString alloc] initWithData:[OCBase16 decodeWithNSString:@"30"] encoding:NSUTF8StringEncoding]]);
    
    XCTAssertTrue([@"0.5" isEqualToString: [[NSString alloc] initWithData:[OCBase16 decodeWithNSString:@"302e35"] encoding:NSUTF8StringEncoding]]);
    
    XCTAssertTrue([@"給點陽光我就腐爛" isEqualToString: [[NSString alloc] initWithData:[OCBase16 decodeWithNSString:@"e7b5a6e9bb9ee999bde58589e68891e5b0b1e88590e7889b"] encoding:NSUTF8StringEncoding]]);
       
    XCTAssertTrue([@"😀😀😀😂😂" isEqualToString: [[NSString alloc] initWithData:[OCBase16 decodeWithNSString:@"f09f9880f09f9880f09f9880f09f9882f09f9882"] encoding:NSUTF8StringEncoding]]);

    XCTAssertTrue([@"🔥🍉haha" isEqualToString: [[NSString alloc] initWithData:[OCBase16 decodeWithNSString:@"f09f94a5f09f8d8968616861"] encoding:NSUTF8StringEncoding]]);
       
    XCTAssertTrue([@"welcome to 中国" isEqualToString: [[NSString alloc] initWithData:[OCBase16 decodeWithNSString:@"77656c636f6d6520746f20e4b8ade59bbd"] encoding:NSUTF8StringEncoding]]);
    
    XCTAssertTrue([@"こんにちは💯" isEqualToString: [[NSString alloc] initWithData:[OCBase16 decodeWithNSString:@"e38193e38293e381abe381a1e381aff09f92af"] encoding:NSUTF8StringEncoding]]);
}

- (void)testBase16Decode3 {
    XCTAssertTrue([@"中国" isEqualToString: [[NSString alloc] initWithData:[OCBase16 decodeWithNSString:@"E4B8ADE59bbd"] encoding:NSUTF8StringEncoding]]);
}

@end
