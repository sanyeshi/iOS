//
//  RunLoopContext.h
//  Runloop
//
//  Created by 孙硕磊 on 7/12/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RunLoopSource.h"

@interface RunLoopContext : NSObject

@property(nonatomic,assign,readonly) CFRunLoopRef runLoopRef;
@property(nonatomic,strong,readonly) RunLoopSource * source;

-(instancetype) initWithSource:(RunLoopSource *) src andRunLoopRef:(CFRunLoopRef) runLoopRef;
@end
