//
//  WifiInteractorInput.swift
//  CleanArchitecture-Diffable
//
//  Created by Amirreza Eghtedari on 05.06.20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

protocol WifiInteractorInput {
	
	func toggleWifi(enabled: Bool)
	
	func scanForNetworks(enabled: Bool)
}
