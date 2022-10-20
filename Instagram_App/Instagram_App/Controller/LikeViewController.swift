//
//  LikeViewController.swift
//  Instagram_App
//
//  Created by Анастасия Козлова on 17.10.2022.
//

import UIKit

/// Уведомления пользователя
final class LikeViewController: UIViewController {
    // MARK: - Private Constant
    private enum Constant {
        static let indentifierFollowText = "follow"
        static let indentifierLikeText = "like"
        static let indentifierCommentText = "comment"
        static let indentifierButtonText = "button"
        static let todayText = "Сегодня"
        static let weekText = "На этой неделея"
        static let monthText = "В этом месяце"
    }
    private enum Section {
        case follow
        case today
        case week
        case month
    }
    // MARK: - Private Visual Components
    private let refreshControl: UIRefreshControl = {
        let ref = UIRefreshControl()
        ref.tintColor = .white
        return ref
    }()
    private let allSection: [Section] = [ .follow, .today, .week, .month]

    // MARK: - Private @IBOutlet
    @IBOutlet private weak var likeTableView: UITableView!

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        cereateRefresh()
    }
    // MARK: - Private Methods
    private func cereateRefresh() {
        likeTableView.refreshControl = refreshControl
        likeTableView.refreshControl?.endRefreshing()
    }
}

extension LikeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        allSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch allSection[section] {
        case .follow:
            return 1
        case .today:
            return 3
        case .week:
            return 4
        case .month:
            return 5
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch allSection[indexPath.section] {
            
        case .follow:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.indentifierFollowText, for: indexPath)
            return cell
        
        case .today:
            switch indexPath.row % 3 {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.indentifierLikeText, for: indexPath)
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.indentifierCommentText, for: indexPath)
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.indentifierButtonText,
                                                         for: indexPath)
                return cell
            default:
                break
            }

        case .week:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.indentifierCommentText, for: indexPath)
            return cell
            
        case .month:
            switch indexPath.row % 3 {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.indentifierButtonText, for: indexPath)
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.indentifierCommentText,
                                                         for: indexPath)
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.indentifierLikeText,
                                                         for: indexPath)
                return cell
            default:
                break
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch allSection[section] {
        case .today, .month, .week:
            return 50
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = .black
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 22)

        switch allSection[section] {
        case .today:
            label.text = Constant.todayText
        case .week:
            label.text = Constant.weekText
        case .month:
            label.text = Constant.monthText
        default:
            break
        }
        return label
    }
}
