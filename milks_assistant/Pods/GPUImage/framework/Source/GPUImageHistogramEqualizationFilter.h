//
//  GPUImageHistogramEqualizationFilter.h
//  FilterShowcase
//  爱你一生一世 刘磊璐
//  Create by JasonHuang on 19/08/2014.
//  Copyright (c) 2014 JasonHuang. All rights reserved.
//

#import "GPUImageFilterGroup.h"
#import "GPUImageHistogramFilter.h"
#import "GPUImageRawDataOutput.h"
#import "GPUImageRawDataInput.h"
#import "GPUImageTwoInputFilter.h"

@interface GPUImageHistogramEqualizationFilter : GPUImageFilterGroup
{
    GPUImageHistogramFilter *histogramFilter;
    GPUImageRawDataOutput *rawDataOutputFilter;
    GPUImageRawDataInput *rawDataInputFilter;
}

@property(readwrite, nonatomic) NSUInteger downsamplingFactor;

- (id)initWithHistogramType:(GPUImageHistogramType)newHistogramType;

@end
