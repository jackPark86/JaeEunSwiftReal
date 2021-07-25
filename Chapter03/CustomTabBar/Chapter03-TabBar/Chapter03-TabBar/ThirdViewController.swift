//
//  ThirdViewController.swift
//  Chapter03-TabBar
//
//  Created by icoinnet on 2021/07/25.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //1) title 레이블 생성
        let title = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 30))
        
        //2) title 레이블 속성 설정
        title.text = "세 번째 탭"
        title.textColor = .red
        title.textAlignment = .center
        title.font = UIFont.boldSystemFont(ofSize: 14)
        
        //sizeToFit 메소드와 center 속성 설정 구문을 함께 사용할 경우, 객체의 center 속성 설정은 항상 sizeToFit 메소드를 호출한 후에 처리해야 한다.
        //3) 콘텐츠 내용에 맞게 레이블 크기 변경
        title.sizeToFit()
        
        //4)X축의 중앙에 오도록 설정
        title.center.x = self.view.frame.width / 2 //x축의 중앙에 오도록

        //5) 수퍼 뷰에 추가
        self.view.addSubview(title)
        
    }//end of viewDidLoad
    


}//end of class 
