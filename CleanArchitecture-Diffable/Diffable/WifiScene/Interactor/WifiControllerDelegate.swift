//
//  WifiControllerDelegate.swift
//  CleanArchitecture-Diffable
//
//  Created by Amirreza Eghtedari on 05.06.20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

protocol WifiControllerDelegate {
	
	func wifiControllerDidUpdate(_: WiFiController, wifiEnabled: Bool, connectedNetwork: Network?, avaialbleNetworks: [Network]?)
}

