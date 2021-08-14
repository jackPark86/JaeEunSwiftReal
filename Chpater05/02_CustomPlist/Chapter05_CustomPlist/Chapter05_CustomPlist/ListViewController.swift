//
//  ListViewController.swift
//  Chapter05_CustomPlist
//
//  Created by icoinnet on 2021/08/12.
//

import UIKit

class ListViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var account: UITextField!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var married: UISwitch!
    
    var accountlist = [String]()
    
    //메인 번들에 정의된 PList 내용을 저장할 딕셔너리
    var defaultPlist : NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //메인 번들 UserInfo.plist가 포함되어 있으면 이를 읽어와 딕셔너리에 담는다.
        if let defaultPListPath = Bundle.main.path(forResource: "UserInfo", ofType: "plist") {
            self.defaultPlist = NSDictionary(contentsOfFile: defaultPListPath)
        }
    
        //기본 저장소 객체 불러오기
        let plist = UserDefaults.standard
        
        //불러온 값 을설정
        self.name.text = plist.string(forKey: "name")//이름
        self.married.isOn = plist.bool(forKey: "married") //결혼 여부
        self.gender.selectedSegmentIndex = plist.integer(forKey: "gender")//성별
    
        let accountlist = plist.array(forKey: "accountlist") as? [String] ?? [String]()
        self.accountlist = accountlist
        
        if let account = plist.string(forKey: "selectedAccount"){
            self.account.text = account
            let customPlist = "\(account).plist" //읽어올 파일명
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) //앱 내에 생성된 문서 디렉터리 경로를 구함
            let path = paths[0] as NSString
            let clist = path.strings(byAppendingPaths: [customPlist]).first! //커스텀 프로퍼티 파일을 읽어 옴
            let data = NSDictionary(contentsOfFile: clist)  // 저장된 파일을 읽어와서 수정 불가 딕셔너리 객체로 전환한다.
            
            self.name.text = data?["name"] as? String
            self.gender.selectedSegmentIndex = data?["gender"] as? Int ?? 0
            self.married.isOn = data?["married"] as? Bool ?? false
        } else {
            self.account.text = ""
        }
        
    
        //사용자 계정의 값이 비어 있다면 값을 설정하는 것을 막는다.
        if (self.account.text?.isEmpty)! {
            self.account.placeholder = "등록된 계정이 없습니다."
            self.gender.isEnabled = false //비활성화 처리
            self.married.isEnabled = false // 비활성화 처리
        }//end of if
        
        //피커 객체 생성
        let picker = UIPickerView()
        
        //1) 피커 뷰의 델리게이트 객체 지정
        picker.delegate = self
        //2) account 텍스트 필드 입력 방식을 가상 키보드 대신 피커 뷰로 설정
        self.account.inputView = picker

        //툴 바 객체의 정의
        let toolbar = UIToolbar()
        toolbar.frame =  CGRect(x: 0, y: 0, width: 0, height: 35)
        toolbar.barTintColor = .lightGray
        
        //액세서리 뷰 영역에 툴 바를 표시
        self.account.inputAccessoryView = toolbar
        
        //툴 바에 들어갈 닫기 버튼
        let done = UIBarButtonItem()
        done.title = "Done"
        done.target = self
        done.action = #selector(pickerDone(_:))
        
        //가변 폭 버튼 정의(툴바의 Done버튼을 오른쪽으로 지정하기 위해 p.760)
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        // 신규 계정 등록 버튼
        let new = UIBarButtonItem()
        new.title = "New"
        new.target = self
        new.action = #selector(newAccount(_:))
        
        //버튼을 툴 바에 추가()
        toolbar.setItems([new,flexSpace, done], animated: true)
        
        //내비게이션 바에 newAccount 메소드와 연결된 버튼을 추가한다
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newAccount(_:)))
        self.navigationItem.rightBarButtonItems = [addBtn]
        
    }//end of viewDidLoad

    
    /*
     피커뷰 메소드 구현
     */
    //생성할 컴포넌트의 개수를 정의
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }//end of numberOfComponents
    
    //지정된 컴포넌트가 가질 목록의 길이를 정의
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.accountlist.count
    }//end of pickerView

    //지정된 컴포넌트의 목록 각 행에 출력될 내용을 정의
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.accountlist[row]
    }//end of pickerView
    
    //지정된 컴포넌트의 목록 각 행을 사용자가 선택했을 때 실행할 액션을 정의
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //1) 선택된 계정값을 텍스트 필드에 입력
        let account = self.accountlist[row] //선택된 계정
        self.account.text = account
        
        //사용자가 계정을 생성하면 이 계정을 선택한 것으로 간주하고 저장
        let plist = UserDefaults.standard
        plist.set(account, forKey: "selectedAccount")
        plist.synchronize()
    }//end of pickerView
    
    
    //피커 툴바 done 버튼
    @objc func pickerDone(_ sender: Any){
        //피커 뷰 닫음
        self.view.endEditing(true)
        
        //선택된 계정에 대한 커스텀 프로퍼티 파일을 읽어와 세팅한다.
        if let _account = self.account.text{
            
            let customPlist = "\(_account).plist" //읽어올 파일명
            
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) //앱 내에 생성된 문서 디렉터리 경로를 구함
            let path = paths[0] as NSString
            let clist = path.strings(byAppendingPaths: [customPlist]).first! //커스텀 프로퍼티 파일을 읽어 옴
            let data = NSDictionary(contentsOfFile: clist)  // 저장된 파일을 읽어와서 수정 불가 딕셔너리 객체로 전환한다.
            
            self.name.text = data?["name"] as? String
            self.gender.selectedSegmentIndex = data?["gender"] as? Int ?? 0
            self.married.isOn = data?["married"] as? Bool ?? false
        }//end of if
    }//end of pickerDone
    
    //피커 툴바 new 버튼
    @objc func newAccount(_ sender: Any){
        self.view.endEditing(true) //일단 열려있는 입력용 뷰부터 닫아준다.
        
        //알림창 객체 생성
        let alert = UIAlertController(title: "새 계정을 입력하세요", message: nil, preferredStyle: .alert)
        
        //입력폼 추가
        alert.addTextField(){
            $0.placeholder = "ex) abc@gmail.com"
        }
        
        //버튼 및 액션 정의
        alert.addAction(UIAlertAction(title: "OK", style: .default) { (_) in
            if let account = alert.textFields?[0].text {
                //계정 목록 배열에 추가한다
                self.accountlist.append(account)
                //계정 텍스트 필드에 표시한다.
                self.account.text = account
                
                //컨트롤 값을 모두 초기화한다.
                self.name.text = ""
                self.gender.selectedSegmentIndex = 0
                self.married.isOn = false
                
                //계정 목록을 통째로 저장한다.
                let plist = UserDefaults.standard
                
                plist.set(self.accountlist, forKey: "accountlist")
                plist.set(account, forKey: "selectedAccount")
                plist.synchronize()
                
                //입력 항목을 활성화한다
                self.gender.isEnabled = true
                self.married.isEnabled = true
            }
        })
        
        //알림창 오픈
        self.present(alert, animated: false, completion: nil)
    }//end of newAccount
    
    
    @IBAction func changeGender(_ sender: UISegmentedControl) {
        let value = sender.selectedSegmentIndex //0이면 남자, 1이면 여자
        
        // 커스텀 프로퍼티 저장소에 추가하기 위한 주석 처리
       // let plist = UserDefaults.standard //기본 저장소 객체를 가져온다.
       // plist.set(value, forKey: "gender") // "gender"라는 키로 값을 저장한다.
       // plist.synchronize() //동기화 처리
        
        //커스텀 plist 저장 로직 시작
        let customPlist = "\(self.account.text!).plist" //읽어올 파일명
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) //앱 내에 생성된 문서 디렉터리 경로를 구함
        let path = paths[0] as NSString
        let plist = path.strings(byAppendingPaths: [customPlist]).first! //커스텀 프로퍼티 파일을 읽어 옴
        let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary(dictionary: self.defaultPlist) //읽어온 파일을 딕셔너리 객체로 반환, 만약 없으면 새로운 딕셔너리 객체 생성
        
        data.setValue(value, forKey: "gender")
        data.write(toFile: plist, atomically: true)
        
    }//end of changeGender
    
    
    @IBAction func changeMarried(_ sender: UISwitch) {
        let value = sender.isOn //true 기혼, false면 미혼
        
        // 커스텀 프로퍼티 저장소에 추가하기 위한 주석 처리
        //let plist = UserDefaults.standard //기본 저장소 객체를 가져온다.
        //plist.set(value, forKey: "married") //"married"라는 키로 값을 저장한다.
        //plist.synchronize() // 동기화 처리
        
        //커스텀 plist 저장 로직 시작
        let customPlist = "\(self.account.text!).plist" //읽어올 파일명
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) //앱 내에 생성된 문서 디렉터리 경로를 구함
        let path = paths[0] as NSString
        let plist = path.strings(byAppendingPaths: [customPlist]).first! //커스텀 프로퍼티 파일을 읽어 옴
        let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary(dictionary: self.defaultPlist) //읽어온 파일을 딕셔너리 객체로 반환, 만약 없으면 새로운 딕셔너리 객체 생성
        
        data.setValue(value, forKey: "married")
        data.write(toFile: plist, atomically: true)
        
        print("custom plist = \(plist)")
        
    }//end of changeMarried
    
    //테이블 뷰에 대한 델리게이트 메소드
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 && !(self.account.text?.isEmpty)! { //두 번째 셀이 클릭되었을 때에만
            //입력이 가능한 알림창을 띄워 이름을 수정할 수 있도록 한다.
            let alert = UIAlertController(title: nil, message: "이름을 입력하세요", preferredStyle: .alert)
            
            //입력 필드 추가
            alert.addTextField() {
                $0.text = self.name.text // name 레이블의 텍스트를 입력폼에 기본값으로 넣어준다.
            }
            
            //버튼 및 액션 추가
            alert.addAction(UIAlertAction(title: "OK", style: .default) { (_) in
                //사용자가 OK 버튼을 누르면 입력 필드에 입력된 값을 저장한다.
                let value = alert.textFields?[0].text
                
                //커스텀 plist를 사용하기 위해 주석
                //let plist = UserDefaults.standard //기본 저장소를 가져온다.
                //plist.setValue(value, forKey: "name") //"name"이라는 키로 값을 저장한다.
                //plist.synchronize()
                
                //커스텀 plist 저장 로직 시작
                let customPlist = "\(self.account.text!).plist" //읽어올 파일명
                let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) //앱 내에 생성된 문서 디렉터리 경로를 구함
                let path = paths[0] as NSString
                let plist = path.strings(byAppendingPaths: [customPlist]).first! //커스텀 프로퍼티 파일을 읽어 옴
                let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary(dictionary: self.defaultPlist) //읽어온 파일을 딕셔너리 객체로 반환, 만약 없으면 새로운 딕셔너리 객체 생성
                
                data.setValue(value, forKey: "name")
                data.write(toFile: plist, atomically: true)
                    
                self.name.text = value
            })
            self.present(alert, animated: false, completion: nil)
        }
    }//end of tableView
    
}//end of class
