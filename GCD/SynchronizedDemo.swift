//
//  SynchronizedDemo.swift
//  GCD
//
//  Created by 吴红星 on 2020/3/31.
//  Copyright © 2020 wuhongxing. All rights reserved.
//

import Foundation

class SynchronizedDemo: UnlockDemo {
    
    override func saleTickets() {
        (0..<3).forEach { _ in
            DispatchQueue.global().async {
                (0..<5).forEach { (i) in
                    self.osspinlockSale()
                }
            }
        }
    }
    
    override func saveDrawMoney() {
        DispatchQueue.global().async {
            (0..<5).forEach { (i) in
                self.osspinlockSaveMoney()
            }
        }
        DispatchQueue.global().async {
            (0..<5).forEach { (i) in
                self.osspinlockDrawMoney()
            }
        }
    }
    
    func osspinlockSale() {
        objc_sync_enter(self)
        super.unlockSale()
        objc_sync_exit(self)
    }
    
    func osspinlockSaveMoney() {
        objc_sync_enter(self)
        super.unlockSaveMoney()
        objc_sync_exit(self)
    }
    
    func osspinlockDrawMoney() {
        objc_sync_enter(self)
        super.unlockDrawMoney()
        objc_sync_exit(self)
    }
}
