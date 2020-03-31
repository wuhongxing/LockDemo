//
//  OSSpinLockDemo.swift
//  GCD
//
//  Created by 吴红星 on 2020/3/30.
//  Copyright © 2020 wuhongxing. All rights reserved.
//

import Foundation

class OSSpinLockDemo: UnlockDemo {
    var lock = OSSpinLock()
    
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
        OSSpinLockLock(UnsafeMutablePointer(&lock))
        super.unlockSale()
        OSSpinLockUnlock(UnsafeMutablePointer(&lock))
    }
    
    func osspinlockSaveMoney() {
        OSSpinLockLock(UnsafeMutablePointer(&lock))
        super.unlockSaveMoney()
        OSSpinLockUnlock(UnsafeMutablePointer(&lock))
    }
    
    func osspinlockDrawMoney() {
        OSSpinLockLock(UnsafeMutablePointer(&lock))
        super.unlockDrawMoney()
        OSSpinLockUnlock(UnsafeMutablePointer(&lock))
    }
}
