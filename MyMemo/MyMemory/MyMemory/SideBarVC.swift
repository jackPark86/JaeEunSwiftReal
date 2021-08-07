//
//  SideBarVC.swift
//  MyMemory
//
//  Created by icoinnet on 2021/08/07.
//

import UIKit

class SideBarVC: UITableViewController {
    
    let nameLabel = UILabel() //이름 레이블
    let emailLabel = UILabel() //이메일 레이블
    let profileImage = UIImageView() //프로필 이미지
    

    //목록 데이터 배열
    let titles = ["새글 작성하기", "친구 새글", "달력으로 보기", "공지사항", "통게" , "계정 관리"]
    
    //아이콘 데이터 배열
    let icons = [
        UIImage(named: "icon01.png"),
        UIImage(named: "icon02.png"),
        UIImage(named: "icon03.png"),
        UIImage(named: "icon04.png"),
        UIImage(named: "icon05.png"),
        UIImage(named: "icon06.png"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //테이블 뷰의 헤더 역할을 할 뷰를 정의한다
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70))
        headerView.backgroundColor = .brown
        
        //테이블 뷰의 헤더 뷰로 지정한다
        self.tableView.tableHeaderView = headerView
        self.tableView.tableFooterView = UIView() //테이블 뷰 아래 영역을 View 처리(separator 삭제 시킴)
      
        //이름 레이블의 속성의 정의하고, 헤더 뷰에 추가한다.
        self.nameLabel.frame = CGRect(x: 70, y: 15, width: 100, height: 30) //위치와 크기를 정의
        self.nameLabel.text = "스위프트 개발자" //기본 텍스트
        self.nameLabel.textColor = .white //텍스트 색상
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 15) //폰트 사이즈
        self.emailLabel.backgroundColor = .clear //배경 색상
        headerView.addSubview(self.nameLabel) //헤더 뷰에 추가
        
        //이메일 레이블의 속성을 정의하고, 헤더 뷰에 추가한다.
        self.emailLabel.frame = CGRect(x: 70, y: 30, width: 100, height: 30)
        self.emailLabel.text = "jackpark@gmail.com"
        self.emailLabel.textColor = .white //텍스트 색상
        self.emailLabel.font = UIFont.systemFont(ofSize: 11) //폰트 사이즈
        self.emailLabel.backgroundColor = .clear //배경 색상
        
        headerView.addSubview(self.emailLabel) //헤더 뷰에 추가
        
        //기본 이미지를 구현한다
        let defaultProfile = UIImage(named: "account.jpg")
        self.profileImage.image = defaultProfile //이미지 등록
        self.profileImage.frame =  CGRect(x: 10, y: 10, width: 50, height: 50)//위치와 크기를 정의
        
        view.addSubview((self.profileImage))
        
        //프로필 이미지 둥글게 만들기
        self.profileImage.layer.cornerRadius = (self.profileImage.frame.width / 2)
        
        self.profileImage.layer.borderWidth = 0 // 테두리 두께 0으로
        self.profileImage.layer.masksToBounds = true //마스크 효과(기존의 이미지 위에 덧씌워서 일부를 가리는 역할을 하는 레이어 p621)
        view.addSubview(self.profileImage) //헤더 뷰에 추가
        
    
    }//end of viewDidLoad

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.titles.count
    }//end of numberOfRowsInSection tableView

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //재사용 큐에서 테이블 셀을 꺼내 온다. 없으면 새로 생성한다.
        let id = "menucell" //테이블 셀 식별자
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
                
        //타이틀과 이미지를 대입한다.
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.imageView?.image = self.icons[indexPath.row]
        
        //폰트 설정
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
       
        return cell
    }//end of cellForRowAt tableView
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 { //선택된 행이 새글 작성 메뉴일 대
            //사이드 바 컨트롤러에서 프론트 컨트롤러를 직접 참조할 방법이 없어 메인 컨트롤러를 이용해 연결
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "MemoForm") //MemoForm 값을 식별자로 하는 뷰 컨트롤러 인스턴스 스토리보드 객체로부터 가져온다.
            let target = self.revealViewController()?.frontViewController as! UINavigationController //메인 컨트롤러 객체를 가져와 네비게이션 컨트롤러로 캐스팅
            
            target.pushViewController(uv!, animated: true) //글쓰기 뷰로 전환
            self.revealViewController()?.revealToggle(self) //사이드 바 닫기
        } else if indexPath.row == 5 { //계정 관리
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "_Profile")
            uv?.modalPresentationStyle = .fullScreen
            self.present(uv!, animated: true){
                self.revealViewController()?.revealToggle(self)
            }
        }
    }//end of tableView
 
    
}//end of class
