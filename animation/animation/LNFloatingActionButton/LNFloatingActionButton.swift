//
//  LNFloatingActionButton.swift
//  LNFloatingActionButton
//
//  Created by Shuhei Kawaguchi on 2016/11/26.
//  Copyright © 2016年 Shuhei Kawaguchi. All rights reserved.
//

import UIKit
import QuartzCore

@objc public protocol LNFloatingActionButtonDataSource {
    func numberOfCells(_ floatingActionButton: LNFloatingActionButton) -> Int
    func cellForIndex(_ index: Int) -> LNFloatingActionButtonCell
}

@objc public protocol LNFloatingActionButtonDelegate {
    @objc optional func floatingActionButton(_ floatingActionButton: LNFloatingActionButton, didSelectItemAtIndex index: Int)
}

open class LNFloatingActionButton: UIView {
    open let imageView = UIImageView()  // TODO: private
    open var closedImage: UIImage? = nil {
        didSet {
            imageView.image = closedImage
        }
    }
    open var openedImage: UIImage?
    private var originalImage: UIImage?
    private var circleLayer: CAShapeLayer = CAShapeLayer()
    
    open var shadowOffset: CGSize {
        get { return circleLayer.shadowOffset }
        set { circleLayer.shadowOffset = newValue }
    }
    open var shadowOpacity: Float {
        get { return circleLayer.shadowOpacity }
        set { circleLayer.shadowOpacity = newValue }
    }
    open var shadowRadius: CGFloat {
        get { return circleLayer.shadowRadius }
        set { circleLayer.shadowRadius = newValue }
    }
    open var shadowPath: CGPath? {
        get { return circleLayer.shadowPath }
        set { circleLayer.shadowPath = newValue }
    }
    open var circlePath: CGPath? {
        return circleLayer.path
    }
    
    open var internalRatio: CGFloat = 0.75
    open var cellMargin: CGFloat = 10.0
    open var btnToCellMargin: CGFloat = 15.0
    
    open var size: CGFloat = 70 {
        didSet {
            frame.size = CGSize(width: size, height: size)
            circleLayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            circleLayer.cornerRadius = size / 2
            resizeSubviews()
        }
    }
    open var color = UIColor(red: 0/255.0, green: 157/255.0, blue: 238/255.0, alpha: 1.0) {
        didSet {
            containerView.normalColor = color
            circleLayer.backgroundColor = color.cgColor
        }
    }
    open var touchingColor: UIColor? {
        didSet {
            containerView.selectedColor = touchingColor ?? color.withAlphaComponent(0.5)
        }
    }
    
