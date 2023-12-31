import UIKit

struct LoginViewModelFactory {
    
    // MARK: - Functions
    
    static func create() -> LoginViewModel {
        return LoginViewModel(backgroundColor: Theme.Color.primaryLight,
                              buttonModel: createButtonModel(),
                              contentStackModel: createContentStackModel(),
                              emailTextEntryModel: createEmailTextEntryModel(),
                              formStackModel: createFormStackModel(),
                              imageModel: createImageModel(),
                              passwordTextEntryModel: createPasswordTextEntryModel(),
                              titleModel: createTitleModel())
    }
    
    // MARK: Private
    
    private static func createButtonModel() -> LoginButtonModel {
        return LoginButtonModel(backgroundColor: Theme.Color.primary,
                                cornerRadius: 6,
                                disabledBackgroundColor: Theme.Color.silver,
                                height: 44,
                                highlightedBackgroundColor: Theme.Color.primaryDark,
                                title: NSLocalizedString("LOG IN", comment: "Login Form - CTA Title Text"),
                                titleColor: Theme.Color.labelWhite,
                                titleFont: UIFont.systemFont(ofSize: 16, weight: .semibold))
    }
    
    private static func createContentStackModel() -> LoginStackModel {
        let topInset: CGFloat = DeviceInfo.safeAreaTopInset + 34
        
        return LoginStackModel(alignment: .leading,
                               axis: .vertical,
                               edgeInsets: UIEdgeInsets(top: topInset, left: 24, bottom: 24, right: 24),
                               spacing: 30)
    }
    
    private static func createEmailTextEntryModel() -> LoginTextEntryViewModel {
        let titleText: String = NSLocalizedString("Email", comment: "Login Form - Row Title Text")
        let placeholderText: String = NSLocalizedString("enter email", comment: "Login Form - TextField Placeholder Text")
        
        return createTextEntryViewModel(titleText: titleText, placeholderText: placeholderText)
    }
    
    private static func createFormStackModel() -> LoginStackModel {
        return LoginStackModel(alignment: .leading, axis: .vertical, edgeInsets: .zero, spacing: 12)
    }
    
    private static func createImageModel() -> LoginImageModel {
        return LoginImageModel(contentMode: .scaleAspectFit,
                               height: 32,
                               name: "ScreenSafeFutureColor")
    }
    
    private static func createPasswordTextEntryModel() -> LoginTextEntryViewModel {
        let titleText: String = NSLocalizedString("Password", comment: "Login Form - Row Title Text")
        let placeholderText: String = NSLocalizedString("enter password", comment: "Login Form - TextField Placeholder Text")
        
        return createTextEntryViewModel(titleText: titleText, placeholderText: placeholderText, secureTextFieldTextEntry: true)
    }
    
    private static func createTitleModel() -> LoginTextModel {
        return LoginTextModel(font: UIFont.systemFont(ofSize: 26, weight: .bold),
                              numberOfLines: 2,
                              text: NSLocalizedString("Enter email\nand password", comment: "Login Form - Title Text"),
                              textColor: .black)
    }
    
    private static func createTextEntryViewModel(titleText: String, placeholderText: String, secureTextFieldTextEntry: Bool = false) -> LoginTextEntryViewModel {
        let shadowViewModel: ShadowViewModel = .init(color: UIColor.primaryShadowColor,
                                                     offset: CGSize(width: 1, height: 1),
                                                     opacity: 0.1,
                                                     radius: 1)
        
        let textFieldModel: LoginTextEntryTextFieldModel = .init(autocapitalizationType: .none,
                                                                 autocorrectionType: .no,
                                                                 backgroundColor: UIColor.secondaryBackgroundColor,
                                                                 cornerRadius: 4,
                                                                 font: UIFont.systemFont(ofSize: 16, weight: .regular),
                                                                 padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
                                                                 placeholderText: placeholderText,
                                                                 placeholderTextColor: UIColor.secondaryTextColor,
                                                                 isSecureTextEntry: secureTextFieldTextEntry,
                                                                 shadowModel: shadowViewModel,
                                                                 textColor: UIColor.primaryTextColor)
        
        let titleModel: LoginTextModel = .init(font: UIFont.systemFont(ofSize: 14, weight: .medium),
                                               numberOfLines: 1,
                                               text: titleText,
                                               textColor: UIColor.primaryTextColor)
        
        let stackModel: LoginStackModel = .init(alignment: .leading,
                                                axis: .vertical,
                                                edgeInsets: .zero,
                                                spacing: 8)
        
        return LoginTextEntryViewModel(textFieldModel: textFieldModel,
                                       titleModel: titleModel,
                                       spacing: 8,
                                       stackModel: stackModel)
    }

}
