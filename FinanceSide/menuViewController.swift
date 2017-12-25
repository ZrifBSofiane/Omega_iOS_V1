//
//  menuViewController.swift
//  FinanceSide
//
//  Created by Sofiane Bouragba Zrif  on 24/10/2017.
//  Copyright © 2017 Sofiane Bouragba Zrif . All rights reserved.
//

import UIKit

class menuViewController: UIViewController {

    @IBOutlet weak var viewBackground: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func quitButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
//    $$$$$$$$$$$$$$$  BACKGROUND GRADIENT $$$$$$$$$$$$$
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
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
