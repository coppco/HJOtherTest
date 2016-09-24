//
//  HJLinkLabel.swift
//  HJLinkLabel
//
//  Created by coco on 16/9/24.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

typealias didClickText = (String) -> Void

class HJLinkLabel: UILabel {
    /**链接样式*/
    var defaultLinkAttribute: [String : AnyObject]?
    
    //当前点击的链接
    private var activityLink : NSTextCheckingResult?
    
    private var links: [NSTextCheckingResult] = [NSTextCheckingResult]()
    
    /**所有添加的link数组*/
    private var linksArray: [HJLink] = [HJLink]()
    
    func addLinkString(link: String, operation: didClickText) {
        self.addLinkString(link, attribute: self.defaultLinkAttribute, operation: operation)
    }
    
    func addLinkString(link: String, attribute: [String: AnyObject]?, operation: didClickText) {
        var isContain = false
        for item in self.linksArray {
            if item.link == link {
                item.attribute = attribute
                item.operation = operation
                isContain = true
                break
            }
        }
        
        if isContain == false {
            let link = HJLink(link: link, attribute: attribute, operation: operation)
            self.linksArray.append(link)
        }
        updateText()
    }
    
    private func updateText() {
        if let value = self.attributedText {
            let mutableString = NSMutableAttributedString(attributedString: value)
            self.links.removeAll()
            for item in linksArray {
                if let result = self.selectLink(mutableString.string, link: item.link) {
                    for textCheckResult in result {
                        mutableString.replaceCharactersInRange(textCheckResult.range, withAttributedString: NSAttributedString(string: item.link, attributes: item.attribute))
                    }
                    self.links.appendContentsOf(result)
                }
            }
            self.attributedText = mutableString
        }
    }
    
    /**
     获取链接文字在 文本中的位置
     
     - parameter text:    文本
     - parameter link: 链接文字
     
     - returns:
     */
    private func selectLink(text: String, link: String) -> ([NSTextCheckingResult]?) {
        do {
            let regex = try NSRegularExpression(pattern: link, options: NSRegularExpressionOptions.CaseInsensitive)
            let result = regex.matchesInString(text, options: NSMatchingOptions.ReportCompletion, range: NSMakeRange(0, text.characters.count))
            return result
        } catch {
            return nil
        }
    }

    
    //MARK: 初始化方法
    
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HJLinkLabel {
    //MARK: hitTest
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        if self.linkAtPoint(point) == nil || !self.userInteractionEnabled || self.hidden || self.alpha < 0.01 {
            return super.hitTest(point, withEvent: event)
        }
        return self
    }
    
