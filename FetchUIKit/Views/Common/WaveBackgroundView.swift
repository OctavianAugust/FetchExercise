//
//  CurvedBackgroundView.swift
//  UIKitProject
//
//  Created by Roman Myroniuk on 08.09.2024.
//

import UIKit

class WaveBackgroundView: UIView {

    private let waveHeight: CGFloat = 80.0

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawWaveBackground()
    }

    private func drawWaveBackground() {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: bounds.height / 2))
        path.addLine(to: CGPoint(x: 0, y: bounds.height / 2 - waveHeight))
        
        let numberOfWaves = Int(bounds.width / waveHeight)
        for i in 0...numberOfWaves {
            let x = CGFloat(i) * waveHeight
            let y = bounds.height / 2 - waveHeight / 2 + sin(CGFloat(i) * 0.5) * waveHeight
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.height / 2 + waveHeight))
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        path.addLine(to: CGPoint(x: 0, y: bounds.height))
        path.close()
        
        context.addPath(path.cgPath)
        context.clip()
        
        let gradientColors = [UIColor.systemBlue.cgColor, UIColor.systemGreen.cgColor] as CFArray
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorsSpace: colorSpace, colors: gradientColors, locations: nil)!
        
        let startPoint = CGPoint(x: bounds.midX, y: 0)
        let endPoint = CGPoint(x: bounds.midX, y: bounds.height)
        
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
    }
}
