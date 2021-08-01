//
//  MemoFormVC.swift
//  MyMemory
//
//  Created by icoinnet on 2021/07/17.
//

import UIKit

/**
    메모 작성 폼 컨트롤러 
 */
class MemoFormVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    /**
     UIImagePickerControllerDelegate, UINavigationControllerDelegate는
     이미지 피커 컨트롤러의 델리게이트 메소드를 구현하는 데에 필요한 것.
     */
    
    var subject:String! //제목 저장 변수
    
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var preview: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.contents.delegate = self
        
        //커스텀 배경 이미지 설정 (p523 - chapter03)
        // 공식적으로는 배경 이미지를 텍스트 뷰에 설정하는 방법이 없지만, UIColor 객체에 패턴화된 이미지를 배경 색상처럼 사용할 수 있는 방식으로 사용
        let bgImage = UIImage(named: "memo-background.png")!
        self.view.backgroundColor = UIColor(patternImage: bgImage)
        
        //텍스트 뷰의 기본 속성
        self.contents.layer.borderWidth = 0
        self.contents.layer.borderColor = UIColor.clear.cgColor
        self.contents.backgroundColor = UIColor.clear //색상을 제거할 때 사용
        
        //줄 간격
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 9
        self.contents.attributedText = NSAttributedString(string: " ", attributes: [.paragraphStyle: style])
        self.contents.text = ""
    }//end of viewDidLoad
    
    //저장 버튼을 클릭했을 때 호출되는 메소드
    @IBAction func save(_ sender: Any) {
        //커스텀 경고창에 사용될 콘텐츠 뷰 컨트롤러 구성(p528 - chapter03)
        let alertV = UIViewController()
        let iconImage = UIImage(named: "warning-icon-60")
        alertV.view = UIImageView(image: iconImage)
        alertV.preferredContentSize = iconImage?.size ?? CGSize.zero
        
        //1. 내용을 입력하지 않았을 경우, 경고한다(chpater02)
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            //추가(p528 - chapter03) 콘텐츠 뷰 영역에 alertV를 등록한다
            alert.setValue(alertV, forKey: "contentViewController")
            
            self.present(alert, animated: true)
            return
        }//end of guard
    
        //2. MemoData 객체를 생성하고, 데이터를 담는다.
        let data = MemoData()
        
        data.title = self.subject //제목
        data.contents = self.contents.text //내용
        data.image = self.preview.image //이미지
        data.regdate = Date() //작성 시각
        
        //3.앱 델리게이트 객체를 읽어온 다음, memolist 배열에 MemoData 객체를 추가한다.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memolist.append(data)
        
        //4. 작성폼 화면을 종료하고, 이전 화면으로 되돌아간다.
        _ = self.navigationController?.popViewController(animated: true)
    }//end of save
    
    //카메라 버튼을 클릭했을 때 호출되는 메소드
    @IBAction func pick(_ sender: Any) {
        //이미지 피커 인스턴스를 생성
        let picker = UIImagePickerController()
        
        picker.delegate = self //이미지 피커 컨트롤러 인스턴스의 델리게이트 속성을 현재의 뷰 컨트롤러 인스턴스로 설정한다
        picker.allowsEditing = true // 이미지 피커 컨트롤러의 이미지 편집을 허용한다.
        
        //이미지 피커 화면을 표시한다.
        self.present(picker, animated: false)
    }//end oof pick
    
    
    //델리게이트 메소드 : 사용자가 이미지를 선택하면 자동으로 이 메소드가 호출
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //선택된 이미지를 미리보기에 출력한다.
        self.preview.image = info[.editedImage] as? UIImage
        
        //이미지 피커 컨트롤러를 닫는다.
        picker.dismiss(animated: false)
    }//end of imagePickerController
    
    //델리게이트 메소드 : 사용자가 텍스트 뷰에 뭔가를 입력하면 자동으로 이 메소드가 호출
    func textViewDidChange(_ textView: UITextView) {
        //내용의 최대 15자리까지 읽어 subject 변수에 저장한다.
        let contents = textView.text as NSString //String 타입 보다 NSString 타입이 관련 메소드가 다양하기 때문에 사용하기 좋다, 두 타입은 서로 완전 호한된다.
        let length = ((contents.length > 15) ? 15 : contents.length)
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        //내비게이션 타이틀에 표시한다.
        self.navigationController?.title = self.subject
    }//end of textViewDidChange
    
    
    // touchesEnded() 메소드는 사용자가 뷰를 터치했을 때 호출되는 메소드
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //내비게이션 바의 토글 처리(p526 - chapter03)
        let bar = self.navigationController?.navigationBar
        
        let ts = TimeInterval(0.3)
        UIView.animate(withDuration: ts){ //애미메이션 구현용 메소드
            bar?.alpha = (bar?.alpha == 0 ? 1 : 0)
        }
    }//end of touchesEnded
    
    
    
}//end of class
