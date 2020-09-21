//
//  BuzzTextField.swift
//  TheUltimateBuzz
//
//  Created by Sagar C on 29/07/20.
//  Copyright © 2020 Ticron. All rights reserved.
//

import UIKit
typealias CompletionHandler = (_ completed: Bool) -> Void

@objc protocol BUZZTextFieldDelegate: class {
    @objc optional
    func buzzTextFieldShouldBeginEditing(_ textField: BuzzTextField) -> Bool
    @objc optional
    func buzzTextFieldDidBeginEditing(_ textField: BuzzTextField)
    @objc optional
    func buzzTextFieldShouldReturn(_ textField: BuzzTextField) -> Bool
    @objc optional
    func buzzTextFieldDidEndEditing(_ textField: BuzzTextField)
    @objc optional
    func buzzTextFieldShouldEndEditing(_ textField: BuzzTextField) -> Bool
    @objc optional
    func buzzTextField(_ textField: BuzzTextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    @objc optional
    func rightButtonClickAction(_ textField: BuzzTextField)
}

class BuzzTextField: UIView {
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var textFieldCustom: UITextField!
    @IBOutlet weak var floatLabel: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var textFieldTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var textFieldBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var textFieldLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var textFieldRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var outerLabel: UILabel!
    @IBOutlet weak var viewTextField: UIView!
    var delegate: BUZZTextFieldDelegate?
    
    @IBInspectable open var hideRightButton: Bool = true
    @IBInspectable open var hideOuterLabel : Bool = true
    @IBInspectable open var hideText : Bool = true
    
    
    var errorColor = UIColor.red
    var floatLabelTextColor = UIColor.darkGray
    var placeholderText = ""
    let animationDuration = 0.3
    var textFieldBorderWidth : CGFloat = 2.0
    var textFieldCornerRadius : CGFloat = 4.0
    
    
    
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
        let nib = UINib(nibName: "BuzzTextField", bundle: Bundle.main)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        textFieldCustom.delegate = self
        addSubview(contentView)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initializeTextFieldView()
    }
    
    func initializeTextFieldView ()
    {
        viewTextField.layer.cornerRadius = 4.0
        outerLabel.isHidden = true
        textFieldCustom.autocorrectionType = UITextAutocorrectionType.no
        textFieldCustom.autocapitalizationType = .none
        floatLabel.text = placeholderText
        textFieldCustom.attributedPlaceholder = NSAttributedString(string:placeholderText,
        attributes: [NSAttributedString.Key.foregroundColor: floatLabelTextColor])
        textFieldTopConstraint.constant = 18
        textFieldBottomConstraint.constant = 18
        floatLabel.layoutIfNeeded()
        
    }
    
   
    func setText (inputText: String, animated: Bool = true) {
        textFieldCustom.text = inputText
        animatePlaceholderLabel(isEditing: !inputText.isEmpty, animated: animated)
    }
    
    func setText (inputText: String, placeholderText: String, animated: Bool = true) {
        textFieldCustom.attributedPlaceholder = NSAttributedString(string:placeholderText,
        attributes: [NSAttributedString.Key.foregroundColor: floatLabelTextColor])
        self.placeholderText = placeholderText
        setText(inputText: inputText, animated: animated)
    }
    
    func showFloatLabel(animated: Bool, completionBlock: CompletionHandler? = nil)
    {
        floatLabel.text = self.placeholderText
        textFieldCustom.attributedPlaceholder = NSAttributedString(string:"",
        attributes: [NSAttributedString.Key.foregroundColor: floatLabelTextColor])
        if animated
        {
            UIView.animate(withDuration: animationDuration, delay: (animationDuration / 2), options: UIView.AnimationOptions.curveEaseOut, animations: { [weak self] in
                
                self?.textFieldTopConstraint.constant = 28
                self?.textFieldBottomConstraint.constant = 8
                self?.layoutIfNeeded()
            }) { (success) in
                if let completion = completionBlock {
                    completion(success)
                }
            }
        }
        else
        {
            textFieldTopConstraint.constant = 28
            textFieldBottomConstraint.constant = 8
            layoutIfNeeded()
            if let completion = completionBlock {
                completion(true)
            }
        }
    }
    
