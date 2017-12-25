//
//  newTradeController.swift
//  FinanceSide
//
//  Created by Sofiane Bouragba Zrif  on 22/10/2017.
//  Copyright © 2017 Sofiane Bouragba Zrif . All rights reserved.
//

import UIKit
import Charts





class newTradeController: UIViewController, UIScrollViewDelegate, UIViewControllerTransitioningDelegate {

  
   
    
//    OTHER
    var refreshControl: UIRefreshControl!
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var menuButton: UIButton!
    let transition = CircularTransition()
    var chart:EPieChart!
    
    @IBOutlet weak var viewBackground: UIView!
    
    @IBOutlet weak var weekMonthYearSection: UISegmentedControl!
    
    @IBAction func weekMonthYear(_ sender: Any) {
        if(weekMonthYearSection.selectedSegmentIndex == 0) {
//            print("Week") // time 0
//            loadResultSection(time: 0)
//            loadPerformancesSection()
            telechargementData()
        }
        if(weekMonthYearSection.selectedSegmentIndex == 1) {
//            print("Month") // time 1
//            loadResultSection(time: 1)
//            loadPerformancesSection()
            telechargementData()
        }
        if(weekMonthYearSection.selectedSegmentIndex == 2) {
//            print("Year") // time 2
//            loadResultSection(time: 2)
//            loadPerformancesSection()
            telechargementData()
        }
        
    }
    
//    RESULTS SECTION
    
    @IBOutlet weak var numberOfTrade: UILabel!
    @IBOutlet weak var winningTrade: UILabel!
    @IBOutlet weak var losingTrade: UILabel!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var backgroundResults: UIImageView!
    @IBOutlet weak var averageLabel: UILabel!
    

//    PERFORMANCES SECTION
    @IBOutlet weak var perfChart: LineChartView!
    @IBOutlet weak var backgroundPerformances: UIImageView!
    @IBOutlet weak var maximumLabel: UILabel!
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()
        addShadow(text: backgroundResults)
        addShadow(text: backgroundPerformances)

        
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        scroller.refreshControl = refreshControl
        
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor.cyan
        
        
        
//        $$$$$$$$$$$$$$$$$$$   LOAD SECTIONS $$$$$$$$$$$$$$$$$$$
            telechargementData()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
    

    
//      $$$$$$$$$$$$$$$$$$$$   LOAD FUNCTIONS $$$$$$$$$$$$$$$$$$$$$$
    
    //    Pour charger les nouveaux points, ici faire la connexion avec la bdd
    func loadPerformancesSection(tab: [Double]){
        let paire = ["EURUSD", "AUDCAD", "EURJPY", "CADJPY", "USDJPY", "USDCHF", "GBPJPY", "USDCAD", "GBPUSD", "AUDUSD", "EURCHF", "EURMAD"]
//        let gain = [261.0, 152.0, 183.0,99.0, 423.0, 198.0, 135.0, 55.0, 79.0, 82.0, 142.0, 352.0]
        maximumLabel.text = String(format:"%.2f €", tab.max()!)
        addPoint(dataEntryX: paire, dataEntryY: tab)
    }
    
    func loadSmallStatResultsSection(total:Int, gain:Int, loose:Int) {
        //Ici faire la recherche bdd
        
        numberOfTrade.text = String(total)
        winningTrade.text = String(gain)
        losingTrade.text = String(loose)
    }
    
    
   
    

