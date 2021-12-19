//
//  DetailsViewController.swift
//  ToDoApp
//
//  Created by pikateck on 20/12/21.
//

import UIKit

class DetailsViewController: UIViewController {

    // MARK: - IBOutlets
    
    //UILabel
    @IBOutlet var lbl_title: UILabel!
    @IBOutlet var lbl_decs: UILabel!
    @IBOutlet var lbl_time: UILabel!
    
    var event : Event? = nil
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        lbl_title.text = event?.event_title
        lbl_decs.text = event?.event_decs
        lbl_time.text = event?.event_time
    }
    
    // MARK: - Navigation
    /// Get ViewController screen instance from Storyboard
    ///
    /// - Returns: Instance of ViewController
    class func GetViewController()->DetailsViewController?{
        if let viewController = Storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController{
            return viewController
        }
        return nil
    }
        
        
    /// Get refrence of Storyboard
    static var Storyboard: UIStoryboard {
        return UIStoryboard(name: STORYBOARD_MAIN, bundle: Bundle.main)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
