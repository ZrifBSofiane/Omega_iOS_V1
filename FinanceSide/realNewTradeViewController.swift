//
//  realNewTradeViewController.swift
//  FinanceSide
//
//  Created by Sofiane Bouragba Zrif  on 23/10/2017.
//  Copyright © 2017 Sofiane Bouragba Zrif . All rights reserved.
//

import UIKit

class realNewTradeViewController: UIViewController, UITextFieldDelegate, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var numberOfWeek: UITextField!
    @IBOutlet weak var unitTime: UITextField!
    @IBOutlet weak var dateEntry: UITextField!
    @IBOutlet weak var dateExit: UITextField!
    @IBOutlet weak var hourEntry: UITextField!
    @IBOutlet weak var hourExit: UITextField!
    @IBOutlet weak var currency: UITextField!
    @IBOutlet weak var buySell: UITextField!
    @IBOutlet weak var entry: UITextField!
    @IBOutlet weak var stop: UITextField!
    @IBOutlet weak var profit: UITextField!
    @IBOutlet weak var exit: UITextField!
    @IBOutlet weak var volume: UITextField!
    @IBOutlet weak var gain: UITextField!
    @IBOutlet weak var loss: UITextField!
    
    @IBOutlet weak var validButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var takeProfit: UITextField!
    
    @IBOutlet weak var stopLoss: UITextField!
    @IBOutlet weak var backView: UIView!
    
    
    let transition = CircularTransition()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        addImage(text: numberOfWeek, image: "calendar.png")
        createGradientLayer()
        loadTextField()
        loadButton()
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
       

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if (self.view.frame.origin.y == 0 && gain.isEditing) || (self.view.frame.origin.y == 0 && loss.isEditing) || (self.view.frame.origin.y == 0 && volume.isEditing) || (self.view.frame.origin.y == 0 && takeProfit.isEditing) || (self.view.frame.origin.y == 0 && stopLoss.isEditing) {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if (self.view.frame.origin.y != 0 && gain.isEditing) || (self.view.frame.origin.y != 0 && loss.isEditing) || (self.view.frame.origin.y != 0 && volume.isEditing) || (self.view.frame.origin.y != 0 && takeProfit.isEditing) || (self.view.frame.origin.y != 0 && stopLoss.isEditing) {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    
    @objc func dismissKeyboard()-> Bool {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        return true
    }
    
    
    func createGradientLayer() {
        var gradientLayer: CAGradientLayer!
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        let firstColor = UIColor(red: 0/255, green: 180/255, blue: 140/255, alpha: 1.0).cgColor
        let lastColor = UIColor(red: 37/255, green: 103/255, blue: 192/255, alpha: 1.0).cgColor
//        gradientLayer.locations = [0.0, 19.0]
        gradientLayer.colors = [firstColor, lastColor]
        
        backView.layer.addSublayer(gradientLayer)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func loadTextField() {
        addImage(text: dateExit, image: "calendar.png")
        addImage(text: dateEntry, image: "calendar.png")
        addImage(text: hourExit, image: "hour.png")
        addImage(text: hourEntry, image: "hour.png")
        addImage(text: takeProfit, image: "euro.png")
        addImage(text: stopLoss, image: "euro.png")
        
        addShadowTextField(text: dateEntry)
        addShadowTextField(text: dateExit)
        addShadowTextField(text: hourEntry)
        addShadowTextField(text: hourExit)
        addShadowTextField(text: unitTime)
        addShadowTextField(text: numberOfWeek)
        addShadowTextField(text: currency)
        addShadowTextField(text: buySell)
        addShadowTextField(text: entry)
        addShadowTextField(text: stop)
        addShadowTextField(text: profit)
        addShadowTextField(text: exit)
        addShadowTextField(text: volume)
        addShadowTextField(text: gain)
        addShadowTextField(text: loss)
        addShadowTextField(text: takeProfit)
        addShadowTextField(text: stopLoss)
        
        
        gain.delegate = self
        numberOfWeek.delegate = self
        dateEntry.delegate = self
        dateExit.delegate = self
        unitTime.delegate = self
        hourExit.delegate = self
        hourEntry.delegate = self
        currency.delegate = self
        buySell.delegate = self
        entry.delegate = self
        stop.delegate = self
        profit.delegate = self
        exit.delegate = self
        volume.delegate = self
        loss.delegate = self
        takeProfit.delegate = self
        stopLoss.delegate = self
        
        setDecimalKeyboardType(text: numberOfWeek)
        setDecimalKeyboardType(text: entry)
        setDecimalKeyboardType(text: stop)
        setDecimalKeyboardType(text: gain)
        setDecimalKeyboardType(text: loss)
        setDecimalKeyboardType(text: profit)
        setDecimalKeyboardType(text: exit)
        setDecimalKeyboardType(text: takeProfit)
        setDecimalKeyboardType(text: stopLoss)
    }
    
    func setDecimalKeyboardType(text: UITextField) {
        text.keyboardType = UIKeyboardType.decimalPad
    }
    
    
    func loadButton() {
        validButton.layer.borderWidth = 0.5
        validButton.layer.borderColor = UIColor.black.cgColor
    }
    
    
    
    
    func addShadowTextField(text:UITextField) {
        text.layer.cornerRadius = 5
        text.layer.borderWidth = 0.5
        text.layer.shadowColor = UIColor.blue.cgColor
        text.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        text.layer.masksToBounds = false
        text.layer.shadowRadius = 4.0
        text.layer.shadowOpacity = 1.0
    }
    
    
    @IBAction func menuButton(_ sender: Any) {
    }
    
    func addImage(text:UITextField, image:String) {
        let imageView = UIImageView();
        let imageContent = UIImage(named: image);
        imageView.image = imageContent;
        
        let rightView = UIView()
        rightView.addSubview(imageView)
        let size = text.bounds.height - 8
        imageView.frame = CGRect(x: -5, y: 0, width: size, height: size)
        rightView.frame = CGRect(x: 0, y: 0, width: size, height: size)
        text.rightView = rightView
        text.rightViewMode = UITextFieldViewMode.always
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
