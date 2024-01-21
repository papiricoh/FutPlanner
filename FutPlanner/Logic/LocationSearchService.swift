//
//  LocationSearchService.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 21/1/24.
//

import Foundation
import MapKit

class LocationSearchService: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    @Published var searchResults = [MKLocalSearchCompletion]()
    private var searchCompleter = MKLocalSearchCompleter()

    override init() {
        super.init()
        self.searchCompleter.delegate = self
    }

    func search(query: String) {
        searchCompleter.queryFragment = query
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        DispatchQueue.main.async {
            self.searchResults = completer.results
        }
    }

    func getCoordinates(for item: MKLocalSearchCompletion, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let request = MKLocalSearch.Request(completion: item)
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let coordinate = response?.mapItems.first?.placemark.coordinate, error == nil else {
                completion(nil)
                return
            }
            completion(coordinate)
        }
    }
}
