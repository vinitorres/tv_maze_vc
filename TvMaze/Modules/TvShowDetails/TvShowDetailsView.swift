import UIKit
import SnapKit
import Kingfisher

protocol TvShowDetailsViewDelegate {
    
}

class TvShowDetailsView: UIView {
    
    var viewDelegate: TvShowDetailsViewDelegate?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var infoContainerView = UIView()
    
    lazy var imageContainerView: UIView = {
        let height = UIScreen.main.bounds.height * 0.4
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height))
        return view
    }()

    lazy var backButton: CustomBackButton = {
        let customBackButton = CustomBackButton()
        return customBackButton
    }()
    
    lazy var bannerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image_placeholder")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = UIColor.black
        title.font = UIFont.boldSystemFont(ofSize: 22)
        title.numberOfLines = 2
        return title
    }()
    
    lazy var genresCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: GenreFlowLayout())
        collection.register(GenreCollectionCell.self, forCellWithReuseIdentifier: GenreCollectionCell.identifier)
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
        
    lazy var summaryLabel: UILabel = {
        let title = UILabel()
        title.textColor = UIColor.black
        title.text = "Summary"
        title.font = UIFont.boldSystemFont(ofSize: 18)
        return title
    }()
    
    lazy var summaryTextLabel: UILabel = {
        let title = UILabel()
        title.textColor = UIColor.black
        title.numberOfLines = 0
        return title
    }()
    
    lazy var daysAndTimeLabel: UILabel = {
        let title = UILabel()
        title.textColor = UIColor.black
        title.font = UIFont.boldSystemFont(ofSize: 18)
        title.text = "Days and Time"
        return title
    }()
    
    lazy var daysAndTimeTextLabel: UILabel = {
        let title = UILabel()
        title.textColor = UIColor.black
        title.text = "---"
        return title
    }()
    
    lazy var castLabel: UILabel = {
        let title = UILabel()
        title.text = "Cast"
        title.font = UIFont.boldSystemFont(ofSize: 18)
        title.textColor = UIColor.black
        return title
    }()
    
    lazy var actorsCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: CastFlowLayout())
        collection.register(ActorCollectionCell.self, forCellWithReuseIdentifier: ActorCollectionCell.identifier)
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    lazy var episodesLabel: UILabel = {
        let title = UILabel()
        title.text = "Episodes"
        title.font = UIFont.boldSystemFont(ofSize: 18)
        title.textColor = UIColor.black
        return title
    }()
    
    lazy var episodesTable: AutoSizeTableView = {
        let table = AutoSizeTableView()
        table.isScrollEnabled = false
        table.backgroundColor = UIColor.yellow
        table.separatorStyle = .none
        table.register(EpisodesTableCell.self, forCellReuseIdentifier: EpisodesTableCell.identifier)
        return table
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare(tvShow: TvShow) {
        bannerImage.kf.setImage(with: tvShow.posterUrl)
        titleLabel.text = tvShow.name
        summaryTextLabel.text = tvShow.summary
        genresCollection.reloadData()
        genresCollection.layoutIfNeeded()
    }
    
    func setupGenresCollection(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        genresCollection.delegate = delegate
        genresCollection.dataSource = dataSource
    }
    
    func setupActorsCollection(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        actorsCollection.delegate = delegate
        actorsCollection.dataSource = dataSource
    }
    
    func setupEpisodesTable(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        episodesTable.delegate = delegate
        episodesTable.dataSource = dataSource
    }
    
    func refreshTableViewSize() {
        episodesTable.reloadData()
    }
    
}

extension TvShowDetailsView: ViewConfiguration {
    
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(mainStackView)
        
        imageContainerView.addSubview(bannerImage)
        imageContainerView.addSubview(backButton)
        
        mainStackView.addArrangedSubview(imageContainerView)
        mainStackView.addArrangedSubview(infoContainerView)
        
        infoContainerView.addSubview(infoStackView)
        
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(genresCollection)
        infoStackView.addArrangedSubview(summaryLabel)
        infoStackView.addArrangedSubview(summaryTextLabel)
        infoStackView.addArrangedSubview(daysAndTimeLabel)
        infoStackView.addArrangedSubview(daysAndTimeTextLabel)
        infoStackView.addArrangedSubview(castLabel)
        infoStackView.addArrangedSubview(actorsCollection)
        infoStackView.addArrangedSubview(episodesLabel)
        infoStackView.addArrangedSubview(episodesTable)
    }
    
    func setupContraints() {
        configScrollViewConstraints()
        configMainStackViewConstraints()
        configInfoStackViewConstraints()
        configImageContainerViewConstraints()
        configBannerImageConstraints()
        configbackButtonConstraints()
        configGenresCollectionConstraints()
        configActorsCollectionConstraints()
    }
    
    func configScrollViewConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.bottom.greaterThanOrEqualTo(self.snp.bottom)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
        }
    }
    
    func configMainStackViewConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(self.snp.width)
        }
    }
    
    func configInfoStackViewConstraints() {
        infoStackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    func configImageContainerViewConstraints() {
        let height = UIScreen.main.bounds.width / 0.7
        imageContainerView.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
    }
    
    func configbackButtonConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(imageContainerView.snp.top).offset(16)
            make.leading.equalTo(imageContainerView.snp.leading).offset(16)
        }
    }
    
    func configBannerImageConstraints() {
        bannerImage.snp.makeConstraints { make in
            make.top.equalTo(imageContainerView.snp.top)
            make.bottom.equalTo(imageContainerView.snp.bottom)
            make.leading.equalTo(imageContainerView.snp.leading)
            make.trailing.equalTo(imageContainerView.snp.trailing)
        }
    }
    
    func configGenresCollectionConstraints() {
        genresCollection.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(60).priority(.high)
        }
    }
    
    func configActorsCollectionConstraints() {
        actorsCollection.snp.makeConstraints { make in
            make.height.equalTo(180)
        }
    }
    
}


