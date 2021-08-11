//
//  ListViewController.swift
//  Chapter05-UserDefaults
//
//  Created by icoinnet on 2021/08/10.
//

import UIKit

class ListViewController: UITableViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var married: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let plist = UserDefaults.standard
        
        //저장된 값을 꺼내어 각 컨트롤에 설정한다.
        self.name.text = plist.string(forKey: "name")//이름
        self.married.isOn = plist.bool(forKey: "married") //결혼 여부
        self.gender.selectedSegmentIndex = plist.integer(forKey: "gender") //성별
        
    }//end of class 

    /*
     자식 클래스에서 메소드가 구현되지 않으면 동일한 부모 메소드가 호출되는 객체지향 특성으로 메소드 삭제 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /**
         정적인 셀을 개수를 구하기 위해 부모 컨트롤러에서 가져다 사용한다. (P693)
         오버라이드 멧소드에서 부모 메소드가 처리하던 기능을 구현하고 싶을 때에는 직접 구현하기보다는 부모 메소드를 호출하는 방식으로 기능을 구현한다.
         */
        return super.tableView(tableView, numberOfRowsInSection: section)
    }//end of tableView
    */

    @IBAction func changeGender(_ sender: UISegmentedControl) {
        //성별을 선택하는 세그먼트 컨트롤의 값을 프로퍼티 리스트에 저장하는 내용
        
        let value = sender.selectedSegmentIndex // 0이면 남자, 1이면 여자
        
        let plist = UserDefaults.standard //기본 저장소 객체를 가져온다.
        plist.set(value, forKey: "gender") //"gender" 라는 키로 값을 저장한다.
        plist.synchronize() //동기화 처리
        
    }//end of changeGender
    
 
    @IBAction func changeMarried(_ sender: UISwitch) {
        let value = sender.isOn //true면 기혼, false면 미혼
        
        let plist = UserDefaults.standard //기본 저장소 객체를 가져온다.
        plist.set(value, forKey: "married") //"married"라는 키로 값을 저장한다
        plist.synchronize() //동기화 처리
    }//end of changeMarried
    
    //사용자가 테이블 뷰 셀을 선택했을 때 호출되는 메소드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 0 { //첫 번째 셀이 클릭되었을 때에만
//            //입력이 가능한 알림창을 띄워 이름을 수정할 수 있도록 한다.
//            let alert = UIAlertController(title: nil, message: "이름을 입력하세요", preferredStyle: .alert)
//
//            //입력 필드 추가
//            alert.addTextField(){
//                $0.text = self.name.text //name 레이블의 텍스트를 입력폼에 기본값으로 넣어준다.
//            }
//            //버튼 및 액션 추가
//            alert.addAction(UIAlertAction(title: "OK", style: .default) { (_) in
//                //사용자가 OK 버튼을 누르면 입력 필드에 입력된 값을 저장한다.
//                let value = alert.textFields?[0].text
//
//                let plist = UserDefaults.standard //기본 저장소를 가져온다.
//                plist.setValue(value, forKey: "name") //"name"이라는 키로 값을 저장한다.
//                plist.synchronize() //동기화 처리
//
//                self.name.text = value //수정된 값을 이름 레이블에도 적용한다.
//            })
//            //알림창을 띄운다.
//            self.present(alert, animated: false, completion: nil)
//        }
    
    }//end of tableView
    
    //UITapGuesture 제스처를 통한 label 호출 메소드(p711)
    //뷰는 기본적으로 사용자와 상호반응하지 않도록 설계되어 있다. UIControl 클래스를 상속받지 않은 일반 뷰 객체가 제스처를 사용하려면 시스템에 상호반응할 객체라는 것을 직접 알려주어야 한다.
    @IBAction func edit(_ sender: Any) {
        //입력이 가능한 알림창을 띄워 이름을 수정할 수 있도록 한다.
        let alert = UIAlertController(title: nil, message: "이름을 입력하세요", preferredStyle: .alert)
        
        //입력 필드 추가
        alert.addTextField(){
            $0.text = self.name.text //name 레이블의 텍스트를 입력폼에 기본값으로 넣어준다.
        }
        //버튼 및 액션 추가
        alert.addAction(UIAlertAction(title: "OK", style: .default) { (_) in
            //사용자가 OK 버튼을 누르면 입력 필드에 입력된 값을 저장한다.
            let value = alert.textFields?[0].text
            
            let plist = UserDefaults.standard //기본 저장소를 가져온다.
            plist.setValue(value, forKey: "name") //"name"이라는 키로 값을 저장한다.
            plist.synchronize() //동기화 처리
            
            self.name.text = value //수정된 값을 이름 레이블에도 적용한다.
        })
        //알림창을 띄운다.
        self.present(alert, animated: false, completion: nil)
    }//end of edit
    
}//end of class
