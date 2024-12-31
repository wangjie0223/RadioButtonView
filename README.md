# RadioButtonView

🚀 **不要再使用 UICollectionView 了，循环才是王道！**

一个自定义的单选按钮视图组件，支持灵活配置和动态布局，适用于 iOS 项目。通过循环动态布局替代复杂的 UICollectionView，简单高效！

---

## 功能特点

- 🌟 基于循环的动态布局，不依赖 UICollectionView。
- ✨ 支持自定义图标、文字和回调事件。
- 💡 使用 SnapKit 进行手动布局，代码简洁易懂。
- 🔧 自动计算总高度，方便适配各种屏幕。

---

## 效果展示

![RadioButtonView 效果图](https://your-image-link-here)  
_（请将图片上传到 GitHub 的项目中，并替换上方链接）_

---

## 安装和使用

### 1. 安装
将 `RadioButtonView.swift` 文件拷贝到你的项目中。

### 2. 使用示例

```swift
let options = [
    RadioButtonOption(normalIconName: "circle", selectedIconName: "circle.fill", title: "选项一", extraData: "1"),
    RadioButtonOption(normalIconName: "circle", selectedIconName: "circle.fill", title: "选项二", extraData: "2"),
    RadioButtonOption(normalIconName: "circle", selectedIconName: "circle.fill", title: "选项三", extraData: "3")
]

let radioButtonView = RadioButtonView(
    frame: .zero,
    topSpacing: 10,
    bottomSpacing: 10,
    buttonSpacing: 20,
    options: options
)

radioButtonView.buttonSelectionCallback = { selectedIndex in
    print("选择了第 \(selectedIndex + 1) 个选项")
}
