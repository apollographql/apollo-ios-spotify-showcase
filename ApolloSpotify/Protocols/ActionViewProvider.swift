import Foundation
import SwiftUI

protocol ActionViewProvider: ObservableObject {
  associatedtype ActionView: View
  var actionView: ActionView { get }
}
