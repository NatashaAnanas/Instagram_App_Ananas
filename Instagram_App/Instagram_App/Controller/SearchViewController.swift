//
//  SearchViewController.swift
//  Instagram_App
//
//  Created by Анастасия Козлова on 17.10.2022.
//

import UIKit

/// Контроллер поиска
final class SearchViewController: UIViewController {

    // MARK: - Private Constant
    private enum Constant {
        static let indentifierFirstText = "first"
        static let indentifierSecondText = "second"
        static let indentifierThirdText = "third"
        static let indentifierCellText = "cell"
        static let indentifierViewText = "view"
        static let indentifierCollectionText = "collection"
        static let indentifierImageCellText = "imageCell"
        static let images = ["me", "me2", "me1", "sergey", "durovv", "valya", "we", "durov", "pavel", "дом1", "дом2"]
        static let cells: [Cell] = [ .main, .info, .scroll, .chouse, .collection]
    }
    
    private enum Cell {
        case main
        case info
        case scroll
        case chouse
        case collection
    }
    
    // MARK: - Private IBOutlet
    @IBOutlet private weak var bigTableView: UITableView!
    
    // MARK: - Private Visual Components
    private let refreshControl: UIRefreshControl = {
        let ref = UIRefreshControl()
        ref.tintColor = .white
        return ref
    }()
    
    // MARK: - Private Property
    private let photo = Photo(images: Constant.images)
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        cereateRefresh()
    }
    
    // MARK: - Private Methods
    private func cereateRefresh() {
        bigTableView.refreshControl = refreshControl
        refreshControl.addTarget(self,
                                 action: #selector(refreshControlActionn),
                                 for: .valueChanged)
    }
    
    @objc private func refreshControlActionn(sender: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.bigTableView.refreshControl?.endRefreshing()
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Constant.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch Constant.cells[indexPath.row] {
        case .main:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.indentifierFirstText, for: indexPath)
                return cell
        case .info:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.indentifierSecondText, for: indexPath)
                return cell
        case .scroll:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.indentifierThirdText, for: indexPath)
                return cell
        case .chouse:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.indentifierCellText, for: indexPath)
                return cell
        case .collection:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.indentifierCollectionText, for: indexPath)
                return cell
        }
        return UITableViewCell()
    }
}

extension SearchViewController: UICollectionViewDataSource,
                                UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photo.images.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.indentifierImageCellText,
        for: indexPath) as? PhotoCollectionViewCell else { return  UICollectionViewCell() }
        
        let image = photo.images[indexPath.item]
        cell.photoImageView.image = UIImage(named: image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let frame = collectionView.frame
        let widhtCell = frame.width / CGFloat(3)
        let heightCell = widhtCell

        return CGSize(width: widhtCell, height: heightCell)
    }
}
