/*
 
 MIT License
 
 Copyright (c) 2016 Maxim Khatskevich (maxim@khatskevi.ch)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 
 */

public
extension Array
{
    public
    struct XCEArrayProxy<Element>
    {
        let array: [Element]
    }
    
    //===
    
    var xce: XCEArrayProxy<Element>
    {
        return XCEArrayProxy(array: self)
    }
}

//===

public
extension Array.XCEArrayProxy
{
    public
    enum Errors // scope
    {
        public
        struct InvalidIndex: Error { }
        
        public
        struct InvalidElement: Error { }
    }
    
    //===
    
    func isValidIndex(_ index: Int) -> Bool
    {
        return array.startIndex...array.endIndex ~= index
    }
    
    //===
    
    func isValidForInsertIndex(_ index: Int) -> Bool
    {
        return array.startIndex...(array.endIndex+1) ~= index
    }
    
    //===
    
    func element(at index: Int) throws -> Element
    {
        guard
            isValidIndex(index)
        else
        {
            throw Errors.InvalidIndex()
        }
        
        //---
        
        return array[index]
    }
    
    func elementOrNil(at index: Int) -> Element?
    {
        guard
            isValidIndex(index)
        else
        {
            return nil
        }
        
        //---
        
        return array[index]
    }
    
    //===
    
    func insert(_ element: Element, at index: Int) throws -> [Element]
    {
        guard
            isValidForInsertIndex(index)
        else
        {
            throw Errors.InvalidIndex()
        }
        
        //---
        
        var result = array
        
        //---
        
        result.insert(element, at: index)
        
        //---
        
        return result
    }
    
    //===
    
    func insert(_ elements: [Element], at index: Int) throws -> [Element]
    {
        guard
            isValidForInsertIndex(index)
        else
        {
            throw Errors.InvalidIndex()
        }
        
        //---
        
        var result = array
        
        //---
        
        result.insert(contentsOf: elements, at: index)
        
        //---
        
        return result
    }
    
    //===
    
    func remove(elementAt index: Int) throws -> [Element]
    {
        guard
            isValidIndex(index)
        else
        {
            throw Errors.InvalidIndex()
        }
        
        //---
        
        var result = array
        
        //---
        
        result.remove(at: index)
        
        //---
        
        return result
    }
}

//===

public
extension Array.XCEArrayProxy where Element: Equatable
{
    func remove(_ element: Element) throws -> [Element]
    {
        guard
            let index = array.index(of: element)
        else
        {
            throw Errors.InvalidElement()
        }
        
        //---
        
        var result = array
        
        //---
        
        result.remove(at: index)
        
        //---
        
        return result
    }
}