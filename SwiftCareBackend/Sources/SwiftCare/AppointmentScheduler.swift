import Foundation

public class Appointment: CustomStringConvertible {

    public let id = UUID()
    public var name: String
    public let startDate: Date
    // let endDate: Date
    public let machineIndex: Int
    public var patientID: UUID?

    public init(name: String, startDate: Date, machineIndex: Int, patientID: UUID?) {
        self.name = name
        self.startDate = startDate
        self.machineIndex = machineIndex
        self.patientID = patientID
    }

    public var description: String {
        return "Appointment(startDate: \(startDate.formatted()), machineIndex: \(machineIndex), patientID: \(patientID))"
    }
}

// struct TimeSlot {

//     let startTime: Date
//     var appointmentID: UUID?
// }

// // [TS1tb1, TS1tb2, TS1vb1, TS1vb2, TS1u, TS2tb1, TS2tb2, TS2vb1, TS2vb2, TS2u]

// struct MachineCalendar {

//     var slots = [TimeSlot]()
//     let machine: Int
//     var machineType: MachineType {
//         return availableMachines[machine]
//     }
// }

// var machineCalendars = availableMachines.indices.map { MachineCalendar(machine: $0) }

public final class AppointmentScheduler {

    private var appointments = [Appointment]()
    public static let shared = AppointmentScheduler()
    private init() {}

    public func getAppointments(from startDate: Date, to endDate: Date) -> [Appointment] {
        return appointments.filter { $0.startDate >= startDate && $0.startDate <= endDate && $0.patientID != nil }
    }

    func dumpAppointments() {
        print("Total appointments: \(appointments.filter { $0.patientID != nil }.count)")
        var patientsToAppointments = [UUID: [Appointment]]()
        for appointment in appointments where appointment.patientID != nil {
            // if let patientID = appointment.patientID {
                // patientsToAppointments[Calendar.current.component(.day, from: appointment.startDate), default: []].append(appointment)
                patientsToAppointments[appointment.patientID!, default: []].append(appointment)
            // }
        }
        for (patientID, appointments) in patientsToAppointments {
            print("Patient: \(patientID)")
            print("[")
            for appointment in appointments {
                print("  \(appointment),")
            }
            print("]")
        }
        // print(patientsToAppointments)
    }

    private func createSlotsForADay() -> [Appointment] {
        var result = [Appointment]()
        let startingFrom: Date
        if let lastSlotTime = appointments.last?.startDate {
            startingFrom = Calendar.current.date(byAdding: .day, value: 1, to: lastSlotTime)!
        } else {
            startingFrom = .now
        }
        
        var startOfWorkingDay = Calendar.current.startOfDay(for: startingFrom)
        startOfWorkingDay = Calendar.current.date(byAdding: .hour, value: 8, to: startOfWorkingDay)!

        var currentSlotStart = startOfWorkingDay
        for slotNumber in 1...16 {
            for machine in availableMachines.indices {
                result.append(Appointment(name: String(), startDate: currentSlotStart, machineIndex: machine, patientID: nil))
            }
            if slotNumber == 8 {
                currentSlotStart = Calendar.current.date(byAdding: .hour, value: 1, to: currentSlotStart)!
            }
            currentSlotStart = Calendar.current.date(byAdding: .minute, value: 30, to: currentSlotStart)!
        }

        return result
    }

    public func makeAppointment(for event: Event, _ name: String) {
        switch event.type {
            case .treatmentSession(let cancerType, let daysInRow, let patientID):
                bookAppointments(name: name, cancerType: cancerType, daysInRow: daysInRow, paitentID: patientID)
            case .maintenance(let _):
                return
            case .breakdown(let _):
                return
        }
    }

    private func bookAppointments(name: String,cancerType: CancerType, daysInRow: Int, paitentID: UUID) {
        let suitableMachines = cancerType
            .suitableMachineTypes
            .flatMap { indices(of: $0, in: availableMachines) }

        extendAppointmentsIfNeeded(machines: suitableMachines, daysInRow: daysInRow)

        let appointmentsToBook = getAvalableAppointments(machines: suitableMachines, daysInRow: daysInRow)
        print("[DBG] \(appointmentsToBook.count) for \(paitentID)")
        for appointment in appointmentsToBook {
            appointment.name = name
            appointment.patientID = paitentID
        }
    }

    private func extendAppointmentsIfNeeded(machines: [Int], daysInRow: Int) {
        let firstAvailableSlot = appointments
            .filter { machines.contains($0.machineIndex) }
            .first { $0.patientID == nil }

        let daysMissing: Int
        if let firstAvailableSlot {
            let firstAvailableSlotDate = firstAvailableSlot.startDate
            let lastSlotDate = appointments.last!.startDate
            let daysBetween = Calendar.current.dateComponents([.day], from: firstAvailableSlotDate, to: lastSlotDate).day!
            daysMissing = daysInRow - daysBetween
        } else {
            daysMissing = daysInRow
        }

        if daysMissing > 0 {
            for _ in 1...daysMissing {
                appointments.append(contentsOf: createSlotsForADay())
            }
        }
    }

    private func getAvalableAppointments(machines: [Int], daysInRow: Int) -> [Appointment] {
        let freeAppointmentsForMachine = appointments
            .filter { machines.contains($0.machineIndex) }
            .filter { $0.patientID == nil }

        var appointmentsLeft = daysInRow
        var appointmentsToBook = [Appointment]()
        for appointment in freeAppointmentsForMachine {
            if appointmentsToBook.isEmpty {
                appointmentsLeft -= 1
                appointmentsToBook.append(appointment)
            } else if let last = appointmentsToBook.last {
                if Calendar.current.compare(last.startDate, to: appointment.startDate, toGranularity: .day) == .orderedSame {
                    continue
                } else {
                    appointmentsLeft -= 1
                    appointmentsToBook.append(appointment)
                }
            }
            if appointmentsLeft == 0 {
                break
            }
        }

        return appointmentsToBook
    }

    private func indices(of type: MachineType, in array: [MachineType]) -> [Int] {
        return array.enumerated().filter { $0.element == type }.map { $0.offset }
    }
}
