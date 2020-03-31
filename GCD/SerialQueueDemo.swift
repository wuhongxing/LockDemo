//
//  SerialQueueDemo.swift
//  GCD
//
//  Created by 吴红星 on 2020/3/31.
//  Copyright © 2020 wuhongxing. All rights reserved.
//

import Foundation

class SerialQueueDemo: UnlockDemo {
    
    let serialQueue = DispatchQueue(label: "serialQueue")
    
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
        serialQueue.sync {
            super.unlockSale()
        }
    }
    
    func osspinlockSaveMoney() {
        serialQueue.sync {
            super.unlockSaveMoney()
        }
    }
    
    func osspinlockDrawMoney() {
        serialQueue.sync {
            super.unlockDrawMoney()
        }
    }
    
}
