//
//  SceneDelegate.swift
//  MyMemory
//
//  Created by icoinnet on 2021/07/15.
//

import UIKit

/**
 SceneDelegate는 iOS 13부터 추가된 클래스이며, UI 라이프사이클을 관리하는 클래스이다.
 iOS 12까지는 하나의 앱이 하나의 윈도우(Window)만 가지기 때문에 AppDelegate 클래스가  UI의 라이플사이클 관리까지 겸하고 있었는데,
 iOS 13부터 하나의 앱에 여러 개의 윈도우가 동시에 사용될 수 있게 됨에 따라 UI 라이플사이클을 전담 관리해줄 클래스가 필요해졌다.
 이를 위해 추가된 클래스가 SceneDelegate이다.
 이 클래스는 기존의 AppDelegate가 담당하던 앱의 상태 변화, 즉 앱이 실행되고 백그라운드로 들어갔다가 다시 포그라운드로 나오는 등의 변화를 대신 감지하고 그에 맞는 메소드를 호출하는 역할을 한다.
 루트 뷰 컨트롤러에 대한 참조도 기존 AppDelegate  클래스에서 제공한던 것이, 이제는 SceneDelegate 클래스에서 제공하도록 변경되었다.
   꼼꼼한 재은씨 실전편 -  p 325
 */

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        //페이지 인디케이터 설정을 위한 외형 템플릿 구문
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.backgroundColor = .white
        
    }//end of scene

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

