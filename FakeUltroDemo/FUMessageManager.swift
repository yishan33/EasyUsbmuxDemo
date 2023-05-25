//
//  FUMessageManager.swift
//  FakeUltroDemo
//
//  Created by liufushan on 2023/5/23.
//

import Foundation

let FU = FUMessageManager.shared

struct FUDeviceInfo {
    var name = ""
    var number = ""
    var typeNum = ""
    var osVersion = ""
    var connectType = ""
}

class FUMessageManager {
    
    static let shared = FUMessageManager()
    
    func getDeviceInfo() -> FUDeviceInfo {
        return FUDeviceInfo(name: "myIphone")
    }

}
