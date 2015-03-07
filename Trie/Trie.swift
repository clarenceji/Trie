//
//  Trie.swift
//  Trie
//
//  Created by Neil Pankey on 3/6/15.
//  Copyright (c) 2015 Neil Pankey. All rights reserved.
//

public final class Trie<K: CollectionType, V where K.Generator.Element: Hashable> {
    private var value: V? = nil
    private var children: [K.Generator.Element: Trie<K, V>] = [:]

    public init() {
    }

    public func lookup(key: K) -> V? {
        return lookup(key, key.startIndex)
    }

    private func lookup(key: K, _ index: K.Index) -> V? {
        if index == key.endIndex {
            return value
        } else {
            let child = children[key[index]]
            return child?.lookup(key, index.successor())
        }
    }

    public func insert(key: K, _ value: V) {
        insert(key, key.startIndex, value)
    }

    private func insert(key: K, _ index: K.Index, _ value: V) {
        if index == key.endIndex {
            self.value = value
        } else {
            var child = children[key[index]]
            if child == nil {
                child = Trie()
                children[key[index]] = child
            }
            child!.insert(key, index.successor(), value)
        }
    }

    public func remove(key: K) {
        remove(key, key.startIndex)
    }

    private func remove(key: K, _ index: K.Index) {
        if index == key.endIndex {
            value = nil
        } else {
            // TODO Error if the key doesn't exist?
            let child = children[key[index]]
            child?.remove(key, index.successor())
        }
    }
}
