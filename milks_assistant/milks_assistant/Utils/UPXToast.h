//
//  UPToast.h
//  UPClientV3
//
//  Create by TZ_JSKFZX_CAOQ on 13-5-28.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef enum ToastGravityTag {
	kToastGravityTop = 1000001,
	kToastGravityBottom,
	kToastGravityCenter
}ToastGravity;




@class UPXToastSettings;

@interface UPXToast : NSObject {
	NSInteger _offsetLeft;
	NSInteger _offsetTop;
    UPXToastSettings* _settings;
	NSTimer *_timer;
	UIView *_view;
	NSString *_text;
}

- (void)show;
- (UPXToast*)setDuration:(NSInteger ) duration;
- (UPXToast*)setGravity:(ToastGravity) gravity
               offsetLeft:(NSInteger) left
                offsetTop:(NSInteger) top;
- (UPXToast*)setGravity:(ToastGravity) gravity;
- (UPXToast*)setPostion:(CGPoint) position;
- (UPXToast*)setSize:(CGSize) size;
- (UPXToast*)setImage:(UIImage*)image;
+ (UPXToast*)makeText:(NSString *) text;
- (UPXToastSettings*)theSettings;
- (void)removeToast;

@end



@interface UPXToastSettings : NSObject<NSCopying>{
	NSInteger _duration;
	ToastGravity _gravity;
	CGPoint _postition;
	CGSize  _size;
	UIImage *_image;
	BOOL _positionIsSet;
}

@property(assign) NSInteger duration;
@property(assign) ToastGravity gravity;
@property(assign) CGPoint postition;
@property(assign) CGSize size;
@property(retain) UIImage *image;

+ (UPXToastSettings*)getSharedSettings;

@end
