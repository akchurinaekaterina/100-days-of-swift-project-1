//
//  ViewController.swift
//  Project1
//
//  Created by Ekaterina Musiyko on 18/02/2020.
//  Copyright © 2020 Ekaterina Akchurina. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()
    var sortedPictures = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl"){
                pictures.append(item)
                sortedPictures = pictures.sorted()
            }
        }
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Pictures"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(recommend))
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedPictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = sortedPictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "detail") as? DetailViewController {
            vc.selectedImageName = "Picture \(indexPath.row + 1) of \(sortedPictures.count)"
            vc.selectedImage = sortedPictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func recommend () {
        let textToRecommend = "Hey there! I know a nice app, try it!"
        let recommend = UIActivityViewController(activityItems: [textToRecommend], applicationActivities: [])
        recommend.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(recommend, animated: true)
    }


}

