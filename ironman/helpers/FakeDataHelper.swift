//
//  FakeDataHelper.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/14/21.
//

import Foundation

class FakeDataHelper {
    
    static func getData(dataSource: DataSource) -> [String] {
        switch dataSource {
        case .gender:
            return getGenders()
        case .area:
            return getAreas()
        default:
            return []
        }
    }
    
    private static func getGenders() -> [String] {
        var genders: [String] = []
        
        genders.append("Male")
        genders.append("Female")
        genders.append("Others")
        
        return genders
    }
    
    private static func getAreas() -> [String] {
        var areas: [String] = []
        
        areas.append("Adabor")
        areas.append("Bashundhara")
        areas.append("Baridhara")
        areas.append("Dhanmondi")
        areas.append("Demra")
        areas.append("Elephant Road")
        areas.append("Hatirpool")
        areas.append("Hatirjheel")
        areas.append("Kalabagan")
        areas.append("Mohammadpur")
        areas.append("Panthapath")
        
        return areas
    }
    
    
    // MARK: html data
    
    static func getHtmlData(htmlType: HtmlType?) -> String {
        switch htmlType {
        case .PRIVACY_POLICY:
            return getPrivacyPolicy()
        case .TERMS_OF_SERVICE:
            return getTermsOfService()
        default:
            return ""
        }
    }
    
    
    private static func getPrivacyPolicy() -> String {
        return """
        <!DOCTYPE html>
        <style>
        body {
            background-color: #EFEFEF;
        }
        container {
            background-color: #EFEFEF;
        }
        p {
            font-family: OpenSans;
            font-size: 30px;
            font-style: normal;
            font-weight: normal;
            text-decoration: none;
            text-transform: none;
            color: #294366;
            background-color: #EFEFEF;
        }
        </style>
        <body>
            <div class="container">
            <p>A Privacy Policy is a statement or a legal document that states how a company or website collects, handles and processes data of its customers and visitors. It explicitly describes whether that information is kept confidential, or is shared with or sold to third parties.</p>
            <p>A Privacy Policy is a statement or a legal document that states how a company or website collects, handles and processes data of its customers and visitors.</p>
            </div>
        </body>
        """
    }
    
    private static func getTermsOfService() -> String {
        return """
        <!DOCTYPE html>
        <style>
        body {
            background-color: #EFEFEF;
        }
        div.container {
            background-color: #EFEFEF;
        }
        p {
            font-family: OpenSans;
            font-size: 30px;
            font-style: normal;
            font-weight: normal;
            text-decoration: none;
            text-transform: none;
            color: #294366;
            background-color: #EFEFEF;
        }
        h1 {
            font-family: OpenSans;
            font-size: 48px;
            font-style: normal;
            font-weight: bold;
            text-decoration: none;
            text-transform: none;
            color: #001733;
            background-color: #EFEFEF;
        }
        </style>

        <body>
            <div class="container">
                <h1 class="head_first">Terms Line</h1>
                <p>Terms of service (also known as terms of use and terms and conditions, commonly abbreviated as TOS or ToS, ToU or T&C) are the legal agreements between a service provider and a person who wants to use that service. The person must agree to abide by the terms of service in order to use the offered service.</p>
                
                <br/>
                
                <h1 class="head_second">Condition Line</h1>
                <p>Terms of service (also known as terms of use and terms and conditions, commonly abbreviated as TOS or ToS, ToU or T&C) are the legal agreements between a service provider and a person who wants to use that service. </p>
            </div>
        </body>

        """
    }
    
    static func getSegmentItems() -> [String] {
        var items: [String] = []
        
        items.append("Men")
        items.append("Women")
        items.append("Kids")
        items.append("House Hold")
        items.append("Abc")
        items.append("Cba")
        items.append("Bca")
        items.append("Others")
        
        return items
    }
}
