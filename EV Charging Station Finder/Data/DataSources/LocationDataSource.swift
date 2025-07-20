//
//  LocationDataSource.swift
//  EV Charging Station Finder
//
//  Created by Jesus Daniel Medina Cruz on 20/07/25.
//

import CoreLocation

protocol LocationDataSource {
    func requestLocationAuthorization()
    func startUpdatingLocation() -> AsyncStream<Result<CLLocationCoordinate2D, Error>>
    func stopUpdatingLocation()
}

enum LocationError: Error {
    case authorizationDenied
    case unknown
}
