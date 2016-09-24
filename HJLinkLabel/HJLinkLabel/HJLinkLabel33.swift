////
////  HJLinkLabel.swift
////  HJLinkLabel
////
////  Created by coco on 16/9/23.
////  Copyright © 2016年 XHJ. All rights reserved.
////
//
//import UIKit
//
//class HJLinkLabel: UILabel {
//    typealias didClickText = (String) -> Void
//    
//    /**链接数组*/
//    private var linksArray: [String] = [String]()
//    
//    //链接数组 保存NSTextCheckingResult
//    private var linkChecksArray = [NSTextCheckingResult]()
//    
//    //当前点击的链接
//    private var activityLink : NSTextCheckingResult?
//    
//    //链接颜色
//    var linkColor: UIColor = UIColor.orangeColor()
//    /**操作block*/
//    private var operation: [String : didClickText] = [String : didClickText]()
//    
//    /**
//     添加链接文字和操作
//     
//     - parameter link:      链接文字
//     - parameter linkBlock: 链接操作
//     */
//    func addLink(link: String, linkBlock: didClickText) -> Void {
//        if !self.linksArray.contains(link) {
//            self.linksArray.append(link)
//            self.operation[link] = linkBlock
//        }
//        self.updateText()
//    }
//    
//    /**
//     更新显示文字
//     */
//    private func updateText() {
//        if let value = text {
//            let att = NSMutableAttributedString(string: value, attributes: [NSFontAttributeName: self.font, NSForegroundColorAttributeName : self.textColor])
//            self.linkChecksArray.removeAll()
//            for link in linksArray {
//                if let result = self.selectLink(value, link: link) {
//                    for textCheckResult in result {
//                        att.replaceCharactersInRange(textCheckResult.range, withAttributedString: NSAttributedString(string: link, attributes: [NSForegroundColorAttributeName: self.linkColor]))
//                    }
//                    self.linkChecksArray.appendContentsOf(result)
//                }
//            }
//            self.attributedText = att
//        }
//    }
//    
//    
//    func removeLink(link: String) -> Void {
//        if self.linksArray.contains(link) {
//            self.linksArray.removeAtIndex(self.linksArray.indexOf(link)!)
//        }
//    }
//    
//    func removeAllLinks() -> Void {
//        self.linksArray.removeAll()
//    }
//    
//    //MAKR: 初始化方法
//    convenience init() {
//        self.init(frame: CGRectZero)
//    }
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.userInteractionEnabled = true
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    /**
//     获取链接文字在 文本中的位置
//     
//     - parameter text:    文本
//     - parameter link: 链接文字
//     
//     - returns:
//     */
//    private func selectLink(text: String, link: String) -> ([NSTextCheckingResult]?) {
//        do {
//            let regex = try NSRegularExpression(pattern: link, options: NSRegularExpressionOptions.CaseInsensitive)
//            let result = regex.matchesInString(text, options: NSMatchingOptions.ReportCompletion, range: NSMakeRange(0, text.characters.count))
//            return result
//        } catch {
//            return nil
//        }
//    }
//    
//    //MARK: touch
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        let touch = touches.first
//        if let point = touch?.locationInView(self) {
//            self.activityLink = self.linkAtPoint(point)
//        } else {
//            self.activityLink = nil
//        }
//        if self.activityLink == nil {
//            super.touchesBegan(touches, withEvent: event)
//        }
//    }
//    
//    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        if self.activityLink == nil {
//            super.touchesBegan(touches, withEvent: event)
//        } else {
//            if let point = touches.first?.locationInView(self) {
//                if self.activityLink != self.linkAtPoint(point) {
//                    self.activityLink = nil
//                }
//            } else {
//                self.activityLink = nil
//            }
//        }
//    }
//    
//    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        if let result = self.activityLink {
//            self.activityLink = nil
//            switch result.resultType {
//            case NSTextCheckingType.RegularExpression:
//                if let operation = self.operation[result.regularExpression!.pattern] {
//                    operation(result.regularExpression!.pattern)
//                }
//            default:
//                break
//            }
//        } else {
//            super.touchesEnded(touches, withEvent: event)
//        }
//    }
//    
//    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
//        self.activityLink = nil
//        super.touchesCancelled(touches, withEvent: event)
//    }
//    
//    //MARK: 获取到连接点
//    private func linkAtPoint(point: CGPoint) -> NSTextCheckingResult? {
//        let idx = self.characterIndexAtPoint(point)
//        return linkAtCharacterIndex(idx)
//    }
//    
//    private func linkAtCharacterIndex(idx: CFIndex) -> NSTextCheckingResult? {
//        for item in self.linkChecksArray {
//            if NSLocationInRange(idx, item.range) {
//                return item
//            }
//        }
//        return nil
//    }
//    
//    private func characterIndexAtPoint(point: CGPoint) -> CFIndex {
//        var p = point
//        if !CGRectContainsPoint(self.bounds, p) {
//            return NSNotFound
//        }
//        
//        let textRect = self.textRectForBounds(self.bounds, limitedToNumberOfLines: self.numberOfLines)
//        if !CGRectContainsPoint(textRect, p) {
//            return NSNotFound
//        }
//        
//        p = CGPointMake(p.x - textRect.origin.x, p.y - textRect.origin.y)
//        // Convert tap coordinates (start at top left) to CT coordinates (start at bottom left)
//        p = CGPointMake(p.x, textRect.size.height - p.y)
//        
//        let path = CGPathCreateMutable()
//        CGPathAddRect(path, nil, textRect)
//        
//        let framesetter = CTFramesetterCreateWithAttributedString(self.attributedText!)
//        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, CFIndex(self.attributedText!.length)), path, nil)
//        
//        let lines = CTFrameGetLines(frame)
//        let numberOfLines = self.numberOfLines > 0 ? min(self.numberOfLines, CFArrayGetCount(lines)) : CFArrayGetCount(lines)
//        if numberOfLines == 0 {
//            return NSNotFound
//        }
//        
//        var idx = NSNotFound
//        var lineOrigins: [CGPoint] = [CGPoint](count: numberOfLines, repeatedValue: CGPointZero)
//        CTFrameGetLineOrigins(frame, CFRangeMake(0, numberOfLines), &lineOrigins)
//        
//        if lineOrigins.count == 0 {
//            return NSNotFound
//        }
//        
//        let flushFactor = HJFlushFactorForTextAlignment(self.textAlignment)
//        
//        for lineIndex in 0..<numberOfLines {
//            var lineOrigin = lineOrigins[lineIndex]
//            let line = unsafeBitCast(CFArrayGetValueAtIndex(lines, lineIndex), CTLine.self)
//            
//            
//            // Get bounding information of line
//            var ascent: CGFloat = 0.0, descent: CGFloat = 0.0, leading: CGFloat = 0.0
//            let width = CGFloat(CTLineGetTypographicBounds(line, &ascent, &descent, &leading))
//            let yMin: CGFloat = floor(lineOrigin.y - descent)
//            let yMax: CGFloat = ceil(lineOrigin.y + ascent)
//            
//            // Apply penOffset using flushFactor for horizontal alignment to set lineOrigin since this is the horizontal offset from drawFramesetter
//            let penOffset = CGFloat(CTLineGetPenOffsetForFlush(line, flushFactor, Double(textRect.size.width)))
//            lineOrigin.x = penOffset
//            
//            if p.y > yMax {
//                break
//            }
//            
//            if (p.y >= yMin) {
//                // Check if the point is within this line horizontally
//                if (p.x >= penOffset && p.x <= penOffset + width) {
//                    // Convert CT coordinates to line-relative coordinates
//                    let relativePoint = CGPointMake(p.x - penOffset, p.y - lineOrigin.y);
//                    idx = CTLineGetStringIndexForPosition(line, relativePoint) - 1;
//                    break;
//                }
//            }
//        }
//        return idx
//    }
//    
//    func HJFlushFactorForTextAlignment(textAlignment: NSTextAlignment) -> CGFloat{
//        switch (textAlignment) {
//        case .Center:
//            return 0.5
//        case .Right:
//            return 1.0
//        case .Left:
//            fallthrough
//        default:
//            return 0.0
//        }
//    }
//    
//}
