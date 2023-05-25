import UIKit
import SnapKit

class TvShowsView: UIView {
    
    lazy var searchTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Search Tv Show"
        textfield.clipsToBounds = true
        textfield.layer.cornerRadius = 8
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.layer.borderWidth = 0.5
        textfield.leftViewMode = UITextField.ViewMode.always
        textfield.returnKeyType = UIReturnKeyType.done
        textfield.autocorrectionType = UITextAutocorrectionType.no
        textfield.autocapitalizationType = UITextAutocapitalizationType.none
        textfield.spellCheckingType = UITextSpellCheckingType.no
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textfield.leftView = padding
        return textfield
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = GridFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TvShowCollectionCell.self, forCellWithReuseIdentifier: TvShowCollectionCell.identifier)
        return collectionView
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setSearchFieldDelegate(_ delegate: UITextFieldDelegate) {
        searchTextField.delegate = delegate
    }
    
    public func setCollectionViewDelegate(_ delegate: UICollectionViewDelegate) {
        collectionView.delegate = delegate
    }
    
    public func setCollectionViewDataSource(_ dataSource: UICollectionViewDataSource) {
        collectionView.dataSource = dataSource
    }
    
    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
    }
    
}

extension TvShowsView: ViewConfiguration {
    
    func buildViewHierarchy() {
        addSubview(searchTextField)
        addSubview(collectionView)
        addSubview(activityIndicator)
    }
    
    func setupContraints() {
        setupSearchTextFieldConstraints()
        setupCollectionViewConstraints()
        setupActivityIndicatorConstraints()
    }
    
    func setupSearchTextFieldConstraints() {
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(self.snp.leading).offset(16)
            make.trailing.equalTo(self.snp.trailing).inset(16)
            make.height.equalTo(45)
        }
    }
    
    func setupCollectionViewConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(8)
            make.leading.equalTo(self.snp.leading)
            make.bottom.equalTo(self.snp.bottom)
            make.trailing.equalTo(self.snp.trailing)
        }
    }
    
    func setupActivityIndicatorConstraints() {
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
    
}
