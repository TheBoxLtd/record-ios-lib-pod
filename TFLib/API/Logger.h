//
//  Logger.h
//  Rising Star
//
//  Created by Jano A. on 24/07/14.
//  Copyright (c) 2014 Jano A. All rights reserved.
//

#import <Foundation/Foundation.h>

#if DEBUG
#define LOG( s, ... ) NSLog( @"<%@:%d> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__,  [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define LOG( s, ... )
#endif

#define UA_logBounds(view) UA_log(@"%@ bounds: %@", view, NSStringFromRect([view bounds]))
#define UA_logFrame(view)  UA_log(@"%@ frame: %@", view, NSStringFromRect([view frame]))

#define UA_SHOW_VIEW_BORDERS YES
#define UA_showDebugBorderForViewColor(view, color) if (UA_SHOW_VIEW_BORDERS) { view.layer.borderColor = color.CGColor; view.layer.borderWidth = 1.0; }
#define UA_showDebugBorderForView(view) UA_showDebugBorderForViewColor(view, [UIColor colorWithWhite:0.0 alpha:0.25])
