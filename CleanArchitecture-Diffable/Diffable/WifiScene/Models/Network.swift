//
//  Network.swift
//  CleanArchitecture-Diffable
//
//  Created by Amirreza Eghtedari on 05.06.20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

struct Network: Hashable {
	let name: String
	let identifier = UUID()

	func hash(into hasher: inout Hasher) {
		hasher.combine(identifier)
	}
	static func == (lhs: Network, rhs: Network) -> Bool {
		return lhs.identifier == rhs.identifier
	}
}

