//
//  CountryPicker.swift
//  drivethrough
//
//  Created by Nguyen Minh on 3/29/17.
//  Copyright © 2017 SP. All rights reserved.
//

import UIKit
import libPhoneNumber_iOS

protocol CountryPickerDelegate: class {
    func countryPhoneCodePicker(picker: CountryPicker,
                                didSelectCountryCountryWithName name: String,
                                countryCode: String,
                                phoneCode: String)
}

public struct Country {
    var code: String?
    var name: String?
    var phoneCode: String?
    
    public init(code: String?, name: String?, phoneCode: String?) {
        self.code = code
        self.name = name
        self.phoneCode = phoneCode
    }
}

open class CountryPicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var countries: [Country]!
    weak var countryPhoneCodeDelegate: CountryPickerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setup() {
        super.dataSource = self
        
        super.delegate = self
        
        countries = countryNamesByCode()
    }
    
    // MARK: - Country Methods
    
    open func setCountry(code: String) {
        var row = 0
        for index in 0..<countries.count {
            if countries[index].code?.uppercased() == code.uppercased() {
                row = index
                break
            }
        }
        
        self.selectRow(row, inComponent: 0, animated: true)
    }
    
    fileprivate func countryNamesByCode() -> [Country] {
        var countries = [Country]()
        
        for code in NSLocale.isoCountryCodes {
            if let countryName = (Locale.current as NSLocale).displayName(forKey: .countryCode, value: code) {
                let phoneNumberUtil = NBPhoneNumberUtil.sharedInstance()
                if let num = phoneNumberUtil?.getCountryCode(forRegion: code) {
                    let phoneCode: String = String(format: "+%d", num.intValue)
                    if phoneCode != "+0" {
                        let country = Country(code: code, name: countryName, phoneCode: phoneCode)
                        countries.append(country)
                    }
                }
            }
        }
        countries = countries.sorted(by: { (country1, country2) -> Bool in
            if let name1 = country1.name, let name2 = country2.name {
                return name1 < name2
            } else {
                return false
            }
        })
        return countries
    }
    
    // MARK: - Picker Methods
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    public func pickerView(_ pickerView: UIPickerView,
                           viewForRow row: Int,
                           forComponent component: Int,
                           reusing view: UIView?) -> UIView {
        var resultView: Any
        if view == nil {
            resultView = Bundle(for: CountryView.self).loadNibNamed("CountryView", owner: self)?.first as Any
        } else {
            resultView = view as Any
        }
        if let resultView = resultView as? CountryView {
            resultView.setup(country: countries[row])
            return resultView
        } else {
            fatalError("CountryView invalid, please double check")
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let country = countries[row]
        if let countryPhoneCodeDelegate = countryPhoneCodeDelegate,
            let name = country.name,
            let code = country.code,
            let phoneCode = country.phoneCode {
            countryPhoneCodeDelegate.countryPhoneCodePicker(
                picker: self,
                didSelectCountryCountryWithName: name,
                countryCode: code,
                phoneCode: phoneCode
            )
        }
    }
}
