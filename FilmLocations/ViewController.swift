//
//  ViewController.swift
//  FilmLocations
//
//  Created by Anika Morris on 6/15/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var films:[FilmEntry] = []
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getDataFromFile("locations")
        print(films)
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = films[indexPath.row].locations
        return cell
    }
    
    func getDataFromFile(_ fileName:String) {
        let path = Bundle.main.path(forResource: fileName, ofType: ".json")
        if let path = path {
          let url = URL(fileURLWithPath: path)
          let contents = try? Data(contentsOf: url)
          do {
            if let data = contents,
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String:Any]] {
              for film in jsonResult{
                  let firstActor = film["actor_1"] as? String ?? ""
                  let locations = film["locations"] as? String  ?? ""
                  let releaseYear = film["release_year"] as? String  ?? ""
                  let title = film["title"] as? String  ?? ""
                  let movie = FilmEntry(firstActor: firstActor, locations: locations, releaseYear: releaseYear, title: title)
                  films.append(movie)
              }
            }
            
          } catch {
            print("Error deserializing JSON: \(error)")
          }
        }
        
    }

}

