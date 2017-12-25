//
//  reportingViewController.swift
//  FinanceSide
//
//  Created by Sofiane Bouragba Zrif  on 25/10/2017.
//  Copyright © 2017 Sofiane Bouragba Zrif . All rights reserved.
//

import UIKit

class reportingViewController: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var menuButton: UIButton!
    let transition = CircularTransition()
    
    @IBOutlet weak var weekMonthYear: UISegmentedControl!
    
    @IBOutlet weak var eurusdTotal: UILabel!
    @IBOutlet weak var eurusdGain: UILabel!
    @IBOutlet weak var eurusdLosses: UILabel!
    @IBOutlet weak var usdcadTotal: UILabel!
    @IBOutlet weak var usdcadGain: UILabel!
    @IBOutlet weak var usdcadLosses: UILabel!
    @IBOutlet weak var audusdTotal: UILabel!
    @IBOutlet weak var audusdGain: UILabel!
    @IBOutlet weak var audusdLosses: UILabel!
    @IBOutlet weak var gbpusdTotal: UILabel!
    @IBOutlet weak var gbpusdGain: UILabel!
    @IBOutlet weak var gbpusdLosses: UILabel!
    @IBOutlet weak var eurjpyTotal: UILabel!
    @IBOutlet weak var eurjpyGain: UILabel!
    @IBOutlet weak var eurjpyLosses: UILabel!
    @IBOutlet weak var usdchfTotal: UILabel!
    @IBOutlet weak var usdchfGain: UILabel!
    @IBOutlet weak var usdchfLosses: UILabel!
    @IBOutlet weak var audcadTotal: UILabel!
    @IBOutlet weak var audcadGain: UILabel!
    @IBOutlet weak var audcadLosses: UILabel!
    @IBOutlet weak var cadjpyTotal: UILabel!
    @IBOutlet weak var cadjpyGain: UILabel!
    @IBOutlet weak var cadjpyLosses: UILabel!
    @IBOutlet weak var usdjpyTotal: UILabel!
    @IBOutlet weak var usdjpyGain: UILabel!
    @IBOutlet weak var usdjpyLosses: UILabel!
    
    
    
    @IBAction func weekMonthYear(_ sender: Any) {
        if(weekMonthYear.selectedSegmentIndex == 0) {
            telechargementData()
        }
        if(weekMonthYear.selectedSegmentIndex == 1) {
            telechargementData()
        }
        if(weekMonthYear.selectedSegmentIndex == 2) {
            telechargementData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()
       
        telechargementData()
        
      

        // Do any additional setup after loading the view.
    }
    
  
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
//    $$$$$$$$$$$$$ BACKGROUND COLOR GRADIENT $$$$$$$$$$$$$
    func createGradientLayer() {
        var gradientLayer: CAGradientLayer!
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        let firstColor = UIColor(red: 0/255, green: 180/255, blue: 140/255, alpha: 1.0).cgColor
        let lastColor = UIColor(red: 37/255, green: 103/255, blue: 192/255, alpha: 1.0).cgColor
        //        gradientLayer.locations = [0.0, 19.0]
        gradientLayer.colors = [firstColor, lastColor]
        
        viewBackground.layer.addSublayer(gradientLayer)
    }
    
    
//    $$$$$$$$$$$   MENU TRANSITION $$$$$$$$$$
    // $$$$$$$$$$$$$$$$$$ PREPARE SEGUE $$$$$$$$$$$$$$$$$
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let menuVC = segue.destination as! menuViewController
        menuVC.transitioningDelegate = self
        menuVC.modalPresentationStyle = .custom
    }
    
    
    //    $$$$$$$$$$$$$$$$$$$ ANIMATION $$$$$$$$$$$$$$$$
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = menuButton.center
        transition.circleColor = UIColor(red: 0/255, green: 180/255, blue: 140/255, alpha: 1.0)
        
        return transition
    }
    
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = menuButton.center
        transition.circleColor = UIColor(red: 37/255, green: 103/255, blue: 192/255, alpha: 1.0)
        
        return transition
    }
    
    
    
    
    
    func telechargementData() {
        let urlPath = "http://www.gael-jasawant-naime.com/reporting.php"
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) {
            (data,response,error) in
            if error != nil {
                print("Failed to download data")
            } else {
                print("Data downloaded")
                
                self.parseJSON(data!)
                
            }
        }
        task.resume()
    }
    
    func parseJSON(_ data:Data) {
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        } catch let error as NSError {
            print(error)
        }
        var jsonElement = NSDictionary()
        let reportingList = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            jsonElement = jsonResult[i] as! NSDictionary
            
            let report = Reporting()
            
            if let total = jsonElement["COUNT(currencyPair)"] as? String,
                let gain = jsonElement["SUM(gain)"] as? String,
                let loss = jsonElement["SUM(loss)"] as? String,
                let pair = jsonElement["currencyPair"] as? String {
                
                report.gain = Double(gain)
                report.loss = Double(loss)
                report.total = Int(total)
                report.pair = pair
 
            }
            
            reportingList.add(report)
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
                self.loadDataToView(report: reportingList)
        })
    }
    
    
    func loadDataToView(report: NSMutableArray) {
        
        for i in 0 ..< report.count {
            let temp = report[i] as! Reporting
            
            let pair = temp.pair
            
            if(pair == "EURUSD") {
                eurusdTotal.text = String(temp.total!)
                eurusdGain.text = String(format:"%.2f €", temp.gain!)
                eurusdLosses.text = String(format:"%.2f €", temp.loss!)
            }
            if(pair == "USDCAD") {
                usdcadTotal.text = String(temp.total!)
                usdcadGain.text = String(format:"%.2f €", temp.gain!)
                usdcadLosses.text = String(format:"%.2f €", temp.loss!)
            }
            if(pair == "AUDUSD") {
                audusdTotal.text = String(temp.total!)
                audusdGain.text = String(format:"%.2f €", temp.gain!)
                audusdLosses.text = String(format:"%.2f €", temp.loss!)
            }
            if(pair == "GBPUSD") {
                gbpusdTotal.text = String(temp.total!)
                gbpusdGain.text = String(format:"%.2f €", temp.gain!)
                gbpusdLosses.text = String(format:"%.2f €", temp.loss!)
            }
            if(pair == "EURJPY") {
                eurjpyTotal.text = String(temp.total!)
                eurjpyGain.text = String(format:"%.2f €", temp.gain!)
                eurjpyLosses.text = String(format:"%.2f €", temp.loss!)
            }
            if(pair == "USDCHF") {
                usdchfTotal.text = String(temp.total!)
                usdchfGain.text = String(format:"%.2f €", temp.gain!)
                usdchfLosses.text = String(format:"%.2f €", temp.loss!)
            }
            if(pair == "AUDCAD") {
                audcadTotal.text = String(temp.total!)
                audcadGain.text = String(format:"%.2f €", temp.gain!)
                audcadLosses.text = String(format:"%.2f €", temp.loss!)
            }
            if(pair == "CADJPY") {
                cadjpyTotal.text = String(temp.total!)
                cadjpyGain.text = String(format:"%.2f €", temp.gain!)
                cadjpyLosses.text = String(format:"%.2f €", temp.loss!)
            }
            if(pair == "USDJPY") {
                usdjpyTotal.text = String(temp.total!)
                usdjpyGain.text = String(format:"%.2f €", temp.gain!)
                usdjpyLosses.text = String(format:"%.2f €", temp.loss!)
            }
        }
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
