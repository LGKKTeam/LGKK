//
//  CountryPhoneHolderView.swift
//  drivethrough
//
//  Created by Nguyen Minh on 4/3/17.
//  Copyright © 2017 SP. All rights reserved.
//

import UIKit
import Reusable
import SwifterSwift

public protocol CountryPhoneHolderDelegate: class {
    func countryPhoneShouldReturn() -> Bool
}

open class CountryPhoneHolderView: SPBaseView, NibOwnerLoadable {
    
    @IBOutlet fileprivate weak var btnFlag: UIButton!
    @IBOutlet fileprivate weak var lblPhoneCode: UILabel!
    @IBOutlet fileprivate weak var tfPhone: UITextField!
    @IBOutlet fileprivate weak var line: UIView!
    @IBOutlet fileprivate weak var lineHeight: NSLayoutConstraint!
    
    open weak var delegate: CountryPhoneHolderDelegate?
    private var hiddenTfChooseCountry: UITextField?
    open var phoneCode: String? = "+1" //US default
    
    open var phone: String? {
        get {
            return tfPhone.text
        }
    }
    
    open var fullPhone: String? {
        get {
            return "\(phoneCode!)\(tfPhone.text!)"
        }
    }
    
    init() {
        let rect = CGRect(x: 0, y: 0, width: 100, height: 30)
        super.init(frame: rect)
        self.loadNibContent()
        setUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadNibContent()
        setUI()
    }
    
    func setUI() {
        //Trick:
        hiddenTfChooseCountry = UITextField()
        addSubview(hiddenTfChooseCountry!)
        
        backgroundColor = .clear
        tfPhone.delegate = self
        tfPhone.placeholder = "Enter mobile number"
        tfPhone.keyboardType = .phonePad
        phoneCode = "+1"
        setFlag(with: "us")
    }
    
    fileprivate func setFlag(with code: String) {
        if let flagSheet = FlagIcons.sharedInstance.spriteSheet {
            let image = flagSheet.getImageFor(code)
            btnFlag.setImage(image, for: .normal)
        }
    }
    
    @IBAction func btnFlag_Tapped(_ sender: Any) {
        endEditing(true)
        let countryPicker = CountryPicker(frame: CGRect(x: 0, y: 0, width: SwifterSwift.screenWidth, height: 260))
        countryPicker.backgroundColor = .white
        countryPicker.countryPhoneCodeDelegate = self
        countryPicker.setCountry(code: "us")
        hiddenTfChooseCountry?.inputView = countryPicker
        hiddenTfChooseCountry?.becomeFirstResponder()
    }
}

//MARK: - Country picker delegate
extension CountryPhoneHolderView: CountryPickerDelegate {
    func countryPhoneCodePicker(picker: CountryPicker, didSelectCountryCountryWithName name: String, countryCode: String, phoneCode: String) {
        
        setFlag(with: countryCode)
        self.phoneCode = phoneCode
        lblPhoneCode.text = phoneCode
    }
}

//MARK: - UITextFieldDelegate
extension CountryPhoneHolderView: UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == tfPhone {
            line.backgroundColor = UIColor.darkGray
            lineHeight.constant = 2.0
            line.updateConstraints()
        }
    }
    
    //Pair becomeFirstResponder & countryPhoneShouldReturn
    override open func becomeFirstResponder() -> Bool {
        return tfPhone.becomeFirstResponder()
    }
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let delegate = delegate, textField == tfPhone {
            return delegate.countryPhoneShouldReturn()
        }
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tfPhone {
            return textField.text!.characters.count + (string.characters.count - range.length) <= 15
        }
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == tfPhone {
            line.backgroundColor = UIColor.lightGray
            lineHeight.constant = (textField.text?.characters.count)! > 0 ? 2.0 : 0.5
            line.updateConstraints()
        }
    }
}
