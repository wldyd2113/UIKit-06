

import UIKit
import FirebaseFirestore
class ViewController: UIViewController {
    enum Section {
        case main
    }
    
    private var db: Firestore!
    private var dataSource: UITableViewDiffableDataSource<Section, Post>!
    private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Feed"
        self.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "text.bubble"), tag: 0)
    }
    
    func configureTable() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "postCell")
        tableView.rowHeight = 280
    }
    
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Post>(tableView: tableView) {
            (tableView, indexPath, item) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "postCell")
            var config = cell?.defaultContentConfiguration()
            config?.text = item.description
            cell?.contentConfiguration = config
            return cell
        }
    }
}

