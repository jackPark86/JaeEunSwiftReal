//
//  ListVC.swift
//  Chapter07-CoreData
//
//  Created by icoinnet on 2021/08/18.
//

import UIKit
import CoreData

class ListVC: UITableViewController {
    
    //데이터 소스 역할을 할 배열 변수
    lazy var list : [NSManagedObject] = {
        return self.fetch()
    }()

    //데이터를 읽어올 메소드
    func fetch() -> [NSManagedObject] {
        //1. 앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //2. 관리 객체 컨텍스트 참조
        let contex = appDelegate.persistentContainer.viewContext
        
        //3. 요청 객체 생성
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Board")
        
        //4. 데이터 가져오기
        let result = try! contex.fetch(fetchRequest)
        return result
    } //end of fetch
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

  
}//end of class
