//
//  AppDelegate.h
//  victoryCenter
//
//  Created by Xiaohe Hu on 9/23/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSString *appendFilenameForExternal;
@property (nonatomic,strong) UIScreen *external_disp;
@property (nonatomic,strong) UIWindow *external_wind;
@property (assign) BOOL extDisplayConnected;
@end
