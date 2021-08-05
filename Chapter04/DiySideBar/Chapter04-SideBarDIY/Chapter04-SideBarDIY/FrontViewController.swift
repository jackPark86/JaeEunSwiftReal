//
//  FrontViewController.swift
//  Chapter04-SideBarDIY
//
//  Created by icoinnet on 2021/08/03.
//

import UIKit

/**
 FrontViewController 클래스는 앱이 실행되었을 때 사용자에게 보여질 실질적인 첫 화면
 */
class FrontViewController: UIViewController {

    //사이드 바 오픈 기능을 위임할 델리게이트 (델리게이트 변수는 특정 기능을 위임할 대상을 지정하기 위한 변수이다.)
    var delegate: RevealViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //사이드 바 오픈용 버튼 정의
        let btnSideBar = UIBarButtonItem(image: UIImage(named: "sidemenu.png"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(moveSide(_:)))
        
        //버튼을 내비게이션 바 왼쪽 영역에 추가
        self.navigationItem.leftBarButtonItem =  btnSideBar
        
        
        //화면 끝에서 다른 쪽으로 패닝하는 제스처를 정의 (화면 끝 제스처는 패닝)
        let dragLeft = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(moveSide(_:)))
        dragLeft.edges = UIRectEdge.left //시작 모서리는 왼쪽
        self.view.addGestureRecognizer(dragLeft) //뷰의 제스처 객체를 등록
        
        //화면을 스와이프하는 제스처를 정의(사이드 메뉴 닫기용) (화면 중간 제스처는 스와이프)
        let dragRight = UISwipeGestureRecognizer(target: self, action: #selector(moveSide(_:)))
        dragRight.direction = .left //방향은 왼쪽
        self.view.addGestureRecognizer(dragRight) //뷰에 제스처 객체를 등록
        
    }//end of viewDidLoad
    
    //사용자의 액션에 따라 델리게이트 메소드를 호출
    @objc func moveSide(_ sender: Any){
        if sender is UIScreenEdgePanGestureRecognizer { //패닝 제스처
            self.delegate?.openSideBar(nil)
        } else if sender is UISwipeGestureRecognizer { //스와이프 제스처
            self.delegate?.closeSideBar(nil)
        } else if sender is UIBarButtonItem { //네비게이션 버튼 
            if self.delegate?.isSideBarShowing == false {
                self.delegate?.openSideBar(nil) //사이드 바를 연다.
            } else {
                self.delegate?.closeSideBar(nil) //사이드 바를 닫는다.
            }//end of if  ~ else
        }//end of if else
    }//end of moveSide
    
    
    
    
}//end of class
