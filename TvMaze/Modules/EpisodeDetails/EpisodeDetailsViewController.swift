//
//
// Created by André Vinícius Torres Conrado
//


import UIKit

class EpisodeDetailsViewController: UIViewController {
    
    private var customView: EpisodeDetailsView?
    private var viewModel: EpisodeDetailsViewModel?
        
    public override func loadView() {
        self.customView = EpisodeDetailsView()
        self.view = customView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    static func assembleModule(episode: Episode) -> UIViewController {
        let viewController = EpisodeDetailsViewController()
        let viewModel = EpisodeDetailsViewModel(episode: episode)
        viewController.viewModel = viewModel
        return viewController
    }
    
}
