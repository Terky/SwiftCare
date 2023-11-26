// import Collections
// import Foundation














// @main
// public struct Main {

//     public static func main() async throws {
//         let scheduler = AppointmentScheduler.shared
//         // var eventHeap = Heap<Event>()

//         // /// Inserts
//         // eventHeap.insert(createTreatmentSession(cancerType: CancerType.craniospinal, daysInRow: 30))
//         // eventHeap.insert(createTreatmentSession(cancerType: CancerType.abdomen, daysInRow: 15, priority: EventPriority.high))
//         // eventHeap.insert(createTreatmentSession(cancerType: CancerType.breast, daysInRow: 20, priority: EventPriority.low))

//         // print(eventHeap.popMin()!)
//         // print(eventHeap.popMax()!)

//         // //  Scheduling logic 
//         // guard eventHeap.count > 15 else { return }
//         // let event = eventHeap.popMax()
        
//         for _ in 1...(16 * 4) {
//             scheduler.makeAppointment(for: createTreatmentSession(patient: UUID(), cancerType: Bool.random() ? .headAndNeck : .breast, daysInRow: 6))
//         }
//         // scheduler.makeAppointment(for: createTreatmentSession(patient: UUID(), cancerType: .crane, daysInRow: 8))
//         // scheduler.makeAppointment(for: createTreatmentSession(patient: UUID(), cancerType: .breast, daysInRow: 10))
//         // scheduler.makeAppointment(for: createTreatmentSession(patient: UUID(), cancerType: .craniospinal, daysInRow: 7))
//         // scheduler.makeAppointment(for: createTreatmentSession(patient: UUID(), cancerType: .lung, daysInRow: 3))

//         scheduler.dumpAppointments()
//     }
// }