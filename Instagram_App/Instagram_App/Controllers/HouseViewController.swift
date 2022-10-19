//
//  ViewController.swift
//  Instagram_App
//
//  Created by Анастасия Козлова on 17.10.2022.
//

import UIKit

/// Главная страница - лента инстаграм
final class HouseViewController: UIViewController {
    // MARK: - Private VConstant
    private enum Constant {
        static let indentifireStoryText = "story"
        static let indentifirePostText = "post"
        static let indentifireRecText = "rec"
    }

    // MARK: - IBOutlet
    @IBOutlet private weak var instTableView: UITableView!

    // MARK: - Private Visual Components
    private let refreshControl: UIRefreshControl = {
        let ref = UIRefreshControl()
        ref.tintColor = .white
        return ref
    }()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        cereateRefresh()
    }
    // MARK: - Private Methods
    private func cereateRefresh() {
        instTableView.refreshControl = refreshControl
        refreshControl.addTarget(self,
                                 action: #selector(refreshControlActionn),
                                 for: .valueChanged)
    }
    @objc private func refreshControlActionn(sender: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.instTableView.refreshControl?.endRefreshing()
        }
    }
}

extension HouseViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.indentifireStoryText, for: indexPath)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.indentifirePostText, for: indexPath)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.indentifireRecText, for: indexPath)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.indentifirePostText, for: indexPath)
            return cell
        }
    }
}
