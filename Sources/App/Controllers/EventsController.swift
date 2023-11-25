import Foundation
import Vapor
import SwiftCare

final class EventsController: RouteCollection {

    func boot(routes: RoutesBuilder) throws {
        let eventRoutes = routes.grouped("api", "events")

        eventRoutes.get(use: getAllPlannedEventsHandler)
        eventRoutes.post(use: addEventHandler)

        let decoder = URLEncodedFormDecoder(configuration: .init(dateDecodingStrategy: .iso8601))
        ContentConfiguration.global.use(urlDecoder: decoder)
    }

    func getAllPlannedEventsHandler(_ req: Request) async throws -> [AppointmentContent] {
        struct Parameters: Content {

            let startDate: Date
            let endDate: Date
        }

        let params = try req.query.decode(Parameters.self)

        return AppointmentScheduler
            .shared
            .getAppointments(from: params.startDate, to: params.endDate)
            .map(AppointmentContent.init)
    }

    func addEventHandler(_ req: Request) async throws -> HTTPStatus {
        struct Parameters: Content {

            let name: String
            let cancerType: CancerType
            let daysInRow: Int
            let patientID: UUID
        }

        let params = try req.content.decode(Parameters.self)
        let event = createTreatmentSession(
            patient: params.patientID,
            cancerType: params.cancerType,
            daysInRow: params.daysInRow
        )

        let scheduler = AppointmentScheduler.shared
        scheduler.makeAppointment(for: event, params.name)

        return .ok
    }
}
