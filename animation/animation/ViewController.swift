//
//  ViewController.swift
//  animation
//
//  Created by Andra Pop on 27/08/2018.
//  Copyright © 2018 Halcyonmobile. All rights reserved.
//

import UIKit

fileprivate struct LayoutValues {
    static let sectionHeaderHeight: CGFloat                   = 15.0
    static let floatingActionButtonSize: CGFloat              = 48.0
    static let floatingActionButtonInset: CGFloat             = 10.0
    static let actionButtonHeight: CGFloat                    = 36.0
}

class myViewController: UIViewController {
    var startingPoint: CGPoint = CGPoint()
    var checkinView: UIView = UIView()
    var checkinMessageLabel: UILabel = UILabel()
    var floatingActionButton: LNFloatingActionButton!
    var checkinViewHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        startingPoint = CGPoint(x: view.frame.width - 38, y: view.frame.height + 38)
        addCircle()
        addButton()

    }
    
    func addButton() {

        floatingActionButton.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
//        floatingActionButton.delegate = self
//        floatingActionButton.dataSource = self
        floatingActionButton.size = LayoutValues.floatingActionButtonSize
        floatingActionButton.color = UIColor.blue
        floatingActionButton.touchingColor = UIColor.purple
        floatingActionButton.shadowOffset = CGSize(width: 0.0, height: 2.0)
        floatingActionButton.shadowOpacity = 0.25
        floatingActionButton.shadowRadius = 2.0
        floatingActionButton.shadowPath = floatingActionButton.circlePath
//        floatingActionButton.closedImage = #imageLiteral(resourceName: "icon_add_white")
        floatingActionButton.cellHorizontalAlign = .right
        view.addSubview(floatingActionButton)
        
    
    }
    
    
    let VerticalScaleFactor: CGFloat = UIScreen.main.bounds.size.height / 568
    let HorizontalScaleFactor: CGFloat = UIScreen.main.bounds.size.width / 320
    func addCircle() {
        floatingActionButton = LNFloatingActionButton(x: view.frame.width - LayoutValues.floatingActionButtonSize - LayoutValues.floatingActionButtonInset, y: view.frame.height - 107 - view.safeAreaInsets.bottom)
//        floatingActionButton = LNFloatingActionButton()
        var button = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 20), size: CGSize(width:100 , height: 20)))
        button.setTitle("ANIMATE BACK", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(animateBack), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        view.addSubview(button)
      
        
        checkinView = UIView()
        var viewSize = CGSize(width: 200, height: 200)
        checkinViewHeight = view.frame.height + 110
        checkinView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: view.frame.height + 110, height: view.frame.height + 110))
        checkinView.center = CGPoint(x: view.frame.width - 35, y: view.frame.height - 80)
        checkinView.backgroundColor = UIColor.blue
        checkinView.layer.cornerRadius = checkinView.frame.width / 2

        checkinView.alpha = 0.5
        view.addSubview(checkinView)

        checkinMessageLabel = UILabel()
        checkinMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        let string =  "Start deep change today \nCheck in daily and increase your\nhealing progress"
        let attributedString = NSMutableAttributedString(string: "Start deep change today \nCheck in regularly and increase your\nhealing progress")
        let mutableParagraphStyle = NSMutableParagraphStyle()
        mutableParagraphStyle.lineSpacing = 9
        checkinMessageLabel.numberOfLines = 0
        checkinMessageLabel.font = UIFont.systemFont(ofSize: 15)
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: mutableParagraphStyle, range: NSMakeRange(0, attributedString.length))
        attributedString.addAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)], range: (string as NSString).range(of: "Start deep change today"))
        checkinMessageLabel.attributedText = attributedString
        checkinMessageLabel.textColor = .white
        checkinMessageLabel.alpha = 0
        view.addSubview(checkinMessageLabel)

        let metrics: [String : CGFloat] = ["topP": VerticalScaleFactor * 230 ]

        let views: [String : UIView] = ["checkinMessageLabel" : checkinMessageLabel]
        var constraints = [NSLayoutConstraint]()
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-(30)-[checkinMessageLabel]|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(topP)-[checkinMessageLabel]|", options: [], metrics: metrics, views: views)
        NSLayoutConstraint.activate(constraints)
        
        checkinView.alpha = 0
        self.checkinView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)

      //  circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        
        // 1. create a gesture recognizer (tap gesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        
        // 2. add the gesture recognizer to a view
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
     
    
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        guard let location = touch?.location(in: self.view) else { return }
        let distance:CGFloat = sqrt(CGFloat(powf((Float(self.checkinView.center.x - location.x)), 2) + powf((Float(self.checkinView.center.y - location.y)), 2)))
        if distance < checkinViewHeight / 2 {
            print("Tapped IN the view")
        } else {
            print("Tapped OUT the view")

        }
//        if !self.checkinView.frame.contains(location) {
//            print("Tapped outside the view")
//        }else {
//            print("Tapped inside the view")
//        }
    }
    
    @objc func animateBack() {
        print("sdada")
        UIView.animate(withDuration: 1.5, animations: {
            self.pulsator.stop()
            self.checkinView.alpha = 0
            self.checkinView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self.checkinMessageLabel.alpha = 0
            
            
            //            self.checkinMessageLabel.alpha = 0
            //            self.checkinView.backgroundColor = .white
        }, completion: { _ in
            self.floatingActionButton.alpha = 0.5
            self.floatingActionButton.color = .blue

        } )
    }
    let pulsator = Pulsator()

    @objc func handleTap() {
//        self.checkinView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)

        UIView.animate(withDuration: 0.6, animations: {

            self.checkinView.alpha = 0.5
            self.checkinView.transform = CGAffineTransform.identity
            self.floatingActionButton.alpha = 1
            self.floatingActionButton.color = .white
            self.floatingActionButton.touchingColor = UIColor.white
            self.checkinMessageLabel.alpha = 1
          
            
//            self.checkinMessageLabel.alpha = 0
//            self.checkinView.backgroundColor = .white
        }, completion: { _ in
            self.pulsator.position = CGPoint(x: self.floatingActionButton.frame.midX, y: self.floatingActionButton.frame.midY)
            self.view.layer.addSublayer(self.pulsator)
            
            self.pulsator.pulseInterval = 0.5
            self.pulsator.numPulse = 2
            self.pulsator.radius = 40
//            pulsator.duration = 15
            
            
            self.pulsator.start()
        } )
        
  
    }

}


