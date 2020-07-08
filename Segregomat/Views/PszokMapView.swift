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
    @EnvironmentObject var session: FirebaseSession

    var body: some View {
        ZStack(alignment: .top) {
            Color("colorBackground").edgesIgnoringSafeArea(.all)

            MapView()
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(
                    leading: BackButton(presentationMode: presentationMode))
                .navigationBarTitle("SEGREGOMAT", displayMode: .inline)
                .environmentObject(session)
        }
    }

    struct MapView: UIViewRepresentable {
        @EnvironmentObject var session: FirebaseSession

        var locationManager = CLLocationManager()
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
            uiView.addAnnotations(session.pszoks)
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

        class CustomAnnotationView: MKMarkerAnnotationView {
            override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
                super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
                markerTintColor = UIColor(named: "green")
                glyphImage = UIImage(named: "pinImage")
                canShowCallout = true
                let launchMapButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                rightCalloutAccessoryView = launchMapButton

            }

            required init?(coder aDecoder: NSCoder) {
                super.init(coder: aDecoder)
            }
        }
    }
}

struct PszokMapView_Previews: PreviewProvider {
    static var previews: some View {
        PszokMapView()
    }
}
