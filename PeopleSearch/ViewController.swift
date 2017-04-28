//
//  ViewController.swift
//  PeopleSearch
//
//  Created by Tazeen on 27/04/17.
//  Copyright © 2017 Tazeen. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

var users = [Int:[Any]]()
var profile = [UIImage]()

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate,UISearchDisplayDelegate {

   
    @IBOutlet weak var tableView: UITableView!
    
    let no = [0,1,2,3,4,5,6,7,8,9]
    var searchController = UISearchController()
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return no.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        if users .isEmpty
        {
            print("no user")
            self.tableView.reloadData()
        }
        else
        {
            if (searchController.isActive && searchController.searchBar.text != " ")
            {
                
                let object = Array(users.values)[indexPath.row]
                Alamofire.request("http://104.215.251.233:81/d_MNetV2/public/images/\(object[6])").responseImage { response in
                    debugPrint(response)
                    let image = response.result.value
                cell.name.text? = object[1] as! String
                cell.profile.image = image
                cell.compLabel.text? = object[2] as! String
                cell.branchLabel.text? = object[3] as! String
                cell.statusLabel.text? = object[5] as! String
                }
            }
        else
            {
                let object = Array(users.values)[indexPath.row]
                Alamofire.request("http://104.215.251.233:81/d_MNetV2/public/images/\(object[6])").responseImage { response in
                    debugPrint(response)
                    let image = response.result.value
                cell.name.text? = object[1] as! String
                cell.profile.image = image
                cell.compLabel.text? = object[2] as! String
                cell.branchLabel.text? = object[3] as! String
                cell.statusLabel.text? = object[5] as! String
                }
            }
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let indexPath = tableView.indexPathForSelectedRow;
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        viewController.passedValue =  no[(indexPath?.row)!]
        self.present(viewController, animated: true , completion: nil)
    }
    
    func getUser()
    {
        let parameters = ["user_id":31, "group_id":1,"data_type_id":"B2B User", "start":0,"limit":10] as [String : Any]
        Alamofire.request("http://104.215.251.233:81/d_MNetV2Service/MnetV2WebService/findUsersfuncTo",method: .post, parameters: parameters,encoding:JSONEncoding(options: []))
            .responseJSON { (response:DataResponse) in
              
                        switch(response.result) {
                case .success(_):
                    if let data = response.result.value as? [String : Any]
                    {
                        let users_data = data["status"] as? [[String:Any]]
                        var i = 0
                       for user_data in users_data!
                        {
                            let username = user_data["username"]
                            let id = user_data["user_id"]
                            let compname = user_data["comp_name"]
                            let branch = user_data["branch_name"]
                            let status = user_data["user_status"]
                            let email = user_data["user_email"]
                            let link = user_data["profile_img_link"]
                            
                            users[i] = [id!,username! ,compname!,branch! ,email!,status!,link!]
                           
                            i += 1
                        }
                        
                    }
                    break
                    
                case .failure(_):
                    print(response.result.error!)
                    break
                    
                }
        
        }
        
      self.tableView.reloadData()
           }
    func filterResult(searchText: String)
    {
        let parameters = ["user_id":31, "group_id":1,"data_type_id":"B2B User", "start":0,"limit":10,"query": searchText] as [String : Any]
        
        Alamofire.request("http://104.215.251.233:81/d_MNetV2Service/MnetV2WebService/findUsersfuncTo",method: .post, parameters: parameters,encoding:JSONEncoding(options: []))
            .responseJSON { (response:DataResponse) in
                
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value as? [String : Any]
                    {
                        let users_data = data["status"] as? [[String:Any]]
                        var i = 0
                        for user_data in users_data!
                        {
                            let username = user_data["username"]
                            let id = user_data["user_id"]
                            let compname = user_data["comp_name"]
                            let branch = user_data["branch_name"]
                            let status = user_data["user_status"]
                            let email = user_data["user_email"]
                            let link = user_data["profile_img_link"]
                            users[i] = [id!,username! ,compname!,branch! ,email!,status!,link!]
                            i += 1
                            print(users)
                        }
                    }
                    break
                    
                case .failure(_):
                    print(response.result.error!)
                    break
                    
                }
                
        
        
        }
        self.tableView.reloadData()
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        getUser()
        self.tableView.reloadData()
        self.searchController.loadViewIfNeeded()
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        // Do any additional setup after loading the view, typically from a nib.
    }
    
  
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController: UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController)
    {
        filterResult(searchText: searchController.searchBar.text!)
    }
}
