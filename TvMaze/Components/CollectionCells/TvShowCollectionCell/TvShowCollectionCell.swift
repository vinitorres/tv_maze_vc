import UIKit

class TvShowCollectionCell: UICollectionViewCell {
    
    static let identifier: String = "TvShowCollectionCell"
    
    var tvShow: TvShow?
    
    lazy var customView: TvShowCellView = {
        var view = TvShowCellView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        customView.prepareForReuse()
    }
    
    func prepare(tvShow: TvShow) {
        customView.prepare(tvShow: tvShow)
    }
    
}

extension TvShowCollectionCell: ViewConfiguration {
    
    func buildViewHierarchy() {
        self.contentView.addSubview(customView)
    }
    
    func setupContraints() {
        configCustomViewConstraints()
    }
    
    func configCustomViewConstraints() {
        customView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

