//
//  CSLogButton.swift
//  MyMemory
//
//  Created by icoinnet on 2021/08/01.
//

import UIKit

public enum CSLogType: Int {
    case basic //기본 로그 타입
    case title //버튼의 타이틀을 출력
    case tag //버튼의 태그값을 출력
}//end of CSLogType

//커스텀 버튼 클래스
public class CSLogButton: UIButton {

    //로그 출력 타입
    public var logType: CSLogType = .basic
    
    
    /*
      init(coder:) 구문은 스토리보드 방식으로 객체를 생성할 때 호출되는 초기화 메소드이다. 다시 말해,
     스토리보드에서 CSButton 클래스 타입의 버튼 객체를 사용하면 이 초기화 메소드가 사용된다.
     */
    //(coder(전달인자레이블) aDecoder(매개변수이름): NSCoder(매개변수타입)
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //버튼에 스타일 적용
        self.setBackgroundImage(UIImage(named: "button-bg"), for: .normal)
        self.tintColor = .white
        
        //버튼의 클릭 이벤트에 logging(_:) 메소드 연결
        self.addTarget(self, action: #selector(logging(_:)), for: .touchUpInside)
    }//end of init
    

    //로그를 출력하는 액션 메소드
    @objc func logging(_ sender: UIButton){
        switch self.logType {
        case .basic: //단순히 로그만 출력함
            NSLog("버튼이 클릭되었습니다.")
        case .title: //로그에 버튼의 타이틀을 출력함
            let btnTitle = sender.titleLabel?.text ?? "타이틀 없는"
            NSLog("\(btnTitle) 버튼이 클릭되었습니다.")
        case .tag: //로그에 버튼의 태그를 출력함
            NSLog("\(sender.tag) 버튼이 클릭되었습니다.")
        }
    }//end of logging
    

}//end of CSLogButton
