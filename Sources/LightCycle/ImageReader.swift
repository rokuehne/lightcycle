//
//  ImageReader.swift
//  LightCycle
//
//  Created by Robert Kühne on 02.12.20.
//

import Foundation
import AppKit.NSImage

enum ImageReadError: Error {
	case unreadable
}

/// Read image data from file system.
protocol ImageReader {
	
}

extension ImageReader {
	
	func readImage(from url: URL) throws -> NSImage {
		guard let image = NSImage(contentsOf: url) else {
			throw ImageReadError.unreadable
		}
		
		return image
	}
	
}
