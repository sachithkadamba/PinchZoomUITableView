//
//  ZoomTable_iPhoneAppDelegate.h
//  ZoomTable_iPhone
//
//  Created by Sachith on 31/01/11.
//

#import <UIKit/UIKit.h>

@interface ZoomTable_iPhoneAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

