//
//  LogVC.swift
//  Chapter07-CoreData
//
//  Created by icoinnet on 2021/08/22.
//

import UIKit

class LogVC: UITableViewController {

    var board: BoardMO! //게시글 정보를 전달받을 변수
    
    lazy var list: [LogMO]! = {
        return self.board.logs?.array as! [LogMO]
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationItem.title = self.board.title
    
        
    }//end of viewDidLoad
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.list[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "logcell")!
        cell.textLabel?.text = "\(row.regdate!)에 \(row.type.toLogType())되었습니다."
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        
        return cell
    }
    
}//end of class

public enum LogType: Int16 {
    case create = 0 //생성
    case edit = 1 //수정
    case delete = 2 //삭제
}//end of LogType

extension Int16 {
    func toLogType() -> String {
        switch self {
        case 0 : return "생성"
        case 1 : return "수정"
        case 2 : return "삭제"
        default : return ""
        }
    }
}//end of extension
