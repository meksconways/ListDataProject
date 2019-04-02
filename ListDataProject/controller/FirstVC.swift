//
//  FirstVC.swift
//  ListDataProject
//
//  Created by macbook  on 2.04.2019.
//  Copyright © 2019 ibrahimballibaba. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
class FirstVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    let tableView: UITableView = {
       let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    func setupUI(){
        self.view.addSubview(tableView)
        self.view.addSubview(bottomFloatView)
        bottomFloatView.addSubview(stackView)
        stackView.addArrangedSubview(whenButton)
        stackView.addArrangedSubview(moveButton)
        stackView.addArrangedSubview(deleteButton)
        stackView.addArrangedSubview(moreButton)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(FirstItemCell.self, forCellReuseIdentifier: "firstid")
        tableView.register(SecondItemCell.self, forCellReuseIdentifier: "secondid")
        tableView.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 64,right: 0)
        tableView.separatorStyle = .none
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        let backButton = UIBarButtonItem()
        backButton.title = "Geri"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        tableView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }
        
        bottomFloatView.layer.cornerRadius = 18.0
        bottomFloatView.backgroundColor = UIColor(red: 0/255, green: 162/255, blue: 232/255, alpha: 1.0)
        
        bottomFloatView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-24)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(44)
        }
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(bottomFloatView.snp.top)
            make.bottom.equalTo(bottomFloatView.snp.bottom)
            make.right.equalTo(bottomFloatView.snp.right).offset(-12)
            make.left.equalTo(bottomFloatView.snp.left).offset(12)
        }
        fetchData()
    }

  
    var firstModel : FirstDataModelRootClass?
    var secondModel : [FirstDataModelRootClass]?
    
    func fetchData(){
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos")else{
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
                
                var allData = try JSONDecoder().decode([FirstDataModelRootClass].self, from: data)
                self.firstModel = allData[0]
                allData.removeFirst()
                self.secondModel = allData
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                
            } catch let err{
                print("catch = \(err.localizedDescription)")
            }
            
        }
        dataTask.resume()
        
    }
    
    
    
    
    let bottomFloatView: UIView = {
        let fv = UIView()
        fv.translatesAutoresizingMaskIntoConstraints = false
        
        return fv
    }()
    
    let stackView: UIStackView = {
        
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.spacing = 6.0
        sv.distribution = .fillProportionally
        return sv
        
    }()
    
    let whenButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.system)
        btn.setImage(UIImage(named: "event"), for: UIControl.State.normal)
        btn.tintColor = UIColor.white
        btn.setTitle("When", for: UIControl.State.normal);
        let spacing = 3.0;
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: CGFloat(spacing));
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: CGFloat(spacing), bottom: 0, right: 0);        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let moveButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.system)
        btn.setTitle("Move", for: UIControl.State.normal)
        btn.tintColor = UIColor.white
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let deleteButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.system)
        btn.setImage(UIImage(named: "delete"), for: UIControl.State.normal)
        btn.tintColor = UIColor.white
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let moreButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.system)
        btn.setImage(UIImage(named: "more"), for: UIControl.State.normal)
        btn.tintColor = UIColor.white
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // MARK: - Table view data source

    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            
            return 1
        }else{
            if let count = self.secondModel?.count{
                return count
            }
            return 0
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let indexPath = tableView.indexPathForSelectedRow
            let currentCell = tableView.cellForRow(at: indexPath!) as! FirstItemCell
            if let _id = self.firstModel?.id{
                
                showDetail(id: _id, image: currentCell.firstCellImage.image,imageUrl: (self.firstModel?.url)!) // değişebilir
            }
           
        }else{
            let indexPath = tableView.indexPathForSelectedRow
            let currentCell = tableView.cellForRow(at: indexPath!) as! SecondItemCell
            if let _id = self.secondModel?[(indexPath?.row)!].id{
                showDetail(id: _id, image: currentCell.secondCellImage.image,imageUrl: self.secondModel![(indexPath?.row)!].url!) // değişebilir
            }
        }
        
    }
    // imageUrl : eğer tıklanan cell'de image henüz yüklenmemişse urlini gönder
    func showDetail(id:Int,image:UIImage?,imageUrl:String) {
        
        let detailController = SecondVC()
        detailController.id = id
        detailController.image = image
        detailController.imageUrl = imageUrl
        self.navigationController?.pushViewController(detailController, animated: true)
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "firstid", for: indexPath) as! FirstItemCell
            cell.selectionStyle = .none
            if let model = self.firstModel{
                cell.model = model
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "secondid", for: indexPath) as! SecondItemCell
            cell.selectionStyle = .none
            if let model = self.secondModel?[indexPath.row]{
                cell.model = model
            }
            return cell
        }


    }



}

class SecondItemCell : BaseCell {
    
    var model: FirstDataModelRootClass?{
        didSet{
            if let imageUrl = model?.url{
                let url = URL(string: imageUrl)
                secondCellImage.kf.setImage(with: url)
            }
            if let titleText = model?.title{
                secondCellTitle.text = titleText
            }
        }
    }
    
    let mainView : UIView =  {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return view
    }()
    
    let secondCellImage : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.backgroundColor = UIColor(white: 0.8, alpha: 1)
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let secondCellTitle : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight.regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    override func setupUI() {
        super.setupUI()
        addSubview(mainView)
        mainView.addSubview(secondCellImage)
        mainView.addSubview(secondCellTitle)
        mainView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
            make.right.equalToSuperview().offset(-16)
            make.left.equalToSuperview().offset(16)
        }
        secondCellImage.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        secondCellTitle.snp.makeConstraints { (make) in
            make.left.equalTo(secondCellImage.snp.right).offset(8)
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(secondCellImage.snp.centerY)
        }
        
        
        
        
    }
}

class FirstItemCell: BaseCell {
    
    
    var model: FirstDataModelRootClass?{
        didSet{
            if let imageUrl = model?.url{
                let url = URL(string: imageUrl)
                firstCellImage.kf.setImage(with: url)
            }
            if let titleText = model?.title{
                firstCellTitle.text = titleText
            }
        }
    }
    
    let firstCellImage : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.backgroundColor = UIColor(white: 0.7, alpha: 1)
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let firstCellTitle : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0, weight: UIFont.Weight.semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override func setupUI() {
        super.setupUI()
        addSubview(firstCellImage)
        addSubview(firstCellTitle)
        firstCellImage.clipsToBounds = true
        firstCellImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(200)
        }
        firstCellTitle.snp.makeConstraints { (make) in
            make.top.equalTo(firstCellImage.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
            
        }
    }
    
}

class BaseCell : UITableViewCell{
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
    }
    
}
