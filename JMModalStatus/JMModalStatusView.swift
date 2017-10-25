//
//  JMModalStatusView.swift
//  JMModalStatus
//
//  Created by Jeff Marlow on 2017-10-25.
//  Copyright © 2017 Joltguy. All rights reserved.
//
//  Based on this tutorial:
//  • https://medium.com/flawless-app-stories/getting-started-with-reusable-frameworks-for-ios-development-f00d74827d11

import UIKit

public class JMModalStatusView: UIView {

	@IBOutlet private weak var statusImage: UIImageView!
	@IBOutlet private weak var headlineLabel: UILabel!
	@IBOutlet private weak var subheadLabel: UILabel!
	
	let nibName = "JMModalStatusView"
	var contentView: UIView!
	var timer: Timer?
	
	override public init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupView()
	}

	private func setupView() {
		let bundle = Bundle(for: type(of: self))
		let nib = UINib(nibName: nibName, bundle: bundle)
		
		self.contentView = nib.instantiate(withOwner: self, options: nil).first as! UIView
		addSubview(contentView)
		
		contentView.center = self.center
		contentView.autoresizingMask = []
		contentView.translatesAutoresizingMaskIntoConstraints = true
		
		headlineLabel.text = ""
		subheadLabel.text = ""
		
		contentView.alpha = 0.0
	}
	
	public override func didMoveToSuperview() {
		UIView.animate(withDuration: 0.25, animations: {
			self.contentView.alpha = 1.0
			self.contentView.transform = CGAffineTransform.identity
		}) { _ in
			// Kick off a timer to automatically remove the view
			self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(3.0), target: self, selector: #selector(self.removeSelf), userInfo: nil, repeats: false)
		}
	}
	
	@objc private func removeSelf() {
		UIView.animate(withDuration: 0.25, animations: {
			self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
			self.contentView.alpha = 0.0
		}) { _ in
			self.removeFromSuperview()
		}
	}
	
	public override func layoutSubviews() {
		// Rounded corners
		self.layoutIfNeeded()
		self.contentView.clipsToBounds = true
		self.contentView.layer.masksToBounds = true
		self.contentView.layer.cornerRadius = 10
	}
	
	public func set(image: UIImage) {
		self.statusImage.image = image
	}
	
	public func set(headline text: String) {
		self.headlineLabel.text = text
	}
	
	public func set(subheadline text: String) {
		self.subheadLabel.text = text
	}
	
}
