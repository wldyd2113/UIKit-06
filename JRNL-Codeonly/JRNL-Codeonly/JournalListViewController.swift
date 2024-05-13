//
//  ViewController.swift
//  JRNL-Codeonly
//
//  Created by 차지용 on 5/13/24.
//

import UIKit

class JournalListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }() //초기화해줌

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableView.self, forCellReuseIdentifier: "Journal")
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let global = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: global.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: global.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: global.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: global.bottomAnchor)
        ])
        
        navigationItem.title = "Journal"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addJournal))
    }
    
    // MARK: - UITableViewDataDource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
    }
    
    // MARK: - Methods
    @objc private func addJournal() {
        let addJournalViewController = AddJournalViewController()
        let navController = UINavigationController(rootViewController: addJournalViewController)
        present(navController, animated: true)
    }

}

