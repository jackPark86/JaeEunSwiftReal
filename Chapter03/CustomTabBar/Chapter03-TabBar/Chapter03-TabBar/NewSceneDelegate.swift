//
//  NewSceneDelegate.swift
//  Chapter03-TabBar
//
//  Created by icoinnet on 2021/07/25.
//

import UIKit
/**
 SceneDelegate는 iOS 13부터 추가된 클래스이며, UI 라이프사이클을 관리하는 클래스이다.
 iOS 12까지는 하나의 앱이 하나의 윈도우(Window)만 가지기 때문에 AppDelegate 클래스가  UI의 라이플사이클 관리까지 겸하고 있었는데,
 iOS 13부터 하나의 앱에 여러 개의 윈도우가 동시에 사용될 수 있게 됨에 따라 UI 라이플사이클을 전담 관리해줄 클래스가 필요해졌다.
 이를 위해 추가된 클래스가 SceneDelegate이다.
 이 클래스는 기존의 AppDelegate가 담당하던 앱의 상태 변화, 즉 앱이 실행되고 백그라운드로 들어갔다가 다시 포그라운드로 나오는 등의 변화를 대신 감지하고 그에 맞는 메소드를 호출하는 역할을 한다.
 루트 뷰 컨트롤러에 대한 참조도 기존 AppDelegate  클래스에서 제공한던 것이, 이제는 SceneDelegate 클래스에서 제공하도록 변경되었다.
 */

/* 직접 SceneDelegate 클래스 구현하기 위해서는
1. UIResponder 클래스를 상속받아야 한다.
2. UIWindowSceneDelegate 프로토콜을 구현해야 한다.
3. UIWindow 타입의 멤버 변수 windwo가 정의되어 있어야 한다.
4. Info.plist 파일 [Delegate Class Name] 항목에 등록되어 있어야 한다.
*/
class NewSceneDelegate: UIResponder, UIWindowSceneDelegate {
    // 기존 앱 덷ㄹ리게이트 클래스에 정의되어 있던 UIWindow 객체도 이제는 씬 델리게이트를 통해 제공된다
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        //스토리보드의 도움 없이뷰 컨트롤러까지 생성하여 탭 바에 연결하는 방법을 위해 소스 코드
        // 1) 탭 바 컨트롤러를 생성하고, 배경을 흰색으로 채운다.
        let tbC = UITabBarController()
        tbC.view.backgroundColor = .white
        
        // 2) 성된 tbC를 루트 뷰 컨트롤러로 등록한다.
        self.window?.rootViewController = tbC
        
        //3) 탭 바 아이템에 연결될 뷰 컨트롤러 객체를 생성하나다.
        let view01 = ViewController()
        let view02 = SecondViewController()
        let view03 = ThirdViewController()
        
        //4) 생성된 뷰 컨트롤러 객체들을 탭 바 컨트롤러에 등록한다.
        tbC.setViewControllers([view01,view02, view03], animated: false)
                
        //5) 개별 탭 바 아이템 속성을 설정한다.
        view01.tabBarItem = UITabBarItem(title: "First", image: UIImage(named: "calendar"), selectedImage: nil)
        view02.tabBarItem = UITabBarItem(title: "Second", image: UIImage(named: "file-tree"), selectedImage: nil)
        view03.tabBarItem = UITabBarItem(title: "Third", image: UIImage(named: "photo"), selectedImage: nil)
    }//end of scene
    
}//end of class
