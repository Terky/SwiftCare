// import Algorithms
// import Collections
// import Dispatch
// import Foundation

// struct WorkingDay {

//     var events: Heap<Event>
// }

// struct EnqueuedEvent {

// }

// final class Scheduler {

//     private let schedulerQueue = DispatchQueue(label: "scheduler-queue")

//     private var appointmentQueue = Heap<Event>()

//     func addPatient(cancerType: CancerType, daysInRow: Int) {
//         schedulerQueue.async { [unowned self] in
//             let patientID = UUID()
//             var firstDate = Date.now
//             for (left, right) in appointmentQueue.unordered.adjacentPairs() {

//             }
//             for _ in 1...daysInRow {
//                 appointmentQueue.insert(createTreatmentSession(patient: patientID, cancerType: cancerType, daysInRow: daysInRow))            
//             }
//         }
//     }

//     func addMaintenence(for machine: Int) {
//         schedulerQueue.async { [unowned self] in
//             appointmentQueue.insert(createMaintenance(machineIndex: machine))
//         }
//     }

//     func addBreakdown(for machine: Int) {
//         schedulerQueue.async { [unowned self] in
//             appointmentQueue.insert(createBreakdown(machineIndex: machine))
//         }
//     }

//     private func findFirstAvailableDate(for machineType: MachineType) -> Date {
//         // var currentAppointments = appointmentQueue
//     }
// }

// extension Array {

//     func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> Self {
//         return sorted { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
//     }
// }