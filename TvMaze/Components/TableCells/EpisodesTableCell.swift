//
//  EpisodesTableCell.swift
//  TvMaze
//

import UIKit

class EpisodesTableCell: UITableViewCell {
    
    static let identifier: String = "EpisodesTableCell"
    
    var seasonEpisodes: [Episode] = []
    
    lazy var episodesCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(EpisodeCollectionCell.self, forCellWithReuseIdentifier: EpisodeCollectionCell.identifier)
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    lazy var seasonLabel: UILabel = {
        let title = UILabel()
        title.textColor = UIColor.black
        return title
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare(season: [Episode]) {
        seasonEpisodes = season
        seasonLabel.text = "Season \(season.first?.season ?? 0)"
        episodesCollection.reloadData()
    }
}

extension EpisodesTableCell: ViewConfiguration {
    
    func buildViewHierarchy() {
        self.contentView.addSubview(seasonLabel)
        self.contentView.addSubview(episodesCollection)
    }
    
    func setupContraints() {
        setupSeasonLabelConstraints()
        setupEpisodesCollectionConstraints()
    }
    
    func setupSeasonLabelConstraints() {
        seasonLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
        }
    }
    
    func setupEpisodesCollectionConstraints() {
        episodesCollection.snp.makeConstraints { make in
            make.top.equalTo(seasonLabel.snp.bottom).offset(8)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(8)
            make.leading.equalTo(self.contentView.snp.leading)
            make.trailing.equalTo(self.contentView.snp.trailing)
            make.height.equalTo(180)
        }
    }

}

extension EpisodesTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seasonEpisodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCollectionCell.identifier, for: indexPath) as! EpisodeCollectionCell
        cell.prepare(episode: seasonEpisodes[indexPath.row])
        return cell
    }
    
}
