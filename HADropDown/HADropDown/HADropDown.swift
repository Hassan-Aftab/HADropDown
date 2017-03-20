//
//  HADropDown.swift
//  MyDropDown
//
//  Created by Hassan Aftab on 22/02/2017.
//  Copyright © 2017 Hassan Aftab. All rights reserved.
//

import UIKit

protocol HADropDownDelegate: class {
    func didSelectItem(dropDown: HADropDown, at index: Int)  
    func didShow(dropDown: HADropDown) 
    func didHide(dropDown: HADropDown) 
    
}

extension HADropDownDelegate {
    func didSelectItem(dropDown: HADropDown, at index: Int) {
        
    }
    func didShow(dropDown: HADropDown)  {
        
    }
    func didHide(dropDown: HADropDown)  {
        
    }
}

@IBDesignable
class HADropDown: UIView {

    var delegate: HADropDownDelegate!
    fileprivate var label = UILabel()
    
    @IBInspectable
    var title : String {
        set {
            label.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
            label.text = newValue
        }
        get {
            return label.text!
        }
    }
    
    @IBInspectable
    var textAllignment : NSTextAlignment {
        set {
            label.textAlignment = newValue
        }
        get {
            return label.textAlignment
        }
    }
    
    
    @IBInspectable
    var titleColor : UIColor {
        set {
            label.textColor = newValue
        }
        get {
            return label.textColor
        }
    }
    
    @IBInspectable
    var titleFontSize : CGFloat {
        set {
            titleFontSize1 = newValue
        }
        get {
            return titleFontSize1
        }
    }
    fileprivate var titleFontSize1 : CGFloat = 14.0
    
    
    @IBInspectable
    var itemHeight : Double {
        get {
            return itemHeight1
        }
        set {
            itemHeight1 = newValue
        }
    }
    @IBInspectable
    var itemBackground : UIColor {
        set {
            itemBackgroundColor = newValue
        }
        get {
            return itemBackgroundColor
        }
    }
    
    
    fileprivate var itemBackgroundColor = UIColor.white
    
    @IBInspectable
    var itemTextColor : UIColor {
        set {
            itemFontColor = newValue
        }
        get {
            return itemFontColor
        }
    }
    fileprivate var itemFontColor = UIColor.black
    
    fileprivate var itemHeight1 = 40.0
    
    
    @IBInspectable
    var itemFontSize : CGFloat {
        set {
            itemFontSize1 = newValue
        }
        get {
            return itemFontSize1
        }
    }
    fileprivate var itemFontSize1 : CGFloat = 14.0
    
    var itemFont = UIFont.systemFont(ofSize: 14)
    
    var font : UIFont {
        set {
            selectedFont = newValue
            label.font = selectedFont
        }
        get {
            return selectedFont
        }
    }
    fileprivate var selectedFont = UIFont.systemFont(ofSize: 14)
    
    var items = [String]()
    fileprivate var selectedIndex = -1
    
    var isCollapsed = true
    private var table = UITableView()
    
    var getSelectedIndex : Int {
        get {
            return selectedIndex
        }
    }
    
    private var tapGestureBackground: UITapGestureRecognizer!
    
    override func prepareForInterfaceBuilder() {
        label.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        font = UIFont(descriptor: font.fontDescriptor, size: titleFontSize)
        label.font = font
        self.addSubview(label)
        textAllignment = .center
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 4
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
        
        label.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.addSubview(label)
        textAllignment = .center
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap(gesture:)))
        self.addGestureRecognizer(tapGesture)
        table.delegate = self
        table.dataSource = self
        var rootView = self.superview
        
        // here we getting top superview to add table on that.
        while rootView?.superview != nil {
        rootView = rootView?.superview
       }
      
       let newFrame: CGRect = self.superview!.convert(self.frame, to: rootView)
      self.tableFrame = newFrame
      self.table.frame = CGRect(x: newFrame.origin.x, y: (newFrame.origin.y) + (newFrame.height)+5, width: (newFrame.width), height: 0)     
        
        table.backgroundColor = itemBackgroundColor
    }
      // Default tableview frame
      var tableFrame = CGRect.zero

    func didTapBackground(gesture: UIGestureRecognizer) {
        isCollapsed = true
        collapseTableView()
        
    }
    
    @objc private func didTap(gesture: UIGestureRecognizer) {
        isCollapsed = !isCollapsed
        if !isCollapsed {
            let height : CGFloat = CGFloat(items.count > 5 ? itemHeight*5 : itemHeight*Double(items.count))
            self.table.layer.zPosition = 1
            self.table.removeFromSuperview()
            self.table.layer.borderColor = UIColor.lightGray.cgColor
            self.table.layer.borderWidth = 1
            self.table.layer.cornerRadius = 4
            var rootView = self.superview
          // adding tableview to root view( we can say first view in hierarchy)
           while rootView?.superview != nil {
            rootView = rootView?.superview
          }
       
          rootView?.addSubview(self.table)

           self.table.reloadData()
            UIView.animate(withDuration: 0.25, animations: { 
                self.table.frame = CGRect(x: self.tableFrame.origin.x, y: self.tableFrame.origin.y + self.frame.height+5, width: self.frame.width, height: height)
              
            })

            
            if delegate != nil {
                delegate.didShow(dropDown: self)
            }
            let view = UIView(frame: UIScreen.main.bounds)
            view.tag = 99121
            self.superview?.insertSubview(view, belowSubview: table)
            
            tapGestureBackground = UITapGestureRecognizer(target: self, action: #selector(didTapBackground(gesture:)))
            view.addGestureRecognizer(tapGestureBackground)
        }
        else {
            collapseTableView()
        }
        
    }
    func collapseTableView() {
        
        if isCollapsed {
            // removing tableview from rootview
        UIView.animate(withDuration: 0.25, animations: { 
                self.table.frame = CGRect(x: self.tableFrame.origin.x, y: self.tableFrame.origin.y+self.frame.height, width: self.frame.width, height: 0)
            })
          var rootView = self.superview
          
          while rootView?.superview != nil {
             rootView = rootView?.superview
          }
          
          rootView?.viewWithTag(99121)?.removeFromSuperview()
            self.superview?.viewWithTag(99121)?.removeFromSuperview()
            if delegate != nil {
                delegate.didHide(dropDown: self)
            }
        }
    }
}
extension HADropDown : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.textAlignment = textAllignment
        cell?.textLabel?.text = items[indexPath.row]
        let font = UIFont(descriptor: itemFont.fontDescriptor, size: itemFontSize)
        
        cell?.textLabel?.font = font
        
        cell?.textLabel?.textColor = itemTextColor
        
        if indexPath.row == selectedIndex {
            cell?.accessoryType = .checkmark
        }
        else {
            cell?.accessoryType = .none
        }
        
        cell?.backgroundColor = itemBackgroundColor
        
        cell?.tintColor = self.tintColor
        
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(itemHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        label.text = items[selectedIndex]
        isCollapsed = true
        collapseTableView()
        if delegate != nil {
            delegate.didSelectItem(dropDown: self, at: selectedIndex)
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
