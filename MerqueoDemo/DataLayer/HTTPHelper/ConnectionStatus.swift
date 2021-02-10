//
//  ConnectionStatus.swift
//  MerqueoDemo
//
//  Created by Carlos Obregón on 7/02/21.
//

import UIKit

class ConnectionStatus {
    static let shared = ConnectionStatus()
    var iConnectionStatusListener: IConnectionStatusListener?
    
    var canConnectToServer = true {
        didSet{
            if oldValue != canConnectToServer {
                iConnectionStatusListener?.onChangeNetStatus(isConnected: canConnectToServer)
            }
        }
    }
    
}
