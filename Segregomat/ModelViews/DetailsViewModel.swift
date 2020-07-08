//
//  DetailsViewModel.swift
//  Segregomat
//
//  Created by Iga Hupalo on 03/07/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import Foundation
import SwiftUI


class DetailsViewModel: ObservableObject {
    var details: String

    init(details: String) {
        self.details = details
    }

    func openURL(textUrl: String) {
        guard let url = URL.init(string: textUrl), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }

    func getTexts(sourceText: String, texts: [TextResult]) -> [TextResult] {

        let urls = detectURLs(sourceText: sourceText)
        var texts = texts
        let sourceText = sourceText

        if(!urls.isEmpty) {
            var splits = (sourceText.components(separatedBy: urls[0]).flatMap { [$0, urls[0]] }.dropLast().filter { $0 != "" })

            if(urls.count > 1) {
                for urlIndex in 1...urls.count - 1 {
                    let lastSplit = splits[splits.count - 1]
                    splits.removeLast()
                    splits = splits + (lastSplit.components(separatedBy: urls[urlIndex]).flatMap { [$0, urls[urlIndex]] }.dropLast().filter { $0 != "" })
                }
            }
            for split in splits {
                if(urls.contains(split)) {
                    texts.append(TextResult(text: split, isURL: true))
                } else {

                    texts.append(TextResult(text: split.trimmingCharacters(in: CharacterSet.init(charactersIn: " .")), isURL: false))
                }
            }
            if(!texts[texts.count - 1].isURL) {
                texts[texts.count - 1].text = texts[texts.count - 1].text + "."
            }
        } else {
            texts.append(TextResult(text: sourceText, isURL: false))
        }
        return texts

    }

    func detectURLs(sourceText: String) -> [String]{
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: sourceText, options: [], range: NSRange(location: 0, length: sourceText.utf16.count))
        var urls = [String]()

        for match in matches {
            guard let range = Range(match.range, in: sourceText) else { continue }
            let url = sourceText[range]
            urls.append(String(url))
        }

        return urls
    }
}
