//
//  ViewController.swift
//  Button
//
//  Created by icoinnet on 2021/07/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //버튼 객체를 생성하고, 속성을 설정한다.
        let btn = UIButton(type: .system) //1 버튼의 타입을 인자값으로 하여 버튼 인스턴스를 생성
        btn.frame = CGRect(x: 50, y: 100, width: 150, height: 30)//2.버튼의 영역을 설정하여 frame 속성에 대입
        btn.setTitle("텍스트 버튼", for: .normal)
        
        //버튼을 수평 중앙 정렬한다.
        btn.center = CGPoint(x: self.view.frame.size.width/2, y: 100) //self.view.frame.size.width/2 대신 window.screen을 사용해도 된다.
        
        //생성된 버튼 인스턴스를 루트 뷰에 추가한다
        self.view.addSubview(btn)
    }//end of viewDidLoad()
    
    @objc func btnOnClick(_ sender: Any){
        //호출한 객체가 버튼이라면
        if let btn = sender as? UIButton {
            btn.setTitle("클릭되었습니다", for: .normal)
        }
        
    }//end of btnOnClick
    
    
}//end of class

