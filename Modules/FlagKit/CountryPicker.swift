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
    func countryPhoneCodePicker(picker: CountryPicker, didSelectCountryCountryWithName name: String, countryCode: String, phoneCode: String)
}

struct Country {
    var code: String?
    var name: String?
    var phoneCode: String?
    
    init(code: String?, name: String?, phoneCode: String?) {
        self.code = code
        self.name = name
        self.phoneCode = phoneCode
    }
}

class CountryPicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var countries: [Country]!
    var countryPhoneCodeDelegate: CountryPickerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        super.dataSource = self;
        super.delegate = self;
        
        countries = countryNamesByCode()
    }
    
    // MARK: - Country Methods
    
    func setCountry(code: String) {
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
                let num = phoneNumberUtil?.getCountryCode(forRegion: code)
                let phoneCode: String = String(format: "+%d", (num?.intValue)!)
                if phoneCode != "+0" {
                    let country = Country(code: code, name: countryName, phoneCode: phoneCode)
                    countries.append(country)
                }
            }
        }
        countries = countries.sorted(by: { (c1, c2) -> Bool in
            return c1.name! < c2.name!
        })
        return countries
    }
    
    // MARK: - Picker Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var resultView: CountryView
        if view == nil {
            resultView = (Bundle.main.loadNibNamed("CountryView", owner: self, options: nil)![0] as! CountryView)
        } else {
            resultView = view as! CountryView
        }
        resultView.setup(country: countries[row])
        return resultView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let country = countries[row]
        if let countryPhoneCodeDelegate = countryPhoneCodeDelegate {
            countryPhoneCodeDelegate.countryPhoneCodePicker(picker: self, didSelectCountryCountryWithName: country.name!, countryCode: country.code!, phoneCode: country.phoneCode!)
        }
    }
}
