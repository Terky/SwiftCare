import Foundation


public func createTreatmentSession(patient: UUID, cancerType: CancerType, daysInRow: Int, priority: EventPriority = .normal, desiredDate: Date = .now) -> Event {
    let treatmentSession = EventType.treatmentSession(cancerType: cancerType, daysInRow: daysInRow, patientID: patient)
    return Event(priority: priority, type: treatmentSession, desiredDate: desiredDate)
}

func createMaintenance(machineIndex: Int, priority: Int = EventPriority.normal, desiredDate: Date = .now) -> Event {
    let maintenance = EventType.maintenance(machineIndex: machineIndex)
    return Event(priority: priority, type: maintenance, desiredDate: desiredDate)
}

func createBreakdown(machineIndex: Int) -> Event {
    let breakdown = EventType.breakdown(machineIndex: machineIndex)
    return Event(priority: .urgent, type: breakdown, desiredDate: .now)
}