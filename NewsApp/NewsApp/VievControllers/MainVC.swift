//
//  ViewController.swift
//  NewsApp
//
//  Created by MacBook on 16.04.2022.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var newsList = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        viewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func viewSetup(){
        
        WebService().getArticlesData { articles in
            
            if let answer = articles{
                self.newsList = answer
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? Int
        
        let detailVC = segue.destination as! NewsDetailVC
        detailVC.news = newsList[index!]
    }
}

extension MainVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let new = newsList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        
        cell.labelTitle.text = new.title
        cell.labelDescription.text = new.description
        cell.imageNews.layer.cornerRadius = 10
        
        if let url = URL(string: new.urlToImage ?? "") {
                   
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                       
                DispatchQueue.main.async {
                    if let data = data{
                        cell.imageNews.image = UIImage(data: data)
                    }
                }
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: indexPath.row)
    }
}
