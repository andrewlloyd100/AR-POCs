//
//  HomeModel.swift
//  ARPOCs
//
//  Created by Andrew Lloyd on 08/12/2022.
//

import Foundation

public final class HomeModel: ObservableObject {
  @Published public var destination: Destination?

  public enum Destination: Equatable {
    case car
    case fruit
  }

  public init(
    destination: Destination? = nil
  ) {
    self.destination = destination
  }

  func carButtonTapped() {
      self.destination = .car
  }

  func fruitButtonTapped() {
    self.destination = .fruit
  }
}
