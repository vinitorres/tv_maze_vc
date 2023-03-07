//
//  ViewConfiguration.swift
//  TvMaze
//
//  Created by Vinicius Torres on 23/02/23.
//

protocol ViewConfiguration {
    
    func buildViewHierarchy()
    func setupContraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension ViewConfiguration {
        
    func setupView() {
        buildViewHierarchy()
        setupContraints()
        setupAdditionalConfiguration()
    }
    
    func setupAdditionalConfiguration() {
        
    }
}
