//
//  MapAlertViewController.swift
//  Chapter03-Alert
//
//  Created by icoinnet on 2021/07/27.
//

import UIKit

class MapAlertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //버튼 생성
        let alertBtn = UIButton(type: .system)
        alertBtn.frame = CGRect(x: 0, y: 150, width: 100, height: 30)
        alertBtn.center.x = self.view.frame.width / 2
        alertBtn.setTitle("Map Alertt", for: .normal)
        alertBtn.addTarget(self, action: #selector(mapAlertt(_:)), for: .touchUpInside)
        
        self.view.addSubview(alertBtn)
        
    }//end of viewDidLoad

    @objc func mapAlertt(_ sender: UIButton) {
        //경고창 객체를 생성하고, OK 및 Cancel 버튼을 추가한다. 
        
    }//end of mapAlertt

}//end of class
