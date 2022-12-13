import SwiftUI

public final class CarModel: ObservableObject {
    @Published public var mercPaint: [MercPart : Color]
    @Published public var selectedPart: String = MercPart.body.rawValue {
        didSet {
            if let part = MercPart(rawValue: selectedPart),
               let color = mercPaint[part] {
                selectedColor = color
            }
        }
    }
    @Published public var selectedColor: Color = .blue {
        didSet {
            if let part = MercPart(rawValue: selectedPart) {
                mercPaint[part] = selectedColor
            }
        }
    }
    
    public init(
        mercPaint: [MercPart : Color] = [:]
    ) {
        self.mercPaint = [.body: .blue,
                          .numberPlate: .yellow,
                          .frontIndicators: .orange,
                          .windows: .white,
                          .trims: .pink,
                          .rims: .red,
                          .tyres: .brown,
                          .bumper: .yellow
        ]
    }
    
    public var selectedPartDisplayString: String {
        MercPart(rawValue: selectedPart)?.displayString ?? "-"
    }
}

