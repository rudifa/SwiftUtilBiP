//
//  UIUtil.swift v.0.2.3
//  SwiftUtilBiP
//
//  Created by Rudolf Farkas on 04.09.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

import UIKit

/**
 Create a UIWindow with a UIViewController to present UIAlertController on it.
 from http://lazyself.io/ios/2017/05/18/present-uialertcontroller-when-not-in-a-uiviewcontroller.html
 */
extension UIAlertController {
    /// present alert from a (possibly) non-UIViewController object
    func show() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIViewController()
        window.windowLevel = UIWindow.Level.alert
        window.makeKeyAndVisible()
        window.rootViewController?.present(self, animated: false, completion: nil)
    }
}

// https://www.hackingwithswift.com/example-code/uicolor/how-to-convert-a-hex-color-to-a-uicolor
/// UIColor.init from a #rgba hex string like so:
///     let gold = UIColor(hex: "#ffe700ff")
extension UIColor {
    public convenience init(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xFF00_0000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00FF_0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000_FF00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x0000_00FF) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        self.init(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
    }
}

// MARK: factory methods

extension UILabel {
    static func configuredLabel(text: String) -> UILabel {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        // backgroundColor = .systemBlue // uncomment for visual debugging
        label.font = .preferredFont(forTextStyle: UIFont.TextStyle.title3)
        label.text = text
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }
}

// https://cocoacasts.com/elegant-controls-in-swift-with-closures
/// Button with storage for an action callback
class ButtonWithAction: UIButton {
    typealias ActionCallback = (ButtonWithAction) -> Void

    // On notification from the button calls the actionCallback
    @objc private func onTouchUpInside(sender: UIButton) {
        if let actionCallback = actionCallback {
            actionCallback(self)
        }
    }

    // Receives an assignment of a callback or nil (to remove it)
    var actionCallback: ActionCallback? {
        didSet {
            if actionCallback != nil {
                addTarget(self, action: #selector(onTouchUpInside), for: .touchUpInside)
            } else {
                removeTarget(self, action: #selector(onTouchUpInside), for: .touchUpInside)
            }
        }
    }
}

/*
 Examples of creation of buttons with actions
 private lazy var backgroundColorButton = UIButton.actionButton(title: "Button0", action: backgroundColorButtonTap)
 private lazy var button1 = UIButton.actionButton(title: "Button1", action: { _ in self.printClassAndFunc(info: "Button1") })
 Example of removing the action
 */
extension UIButton {
    /// Returns an instance of ActionButton, configured and initializeed with an action callback.
    /// - Parameters:
    ///   - title: button title for .normal
    ///   - action: action callback
    static func actionButton(title: String, action: @escaping ButtonWithAction.ActionCallback) -> ButtonWithAction {
        let button = ButtonWithAction(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear // uncomment for visual debugging
        button.titleLabel?.font = .preferredFont(forTextStyle: UIFont.TextStyle.title3)
        button.setTitle(title, for: .normal)
        button.sizeToFit()
        button.actionCallback = action
        return button
    }
}

extension UIButton {
    /// Returns an instance of UIButton, configured.
    /// - Parameter title: button title for .normal
    static func configuredButton(title: String) -> UIButton {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGray // uncomment for visual debugging
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitle(title, for: .normal)
        button.sizeToFit()
        return button
    }
}

extension UIStackView {
    /// Returns a configured horizontal stack view with subviews
    /// - Parameter subviews: to add to the stack view
    static func horizontal(subviews: [UIView]) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false // vital

        stackView.axis = .horizontal
        stackView.alignment = .fill // .leading .firstBaseline .center .trailing .lastBaseline
        stackView.distribution = .fillEqually // .fillEqually .fillProportionally .equalSpacing .equalCentering
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 8)

        for subview in subviews {
            stackView.addArrangedSubview(subview)
        }
        return stackView
    }

    /// Returns a configured vertical stack view with subviews
    /// - Parameter subviews: to add to the stack view
    static func vertical(subviews: [UIView]) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false // vital

        stackView.axis = .vertical
        stackView.alignment = .fill // .leading .firstBaseline .center .trailing .lastBaseline
        stackView.distribution = .fillEqually // .fillEqually .fillProportionally .equalSpacing .equalCentering
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

        for subview in subviews {
            stackView.addArrangedSubview(subview)
        }
        return stackView
    }
}

extension UIView {
    /// Adds overlaid on top of self, stretching to cover the self
    /// - Parameters:
    ///   - overlaid: sibling view to add
    public func addSibling(overlaid: UIView) {
        if let superview = self.superview {
            superview.addSubview(overlaid)
            overlaid.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                overlaid.leftAnchor.constraint(equalTo: leftAnchor),
                overlaid.rightAnchor.constraint(equalTo: rightAnchor),
                overlaid.topAnchor.constraint(equalTo: topAnchor),
                overlaid.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
        }
    }
}

