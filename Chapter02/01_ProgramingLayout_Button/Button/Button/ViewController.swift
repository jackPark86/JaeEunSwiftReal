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
        
        //버튼의 이벤트와 메소드 btnOnClick()을 연결한다
        btn.addTarget(self, action: #selector(btnOnClick(_:)), for: .touchUpInside)
    }//end of viewDidLoad()
    

    /**
     btnOnClick 메소드는 사용자가 버튼을 터치했을 때 반응할 액션 메소드, 요구 사항으로는
     1. 매개변수 : 이벤트가 발생한 객체 정보를 전달받을 수 있도록 Any 혹은 해당 객체 타입의 첫 번재 매개변수를 정의해야 한다.
     2 .첫 번째 매개변수의 타입은 Any, AnyObject 또는 호출한 객체의 타입이어야 한다.
     3. @objc 어트리뷰트를 붙여 오브젝트-C에서도 인식할 수 있도록 해야 한다.
     */
    @objc func btnOnClick(_ sender: Any){
        //호출한 객체가 버튼이라면
        if let btn = sender as? UIButton {
            btn.setTitle("클릭되었습니다", for: .normal)
        }
        
    }//end of btnOnClick
    
    
}//end of class

