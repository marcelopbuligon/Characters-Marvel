//
//  DetailsViewController.swift
//  Characters-Marvel
//
//  Created by Marcelo Pagliarini Buligon on 25/07/20.
//  Copyright © 2020 Marcelo Pagliarini Buligon. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var charactereImage: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel?
    @IBOutlet weak var hyperlinkView: UIImageView?
    
    private let presenter: DetailsPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGesture()
        presenter.attachView(self)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    init(presenter: DetailsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hyperlinkTapped))
        hyperlinkView?.addGestureRecognizer(tap)
    }
    
    @objc func hyperlinkTapped() {
        presenter.hyperLinkDidTap()
    }
    
    @IBAction func dismissButtonDidTap(_ sender: UIButton) {
      dismiss(animated: true, completion: nil)
    }
}

extension DetailsViewController: DetailsPresenterDelegate {
    
    func setNavigationTitle(_ text: String) {
        navigationItem.title = text
    }
    
    func setupImage(imageUrl: String) {
        charactereImage?.loadImage(from: imageUrl)
    }
    
    func setupTitle(title: String) {
        titleLabel?.text = title
    }
    
    func setupDescription(description: String) {
        descriptionLabel?.text = description
    }
    
    func openURL(_ url: URL) {
        UIApplication.shared.open(url, options: [:])
    }
}
