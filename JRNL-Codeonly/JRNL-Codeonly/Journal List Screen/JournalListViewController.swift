//
//  ViewController.swift
//  JRNL-Codeonly
//
//  Created by 차지용 on 5/13/24.
//

import UIKit
//delgate: 연결고리 같은거 
class JournalListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddJournalContrillerDelegate {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }() //초기화해줌
    var sampleJournalEntryData = SampleJournalEntryData()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sampleJournalEntryData.createSampleJournalEntryData()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(JournalListTableViewCell.self, forCellReuseIdentifier: "journalCell")

        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        navigationItem.title = "Journal"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addJournal))
    }
    
    // MARK: - UITableViewDataDource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sampleJournalEntryData.journalEntries.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath) as! JournalListTableViewCell
        let journalEntry = sampleJournalEntryData.journalEntries[indexPath.row]
        cell.configureCell(journalEntry: journalEntry)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let journalDetailViewController = JournalDetailViewController()
        show(journalDetailViewController, sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    // MARK: - Methods
    @objc private func addJournal() {
        let addJournalViewController = AddJournalViewController()
        let navController = UINavigationController(rootViewController: addJournalViewController)
        addJournalViewController.delegate = self
        present(navController, animated: true)
    }
    
    public func saveJournalEntry(_ journalEntry: JournalEntry) {
        print("TEST \(journalEntry.entryTitle)")
    }

}

