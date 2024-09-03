import SwiftUI

struct ActionMenuModalView: View {
  
  let title: String
  let menuItems: [ActionMenuItem]
  
  var body: some View {
    VStack {
      Text(title)
        .font(.system(size: 18))
        .foregroundStyle(.white)
      
      List {
        ForEach(0..<menuItems.count, id: \.self) { index in
          menuItems[index]
            .listRowInsets(.init())
            .listRowSeparator(.hidden)
            .onTapGesture {
              menuItems[index].actionHandler()
            }
        }
      }
      .listStyle(.plain)
    }
    .background(Color.init(hex: "212121"))
    .padding(.all)
  }
}

#Preview {
    ActionMenuModalView(
      title: "Action Menu Title",
      menuItems: [
        ActionMenuItem(label: "Action 1", systemImageName: "plus", actionHandler: {
          print("Action 1 handler.")
        }),
        ActionMenuItem(label: "Action 2", systemImageName: "x.circle", actionHandler: {
          print("Action 2 handler.")
        })
      ])
}
