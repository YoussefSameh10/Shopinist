//
//  NetworkReachability.swift
//  Shopinist
//
//  Created by Youssef on 6/22/22.
//  Copyright © 2022 MAD 42. All rights reserved.
//

import Foundation
import Network

class NetworkReachability {

    @available(iOS 12.0, *)

    class func monitorNetwork(){

        let monitor = NWPathMonitor()

        monitor.pathUpdateHandler = { path in

            //this closure get called every time connection state changes

            if path.status != .unsatisfied {

                //publish connected notf

                DispatchQueue.main.async {

                NotificationCenter.default.post(Notification.init(name: Notification.Name("ConnectedToNetwork")))

                print("We're connected!")

                }

            } else {

                //publish not Connected notf

                DispatchQueue.main.async {

                    NotificationCenter.default.post(Notification.init(name: Notification.Name("DisconnectedFromNetwork")))

                    print("No connection.")

                }

            }

        }

        let queue = DispatchQueue(label: "Monitor")

        monitor.start(queue: queue)

    }

}
