//
//  MenuCell.swift
//  WinfoxTestTaskApp
//
//  Created by TeRb1 on 27.08.2022.
//

import UIKit

class MenuCell: UITableViewCell {
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var postImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "rest")
        return image
    }()
    
    private lazy var nameOfPost: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var priceOfPost: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.text = "Цена: "
        return label
    }()
    
    private lazy var priceOfPosition: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .systemIndigo
        return label
    }()
    
    private lazy var placeOfPost: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .systemGray2
        return label
    }()
    
    private lazy var weightOfPost: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .systemGray2
        return label
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviewInContentView() {
        self.contentView.addSubview(mainView)
        self.mainView.addSubview(postImage)
        self.mainView.addSubview(nameOfPost)
        self.mainView.addSubview(priceOfPost)
        self.mainView.addSubview(placeOfPost)
        self.mainView.addSubview(weightOfPost)
        self.mainView.addSubview(priceOfPosition)
    }
    
    private func setupConstraints() {
        mainView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(5)
        }
        
        postImage.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(self.mainView).dividedBy(1.5)
        }
        
        nameOfPost.snp.makeConstraints { make in
            make.bottom.equalTo(postImage).inset(-35)
            make.left.right.equalToSuperview().inset(10)
        }
        
        priceOfPost.snp.makeConstraints { make in
            make.bottom.equalTo(nameOfPost).inset(-20)
            make.left.right.equalToSuperview().inset(10)
        }
        
        placeOfPost.snp.makeConstraints { make in
            make.bottom.equalTo(priceOfPost).inset(-20)
            make.left.right.equalToSuperview().inset(10)
        }
        
        weightOfPost.snp.makeConstraints { make in
            make.bottom.equalTo(placeOfPost).inset(-20)
            make.left.right.equalToSuperview().inset(10)
        }
        
        priceOfPosition.snp.makeConstraints { make in
            make.bottom.equalTo(nameOfPost).inset(-20)
            make.left.equalTo(priceOfPost).inset(45)
            make.right.equalToSuperview().inset(20)
        }
    }
    
    private func configureCell() {
        self.contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(350)
        }
        self.contentView.backgroundColor = .systemIndigo
        addSubviewInContentView()
        setupConstraints()
    }
    
    func setupMenuData(_ data: Menu) {
        nameOfPost.text = data.name
        
        let price = data.price
        let weight = data.weight
        
        priceOfPosition.text = String(price)
        weightOfPost.text = String(weight)
        
        if let url = URL(string: data.image) {
            if let data = try? Data(contentsOf: url) {
                postImage.image = UIImage(data: data)
            }
        }
    }
}
