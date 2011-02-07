//  PinchZoomTableView.h
//  Created by Sachith on 14/01/11.

//  For any Queries or suggestion contact me :sachithkadamba@gmail.com

/*

 This works both for iPhone and iPad in all orientaions. 
 For any bugs or improvements feel free to contact me.
 
*/

#import <UIKit/UIKit.h>

@interface PinchZoomTableView : UITableView <UIGestureRecognizerDelegate>{
	
	CGRect originalFrame;
	CGFloat screenWidth;
	CGFloat screenHeight;
	CGFloat deltaY;
}

@property (nonatomic, readwrite) CGRect originalFrame;
@property (nonatomic, readwrite) CGFloat screenWidth;
@property (nonatomic, readwrite) CGFloat screenHeight;
@property (nonatomic, readwrite) CGFloat deltaY;
- (void) resetTable;
- (void) addGesture;

@end
