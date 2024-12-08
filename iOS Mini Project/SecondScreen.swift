//
//  SecondScreen.swift
//  iOS Mini Project
//
//  Created by Muhammad Afif Fadhlurrahman on 03/12/24.
//

import UIKit

class SecondScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        // tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // tablevi
        return tableView
    }()
    
}

//class ChickenTableView: UITableViewController {
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//       // Ask for a cell of the appropriate type.
//       let cell = tableView.dequeueReusableCell(withIdentifier: "basicStyleCell", for: indexPath)
//            
//       // Configure the cell’s contents with the row and section number.
//       // The Basic cell style guarantees a label view is present in textLabel.
//       cell.textLabel!.text = "Row \(indexPath.row)"
//       return cell
//    }
//}
