# OC-Utils
Objective-C Common Use Utils

## Usage
1、Add the following code to `Podfile` in your project:

```
pod 'OC-Utils', '~> 1.0.0'
```

2、Execute the following command to install this lib:

```
pod install
```

## Base16

1、import `OCBase16.h` header:

``` objective-c
#import "OCBase16.h"
```
2、Base16 Encode to UpperCase:
``` objective-c
NSString *str = @"中国";
NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
NSString *base16EncodedStr = [OCBase16 encodeWithNSData:data];
```
3、Base16 Encode to LowerCase:
``` objective-c
NSString *str = @"中国";
NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
NSString *base16EncodedStr2 = [OCBase16 encodeWithNSData:data toUpperCase:NO];
```
4、Base16 Decode Usage:
``` objective-c
NSString *str = @"4142434445";
NSData *data = [OCBase16 decodeWithNSString:str];
```

## License

OC-Utils is available under the MIT license. See the LICENSE file for more info.
