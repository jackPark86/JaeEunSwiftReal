//
//  CSButton.swift
//  Chapter03-CSButton
//
//  Created by icoinnet on 2021/07/29.
//

import UIKit

public enum CSButtonType {
    case rect
    case circle
}//end of enum

class CSButton: UIButton {
    
    var style : CSButtonType = .rect {
        didSet{
            switch style {
            case .rect:
                self.backgroundColor = .black //배경을 검은색으로
                self.layer.borderColor = UIColor.black.cgColor
                self.layer.borderWidth = 2
                self.layer.cornerRadius = 0 //모서리는 전혀 둥들지 않게
                self.setTitleColor(.white, for: .normal) //글씨는 흰색으로
                self.setTitle("Rect Button", for: .normal) //기본 문구 설정
            case .circle:
                self.backgroundColor = .red //배경을 검은색으로
                self.layer.borderColor = UIColor.black.cgColor
                self.layer.borderWidth = 2
                self.layer.cornerRadius = 50 //모서리는 전혀 둥들지 않게
                self.setTitle("Rect Button", for: .normal) //기본 문구 설정
            }//end of switch
        }
    }

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
 
    
    /**
             프로그래밍 방식으로도 커스텀 클래스를 생성할 수 있도록 초기화 메소드를 오버라이드 한다.
     */
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.backgroundColor = .gray
        self.layer.borderColor = UIColor.black.cgColor //테두리는 검은색으로
        self.layer.borderWidth = 2 //테두리는 조금 두껍게
        self.setTitle("코드로 생성된 버튼", for: .normal) //기본 문구 설정
    }//end of init
    
    
    init() {
        super.init(frame: CGRect.zero)
    }//end of init
    
    /*
        편의 초기화 메소드
     편의 초기화 메소드는 사용자 편의를 주기 위해 정의하는 보조적인 초기화 메소드이다. 이 메소드는 일부 혹은 전체 멤버에 대해서 별도의 초기값을 설정하는 동시에 내부적으로 다른 초기화 메소드를 다시 호출한다. 반드시 정의해야 하는 것은 아니며, 지정 초기화 메소드와 구분을 위해 convenience 키워드를 붙여준다.
     (이 메소드는 편의 초기화 메소드로 정의되었으모로, 부모의 초기화 메소드를 호출하는 것이 아니라 자신의 지정 초기화 메소드 중 하나를 호출한다.)
     P - 460
     */
    convenience init(type: CSButtonType){
        self.init()
        
        switch type {
        case .rect:
            self.backgroundColor = .black //배경을 검은색으로
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.borderWidth = 2
            self.layer.cornerRadius = 0 //모서리는 전혀 둥들지 않게
            self.setTitleColor(.white, for: .normal) //글씨는 흰색으로
            self.setTitle("Rect Button", for: .normal) //기본 문구 설정
        case .circle:
            self.backgroundColor = .red //배경을 검은색으로
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.borderWidth = 2
            self.layer.cornerRadius = 50 //모서리는 전혀 둥들지 않게
            self.setTitle("Rect Button", for: .normal) //기본 문구 설정
        }
        
        self.addTarget(self, action: #selector(counting(_:)), for: .touchUpInside)
    }//end of convenience
    
    
    //버튼이 클릭된 횟수를 카운트하여 타이틀에 표시해 주는 함수
    @objc func counting(_ sender: UIButton){
        /**
         버튼의 tag 속성을 활용해 카운트 횟수를 저장
         tag속성도 클래스 레벨에서 정의된 프로퍼티이며, 값의 타입 역시 Int로 정의되어 있다.
         */
        sender.tag = sender.tag + 1
        sender.setTitle("\(sender.tag) 번째 클릭", for: .normal)
    }//end of counting

}//end of class
