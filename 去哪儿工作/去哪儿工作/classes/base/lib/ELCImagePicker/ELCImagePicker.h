
//
//  ELCImagePicker.h
//  parttime
//
//  Created by 孙硕磊 on 4/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#ifndef parttime_ELCImagePicker_h
#define parttime_ELCImagePicker_h

#ifndef iPhone5
#define iPhone5     ([UIScreen mainScreen].bounds.size.width==320?YES:NO)
#endif

#ifndef iPhone6
#define iPhone6     ([UIScreen mainScreen].bounds.size.width==375?YES:NO)
#endif

#ifndef iPhone6Plus
#define iPhone6Plus ([UIScreen mainScreen].bounds.size.width==414?YES:NO)
#endif

#define kELCAssetItemCount (iPhone6Plus==YES?5:4)

#import "ELCAlbumPickerController.h"
#import "ELCImagePickerController.h"
#import "ELCAssetTablePicker.h"

#endif
