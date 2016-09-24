////
////  HJLinkLabel1111.swift
////  HJLinkLabel
////
////  Created by coco on 16/9/24.
////  Copyright © 2016年 XHJ. All rights reserved.
////
//
//import UIKit
//
//typealias didClickText = (String) -> Void
//
//class HJLinkLabel1111: UILabel {
//    /**链接样式*/
//    var defaultLinkAttribute: [String : AnyObject]?
//    
//    //当前点击的链接
//    private var activityLink : NSTextCheckingResult?
//    
//    private var links: [NSTextCheckingResult] = [NSTextCheckingResult]()
//    
//    /**所有添加的link数组*/
//    private var linksArray: [HJLink] = [HJLink]()
//    
//    func addLinkString(link: String, operation: didClickText) {
//        self.addLinkString(link, attribute: self.defaultLinkAttribute, operation: operation)
//    }
//    
//    func addLinkString(link: String, attribute: [String: AnyObject]?, operation: didClickText) {
//        var isContain = false
//        for item in self.linksArray {
//            if item.link == link {
//                item.attribute = attribute
//                item.operation = operation
//                isContain = true
//                break
//            }
//        }
//        
//        if isContain == false {
//            let link = HJLink(link: link, attribute: attribute, operation: operation)
//            self.linksArray.append(link)
//        }
//        updateText()
//    }
//    
//    private func updateText() {
//        if let value = self.attributedText {
//            let mutableString = NSMutableAttributedString(attributedString: value)
//            self.links.removeAll()
//            for item in linksArray {
//                if let result = self.selectLink(mutableString.string, link: item.link) {
//                    for textCheckResult in result {
//                        mutableString.replaceCharactersInRange(textCheckResult.range, withAttributedString: NSAttributedString(string: item.link, attributes: item.attribute))
//                    }
//                    self.links.appendContentsOf(result)
//                }
//            }
//            self.attributedText = mutableString
//        }
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
//    
//    //MARK: 初始化方法
//    
//    convenience init() {
//        self.init(frame: CGRectZero)
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.userInteractionEnabled = true
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//extension HJLinkLabel1111 {
//    //MARK: hitTest
////    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
////        if self.linkAtPoint(point) == nil || !self.userInteractionEnabled || self.hidden || self.alpha < 0.01 {
////            return super.hitTest(point, withEvent: event)
////        }
////        return self
////    }
//    
//    //MARK: touch
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        let touch = touches.first
//        if let point = touch?.locationInView(self) {
//            self.activityLink = self.linkAtPoint(point)
//            print(self.activityLink)
//        } else {
//            self.activityLink = nil
//        }
//        if self.activityLink == nil {
//            super.touchesBegan(touches, withEvent: event)
//        }
//    }
//    
////    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
////        if self.activityLink == nil {
////            super.touchesBegan(touches, withEvent: event)
////        } else {
////            if let point = touches.first?.locationInView(self) {
////                if self.activityLink != self.linkAtPoint(point) {
////                    self.activityLink = nil
////                }
////            } else {
////                self.activityLink = nil
////            }
////        }
////    }
//    
//    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        if let result = self.activityLink {
//            self.activityLink = nil
//            switch result.resultType {
//            case NSTextCheckingType.RegularExpression:
//                if let pattern = result.regularExpression?.pattern {
//                    for item in self.linksArray {
//                        if item.link == pattern {
//                            item.operation(item.link)
//                        }
//                    }
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
//        for item in self.links {
//            print(item.range, idx)
//            if NSLocationInRange(idx, item.range) {
//                return item
//            }
//        }
//        return nil
//    }
//    
//    private func characterIndexAtPoint(point: CGPoint) -> CFIndex {
//
//        if !CGRectContainsPoint(self.bounds, point) {
//            return NSNotFound
//        }
//        
//        let textRect = self.textRectForBounds(self.bounds, limitedToNumberOfLines: self.numberOfLines)
//        if !CGRectContainsPoint(textRect, point) {
//            return NSNotFound
//        }
//
//        
//        let framesetter = CTFramesetterCreateWithAttributedString(self.attributedText!)
//        
//        var Path = CGPathCreateMutable()
//        
//        CGPathAddRect(Path, nil, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height))
//        
//        var frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, nil);
//        
//        let range = CTFrameGetVisibleStringRange(frame)
//        
//        if self.attributedText?.length < range.length {
//            
//            var font: UIFont?
//            
//            if self.attributedText?.attribute(NSFontAttributeName, atIndex: 0, effectiveRange: nil) != nil {
//                
//                font = self.attributedText?.attribute(NSFontAttributeName, atIndex: 0, effectiveRange: nil) as? UIFont
//                
//            }else if self.font != nil{
//                font = self.font
//                
//            }else {
//                font = UIFont.systemFontOfSize(17)
//            }
//            
//            Path = CGPathCreateMutable();
//            
//            CGPathAddRect(Path, nil, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height + font!.lineHeight));
//            
//            frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, nil);
//        }
//        
//        let lines = CTFrameGetLines(frame);
//        let numberOfLines = self.numberOfLines > 0 ? min(self.numberOfLines, CFArrayGetCount(lines)) : CFArrayGetCount(lines)
//        if numberOfLines == 0 {
//            return NSNotFound
//        }
//        
//        var origins: [CGPoint] = [CGPoint](count: numberOfLines, repeatedValue: CGPointZero)
//        
//        CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), &origins);
//        
//        
//        let verticalOffset: CGFloat = 0.0
//        
//        let transform = self.transformForCoreText()
//        
//        for i in 0..<numberOfLines {
//            let linePoint = origins[i]
//            let line = unsafeBitCast(CFArrayGetValueAtIndex(lines, i), CTLine.self)
//            
//            let flippedRect = self.getLineBounds(line, point: linePoint)
//            
//            var rect = CGRectApplyAffineTransform(flippedRect, transform);
//            
//            rect = CGRectInset(rect, 0, 0);
//            
//            rect = CGRectOffset(rect, 0, verticalOffset);
//            
//            var lineSpace: CGFloat = 0
//            
//            if let style = self.attributedText?.attribute(NSParagraphStyleAttributeName, atIndex: 0, effectiveRange: nil) {
//                lineSpace = style.lineSpacing
//            }
//            
//            let lineOutSpace = (self.bounds.size.height - lineSpace * CGFloat(numberOfLines - 1) - rect.size.height * CGFloat(numberOfLines)) / 2
//            
//            rect.origin.y = lineOutSpace + rect.size.height * CGFloat(i) + lineSpace * CGFloat(i)
//            
//            if CGRectContainsPoint(rect, linePoint) {
//                let relativePoint = CGPointMake(point.x - CGRectGetMinX(rect), point.y - CGRectGetMinY(rect));
//                
//                var index = CTLineGetStringIndexForPosition(line, relativePoint);
//                
//                var offset: CGFloat = 0
//                
//                CTLineGetOffsetForStringIndex(line, index, &offset);
//                
////                if (offset > relativePoint.x) {
//                    index = index - 1;
////                }
//                return index
//            }
//        }
//        return NSNotFound
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
//    private func getLineBounds(line: CTLine, point: CGPoint) -> CGRect {
//        var ascent: CGFloat = 0.0
//        var descent: CGFloat = 0.0
//        var leading: CGFloat = 0.0
//        let width = CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
//        let height = ascent + fabs(descent) + leading;
//        return CGRectMake(point.x, point.y , CGFloat(width), height);
//        
//    }
//    private func transformForCoreText() -> CGAffineTransform {
//        return CGAffineTransformScale(CGAffineTransformMakeTranslation(0, self.bounds.size.height), 1, -1);
//    }
//
//}
//
//
//class HJLink: NSObject {
//    var link: String
//    var attribute: [String : AnyObject]?
//    var operation: didClickText
//    
//    init(link: String, attribute: [String : AnyObject]?, operation: didClickText) {
//        self.link = link
//        self.attribute = attribute
//        self.operation = operation
//        super.init()
//    }
//}
