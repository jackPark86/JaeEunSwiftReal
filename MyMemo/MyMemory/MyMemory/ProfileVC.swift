//
//  ProfileVC.swift
//  MyMemory
//
//  Created by icoinnet on 2021/08/07.
//

import UIKit

/**
  테이블 뷰가 사용되긴 했지만, 테으블 뷰 컨트롤러는 아니다. 따라서 테이블 뷰를 위한 프로토콜을 직접 추가해야 테이블 뷰를 구현할 수 있다.
 UITableViewDelegate는 테이블 뷰에서 발생하는 사용자 액션에 응답하기 위한 프로토콜이며,
 UITableViewDataSource는 데이터 소스를 이용하여 테이블 뷰를 구성하기 위해 필요한 프로토콜이다. (P631)
 */
class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let uinfo = UserInfoManager() //개인 정보 관리 메니저
    
    let profileImage = UIImageView() //프로필 사진 이미지
    let tv = UITableView() //프로필 목록
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "프로필"
        
        //뒤로 가기 버튼 처리
        let backBtn = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(close(_:)))
        self.navigationItem.leftBarButtonItem = backBtn
        
        self.navigationController?.navigationBar.isHidden = true //내비게이션 바 숨김 처리
        
        //배경 이미지 설정
        let bg = UIImage(named: "profile-bg")
        let bgImg = UIImageView(image: bg)
         
        bgImg.frame.size = CGSize(width: bgImg.frame.size.width, height: bgImg.frame.size.height)
        bgImg.center = CGPoint(x: self.view.frame.width / 2, y: 40)
        
        bgImg.layer.cornerRadius = bgImg.frame.size.width / 2
        bgImg.layer.borderWidth = 0
        bgImg.layer.masksToBounds = true
        self.view.addSubview(bgImg)
        
        //1) 프로필 사진에 들어갈 기분 이미지
        //let image = UIImage(named: "account.jpg")
        let image = self.uinfo.profile
        
        //2) 프로필 이미지 처리
        self.profileImage.image = image
        self.profileImage.frame.size = CGSize(width: 100, height: 100)
        self.profileImage.center = CGPoint(x: self.view.frame.width / 2, y: 260) //중앙 정렬하기 위해 frame 속성이 아닌 center 속성에 값을 설정
        
        //3) 프로필 이미지 둥글게 만들기
        self.profileImage.layer.cornerRadius = self.profileImage.frame.width / 2
        self.profileImage.layer.borderWidth = 0
        self.profileImage.layer.masksToBounds = true
        
        //4) 루트 뷰에 추가
        self.view.addSubview(self.profileImage)
        
        //프로필 이미지 뷰 객체에 탭 제스처를 등록하고, 이를 profile()과 연결
        let tap = UITapGestureRecognizer(target: self, action: #selector(profile(_:)))
        self.profileImage.addGestureRecognizer(tap)
        self.profileImage.isUserInteractionEnabled = true //해당 객체가 사용자와 상호반응 할 수 있도록 허럭해 주는 역할
        
        //테이블 뷰
        self.tv.frame = CGRect(x: 0, y: self.profileImage.frame.origin.y + self.profileImage.frame.size.height + 20, width: self.view.frame.width, height: 100)
        self.tv.dataSource = self
        self.tv.delegate = self
        
        self.view.addSubview(self.tv)
        
        //뷰를 위로 올리는 방법
        //self.view.bringSubviewToFront(self.tv)
        //self.view.bringSubviewToFront(self.profileImage)
        
        //최초 화면 로딩 시 로그인 상태에 따라 적절히 로그인/로그아웃 버튼을 출력한다
        self.drawBtn()
        
    }//end of viewDidLoad
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }//end of tableView numberOfRowsInSection
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        
        //여기에 셀 구현 내용이 들어갈 예정
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        cell.accessoryType = .disclosureIndicator
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "이름"
            cell.detailTextLabel?.text = self.uinfo.name ?? "Login please"
        case 1:
            cell.textLabel?.text = "계정"
            cell.detailTextLabel?.text = self.uinfo.account ?? "Login please"
        default:
        ()
        }
        return cell
    }//end of tableView cellForRowAt
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.uinfo.isLogin == false {
            //로그인되어 있지 않다면 로그인 창을 띄워 준다.
            self.doLogin(self.tv)
        }
    }//end of tableView didSelectRowAt
     
    
    @objc func close(_ sender: Any){
        self.presentingViewController?.dismiss(animated: true)
    }//end of close
    
    
    @objc func doLogin(_ sender: Any){
        let loginAlert = UIAlertController(title: "LOGIN", message: nil, preferredStyle: .alert)
        
        //알림창에 들어갈 입력폼 추가
        loginAlert.addTextField() { (tf) in
            tf.placeholder = "Your Account"
        }
    
        loginAlert.addTextField() { (tf) in
            tf.placeholder = "Password"
            tf.isSecureTextEntry = true
        }
        
        //알림창 버튼 추가
        loginAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        loginAlert.addAction(UIAlertAction(title: "Login", style: .destructive) { (_) in
            let account = loginAlert.textFields?[0].text ?? ""  //첫 번째 필드 : 계정
            let passwd = loginAlert.textFields?[1].text ?? "" //두 번째 필드 : 비밀번호
            
            if self.uinfo.login(account: account, passwd: passwd) {
                // TODO: (로그인 성공 시 처리할 내용)
                self.tv.reloadData() // 테이블 뷰를 갱신한다
                self.profileImage.image = self.uinfo.profile // 이미지 프로필을 갱신한다
                self.drawBtn() //로그인 상태에 따라 적절히 로그인/로그아웃 버튼을 출력
            
            } else {
                let msg = "로그인에 실패하였습니다."
                let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style:.cancel))
                self.present(alert, animated: false)
            }//end of if else
        })
        self.present(loginAlert, animated: false)
    }//end of doLogin
    
    @objc func doLogout(_ sender: Any){
        let msg = "로그아웃하시겠습니까?"
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "확인", style: .destructive){ (_) in
            if self.uinfo.logout() {
                //TODO: (로그아웃 시 처리할 내용)
                self.tv.reloadData() //테이블 뷰를 갱신한다
                self.profileImage.image = self.uinfo.profile //이미지 프로필을 갱신한다.
                self.drawBtn() //로그인 상태에 따라 적절히 로그인/로그아웃 버튼을 출력
            }
        })
        self.present(alert, animated: false)
        
    }//end of doLogout
    
    //로그인/로그아웃 버튼
    func drawBtn() {
        //버튼을 감쌀 뷰를 정의한다.
        let v = UIView()
        v.frame.size.width = self.view.frame.width
        v.frame.size.height = 40
        v.frame.origin.x = 0
        v.frame.origin.y = self.tv.frame.origin.y + self.tv.frame.height
        v.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
        
        self.view.addSubview(v)
        
        //버튼을 정의한다.
        let btn = UIButton(type: .system)
        btn.frame.size.width = 100
        btn.frame.size.height = 30
        btn.center.x  = v.frame.size.width / 2
        btn.center.y = v.frame.size.height / 2
        
        //로그인 상태일 때는 로그아웃 버튼을, 로그아웃 상태일 때는 로그인 버튼을 만들어 준다.
        if self.uinfo.isLogin == true {
            btn.setTitle("로그아웃", for: .normal)
            btn.addTarget(self, action: #selector(doLogout(_:)), for: .touchUpInside)
        } else {
            btn.setTitle("로그인", for: .normal)
            btn.addTarget(self, action: #selector(doLogin(_:)), for: .touchUpInside)
        }
        v.addSubview(btn)
    }//end of drawBtn
    
    //프로필 사진의 소스 타입을 선택하는 액션 메소드
    @objc func profile(_ sender: UIButton){
        //로그인되어 있지 않을 경우에는 프로필 이미지 등록을 막고 대신 로그인 창을 띄어 준다.
        guard self.uinfo.account != nil else {
            self.doLogin(self)
            return
        }
        
        let alert = UIAlertController(title: nil, message: "사진을 가져올 곳을 선택해 주세요!", preferredStyle: .actionSheet)
        
        //카메라를 사용할 수 있으면
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "카메라", style: .default) { (_) in
                self.imgPicker(.camera)
            })
        }
        
        //저장된 앨범을 사용할 수 있으면
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            alert.addAction(UIAlertAction(title: "저장된 앨범", style: .default){ (_) in
                self.imgPicker(.savedPhotosAlbum)
            })
        }
        
        //포토 라이브러리를 사용할 수 있으면
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            alert.addAction(UIAlertAction(title: "포토 라이브러리", style: .default){ (_) in
                self.imgPicker(.photoLibrary)
            })
        }
        
        //취소 버튼 추가
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        //액션 시트 창 실행
        self.present(alert, animated: true)
    }//end of profile
    
    //이미지 피커 컨트롤러를 실행할 커스텀 메소드
    func imgPicker(_ source : UIImagePickerController.SourceType){
        
        let picker = UIImagePickerController()
        picker.sourceType = source
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true)
        
    }//end of imgPicker
    
    //이미지를 선택하면 이 메소드가 자동으로 호출된다. (p820)
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.uinfo.profile = img
            self.profileImage.image = img
        }
        
        //이 구문을 누룩하면 이미지 피커 컨트롤러 창은 닫히지 않는다.
        picker.dismiss(animated: true)
    }//end of imagePickerController
    
    

}//end of class
