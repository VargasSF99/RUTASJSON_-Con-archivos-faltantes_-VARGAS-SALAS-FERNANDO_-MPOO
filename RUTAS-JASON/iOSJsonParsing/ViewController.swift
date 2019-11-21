//
//  ViewController.swift
//  iOSJsonParsing
//
//  Created by Anupam Chugh on 04/07/18.
//  Copyright © 2018 JournalDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    @IBAction func cerrar(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    var todo = [puntos]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadInitialData()
        
        
        
        
    }
    func loadInitialData() {
        // 1
        guard let fileName = Bundle.main.path(forResource: "PublicArt", ofType: "json")
            else { return }
        let optionalData = try? Data(contentsOf: URL(fileURLWithPath: fileName))
        
        guard
            let data = optionalData,
            // 2
            let json = try? JSONSerialization.jsonObject(with: data),
            // 3
            let dictionary = json as? [String: Any],
            // 4
            let works = dictionary["data"] as? [[Any]]
            else { return }
        // 5
        let validWorks = works.compactMap { puntos(json: $0) }
        todo.append(contentsOf: validWorks)
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todo.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentMovie = todo[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = currentMovie.title
        cell.imageView?.image = UIImage(named:todo[indexPath.row].imageYear) //cell.detailTextLabel?.text = "\(currentMovie.movieYear)"
        return cell
    }

}


struct puntos {
    var title: String
    var imageYear: String
    
    init?(json: [Any]) {
        // 1
        if let title = json[1] as? String {
            self.title = title
        } else {
            self.title = "No Title"
        }
         self.imageYear = json[5] as! String
    }
}


