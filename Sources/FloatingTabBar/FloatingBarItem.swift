import SwiftUI

@available(iOS 13.0, *)
@available(OSX 11.0, *)
public struct BottomBarItem {
    public let title: String
    public let icon: String
    public let color: Color
    public var completion: (_ index: Int) async -> Void = {index in }
    
    public init(title: String, icon: String, color: Color) {
        self.title = title
        self.icon = icon
        self.color = color
    }
    
    public init(title: String, icon: String, color: Color, completion: @escaping (_ index: Int) async -> Void) {
        self.title = title
        self.icon = icon
        self.color = color
        self.completion = completion
    }
}

