import SwiftUI

public final class CarModel: ObservableObject {
    @Published public var carType: CarType = CarType.merc
    
    @Published public var mercPaint: [CarPart : Color]
    @Published public var selectedPart: String = CarPart.body.rawValue {
        didSet {
            if let part = CarPart(rawValue: selectedPart),
               let color = mercPaint[part] {
                selectedColor = color
            }
        }
    }
    @Published public var selectedColor: Color = .blue {
        didSet {
            if let part = CarPart(rawValue: selectedPart) {
                mercPaint[part] = selectedColor
            }
        }
    }
    
    public init(
        type: CarType = .merc,
        mercPaint: [CarPart : Color] = [:]
    ) {
        self.carType = type
        self.mercPaint = [.body: .blue,
                          .exhaustPipe: .gray,
                          .windows: .white,
                          .trims: .pink,
                          .vents: .black,
        ]
    }
    
    public var selectedPartDisplayString: String {
        CarPart(rawValue: selectedPart)?.displayString ?? "-"
    }
}

