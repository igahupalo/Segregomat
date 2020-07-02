//
//  MapView.swift
//  Segregomat
//
//  Created by Iga Hupalo on 01/07/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import SwiftUI
import MapKit

struct PszokMapView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        ZStack {
            Color("colorBackground").edgesIgnoringSafeArea(.all)

            MapView().navigationBarBackButtonHidden(true).navigationBarItems(leading: BackButton(presentationMode: presentationMode)).navigationBarTitle("SEGREGOMAT", displayMode: .inline)
        }

    }
}



struct MapView: UIViewRepresentable {
    @State var pszoks: [Pszok] = []
    @ObservedObject var pszokMapViewModel: PszokMapViewModel = PszokMapViewModel()
    var locationManager = CLLocationManager()

    init() {
        pszokMapViewModel.fetchPszoks()
    }

    func setupManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        setupManager()
        let mapView = MKMapView(frame: UIScreen.main.bounds)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.addAnnotations(pszokMapViewModel.pszoks)
        uiView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        uiView.showsUserLocation = true
        let status = CLLocationManager.authorizationStatus()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            let location: CLLocationCoordinate2D = locationManager.location!.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
            let region = MKCoordinateRegion(center: location, span: span)
            uiView.setRegion(region, animated: true)
        }
    }

    //    class AnnotationButton: UIButton {
    //        var annotation: MKAnnotation
    //
    //        init(annotation: MKAnnotation) {
    //            self.annotation = annotation
    //            super.init(frame: .zero)
    //        }
    //
    //        required init?(coder aDecoder: NSCoder) {
    //            fatalError("init(coder:) has not been implemented")
    //        }
    //    }

    class CustomAnnotationView: MKMarkerAnnotationView {
        override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
            super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
            markerTintColor = UIColor(named: "green")
            canShowCallout = true
            let launchMapButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            rightCalloutAccessoryView = launchMapButton

            // icon: https://icons8.com

            //            launchMapButton.setImage(UIImage(named: "map"), for: .normal)
            //            launchMapButton.setImage(UIImage(named: "mapHighlighted"), for: .highlighted)
            //            launchMapButton.addTarget(self, action:#selector(openMapForPlace), for: .touchUpInside)
            //            rightCalloutAccessoryView?.backgroundColor = UIColor(named: "green")
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }



        //        @objc func openMapForPlace(sender: UIButton) {
        //            let annotation: MKAnnotation = sender.annotation
        //
        //            let regionDistance:CLLocationDistance = 10000
        //            let regionSpan = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        //            let options = [
        //                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
        //                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        //            ]
        //            let placemark = MKPlacemark(coordinate: annotation.coordinate, addressDictionary: nil)
        //            let mapItem = MKMapItem(placemark: placemark)
        //            mapItem.name = "\(String(describing: annotation.title))"
        //            mapItem.openInMaps(launchOptions: options)
        //        }
    }


}



struct PszokMapView_Previews: PreviewProvider {
    static var previews: some View {
        PszokMapView()
    }
}
