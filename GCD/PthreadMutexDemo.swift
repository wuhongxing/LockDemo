//
//  PthreadMutexDemo.swift
//  GCD
//
//  Created by 吴红星 on 2020/3/30.
//  Copyright © 2020 wuhongxing. All rights reserved.
//

import Foundation



class PthreadMutexDemo: UnlockDemo {
    var lock = pthread_mutex_t()
    
    override init() {
        var attr = pthread_mutexattr_t()
        pthread_mutexattr_init(UnsafeMutablePointer(&attr))
        pthread_mutexattr_settype(UnsafeMutablePointer(&attr), 0)
        pthread_mutex_init(&lock, UnsafePointer(&attr))
        pthread_mutexattr_destroy(UnsafeMutablePointer(&attr))
        // pthread_mutex_init(&lock, NULL)
    }
    
    
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
        pthread_mutex_lock(UnsafeMutablePointer(&lock))
        super.unlockSale()
        pthread_mutex_unlock(UnsafeMutablePointer(&lock))
    }
    
    func osspinlockSaveMoney() {
        pthread_mutex_lock(UnsafeMutablePointer(&lock))
        super.unlockSaveMoney()
        pthread_mutex_unlock(UnsafeMutablePointer(&lock))
    }
    
    func osspinlockDrawMoney() {
        pthread_mutex_lock(UnsafeMutablePointer(&lock))
        super.unlockDrawMoney()
        pthread_mutex_unlock(UnsafeMutablePointer(&lock))
    }
}

