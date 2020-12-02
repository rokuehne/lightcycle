import Foundation
import ArgumentParser

enum Mode: String, ExpressibleByArgument {
	case create
}

struct LightCycle: ParsableCommand, ImageReader {
	
	@Argument(help: "The mode of the operation. (options: create)")
	var mode: Mode = .create
	
	@Option(name: [.short, .customLong("day")], help: "The url of the day image used in light cycle")
	var dayImageUrl: URL
	
	@Option(name: [.short, .customLong("night")], help: "The url of the night image used in light cycle")
	var nightImageUrl: URL
	
	@Option(name: [.short, .customLong("output")], help: "The url of the output image used in light cycle")
	var outputImageUrl: URL
	
	func run() throws {
		guard try dayImageUrl.checkResourceIsReachable() else {
			print("Given day image is not reachable")
			return
		}
		
		guard try nightImageUrl.checkResourceIsReachable() else {
			print("Given night image is not reachable")
			return
		}
		
		let dayImage = try readImage(from: dayImageUrl)
		let nightImage = try readImage(from: nightImageUrl)
		
		switch mode {
		case .create:
			print(dayImage.size)
			print(nightImage.size)
			print(mode.rawValue)
		}
	}

}

extension URL: ExpressibleByArgument {
	
	public init?(argument: String) {
		self.init(string: argument)
	}
	
}

LightCycle.main()
