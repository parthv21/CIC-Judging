//
//  AssetsFetcher.swift
//  CIC Judging
//
//  Created by Parth Tamane on 03/03/20.
//  Copyright © 2020 Parth Tamane. All rights reserved.
//

import Foundation
import UIKit
import Firebase

func fetchImage(url: String, completion: @escaping (UIImage) -> ()) {
    let imageUrl = URL(string: url)
    if let imageUrl = imageUrl {
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: imageUrl)
                if let fetchedImage = UIImage(data: data) {
                    completion(fetchedImage)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
