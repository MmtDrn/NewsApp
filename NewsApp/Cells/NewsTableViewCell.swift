//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by MacBook on 16.04.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func viewSetup(new:News) {
        
        labelTitle.text = new.title
        labelDescription.text = new.description
        imageNews.layer.cornerRadius = 10
        
        if let url = URL(string: new.urlToImage ?? "") {
                   
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                       
                DispatchQueue.main.async {
                    if let data = data{
                        self.imageNews.image = UIImage(data: data)
                    }
                }
            }
        }
    }

}
