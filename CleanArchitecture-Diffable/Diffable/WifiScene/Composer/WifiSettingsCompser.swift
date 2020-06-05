//
//  WifiSettingsCompser.swift
//  CleanArchitecture-Diffable
//
//  Created by Amirreza Eghtedari on 05.06.20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

class WifiSettingsCompser {
	
	static func makeModule() -> WiFiSettingsViewController {

		let wifiController = WiFiController()
		let wifiSettingsViewController = WiFiSettingsViewController(wifiController: wifiController)
		let wifiPresenter = WifiPresenter()
		wifiController.delegate = wifiPresenter
		wifiPresenter.delegate = wifiSettingsViewController

		return wifiSettingsViewController
	}
}

