//
//  ViewController.swift
//  Chapter03-NavigationBar
//
//  Created by icoinnet on 2021/07/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 내비게이션 타이틀 초기화
        //self.initTitle() // 타이틀 레이블로 두 줄 표현
        //self.initTitleNew() // 타이틀 컨테이너뷰로 두 줄 표햔
        //self.initTitleImage() // 타이틀 이미지 표현
        self.initTitleInput() // 타이틀 텍스트 필드 추가
    }//end of viewDidLoad

    //텍스트 필드를 이용하여 타이틀을 구성하는 메소드
    func initTitleInput(){
        //텍스트 필드 객체 생성(텍스트 필드를 수동으로 생성하면 아래 속성들을 설정해 줘야 한다.)
        let tf = UITextField()
        tf.frame = CGRect(x: 0, y: 0, width: 300, height: 35)
        tf.backgroundColor = .white //배경 색상을 흰색으로
        tf.font = UIFont.systemFont(ofSize: 13) //입력할 글씨 크기를 13픽셀로
        tf.autocapitalizationType = .none //자동 대문자 변환 속성은 사용하지 않도록
        tf.autocorrectionType = .no //자동 입력 기능 해제
        tf.spellCheckingType = .no //스펠링 체크 기능 해제
        tf.keyboardType = .URL //URL 입력 전용 키보드
        tf.keyboardAppearance = .dark
        tf.layer.borderWidth = 0.3 //테두리 경계선 두께
        tf.layer.borderColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.0).cgColor
        
        //타이틀 뷰 속성에 대입
        self.navigationItem.titleView = tf
        
        //내비게이션 바 좌측 아이템 커스텀
       /* let v = UIView()
        v.frame = CGRect(x: 0, y: 0, width: 150, height: 37)
        v.backgroundColor = .brown
        
        let leftItem = UIBarButtonItem(customView: v)
        self.navigationItem.leftBarButtonItem = leftItem
        
        //우측 바 아이템 영역 커스텀
        let rv = UIView()
        rv.frame = CGRect(x: 0, y: 0, width: 100, height: 37)
        rv.backgroundColor = .red
        let rightItem = UIBarButtonItem(customView:  rv)
        self.navigationItem.rightBarButtonItem = rightItem*/
        
        //왼쪽 아이템 영역에 들어갈 뷰
        let back = UIImage(named: "arrow-back")
    
        let leftItem = UIBarButtonItem(image: back, style: .plain, target: self, action: nil)
        
        //왼쪽 아이템 영역에 이미지 뷰 설정
        self.navigationItem.leftBarButtonItem = leftItem
        
        //오른쪽 아이템 영역에 들어갈 컨테이너 뷰
        let rv = UIView()
        rv.frame = CGRect(x: 0, y: 0, width: 70, height: 37)
        
        let rItem = UIBarButtonItem(customView: rv)
        self.navigationItem.rightBarButtonItem = rItem
        
        //카운트 값을 표시할 레이블 구성
        let cnt = UILabel()
        cnt.frame = CGRect(x: 10, y: 8, width: 20, height: 20)
        cnt.font = UIFont.boldSystemFont(ofSize: 10)
        cnt.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.0)
        cnt.text = "12"
        cnt.textAlignment = .center
        
        //외곽선
        cnt.layer.cornerRadius = 3 //모서리 둥글게 처리
        cnt.layer.borderWidth = 2
        cnt.layer.borderColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.0).cgColor
        
        //레이블을 서브 뷰로 추가
        rv.addSubview(cnt)
        
        //more 버튼 구현
        let more = UIButton(type: .system)
        more.frame = CGRect(x: 50, y: 10, width: 16, height: 16)
        more.setImage(UIImage(named: "more"), for: .normal)
        
        rv.addSubview(more)
        
    }//end of initTitleInput
    
    //타이틀에 이미지를 표시하는 메소드
    func initTitleImage(){
        let img = UIImage(named: "swift_logo")
        let imgV = UIImageView(image: img)
        
        self.navigationItem.titleView = imgV
    }//end of initTitleImage
    
    
    //컨테이너뷰(오브젝트 라이브러리 컨테이너뷰와 다름)를 이용하여 타이틀 두 줄 표현
    func initTitleNew() {
      // ① 복합적인 레이아웃을 구현할 컨테이너 뷰
      let containerView = UIView(frame:CGRect(x: 0, y: 0, width: 200, height: 36))
      
      // ② 상단 레이블 정의
      let topTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 18))
      topTitle.numberOfLines = 1
      topTitle.textAlignment = .center
      topTitle.font = UIFont.systemFont(ofSize: 15)
      topTitle.textColor = UIColor.white
      topTitle.text = "58개 숙소"
      
      // ③ 하단 레이블 정의
      let subTitle = UILabel(frame: CGRect(x: 0, y: 18, width: 200, height: 18))
      subTitle.numberOfLines = 1
      subTitle.textAlignment = .center
      subTitle.font = UIFont.systemFont(ofSize: 12)
      subTitle.textColor = UIColor.white
      subTitle.text = "1박(1월 10일 ~ 1월 11일)"
      
      // ④ 상하단 레이블을 컨테이너 뷰에 추가한다.
      containerView.addSubview(topTitle)
      containerView.addSubview(subTitle)
      
      // ⑤ 내비게이션 타이틀에 컨테이너 뷰를 대입한다.
        /**
                    titview 속성에는 하나의 뷰 객체만 대입할 수 있으므로  두 개 이상의 객체로 이루어진 복합 레이아웃을 구성하려면 뷰를 하나 추가하여 컨테이너 역할로 사용하고, 그 내부를 필요한 개체들로 채워 넣어야 한다.
         */
      self.navigationItem.titleView = containerView
      
      // 배경 색상 설정
      let color = UIColor(red:0.02, green:0.22, blue:0.49, alpha:1.0)
      self.navigationController?.navigationBar.barTintColor = color
    }//end of initTitleNew
    
    //단순 레이블 객체 하나를 이용하여 타이틀 두 줄 표현
    func initTitle() {
      // ① 내비게이션 타이틀용 레이블 객체
      let nTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
      
      // ② 속성 설정
      nTitle.numberOfLines = 2 // 두 줄까지 표시되도록 설정
      nTitle.textAlignment = .center // 중앙 정렬
      nTitle.textColor = UIColor.white // 추가된 구문) 텍스트 색상 설정
      nTitle.font = UIFont.systemFont(ofSize: 15) // 폰트 크기
      nTitle.text = "58개 숙소 \n 1박(1월 10일 ~ 1월 11일)"
      
      // ③ 내비게이션 타이틀에 입력
      self.navigationItem.titleView = nTitle
      
      // 추가된 구문) 배경 색상 설정
      let color = UIColor(red:0.02, green:0.22, blue:0.49, alpha:1.0)
      self.navigationController?.navigationBar.barTintColor = color
    }//end of initTitle
    
    
}//end of class

