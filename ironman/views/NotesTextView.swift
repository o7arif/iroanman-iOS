//
//  NotesTextView.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/15/21.
//

import UIKit

class NotesTextView: UITextView {
    
    var placeholder = "" {
        didSet {
            showPlaceholder()
        }
    }
    
    override var text: String! {
        didSet {
            textColor = text == placeholder ? .textGrey : .textBlack
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        delegate = self
        
        textAlignment = .left
        backgroundColor = .color(fromHexString: "F1F8FF")
        
        // Update UITextView font size and colour
        font = OpenSans.regular.of(size: AppConst.fontSize12)
        textColor = .black
        
        // Make UITextView corners rounded
        layer.cornerRadius = 10
        
        // Make UITextView Editable
        isEditable = true
        
        // padding
        textContainerInset = UIEdgeInsets.init(top: 0, left: 12, bottom: 0, right: 12)
        contentInset = UIEdgeInsets.init(top: 12, left: 0, bottom: 12, right: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func showPlaceholder() {
        text = placeholder
    }
    
    private func hidePlaceholder() {
        text = ""
    }
}


extension NotesTextView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if text == placeholder { hidePlaceholder() }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if text.isEmpty { showPlaceholder() }
    }
    
}
