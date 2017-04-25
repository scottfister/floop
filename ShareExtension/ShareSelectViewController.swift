//
//  ShareSelectViewController.swift
//  Floop
//
//  Created by Scott Fister on 4/24/17.
//  Copyright © 2017 Scott Fister. All rights reserved.
//

import UIKit

protocol ShareSelectViewControllerDelegate: class {
    func selected(deck: Deck)
}

class ShareSelectViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Identifiers.DeckCell)
        return tableView
    }()
    var userDecks = [Deck]()
    weak var delegate: ShareSelectViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        title = "Select Deck"
        view.addSubview(tableView)
    }
}

extension ShareSelectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDecks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.DeckCell, for: indexPath)
        cell.textLabel?.text = userDecks[indexPath.row].title
        cell.backgroundColor = .clear
        return cell
    }
}

extension ShareSelectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selected(deck: userDecks[indexPath.row])
    }
}

private extension ShareSelectViewController {
    struct Identifiers {
        static let DeckCell = "deckCell"
    }
}
