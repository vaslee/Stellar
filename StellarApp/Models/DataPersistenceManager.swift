//
//  DataPersistenceManager.swift
//  StellarApp
//
//  Created by Ramu on 4/12/19.
//  Copyright © 2019 TingxinLi. All rights reserved.
//

import Foundation

final class DataPersistenceManger {
    static public func documentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    static public func filepathToDocumentsDirectory(filename: String) -> URL {
        return documentsDirectory().appendingPathComponent(filename)
    }
}
