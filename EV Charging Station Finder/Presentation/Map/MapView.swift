//
//  MapView.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 18/07/25.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
  @Binding var coordinate: CLLocationCoordinate2D
  @Binding var span: MKCoordinateSpan
  var annotations: [MKPointAnnotation] = []

  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView()
    mapView.delegate = context.coordinator
    return mapView
  }

  func updateUIView(_ uiView: MKMapView, context: Context) {
    let region = MKCoordinateRegion(center: coordinate, span: span)
    uiView.setRegion(region, animated: true)
    uiView.removeAnnotations(uiView.annotations)
    uiView.addAnnotations(annotations)
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapView

    init(_ parent: MapView) {
      self.parent = parent
    }

    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
      DispatchQueue.main.async {
        self.parent.coordinate = mapView.centerCoordinate
        self.parent.span = mapView.region.span
      }
    }
  }
}
