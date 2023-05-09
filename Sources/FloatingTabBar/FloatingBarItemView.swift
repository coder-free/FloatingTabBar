import SwiftUI

@available(iOS 13.0.0, *)
@available(macOS 11.0, *)
public struct BottomBarItemView: View {
    public let isSelected: Bool
    public let item: BottomBarItem
    
    public var body: some View {
        VStack {
            Text(item.title)
        }
    }
}
