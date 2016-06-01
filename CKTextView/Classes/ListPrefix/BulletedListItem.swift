//
//  BulletedListItem.swift
//  Pods
//
//  Created by Chanricle King on 5/11/16.
//
//

import UIKit

class BulletedListItem: BaseListItem {
    var label: UILabel?
    
    override func listType() -> ListType {
        return ListType.Bulleted
    }
    
    required init(keyY: CGFloat, ckTextView: CKTextView, listInfoStore: BaseListInfoStore?)
    {
        super.init()
        
        self.firstKeyY = keyY
        self.keyYSet.insert(keyY)
        
        // create number
        setupBulletLabel(keyY, ckTextView: ckTextView)
        
        if listInfoStore == nil {
            self.listInfoStore = BaseListInfoStore(listStartByY: keyY, listEndByY: keyY)
        } else {
            self.listInfoStore = listInfoStore
            self.listInfoStore!.listEndByY = keyY
        }
    }
    
    // MARK: Override
    
    override func createNextItemWithY(y: CGFloat, ckTextView: CKTextView) {
        let nextItem = BulletedListItem(keyY: y, ckTextView: ckTextView, listInfoStore: self.listInfoStore)
        handleRelationWithNextItem(nextItem, ckTextView: ckTextView)
    }
    
    override func reDrawGlyph(index: Int, ckTextView: CKTextView) {
        clearGlyph()
        
        setupBulletLabel(firstKeyY, ckTextView: ckTextView)
    }
    
    override func clearGlyph() {
        label?.removeFromSuperview()
    }
    
    override func destroy(ckTextView: CKTextView, byBackspace: Bool, withY y: CGFloat) {
        super.destroy(ckTextView, byBackspace: byBackspace, withY: y)
        
        clearGlyph()
    }
    
    // MARK: setups
    
    private func setupBulletLabel(keyY: CGFloat, ckTextView: CKTextView)
    {
        let lineHeight = ckTextView.font!.lineHeight
        let width = lineHeight + 10
        
        label = UILabel(frame: CGRect(x: 8, y: keyY, width: width, height: lineHeight))
        label!.font = ckTextView.font!
        label?.textAlignment = .Center
        label!.text = "●"
        
        // Append label to textView.
        ckTextView.addSubview(label!)
    }
}
