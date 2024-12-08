//
//  FirstScreen.swift
//  iOS Mini Project
//
//  Created by Muhammad Afif Fadhlurrahman on 03/12/24.
//
import UIKit

class FirstScreen: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Buat instance UITableView
    let tableView = UITableView()
    var data: [String] = [] // Menyimpan data dari API

    override func viewDidLoad() {
        super.viewDidLoad()
        // Header Menu
        view.backgroundColor = .systemBackground
        title = "Choose Your Menu"
        navigationController?.navigationBar.prefersLargeTitles = true

        // Setup UITableView
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        // Registrasi cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        // Panggil fungsi untuk mengambil data dari API
        fetchDataFromAPI()
    }

    // Jumlah baris di tabel (jumlah elemen data)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    // Konfigurasi cell untuk setiap baris
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    func fetchDataFromAPI() {
        let urlString = "https://www.themealdb.com/api/json/v1/1/search.php?s=chicken"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else { return }
            
            // Parsing JSON
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    // Ambil judul dari setiap post
                    let titles = jsonArray.compactMap { $0["title"] as? String }
                    
                    // Simpan ke dalam array data
                    DispatchQueue.main.async {
                        self.data = titles
                        self.tableView.reloadData() // Refresh UITableView
                    }
                }
            } catch let parsingError {
                print("Error parsing JSON: \(parsingError)")
            }
        }
        task.resume() // Mulai task untuk mengambil data dari API
    }

}

