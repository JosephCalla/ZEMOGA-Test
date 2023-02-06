//
//  CGSize+ScaledSize.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 2/02/23.
//

import Foundation
import UIKit

extension CGSize {
    var scaledSize: CGSize {
        .init(width: width * UIScreen.main.scale, height: height * UIScreen.main.scale)
    }
}
