//
//  BuyVC.swift
//  Sweetheart
//
//  Created by anmin on 30.01.2021.
//

import UIKit

class BuyVC: UIViewController{
    
    var herts: Int = 5
    
    var backBtn = UIButton()
    var balance = UIButton()
    
    var buyLabel = UILabel()
    var freeButton = UIButton()
    
    var tableView = UITableView()
    
    var model = TypeOfSell.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.backBtn)
        self.backBtn.translatesAutoresizingMaskIntoConstraints = false
        self.backBtn.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 23).isActive = true
        self.backBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 38).isActive = true
        self.backBtn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        self.backBtn.widthAnchor.constraint(equalToConstant: 121).isActive = true
        
        self.backBtn.setImage(UIImage(named: "backBtn"), for: .normal)
        self.backBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 23)
        
        self.backBtn.setTitle("Рейтинг", for: .normal)
        self.backBtn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        self.backBtn.setTitleColor(.black, for: .normal)
        self.backBtn.addTarget(self, action: #selector(self.back), for: .touchUpInside)
        
        self.view.addSubview(self.balance)
        self.balance.translatesAutoresizingMaskIntoConstraints = false
        self.balance.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 19).isActive = true
        self.balance.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -32).isActive = true
        self.balance.heightAnchor.constraint(equalToConstant: 28).isActive = true
        self.balance.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        self.balance.contentHorizontalAlignment = .right
        self.balance.semanticContentAttribute = .forceRightToLeft
        self.balance.imageEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: -3)
        self.balance.setImage(UIImage(named: "Hearts"), for: .normal)
        
        self.balance.setTitle(String(self.herts), for: .normal)
        self.balance.setTitleColor(UIColor(r: 255, g: 95, b: 41), for: .normal)
        //        self.balance.addTarget(self, action: #selector(self.openBuy), for: .touchUpInside)
        
        self.view.addSubview(self.buyLabel)
        self.buyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.buyLabel.topAnchor.constraint(equalTo: self.backBtn.bottomAnchor, constant: 66).isActive = true
        self.buyLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.buyLabel.text = "Покупка"
        self.buyLabel.font = .boldSystemFont(ofSize: 24)
        self.buyLabel.textColor = .black
        
        self.view.addSubview(self.freeButton)
        self.freeButton.translatesAutoresizingMaskIntoConstraints = false
        self.freeButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -32).isActive = true
        self.freeButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32).isActive = true
        self.freeButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -32).isActive = true
        self.freeButton.heightAnchor.constraint(equalToConstant: 49).isActive = true
        
        self.freeButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        self.freeButton.layer.cornerRadius = 8
        self.freeButton.semanticContentAttribute = .forceRightToLeft
        self.freeButton.setTitle("Получить бесплатно", for: .normal)
        self.freeButton.setImage(UIImage(named: "Hearts")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.freeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        self.freeButton.backgroundColor = UIColor(r: 255, g: 239, b: 234)
        self.freeButton.setTitleColor(UIColor(r: 255, g: 95, b: 45), for: .normal)
        self.freeButton.tintColor = UIColor(r: 255, g: 95, b: 45)
        
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.buyLabel.bottomAnchor, constant: 30).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.freeButton.topAnchor, constant: -30).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -32).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32).isActive = true
        
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(BuyCell.self, forCellReuseIdentifier: "BuyCell")
    }
    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension BuyVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BuyCell", for: indexPath) as! BuyCell
        cell.configure(type: self.model[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 81
    }
    

}


class BuyCell: UITableViewCell{
    var countLabel = UILabel()
    var priceLabel = UILabel()
    var currency = UILabel()
    
    var view = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = .white
        
        self.addSubview(self.view)
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.view.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.view.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        
        self.view.backgroundColor = UIColor(r: 247, g: 247, b: 247)
        self.view.layer.cornerRadius = 6
        
        self.view.addSubview(self.countLabel)
        self.countLabel.translatesAutoresizingMaskIntoConstraints = false
        self.countLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 24).isActive = true
        self.countLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        self.countLabel.textColor = UIColor(r: 114, g: 114, b: 114)
        self.countLabel.font = .boldSystemFont(ofSize: 14)
        
        self.view.addSubview(self.priceLabel)
        self.priceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.priceLabel.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -1).isActive = true
        self.priceLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -24).isActive = true
        
        self.priceLabel.textColor = UIColor(r: 255, g: 95, b: 45)
        self.priceLabel.font = .boldSystemFont(ofSize: 18)
        self.priceLabel.textAlignment = .right
        
        self.view.addSubview(self.currency)
        self.currency.translatesAutoresizingMaskIntoConstraints = false
        self.currency.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -24).isActive = true
        self.currency.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 2).isActive = true
        
        self.currency.textColor = UIColor(r: 255, g: 95, b: 45)
        self.currency.font = .systemFont(ofSize: 12)
        self.currency.textAlignment = .right
        
    }
    
    func configure(type: TypeOfSell){
        self.countLabel.text = type.text
        self.priceLabel.text = "140"
        self.currency.text = "rub"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum TypeOfSell: CaseIterable{
    case five
    case twoZero
    case fiveZero
    case hundred
    case twoFifty
    case fiveFundred
    
    var text: String {
        switch self {
        case .five:
            return "+ 5 валентинок"
        case .twoZero:
            return "+ 20 валентинок"
        case .fiveZero:
            return "+ 50 валентинок"
        case .hundred:
            return "+ 100 валентинок"
        case .twoFifty:
            return "+ 250 валентинок"
        case .fiveFundred:
            return "+ 500 валентинок"
        }
    }
}
