/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Mimics the Settings.app for displaying a dynamic list of available wi-fi access points
*/

import UIKit

class WiFiSettingsViewController: UIViewController {

    enum Section: CaseIterable {
        case config, networks
    }
	
	var isVisible: Bool = false
	
	var firstShow: Bool = true
	var wifiController: WifiInteractorInput!

    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    var dataSource: UITableViewDiffableDataSource<Section, NetworkViewModel>! = nil
    var currentSnapshot: NSDiffableDataSourceSnapshot<Section, NetworkViewModel>! = nil

	init(wifiController: WifiInteractorInput) {
		self.wifiController = wifiController
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    static let reuseIdentifier = "reuse-identifier"

    override func viewDidLoad() {
        
		super.viewDidLoad()
        self.navigationItem.title = "Wi-Fi"
        configureTableView()
        configureDataSource()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		
		super.viewWillAppear(animated)
		wifiController.toggleWifi(enabled: true)
		wifiController.scanForNetworks(enabled: true)
	}
}

extension WiFiSettingsViewController {

    func configureDataSource() {
		
        self.dataSource = UITableViewDiffableDataSource
            <Section, NetworkViewModel>(tableView: tableView) { [weak self]
                (tableView: UITableView, indexPath: IndexPath, item: NetworkViewModel) -> UITableViewCell? in
            guard let self = self else { return nil }

            let cell = tableView.dequeueReusableCell(
                withIdentifier: WiFiSettingsViewController.reuseIdentifier,
                for: indexPath)

            // network cell
            if item.isNetwork {
                cell.textLabel?.text = item.title
                cell.accessoryType = .detailDisclosureButton
                cell.accessoryView = nil

            // configuration cells
            } else if item.isConfig {
                cell.textLabel?.text = item.title
                if item.type == .wifiEnabled {
                    let enableWifiSwitch = UISwitch()
					enableWifiSwitch.isOn = self.wifiController.isWifiEnabled
                    enableWifiSwitch.addTarget(self, action: #selector(self.toggleWifi(_:)), for: .touchUpInside)
                    cell.accessoryView = enableWifiSwitch
                } else {
                    cell.accessoryView = nil
                    cell.accessoryType = .detailDisclosureButton
                }
            } else {
                fatalError("Unknown item type!")
            }
            return cell
        }
        self.dataSource.defaultRowAnimation = .fade
    }
}

extension WiFiSettingsViewController {

    func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: WiFiSettingsViewController.reuseIdentifier)
    }

    @objc
    func toggleWifi(_ wifiEnabledSwitch: UISwitch) {
		wifiController.toggleWifi(enabled: wifiEnabledSwitch.isOn)
		wifiController.scanForNetworks(enabled: wifiEnabledSwitch.isOn)
    }
	
}

extension WiFiSettingsViewController: WifiPresenterDelegate {
	
	func wifiPresenterDidUpdate(_: WifiPresenter, wifiEnabled: Bool, configItem: NetworkViewModel, connectedNetwork: NetworkViewModel?, avaialbleNetworks: [NetworkViewModel]?) {
		
		currentSnapshot = NSDiffableDataSourceSnapshot<Section, NetworkViewModel>()
		currentSnapshot.appendSections([.config])
		currentSnapshot.appendItems([configItem])
		
		if let connectedNetwork = connectedNetwork {
			currentSnapshot.appendItems([connectedNetwork])
		}
		
		if let availableNetworks = avaialbleNetworks {
			currentSnapshot.appendSections([.networks])
			currentSnapshot.appendItems(availableNetworks)
		}
		
		self.dataSource.apply(currentSnapshot, animatingDifferences: !firstShow && self.isVisible)
		firstShow = false
	}
}

extension WiFiSettingsViewController {
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		self.isVisible = true
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		self.isVisible = false
	}
}
