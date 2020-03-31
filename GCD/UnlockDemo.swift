//
//  BaseDemo.swift
//  GCD
//
//  Created by 吴红星 on 2020/3/30.
//  Copyright © 2020 wuhongxing. All rights reserved.
//

import UIKit

class UnlockDemo {
    var ticketsCount: Int = 15
    var money: Int = 100
    
    func saleTickets() {
        (0..<3).forEach { _ in
            DispatchQueue.global().async {
                (0..<5).forEach { (i) in
                    self.unlockSale()
                }
            }
        }
    }
    
    func saveDrawMoney() {
        DispatchQueue.global().async {
            (0..<5).forEach { (i) in
                self.unlockSaveMoney()
            }
        }
        DispatchQueue.global().async {
            (0..<5).forEach { (i) in
                self.unlockDrawMoney()
            }
        }
    }
    
    func unlockSale() {
        var oldCount = ticketsCount
        sleep(1)
        oldCount -= 1
        ticketsCount = oldCount
        
        print("还有\(ticketsCount)张票")
    }
    
    func unlockSaveMoney() {
        var oldMoney = money
        sleep(1)
        oldMoney += 50
        money = oldMoney
        
        print("存：还有\(money)元")
    }
    
    func unlockDrawMoney() {
        var oldMoney = money;
        sleep(1)
        oldMoney -= 40
        money = oldMoney
        
        print("取：还有\(money)元")
    }
}



