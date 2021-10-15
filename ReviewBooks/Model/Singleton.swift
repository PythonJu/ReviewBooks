//
//  Singleton.swift
//  ReviewBooks
//
//  Created by MBP潤 on 2021/10/16.
//

import Foundation

class Singleton {
    var changePresentVC: String = "moveToLogInVC"
    static let sharedInstance: Singleton = Singleton()
    private init(){}
}
