
//  PinchZoomTableView.m

//  Created by Sachith on 14/01/11.
//  Copyright 2011 Sachith Kadamba All rights reserved.
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//  For any Queries or suggestion contact me :sachithkadamba@gmail.com


#import "PinchZoomTableView.h"
#import <QuartzCore/QuartzCore.h>


@implementation PinchZoomTableView
@synthesize originalFrame;
@synthesize screenWidth;
@synthesize screenHeight;
@synthesize deltaY;

-(void)awakeFromNib {
	
	[self addGesture];
	
	CGRect wh =  [[UIScreen mainScreen]bounds];
	screenWidth = wh.size.width;
	screenHeight = wh.size.height;
	
	/*
	 For iPad i found deltaY as 120.. you can change this for your requirement 
	*/
	if(screenWidth > 1000) {
		deltaY = 120;
	}
	else {
		deltaY = 50;
	}	
}
	
- (void)addGesture {
	
	self.clipsToBounds = YES;	
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scalePiece:)];
    [pinchGesture setDelegate:self];
    [self addGestureRecognizer:pinchGesture];
    [pinchGesture release]; 	
}


- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    
	if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
 
		UIView *piece = gestureRecognizer.view;
		originalFrame.size.height = self.frame.size.height;
		self.originalFrame = self.frame;

        CGPoint locationInView = [gestureRecognizer locationInView:nil];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];		
		
		UIInterfaceOrientation orientaion = [[UIDevice currentDevice]orientation];			
	
		/*some times Device gives unknown orientaion
		  If Device orientaion is unkown check orientaion of status bar
		*/
		if( orientaion != UIInterfaceOrientationPortrait  && orientaion != UIInterfaceOrientationPortraitUpsideDown &&orientaion != UIInterfaceOrientationLandscapeLeft && orientaion != UIInterfaceOrientationLandscapeRight) {
			
			orientaion = [[UIApplication sharedApplication] statusBarOrientation];
		}
		
		if( orientaion == UIInterfaceOrientationPortrait ) {
			
		}
		
		else if ( orientaion == UIInterfaceOrientationPortraitUpsideDown ) {
			
			locationInView.x = screenWidth - locationInView.x;
			locationInView.y = (screenHeight -20) - locationInView.y;
		}
		
		else if ( orientaion == UIInterfaceOrientationLandscapeLeft ) {
			
			float x =  screenHeight - locationInView.y;
			float y = locationInView.x;
			
			locationInView.x = x;
			locationInView.y = y;
			
		}
		else if ( orientaion == UIInterfaceOrientationLandscapeRight ) {
			
			float y =  locationInView.y;
			float x = screenWidth - locationInView.x;
			
			locationInView.x = y;
			locationInView.y = x;
		}		
        
		piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, (locationInView.y -deltaY) / piece.bounds.size.height);
	
        piece.center = locationInSuperview;		
		
    }
	
	else if(gestureRecognizer.state == UIGestureRecognizerStateEnded) {
	
		[self resetTable];
	}
	
}

- (void)resetTable {
	
	[UIView beginAnimations:nil context:nil];
	[self setTransform:CGAffineTransformIdentity];	
	self.frame = originalFrame;
	[UIView commitAnimations];
}

- (void)scalePiece:(UIPinchGestureRecognizer *)gestureRecognizer {
	
	[self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        [gestureRecognizer view].transform = CGAffineTransformScale([[gestureRecognizer view] transform], [gestureRecognizer scale], [gestureRecognizer scale]);
		[gestureRecognizer setScale:1];		
    }	
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

-(void)dealloc {	
	[super dealloc];	
}

@end
