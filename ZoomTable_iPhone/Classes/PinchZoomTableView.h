//  PinchZoomTableView.h
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

//For any Queries or suggestion contact me :sachithkadamba@gmail.com

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
