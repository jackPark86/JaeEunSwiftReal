//
//  MapKitViewController.swift
//  Chapter03-Alert
//
//  Created by icoinnet on 2021/07/28.
//

import UIKit
import MapKit

class MapKitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //뷰 컨트롤러에 맵킷 뷰를 추가한다.
        let mapkitView = MKMapView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.view = mapkitView//맵킷 뷰를 루트 뷰로 설정
        self.preferredContentSize.height = 200 // 외부(여기서는 알림창)에서 뷰 컨트롤러를 읽어들일 때 참고하는 사이즈
        
        //위치 정보를 설정한다.(위/경도를 사용)
        let pos = CLLocationCoordinate2D(latitude: 37.514322, longitude: 126.894623)
        
        //조도에서 보여줄 넓이, 일종의 축척, 숫자가 작을수록 좁은 범위를 확대시켜서 보여준다.
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        
        //지도 영역을 정의
        let region = MKCoordinateRegion(center: pos, span: span)
        
        //지도 뷰에 표시
        mapkitView.region = region
        mapkitView.regionThatFits(region)

         //위치를 핀으로 표시
        let point = MKPointAnnotation()
        point.coordinate = pos
        mapkitView.addAnnotation(point)
        
    }//end of viewDidLoad


}//end of class 
