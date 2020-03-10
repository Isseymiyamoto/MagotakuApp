//
//  CustomLabel.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/10.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import Foundation
import UIKit

final class DateInputLabel: UILabel {

    var datePickerContainerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    override var canResignFirstResponder: Bool {
        return true
    }

    override var inputView: UIView? {
        return datePickerContainerView
    }

    private func setupView() {
        isUserInteractionEnabled = true

        // 長押しでメニューを表示するのにロングプレスイベントを追加
        let longTap = UILongPressGestureRecognizer(target: self,
                                                   action: #selector(handleLongPressGesture(gesture:)))
        addGestureRecognizer(longTap)
    }

    @objc func handleLongPressGesture(gesture: UILongPressGestureRecognizer) {
        guard let text = text, !text.isEmpty else {
            return
        }
        let menuController = UIMenuController.shared
        if !menuController.isMenuVisible {
            let bounds = textRect(forBounds: self.bounds, limitedToNumberOfLines: 1)
            menuController.setTargetRect(bounds, in: self)
            menuController.setMenuVisible(true, animated: true)
        }
    }
}
