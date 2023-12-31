//
//  ViewController.swift
//  EventMe
//
//  Created by Harrison Anthony on 9/15/23.
//
import UIKit
import Alamofire
import CoreLocation

class EventMe: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
        
    @IBOutlet weak var viewAll: UITextView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var barSearch: UISearchBar!

        var events  = [Event]()
        
        var tableData = ["1", "2", "3", "4"]
        
        let token = "37ayPhhA3QBrYhKjSnEzolZvKwGowA4VkJWSro6dq09by_jXBL-db-2ygGCX4osuKI7MT-VPQZTHg48ohf7dac2gKVESPOAjOAehDLoAoZSnZXwqZCub2pJ6jJ7HZHYx"

        override func viewDidLoad() {
            
            super.viewDidLoad()
            
            self.setupTable()
            
            self.barSearch.delegate = self
            
            self.barSearch.searchTextField.text = "Scituate, MA"
     
        }

        func fetchEventsFromAddress(_ address: String, completion:@escaping(_ success: Bool, _ events: [Event]?)->()) {

            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(address) {
                placemarks, error in

                weak var weakSelf = self

                if let placemark = placemarks?.first,
                   let location = placemark.location {

                    let lat = location.coordinate.latitude
                    let lng = location.coordinate.longitude

                    weakSelf?.fetchEvents(lat: lat, lng: lng) {
                        success, events in

                        if success {
                            completion(true, events)
                        } else {
                            completion(false, nil)
                        }
                        return
                    }

                }
                completion(false, nil)
            }

        }
        
        func fetchEvents(lat: Double, lng: Double, completion: @escaping(_ success: Bool, _ events: [Event]?) -> ()) {

            let headers: HTTPHeaders = [
                    "Authorization" : String(format: "Bearer %@", token),
                    "Content-Type": "application/json"
                ]

            AF.request( "https://api.yelp.com/v3/events?limit=20&latitude=42.195831&longitude=-70.726387", headers: headers)
                .response { response in

                if let data = response.data,
                   let jsonString = String(data: data, encoding: .utf8) {

                    print(jsonString)

                    if let jsonDecoded = try? JSONDecoder().decode(Events.self, from: data) {

                        if let events = jsonDecoded.events {
                            self.events = events
                            completion(true, events)
                            return
                        }

                    }

                }
                completion(false, nil)
            }
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

            guard let searchValue = searchBar.searchTextField.text else {
                // Print Error Message
                return
            }

            fetchEventsFromAddress(searchValue) {
                success, events in

                if success,
                   let events = events {
                    self.events = events
                    print(events)
                    self.tableView.reloadData()
                } else {
                    //  Print Error Message
                }

            }
        }

        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.searchTextField.text = ""
            self.events = [Event]()
            self.tableView.reloadData()
        }
    }


