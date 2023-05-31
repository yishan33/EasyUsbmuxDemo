//
//  FUTCPRequestSerializer.h
//  FakeUltroDemo
//
//  Created by liufushan on 2023/5/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FUTCPRequestSerializer : NSObject



- (void)requestWithPath:(NSString *)path params:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
