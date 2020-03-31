//
//  ViewController.swift
//  GCD
//
//  Created by 吴红星 on 2020/3/30.
//  Copyright © 2020 wuhongxing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    
    //MARK: 先异步执行任务A、B再异步执行C、D
    @IBAction func button1DidTouched(_ sender: UIButton) {
        let queue = DispatchQueue(label: "myqueue", attributes: .concurrent)
        let group = DispatchGroup()
        queue.async(group: group) {
            self.A()
        }
        queue.async(group: group) {
            self.B()
        }
        
        group.notify(queue: queue) {
            self.C()
        }
        group.notify(queue: queue) {
            self.D()
        }
    }
    
    func A() {
        (0...5).forEach { (i) in
            print(i, Thread.current, "A")
        }
    }
    
    func B() {
        (0...5).forEach { (i) in
            print(i, Thread.current, "B")
        }
    }
    
    func C() {
        (0...5).forEach { (i) in
            print(i, Thread.current, "C")
        }
    }
    
    func D() {
        (0...5).forEach { (i) in
            print(i, Thread.current, "D")
        }
    }
    
    //MARK: 卖票问题
    
    var demo = SynchronizedDemo()
    @IBAction func saleTickets(_ sender: Any) {
        demo.saleTickets()
    }
    
    @IBAction func saveDrawMoney(_ sender: Any) {
        demo.saveDrawMoney()
    }
    
}


