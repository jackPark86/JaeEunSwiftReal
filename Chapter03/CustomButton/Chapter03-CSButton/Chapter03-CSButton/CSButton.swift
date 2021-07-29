//
//  CSButton.swift
//  Chapter03-CSButton
//
//  Created by icoinnet on 2021/07/29.
//

import UIKit

class CSButton: UIButton {

    /*
      init(coder:) 구문은 스토리보드 방식으로 객체를 생성할 때 호출되는 초기화 메소드이다. 다시 말해,
     스토리보드에서 CSButton 클래스 타입의 버튼 객체를 사용하면 이 초기화 메소드가 사용된다.
     */
    required init(coder aDecoder: NSCoder) {
      /*
        상위 클래스의 동일한 초기화 메소드에서 처리하는 내용을 누락시키지 않기 위해,
        부모의 초기화 메소드를 내부적으로 호출
       */
        super.init(coder: aDecoder)!
        
        //스토리보드 방식으로 버튼을 정의했을 때 적용
        self.backgroundColor = .green //배경을 녹색으로
        self.layer.borderWidth = 2 //테두리는 조금 두껍게
        self.layer.borderColor = UIColor.black.cgColor  //테두리는 검은색으로
        self.setTitle("버튼", for: .normal) //기본 문구 설정
    }//end of init
 
    

}//end of class
