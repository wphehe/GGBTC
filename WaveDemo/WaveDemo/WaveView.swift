//
//  WaveView.swift
//  WaveDemo
//
//  Created by wangpeng on 2020/4/1.
//  Copyright © 2020 wangpeng. All rights reserved.
//

import UIKit

class WaveView: UIView {
    private var offset: Int = 0
    private var speed: CGFloat = 3.5
    private var displayLink: CADisplayLink?
    private lazy var bgView: UIView = {
        let view = UIView.init(frame: self.bounds)
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = view.bounds.width/2
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var waveLayer: CAShapeLayer = {
        let layer = CAShapeLayer.init()
        layer.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.width)
        return layer
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel.init()
        label.text = "RD"
        label.font = UIFont.init(name:"HelveticaNeue-Bold", size: 70)
        label.textColor =  kRGBA(r: 29, g: 22, b: 233, a: 1)
        label.sizeToFit()
        return label
    }()
    
    private lazy var upLabel: UILabel = {
        let label = UILabel.init()
        label.text = "RD"
        label.font = UIFont.init(name:"HelveticaNeue-Bold", size: 70)
        label.textColor = UIColor.white
        label.sizeToFit()
        return label
    }()
    
    private lazy var shapeLayer: CAShapeLayer = {
        let maskLayer = CAShapeLayer.init()
        maskLayer.bounds = self.bgView.bounds
        maskLayer.position = CGPoint.init(x: self.label.bounds.width * 0.5, y: self.label.bounds.height * 0.5)
        
        return maskLayer
    }()
    // MARK: - 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func startDisplayLink() {
        self.displayLink = CADisplayLink.init(target: self, selector: #selector(waveAction))
        self.displayLink?.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
    }
   private func updateWave(with width: CGFloat, height: CGFloat) {
        
        let degree: CGFloat = CGFloat.pi/80
        let wavePath = CGMutablePath()
        wavePath.move(to: CGPoint.init(x: 0, y: height))
        var offsetX: CGFloat = 0
        while offsetX < width {
            let offsetY = height * 0.5 + 15 * sin(offsetX * degree + CGFloat(self.offset) * degree * self.speed)
            wavePath.addLine(to: CGPoint.init(x: offsetX, y: offsetY))
            offsetX += 1.0
        }
        wavePath.addLine(to: CGPoint.init(x: width, y: height))
        wavePath.addLine(to: CGPoint.init(x: 0, y: height))
        wavePath.closeSubpath()
        self.waveLayer.path = wavePath
        waveLayer.fillColor = kRGBA(r: 29, g: 22, b: 233, a: 1).cgColor
        self.shapeLayer.path = wavePath
    }
    //MARK:- action
    @objc private func waveAction() {
        self.offset += 1
        let width: CGFloat = self.frame.width
        let height: CGFloat = self.frame.height
        self.updateWave(with: width, height: height)
    }
    func kRGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    func stopDisplayLink() {
        if self.displayLink != nil {
            self.displayLink?.invalidate()
            self.displayLink = nil
        }
    }
}
// MARK: - 设置界面
extension WaveView {
    func setupUI() {
        self.addSubview(self.bgView)
        self.bgView.addSubview(self.label)
        self.bgView.addSubview(self.upLabel)
        self.label.center = CGPoint.init(x: self.bgView.frame.width * 0.5, y: self.bgView.frame.height * 0.5)
        self.upLabel.center = self.label.center
        self.bgView.layer.insertSublayer(self.waveLayer, below: self.label.layer)
        self.upLabel.layer.mask = self.shapeLayer
    }
}
