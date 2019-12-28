//
//  MapView.swift
//  CuacaKini
//
//  Created by Arie on 24/12/19.
//  Copyright © 2019 Arie. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
  private let coordinate: CLLocationCoordinate2D
  
  init(coordinate: CLLocationCoordinate2D) {
    self.coordinate = coordinate
  }
  
  func makeUIView(context: Context) -> MKMapView {
    MKMapView()
  }
  
  func updateUIView(_ view: MKMapView, context: Context) {
    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    let region = MKCoordinateRegion(center: coordinate, span: span)
    
    let annotation = MKPointAnnotation()
    annotation.coordinate = coordinate
    view.addAnnotation(annotation)
    
    view.setRegion(region, animated: true)
  }
}
