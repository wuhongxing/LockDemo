//
//  UnfairLockDemo.swift
//  GCD
//
//  Created by 吴红星 on 2020/3/30.
//  Copyright © 2020 wuhongxing. All rights reserved.
//

import Foundation

class UnfairLockDemo: UnlockDemo {
    var lock = os_unfair_lock()
    
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
        os_unfair_lock_lock(&lock)
        super.unlockSale()
        os_unfair_lock_unlock(&lock)
    }
    
    func osspinlockSaveMoney() {
        os_unfair_lock_lock(&lock)
        super.unlockSaveMoney()
        os_unfair_lock_unlock(&lock)
    }
    
    func osspinlockDrawMoney() {
        os_unfair_lock_lock(&lock)
        super.unlockDrawMoney()
        os_unfair_lock_unlock(&lock)
    }
}

