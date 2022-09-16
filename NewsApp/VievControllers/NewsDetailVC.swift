//
//  NewsDetailVC.swift
//  NewsApp
//
//  Created by MacBook on 16.04.2022.
//

import UIKit
import SafariServices

final class NewsDetailVC: UIViewController {

    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    var news:News?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        viewSetup()
    }
    
    @IBAction func goToLink(_ sender: Any) {
        
        guard let url = URL(string: news!.url ?? "") else { return }
    
        let vc = SFSafariViewController(url: url)
        self.present(vc, animated: true)
        
    }
    
    private func viewSetup() {
        
        if let news = news {
            
            labelTitle.text = news.title
            labelDescription.text = news.description
            
            if let url = URL(string: news.urlToImage ?? "") {
                       
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                           
                    DispatchQueue.main.async {
                        self.imageNews.image = UIImage(data: data!)
                    }
                }
            }
        }
    }
}
