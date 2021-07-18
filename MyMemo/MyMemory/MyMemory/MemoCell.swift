//
//  MemoCell.swift
//  MyMemory
//
//  Created by icoinnet on 2021/07/17.
//

import UIKit

/**
 MemoCell은 프로토타입 셀(테이블 뷰의 셀)에 연결되어 기능 구현을 담당하는 커스텀 클래스
 */
class MemoCell: UITableViewCell {
    
    @IBOutlet weak var subject: UILabel!//메모 제목
    @IBOutlet weak var regdate: UILabel!//메모 일자
    @IBOutlet weak var contents: UILabel!//메노 내용
    @IBOutlet weak var img: UIImageView!//이미지
    

}//end of MemoCell
