//
//  TutorialContentsVC.swift
//  MyMemory
//
//  Created by icoinnet on 2021/08/16.
//

import UIKit

class TutorialContentsVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    
    var pageIndex: Int! //페이지 번호
    var titleText: String! //타이틀
    var imageFile: String! //이미지 정보
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //이지를 꽉 채울 수 있게
        self.bgImageView.contentMode = .scaleAspectFit
        
        //전달받은 타이틀 정보를 레이블 객체에 대입하고 크기를 조절한다
        self.titleLabel.text = self.titleText
        self.titleLabel.sizeToFit() //레이블 너비를 텍스트 길이에 맞춤 
        
        //전달받은 이미지 정보를 이미지 뷰에 대입한다.
        self.bgImageView.image = UIImage(named: self.imageFile)
    }//end of viewDidLoad

}//end of class
