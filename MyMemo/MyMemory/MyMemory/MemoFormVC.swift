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
    
    }//end of viewDidLoad
    
    //저장 버튼을 클릭했을 때 호출되는 메소드
    @IBAction func save(_ sender: Any) {
        //1. 내용을 입력하지 않았을 경우, 경고한다
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
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
    
    
    
    
    
}//end of class
