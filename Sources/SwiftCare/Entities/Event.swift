import Foundation

enum EventType: Hashable {

    case appointment(cancerType: CancerType, daysInTheRow: Int)
    case maintenance(machineIndex: Int)
    case breakdown(machineIndex: Int)
}

typealias EventPriority = Int

extension EventPriority {

    static let urgent = 100 
    static let high = 50
    static let normal = 25
    static let low = 0
}

enum CancerType: Hashable {

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

struct Event: Hashable, Comparable {

    var priority: EventPriority
    let type: EventType
    let desiredDate: Date

    static func < (_ lhs: Self, _ rhs: Self) -> Bool {
        return lhs.priority < rhs.priority
    }
}