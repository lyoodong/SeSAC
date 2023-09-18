//
//  ViewController.swift
//  LoginExample
//
//  Created by Dongwan Ryoo on 2023/09/12.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let viewModel = ViewModel()
    lazy var idTextField: UITextField = {
        let view = UITextField()
        view.backgroundColor = .mainGreen
        view.placeholder = "이메일 또는 전화번호"
        view.textAlignment = .center
        view.textColor = .white
        view.layer.cornerRadius = 5
        
        return view
    }()
    
    lazy var pwTextField: UITextField = {
        let view = UITextField()
        view.backgroundColor = .mainGreen
        view.placeholder = "비밀번호"
        view.textAlignment = .center
        view.textColor = .white
        view.layer.cornerRadius = 5
        
        return view
    }()
    
    lazy var nickNameTextField: UITextField = {
        let view = UITextField()
        view.backgroundColor = .mainGreen
        view.placeholder = "닉네임"
        view.textAlignment = .center
        view.textColor = .white
        view.layer.cornerRadius = 5
        
        return view
    }()
    
    lazy var referralCodeTextField: UITextField = {
        let view = UITextField()
        view.backgroundColor = .mainGreen
        view.placeholder = "추천 코드"
        view.textAlignment = .center
        view.textColor = .white
        view.layer.cornerRadius = 5
        view.keyboardType = .numberPad
        
        return view
    }()
    
    lazy var confirmButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .gray
        view.setTitle("회원가입", for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        view.setTitleColor(.black, for: .normal)
        view.layer.cornerRadius = 5
        
    
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [idTextField,
         pwTextField,
         nickNameTextField,
         referralCodeTextField,
         confirmButton].forEach {
            view.addSubview($0)
        }
        constraints()
        setValue()
        addTarget()
        idTextField.text = UserDefaults.standard.string(forKey: "id")!
    }
    
    func constraints() {
        
        let spacing:CGFloat = 16
        
        idTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view).inset(spacing)
            make.height.equalTo(50)
            make.top.equalTo(200)
        }
        
        pwTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view).inset(spacing)
            make.height.equalTo(50)
            make.top.equalTo(idTextField.snp.bottom).offset(spacing)
        }
        
        nickNameTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view).inset(spacing)
            make.height.equalTo(50)
            make.top.equalTo(pwTextField.snp.bottom).offset(spacing)
        }
        
        referralCodeTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view).inset(spacing)
            make.height.equalTo(50)
            make.top.equalTo(nickNameTextField.snp.bottom).offset(spacing)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view).inset(spacing)
            make.height.equalTo(50)
            make.top.equalTo(referralCodeTextField.snp.bottom).offset(spacing)
        }
    }
    
    func setValue() {
        viewModel.id.bind { result in
            self.idTextField.text = result
        }
        
        viewModel.pw.bind { result in
            self.pwTextField.text = result
        }
        
        viewModel.nickname.bind { result in
            self.nickNameTextField.text = result
        }
        
        viewModel.referralCode.bind { result in
            self.referralCodeTextField.text = String(result)
        }
    }
    
    func addTarget() {
        idTextField.addTarget(self, action: #selector(idTextFieldChanged), for: .editingChanged)
        pwTextField.addTarget(self, action: #selector(pwTextFieldChanged), for: .editingChanged)
        nickNameTextField.addTarget(self, action: #selector(nicknameTextFieldChanged), for: .editingChanged)
        referralCodeTextField.addTarget(self, action: #selector(phoneNumberTextFieldChanged), for: .editingChanged)
        confirmButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
    }
    
    @objc
    func idTextFieldChanged() {
        viewModel.id.value = idTextField.text ?? ""
    }
    
    @objc
    func pwTextFieldChanged() {
        viewModel.pw.value = pwTextField.text ?? ""
    }
    
    @objc
    func nicknameTextFieldChanged() {
        viewModel.nickname.value = nickNameTextField.text ?? ""
    }
    
    @objc
    func phoneNumberTextFieldChanged() {
        viewModel.referralCode.value = referralCodeTextField.text ?? ""
    }
    
    @objc
    func loginButtonClicked() {
        showErrorMassage()

        viewModel.autoID {
            if self.viewModel.isValid.value == true {
                print("로그인 성공")
            } else {
                print("로그인 실패")
            }
        }
    }
    
    func showAlert(title: String) {
        let alert = UIAlertController(title: "로그인 실패!", message: title, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    func showErrorMassage() {
        do {
            try viewModel.checkValidation()
        } catch {
            switch error {
            case loginError.id:
                showAlert(title: "아이디에는 반드시 @을 포함해주세요.")
            case loginError.password:
                showAlert(title: "비밀번호는 7자 이상 10자 이하로 입력해주세요.")
            case loginError.nickname:
                showAlert(title: "닉네임은 필수 입력입니다!")
            case loginError.referralCode:
                showAlert(title: "추천 코드는 6자 입니다.")
            default:
                print("알 수 없는 에러")
            }
        }
    }
}

extension UIColor {
    static var mainGreen: UIColor {
        return UIColor(red: 111/255.0, green: 207/255.0, blue: 151/255.0, alpha: 1.0)
    }
}

