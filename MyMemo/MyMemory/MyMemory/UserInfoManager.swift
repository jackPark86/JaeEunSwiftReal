//
//  UserInfoKey.swift
//  MyMemory-Free
//
//  Created by icoinnet on 2021/08/16.
//

import UIKit

struct UserInfoKey {
    //저장에 사용할 키
    static let loginId = "LOGINID"
    static let account = "ACCOUNT"
    static let name = "NAME"
    static let profile = "PROFILE"
    static let tutorial = "TUTORIAL" 
}//end of UserInfoKey

//계정 및 사용자 정보를 저장 관리하는 클래스
class UserInfoManager {
    
    //연산 프로퍼티 loginId 정의
    var loginId : Int {
        get {
            return UserDefaults.standard.integer(forKey: UserInfoKey.loginId)
        }
        set(v) {
            let ud = UserDefaults.standard
            ud.set(v, forKey: UserInfoKey.loginId)
            ud.synchronize()
        }
    }//end of loginId
    
    //연산 프로퍼티 account 정의
    var account: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.account)
        }
        set (v) {
            let ud = UserDefaults.standard
            ud.set(v, forKey: UserInfoKey.account)
            ud.synchronize()
        }
    }//end of account
    
    //연산 프로퍼티 name 정의
    var name : String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.name)
        }
        
        set (v) {
            let ud = UserDefaults.standard
            ud.set(v, forKey: UserInfoKey.name)
            ud.synchronize()
        }
    }//end of name
    
    //연산 프로퍼티 profile 정의
    var profile: UIImage? {
        
        // 내부적으로 Base64 형태로 인코딩된 문자열을 다시 바이너리 타입으로 복구 과정을 거쳐 이미지를 사용한다.
        get {
            let ud = UserDefaults.standard
            if let _profile = ud.data(forKey: UserInfoKey.profile) {
                return UIImage(data: _profile)
            } else {
                return UIImage(named: "account.jpg") //이미지가 없다면 기본 이미지로
            }
        }
        
        //UIImage 타입은 프로퍼티 리스트에 직접 저장할 수 없어서, Data 타입으로 (Base64 인코딩)변환한 다음에 저장해야 한다.
        //UIImage 타입을 Data 타입으로 변환하기 위해서는 UIImage::pngData() 메소드가 사용된다. (p.803)
        set(v) {
            if v != nil {
                let ud = UserDefaults.standard
                ud.set(v!.pngData(), forKey: UserInfoKey.profile)
                ud.synchronize()
            }
        }
    }//end of profile
    
    //로그인 상태를 판별해 주는 연산 프로퍼티 isLogin을 정의한다
    var isLogin: Bool {
        //로그인 아이디가 0이거나 계정이 비어 있으면
        if self.loginId == 0 || self.account == nil {
            return false
        } else {
            return true
        }
    }//end of isLogin
    
    
    func login(account : String, passwd: String) -> Bool {
        //TODO: 이 부분은 나중에 서버와 연동되는 코드로 대체될 예정
        if account.isEqual("aaaa@naver.com") && passwd.isEqual("1234"){
            let ud = UserDefaults.standard
            ud.set(100, forKey: UserInfoKey.loginId)
            ud.set(account, forKey: UserInfoKey.account)
            ud.set("재은 씨", forKey: UserInfoKey.name)
            ud.synchronize()
            return true
        } else {
            return false
        }//end of if ~ else
        
    }//end of login
    
    //ios애는 세션 개념이 ㅇ벗어 프로퍼티 리스트에 저장된 사용자 데이터를 삭제하여 로그아웃 상태로 만든다.
    // 데이터 일괄 삭제는  ud.removePersistentDomain(forName: <#T##String#>) 할 수 있지만 모든 데이터가 삭제 되므로 주의 (p806)
    func logout() -> Bool {
        let ud = UserDefaults.standard
        
        ud.removeObject(forKey: UserInfoKey.loginId)
        ud.removeObject(forKey: UserInfoKey.account)
        ud.removeObject(forKey: UserInfoKey.name)
        ud.removeObject(forKey: UserInfoKey.profile)
        
        ud.synchronize()
        return true
    }//end of logout
    
    
    
}//end of class
