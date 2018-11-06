//
//  EFAutoScrollLabel.swift
//  EFAutoScrollLabel
//
//  Created by EyreFree on 2017/3/6.
//
//  Copyright (c) 2017 EyreFree <eyrefree@eyrefree.org>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

public enum EFAutoScrollDirection {
    case Right
    case Left
}

public class EFAutoScrollLabel: UIView {

    private static let kLabelCount = 2
    private static let kDefaultFadeLength = CGFloat(7.0)
    private static let kDefaultLabelBufferSpace = CGFloat(20)  // Pixel buffer space between scrolling label
    private static let kDefaultPixelsPerSecond = 30.0
    private static let kDefaultPauseTime = 1.5

    public var scrollDirection = EFAutoScrollDirection.Right {
        didSet {
            scrollLabelIfNeeded()
        }
    }

    // Pixels per second, defaults to 30
    public var scrollSpeed = EFAutoScrollLabel.kDefaultPixelsPerSecond {
        didSet {
            scrollLabelIfNeeded()
        }
    }

    // Defaults to 1.5
    public var pauseInterval = EFAutoScrollLabel.kDefaultPauseTime

    // Pixels, defaults to 20
    public var labelSpacing = EFAutoScrollLabel.kDefaultLabelBufferSpace

    public var animationOptions: UIView.AnimationOptions = UIView.AnimationOptions.curveLinear

    // Returns YES, if it is actively scrolling, NO if it has paused or if text is within bounds (disables scrolling).
    public var scrolling = false

    // Defaults to 7
    public var fadeLength = EFAutoScrollLabel.kDefaultFadeLength {
        didSet {
            if oldValue != fadeLength {
                refreshLabels()
                applyGradientMaskForFadeLength(fadeLengthIn: fadeLength, enableFade: false)
            }
        }
    }

    // UILabel properties
    public var text: String? {
        get {
            return mainLabel.value(forKey: "text") as? String
        }
        set {
            setText(text: newValue, refresh: true)
        }
    }

    public func setText(text: String?, refresh: Bool) {
        // Ignore identical text changes
        if text == self.text {
            return
        }

        for l in labels {
            l.text = text
        }

        if refresh {
            refreshLabels()
        }
    }

    public var attributedText: NSAttributedString? {
        get {
            return mainLabel.attributedText
        }
        set {
            setAttributedText(text: newValue, refresh: true)
        }
    }

    public func setAttributedText(text: NSAttributedString?, refresh: Bool) {
        if text == self.attributedText {
            return
        }
        for l in labels {
            l.attributedText = text
        }
        if refresh {
            refreshLabels()
        }
    }

    public var textColor: UIColor! {
        get {
            return self.mainLabel.textColor
        }
        set {
            for lab in labels {
                lab.textColor = newValue
            }
        }
    }

    public var font: UIFont! {
        get {
            return mainLabel.font
        }
        set {
            for lab in labels {
                lab.font = newValue
            }
            refreshLabels()
            invalidateIntrinsicContentSize()
        }
    }

    public var shadowColor: UIColor? {
        get {
            return self.mainLabel.shadowColor
        }
        set {
            for lab in labels {
                lab.shadowColor = newValue
            }
        }
    }

    public var shadowOffset: CGSize {
        get {
            return self.mainLabel.shadowOffset
        }
        set {
            for lab in labels {
                lab.shadowOffset = newValue
            }
        }
    }

    public override var intrinsicContentSize: CGSize {
        get {
            return CGSize(width: 0.0, height: self.mainLabel.intrinsicContentSize.height)
        }
    }

    // Only applies when not auto-scrolling
    public var textAlignment: NSTextAlignment = .left

    // Views
    private var labels: [UILabel] = {
        var ls = [UILabel]()
        for index in 0 ..< EFAutoScrollLabel.kLabelCount {
            ls.append(UILabel())
        }
        return ls
    }()
    private var mainLabel: UILabel {
        return labels.first ?? UILabel()
    }

