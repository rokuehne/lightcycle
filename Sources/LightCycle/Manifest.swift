/// The application's manifest.
struct Manifest {
	
	private init() {}

	static let name = "LightCycle"
	static let releaseVersion = "0.1.0"
	static let debugVersion =  "\(releaseVersion) Debug Preview"
	
	static var versionDescription: String {
		#if DEBUG
		return debugVersion
		#else
		return releaseVersion
		#endif
	}
	
}
