# HADropDown
HADropDown is a simple iOS drop down list written in Swift. It expands and collapses. It allows the user to select only one item at a time. Items are just Strings. A delegate is notified when selection occurs. HADropDown is IBDesignable and IBInspectable with customizable colors, font, and row heights.
![Alt text](https://github.com/Hassan-Aftab/HADropDown/blob/master/Simulator%20Screen%20Shot?raw=true "Demo")

Simply include HADropDown.swift in your project. HADropDown requires Swift 3. 
# Usage

Create a HADropDown in IB or in code (using UIView's init methods). Then add items and set a delegate:

dropDown.items = ["hello", "goodbye", "why?"]
dropDown.delegate = self
You can also implement HADropDownDelegate to get notified when an item is selected:

```javascript
func didSelectItem(dropDown: HADropDown, at index: Int) {
        print("Item selected at index \(index)")
    }
```
The delegate can also optionally implement the method
```javascript
func didShow(dropDown: HADropDown) 
func didHide(dropDown: HADropDown) 
```
to be notified when the collapse status of the menu changes.

Items can be added or removed

All properties can be manually modified.

# License and Authorship

Released under the MIT License. Copyright 2017-2018 Hassan Aftab. Please open issues on GitHub.
