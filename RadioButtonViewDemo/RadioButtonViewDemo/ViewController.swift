//
//  ViewController.swift
//  RadioButtonViewDemo
//
//  Created by 王杰 on 2024/12/31.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    
    enum RadioButtonOptionType: CaseIterable {
        case radar
        case rainfall
        case temperature
        case warning

        // 返回 normalIconName
        var normalIconName: String {
            switch self {
            case .radar:
                return "RADA_L3_MST_CREF-CREF2_icon_nor"
            case .rainfall:
                return "SURF_CHN_MUL_HOR-rain1H_icon_nor"
            case .temperature:
                return "SURF_CHN_MUL_HOR-TEM_icon_nor"
            case .warning:
                return "warn_icon_nor"
            }
        }

        // 返回 selectedIconName
        var selectedIconName: String {
            switch self {
            case .radar:
                return "RADA_L3_MST_CREF-CREF2_icon_sel"
            case .rainfall:
                return "SURF_CHN_MUL_HOR-rain1H_icon_sel"
            case .temperature:
                return "SURF_CHN_MUL_HOR-TEM_icon_sel"
            case .warning:
                return "warn_icon_sel"
            }
        }

        // 返回标题
        var title: String {
            switch self {
            case .radar:
                return "雷达"
            case .rainfall:
                return "雨量"
            case .temperature:
                return "气温"
            case .warning:
                return "预警"
            }
        }

        // 返回额外数据
        var extraData: String {
            switch self {
            case .radar:
                return "RADA_L3_MST_CREF-CREF2"
            case .rainfall:
                return "SURF_CHN_MUL_HOR-rain1H"
            case .temperature:
                return "SURF_CHN_MUL_HOR-TEM"
            case .warning:
                return "warn"
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        createElementsUI()
    }

    func createElementsUI() {
        let options = RadioButtonOptionType.allCases.map { optionType in
            RadioButtonOption(
                normalIconName: optionType.normalIconName,
                selectedIconName: optionType.selectedIconName,
                title: optionType.title,
                extraData: optionType.extraData
            )
        }
        
        let radioButtonView = RadioButtonView(
            frame: CGRect(x: 20, y: 100, width: 45, height: 300),
            topSpacing: 10,
            bottomSpacing: 10,
            buttonSpacing: 20,
            options: options,
            normalTextColor: .color064064064a1,
            selectedTextColor: .themeColor
        )
        
        radioButtonView.buttonSelectionCallback = { [weak self] selectedIndex in
            print("选中按钮的索引：\(selectedIndex)")
            print("选中按钮的额外数据：\(options[selectedIndex].extraData)")
            
            
            
        }
        
        view.addSubview(radioButtonView)
        radioButtonView.snp.makeConstraints { make in
            //            make.top.equalTo(100)
            make.width.equalTo(45)
            //            make.right.equalTo(-5)
            make.center.equalToSuperview()
            make.height.equalTo(radioButtonView.getTotalHeight())
            //            make.height.equalTo(300)
            
        }
    }
}

