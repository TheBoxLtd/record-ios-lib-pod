//
//  ImageView.h
//  TFLib
//
//  Created by Jano A. on 21/1/15.
//  Copyright (c) 2015 Screenz. All rights reserved.
//

#import "BaseView.h"
#import "UIDownloadableImageView.h"

@interface ImageView : BaseView
@property IBOutlet UILabel *lblTitle;
@property IBOutlet UIDownloadableImageView *img;
@property IBOutlet UILabel *lblText;
@end
