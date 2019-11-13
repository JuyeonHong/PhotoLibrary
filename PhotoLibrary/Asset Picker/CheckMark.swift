//
//  CheckMark.swift
//  PhotoLibrary
//
//  Created by hongjuyeon_dev on 2019/11/11.
//  Copyright © 2019 hongjuyeon_dev. All rights reserved.
//

import UIKit
import CoreGraphics

class CheckMark: UIView{
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawRectChecked()
    }
    
    func drawRectChecked() {
        // General Declaration
        let context = UIGraphicsGetCurrentContext()
        
        // Color Declaration
        let checkMarkBlue = UIColor(red: 0.078, green: 0.435, blue: 0.875, alpha: 1.0)
        
        // Frames
        let frame = bounds
        
        // Subframes
        let group = CGRect(x: frame.minX + 3, y: frame.minY + 3, width: frame.width - 6, height: frame.height - 6)
        
        // CheckedOval Drawing (blue circle)
        let checkedOvalPath = UIBezierPath(ovalIn:CGRect(x: group.minX + 0.5, y: group.minY + 0.5, width: group.width + 1, height: group.height + 1))
        context?.saveGState()
        context?.setShadow(offset: CGSize(width: 0.1, height: -0.1), blur: CGFloat(2.5), color: UIColor.black.cgColor)
        checkMarkBlue.setFill()
        checkedOvalPath.fill()
        context?.restoreGState()
        
        // white oval circle line drawing
        UIColor.white.setStroke()
        checkedOvalPath.lineWidth = 1
        checkedOvalPath.stroke()
        
        // Beizer drawing (check mark)
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: group.minX + 0.27083 * group.width, y: group.minY + 0.54167 * group.height)) // 초기 세그먼트 시작점 설정
        bezierPath.addLine(to: CGPoint(x: group.minX + 0.41667 * group.width, y: group.minY + 0.68750 * group.height)) // 선을 추가해서 subpath 정의
        bezierPath.addLine(to: CGPoint(x: group.minX + 0.75000 * group.width, y: group.minY + 0.35417 * group.height))
        bezierPath.lineCapStyle = .square
        
        UIColor.white.setStroke()
        bezierPath.lineWidth = 1.3
        bezierPath.stroke()
    }
}
