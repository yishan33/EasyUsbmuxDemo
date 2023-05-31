//
//  FUTCPRequest.h
//  FakeUltroDemo
//
//  Created by liufushan on 2023/5/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FUTCPRequest : NSObject

@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSDictionary *params;


@end

NS_ASSUME_NONNULL_END
