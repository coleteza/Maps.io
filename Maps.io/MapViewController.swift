//
//  MapViewController.swift
//  Maps.io
//
//  Created by Cole Teza on 1/28/18.
//  Copyright © 2018 Cole Teza. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate {
    //Counter to keep map from constantly refreshing [TEMPORARY SOLUTION]
   var count = 0
    
    // Map Connect
    @IBAction func SearchButton(_ sender: Any) {
        //Allows for Location Search Button to be pressed and for assocaited bar and keyboard to appear
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
        print("Success")
    }
    
    //Function for when our users hits search
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        //Ignoring User
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        //Activity Indicator
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        
        //HideSearchBar
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        //Create the Search Requests
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start { (response, error) in
            
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil {
                print("Error")
            }
            else {
                //Remove Annotations
                let annotations = self.map.annotations
                self.map.removeAnnotation(annotations as! MKAnnotation)
                
                //Getting Data
                let lattitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                //Create Annotation
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(lattitude!, longitude!)
                self.map.addAnnotation(annotation)
               
                
                //** Zoom in on Pin **
                
                //Zoom in map on pins location
                let span:MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
                
                //Create variable for users lat and long location
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lattitude!, longitude!)
                
                //Create variable for Region using "myLocation" and "span"
                let region:MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
                
                //Set map equal to the region declared
                self.map.setRegion(region, animated: true)
            }
            
        }
    }
    
    //Map
    @IBOutlet weak var map: MKMapView!
    
    //Map Refresh Button
    @IBAction func RefreshButton(_ sender: Any) {
        count=0
    }
    
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Get the most recernt location data from the array "CLLocation"
        let location = locations[0]
        
        //Zoom in map on users location
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.5, 0.5)
        
        //Create variable for users lat and long location
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        //Create variable for Region using "myLocation" and "span"
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        
        if count == 0 {
        //Set map equal to the region declared
        map.setRegion(region, animated: true)
        }
        
        //Show the <you are here> on the map
        self.map.showsUserLocation = true
        count = 1
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        manager.delegate = self
        // Set User Location Accuracy to Best
        manager.desiredAccuracy = kCLLocationAccuracyBest
        // Request Authorization
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        //Added Annotations Manually
        let pin1 = MKPointAnnotation()
        let spot1:CLLocationCoordinate2D = CLLocationCoordinate2DMake(37.771016, -122.477177)
        
        pin1.title = "Paddle Boats SF"
        pin1.coordinate = spot1

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
