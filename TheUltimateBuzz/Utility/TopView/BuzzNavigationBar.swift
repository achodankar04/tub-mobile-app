//
//  BuzzNavigationBar.swift
//  CDHApplication
//
//  Created by Sagar C on 16/06/20.
//  Copyright © 2020 BNT SOFT. All rights reserved.
//

import UIKit

@objc protocol BuzzNavigationBarDelegate: class {
    @objc optional
    func rightButtonClickAction()
}

class BuzzNavigationBar: UIView {

    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet var leftImgView: UIImageView!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var contentViewBottom: NSLayoutConstraint!
    
    var buzzNavigationDelegate : BuzzNavigationBarDelegate?
    
    var hasTopNotch: Bool {
        if #available(iOS 13.0,  *) {
            return UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0 > 20
        }else{
         return appDelegate().window?.safeAreaInsets.top ?? 0 > 20
        }
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
          
    required init?(coder aCoder: NSCoder)
    {
        super.init(coder: aCoder)
        initSubviews()
    }
       
    func initSubviews()
    {
        let nib = UINib(nibName: "BuzzNavigationBar", bundle: Bundle.main)
        nib.instantiate(withOwner: self, options: nil)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.mainView.frame = bounds
        self.mainView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(self.mainView)
    }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        initializeNavigationBar()
    }
    func initializeNavigationBar()
    {
        self.mainView.backgroundColor = UIColor(red: 246.0/255.0, green: 178.0/255.0, blue: 42.0/255.0, alpha: 1.0)
        self.titleLable.textColor = UIColor.black
        self.titleLable.text = ""
        self.rightButton.isHidden = false
        addRightButton(shouldHide: false, imageName: "user")
        setBottomForContent()
    }
    
    func setBottomForContent (){
        if hasTopNotch {
            self.contentViewBottom.constant = 15
        }
        else {
            self.contentViewBottom.constant = 15
        }
    }
    
    func setTitleText(titleText: String){
        self.titleLable.text = titleText
    }
    
    func getTitleText()-> String {
        guard let titleText = self.titleLable.text else {
            return ""
        }
        return titleText
    }
    func addRightButton(shouldHide : Bool, imageName : String){
        self.rightButton.isHidden = shouldHide
        if !shouldHide {
            self.rightButton.setImage(UIImage(named: imageName), for: .normal)
            self.rightButton.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
        }
    }
    
    @objc func rightButtonAction() {
       ButtonUtility.shared.RightButtonClickAction()
    }
}
