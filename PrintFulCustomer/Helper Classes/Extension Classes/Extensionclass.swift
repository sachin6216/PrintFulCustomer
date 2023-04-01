import UIKit
// MARK: - Locale
extension Locale {
    static let currency: [String: (code: String?, symbol: String?)] = Locale.isoRegionCodes.reduce(into: [:]) {
        let locale = Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.countryCode.rawValue: $1]))
        $0[$1] = (locale.currencyCode, locale.currencySymbol)
    }
    func localizedCurrencySymbol(forCurrencyCode currencyCode: String) -> String? {
        guard let languageCode = languageCode, let regionCode = regionCode else { return nil }

        /*
         Each currency can have a symbol ($, £, ¥),
         but those symbols may be shared with other currencies.
         For example, in Canadian and American locales,
         the $ symbol on its own implicitly represents CAD and USD, respectively.
         Including the language and region here ensures that
         USD is represented as $ in America and US$ in Canada.
        */
        let components: [String: String] = [
            NSLocale.Key.languageCode.rawValue: languageCode,
            NSLocale.Key.countryCode.rawValue: regionCode,
            NSLocale.Key.currencyCode.rawValue: currencyCode,
        ]

        let identifier = Locale.identifier(fromComponents: components)

        return Locale(identifier: identifier).currencySymbol
    }
}
// MARK: - UIViewController
extension UIViewController {
    func showalertview(messagestring: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: messagestring, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
struct MyCurrency: Codable {
    let code: String
    let name: String
    let symbol: String
}
var currencies: [MyCurrency] {
    return Locale.availableIdentifiers.compactMap {
        guard let currencyCode = Locale(identifier: $0).currencyCode,
              let name = Locale.autoupdatingCurrent.localizedString(forCurrencyCode: currencyCode),
              let symbol = Locale(identifier: $0).currencySymbol  else { return nil }
        return MyCurrency(code: $0, name: name, symbol: symbol)
    }
}
// MARK: Data
extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            Logger.sharedInstance.logMessage(message: "error: \(error)")
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
