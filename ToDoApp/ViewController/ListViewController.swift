//
//  ListViewController.swift
//  ToDoApp
//
//  Created by pikateck on 19/12/21.
//

import UIKit

class ListViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet var tbl_list: UITableView!
    
    var events : [Event]? = nil
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tbl_list.delegate = self
        tbl_list.dataSource = self
        tbl_list.tableFooterView = UIView(frame: .zero)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    func reloadView(){
        tbl_list?.reloadData()
    }
    
    // MARK: - Navigation
    /// Get ViewController screen instance from Storyboard
    ///
    /// - Returns: Instance of ViewController
    class func GetViewController()->ListViewController?{
        if let viewController = Storyboard.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController{
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

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell", for: indexPath) as? DataTableViewCell
           cell?.selectionStyle = .none
        
        if let event = self.events?[indexPath.row] {
            cell?.lbl_title.text = event.event_title
            cell?.lbl_desc.text = event.event_decs
        }
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = DetailsViewController.GetViewController() {
            vc.event = self.events?[indexPath.row] 
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
