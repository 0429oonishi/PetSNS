//
//  SettingViewController.swift
//  PetSNS
//
//  Created by 大西玲音 on 2021/08/23.
//

import UIKit

final class SettingViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var logoutButton: UIButton!
    
    private enum CellType: CaseIterable {
        case themeColor
        case receiveNotification
        case evaluationApp
        case reportBug
        case shareApp
        case privacyAndSecurity
        
        var title: String {
            switch self {
                case .themeColor: return "テーマカラー"
                case .receiveNotification: return "通知を受け取る"
                case .evaluationApp: return "このアプリを評価"
                case .reportBug: return "ご意見、ご要望、不具合の報告"
                case .shareApp: return "このアプリを評価"
                case .privacyAndSecurity: return "プライバシーとセキュリティー"
            }
        }
    }
    private func isReport(_ section: Int) -> Bool {
        return section == 1
    }
    private func isSwitchingCell(indexPath: IndexPath) -> Bool {
        return indexPath.row == 1 && indexPath.section == 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SwitchingTableViewCell.nib,
                           forCellReuseIdentifier: SwitchingTableViewCell.identifier)
        tableView.register(ItemTableViewCell.nib,
                           forCellReuseIdentifier: ItemTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }
    
    @IBAction private func closeButtonDidTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func logoutButtonDidTapped(_ sender: Any) {
        let loginOrSignUpVC = LoginOrSignUpViewController.instantiate()
        let nav = UINavigationController(rootViewController: loginOrSignUpVC)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
}

extension SettingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let index = isReport(indexPath.section) ? indexPath.row + 2 : indexPath.row
        let cellType = CellType.allCases[index]
        switch cellType {
            case .themeColor:
                let themeColorVC = ThemeColorViewController.instantiate()
                self.navigationController?.pushViewController(themeColorVC, animated: true)
            case .receiveNotification: break
            case .evaluationApp: break
            case .reportBug: break
            case .shareApp: break
            case .privacyAndSecurity:
                let privacyAndSecurityVC = PrivacyAndSecurityViewController.instantiate()
                self.navigationController?.pushViewController(privacyAndSecurityVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.rowHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return isReport(section) ? "レポート" : ""
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplayHeaderView view: UIView,
                   forSection section: Int) {
        view.tintColor = .clear
    }
    
}

extension SettingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return isReport(section) ? 4 : 2
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = isReport(indexPath.section) ? indexPath.row + 2 : indexPath.row
        let title = CellType.allCases[index].title
        if isSwitchingCell(indexPath: indexPath) {
            let switchingCell = tableView.dequeueReusableCell(
                withIdentifier: SwitchingTableViewCell.identifier, for: indexPath
            ) as! SwitchingTableViewCell
            switchingCell.configure(title: title, isOn: true)
            return switchingCell
        } else {
            let itemCell = tableView.dequeueReusableCell(
                withIdentifier: ItemTableViewCell.identifier, for: indexPath
            ) as! ItemTableViewCell
            itemCell.configure(title: title)
            return itemCell
        }
    }
    
}
