//
//  ViewController.swift
//  RxSwiftExample1
//
//  Created by Hoff Henry Pereira da Silva on 27/08/19.
//  Copyright © 2019 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit
import RxSwift

class MainViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    let disposeBag = DisposeBag()
    
    let typpedStringPublishSubject = PublishSubject<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        self.textField.addTarget(self, action: #selector(MainViewController.startObservable(_:)), for: .editingChanged)
    }

    @objc private func startObservable(_ textField: UITextField ) {
        typpedStringPublishSubject.onNext(textField.text ?? "")
    }

}

extension MainViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        typpedStringPublishSubject.subscribe(onNext: {
            self.label.text = $0
        }).disposed(by: disposeBag)
    }
    
}

