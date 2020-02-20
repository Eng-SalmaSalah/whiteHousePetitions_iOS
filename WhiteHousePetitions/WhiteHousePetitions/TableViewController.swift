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
    var filteredPeitions = [Petition]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getPetitions()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(getCredits))
        let filterBtn = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterPetitions))
        let resetBtn = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetPetitions))
        navigationItem.leftBarButtonItems = [filterBtn,resetBtn]
    }
    
    func getPetitions(){
        var urlString:String
        if navigationController?.tabBarItem.tag == 0{
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        }else{
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                parse(data: data)
                return
            }
        }
        showError()
    }
    
    @objc func getCredits(){
        let ac = UIAlertController(title: "Credits", message: "These Petitions Come From \n WE THE PEOPLE API \n of the white house", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "ok", style: .cancel))
        present(ac,animated: true)
    }
    
    @objc func filterPetitions(){
        let ac = UIAlertController(title: "Filter Petitions", message: "Enter The Petition Title You Want", preferredStyle: .alert)
        ac.addTextField { (tf) in
            tf.placeholder = "Enter Petition Title here .."
        }
        ac.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak self](alertAction) in
            if let petitions = self?.petitions{
                self?.filteredPeitions.removeAll()
                for petition in petitions{
                    if let enteredPetitionTitle = ac.textFields?.first?.text?.lowercased(){
                        if petition.title.lowercased().contains(enteredPetitionTitle){
                            self?.filteredPeitions.append(petition)
                        }
                    }
                }
                self?.tableView.reloadData()
            }
        }))
        present(ac,animated: true)
    }
    
    @objc func resetPetitions(){
        filteredPeitions = petitions
        tableView.reloadData()
    }
    
    func parse(data:Data){
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: data){
            //nb : Petitions.self which is Swift’s way of referring to the Petitions type itself rather than an instance of it. That is, we’re not saying “create a new one”, but instead specifying it as a parameter to the decoding so JSONDecoder knows what to convert the JSON too.
            petitions = jsonPetitions.results
            filteredPeitions = petitions
            tableView.reloadData()
        }
    }
    
    func showError(){
        let ac = UIAlertController(title: "Loading error", message: "Cannot load petitions right now please check you internet connection", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(ac,animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPeitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let petition = filteredPeitions[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController()
        detailsVC.detailItem = filteredPeitions[indexPath.row]
        navigationController?.pushViewController(detailsVC, animated: true)
        //here we didn't use instantiate VC because we didn't add the details VC in storyboard
    }

}

