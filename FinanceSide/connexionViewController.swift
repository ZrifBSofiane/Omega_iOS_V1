//
//  connexionViewController.swift
//  FinanceSide
//
//  Created by Sofiane Bouragba Zrif  on 21/10/2017.
//  Copyright © 2017 Sofiane Bouragba Zrif . All rights reserved.
//

import UIKit

class connexionViewController: UIViewController, UITextFieldDelegate, URLSessionDataDelegate {

    
//    All outlet are in the same order as in the view
    @IBOutlet weak var connect: UIButton!
    
    @IBOutlet weak var passwordText: ShakingTextField!
    @IBOutlet weak var identifiantText: ShakingTextField!
    
    

    
    
    @IBOutlet weak var connectButton: UIButton!
    
    @IBOutlet weak var viewBackground: UIView!
    
    var isConnected:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        customizeConnectButton()
        addDelegateTextField()
        //createGradientLayer()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addDelegateTextField(){
//      To dismiss keyboard when tap return
        self.identifiantText.delegate = self
        passwordText.delegate = self
        self.passwordText.isSecureTextEntry = true
    }
    
    
//    func customizeConnectButton(){
////        For the button central with the name
//        connect.layer.cornerRadius = 20
//        connect.layer.borderWidth = 1
//       connect.layer.shadowColor = UIColor.black.cgColor
//        connect.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
//        connect.layer.masksToBounds = false
//        connect.layer.shadowRadius = 4.0
//        connect.layer.shadowOpacity = 1.0
//
////        For the let's go connection button
////        connectButton.layer.cornerRadius = 10
//        connectButton.layer.borderWidth = 1
//    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= 150
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += 150
            }
        }
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
    
    
    
    
    @IBAction func connectActionButton(_ sender: Any) {
        var isIDempty:Bool = true
        var isPasswordEmpty:Bool = true
        
        let password = passwordText.text
        let id = identifiantText.text
        
        if(password != "")
        {
            isPasswordEmpty = false
        }
        if(id != "")
        {
            isIDempty = false
        }
        
        if(isIDempty == false && isPasswordEmpty == false)
        {
         
            print("Connected ...")
            connexion(user: id!, pass: password!)
        }
        else
        {
            if(isIDempty && isPasswordEmpty)
            {
                print("Id and password incorrect")
                passwordText.shake()
                identifiantText.shake()
            }
            else
            {
                if(isIDempty)
                {
                    print("Id incorrect")
                    identifiantText.shake()
                }
                if(isPasswordEmpty)
                {
                    print("Password incorrect")
                    passwordText.shake()
                }
            }
            
        }
    }
    
    func connexion(user:String, pass:String) {
        let urlPath = "http://www.gael-jasawant-naime.com/connexion.php"
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) {
            (data,response,error) in
            if error != nil {
                print("Failed to download data")
            } else {
                print("Data downloaded")
                
               self.parseJSON(data!, usernameTemp: user, passwordTemp: pass)
                
            }
        }
        task.resume()
    }
    
    func parseJSON(_ data:Data, usernameTemp:String, passwordTemp:String) {
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        } catch let error as NSError {
            print(error)
        }
        var jsonElement = NSDictionary()
        let admins = NSMutableArray()

        for i in 0 ..< jsonResult.count
        {
            jsonElement = jsonResult[i] as! NSDictionary
            
            let admin  = Admin()
            
            if let id = jsonElement["idAdmin"] as? String,
                let username = jsonElement["username"] as? String,
                let password = jsonElement["password"] as? String {
                
                admin.id = Int(id)
                admin.username = username
                admin.password = password
                
            }
            
            admins.add(admin)
        }

        DispatchQueue.main.async(execute: { () -> Void in
            
            self.seConnecter(admins: admins)
            
        })
    }
    
    
    
    func seConnecter(admins:NSMutableArray) {
        print ("ICI 4")
        print (admins.count)
        var adminAccount: Bool = false
        
        for i in 0 ..< admins.count {
            let adminTemp = admins[i] as! Admin
            
            
            if( adminTemp.username == identifiantText.text) {
                if( adminTemp.password == passwordText.text) {
                    adminAccount = true
                }
            }
        }
        if(adminAccount) {
            self.performSegue(withIdentifier: "homeView", sender: nil)
        } else {
            let alert = UIAlertController(title: "Incorrect", message: "Username or password incorrect", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
