//
//  PostDetailViewController.swift
//  PetSNS
//
//  Created by 大西玲音 on 2021/08/23.
//

import UIKit

final class PostDetailViewController: UIViewController {

    @IBOutlet private weak var postView: UIView!
    @IBOutlet private weak var commentTableView: UITableView!

    private let cellID = "PostDetailViewController"

    override func viewDidLoad() {
        super.viewDidLoad()

        commentTableView.delegate = self
        commentTableView.dataSource = self
    }

}

extension PostDetailViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)

        return cell
    }

}
