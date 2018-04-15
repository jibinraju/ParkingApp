//
//  ParkingViewDataSource.swift
//  Parking
//
//  Created by Jibin Raju on 15/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import MapKit

class ParkingViewDataSource : NSObject, MKMapViewDelegate {
    // MARK: - Properties
    private let zones: Array<ParkingZone>
    private let mapAnnotationReuseIdentifier: String
    private weak var delegate: ParkingViewDataSourceDelegate?
    
    // MARK: - Accessors
    init(mapAnnotationReuseIdentifier: String, zones: Array<ParkingZone>, delegate: ParkingViewDataSourceDelegate? = nil) {
        self.zones = zones
        self.mapAnnotationReuseIdentifier = mapAnnotationReuseIdentifier
        self.delegate = delegate
    }
    
    func mapAnnotations() -> Array<MKAnnotation> {
        var annotations = Array<MKAnnotation>()
        for parkingZone in zones {
            let parkingZoneAnnotation = ParkingZoneAnnotation()
            parkingZoneAnnotation.parkingZone = parkingZone
            annotations.append(parkingZoneAnnotation)
        }
        return annotations
    }
    
    // MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil;
        }

        var annotationPinView: MKPinAnnotationView;
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: mapAnnotationReuseIdentifier) as? MKPinAnnotationView {
            dequeuedView.annotation = annotation;
            annotationPinView = dequeuedView;
        }else{
            annotationPinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: mapAnnotationReuseIdentifier);
        }
        annotationPinView.canShowCallout = true;
        annotationPinView.pinTintColor = MKPinAnnotationView.greenPinColor()
        let rightButton = UIButton(type: .contactAdd)
        annotationPinView.rightCalloutAccessoryView = rightButton
        let parkingIconView = UIImageView(image: UIImage(named: "parkingAnnotationIcon"))
        annotationPinView.leftCalloutAccessoryView = parkingIconView
        return annotationPinView;
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let parkingZoneAnnotation = view.annotation as? ParkingZoneAnnotation
        delegate?.parkingViewDataSource(self, didSelectedParkingZone: (parkingZoneAnnotation?.parkingZone)!)
    }
}

protocol ParkingViewDataSourceDelegate: NSObjectProtocol {
    func parkingViewDataSource(_ parkingViewDataSource: ParkingViewDataSource, didSelectedParkingZone parkingZone: ParkingZone)
}
