import SwiftUI

struct NowPlayingView: View {
  
  @StateObject private var viewModel: NowPlayingViewModel
  @Environment(\.dismiss) var dismiss
  
  init(viewModel: NowPlayingViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
  var body: some View {
    VStack {
      topBarView
      coverImageView
      playbackItemInfoView
      playbackStatusView
      playbackControlsView
      bottomBarView
    }
    .background(Color(hex: "121212"))
  }
  
  private var topBarView: some View {
    HStack {
      Button {
        dismiss()
      } label: {
        Image(systemName: "chevron.down")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
          .frame(width: 46, height:  46)
          .foregroundStyle(.white)
      }

      Spacer()
      Text(viewModel.albumName)
        .font(.system(size: 14, weight: .bold))
        .foregroundStyle(.white)
        .frame(alignment: .center)
      Spacer()
      Button {
        print("Track Menu")
      } label: {
        Image(systemName: "ellipsis")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
          .frame(width: 46, height:  46)
          .foregroundStyle(.white)
      }

    }
    .padding(.horizontal)
  }
  
  private var coverImageView: some View {
    AsyncImage(url: viewModel.albumImgURL) { image in
      GeometryReader { geo in
        HStack {
          image.resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: geo.size.width * 0.75, height: geo.size.width * 0.75, alignment: .center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
    } placeholder: {
        GeometryReader { geo in
          HStack {
            Image(systemName: "music.note")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: geo.size.width * 0.75, height: geo.size.width * 0.75, alignment: .center)
              .background(.white)
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    .padding(.vertical)
  }
  
  private var playbackItemInfoView: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(viewModel.trackName)
          .font(.system(size: 20, weight: .bold))
          .foregroundStyle(.white)
        Text(viewModel.artistName)
          .font(.system(size: 16, weight: .thin))
          .foregroundStyle(.white)
      }
      Spacer()
      Button {
        print("Add to liked songs")
      } label: {
        Image(systemName: "plus.circle")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .padding(EdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 6))
          .frame(width: 46, height:  46)
          .foregroundStyle(.white)
      }
    }
    .padding(.horizontal)
  }
  
  private var playbackStatusView: some View {
    VStack {
      ProgressView(value: Double(viewModel.progressMs), total: Double(viewModel.trackLengthMs))
        .tint(.white)

      HStack {
        Text(viewModel.trackProgressString)
          .font(.system(size: 12))
          .foregroundStyle(.white)
        Spacer()
        Text(viewModel.trackRemainingString)
          .font(.system(size: 12))
          .foregroundStyle(.white)
      }
    }
    .padding(.horizontal)
  }
  
  private var playbackControlsView: some View {
    HStack {
      Button {
        print("Shuffle Toggle")
      } label: {
        Image(systemName: "shuffle")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
          .frame(width: 46, height:  46)
          .foregroundStyle(.white)
      }
      Spacer()
      Button {
        print("Jump to beginning")
      } label: {
        Image(systemName: "backward.end.fill")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
          .frame(width: 46, height:  46)
          .foregroundStyle(.white)
      }
      Spacer()
      Button {
        print("Play/Pause")
      } label: {
        Image(systemName: "play.circle.fill")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .padding(EdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 6))
          .frame(width: 70, height:  70)
          .foregroundStyle(.white)
      }
      Spacer()
      Button {
        print("Next Song")
      } label: {
        Image(systemName: "forward.end.fill")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
          .frame(width: 46, height:  46)
          .foregroundStyle(.white)
      }
      Spacer()
      Button {
        print("Repeat")
      } label: {
        Image(systemName: "repeat")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
          .frame(width: 46, height:  46)
          .foregroundStyle(.white)
      }
    }
    .padding(.horizontal)
  }
  
  private var bottomBarView: some View {
    HStack {
      Button {
        print("Device")
      } label: {
        Image(systemName: "hifispeaker.2")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 10))
          .frame(width: 40, height:  40)
          .foregroundStyle(.white)
      }
      Spacer()
      Button {
        print("Share")
      } label: {
        Image(systemName: "square.and.arrow.up")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
          .frame(width: 40, height:  40)
          .foregroundStyle(.white)
      }

    }
    .padding(.horizontal)
  }
}

//#Preview {
//    NowPlayingView()
//}
