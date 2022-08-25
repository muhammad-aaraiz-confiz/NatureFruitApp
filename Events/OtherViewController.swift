//
//  OtherViewController.swift
//  Events
//
//  Created by Muhammad Aaraiz Wasim on 09/08/2022.
//

import UIKit
import Foundation
import Alamofire
import AlamofireSwiftyJSON
import AlamofireImage
import SwiftyJSON


let key1 = "user"
let sortKey = "sortBy"
class OtherViewController: UIViewController {
    var receivedFruit: FruitList?

    var window: UIWindow?
    
    @IBOutlet weak var tableView: UITableView!

    private let networkingClient = NetworkingClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getFruitList()
    }
    
    
    private func getFruitList(){
        networkingClient.getJSONData{(json)in
            if let json = json {
                self.receivedFruit = json
                if let retrievedSortableObject = UserDefaults.standard.codableObject(dataType: String.self, key: sortKey) {
                    if retrievedSortableObject == "name"
                    {
                        self.sortByName()
                    }
                    else if retrievedSortableObject == "id"
                    {
                        self.sortById()
                    }
                    
                    
                }
                else
                {
                    self.tableView.reloadData()
                    print("Invalid Key: \(sortKey)")
                }
            }
        }
    }
    
    private func sortByName(){
        self.receivedFruit?.sort{
            $0.name < $1.name
        }
        self.tableView.reloadData()
    }
    
    private func sortById(){
        self.receivedFruit?.sort{
            $0.id < $1.id
        }
        self.tableView.reloadData()
    }
    
    private func configureItems(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Sign Out", style: .plain ,target: self, action:   #selector(showConfirmationAlert)
        )
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.red
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Sort", style: .plain ,target: self, action:   #selector(showOptions)
        )
    }
    
}

extension OtherViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receivedFruit?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CellTableViewCell
        
        cell?.lbl.text = receivedFruit?[indexPath.row].name
        
        let imgURL = getImgUrl(name: receivedFruit?[indexPath.row].name ?? "")
        Alamofire.request(imgURL).responseImage{(response) in
            if let image = response.result.value {
                DispatchQueue.main.async {
                    cell?.img.image = image
                }
            }
        }
        return cell!
    }
    
    func getImgUrl(name: String)-> String
    {
        return FruitDictionary.topTen[name] ?? ""

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        vcc?.fruitObj = receivedFruit?[indexPath.row]
        self.navigationController?.pushViewController(vcc!, animated: true)
    }
    
    @objc func showConfirmationAlert() {
        // create the alert
        let alert = UIAlertController(title: "Log Out", message: "Are you sure?", preferredStyle: UIAlertController.Style.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {action in self.dismissView()
            
            
            if let retrievedCodableObject = UserDefaults.standard.codableObject(dataType: User.self, key: key1) {
                let codableObject = User(userEmail: retrievedCodableObject.userEmail, state: "")
                UserDefaults.standard.setUser(codableObject, forKey: key1)
                
            } else {
                print("Not yet saved with key \(key1)")
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @objc func showOptions() {
        // create the alert
        let alert = UIAlertController(title: "Sort by", message: "Select sorting order", preferredStyle: UIAlertController.Style.actionSheet)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "ID", style: UIAlertAction.Style.default, handler: {action in
            UserDefaults.standard.setUser("id", forKey: sortKey)
            self.getFruitList()
            //CALL SORT BY ID HERE (INCOMPLETE...)
        }))
        alert.addAction(UIAlertAction(title: "Name", style: UIAlertAction.Style.default, handler: {action in             UserDefaults.standard.setUser("name", forKey: sortKey)
            self.getFruitList()
            //CALL SORT BY NAME HERE (INCOMPLETE...)
            
        }))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
// MARK: - DismissView
    func dismissView(){
        //dismiss(animated: true, completion: nil)
        let vc = storyboard?.instantiateViewController(identifier: "loginView") as! ViewController
        
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated: true)
    }
}

