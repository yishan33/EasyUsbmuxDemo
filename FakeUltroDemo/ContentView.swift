//
//  ContentView.swift
//  FakeUltroDemo
//
//  Created by liufushan on 2023/5/23.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        VStack {
            List {
                Button {
    //                let deviceInfo = FU.getDeviceInfo()
    //                print(deviceInfo)
    //
    //                let usbmux = usbmux()
    //                usbmux.testDemo()
                    
                } label: {
                    Text("点击获取设备信息")
                }
                Button {
                    FUTCPRequestSerializer().request(withPath: "", params: ["":""])
                } label: {
                    Text("点击发送i love u")
                }
            }
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
