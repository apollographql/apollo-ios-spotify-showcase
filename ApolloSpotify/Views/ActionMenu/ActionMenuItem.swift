import SwiftUI

struct ActionMenuItem: View {
  
  let label: String
  let systemImageName: String
  let actionHandler: (() -> Void)
  
  var body: some View {
    HStack {
      Image(systemName: systemImageName)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 20, height: 20)
        .padding(.all)
        .foregroundStyle(.white)
      
      VStack {
        Spacer()
        Text(label)
          .font(.system(size: 16))
          .fontWeight(.bold)
          .foregroundStyle(.white)
          .frame(maxWidth: .infinity, alignment: .leading)
        Spacer()
      }
      
      Spacer()
    }
    .frame(height: 60)
    .background(Color.init(hex: "535353"))
  }
}

#Preview {
    ActionMenuItem(
      label: "Action Label",
      systemImageName: "plus") {
        print("Action Handler")
      }
}
