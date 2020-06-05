//
//  NetworkViewModel.swift
//  CleanArchitecture-Diffable
//
//  Created by Amirreza Eghtedari on 05.06.20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

struct NetworkViewModel: Hashable {
	
	let title: String
	let type: NetworkViewModelType
	let network: Network?

	init(title: String, type: NetworkViewModelType) {
		self.title = title
		self.type = type
		self.network = nil
		self.identifier = UUID()
	}
	init(network: Network) {
		self.title = network.name
		self.type = .availableNetwork
		self.network = network
		self.identifier = network.identifier
	}
	var isConfig: Bool {
		let configItems: [NetworkViewModelType] = [.currentNetwork, .wifiEnabled]
		return configItems.contains(type)
	}
	var isNetwork: Bool {
		return type == .availableNetwork
	}

	private let identifier: UUID
	func hash(into hasher: inout Hasher) {
		hasher.combine(self.identifier)
	}
}

