//
//  CoinsMode;.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/3/11.
//

import Foundation

class CoinsModel {
    
    static let shared = CoinsModel() // 单例实例

    var coins: Observable<Int> {
        didSet {
            saveCoinsToUserDefaults()
        }
    }

    init(initialCoins: Int = 50) { // 设定一个默认值或者从UserDefaults加载
        let savedCoins = UserDefaults.standard.integer(forKey: coinsKey)
        coins = Observable(savedCoins >= 0 ? savedCoins : initialCoins)
        saveCoinsToUserDefaults()
    }

    func addCoins(_ amount: Int) {
        let currentCoins = coins.value ?? 0
        coins.value = currentCoins + amount
        saveCoinsToUserDefaults()
    }

    func spendCoins(_ amount: Int) {
        let newAmount = (coins.value ?? 0) - amount
        coins.value = newAmount >= 0 ? newAmount : 0
        saveCoinsToUserDefaults()
    }

    private func saveCoinsToUserDefaults() {
        UserDefaults.standard.set(coins.value, forKey: coinsKey)
    }

}
