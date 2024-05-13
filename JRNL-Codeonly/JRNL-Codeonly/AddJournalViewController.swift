//
//  AddJournalViewController.swift
//  JRNL-Codeonly
//
//  Created by 차지용 on 5/13/24.
//

import UIKit

protocol AddJournalContrillerDelegate: NSObject {
    func saveJournalEntry(_ journalEntry: JournalEntry)
}

class AddJournalViewController: UIViewController {
    weak var delegate: AddJournalContrillerDelegate?
//    의존성
//    weak var journalListViewController: JournalListViewController?
    private lazy  var mainContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var ratingView: UIStackView = {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 252, height: 44))
        stackView.axis = .horizontal
        stackView.backgroundColor = .systemCyan
        return stackView
    }()
    
    private lazy var toggleView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        let swictchComponent = UISwitch()
        let labelComponent = UILabel()
        labelComponent.text = "Switch Label"
        stackView.addArrangedSubview(swictchComponent)
        stackView.addArrangedSubview(labelComponent)
        
        return stackView
    }()
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Journal Title"
        return textField
    }()

    private lazy var bodyTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Journal Body"
        return textView
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "face.smiling")
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "New Empty"
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        
        mainContainer.addArrangedSubview(ratingView)
        mainContainer.addArrangedSubview(toggleView)
        mainContainer.addArrangedSubview(titleTextField)
        mainContainer.addArrangedSubview(bodyTextView)
        mainContainer.addArrangedSubview(imageView)
        
        view.addSubview(mainContainer)
        
        let safeArea = view.safeAreaLayoutGuide

        mainContainer.translatesAutoresizingMaskIntoConstraints = false
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        toggleView.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        bodyTextView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            mainContainer.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            mainContainer.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            mainContainer.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),

            ratingView.widthAnchor.constraint(equalToConstant: 252),
            ratingView.heightAnchor.constraint(equalToConstant: 44),

            titleTextField.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 8),
            titleTextField.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -8),

            bodyTextView.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 8),
            bodyTextView.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -8),
            bodyTextView.heightAnchor.constraint(equalToConstant: 128),

            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    @objc func save() {
        guard let title = titleTextField.text, !title.isEmpty,
              let body = bodyTextView.text, !body.isEmpty else {
            return
        }
        let journalEntry = JournalEntry(rating: 3, title: title, body: body, photo: UIImage(systemName: "face.smiling"))!
        delegate?.saveJournalEntry(journalEntry)
        dismiss(animated: true)
    }
    @objc func cancel() {
        dismiss(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
