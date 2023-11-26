import Foundation

public enum EventType: Hashable {

    case treatmentSession(cancerType: CancerType, daysInRow: Int, patientID: UUID)
    case maintenance(machineIndex: Int)
    case breakdown(machineIndex: Int)
}

public typealias EventPriority = Int

extension EventPriority {

    public static let urgent = 100 
    public static let high = 50
    public static let normal = 25
    public static let low = 0
}

public enum CancerType: String, Codable, Hashable {

    case craniospinal
    case breast
    case breastSpecial
    case headAndNeck
    case abdomen
    case pelvis
    case crane
    case lung
    case lungSpecial
    case wholeBrain

    var treatmentDuration: Int {
        switch self {
            case .craniospinal:
                return 30
            case .breast:
                return 12
            case .breastSpecial:
                return 20
            case .headAndNeck:
                return 12
            case .abdomen:
                return 12
            case .pelvis:
                return 12
            case .crane:
                return 10
            case .lung:
                return 12
            case .lungSpecial:
                return 15
            case .wholeBrain:
                return 10
        }
    }

    var suitableMachineTypes: [MachineType] {
        switch self {
            case .craniospinal, .breastSpecial:
                return [.tb]
            case .breast:
                return MachineType.allCases
            case .headAndNeck, .abdomen, .pelvis, .crane, .lung, .lungSpecial:
                return [.tb, .vb]
            case .wholeBrain:
                return [.vb, .u]
        }
    }
}

public struct Event: Hashable, Comparable {

    var priority: EventPriority
    let type: EventType
    let desiredDate: Date

    public static func < (_ lhs: Self, _ rhs: Self) -> Bool {
        return lhs.priority < rhs.priority
    }
}