//
//  UILabel+HJLink.swift
//  UILabel+HJExrtension
//
//  Created by coco on 16/9/24.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import Foundation
import UIKit

typealias didSelectLink = (String) -> Void

private var kLinksArray: [String] = [String]()

private var kOperation: didSelectLink = {_ in }

private var kIsTapAction: Bool = false

private var kAttributeStrings : [NSTextCheckingResult] = [NSTextCheckingResult]()

extension UILabel {
    
    
    private var links: [String] {
        get {
            return objc_getAssociatedObject(self, &kLinksArray) as! [String]
        }
        set {
            objc_setAssociatedObject(self, &kLinksArray, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    
    private var operationClosure: didSelectLink {
        get {
            return objc_getAssociatedObject(self, &kOperation) as! didSelectLink
        }
        set {
//            objc_setAssociatedObject(self, &kOperation, newValue as! AnyObject, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
    }
    
    func addLinks(links: [String], tapClick: didSelectLink) {
        self.links = links
        self.operationClosure = tapClick
        
        if let text = self.attributedText?.string {
            for link in self.links {
                if let result = self.selectLink(text, link: link) {
                    for item in result {
                        self.attributeStrings.append(item)
                    }
                }
            }
        }
    }
    
    private var attributeStrings : [NSTextCheckingResult] {
        get {
            return objc_getAssociatedObject(self, &kAttributeStrings) as! [NSTextCheckingResult]
        }
        set {
            objc_setAssociatedObject(self, &kAttributeStrings, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var isTapAction: Bool {
        get {
            return objc_getAssociatedObject(self, &kIsTapAction) as! Bool
        }
        set {
            objc_setAssociatedObject(self, &kIsTapAction, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
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

    
    //MAKR: hitTest
    
    public override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
       return self
    }
    
    //MARK: touch
    
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if !self.isTapAction {
            super.touchesBegan(touches, withEvent: event)
        }
        
        let touch = touches.first
        if let point = touch?.locationInView(self) {
            self.getLinkWith(point, operation: { (string) in
                self.operationClosure(string)
            })
        } else {
            super.touchesBegan(touches, withEvent: event)
        }
    }
    
    
    private func getLinkWith(point: CGPoint, operation: didSelectLink) -> Bool{
        var success = false
        let framesetter = CTFramesetterCreateWithAttributedString(self.attributedText!)
        
        var Path = CGPathCreateMutable()
        
        CGPathAddRect(Path, nil, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height))
        
        var frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, nil);
        
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
            
            Path = CGPathCreateMutable();
            
            CGPathAddRect(Path, nil, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height + font!.lineHeight));
            
            frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, nil);
        }
        
        let lines = CTFrameGetLines(frame);
        
        let count = CFArrayGetCount(lines);
        
        if count == 0 {
            return success
        }
        
        var origins: [CGPoint] = [CGPoint](count: numberOfLines, repeatedValue: CGPointZero)
        
        CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), &origins);
        
        
        let verticalOffset: CGFloat = 0.0
        
        let transform = self.transformForCoreText()
        
        for i in 0..<count {
            let linePoint = origins[i]
            let line = unsafeBitCast(CFArrayGetValueAtIndex(lines, i), CTLine.self)
            
            let flippedRect = self.getLineBounds(line, point: linePoint)
            
            var rect = CGRectApplyAffineTransform(flippedRect, transform);
            
            rect = CGRectInset(rect, 0, 0);
            
            rect = CGRectOffset(rect, 0, verticalOffset);
            
            var lineSpace: CGFloat = 0
            
            if let style = self.attributedText?.attribute(NSParagraphStyleAttributeName, atIndex: 0, effectiveRange: nil) {
                lineSpace = style.lineSpacing
            }
            
            let lineOutSpace = (self.bounds.size.height - lineSpace * CGFloat(count - 1) - rect.size.height * CGFloat(count)) / 2
            
            rect.origin.y = lineOutSpace + rect.size.height * CGFloat(i) + lineSpace * CGFloat(i)
            
            if CGRectContainsPoint(rect, linePoint) {
                let relativePoint = CGPointMake(point.x - CGRectGetMinX(rect), point.y - CGRectGetMinY(rect));
                
                var index = CTLineGetStringIndexForPosition(line, relativePoint);
                
                var offset: CGFloat = 0
                
                CTLineGetOffsetForStringIndex(line, index, &offset);
              
                if (offset > relativePoint.x) {
                    index = index - 1;
                }
                
                let link_count = self.attributeStrings.count;
                
                for j in 0..<link_count {
                    let result = self.attributeStrings[j]
                    if NSLocationInRange(index, result.range) {
                        self.operationClosure(result.regularExpression?.pattern ?? "")
                        success = true
                    }
                }
            }
        }
        return success
    }
    
    private func getLineBounds(line: CTLine, point: CGPoint) -> CGRect {
        var ascent: CGFloat = 0.0
        var descent: CGFloat = 0.0
        var leading: CGFloat = 0.0
        let width = CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
        let height = ascent + fabs(descent) + leading;
        return CGRectMake(point.x, point.y , CGFloat(width), height);
        
    }
    private func transformForCoreText() -> CGAffineTransform {
        return CGAffineTransformScale(CGAffineTransformMakeTranslation(0, self.bounds.size.height), 1, -1);
    }
    
}
