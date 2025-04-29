//
//  TaskHeaderTableViewHeaderFooterView.swift
//  TaskMate
//
//  Created by Adriel de Souza on 08/05/25.
//

import UIKit

class TaskSectionHeaderView: UITableViewHeaderFooterView {
    static var reuseIdentifier = "TaskSectionHeaderView"
    
    // MARK: Intializer
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Elements

    private lazy var icon: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "square.and.arrow.up"))
        
        image.contentMode = .scaleAspectFit
        image.tintColor = .gray
        
        image.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return image
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
     
        label.text = "Section"
        label.font = Fonts.subheadlineSemibold
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [icon, title])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 13
        
        return stack
    }()
    
    func config(with category: TaskCategory) {
        self.title.text = category.rawValue.uppercased()
        icon.image = UIImage(systemName: category.imageName)
    }
}

extension TaskSectionHeaderView: ViewCodeProtocol {
    func setup() {
        addSubViews()
        setupConstraints()
        
        contentView.backgroundColor = .Background.secondary
    }
    
    func addSubViews() {
        contentView.addSubview(stack)
    }
    
    func setupConstraints() {
        stack.addSafeMargin(contentView)
        
        NSLayoutConstraint.activate([
            icon.widthAnchor.constraint(equalToConstant: 21),
            icon.heightAnchor.constraint(equalToConstant: 21),
            
            stack.topAnchor.constraint(equalTo: contentView.topAnchor),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            contentView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
