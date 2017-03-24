//
//  MainViewController.swift
//  Comic Art
//
//  Created by Michael Zielinski on 3/22/17.
//  Copyright © 2017 Worldengine. All rights reserved.
//

//* Editor Embed In Navigation Controller
import UIKit

//* add UITableViewDelegate and UITableViewDataSource
class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //* outlet to tableView
    @IBOutlet weak var tableView: UITableView!
    
    //* array of art objects from core data
    var arts : [Art] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //* add these
        tableView.dataSource = self
        tableView.delegate = self
    }

    //* function to pull things out of core data
    override func viewWillAppear(_ animated: Bool) {
        //* set up context
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //* try catch to fetch things from core data
        do {
            arts = try context.fetch(Art.fetchRequest())
            tableView.reloadData()
        } catch {
            print("some error occurred")
        }
    }
    
    //* specify number of rows in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arts.count
    }
    
    //* specify what goes in each cell for index
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let art = arts[indexPath.row]
        cell.textLabel?.text = art.title
        
        return cell
        
    }


}

