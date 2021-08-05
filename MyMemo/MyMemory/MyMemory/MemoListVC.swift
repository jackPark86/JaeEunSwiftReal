//
//  MemoListVC.swift
//  MyMemory
//
//  Created by icoinnet on 2021/07/17.
//

import UIKit

/**
 MemoListVC 클래스는 메모 목록 화면을 구현하는 커스텀 클래스
 */
class MemoListVC: UITableViewController {
    
    //앱 델리게이트 객체의 참조 정보를 읽어온다,
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    //화면이 나타날 때마다 호출되는 메소드
    override func viewWillAppear(_ animated: Bool) {
      //테이블 데이터를 다시 읽어들인다. 이에 따라 행을 구성하는 로직이 다시 실행될 것이다.
        self.tableView.reloadData()
    }//end of viewWillAppear
    
    
    //최초 뷰가 로드되는 시점에만 호출
    override func viewDidLoad() {
        super.viewDidLoad()
        //SWRevealViewController 라이브러리의 revealViewController 객체를 읽어온다.
        if let revealVC = self.revealViewController() {
            
            //바 버튼 아이템 객체를 정의한다.
            let btn = UIBarButtonItem()
            btn.image = UIImage(named: "sidemenu.png") //이미지는 sidemenu.png로
            btn.target = revealVC //버튼 클릭 시 호출할 메소드가 정의된 객체를 지정
            btn.action = #selector(revealVC.revealToggle(_:)) //버튼 클릭 시 라이브러리 revealToggle() 호출
            
            //정의된 바 버튼을 내비게이션 바의 왼쪽 아이템으로 등록한다
            self.navigationItem.leftBarButtonItem = btn
    
            //제스처 객체를 뷰에 추가한다.
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
    }//end of viewDidLoad


    //테이블 행의 개수를 결정하는 메소드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.appDelegate.memolist.count
        NSLog("테이블 뷰 개수 : \(count)")
        return count
    }//end of tableView


    //테이블 뷰 행을 구성하는 메소드(개별 행을 만들어내는 역할)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1. memolist 배열 데이터에서 주어진 행에 맞는 테이터를 꺼낸다.
        let row = self.appDelegate.memolist[indexPath.row]
            
        //2. 이미지 속성이 비어 있을 경우 "memoCell", 아니면 "memoCellWithImage"
        let cellId = row.image == nil ? "memoCell" : "memoCellWithImage"
        
        //3. 재사용 큐로부터 프로포타입 셀의 인스턴스를 전달받는다.
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! MemoCell

        //4. memoCell의 내용을 구성한다.
        cell.subject?.text = row.title
        cell.contents?.text = row.contents
        cell.img?.image = row.image
        
        //5. Date 타입의 날짜를 yyyy-MM-dd HH:mm:ss 포맷에 맞게 변경한다.
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.regdate?.text = formatter.string(from: row.regdate!)
        
        //6. cell 객체를 리턴한다.
        return cell
    }//end of tableView
    
    //테일블의 특정 행이 선택되었을 때 호출되는 메소드, 선택된 행의 정보는 indexPath에 담겨 전달되낟.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        //1. memoList 배열에서 선택된 행에 맞는 데이터를 꺼낸다.
        let row = self.appDelegate.memolist[indexPath.row]
        
        //2. 상세 화면의 인스턴스를 생성한다
        guard let vc = self.storyboard?.instantiateViewController(identifier: "MemoRead") as? MemoReadVC else {
            return
        }
        
        //3. 값을 전달한 다음, 상세 화면으로 이동한다.
        vc.param = row
        self.navigationController?.pushViewController(vc, animated: true)
        
    }//end of tableView
    
    
}//end of class
