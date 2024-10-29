import SwiftUI

struct NowPlayingOverlayView: View {
  
  @StateObject private var viewModel = NowPlayingViewModel()
  @State private var isFullScreenPresented = false
  
  var body: some View {
    VStack(spacing: 0) {
      HStack {
        AsyncImage(url: viewModel.albumImgURL) { image in
          image.resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50)
            .clipShape(.rect(cornerRadius: 8))
            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
        } placeholder: {
          Image(systemName: "music.note")
            .frame(width: 50, height: 50)
            .background(.gray)
            .clipShape(.rect(cornerRadius: 8))
            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
        }
        
        VStack(alignment: .leading, spacing: 4) {
          Text(viewModel.trackName)
            .font(.system(size: 16))
            .foregroundStyle(.white)
          
          Text(viewModel.albumName)
            .font(.system(size: 12))
            .foregroundStyle(.white)
        }
        
        Spacer()
        
        Button {
          print("Play/pause")
        } label: {
          Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
            .foregroundStyle(.white)
            .frame(width: 50, height: 50)
        }

      }
      
      ProgressView(value: Double(viewModel.progressMs), total: Double(viewModel.trackLengthMs))
        .tint(.white)
    }
    .background(.black)
    .clipShape(.rect(cornerRadius: 8))
    .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2))
    .onTapGesture {
      isFullScreenPresented = true
    }
    .fullScreenCover(isPresented: $isFullScreenPresented) {
      NowPlayingView(viewModel: viewModel)
    }
  }
}

#Preview {
    NowPlayingOverlayView()
}
