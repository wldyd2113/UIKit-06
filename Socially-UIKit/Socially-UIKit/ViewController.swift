

import UIKit
import FirebaseFirestore
class ViewController: UIViewController {
    enum Section {
        case main
    }
    
    private var db: Firestore!
    private var dataSource: UITableViewDiffableDataSource<Section, Post>!
    private var tableView: UITableView!
    private var listener: ListenerRegistration?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Feed"
        self.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "text.bubble"), tag: 0)
        
        db = Firestore.firestore()
        configureTableView()
    }
    
    func configureTableView() {
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
            print(item.description ?? "-")
            cell?.contentConfiguration = config
            return cell
        }
    }
    
    func startListeningToFirestore() {
        listener = db.collection("Posts").addSnapshotListener {
            [weak self] querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            dump(documents)
            let posts = documents.compactMap { Post(document: $0) }
            self?.updateDataSource(with: posts)
        }
    }
    
    func updateDataSource(with posts: [Post]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Post>()
        snapshot.appendSections([.main])
        snapshot.appendItems(posts, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    deinit {
        listener?.remove()
    }
}