    open var isBackgroundView = false
    var cellList : [LNFloatingActionButtonCell] = []
    private var backgroundView = UIControl()
    open var backgroundViewColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.5) {
        didSet {
            backgroundView.backgroundColor = backgroundViewColor
        }
    }
    
    open var responsible = true
    open fileprivate(set) var isClosed = true
    fileprivate var containerView: ContainerButton!
    
    open var titleLabelPosition = TitleLabelPosition.left  // TODO: move extension
    open var cellHorizontalAlign = CellHorizontalAlign.center
    
    open weak var delegate:   LNFloatingActionButtonDelegate?
    open weak var dataSource: LNFloatingActionButtonDataSource?
    
    private var touching = false
    
    open var btnAnimationWithOpen: (LNFloatingActionButton) -> () = { $0.rotate45BtnAnimationWithOpen() }
    open var btnAnimationWithClose: (LNFloatingActionButton) -> () = { $0.rotate45BtnAnimationWithClose() }
    open var cellAnimationWithOpen: (LNFloatingActionButton) -> () = { $0.popCellAnimationWithOpen() }
    open var cellAnimationWothClose: (LNFloatingActionButton) -> () = { $0.popCellAnimationWithClose() }
    
    // MARK: - init
    public init(x: CGFloat, y: CGFloat) {
        super.init(frame: CGRect(x: x, y: y, width: size, height: size))
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: -
    open override func draw(_ rect: CGRect) {
        responseCircle()
    }
    
    public func cells() -> [LNFloatingActionButtonCell] {
        var result: [LNFloatingActionButtonCell] = []
        guard let source = dataSource else { return result }
        
        for i in 0..<source.numberOfCells(self) {
            result.append(source.cellForIndex(i))
        }
        return result
    }
    
    public func open() {
//        self.subviews.filter { !($0 is UIImageView) }.forEach { $0.removeFromSuperview() }
        cellList.removeAll()
        if isBackgroundView {
            backgroundView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            backgroundView.backgroundColor = backgroundViewColor
            backgroundView.isUserInteractionEnabled = true
            self.window?.insertSubview(backgroundView, belowSubview: containerView)
            backgroundView.addTarget(self, action: #selector(close), for: UIControlEvents.touchUpInside)
            
            containerView.removeFromSuperview()
            containerView.frame = CGRect(x: frame.origin.x, y: frame.origin.y + (superview?.frame.origin.y ?? 0.0), width: frame.width, height: frame.height)
            backgroundView.addSubview(containerView)
        }
        if openedImage == nil {
            btnAnimationWithOpen(self)
        } else {
            originalImage = imageView.image
            imageView.image = openedImage
        }
        cells().forEach {
            insert(cell: $0)
            cellList.append($0)
        }
        cellAnimationWithOpen(self)
        isClosed = false
    }
    
    @objc public func close() {
        containerView.removeFromSuperview()
        containerView.frame = bounds
        addSubview(containerView)
        
        backgroundView.removeFromSuperview()
        
        if openedImage == nil {
            btnAnimationWithClose(self)
        } else {
            imageView.image = originalImage
            originalImage = nil
        }
        cellAnimationWothClose(self)
        isClosed = true
    }
    
    @objc fileprivate func containerTapped() {
        isClosed ? open() : close()
    }
    
    // MARK: - Private
    private func setup() {
        self.backgroundColor = UIColor.clear
        self.clipsToBounds = false
        
        containerView = ContainerButton(frame: bounds)
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.backgroundColor = backgroundColor
        containerView.clipsToBounds = false
        containerView.addTarget(self, action: #selector(containerTapped), for: .touchUpInside)
        self.addSubview(containerView)
        
        setupCircleLayer()
        
        imageView.clipsToBounds = false
        containerView.addSubview(imageView)
        resizeSubviews()
    }
    
    private func resizeSubviews() {
        let size = CGSize(width: frame.width * 0.5, height: frame.height * 0.5)
        imageView.frame = CGRect(x: frame.width - frame.width * internalRatio, y: frame.height - frame.height * internalRatio,
                                 width: size.width, height: size.height)
    }
    
    private func responseCircle() {
        if touching && responsible {
            circleLayer.backgroundColor = touchingColor?.cgColor ?? color.withAlphaComponent(0.5).cgColor
        } else {
            circleLayer.backgroundColor = color.cgColor
        }
    }
    
    private func setupCircleLayer() {
        circleLayer.removeFromSuperlayer()
        circleLayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        circleLayer.backgroundColor = color.cgColor
        circleLayer.cornerRadius = size / 2
        containerView.layer.addSublayer(circleLayer)
        containerView.circleLayer = circleLayer
    }
    
    private func insert(cell: LNFloatingActionButtonCell) {
        cell.alpha = 0
        switch cellHorizontalAlign {
        case .center:
            cell.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        case .left:
            cell.frame.origin.x = 0
            cell.frame.origin.y = self.frame.size.height/2 - cell.frame.size.height/2
        case .right:
            cell.layer.transform = CATransform3DIdentity
            cell.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
            cell.frame.origin.x = self.frame.size.width - cell.frame.size.width
        }
        cell.actionButton = self
        
        containerView.addSubview(cell)
    }
    
    private func isTouched(_ touches: Set<UITouch>) -> Bool {
        return touches.count == 1 && touches.first?.tapCount == 1 && touches.first?.location(in: self) != nil
    }
    
    // MARK: - Action
    func didTap(cell: LNFloatingActionButtonCell) {
        guard let _ = dataSource else { return }
        cells().enumerated()
            .filter { $1 === cell }
            .forEach { index, _ in delegate?.floatingActionButton?(self, didSelectItemAtIndex: index) }
    }
}

// MARK: - animation
extension LNFloatingActionButton {
    // MARK: - cell
    public func popCellAnimationWithOpen() {
        var cellHeight = btnToCellMargin
        var delay = 0.0
        cells().forEach { cell in
            cellHeight += cell.size + cellMargin
            cell.frame.origin.y = -cellHeight
            cell.layer.transform = CATransform3DMakeScale(0.4, 0.4, 1)
            UIView.animate(withDuration: 0.3, delay: delay, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.3,
                           options: UIViewAnimationOptions(),
                           animations: {
                            cell.layer.transform = CATransform3DIdentity
                            cell.alpha = 1
            }, completion: nil)
            delay += 0.1
        }
    }
    
    public func popCellAnimationWithClose() {
        var delay = 0.0
        cellList.forEach { cell in
            cell.layer.transform = CATransform3DIdentity
            
            UIView.animate(withDuration: 0.15, delay: delay, options: [.beginFromCurrentState, .overrideInheritedCurve], animations: {
                cell.layer.transform = CATransform3DMakeScale(0.4, 0.4, 1)
                cell.alpha = 0
            }, completion: { _ in
                cell.layer.transform = CATransform3DIdentity
            })
            delay += 0.1
        }
    }
    
    // MARK: - button
    public func rotate45BtnAnimationWithOpen() {
        UIView.animate(withDuration: 0.3) { () -> Void in
            self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi) * 45.0 / 180.0)
        }
    }
    
    public func rotate45BtnAnimationWithClose() {
        UIView.animate(withDuration: 0.3) { () -> Void in
            self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi) * 0 / 180.0)
        }
    }
}

class ContainerButton: UIButton {
    
    fileprivate (set) var circleLayer: CAShapeLayer!
    var normalColor: UIColor!
    var selectedColor: UIColor!
    
    override var isHighlighted: Bool {
        didSet {
            circleLayer.backgroundColor = isHighlighted ? selectedColor.cgColor : normalColor.cgColor
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        for subview in subviews.reversed() {
            let subPoint = subview.convert(point, from: self)
            if let result = subview.hitTest(subPoint, with: event) {
                return result
            }
        }
        
        return super.hitTest(point, with: event)
    }
}