    func loadResultSection(total: [Double], gain: [Double], loss:[Double]) {
// Oon clean toutes les vues !
        for i in chartView.subviews {
            i.removeFromSuperview()
        }

        let sumTotal = total.reduce(0,+)
        let avegare:Double = sumTotal / Double(total.count)
        averageLabel.text = String(format:"%.2f €", avegare)
        
        let tradeTotal = total.count
        let losing = loss.count
        let winning = gain.count
        

        let chartTest = EPieChart(frame: self.chartView.frame, ePieChartDataModel: EPieChartDataModel(budget: CGFloat(tradeTotal), current: CGFloat(losing), estimate: CGFloat(winning)))
        chartTest?.center = CGPoint(x: chartView.bounds.width/2, y: chartView.bounds.height/2)
//      Dans l'ordre du bas vers le haut : Budget / estimate / current
        chartTest?.frontPie.budgetColor = UIColor(red: 47, green: 62, blue: 146, alpha: 0)
        chartTest?.frontPie.currentColor = UIColor.red
        chartTest?.frontPie.estimateColor = UIColor.green
        chartTest?.frontPie.radius = (chartTest?.frontPie.radius)! + 15
        chartTest?.frontPie.backgroundColor = UIColor(red: 47, green: 62, blue: 146, alpha: 0)
        let viewBack = UIView(frame: (chartTest?.backPie.bounds)!)
        viewBack.layer.cornerRadius = viewBack.bounds.width/2
        let text = UILabel(frame: viewBack.frame)
        text.numberOfLines = 3
        text.textAlignment = NSTextAlignment.center
        text.textColor = UIColor.white
        text.font = UIFont(name: "Gurmukhi MN", size: 12.0)
        text.text = "Plan your trade, trade your plan"
        viewBack.addSubview(text)
        chartTest?.backPie.contentView = viewBack
        chartTest?.backPie.backgroundColor = UIColor(red: 47, green: 62, blue: 146, alpha: 0)
        chartView.addSubview(chartTest!)

        loadSmallStatResultsSection(total: tradeTotal, gain: winning, loose: losing)
    }

    
//      $$$$$$$$$$$$$$$$$$$  OTHER FUNCTIONS $$$$$$$$$$$$$$$$$$
    //    Pour ajouter des points
    func addPoint(dataEntryX forX:[String],dataEntryY forY: [Double]) {
        let data = LineChartData()
        var dataEntryTab: [ChartDataEntry] = [ChartDataEntry]()
        
        for (i, v) in forY.enumerated() {
            let dataEntry = ChartDataEntry(x: Double(i), y: v, data: forX as AnyObject?)
            dataEntryTab.append(dataEntry)
        }
        let dataSet = LineChartDataSet(values: dataEntryTab, label: "Gain")
        dataSet.lineWidth = 2.0
        dataSet.colors = [UIColor.yellow]
        dataSet.valueTextColor = UIColor.clear
        dataSet.circleRadius = 4
        dataSet.circleColors = [NSUIColor(cgColor: UIColor(red: 246/255, green: 202/255, blue: 16/255, alpha: 1).cgColor)]
        dataSet.circleHoleRadius = 2
        dataSet.circleHoleColor = NSUIColor(cgColor: UIColor(red: 244/255, green: 146/255, blue: 23/255, alpha: 1).cgColor)
        data.addDataSet(dataSet)
        perfChart.borderLineWidth = 3
        perfChart.borderColor = UIColor.yellow
        perfChart.xAxis.enabled = false
        perfChart.data = data
        perfChart.rightAxis.enabled = false
        perfChart.notifyDataSetChanged()
        perfChart.xAxis.granularity = 1
        perfChart.chartDescription?.text = ""
        perfChart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInCirc)
    }
    

    func addShadow(text:UIImageView) {
//        text.layer.cornerRadius = 5
        text.layer.shadowColor = UIColor.black.cgColor
        text.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        text.layer.masksToBounds = false
        text.layer.shadowRadius = 4.0
        text.layer.shadowOpacity = 1.0
    }
    
    
    
    
    func telechargementData() {
        let urlPath = "http://www.gael-jasawant-naime.com/statistics.php"
        
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
        let statsList = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            jsonElement = jsonResult[i] as! NSDictionary
            
            let stats = StatisticsTrade()
            
            if let gain = jsonElement["gain"] as? String,
                let loss = jsonElement["loss"] as? String {
                stats.gain = Double(gain)
                stats.loss = Double(loss)
            }
            
            statsList.add(stats)
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            self.compute(stats: statsList)
        })
    }
    
    
    
    func compute(stats: NSMutableArray) {
        
        var gain:[Double] = []
        var loss:[Double] = []
        var total:[Double] = []
        
        for i in 0 ..< stats.count {
            let temp = stats[i] as! StatisticsTrade
            
            if(temp.gain == 0) {
                loss.append(temp.loss!)
                total.append(temp.loss!)
            } else {
                gain.append(temp.gain!)
                total.append(temp.gain!)
            }
        }
        
        loadPerformancesSection(tab: total)
        loadResultSection(total: total, gain: gain, loss: loss)
        
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
