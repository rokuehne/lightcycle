//
//  ImageWriter.swift
//  LightCycle
//
//  Created by Robert Kühne on 02.12.20.
//

import Foundation
import AppKit.NSImage
import CoreImage

enum ImageWriteError: Error {
	case missingBitmapRepresentation
	case unwritableFileType
	case notConvertibleImage
}

protocol ImageWriter {
	
}

extension ImageWriter {
	
	var imageRepresentationProperties: [NSBitmapImageRep.PropertyKey: Any] {
		[:]
	}
	
	func writeImage(_ image: NSImage, to url: URL) throws {
		guard let bitmap = bitmapRepresentation(from: image) else {
			throw ImageWriteError.missingBitmapRepresentation
		}
		
		guard let convertedImage = CIImage(bitmapImageRep: bitmap) else {
			throw ImageWriteError.notConvertibleImage
		}
		
		try CIContext().writeHEIFRepresentation(of: convertedImage, to: url, format: .A8, colorSpace: CGColorSpace(name: CGColorSpace.sRGB)!, options: [:])
		
		guard let representation = bitmap.representation(using: .jpeg, properties: imageRepresentationProperties) else {
			throw ImageWriteError.unwritableFileType
		}
		
		try representation.write(to: url)
	}
	
	private func bitmapRepresentation(from image: NSImage) -> NSBitmapImageRep? {
		return image.representations.first as? NSBitmapImageRep
	}
	
}
