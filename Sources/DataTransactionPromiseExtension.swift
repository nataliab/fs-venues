//
//  DataTransactionPromiseExtension.swift
//  AppleTart
//
//  Created by Evan Maloney on 5/5/16.
//  Copyright © 2016 Gilt Groupe. All rights reserved.
//

import Foundation
import PromiseKit
import CleanroomDataTransactions

extension DataTransaction
{
    public func promise()
        -> Promise<Self.DataType>
    {
        return Promise() { fulfill, reject in
            let callback: (TransactionResult<Self.DataType, Self.MetadataType>) -> Void = { result in
                switch result {
                case .Succeeded(let data, _):
                    fulfill(data)

                case .Failed(let err):
                    reject(err)
                }
            }

            self.executeTransaction(callback as! Self.Callback)
        }
    }
}
