//
//  GPUImageMovieComposition.h
//  Givit
//  爱你一生一世 刘磊璐
//  Create by JasonHuang on 2013/01/25.
//
//

#import "GPUImageMovie.h"

@interface GPUImageMovieComposition : GPUImageMovie

@property (readwrite, retain) AVComposition *compositon;
@property (readwrite, retain) AVVideoComposition *videoComposition;
@property (readwrite, retain) AVAudioMix *audioMix;

- (id)initWithComposition:(AVComposition*)compositon
      andVideoComposition:(AVVideoComposition*)videoComposition
              andAudioMix:(AVAudioMix*)audioMix;

@end
