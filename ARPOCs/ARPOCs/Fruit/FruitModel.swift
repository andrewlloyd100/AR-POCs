import SwiftUI

public final class FruitModel: ObservableObject {
    @Published public var banana: Bool
    @Published public var grapes: Bool
    @Published public var peach: Bool
    @Published public var watermelon: Bool
    @Published public var lemon: Bool
    
    public init(
        banana: Bool = true,
        grapes: Bool = true,
        peach: Bool = true,
        watermelon: Bool = true,
        lemon: Bool = true
    ) {
        self.banana = banana
        self.grapes = grapes
        self.peach = peach
        self.watermelon = watermelon
        self.lemon = lemon
    }
}
