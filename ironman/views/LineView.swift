//
//  LineView.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/10/21.
//

import UIKit

enum LineType {
    case PLAIN
    case DASH
}

class LineView: UIView {
    
    public struct Configuration {
        public var color: UIColor
        public var dashLength: CGFloat
        public var dashGap: CGFloat
        public var lineType: LineType
        
        public init(
            color: UIColor,
            dashLength: CGFloat,
            dashGap: CGFloat,
            lineType: LineType) {
            self.color = color
            self.dashLength = dashLength
            self.dashGap = dashGap
            self.lineType = lineType
        }
        
        static let `default`: Self = .init(
            color: .lightGray,
            dashLength: 7,
            dashGap: 3,
            lineType: .DASH)
    }
    
    // MARK: - Properties
    
    /// Override to customize height
    public class var lineHeight: CGFloat { 1.0 }
    
    override public var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: Self.lineHeight)
    }
    
    public final var config: Configuration = .default {
        didSet {
            drawLine()
        }
    }
    
    private var dashedLayer: CAShapeLayer?
    
    // MARK: - Life Cycle
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        // We only redraw the dashes if the width has changed.
        guard bounds.width != dashedLayer?.frame.width else { return }
        
        drawLine()
    }
    
    // MARK: - Drawing
    
    private func drawLine() {
        if dashedLayer != nil {
            dashedLayer?.removeFromSuperlayer()
        }
        
        if config.lineType == .DASH {
            dashedLayer = drawDashLine(
                start: bounds.origin,
                end: CGPoint(x: bounds.width, y: bounds.origin.y),
                config: config)
        } else {
            dashedLayer = drawPlainLine(
                start: bounds.origin,
                end: CGPoint(x: bounds.width, y: bounds.origin.y),
                config: config)
        }

    }
    
}

private extension LineView {
    func drawDashLine(
        start: CGPoint,
        end: CGPoint,
        config: Configuration) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = config.color.cgColor
        shapeLayer.lineWidth = Self.lineHeight
        shapeLayer.lineDashPattern = [config.dashLength as NSNumber, config.dashGap as NSNumber]
        
        let path = CGMutablePath()
        path.addLines(between: [start, end])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
        
        return shapeLayer
    }
    
    func drawPlainLine(
        start: CGPoint,
        end: CGPoint,
        config: Configuration) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = config.color.cgColor
        shapeLayer.lineWidth = Self.lineHeight
        
        let path = CGMutablePath()
        path.addLines(between: [start, end])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
        
        return shapeLayer
    }
    
}
