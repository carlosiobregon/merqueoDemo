//
//  IConnectionStatusListener.swift
//  MerqueoDemo
//
//  Created by Carlos Obregón on 7/02/21.
//

import Foundation

protocol IConnectionStatusListener {
    func onChangeNetStatus(isConnected: Bool)
}
