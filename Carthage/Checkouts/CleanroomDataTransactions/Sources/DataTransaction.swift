//
//  DataTransaction.swift
//  CleanroomDataTransactions
//
//  Created by Evan Maloney on 7/21/15.
//  Copyright © 2015 Gilt Groupe. All rights reserved.
//

/**
 Represents the possible outcomes of executing a given `DataTransaction`.
 */
public enum TransactionResult<DataType, MetadataType>
{
    /** Represents the result of a successfully executed transaction.
     The case includes the data and metadata returned by the transaction. */
    case Succeeded(DataType, MetadataType)

    /** Represents the result of a failed executed transaction.
     The case includes a `DataTransactionError` representing the problem. */
    case Failed(DataTransactionError)
}

/**
 An interface for an asynchronously-executing data transaction.
 */
public protocol DataTransaction
{
    /** The data type returned by a successful transaction. */
    typealias DataType

    /** The metadata type returned along with a successful transaction. */
    typealias MetadataType

    /** The result type passed to the transaction completion callback 
     function. */
    typealias Result = TransactionResult<DataType, MetadataType>

    /** The signature of the callback function passed to 
     `executeTransaction()`. */
    typealias Callback = (Result) -> Void

    /**
     Causes the transaction to be executed. The transaction may be performed
     asynchronously. When complete, the `Result` is reported to the `Callback`
     function.
     
     - parameter completion: A function that will be called upon completion
     of the transaction.
     */
    func executeTransaction(completion: Callback)
}
