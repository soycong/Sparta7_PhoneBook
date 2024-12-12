//
//  Untitled.swift
//  Sparta7_PhoneBook
//
//  Created by seohuibaek on 12/12/24.
//

import UIKit

class ImageConversionHelper {
    static func convertImageToString(_ image: UIImage) -> String? {
        guard let data = image.pngData() else { return nil }
        return data.base64EncodedString()
    }

    static func convertStringToImage(_ base64: String?) -> UIImage? {
        guard let base64 = base64,
              let data = Data(base64Encoded: base64, options: .ignoreUnknownCharacters) else {
            return UIImage(named: "ProfileImage") // 기본 이미지 반환
        }
        return UIImage(data: data)
    }
}
