//
//  TransportHomeModels.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2022/03/28.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum TransportHome {
    enum Request {
        struct OnLoad {}
        struct OnGoBack {}
        struct OnRideConfirmButton {}
        struct OnViewDidDismiss {}
    }
    
    enum Response: Equatable {
        case ridePrice(Double)
        case superPayBalance(Double)
    }
    
    enum ViewModel {
        struct RidePrice {
            let text: String
        }

        struct SuperPayBalance {
            let text: String
        }
    }
}
