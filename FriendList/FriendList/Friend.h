//
//  Friend.h
//  FriendList
//
//  Created by DengBin on 15/12/16.
//  Copyright © 2015年 DB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Friend : NSObject
@property(nonatomic,strong)NSString  *name;
@property(nonatomic,strong)NSString  *detail;


@property(nonatomic,assign)NSInteger section;



- (NSString *) getFirstName;

@end
