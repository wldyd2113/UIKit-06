import UIKit
import FirebaseFirestore
import Kingfisher

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
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "text.bubble"), tag: 0)
        
        db = Firestore.firestore()
        configureTableView()
        configureDataSource()
        startListeningToFirestore()
        
        let barItem = UIBarButtonItem(systemItem: .add,
                                      primaryAction: UIAction { [weak self] action in
            let newPostViewController = NewPostViewController()
            let navigationController = UINavigationController(rootViewController: newPostViewController)

            if let sheet = navigationController.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 20
            }

            self?.present(navigationController, animated: true, completion: nil)
        })

        navigationItem.rightBarButtonItem = barItem
    }

    func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "postCell")
        tableView.rowHeight = 280
    }
    
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Post>(tableView: tableView) {
            (tableView, indexPath, item) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
            cell.configureItem(with: item)
            
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
