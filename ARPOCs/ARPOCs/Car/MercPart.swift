import Foundation

public enum MercPart: String, CaseIterable {
    case frontIndicators = "FrontIndicators"
    case numberPlate = "NumberPlate"
    case innerHeadlights = "InnerHeadlights"
    case frontLogoInner = "FrontLogoInner"
    case frontLogoTrim = "FrontLogoTrim"
    case frontIndicatorLight = "FrontIndicatorLight"
    case brakeLights = "BrakeLights"
    case exhaustPipe = "ExhaustPipe"
    case vents = "Vents"
    case windows = "Windows"
    case interior = "Interior"
    case bumper = "Bumper"
    case trims = "Trims"
    case backIndicator = "BackIndicator"
    case body = "Body"
    case rims = "Rims"
    case tyres = "Tyres"
}

extension MercPart {
    
    var displayString: String {
        switch self {
        case .frontIndicators:
            return "Front Indicators"
        case .numberPlate:
            return "Number Plate"
        case .innerHeadlights:
            return "Inner Headlights"
        case .frontLogoInner:
            return "Inner Front Logo"
        case .frontLogoTrim:
            return "Front Logo Trim"
        case .frontIndicatorLight:
            return "Front Indicator Bulb"
        case .brakeLights:
            return "Brake Lights"
        case .exhaustPipe:
            return "Exhaust Pipe"
        case .vents:
            return "Vents"
        case .windows:
            return "Windows"
        case .interior:
            return "Interior"
        case .bumper:
            return "Bumper"
        case .trims:
            return "Trims"
        case .backIndicator:
            return "Back Indicators"
        case .body:
            return "Body"
        case .rims:
            return "Rims"
        case .tyres:
            return "Tyres"
        }
    }
}
