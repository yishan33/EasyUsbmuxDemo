//
//  FUUsbMuxRequest.h
//  FakeUltroDemo
//
//  Created by liufushan on 2023/5/24.
//

#import <Foundation/Foundation.h>
#import "usbmux_define.h"

NS_ASSUME_NONNULL_BEGIN

@interface FUUsbMuxRequest : NSObject

@property (nonatomic, assign) int tag;
@property (nonatomic, strong) NSDictionary *packet;
@property (nonatomic, assign) dispatch_io_t channel;

- (instancetype)initWithTag:(int)tag packet:(NSDictionary *)packet channel:(dispatch_io_t)channel;

@end

NS_ASSUME_NONNULL_END
