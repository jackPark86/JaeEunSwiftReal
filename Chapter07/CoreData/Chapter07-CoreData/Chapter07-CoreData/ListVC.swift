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
        /**
         코어 데이터에 저장된 데이터를 가져올 때에는 요청 사항을 정의한 NSFetchRequest 객체가 사용 됨
            다양한 요청들을 복합적으로 정의 할 수 있음
            1) 어디에서 데이터를 가져올 것인가? (엔터티 지정)
            2) 어떤 데이터를 가져올 것인가? (검색 조건 지정)
            3) 어떻게 데이터를 가져올 것인가? (정렬 조건 지정)
         */
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Board")
        
        // 정렬 속성 설정
        let sort = NSSortDescriptor(key: "regdate", ascending: false) // true - 오름차순 / false - 내림차순
        fetchRequest.sortDescriptors = [sort]
        
        //4. 데이터 가져오기
        //코어 데이터는 컨텍스트 객체를 통해 각각의 CRUD에 해당하는 메소드를 제공함
        let result = try! contex.fetch(fetchRequest)
        return result
    } //end of fetch
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add(_:)))
        self.navigationItem.rightBarButtonItem = addBtn
        self.tableView.tableFooterView = UIView()
    }//end of viewDidLoad

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return self.list.count
    }//end of tableView

    //
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      //해당 데이터 가져오기
        let record = self.list[indexPath.row]
        let title = record.value(forKey: "title") as? String
        let contents = record.value(forKey: "contents") as? String
        
        //셀을 생성하고, 값을 대입한다.
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = contents
        
        return cell
    }//end of tableView
    
    //테이블 행을 선택하면 수정 얼럿 띄우기
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //1. 선택된 행에 해당하는 데이터 가져오기
        let object = self.list[indexPath.row]
        let title = object.value(forKey: "title") as? String
        let contents = object.value(forKey: "contents") as? String
        
        let alert = UIAlertController(title: "게시글 수정", message: nil, preferredStyle: .alert)
        
        //2. 입력 필드 추가(기존 값 입력)
        alert.addTextField(){ $0.text = title}
        alert.addTextField(){ $0.text = contents}
        
        //3버튼 추가(Cancel & Save)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Save", style: .default){ (_) in
            guard let  title = alert.textFields?.first?.text,
                  let contents = alert.textFields?.last?.text else {
                return
            }
            
            //4. 값을 수정하는 메소드를 호출하고 그 결과가 성공이면 테이블 뷰를 리로드한다.
            if self.edit(objcet: object, title: title, contents: contents) == true {
                //self.tableView.reloadData()
                
                //셀의 내용을 직접 수정한다.
                let cell = self.tableView.cellForRow(at: indexPath)
                cell?.textLabel?.text = title
                cell?.detailTextLabel?.text = contents
                
                //수정된 셀을 첫 번째 행으로 이동시킨다.
                let firstIndexPath = IndexPath(item: 0, section: 0)
                self.tableView.moveRow(at: indexPath, to: firstIndexPath)
                
            }
        })
        self.present(alert, animated: false)
    }//end of tableView
    
    //사용자가 액세서리 영역을 탭했을 때 실행
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let object = self.list[indexPath.row]
        let uvc = self.storyboard?.instantiateViewController(withIdentifier: "LogVC") as! LogVC
        
        uvc.board = (object as! BoardMO)
        self.show(uvc, sender: self)
        
    }//end of tableView
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }//end of tableView
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let object = self.list[indexPath.row] //삭제할 대상 객체
        if self.delete(object: object) {
            //코어 데이터에서 삭제되고 나면 배열 목록과 테이블 뷰의 행도 삭제한다
            self.list.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }//end of tableView
    
    
    //
    @objc func add(_ sender: Any){
        let alert = UIAlertController(title: "게시글 등록", message: nil, preferredStyle: .alert)
        
        //입력 필드 추가(이름 & 전화번호)
        alert.addTextField() { $0.placeholder = "제목" }
        alert.addTextField() { $0.placeholder = "내용" }
        
        //버튼 추가(Cancel & Save)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Save", style: .default){ (_) in
            guard let title = alert.textFields?.first?.text, let contents = alert.textFields?.last?.text  else {
                return
            }
            
            //값을 저자하고, 성공이며 테이블 뷰를 리로드한다
            if self.save(title: title, contents: contents) == true {
                self.tableView.reloadData()
            }
        })
        self.present(alert, animated: false)
    }//end of add
    
    //저장
    func save(title: String, contents: String) -> Bool {
        //1. 앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //2. 관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        
        //3. 관리 객체 생성 & 값을 설정
        let object = NSEntityDescription.insertNewObject(forEntityName: "Board", into: context)
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(Date(), forKey: "regdate")
        
        //Log 관리 객체 생성 및 어트리뷰트에 값 대입
        let logObject = NSEntityDescription.insertNewObject(forEntityName: "Log", into: context) as! LogMO
        logObject.regdate = Date()
        logObject.type = LogType.create.rawValue //LogVC에 있는 enum 클래스에서 값을 가져 옴
        
        //게시글 객체의 logs 속성에 새로 생성된 로그 객체 추가
        (object as! BoardMO).addToLogs(logObject)
        
        //4. 영구 저장소에 커밋되고 나면 list 프로퍼티에 추가한다.
        do {
            try context.save()
            //self.list.append(object)
            //최신글을 맨 위로
            self.list.insert(object, at: 0)
            return true
        } catch {
            context.rollback()
            return false
        } //end of do ~ cathch
        
    }//end of save
    
    //삭제
    func delete(object: NSManagedObject) -> Bool {
        //1. 앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //2. 관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        
        //3.컨텍스트로부터 해당 객체 삭제
        context.delete(object)
        
        //4. 영구 저장소에 커밋한다
        do {
            try context.save()
            return true
        } catch {
            context.rollback()
            return false
        }//end of do ~ catch
        
    }//end of delete
    
    //수정 메소드
    func edit(objcet: NSManagedObject, title: String, contents: String) -> Bool {
        //1. 앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //2. 관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        
        //3. 관리 객체의 값을 수정
        objcet.setValue(title, forKey: "title")
        objcet.setValue(contents, forKey: "contents")
        objcet.setValue(Date(), forKey: "regdate")
        
        // Log 관리 객체 생성 및 어트리뷰트에 값 대입
        let logObject = NSEntityDescription.insertNewObject(forEntityName: "Log", into: context) as! LogMO
        logObject.regdate = Date()
        logObject.type = LogType.edit.rawValue //LogVC에 있는 enum 클래스에서 값을 가져 옴
        
        // 게시글 객체의 logs 속성에 새로 생성된 로그 객체 추가
        (objcet as! BoardMO).addToLogs(logObject)
        
        //영구 저장소에 반영한다
        do {
            try context.save()
            self.list = self.fetch() // list 배열을 갱신한다.
            return true
        } catch {
            context.rollback()
            return false
        }//end of do ~ catch
        
    }//end of edit
    
    
}//end of class
