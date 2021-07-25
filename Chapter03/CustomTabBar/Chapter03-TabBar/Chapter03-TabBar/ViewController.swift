//
//  ViewController.swift
//  Chapter03-TabBar
//
//  Created by icoinnet on 2021/07/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1) title 레이블 생성
        let title = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 30))
        
        //2) title 레이블 속성 설정
        title.text = "첫번째 탭"
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
        
     
        
    }//end of viewDidLoad()
    
    
    /**
     UIViewController의 상위 클래스인 UIResponder에는 화면 터치 관련 메소드들이 정의되어 있는데,
     들은 별도의 액션 메소드 연결 없이도 화면 전체에서 발생하는 터치 액션을 처리할 수 있도록 도와준다
    외와 관련하여 터치 액션의 타입에 따라 적절히 사용할 수 있는 다양한 메소드가 제공되며, 그중에서 touchesEnded()는
     화면에서 터치가 끝났을 때 호출되는 메소드이다.
     */
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tabBar = self.tabBarController?.tabBar
        //tabBar?.isHidden = (tabBar?.isHidden == true) ? false : true
        
        UIView.animate(withDuration: TimeInterval(0.15)){
            //alpha 값이 0이면 1로, 1이면 0으로 바꾸어 준다.
            //호출될 때마다 점점 투명해졌다가 점점 진해진다.
            tabBar?.alpha = (tabBar?.alpha == 0 ? 1 : 0)
        }

    }//end of touchesEnded
    
    
}//end of class