    lazy public private(set) var scrollView: UIScrollView = {
        let sv = UIScrollView(frame: self.bounds)
        sv.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        sv.backgroundColor = UIColor.clear
        return sv
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        assert(EFAutoScrollLabel.kLabelCount > 0, "EFAutoScrollLabel.kLabelCount must be greater than zero!")

        addSubview(scrollView)

        // Create the labels
        for index in 0 ..< EFAutoScrollLabel.kLabelCount {
            labels[index].backgroundColor = UIColor.clear
            labels[index].autoresizingMask = autoresizingMask
            self.scrollView.addSubview(labels[index])
        }

        // Default values
        self.scrollDirection = EFAutoScrollDirection.Left
        self.scrollSpeed = EFAutoScrollLabel.kDefaultPixelsPerSecond
        self.pauseInterval = EFAutoScrollLabel.kDefaultPauseTime
        self.labelSpacing = EFAutoScrollLabel.kDefaultLabelBufferSpace
        self.fadeLength = EFAutoScrollLabel.kDefaultFadeLength
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.isScrollEnabled = false
        self.isUserInteractionEnabled = false
        self.backgroundColor = UIColor.clear
        self.clipsToBounds = true
    }

    public override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            super.frame = newValue
            didChangeFrame()
        }
    }

    public override var bounds: CGRect {
        get {
            return super.bounds
        }
        set {
            super.bounds = newValue
            didChangeFrame()
        }
    }

    private func didChangeFrame() {
        refreshLabels()
        applyGradientMaskForFadeLength(fadeLengthIn: self.fadeLength, enableFade: self.scrolling)
    }

    public func observeApplicationNotifications() {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(
            self, selector: #selector(EFAutoScrollLabel.scrollLabelIfNeeded),
            name: UIApplication.willEnterForegroundNotification, object: nil
        )
        NotificationCenter.default.addObserver(
            self, selector: #selector(EFAutoScrollLabel.scrollLabelIfNeeded),
            name: UIApplication.didBecomeActiveNotification, object: nil
        )
    }

    @objc private func enableShadow() {
        scrolling = true
        self.applyGradientMaskForFadeLength(fadeLengthIn: self.fadeLength, enableFade: true)
    }

    @objc public func scrollLabelIfNeeded() {
        if text == nil || text?.count == 0 {
            return
        }

        DispatchQueue.main.async {
            [weak self] in
            if let strongSelf = self {
                strongSelf.scrollLabelIfNeededAction()
            }
        }
    }

    func scrollLabelIfNeededAction() {
        let labelWidth = self.mainLabel.bounds.width
        if labelWidth <= self.bounds.width {
            return
        }

        NSObject.cancelPreviousPerformRequests(
            withTarget: self, selector: #selector(EFAutoScrollLabel.scrollLabelIfNeeded), object: nil
        )
        NSObject.cancelPreviousPerformRequests(
            withTarget: self, selector: #selector(EFAutoScrollLabel.enableShadow), object: nil
        )

        self.scrollView.layer.removeAllAnimations()

        let doScrollLeft = self.scrollDirection == EFAutoScrollDirection.Left
        self.scrollView.contentOffset = doScrollLeft ? .zero : CGPoint(
            x: labelWidth + self.labelSpacing, y: 0
        )

        self.perform(
            #selector(EFAutoScrollLabel.enableShadow), with: nil, afterDelay: self.pauseInterval
        )

        // Animate the scrolling
        let duration = Double(labelWidth) / self.scrollSpeed

        UIView.animate(
            withDuration: duration,
            delay: self.pauseInterval,
            options: [self.animationOptions, UIView.AnimationOptions.allowUserInteraction],
            animations: { [weak self] () -> Void in
                if let strongSelf = self {
                    // Adjust offset
                    strongSelf.scrollView.contentOffset = doScrollLeft
                        ? CGPoint(x: labelWidth + strongSelf.labelSpacing, y: 0)
                        : CGPoint.zero
                }
        }) { [weak self] finished in
            if let strongSelf = self {
                strongSelf.scrolling = false

                // Remove the left shadow
                strongSelf.applyGradientMaskForFadeLength(
                    fadeLengthIn: strongSelf.fadeLength, enableFade: false
                )

                // Setup pause delay/loop
                if finished {
                    strongSelf.performSelector(
                        inBackground: #selector(EFAutoScrollLabel.scrollLabelIfNeeded), with: nil
                    )
                }
            }
        }
    }

    @objc private func refreshLabels() {
        var offset = CGFloat(0)

        for lab in labels {
            lab.sizeToFit()

            var frame = lab.frame
            frame.origin = CGPoint(x: offset, y: 0)
            frame.size.height = bounds.height
            lab.frame = frame

            lab.center = CGPoint(x: lab.center.x, y: round(center.y - self.frame.minY))

            offset += lab.bounds.width + labelSpacing

            lab.isHidden = false
        }

        scrollView.contentOffset = CGPoint.zero
        scrollView.layer.removeAllAnimations()

        // If the label is bigger than the space allocated, then it should scroll
        if mainLabel.bounds.width > bounds.width {
            var size = CGSize(width: 0, height: 0)
            size.width = self.mainLabel.bounds.width + self.bounds.width + self.labelSpacing
            size.height = self.bounds.height
            self.scrollView.contentSize = size

            self.applyGradientMaskForFadeLength(fadeLengthIn: self.fadeLength, enableFade: self.scrolling)

            scrollLabelIfNeeded()
        } else {
            for lab in labels {
                lab.isHidden = lab != mainLabel
            }

            // Adjust the scroll view and main label
            self.scrollView.contentSize = self.bounds.size
            self.mainLabel.frame = self.bounds
            self.mainLabel.isHidden = false
            self.mainLabel.textAlignment = self.textAlignment

            // Cleanup animation
            scrollView.layer.removeAllAnimations()

            applyGradientMaskForFadeLength(fadeLengthIn: 0, enableFade: false)
        }

    }

    private func applyGradientMaskForFadeLength(fadeLengthIn: CGFloat, enableFade fade: Bool) {
        var fadeLength = fadeLengthIn

        let labelWidth = mainLabel.bounds.width
        if labelWidth <= self.bounds.width {
            fadeLength = 0
        }

        if fadeLength != 0 {
            gradientMaskFade(fade: fade)
        } else {
            layer.mask = nil
        }
    }

    func gradientMaskFade(fade: Bool) {
        // Recreate gradient mask with new fade length
        let gradientMask = CAGradientLayer()

        gradientMask.bounds = self.layer.bounds
        gradientMask.position = CGPoint(x: self.bounds.midX, y: self.bounds.midY)

        gradientMask.shouldRasterize = true
        gradientMask.rasterizationScale = UIScreen.main.scale

        gradientMask.startPoint = CGPoint(x: 0, y: self.frame.midY)
        gradientMask.endPoint = CGPoint(x: 1, y: self.frame.midY)

        // Setup fade mask colors and location
        let transparent = UIColor.clear.cgColor

        let opaque = UIColor.black.cgColor
        gradientMask.colors = [transparent, opaque, opaque, transparent]

        // Calcluate fade
        let fadePoint = fadeLength / self.bounds.width
        var leftFadePoint = fadePoint
        var rightFadePoint = 1 - fadePoint
        if !fade {
            switch (self.scrollDirection) {
            case .Left:
                leftFadePoint = 0

            case .Right:
                leftFadePoint = 0
                rightFadePoint = 1
            }
        }

        // Apply calculations to mask
        gradientMask.locations = [
            0, NSNumber(value: Double(leftFadePoint)), NSNumber(value: Double(rightFadePoint)), 1
        ]

        // Don't animate the mask change
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        self.layer.mask = gradientMask
        CATransaction.commit()
    }

    private func onUIApplicationDidChangeStatusBarOrientationNotification(notification: NSNotification) {
        // Delay to have it re-calculate on next runloop
        perform(#selector(EFAutoScrollLabel.refreshLabels), with: nil, afterDelay: 0.1)
        perform(#selector(EFAutoScrollLabel.scrollLabelIfNeeded), with: nil, afterDelay: 0.1)
    }
}
