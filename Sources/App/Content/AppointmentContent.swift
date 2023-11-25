import Vapor
import SwiftCare

struct AppointmentContent: Content {

    public private(set) var id: UUID
    public var name: String
    public let startDate: Date
    public let machineIndex: Int
    public var patientID: UUID?

    init(_ appointment: Appointment) {
        id = appointment.id
        name = appointment.name
        startDate = appointment.startDate
        machineIndex = appointment.machineIndex
        patientID = appointment.patientID
    }
}
