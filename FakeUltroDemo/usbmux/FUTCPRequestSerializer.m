//
//  FUTCPRequestSerializer.m
//  FakeUltroDemo
//
//  Created by liufushan on 2023/5/29.
//

#import "FUTCPRequestSerializer.h"
#import "FUTCPRequest.h"
#import "usbmux_define.h"

static NSString * kFUServerIP = @"127.0.0.1";
static int kFUServerPort = 1024;
static dispatch_queue_t usbmuxd_io_queue;
static float requestTimeOut = 15.0;

@interface FUTCPRequestSerializer ()

@property (nonatomic, assign) int clientSocket;
@property (nonatomic, strong) NSTimer *outTimer;

@end

@implementation FUTCPRequestSerializer

- (void)requestWithPath:(NSString *)path params:(NSDictionary *)params
{
    FUTCPRequest *request = [[FUTCPRequest alloc] init];
    request.path = path;
    request.params = params;
//    [self sendAndRecv:@"i love u"];
    
    [self asyncSendAndRecv:@"i love u"];
}

//建立连接
- (void)connectToServer:(NSString *)ip port:(int)port {
    self.clientSocket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    struct sockaddr_in addr;
    /* 填写sockaddr_in结构*/
    addr.sin_family = AF_INET;
    addr.sin_port = htons(port);
    addr.sin_addr.s_addr = inet_addr(ip.UTF8String);
    int connectResult = connect(self.clientSocket, (const struct sockaddr *)&addr, sizeof(addr));
    if (connectResult == 0) {
        NSLog(@"conn ok");
    }
}

//发送数据并等待返回数据
- (void)asyncSendAndRecv:(NSString *)msg {
    [self connectToServer:kFUServerIP port:kFUServerPort];
    self.outTimer = [NSTimer scheduledTimerWithTimeInterval:requestTimeOut repeats:NO block:^(NSTimer * _Nonnull timer) {
        [self closeConnect];
    }];
    
    dispatch_queue_t send_queue = dispatch_queue_create("send_queue", NULL);
    dispatch_queue_t recv_queue = dispatch_queue_create("recv_queue", NULL);
    dispatch_async(send_queue, ^{
        const char *str = msg.UTF8String;
        ssize_t sendLen = send(self.clientSocket, str, strlen(str), 0);    //发消息
        NSLog(@"i send: %@", msg);
    });
    __weak typeof (self) weakSelf = self;
    [self recvInQueue:recv_queue];
}

- (void)recvInQueue:(dispatch_queue_t)queue
{
    dispatch_async(queue, ^{
        char *buf[1024];
        ssize_t recvLen = recv(self.clientSocket, buf, sizeof(buf), 0);    //收消息
        NSString *recvStr = [[NSString alloc] initWithBytes:buf length:recvLen encoding:NSUTF8StringEncoding];
        NSLog(@"i reveive: %@", recvStr);
        [self recvInQueue:queue];
    });
}

//发送数据并等待返回数据
- (void)sendAndRecv:(NSString *)msg {
    [self connectToServer:kFUServerIP port:kFUServerPort];
    self.outTimer = [NSTimer scheduledTimerWithTimeInterval:requestTimeOut repeats:NO block:^(NSTimer * _Nonnull timer) {
        [self closeConnect];
    }];
    
    usbmuxd_io_queue = dispatch_queue_create("usbmuxd_io_queue", NULL);
    dispatch_async(usbmuxd_io_queue, ^{
        const char *str = msg.UTF8String;
        ssize_t sendLen = send(self.clientSocket, str, strlen(str), 0);    //发消息
        char *buf[1024];
        ssize_t recvLen = recv(self.clientSocket, buf, sizeof(buf), 0);    //收消息
        NSString *recvStr = [[NSString alloc] initWithBytes:buf length:recvLen encoding:NSUTF8StringEncoding];
        NSLog(@"i reveive: %@", recvStr);
        if (recvStr.length > 0) {
            [self closeConnect];
        }
    });
}

- (void)closeConnect
{
    close(self.clientSocket);
    NSLog(@"closeConnect");
}

@end
