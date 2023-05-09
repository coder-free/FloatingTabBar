import SwiftUI

@available(iOS 15.0, *)
@available(macOS 12.0, *)
public struct BottomBar : View {
    @Binding public var selectedIndex: Int

    public var items: [BottomBarItem]

    public init(selectedIndex: Binding<Int>, items: [BottomBarItem]) {
        self._selectedIndex = selectedIndex
        self.items = items
    }

    func itemView(at index: Int) -> some View {
        Button(action: {
            withAnimation { self.selectedIndex = index }
            Task {
                await items[index].completion(index)
            }
        }) {
            BottomBarItemView(isSelected: index == selectedIndex, item: items[index])
        }
        .padding(.init(top: 4, leading: 8, bottom: 4, trailing: 8))
        .foregroundColor(.white)
        .background(index == selectedIndex ? .blue: .gray)
        .cornerRadius(8)
        .buttonStyle(.plain)
    }

    public var body: some View {

        ZStack {
            #if os(iOS)
            BlurView(style: .light).frame(height: 50)
            #elseif os(macOS)
            BlurView(material: .contentBackground, blendingMode: .withinWindow).frame(height: 50)
            #endif
               
            HStack(alignment: .center) {
                ForEach(0..<items.count, id:\.self) { index in
                    self.itemView(at: index)

                    if index != self.items.count-1 {
                        Spacer()
                    }
                }
            }.padding([.horizontal]).animation(.default).padding(.bottom,0).padding(.top,0)
        }
    }
}

#if DEBUG
@available(iOS 15.0, *)
@available(macOS 12.0, *)
struct BottomBar_Previews : PreviewProvider {
    @State static var items: [BottomBarItem] = [
        BottomBarItem(title: "", icon: "house.fill", color: .purple),
        BottomBarItem(title: "", icon: "heart", color: .pink),
        BottomBarItem(title: "", icon: "magnifyingglass", color: .orange),
        BottomBarItem(title: "", icon: "magnifyingglass", color: .orange),
        BottomBarItem(title: "", icon: "person.fill", color: .blue)
    ]
    static var previews: some View {
        BottomBar(selectedIndex: .constant(0), items: BottomBar_Previews.items)
    }
}
#endif
