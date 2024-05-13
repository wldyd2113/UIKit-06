//
//  JournalListTableViewCell.swift
//  JRNL-Codeonly
//
//  Created by 차지용 on 5/13/24.
//

import UIKit

class JournalListTableViewCell: UITableViewCell {
    
    private lazy var thumbnailView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "face.smiling")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return dateLabel
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return titleLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(thumbnailView)
        addSubview(dateLabel)
        addSubview(titleLabel)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
}