    //MARK: touch
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        if let point = touch?.locationInView(self) {
            self.activityLink = self.linkAtPoint(point)
        } else {
            self.activityLink = nil
        }
        if self.activityLink == nil {
            super.touchesBegan(touches, withEvent: event)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if self.activityLink == nil {
            super.touchesBegan(touches, withEvent: event)
        } else {
            if let point = touches.first?.locationInView(self) {
                if self.activityLink != self.linkAtPoint(point) {
                    self.activityLink = nil
                }
            } else {
                self.activityLink = nil
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let result = self.activityLink {
            self.activityLink = nil
            switch result.resultType {
            case NSTextCheckingType.RegularExpression:
                if let pattern = result.regularExpression?.pattern {
                    for item in self.linksArray {
                        if item.link == pattern {
                            item.operation(item.link)
                        }
                    }
                }
            default:
                break
            }
        } else {
            super.touchesEnded(touches, withEvent: event)
        }
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        self.activityLink = nil
        super.touchesCancelled(touches, withEvent: event)
    }
    
    //MARK: 获取到连接点
    private func linkAtPoint(point: CGPoint) -> NSTextCheckingResult? {
        let idx = self.characterIndexAtPoint(point)
        return linkAtCharacterIndex(idx)
    }
    
    private func linkAtCharacterIndex(idx: CFIndex) -> NSTextCheckingResult? {
        for item in self.links {
            if NSLocationInRange(idx, item.range) {
                return item
            }
        }
        return nil
    }
    
    private func characterIndexAtPoint(point: CGPoint) -> CFIndex {
        var p = point
        if !CGRectContainsPoint(self.bounds, p) {
            return NSNotFound
        }
        
        let textRect = self.textRectForBounds(self.bounds, limitedToNumberOfLines: self.numberOfLines)
        if !CGRectContainsPoint(textRect, p) {
            return NSNotFound
        }
        
        p = CGPointMake(p.x - textRect.origin.x, p.y - textRect.origin.y)
        // Convert tap coordinates (start at top left) to CT coordinates (start at bottom left)
        p = CGPointMake(p.x, textRect.size.height - p.y)
        
        var path = CGPathCreateMutable()
        CGPathAddRect(path, nil, textRect)
        
        let framesetter = CTFramesetterCreateWithAttributedString(self.attributedText!)
        var frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, CFIndex(self.attributedText!.length)), path, nil)
        
        let range = CTFrameGetVisibleStringRange(frame)
        if self.attributedText?.length < range.length {
            
            var font: UIFont?
            
            if self.attributedText?.attribute(NSFontAttributeName, atIndex: 0, effectiveRange: nil) != nil {
                
                font = self.attributedText?.attribute(NSFontAttributeName, atIndex: 0, effectiveRange: nil) as? UIFont
                
            }else if self.font != nil{
                font = self.font
                
            }else {
                font = UIFont.systemFontOfSize(17)
            }
            
            path = CGPathCreateMutable()
            
            CGPathAddRect(path, nil, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height + font!.lineHeight))
            
            frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, nil)
        }
        
        
        let lines = CTFrameGetLines(frame)
        let numberOfLines = self.numberOfLines > 0 ? min(self.numberOfLines, CFArrayGetCount(lines)) : CFArrayGetCount(lines)
        if numberOfLines == 0 {
            return NSNotFound
        }
        
        var idx = NSNotFound
        var lineOrigins: [CGPoint] = [CGPoint](count: numberOfLines, repeatedValue: CGPointZero)
        CTFrameGetLineOrigins(frame, CFRangeMake(0, numberOfLines), &lineOrigins)
        
        if lineOrigins.count == 0 {
            return NSNotFound
        }
        
        let flushFactor = HJFlushFactorForTextAlignment(self.textAlignment)
        
        for lineIndex in 0..<numberOfLines {
            var lineOrigin = lineOrigins[lineIndex]
            let line = unsafeBitCast(CFArrayGetValueAtIndex(lines, lineIndex), CTLine.self)
            
            
            // Get bounding information of line
            var ascent: CGFloat = 0.0, descent: CGFloat = 0.0, leading: CGFloat = 0.0
            let width = CGFloat(CTLineGetTypographicBounds(line, &ascent, &descent, &leading))
            let yMin: CGFloat = floor(lineOrigin.y - descent)
            let yMax: CGFloat = ceil(lineOrigin.y + ascent)
            
            // Apply penOffset using flushFactor for horizontal alignment to set lineOrigin since this is the horizontal offset from drawFramesetter
            let penOffset = CGFloat(CTLineGetPenOffsetForFlush(line, flushFactor, Double(textRect.size.width)))
            lineOrigin.x = penOffset
            
            if p.y > yMax {
                break
            }
            
            if (p.y >= yMin) {
                // Check if the point is within this line horizontally
                if (p.x >= penOffset && p.x <= penOffset + width) {
                    // Convert CT coordinates to line-relative coordinates
                    let relativePoint = CGPointMake(p.x - penOffset, p.y - lineOrigin.y)
                    idx = CTLineGetStringIndexForPosition(line, relativePoint) - 1
                    break
                }
            }
        }
        return idx
    }
    
    func HJFlushFactorForTextAlignment(textAlignment: NSTextAlignment) -> CGFloat{
        switch (textAlignment) {
        case .Center:
            return 0.5
        case .Right:
            return 1.0
        case .Left:
            fallthrough
        default:
            return 0.0
        }
    }
    
    private func getLineBounds(line: CTLine, point: CGPoint) -> CGRect {
        var ascent: CGFloat = 0.0
        var descent: CGFloat = 0.0
        var leading: CGFloat = 0.0
        let width = CTLineGetTypographicBounds(line, &ascent, &descent, &leading)
        let height = ascent + fabs(descent) + leading
        return CGRectMake(point.x, point.y , CGFloat(width), height)
        
    }
    private func transformForCoreText() -> CGAffineTransform {
        return CGAffineTransformScale(CGAffineTransformMakeTranslation(0, self.bounds.size.height), 1, -1)
    }

}


class HJLink: NSObject {
    var link: String
    var attribute: [String : AnyObject]?
    var operation: didClickText
    
    init(link: String, attribute: [String : AnyObject]?, operation: didClickText) {
        self.link = link
        self.attribute = attribute
        self.operation = operation
        super.init()
    }
}
