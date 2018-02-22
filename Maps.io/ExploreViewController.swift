//
//  ExploreViewController.swift
//  Maps.io
//
//  Created by Cole Teza on 1/28/18.
//  Copyright © 2018 Cole Teza. All rights reserved.
//

import UIKit
import WebKit

class ExploreViewController: UIViewController {

    @IBOutlet weak var VidWinRed: WKWebView!
    @IBOutlet weak var VidWinOrange: WKWebView!
    @IBOutlet weak var VidWinYellow: WKWebView!
   // @IBOutlet weak var VidWinGreen: WKWebView!
    @IBOutlet weak var VidWinBlue: WKWebView!
    @IBOutlet weak var VidWinPurple: WKWebView!
    
    @IBAction func WinButtonGreen(_ sender: Any) {
        if let url = URL(string: "https://www.laweekly.com/news/meet-the-former-angelenos-living-in-a-rent-free-ramshackle-desert-town-slab-city-9093156") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: {(success) in})
            }
        }
    }
 
    
    @IBOutlet weak var exploreHeader: UIImageView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        getVideo(videoCode: "m9R3c0wXySs", color: "red")
        getVideo(videoCode: "ZlcbwUND3bE", color: "orange")
        getVideo(videoCode: "GJ3KIv-DQgI", color: "yellow")
       // getVideo(videoCode: "meet-the-former-angelenos-living-in-a-rent-free-ramshackle-desert-town-slab-city-9093156", color: "green")
        getVideo(videoCode: "4b5hfn90b7w", color: "blue")
        getVideo(videoCode: "w6ffL3PJ2Og", color: "purple")
        
        
        
    }
    
    func getVideo(videoCode: String, color: String){
        
        if (color == "red"){
        let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
            VidWinRed.load(URLRequest(url: url!))
        }
        
        if (color == "orange"){
            let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
            VidWinOrange.load(URLRequest(url: url!))
        }
        
        if (color == "yellow"){
            let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
            VidWinYellow.load(URLRequest(url: url!))
        }
        /*
        if (color == "green"){
            let url = URL(string: "http://www.laweekly.com/news/\(videoCode)")
            VidWinGreen.loadRequest(URLRequest(url: url!))
        }
 */
        
        if (color == "blue"){
            let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
            VidWinBlue.load(URLRequest(url: url!))
        }
        
        if (color == "purple"){
            let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
            VidWinPurple.load(URLRequest(url: url!))
        }
    }
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
