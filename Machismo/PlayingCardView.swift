//
//  PlayingCardView.swift
//  Machismo
//
//  Created by Cheng Wei on 14/8/28.
//  Copyright (c) 2014年 github.com/cheng404. All rights reserved.
//

import Foundation
import UIKit

class PlayCardView: UIControl {
    
    var card: Card? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var faceUp: Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    lazy var swipeGesture: UISwipeGestureRecognizer = {
        var _swipeGesture = UISwipeGestureRecognizer(target: self, action: "swipe:")
        _swipeGesture.direction = .Left | .Right
        return _swipeGesture
    }()
    
    
    class var corner_font_standard_height: CGFloat { return 100.0 }
    class var corner_radius: CGFloat { return 12.0 }

    var cornerScaleFactor: CGFloat {
        return self.bounds.size.height / PlayCardView.corner_font_standard_height
    }
    
    var cornerRadius: CGFloat {
       return self.cornerScaleFactor * PlayCardView.corner_radius
    }
    
    var cornerOffset: CGFloat {
       return self.cornerRadius / 3.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    convenience init(origin: CGPoint, size: CGSize = CGSize(width: 60, height: 70))
    {
        var frame = CGRect(origin: origin, size: size)
        self.init(frame: frame)
    }

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        var roundedRect =  UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        roundedRect.addClip()
        setFill()
        roundedRect.fill()
        UIColor.blackColor().setStroke()
        roundedRect.stroke()
        if faceUp {
            drawCorners()
        }
        else {
            drawCardBack(roundedRect)
        }
        
    }
    
    private func setFill() {
        if !enabled {
            UIColor.grayColor().setFill()
        }
        else {
            faceUp ? UIColor.whiteColor().setFill() : UIColor(red: 43.0/255, green: 121.0/255, blue: 249.0/255, alpha: 0.6).setFill()
        }
    }

    private func drawCardBack(roundedRect: UIBezierPath){
        let squareWidth: CGFloat = 3
        let squareSize = CGSize(width: squareWidth, height: squareWidth)
        roundedRect.fill()
        
        var orginX = self.cornerRadius
        var orginY = self.cornerRadius
        while orginY < self.bounds.height - self.cornerRadius {
            while orginX < self.bounds.width - self.cornerRadius {
                var square =  UIBezierPath(rect: CGRect(origin: CGPoint(x: orginX, y: orginY), size: squareSize))
                UIColor(red: 1, green: 1, blue: 1, alpha: 0.6).setFill()
                square.fill()
                orginX += 2 * squareWidth
            }
            orginX = self.cornerRadius
            orginY += 2 * squareWidth
        }
    }
    
    func tap(sender: UITapGestureRecognizer) {
        self.faceUp = !self.faceUp
    }
    
    func swipe(sender: UISwipeGestureRecognizer) {
        self.faceUp = !self.faceUp
    }
    
    private func drawCorners() {
        var paragraphStype = NSMutableParagraphStyle()
        paragraphStype.alignment = .Center
        
        var textFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        textFont = textFont.fontWithSize(textFont.pointSize * cornerScaleFactor)
        
        var text = self.card!.rank.description() + "\n" + self.card!.suit.description()
        var cornersText = NSAttributedString(string:text, attributes: [
                                                        NSFontAttributeName: textFont,
                                              NSParagraphStyleAttributeName: paragraphStype,
                                             NSForegroundColorAttributeName: self.card!.colorOfSuit()])
        var textBounds = CGRect(origin: CGPointMake(self.cornerOffset, self.cornerOffset), size: cornersText.size())
        
        cornersText.drawInRect(textBounds)
        
        var CR = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM(CR, self.bounds.width, self.bounds.height)
        CGContextRotateCTM(CR, CGFloat.convertFromFloatLiteral(M_PI))
        cornersText.drawInRect(textBounds)
    }
    
    func setUp(){
        self.backgroundColor = UIColor.clearColor()
        self.opaque = false
        self.contentMode = .Redraw
        
        self.addGestureRecognizer(swipeGesture)
    }
    
    override func intrinsicContentSize() -> CGSize {
        return self.frame.size
    }
    
    override func awakeFromNib() {
        setUp()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}