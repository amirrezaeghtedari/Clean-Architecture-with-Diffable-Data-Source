//
//  WifiPresenterDelegate.swift
//  CleanArchitecture-Diffable
//
//  Created by Amirreza Eghtedari on 05.06.20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

protocol WifiPresenterDelegate: class {
	
	func wifiPresenterDidUpdate(_: WifiPresenter, wifiEnabled: Bool, configItem: NetworkViewModel, connectedNetwork: NetworkViewModel?, avaialbleNetworks: [NetworkViewModel]?)
}

