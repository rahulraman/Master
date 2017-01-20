//
//  Common.m
//  HTML Studio
//
//  Created by Do Quang Tri on 7/31/14.
//
//

#import "Common.h"

@implementation Common

+ (BOOL)isIpad {
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}

+ (UIImage *)getFileImage:(NSString *)extension {
    UIImage *image;
    if ([extension isEqualToString:@"html"] || [extension isEqualToString:@"htm"] || [extension isEqualToString:@"htc"]) {
        image = [UIImage imageNamed:@"HTMLFile"];
    }
    else if ([extension isEqualToString:@"php"] || [extension isEqualToString:@"js"]) {
        image = [UIImage imageNamed:@"JSPHPFile"];
    }
    else if ([extension isEqualToString:@"css"] || [extension isEqualToString:@"xml"] || [extension isEqualToString:@"scss"]) {
        image = [UIImage imageNamed:@"JSPHPFile"];
    }
    else if ([extension isEqualToString:@"jpg"] || [extension isEqualToString:@"png"] || [extension isEqualToString:@"gif"] || [extension isEqualToString:@"svg"]) {
        image = [UIImage imageNamed:@"MediaFile"];
    }
    else if ([extension isEqualToString:@"txt"] || [extension isEqualToString:@"rtf"] || [extension isEqualToString:@"otf"] || [extension isEqualToString:@"eot"] || [extension isEqualToString:@"ttf"] || [extension isEqualToString:@"woff"]) {
        image = [UIImage imageNamed:@"TXTFile"];
    }
    else {
        image = [UIImage imageNamed:@"File"];
    }
    return image;
}

@end
