////
////  ViewController.swift
////  FinanceSide
////
////  Created by Sofiane Bouragba Zrif  on 13/10/2017.
////  Copyright © 2017 Sofiane Bouragba Zrif . All rights reserved.
////
//
//import UIKit
//import Charts
//
//
//class ViewController: UIViewController {
//
//
//    @IBOutlet weak var alertButton: UIBarButtonItem!
//    @IBOutlet weak var menuButton: UIBarButtonItem!
//    @IBOutlet weak var Chart: HorizontalBarChartView!
//    @IBOutlet weak var pieChart: PieChartView!
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        sideMenu()
//        customizeNavBar()
//        setBackgroundMainView()
//
//
//        let xAbsisse:[String] = ["EUR/USD","GBP/USD","USD/JPY","USD/CAD","AUD/CAD"]
//        let yValue:Array<Double> = [345,123,87,423,193]
//
//
//        let xGLAbsisse:[String] = ["Gain","Loss"]
//        let gainLoss:Array<Double> = [88,22] // index 0 is gain , 1 is loss
//
//        setChart(name: xAbsisse, value: yValue)
//        setGainLossPieChart(name: xGLAbsisse, value: gainLoss)
//
//        //ChartView On home
//        Chart.noDataText = "Pas de donnée ..."
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    func sideMenu()
//    {
//        if revealViewController() != nil
//        {
//            menuButton.target = revealViewController();
//            menuButton.action = #selector (SWRevealViewController.revealToggle(_:))
//            revealViewController().rearViewRevealWidth = 275
//            revealViewController().rightViewRevealWidth = 160
//
//
//            alertButton.target = revealViewController()
//            alertButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
//
//            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//        }
//    }
//
//
//    func setBackgroundMainView(){
//        let backgroundImage:UIImage = UIImage(named: "background.jpg")!
//        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = view.frame
//        self.view.backgroundColor = UIColor(patternImage: backgroundImage)
//        view.insertSubview(blurEffectView, at: 0)
//    }
//
//
//    func customizeNavBar() {
//        navigationController?.navigationBar.tintColor = UIColor(red: 44/255, green : 99/255, blue : 111/255, alpha :1)
//        navigationController?.navigationBar.barTintColor = UIColor(red: 44/255, green : 99/255, blue : 111/255, alpha :1)
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
//    }
//
//    func setChart(name:[String], value:Array<Double>)
//    {
//        var dataArray:[ChartDataEntry] = []
//        for i in 0..<name.count{
//            let data:BarChartDataEntry = BarChartDataEntry (x: Double(i), y: value[i], data: name as AnyObject )
//            dataArray.append(data)
//        }
//        Chart.chartDescription?.text = ""
//        let dataSet:BarChartDataSet = BarChartDataSet(values : dataArray, label : "Devises")
//        let dataChart = BarChartData(dataSet: dataSet)
//        Chart.xAxis.labelPosition = .bottom
//        Chart.data = dataChart
//        Chart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
//        let limitTarget = ChartLimitLine(limit: 400.0, label: "Target")
//        Chart.rightAxis.addLimitLine(limitTarget)
//    }
//
//    func setGainLossPieChart(name:[String], value:Array<Double>)
//    {
////        Add data
//        var dataArrayPiechart:[ChartDataEntry] = []
//        for i in 0..<name.count{
//            let data:PieChartDataEntry = PieChartDataEntry(value: value[i], label: name[i])
//            dataArrayPiechart.append(data)
//        }
//        let dataSetPieChart:PieChartDataSet = PieChartDataSet(values: dataArrayPiechart, label: "")
//        let dataChartPieChart = PieChartData(dataSet: dataSetPieChart)
//        pieChart.data = dataChartPieChart
//
//
////        Remove the description
//        pieChart.chartDescription?.text = ""
//
////        Add colors
//        var colors: [UIColor] = []
//        let colorRed = UIColor(red: CGFloat(255/255), green: CGFloat(0/255), blue: CGFloat(0/255), alpha: 1)
//        let colorGreen = UIColor(red: CGFloat(0/255), green: CGFloat(255/255), blue: CGFloat(0/255), alpha: 1)
//        colors.append(colorGreen)
//        colors.append(colorRed)
//        dataSetPieChart.colors = colors
//
////        Alter the radius hole
//        pieChart.holeRadiusPercent = 0.8
//        pieChart.transparentCircleRadiusPercent = 0
//        pieChart.drawHoleEnabled = false
//        pieChart.transparentCircleColor = UIColor.clear
//    }
//
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}

