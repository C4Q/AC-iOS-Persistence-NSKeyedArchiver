//
//  DataModel.swift
//  DSA
//
//  Created by Alex Paul on 12/8/17.
//  Copyright © 2017 Alex Paul. All rights reserved.
//

import Foundation

class DataModel {
    
    static let kPathname = "DSAListKeyedArchiver.plist"
    
    // using a singleton to manage the model
    private init(){}
    static let shared = DataModel()
    
    private var lists = [DSA]() {
        didSet { // property observer does saving to persistence on changes
            saveDSAList()
        }
    }
    
    // returns documents directory path for app sandbox
    private func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // returns the path for supplied name from the dcouments directory
    private func dataFilePath(withPathName path: String) -> URL {
        return DataModel.shared.documentsDirectory().appendingPathComponent(path)
    }
    
    // save
    private func saveDSAList() {
        let path = DataModel.shared.dataFilePath(withPathName: DataModel.kPathname).path
        NSKeyedArchiver.archiveRootObject(lists, toFile: path)
        print(documentsDirectory())
    }
  
    // load 
    public func load() {
        let path = DataModel.shared.dataFilePath(withPathName: DataModel.kPathname).path
        if let results = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? [DSA] {
            lists = results
        }
    }
    
    // create
    public func addDSAItemToList(dsaItem item: DSA) {
        lists.append(item)
    }
    
    // read
    public func getLists() -> [DSA] {
        return lists
    }
    
    // update
    public func updateDSAItem(withUpdatedItem item: DSA) {
        if let index = lists.index(where: {$0 === item}) { // TODO: new??? identity comparison
            lists[index] = item
        }
    }
    
    // delete
    public func removeDSAItemFromIndex(fromIndex index: Int) {
        lists.remove(at: index)
    }
}
