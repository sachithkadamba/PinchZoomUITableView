//  PinchZoomTableView.m
//  Created by Sachith on 14/01/11.

/*Copyright 2011 Sachith Kadamba <sachithkadamba@gmail.com>
This program is free software; you can redistribute it and/or modify
it under the terms of the GNU  Lesser General Public License as published by the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
                                                                                                                   
You should have received a copy of the GNU Lesser General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
MA 02110-1301, USA.*/

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
