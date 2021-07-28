//
//  SceneDelegate.swift
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
 - 꼼꼼한 재은씨 실전편 - p325
 */
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        //1) 윈도우 객체에 연결된 루트 뷰 컨트롤러를 읽어와 UITabBarController로 타입 캐스팅한다.
        if let tbC = self.window?.rootViewController as? UITabBarController {
            //2) 루트뷰 컨트롤러를 통해 탭 바의 아이템 객체 배열을 가져온다.
            if let tbItems = tbC.tabBar.items {
                //3) 탭 바 아이템에 커스텀 이미지를 등록한다.
                //tbItems[0].image = UIImage(named: "calendar")
                //tbItems[1].image = UIImage(named: "file-tree")
                //tbItems[2].image = UIImage(named: "photo")
                
                //3) 이미지의 렌더링 모드를 변경하여 원본 이미지 그대로 아이콘 표시하기
                tbItems[0].image = UIImage(named: "designbump")?.withRenderingMode(.alwaysOriginal)
                tbItems[1].image = UIImage(named: "rss")?.withRenderingMode(.alwaysOriginal)
                tbItems[2].image = UIImage(named: "facebook")?.withRenderingMode(.alwaysOriginal)
                
                //탭 바 아이템 전체를 순회하면서 selectedImage 속성에 이미지를 설정한다.
                for tbItem in tbItems {
                    let image = UIImage(named: "checkmark")?.withRenderingMode(.alwaysOriginal)
                    tbItem.selectedImage = image // 탭 바 아이템이 활성화되었을 때 표시
                    
                    //탭 바 아이템별 텍스트 색상 속성을 설정한다.(프록시로 설정하기 위해 주석)
                    //tbItem.setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .disabled)
                    //tbItem.setTitleTextAttributes([.foregroundColor: UIColor.red], for: .selected)
                    //tbItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 15)], for: .normal)
                }//end of for
                /**
                    * 외형 프록시 객체는 화면 요소별 속성을 고통으로 적용할 수 있는 객체이다. 다시 말해 외형 프록시 객체에 속성을 설정해 두면, 해당 타입으로 생성된 모든 객체에 해당 속성이 적용이 된다.
                 */
                //외형 프록시 객체를 이용하여 아이템의 타이틀과 색상 폰트 크기를 설정한다.
                let tbItemProxy = UITabBarItem.appearance()
                tbItemProxy.setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .disabled)
                tbItemProxy.setTitleTextAttributes([.foregroundColor: UIColor.red], for: .selected)
                tbItemProxy.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 15)], for: .normal)
                
                
                //4) 탭 바 아이템에 타이틀을 설정한다.
                tbItems[0].title = "calendar"
                tbItems[1].title = "file"
                tbItems[2].title = "photo"
            }
            //5) 탭 바 아이템의 이미지 색상을 변경한다.
            tbC.tabBar.tintColor = .white //선택된 탭 바 아이템의 색상
            tbC.tabBar.unselectedItemTintColor = .gray //선택되지 않은 나머지 탭 바 아이템의 색상
            
            //6) 탭 바에 배경 이미지를 설정한다
            tbC.tabBar.backgroundImage = UIImage(named: "menubar-bg-mini")
            tbC.tabBar.clipsToBounds = true // 주어진 영역을 벗어나는 이미지 부분 제거하기
        }//end of if
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

