//
//
// Created by André Vinícius Torres Conrado
//

import UIKit
import SnapKit

class GenreCellView: UIView {
        
    lazy var nameLabel: UILabel = {
        let title = UILabel()
        title.textColor = UIColor.black
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 20
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare(genre: String) {
        nameLabel.text = genre
    }

}

extension GenreCellView: ViewConfiguration {
    
    func buildViewHierarchy() {
        addSubview(nameLabel)
    }
    
    func setupContraints() {
        configViewConstraints()
        configNameLabelConstraints()
    }
    
    func configViewConstraints() {
        self.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
    
    func configNameLabelConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.snp.leading).offset(12)
            make.trailing.equalTo(self.snp.trailing).inset(12)
        }
    }
    
}
