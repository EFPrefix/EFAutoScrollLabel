//
//  EFAutoScrollLabel.swift
//  LPDBusiness
//
//  Created by EyreFree on 17/3/6.
//  Copyright © 2017年 LPD. All rights reserved.
//

import UIKit

let kLabelCount = 2
let kDefaultFadeLength = CGFloat(7.0)
let kDefaultLabelBufferSpace = CGFloat(20)  // Pixel buffer space between scrolling label
let kDefaultPixelsPerSecond = 30.0
let kDefaultPauseTime = 1.5

public enum AutoScrollDirection {
    case Right
    case Left
}

public class EFAutoScrollLabel: UIView {

    public var scrollDirection = AutoScrollDirection.Right {
        didSet {
            scrollLabelIfNeeded()
        }
    }

    // Pixels per second, defaults to 30
    public var scrollSpeed = 30.0 {
        didSet {
            scrollLabelIfNeeded()
        }
    }

    // Defaults to 1.5
    public var pauseInterval = 1.5

    // Pixels, defaults to 20
    public var labelSpacing = CGFloat(20)

    public var animationOptions: UIViewAnimationOptions!

    /**
     * Returns YES, if it is actively scrolling, NO if it has paused or if text is within bounds (disables scrolling).
     */
    public var scrolling = false

    // Defaults to 7
    public var fadeLength = CGFloat(7) {
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
            return mainLabel.text
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
    public var textAlignment: NSTextAlignment!

    // Views
    private var labels = [UILabel]()
    private var mainLabel: UILabel! {
        if labels.count > 0 {
            return labels[0]
        }
        return nil
    }

    private var sv: UIScrollView!
    public var scrollView: UIScrollView! {
        get {
            if sv == nil {
                sv = UIScrollView(frame: self.bounds)
                sv.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
                sv.backgroundColor = UIColor.clear
            }

            return sv
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {

        addSubview(scrollView)

        // Create the labels
        for _ in 0 ..< kLabelCount {
            let label = UILabel()
            label.backgroundColor = UIColor.clear
            label.autoresizingMask = autoresizingMask

            // Store labels
            self.scrollView.addSubview(label)
            labels.append(label)
        }

        // Default values
        scrollDirection = AutoScrollDirection.Left
        scrollSpeed = kDefaultPixelsPerSecond
        self.pauseInterval = kDefaultPauseTime
        self.labelSpacing = kDefaultLabelBufferSpace
        self.textAlignment = NSTextAlignment.left
        self.animationOptions = UIViewAnimationOptions.curveLinear
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.isScrollEnabled = false
        self.isUserInteractionEnabled = false
        self.backgroundColor = UIColor.clear
        self.clipsToBounds = true
        self.fadeLength = kDefaultFadeLength
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
            name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil
        )
        NotificationCenter.default.addObserver(
            self, selector: #selector(EFAutoScrollLabel.scrollLabelIfNeeded),
            name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil
        )
    }

    @objc private func enableShadow() {
        scrolling = true
        self.applyGradientMaskForFadeLength(fadeLengthIn: self.fadeLength, enableFade: true)
    }

    public func scrollLabelIfNeeded() {
        if text == nil || text?.characters.count == 0 {
            return
        }

        let labelWidth = mainLabel.bounds.width
        if labelWidth <= self.bounds.width {
            return
        }

        NSObject.cancelPreviousPerformRequests(
            withTarget: self, selector: #selector(EFAutoScrollLabel.scrollLabelIfNeeded), object: nil
        )
        NSObject.cancelPreviousPerformRequests(
            withTarget: self, selector: #selector(EFAutoScrollLabel.enableShadow), object: nil
        )

        scrollView.layer.removeAllAnimations()

        let doScrollLeft = scrollDirection == AutoScrollDirection.Left
        self.scrollView.contentOffset = doScrollLeft ? CGPoint.zero : CGPoint(x: labelWidth + labelSpacing, y: 0)

        perform(#selector(EFAutoScrollLabel.enableShadow), with: nil, afterDelay: self.pauseInterval)

        // Animate the scrolling
        let duration = Double(labelWidth) / scrollSpeed

        UIView.animate(
            withDuration: duration,
            delay: pauseInterval,
            options: [self.animationOptions, UIViewAnimationOptions.allowUserInteraction],
            animations: { () -> Void in
                // Adjust offset
                self.scrollView.contentOffset = doScrollLeft ? CGPoint(x: labelWidth + self.labelSpacing, y: 0) : CGPoint.zero
        }) {
            finished in
            self.scrolling = false

            // Remove the left shadow
            self.applyGradientMaskForFadeLength(fadeLengthIn: self.fadeLength, enableFade: false)

            // Setup pause delay/loop
            if finished {
                self.performSelector(inBackground: #selector(EFAutoScrollLabel.scrollLabelIfNeeded), with: nil)
            }
        }
    }

    @objc private func refreshLabels() {
        var offset = CGFloat(0)

        if mainLabel == nil {
            return
        }

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

        if mainLabel == nil {
            return
        }

        let labelWidth = mainLabel.bounds.width
        if labelWidth <= self.bounds.width {
            fadeLength = 0
        }

        if fadeLength != 0 {
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
        } else {
            layer.mask = nil
        }
    }
    
    private func onUIApplicationDidChangeStatusBarOrientationNotification(notification: NSNotification) {
        // Delay to have it re-calculate on next runloop
        perform(#selector(EFAutoScrollLabel.refreshLabels), with: nil, afterDelay: 0.1)
        perform(#selector(EFAutoScrollLabel.scrollLabelIfNeeded), with: nil, afterDelay: 0.1)
    }
}
