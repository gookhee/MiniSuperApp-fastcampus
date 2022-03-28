import UIKit

final class HomeWidgetView: UIView {
    private let tapHandler: () -> Void
    
    init(viewModel: AppHome.ViewModel.Widget, tapHandler: @escaping () -> Void) {
        self.tapHandler = tapHandler
        super.init(frame: .zero)
        setupViews()
        update(with: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func update(with viewModel: AppHome.ViewModel.Widget) {
        imageView.image = UIImage(systemName: viewModel.imageName)
        titleLabel.text = viewModel.title
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private func setupViews() {
        addSubview(imageView)
        addSubview(titleLabel)
        backgroundColor = .white
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tap)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14)
    ])
    }
    
    @objc
    private func didTap() {
        tapHandler()
    }
}
