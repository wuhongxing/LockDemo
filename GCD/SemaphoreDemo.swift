//
//  SemaphoreDemo.swift
//  GCD
//
//  Created by 吴红星 on 2020/3/31.
//  Copyright © 2020 wuhongxing. All rights reserved.
//

import Foundation

class SemaphoreDemo: UnlockDemo {
    let semaphore = DispatchSemaphore(value: 1)
    
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
        semaphore.wait()
        super.unlockSale()
        semaphore.signal()
    }
    
    func osspinlockSaveMoney() {
        semaphore.wait()
        super.unlockSaveMoney()
        semaphore.signal()
    }
    
    func osspinlockDrawMoney() {
        semaphore.wait()
        super.unlockDrawMoney()
        semaphore.signal()
    }
    
}
