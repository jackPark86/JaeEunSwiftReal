//
//  SidebarViewController.swift
//  Chapter04-SideBarDIY
//
//  Created by icoinnet on 2021/08/03.
//

import UIKit

/**
 SidebarViewController 클래스는 왼쪽 옆에서 열릴 사이드 바 화면을 담당하는 뷰 컨트롤러
 이 클래스는 테이블 뷰로 이루어진 목록을 표현하기 위해 테이블 뷰 컨트롤러를 서브 클래싱하고 있다.
 */
class SidebarViewController: UITableViewController {
    
    //메뉴 제목 배열
    let titles = [
        "메뉴 01",
        "메뉴 02",
        "메뉴 03",
        "메뉴 04",
        "메뉴 05"
    ]
    
    let icons = [
        UIImage(named: "icon01.png"),
        UIImage(named: "icon02.png"),
        UIImage(named: "icon03.png"),
        UIImage(named: "icon04.png"),
        UIImage(named: "icon05.png")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //1) 계정 정보를 표시할 레이블 객체를 정의
        let accountLabel = UILabel()
        accountLabel.frame = CGRect(x: 10, y: 30, width: self.view.frame.width, height: 30)
        
        accountLabel.text = "jackpark086@gmail.com"
        accountLabel.textColor = .white
        accountLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        //2) 테이블 뷰 상단에 표시될 뷰를 정의한다
        let v = UIView()
        v.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70)
        v.backgroundColor = .brown
        v.addSubview(accountLabel)
        
        //3) 생성한 뷰 V를 테이블 헤더 뷰 영역에 등록한다.
        self.tableView.tableHeaderView = v
        self.tableView.tableFooterView = UIView() //테이블 뷰 아래 영역을 View 처리(separator 삭제 시킴)
    }//end of viewDidLoad

  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.titles.count
    }//end of tableView

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1) 재사용 큐로부터 테이블 셀을 꺼내 온다.
        let id = "menucell" //재사용 큐에 등록할 식별자
        
       /*var cell = tableView.dequeueReusableCell(withIdentifier: id)
        
        //2) 재사용 큐에 menucell키로 등록된 테이블 뷰 셀이 없다면 새로 추가한다
        if cell == nil {
         //스토리보드의 도움 없이 재사용 큐를 사용하기 위한 초기화 메소드
            cell = UITableViewCell(style: .default, reuseIdentifier: id)
        }*/
        
        // 위의 1), 2)을 nil 병합 연산자 ??를 사용해서 간결한 표현식을 사용
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
        
        
        //3) 타이틀과 이미지를 대입한다.
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.imageView?.image = self.icons[indexPath.row]
        
        //4) 폰트 설정
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        return cell
    }//end of tableView
    
}//end of class
