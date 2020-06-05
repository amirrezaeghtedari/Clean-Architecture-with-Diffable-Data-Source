//
//  NetworkViewModel.swift
//  CleanArchitecture-Diffable
//
//  Created by Amirreza Eghtedari on 05.06.20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

struct NetworkViewModel: Hashable {
	
	let type: NetworkViewModelType
	var title: String
	var identifier: UUID
	
	init(network: Network, type: NetworkViewModelType) {
		self.title = network.name
		self.type = type
		self.identifier = network.identifier
	}
	
	init(title: String, type: NetworkViewModelType) {
		self.title = title
		self.type = type
		self.identifier = UUID()
	}

	var isConfig: Bool {
		let configItems: [NetworkViewModelType] = [.currentNetwork, .wifiEnabled]
		return configItems.contains(type)
	}
	var isNetwork: Bool {
		return type == .availableNetwork
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(self.identifier)
	}
}

