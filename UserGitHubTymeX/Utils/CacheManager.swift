//
//  CacheManager.swift
//  UserGitHubTymeX
//
//  Created by Hổ's Macbook on 03/10/2024.
//

import Foundation

/// CacheManager: A singleton class for managing in-memory caching.
/// Uses NSCache for thread-safe caching of objects.
/// Provides methods to set, get, remove, and clear cached items.
class CacheManager {
    static let shared = CacheManager()
    private let cache = NSCache<NSString, AnyObject>()
    
    private init() {}
    
    func set<T: AnyObject>(_ object: T, forKey key: String) {
        cache.setObject(object, forKey: key as NSString)
    }
    
    func get<T: AnyObject>(forKey key: String) -> T? {
        return cache.object(forKey: key as NSString) as? T
    }
    
    func remove(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }
    
    func removeAll() {
        cache.removeAllObjects()
    }
}