    func hideFloatLabel(animated: Bool, completionBlock: CompletionHandler? = nil)
    {
        floatLabel.text = ""
        textFieldCustom.attributedPlaceholder = NSAttributedString(string:placeholderText,
        attributes: [NSAttributedString.Key.foregroundColor: floatLabelTextColor])
        if animated
        {
            UIView.animate(withDuration: animationDuration, delay: (animationDuration / 2), options: UIView.AnimationOptions.curveEaseOut, animations: { [weak self] in
             
                self?.textFieldTopConstraint.constant = 18
                self?.textFieldBottomConstraint.constant = 18
                self?.layoutIfNeeded()
            }) { (success) in
                if let completion = completionBlock {
                    completion(success)
                }
            }
        }
        else
        {
            textFieldTopConstraint.constant = 18
            textFieldBottomConstraint.constant = 18
            layoutIfNeeded()
            if let completion = completionBlock {
                completion(true)
            }
        }
    }
    
    func animatePlaceholderLabel(isEditing: Bool, animated: Bool = true)
    {
        if isEditing {
            showFloatLabel(animated: animated)
        } else {
            hideFloatLabel(animated: animated)
        }
    }
    
    func setValue(text : String) {
        textFieldCustom.text = text
    }
    
    func value() -> String {
        return textFieldCustom.text ?? ""
    }
    
    func isEmpty() -> Bool {
        return value().isEmpty
    }
    
    func setKeyboardType(type: UIKeyboardType){
        return textFieldCustom.keyboardType = type
    }
    
    func setKeyboardReturnText(type: UIReturnKeyType){
        return textFieldCustom.returnKeyType = type
    }
    
    func resignKeyboard() {
        let _ = textFieldCustom.resignFirstResponder()
    }
    
    override func becomeFirstResponder() -> Bool {
        return textFieldCustom.becomeFirstResponder()
    }
    
    func addRightButton(imageName: String) {
        
        rightButton.setBackgroundImage(UIImage(named: imageName), for: .normal)
        rightButton.isHidden = hideRightButton
        if !hideRightButton {
            rightButton.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
        }
    }
    
    func addOuterLabel(text : String) {
        outerLabel.text = text
        outerLabel.isHidden = hideOuterLabel
    }
    
    @objc func rightButtonAction() {
        if delegate?.rightButtonClickAction != nil {
            delegate?.rightButtonClickAction!(self)
        }
    }
    
    func addErrorBorder (shouldAdd : Bool)
    {
        if shouldAdd {
        viewTextField.layer.borderColor = errorColor.cgColor
        viewTextField.layer.borderWidth = 2.0
        }
        else {
            viewTextField.layer.borderColor = UIColor.clear.cgColor
            viewTextField.layer.borderWidth = 0
        }
    }
    
    func secureText (isSecure : Bool) {
        if isSecure {
            textFieldCustom.isSecureTextEntry = true
            hideText = false
        }
        else {
            textFieldCustom.isSecureTextEntry = false
            hideText = true
        }
    }
    
    func showErrorOnTextField(showError : Bool,hideRightButton : Bool, withMessage : String, rightImageName : String)
    {
        self.addErrorBorder(shouldAdd: showError)
        self.hideRightButton = hideRightButton
        self.hideOuterLabel = !showError
        self.addOuterLabel(text: withMessage)
        self.addRightButton(imageName: rightImageName)
    }
}

extension BuzzTextField: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        var value = true
        if delegate?.buzzTextFieldShouldBeginEditing != nil {
            value = (delegate?.buzzTextFieldShouldBeginEditing!(self))!
        }
        if value {
            animatePlaceholderLabel(isEditing: true)
        }
        
        return value
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if delegate?.buzzTextFieldDidBeginEditing != nil {
            delegate?.buzzTextFieldDidBeginEditing!(self)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignKeyboard()
        var value = true
        if delegate?.buzzTextFieldShouldReturn != nil {
            value = (delegate?.buzzTextFieldShouldReturn!(self))!
        }
        return value
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.text?.isEmpty)! {
            animatePlaceholderLabel(isEditing: false)
        }
        
        if delegate?.buzzTextFieldDidEndEditing != nil {
            delegate?.buzzTextFieldDidEndEditing!(self)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var value = true
        if delegate?.buzzTextField != nil {
            value = (delegate?.buzzTextField!(self, shouldChangeCharactersIn: range, replacementString: string))!
        }
        return value
    }
}
