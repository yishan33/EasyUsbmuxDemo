//
//  FUUsbMuxRequest.m
//  FakeUltroDemo
//
//  Created by liufushan on 2023/5/24.
//

#import "FUUsbMuxRequest.h"

@implementation FUUsbMuxRequest

- (instancetype)initWithTag:(int)tag packet:(NSDictionary *)packet channel:(dispatch_io_t)channel
{
    if (self = [super init]) {
        _tag = tag;
        _packet = packet;
        _channel = channel;
    }
    return self;
}

@end
