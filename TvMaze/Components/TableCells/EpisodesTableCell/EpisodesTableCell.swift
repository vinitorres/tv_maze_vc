//
//  EpisodesTableCell.swift
//  TvMaze
//

import UIKit

class EpisodesTableCell: UITableViewCell {
    
    static let identifier: String = "EpisodesTableCell"
    
    var seasonEpisodes: [Episode] = []
    
    lazy var customView: EpisodesCellView = EpisodesCellView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = UITableViewCell.SelectionStyle.none
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare(season: [Episode]) {
        customView.prepare(season: season)
    }
}

extension EpisodesTableCell: ViewConfiguration {
    
    func buildViewHierarchy() {
        self.contentView.addSubview(customView)
    }
    
    func setupContraints() {
        setupCustomViewConstraints()
    }
    
    func setupCustomViewConstraints() {
        customView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
