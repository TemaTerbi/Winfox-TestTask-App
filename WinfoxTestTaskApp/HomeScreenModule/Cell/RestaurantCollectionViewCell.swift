//
//  RestaurantCollectionViewCell.swift
//  WinfoxTestTaskApp
//
//  Created by TeRb1 on 26.08.2022.
//

import UIKit
import SnapKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "RestaurantCollectionViewCell"
    
    private lazy var imageCell: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "rest")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var labelCell: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        addSubviewInCell()
        addConstraintInCell()
    }
    
    private func addSubviewInCell() {
        contentView.addSubview(imageCell)
        contentView.addSubview(labelCell)
    }
    
    private func addConstraintInCell() {
        imageCell.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(self.contentView).dividedBy(1.5)
        }
        
        labelCell.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(5)
            make.top.equalTo(imageCell).inset(150)
        }
    }
    
    func setupData(_ data: Places) {
        labelCell.text = data.name
        
        if let url = URL(string: data.image) {
            if let data = try? Data(contentsOf: url) {
                imageCell.image = UIImage(data: data)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
