//
//  SecondVC.swift
//  ListDataProject
//
//  Created by macbook  on 2.04.2019.
//  Copyright © 2019 ibrahimballibaba. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit
class SecondVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detay"
        tableView.register(DetailImageCell.self, forCellReuseIdentifier: "imagecell")
        tableView.register(DetailBodyCell.self, forCellReuseIdentifier: "bodycell")
        fetchDetail()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1.0)
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
    }

    
    
    var image: UIImage? = nil
    var imageUrl: String!
    var id = Int()
    var detailModel : [DetailModelRootClass]?
    
    
    func fetchDetail(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments?postId=\(id)")else{
            return
        }
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        let dataTask = URLSession.shared.dataTask(with: req){
            data, response, error in
            
            if error != nil {
                print("error = \(String(describing:error?.localizedDescription))")
            }
            guard let data = data else {
                return
            }
            do{
                // parse json
                let _data = try JSONDecoder().decode([DetailModelRootClass].self, from: data)
                self.detailModel = _data
                
                DispatchQueue.main.async {
                    UIView.transition(with: self.tableView,
                                      duration: 0.4,
                                      options: .transitionCrossDissolve,
                                      animations: { self.tableView.reloadData() })
                }
                
                
            }catch let err {
                print("error = \(err.localizedDescription)")
            }
            
        }
        dataTask.resume()
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        }else{
            if let count = detailModel?.count{
                return count
            }
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "imagecell", for: indexPath) as! DetailImageCell
            
            if let _image = self.image{
                cell._imageView.image = _image
            }else{
                cell._imageView.kf.setImage(with: URL(string: imageUrl))
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "bodycell", for: indexPath) as! DetailBodyCell
            if let _model = self.detailModel?[indexPath.row]{
                cell.model = _model
            }
            return cell
        }
        
    }
 

}


class DetailImageCell: BaseCell {
    
    
    
    let _imageView : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.backgroundColor = UIColor(white: 0.8, alpha: 1)
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    override func setupUI() {
        super.setupUI()
        addSubview(_imageView)
        _imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(300)
        }
        _imageView.clipsToBounds = true
        
    }
}

class DetailBodyCell: BaseCell {
    
    
    var model : DetailModelRootClass?{
        didSet{
            nameLabel.text = model?.name
            emailLabel.text = model?.email
            bodyLabel.text = model?.body
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight.bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight.semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0, weight: UIFont.Weight.medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override func setupUI() {
        super.setupUI()
        addSubview(nameLabel)
        addSubview(emailLabel)
        addSubview(bodyLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        emailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        bodyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
}
