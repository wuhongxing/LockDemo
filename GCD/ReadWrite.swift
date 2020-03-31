//
//  ReadWrite.swift
//  GCD
//
//  Created by 吴红星 on 2020/4/1.
//  Copyright © 2020 wuhongxing. All rights reserved.
//

import Foundation

class ReadWrite {
    var i = 10
    
    //MARK: 方案3，利用 dispatch_barrier_async
    let queue = DispatchQueue(label: "myqueue", attributes: .concurrent)
    func barrierlock() {
        (0...4).forEach { _ in
            Thread(target: self, selector: #selector(write3), object: nil).start()
            Thread(target: self, selector: #selector(read3), object: nil).start()
        }
    }
    
    @objc func read3() {
        queue.async {
            print("read", self.i)
        }
    }
    
    @objc func write3() {
        queue.sync(flags: .barrier) {
            self.i += 1
            print("write", i)
        }
    }
    
    //MARK: 方案2，利用pthread_rwlock锁
    var lock = pthread_rwlock_t()
    
    func rwlock() {
        (0...4).forEach { _ in
            Thread(target: self, selector: #selector(write2), object: nil).start()
            Thread(target: self, selector: #selector(read2), object: nil).start()
        }
    }
    
    @objc func read2() {
        pthread_rwlock_rdlock(UnsafeMutablePointer(&lock))
        print("read", i)
        pthread_rwlock_unlock(UnsafeMutablePointer(&lock))
    }
    
    @objc func write2() {
        pthread_rwlock_wrlock(UnsafeMutablePointer(&lock))
        i += 1
        print("write", i)
        pthread_rwlock_unlock(UnsafeMutablePointer(&lock))
    }
    
    //MARK: 方案1，使用锁对读写同时加锁，这样不能并发读，感觉不是很科学
    let semaphore = DispatchSemaphore(value: 1)
    
    func semaphorelock() {
        (0...4).forEach { _ in
            Thread(target: self, selector: #selector(write), object: nil).start()
            Thread(target: self, selector: #selector(read), object: nil).start()
        }
    }
    
    @objc func read() {
        semaphore.wait()
        print("read", i)
        semaphore.signal()
    }
    
    @objc func write() {
        semaphore.wait()
        i += 1
        print("write", i)
        semaphore.signal()
    }
}
