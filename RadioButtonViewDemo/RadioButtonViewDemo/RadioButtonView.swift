//
//  Untitled.swift
//  JiangSuWeather
//
//  Created by 王杰 on 2024/12/31.
//

import UIKit

struct RadioButtonOption {
    let normalIconName: String
    let selectedIconName: String
    let title: String
    let extraData: String
}

class RadioButtonView: UIView {
    
    var buttonSelectionCallback: ((Int) -> Void)?
    
    private var buttonContainers: [UIView] = []
    private var imageViews: [UIImageView] = []
    private var labels: [UILabel] = []
    
    private var selectedIndex: Int = 0 {
        didSet {
            updateSelectionStates()
        }
    }

    private let options: [RadioButtonOption]
    
    private let iconSize: CGFloat = 16
    private let textFont: UIFont = .systemFont(ofSize: 12, weight: .regular)
    private let spacing: CGFloat = 4
    private var topSpacing: CGFloat = 10
    private var bottomSpacing: CGFloat = 10
    private var buttonSpacing: CGFloat = 20

    private let normalTextColor: UIColor
    private let selectedTextColor: UIColor

    init(frame: CGRect, topSpacing: CGFloat, bottomSpacing: CGFloat, buttonSpacing: CGFloat, options: [RadioButtonOption], normalTextColor: UIColor = .gray, selectedTextColor: UIColor = .red) {
        self.options = options
        self.normalTextColor = normalTextColor
        self.selectedTextColor = selectedTextColor
        super.init(frame: frame)
        setupViewStyle()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViewStyle() {
        layer.cornerRadius = 12
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 8
        backgroundColor = .white
    }

    private func setupUI() {
        for index in 0..<options.count {
            createButtonContainer(index: index)
        }
        layoutButtonContainers()
        updateSelectionStates()
    }

    private func createButtonContainer(index: Int) {
        let option = options[index]
        let containerView = UIView()
        containerView.tag = index
        containerView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(containerTapped(_:)))
        containerView.addGestureRecognizer(tapGesture)

        let imageView = UIImageView(image: UIImage(named: option.normalIconName))
        imageView.contentMode = .scaleAspectFit
        containerView.addSubview(imageView)
        imageViews.append(imageView)

        let label = UILabel()
        label.text = option.title
        label.textAlignment = .center
        label.textColor = normalTextColor
        label.font = textFont
        containerView.addSubview(label)
        labels.append(label)

        addSubview(containerView)
        buttonContainers.append(containerView)

        imageView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: iconSize, height: iconSize))
        }
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(spacing)
            make.centerX.equalToSuperview()
        }
    }

    private func layoutButtonContainers() {
        for (index, container) in buttonContainers.enumerated() {
            container.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                if index == 0 {
                    make.top.equalToSuperview().offset(topSpacing)
                } else {
                    make.top.equalTo(buttonContainers[index - 1].snp.bottom).offset(buttonSpacing)
                }
//                let textHeight = labels[index].sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).height
                let textHeight = 12.0

                let buttonHeight = iconSize + textHeight + spacing
                make.height.equalTo(buttonHeight)
            }

            // 添加分割线，但不对最后一个元素添加
            if index < buttonContainers.count - 1 {
                let separator = UIView()
                separator.backgroundColor = .color237237237a1
                addSubview(separator)

                separator.snp.makeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.top.equalTo(container.snp.bottom).offset(buttonSpacing / 2 - 1) // 居中于相邻按钮
                    make.height.equalTo(1)
                    make.width.equalTo(20)
                }
            }
        }

        buttonContainers.last?.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-bottomSpacing)
        }
    }

    private func updateSelectionStates() {
        for (index, imageView) in imageViews.enumerated() {
            let isSelected = index == selectedIndex
            imageView.image = UIImage(named: isSelected ? options[index].selectedIconName : options[index].normalIconName)
            labels[index].textColor = isSelected ? selectedTextColor : normalTextColor
        }
    }

    @objc private func containerTapped(_ sender: UITapGestureRecognizer) {
        guard let containerView = sender.view else { return } // 检查 view 是否存在
        let index = containerView.tag // 直接获取 tag 值
        
        // 动画效果：缩放
        UIView.animate(withDuration: 0.1,
                       animations: {
            containerView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                       completion: { _ in
            UIView.animate(withDuration: 0.1) {
                containerView.transform = .identity
            }
        })
        
        if index != selectedIndex {
            selectedIndex = index
            buttonSelectionCallback?(index)
        }
    }
    
    func getTotalHeight() -> CGFloat {
        let buttonHeight = options.reduce(0) { sum, option -> CGFloat in
//            let textHeight = option.title.size(withAttributes: [.font: textFont]).height
            let textHeight = 12.0

            return sum + (iconSize + textHeight + spacing)
        }
        return topSpacing + buttonHeight + CGFloat(options.count - 1) * buttonSpacing + bottomSpacing
    }
}
