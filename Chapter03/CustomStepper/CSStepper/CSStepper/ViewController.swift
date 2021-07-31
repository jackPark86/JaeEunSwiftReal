//
//  ViewController.swift
//  CSStepper
//
//  Created by icoinnet on 2021/07/31.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let stepper = CSStepper()
        stepper.frame = CGRect(x: 30, y: 100, width: 130, height: 30)
        self.view.addSubview(stepper)
        
    }//end of viewDidLoad()

}//end of class

