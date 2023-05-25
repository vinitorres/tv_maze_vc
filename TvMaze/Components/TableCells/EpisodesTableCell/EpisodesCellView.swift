//
//
// Created by André Vinícius Torres Conrado
//

import UIKit
import SnapKit

class EpisodesCellView: UIView {
    
    var onSelected:((_ episode: Episode) -> Void)?
    
    var seasonEpisodes: [Episode] = []
    
    lazy var episodesCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: EpisodesFlowLayout())
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare(season: [Episode], onSelected:((_ episode: Episode) -> Void)?) {
        self.onSelected = onSelected
        seasonEpisodes = season
        seasonLabel.text = "Season \(season.first?.season ?? 0)"
        episodesCollection.reloadData()
    }
}

extension EpisodesCellView: ViewConfiguration {
    
    func buildViewHierarchy() {
        addSubview(seasonLabel)
        addSubview(episodesCollection)
    }
    
    func setupContraints() {
        setupSeasonLabelConstraints()
        setupEpisodesCollectionConstraints()
    }
    
    func setupSeasonLabelConstraints() {
        seasonLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
    }
    
    func setupEpisodesCollectionConstraints() {
        episodesCollection.snp.makeConstraints { make in
            make.top.equalTo(seasonLabel.snp.bottom).offset(8)
            make.bottom.equalTo(self.snp.bottom).offset(8)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(180)
        }
    }

}

extension EpisodesCellView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seasonEpisodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCollectionCell.identifier, for: indexPath) as! EpisodeCollectionCell
        cell.prepare(episode: seasonEpisodes[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.onSelected?(seasonEpisodes[indexPath.row])
    }
    
}
