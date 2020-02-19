import Foundation

struct PicturesMain: Codable {
    
    let w1350: URL?
    let w664: URL?
    let w612: URL?
    let w480: URL?
    let w240: URL?
    let w160: URL?
    let w80: URL?
    let square184: URL?
    let square92: URL?

    enum CodingKeys: String, CodingKey {
        case w1350 = "1350x759"
        case w664 = "664x374"
        case w612 = "612x344"
        case w480 = "480x270"
        case w240 = "240x135"
        case w160 = "160x120"
        case w80 = "80x60"
        case square184 = "184x184"
        case square92 = "92x92"
    }
}
