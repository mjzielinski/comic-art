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
        cell.imageView?.image = UIImage(data: art.image as! Data)
        cell.textLabel?.text = art.title
        
        return cell
    }
    
    //* when someone clicks on one of the rows go to next screen and send Art object
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let art = arts[indexPath.row]
        performSegue(withIdentifier: "artSegue", sender: art)
    }
    
    //* sends the art to the next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! ArtViewController
        nextVC.art = sender as? Art
    }


}

