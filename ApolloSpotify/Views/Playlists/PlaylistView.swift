import SwiftUI
import SpotifyAPI

struct PlaylistView: View {
  
  @StateObject private var viewModel: PlaylistViewModel
  @State var addTracksPresented: Bool = false
  @State var selectedTrack: TrackFragment?
  
  init(playlistID: SpotifyAPI.ID) {
    _viewModel = StateObject(wrappedValue: PlaylistViewModel(playlistID: playlistID))
  }
  
  var body: some View {
    VStack {
      AsyncImage(url: viewModel.playlistImageURL) { image in
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
      
      VStack {
        HStack {
          Text(viewModel.playlistName)
            .fontWeight(.bold)
            .font(.system(size: 20))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        
        HStack(spacing: 0) {
          AsyncImage(url: viewModel.playlistAuthorImageURL) { image in
            image.resizable()
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 20, height: 20)
              .foregroundStyle(.white)
              .padding(.trailing)
          } placeholder: {
            Image(systemName: "person.crop.circle")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 20, height: 20)
              .foregroundStyle(.white)
              .padding(.trailing)
          }
          
          Text(viewModel.playlistAuthor)
            .fontWeight(.bold)
            .font(.system(size: 12))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        
        HStack(spacing: 0) {
          Image(systemName: "globe")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 10, height: 10)
            .foregroundStyle(Color.init(hex: "b3b3b3"))
            .padding(.trailing)
          
          Text(viewModel.playlistLength)
            .font(.system(size: 10))
            .foregroundStyle(Color.init(hex: "b3b3b3"))
            .frame(maxWidth: .infinity, alignment: .leading)
        }
      }
      
      List {
        Button {
          print("Add Tracks")
          addTracksPresented = true
        } label: {
          addTrackButtonView
        }
        .frame(height: 60)
        .listRowInsets(.init())
        .listRowSeparator(.hidden)
        .background(Color.init(hex: "121212"))
        
        ForEach(0..<viewModel.playlistTracks.count, id: \.self) { index in
          TrackCellView(
            playlistTrack: viewModel.playlistTracks[index],
            actionProvider: StateObject(
              wrappedValue: TrackMenuAction(
                track: viewModel.playlistTracks[index],
                selectedTrack: $selectedTrack
              )
            )
          )
            .listRowInsets(.init())
            .listRowSeparator(.hidden)
        }
      }
      .listStyle(.plain)
      .sheet(isPresented: $addTracksPresented, content: {
        PlaylistAddTracksView(
          isPresented: $addTracksPresented,
          playlistID: viewModel.playlistID,
          recommendationInput: viewModel.getRecommendationInput()
        )
        .presentationCornerRadius(8)
      })
      .sheet(item: $selectedTrack) { item in
        trackActionMenu(item)
          .presentationDetents([.medium])
          .presentationBackground(Color.init(hex: "212121"))
          .presentationCornerRadius(8)
      }
      
    }
    .padding(.all)
    .background(Color.init(hex: "121212"))
    .task {
      viewModel.fetchPlaylist()
    }
  }
  
  private var addTrackButtonView: some View {
    HStack {
      Image(systemName: "plus")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .padding(.all)
        .foregroundStyle(.white)
        .background(Color.init(hex: "212121"))
      
      Text("Add to this playlist")
        .font(.system(size: 14))
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
      
      Spacer()
    }
  }
  
  private func trackActionMenu(_ track: TrackFragment) -> some View {
    let removeTrackAction = ActionMenuItem(
      label: "Remove from this playlist",
      systemImageName: "x.circle") {
        viewModel.removeTrackFromPlaylist(
          track) { success in
            if success {
              self.selectedTrack = nil
            }
          }
      }
    
    return ActionMenuModalView(
      title: track.name,
      menuItems: [
        removeTrackAction
      ])
  }
}

extension TrackFragment: Identifiable {}

//#Preview {
//    PlaylistView()
//}
