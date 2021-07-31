//
//  CSStepper.swift
//  CSStepper
//
//  Created by icoinnet on 2021/07/31.
//

import UIKit


/*

 UIView보다는 UIControl을 서브 클래싱하는 것을 권장.
 UIView를 서브 클래싱하면 단순히 화면에 나타낼 수만 있는 반면,
 UIControl을 서브 클래싱하면 CSStepper 객체에 액션 이벤트를 연결 할 수 있기 때문이다.
 p -512
 */
//@IBDesignable 속성은 이 클래스를 스토리보드에서 미리보기 형태로 처리해 달라고 시스템에 요청하는 역할을 한다.
@IBDesignable
public class CSStepper: UIControl /*UIView*/ {

    public var leftBtn = UIButton(type: .system)// 좌측버튼
    public var rightBtn = UIButton(type: .system)//우측버튼
    public var centerLabel = UILabel() //중앙 레이블
    
    /**
     @IBInspectable은 우리가 정의한 속성을 인터페이스 빌더에서도 설정할 수 있도록 처리해 주는 어트리뷰트이다.
     이 어트리뷰트가 붙은 ㅍ ㅡ로퍼티는 어트리뷰트 인스펙터 탭의 속성 항목에 추가되어 편집 가능한 상태로 표시된다.
     마치 오리지널 스테퍼 객체의 속성 항목들처럼 말이다. - p 509
     */
    //스테퍼의 현재값을 저장할 변수
    @IBInspectable
    public var value: Int = 0 {
        didSet{//프로퍼티의 값이 바뀌면 자동으로 호출된다.
            self.centerLabel.text = String(value)
            
            //이 클래스를 상요하는 객체들에게 valueChanged 이벤트 신호를 보내준다.
            //sendActions(for:)는 인자값으로 입력된 타입의 이벤트를 발생시키는 메소드 - p513
            self.sendActions(for: .valueChanged)
        }
    }
    
    /**
            사용자가 속성을 커스텀 할 수 있게 변수로 설정
     */
    //좌측 버튼의 타이틀 속성
    @IBInspectable
    public var leftTitle: String  = "↓" {
        didSet {
            self.leftBtn.setTitle(leftTitle, for: .normal)
        }
    }
    
    //우측 버튼의 타이틀
    @IBInspectable
    public var rightTitle: String  = "↑" {
        didSet {
            self.rightBtn.setTitle(rightTitle, for: .normal)
        }
    }
    
    //센터 영역의 색상
    @IBInspectable
    public var bgColor : UIColor = UIColor.cyan {
        didSet {
            self.centerLabel.backgroundColor = backgroundColor
        }
    }
    
    //중심값 단위
    @IBInspectable
    public var stepValue : Int = 1
    
    @IBInspectable public var maximumValue : Int = 100
    @IBInspectable public var minimumValue : Int = -100
    
    
    //스토리보드에서 호출할 초기화 메소드
    public required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        self.setup()
    }//end of init
   
    //프로그래밍 방식으로 호출할 초기화 메소드
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }//end of init

    //여기에 스테퍼의 기본 속성을 설정한다.
    private func setup(){
        
        let borderWidht: CGFloat = 0.5 //테두리 두께값
        let borderColor = UIColor.blue.cgColor //테두리 색상값
        
        //좌측 다운 버튼 속성 설정
        self.leftBtn.tag = -1 //태그값에 -1을 부여
        //self.leftBtn.setTitle("↓", for: .normal) //버튼의 타이틀
        self.leftBtn.setTitle(leftTitle, for: .normal) //커스텀을 위한 변수로 타이틀 관리
        self.leftBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        self.leftBtn.layer.borderWidth = borderWidht //버튼 테두리 두께
        self.leftBtn.layer.borderColor = borderColor //버튼 테두리 색상 - 파란색
        
        //우측 업 버튼 속성 설정
        self.rightBtn.tag = 1 //태그값에 1을 부여
        //self.rightBtn.setTitle("↑", for: .normal) //버튼의 타이틀
        self.rightBtn.setTitle(rightTitle, for: .normal)
        self.rightBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        self.rightBtn.layer.borderWidth = borderWidht//버튼 테두리 두께
        self.rightBtn.layer.borderColor = borderColor //버튼 테두리 색상 - 파란색
        
        //중앙 레이블 속성 설정
        self.centerLabel.text = String(value) //컨트롤러의 현재값을 문자열로 변환하여 표시
        self.centerLabel.font = UIFont.systemFont(ofSize: 16)
        self.centerLabel.textAlignment = .center //가운데 정렬
        //self.centerLabel.backgroundColor = .cyan //배경 색상 지정
        self.centerLabel.backgroundColor = self.bgColor //배경 색상 지정
        self.centerLabel.layer.borderWidth = borderWidht //레이블의 테두리 두께
        self.centerLabel.layer.borderColor = borderColor // 레이블의 테두리 색상 - 파란색
        
        
        //영역별 객체를 서브 뷰로 추가한다.
        //CSStepper 클래스는 그 자체로 하나의 뷰이기 때문에, 서브 뷰를 추가할 때에도 클래스 자체의 서브 뷰 개념으로 추가해 주어야 한다.
        self.addSubview(self.leftBtn)
        self.addSubview(self.rightBtn)
        self.addSubview(self.centerLabel)
      
        //버튼의 터치 이벤트와 valueChange() 메소드를 연결한다.
        self.leftBtn.addTarget(self, action: #selector(valueChange(_:)), for: .touchUpInside)
        self.rightBtn.addTarget(self, action: #selector(valueChange(_:)), for: .touchUpInside)
        
    }//end of setup
    
    //뷰의 크기를 변경할 때 호출되는 메소드
    override public func layoutSubviews(){
        /**
                메소드를 오버라이드하더라도 딱히 부모 메소드의 기능 자체를 퍠기할 목적이 아니라면, 내부에서 부모의 동일 메소드를 호출해 주는 것이 좋은 습관이다.
         p 494
         */
        super.layoutSubviews()
        
        //버튼의 너비 = 뷰 높이
        let btnwidth = self.frame.height
        
        //레이블의 너뷰 = 뷰 전체 크기 - 양쪽 버튼의 너비 함
        let lblWidth = self.frame.width - (btnwidth*2)
        
        self.leftBtn.frame = CGRect(x: 0, y: 0, width: btnwidth, height: btnwidth)
        self.centerLabel.frame = CGRect(x: btnwidth, y: 0, width: lblWidth, height: btnwidth)
        self.rightBtn.frame = CGRect(x: btnwidth + lblWidth, y: 0, width: btnwidth, height: btnwidth)
    
    }//end of layoutSubviewS
    
    //스테퍼 value 속성의 값을 변경하는 메소드
    @objc public func valueChange(_ sender: UIButton){
        //스테퍼의 값을 변경하기 전에, 미리 최소값과 최대값 범위를 벗어나지 않는지 체크한다.
        let sum = self.value + (sender.tag * self.stepValue)

        
        //더한 결과가 최대값보다 크면 값을 변경하지 않고 종료
        if sum > self.maximumValue {
            return
        }
    
        //더한 결과가 최소값보다 작으면 값을 변경하지 않고 종료
        if sum < self.minimumValue {
            return
        }
        
        
        //현재의 value 값에 +1 또는 -1 한다.
        //self.value += sender.tag
        self.value += (sender.tag * self.stepValue)

        
        
    }//end of valueChange
    
 
    
    
    
}//end of class
