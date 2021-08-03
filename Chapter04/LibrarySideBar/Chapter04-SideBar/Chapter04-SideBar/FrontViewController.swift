//
//  FrontViewController.swift
//  Chapter04-SideBar
//
//  Created by icoinnet on 2021/08/02.
//

import UIKit

class FrontViewController: UIViewController {

    @IBOutlet weak var sideBarButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //메인 컨트롤러의 참조 정보를 가져온다.
        if let revealVC = self.revealViewController() {
            //버튼이 클릭될 때 메인 컨트롤러에 정의된 revealToggle()을 호출하도록 정의한다
            self.sideBarButton.target = revealVC
            self.sideBarButton.action = #selector(revealVC.revealToggle(_:))
            
            //제스처를 뷰에 등록한다
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
        
    }//end of viewDidLoad()
    
    
    
}//end of class
