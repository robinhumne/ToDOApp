//
//  ViewController.swift
//  ToDoApp
//
//  Created by pikateck on 19/12/21.
//

import UIKit
import CarbonKit

enum ActiveEvent {
    case today
    case tomorrow
    case upcoming
    
}

class ViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet var btn_add: UIButton!
    
    
    
    
    //MARK: - Properties
    var items = NSArray()
    var carbonTabSwipeNavigation: CarbonTabSwipeNavigation? = CarbonTabSwipeNavigation()
    
    var events: [Event] = []
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        items = ["Today", "Tomorrow", "Upcoming"]
        
        
       AppDelegate.shared.activeEvent = .today
       carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items as [AnyObject], delegate: self)
       carbonTabSwipeNavigation?.insert(intoRootViewController: self)
        
        style()
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name("onDataInsertRefresh"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.onDataInsertRefresh(notification:)), name: Notification.Name("onDataInsertRefresh"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.view.addSubview(btn_add)
        
         if let events = Event.events{
             self.events = events
             
         }
    }
    
    //MARK: - Custom Views
    func style() {
        let color: UIColor = UIColor(red: 237.0 / 255, green: 24.0 / 255, blue: 73.0 / 255, alpha: 1)

        carbonTabSwipeNavigation?.toolbar.isTranslucent = false
        carbonTabSwipeNavigation?.setIndicatorColor(color)
        carbonTabSwipeNavigation?.carbonSegmentedControl?.setWidth(self.view.frame.size.width / 3, forSegmentAt: 0)
        carbonTabSwipeNavigation?.carbonSegmentedControl?.setWidth(self.view.frame.size.width / 3, forSegmentAt: 1)
        carbonTabSwipeNavigation?.carbonSegmentedControl?.setWidth(self.view.frame.size.width / 3, forSegmentAt: 2)
        
        carbonTabSwipeNavigation?.setNormalColor(UIColor(red: 183.0 / 255, green: 192.0 / 255, blue: 210.0 / 255, alpha: 1))
        carbonTabSwipeNavigation?.setSelectedColor(color, font: UIFont.boldSystemFont(ofSize: 14))
    }
    
    // MARK: - refresh
    @objc func onDataInsertRefresh(notification: Notification?) {
        print("When on add Notification Received:::\(String(describing: notification))")
        self.carbonTabSwipeNavigation?.currentTabIndex = 2
        
        if let events = Event.events{
            self.events = events
        }
        
        DispatchQueue.main.async {
            if AppDelegate.shared.activeEvent == .today {
                self.carbonTabSwipeNavigation?.currentTabIndex = 0
            }
            else if AppDelegate.shared.activeEvent == .tomorrow {
             self.carbonTabSwipeNavigation?.currentTabIndex = 1
            }
           else if AppDelegate.shared.activeEvent == .upcoming {
             self.carbonTabSwipeNavigation?.currentTabIndex = 2
            }
           else{
             self.carbonTabSwipeNavigation?.currentTabIndex = 0
           }
        }
        
        
        
            
                 
           
       }
    
    // MARK: - Actions
    @IBAction func btn_add(_ sender: Any) {
        
        if let vc = AddDetailsViewController.GetViewController() {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    // MARK: - Navigation
    /// Get ViewController screen instance from Storyboard
    ///
    /// - Returns: Instance of ViewController
    class func GetViewController()->ViewController?{
        if let viewController = Storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController{
            return viewController
        }
        return nil
    }
        
        
    /// Get refrence of Storyboard
    static var Storyboard: UIStoryboard {
        return UIStoryboard(name: STORYBOARD_MAIN, bundle: Bundle.main)
    }


}


extension ViewController : CarbonTabSwipeNavigationDelegate
{
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        
        if index == 0
        {
            let vc = ListViewController.GetViewController()!
            vc.events = self.events
            return vc
        }
        else if index == 1
        {
            let vc = ListViewController.GetViewController()!
            vc.events = self.events
            return vc
        }
        else
        {
            let vc = ListViewController.GetViewController()!
            vc.events = self.events
            return vc
        }
    }
    
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, didMoveAt index: UInt) {
        
        if let vc = carbonTabSwipeNavigation.viewControllers[index] as? ListViewController {
            vc.events = self.events
            vc.reloadView()
            
            
            if index == 0 {
                AppDelegate.shared.activeEvent = .today
            }else if index == 1 {
                AppDelegate.shared.activeEvent = .tomorrow
            }else if index == 1 {
                AppDelegate.shared.activeEvent = .upcoming
            }
        }
        
        
    }
}
