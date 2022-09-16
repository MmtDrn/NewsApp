//
//  ViewController.swift
//  NewsApp
//
//  Created by MacBook on 16.04.2022.
//

import UIKit

final class MainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var newsList = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSetup()
    }
}

//MARK - Funcs
extension MainVC {
    
    private func viewSetup(){
        
        tableView.dataSource = self
        tableView.delegate = self
        
        WebService.getArticlesData { [weak self] articles in
            
            guard let self = self else { return }
            
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

//MARK - Tableview
extension MainVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let new = newsList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        
        cell.viewSetup(new: new)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: indexPath.row)
    }
}
