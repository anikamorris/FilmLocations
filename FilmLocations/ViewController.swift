//
//  ViewController.swift
//  FilmLocations
//
//  Created by Anika Morris on 6/15/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromFile("locations")
    }

    func getDataFromFile(_ fileName:String) {
        let path = Bundle.main.path(forResource: fileName, ofType: ".json")
        if let path = path {
          let url = URL(fileURLWithPath: path)
          let contents = try? Data(contentsOf: url)
          do {
            if let data = contents,
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String:Any]] {
              print(jsonResult)
            }
          } catch {
            print("Error deserializing JSON: \(error)")
          }
        }
        
    }

}

