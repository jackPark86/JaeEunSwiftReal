//
//  Utils.swift
//  MyMemory
//
//  Created by icoinnet on 2021/08/16.
//

import UIKit

extension UIViewController {

    //읽기 전용 연산 프로퍼티 
    var tutorialSB: UIStoryboard {
        return UIStoryboard(name: "Tutorial", bundle: Bundle.main)
    }
    
    //Tutorial 스토리보드 객체 생성하기
    func instanceTutorialVC(name: String) -> UIViewController? {
        return self.tutorialSB.instantiateViewController(withIdentifier: name)
    }

    
}//end of extension

