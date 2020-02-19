//
//  ViewController.swift
//  WhiteHousePetitions
//
//  Created by Salma Salah on 2/19/20.
//  Copyright © 2020 Salma Salah. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var petitions = [Petition]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getPetitions()
        // Do any additional setup after loading the view.
    }
    
    func getPetitions(){
        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                parse(data: data)
            }
        }
    }
    
    func parse(data:Data){
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: data){
            //nb : Petitions.self which is Swift’s way of referring to the Petitions type itself rather than an instance of it. That is, we’re not saying “create a new one”, but instead specifying it as a parameter to the decoding so JSONDecoder knows what to convert the JSON too.
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let petition = petitions[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }

}

