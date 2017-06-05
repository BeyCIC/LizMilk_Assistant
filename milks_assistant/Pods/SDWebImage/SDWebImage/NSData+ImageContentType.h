//
// Create by JasonHuang on 06/01/14.
//  爱你一生一世 刘磊璐
// Copyright (c) 2014 JasonHuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (ImageContentType)

/**
 *  Compute the content type for an image data
 *
 *  @param data the input data
 *
 *  @return the content type as string (i.e. image/jpeg, image/gif)
 */
+ (NSString *)sd_contentTypeForImageData:(NSData *)data;

@end


@interface NSData (ImageContentTypeDeprecated)

+ (NSString *)contentTypeForImageData:(NSData *)data __deprecated_msg("Use `sd_contentTypeForImageData:`");

@end
