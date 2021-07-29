//
//  ListViewController.swift
//  Chapter03-Alert
//
//  Created by icoinnet on 2021/07/29.
//

import UIKit

class ListViewController: UITableViewController {
    var delegate: MapAlertViewController? //델리게이트 패턴 적용(실전편 - P427)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize.height = 220
    }//end of viewDidLoad
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }//end of tableView
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row) 번째 옵션입니다."
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        
        return cell
    }//end of tableView

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectRowAt(indexPath: indexPath)
    }//end of tableView

}//end of ListViewController
