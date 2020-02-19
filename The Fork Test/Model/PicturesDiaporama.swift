import Foundation

struct PicturesDiaporama: Codable {
    
    let w1350: URL?
    let w664: URL?
    let w612: URL?
    let w480: URL?
    let w240: URL?
    let label: String

    enum CodingKeys: String, CodingKey {
        case w1350 = "1350x759"
        case w664 = "664x374"
        case w612 = "612x344"
        case w480 = "480x270"
        case w240 = "240x135"
        case label
    }
}
