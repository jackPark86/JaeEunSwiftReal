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
class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    

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
        let image = UIImage(named: "account.jpg")
        
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
        
        
        //테이블 뷰
        self.tv.frame = CGRect(x: 0, y: self.profileImage.frame.origin.y + self.profileImage.frame.size.height + 20, width: self.view.frame.width, height: 100)
        self.tv.dataSource = self
        self.tv.delegate = self
        
        self.view.addSubview(self.tv)
        
        //뷰를 위로 올리는 방법
        //self.view.bringSubviewToFront(self.tv)
        //self.view.bringSubviewToFront(self.profileImage)
    }//end of viewDidLoad
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }//end of tableView
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        
        //여기에 셀 구현 내용이 들어갈 예정
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        cell.accessoryType = .disclosureIndicator
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "이름"
            cell.detailTextLabel?.text = "스위프트 개발자"
        case 1:
            cell.textLabel?.text = "계정"
            cell.detailTextLabel?.text = "xxxxxxxx@gmail.com"
        default:
        ()
        }
        return cell
    }//end of tableView
    
    @objc func close(_ sender: Any){
        self.presentingViewController?.dismiss(animated: true)
    }//end of close
    
}//end of class
