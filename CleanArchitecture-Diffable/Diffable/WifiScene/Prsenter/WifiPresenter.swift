//
//  WifiPresenter.swift
//  CleanArchitecture-Diffable
//
//  Created by Amirreza Eghtedari on 05.06.20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

class WifiPresenter {
	
	weak var delegate: WifiPresenterDelegate?
	private let conifgItemVeiwModel = NetworkViewModel(title: "Wi-Fi", type: .wifiEnabled)
}

extension WifiPresenter: WifiControllerDelegate {
	
	func wifiControllerDidUpdate(_: WiFiController, wifiEnabled: Bool, connectedNetwork: Network?, avaialbleNetworks: [Network]?) {
		
		//Sort Networks and convert to NetworkViewModels
		var sortedAvaialbleNetworkViewModles: [NetworkViewModel]? = nil
		if let avaialbleNetworks = avaialbleNetworks {
			let sortedAvaialbleNetworks = avaialbleNetworks.sorted {
				$0.name < $1.name
			}
			sortedAvaialbleNetworkViewModles = sortedAvaialbleNetworks.map({ (netwrok) -> NetworkViewModel in
				return NetworkViewModel(network: netwrok, type: .availableNetwork)
			})
		}
		
		//Convert connected Network to NetworkViewModel
		var connectedNetworkViewModel: NetworkViewModel? = nil
		if let connectedNetwork = connectedNetwork {
			connectedNetworkViewModel = NetworkViewModel(network: connectedNetwork, type: .currentNetwork)
		}
		
		//Trigger delegate method
		delegate?.wifiPresenterDidUpdate(self, wifiEnabled: wifiEnabled, configItem: conifgItemVeiwModel, connectedNetwork: connectedNetworkViewModel, avaialbleNetworks: sortedAvaialbleNetworkViewModles)
	}
}

