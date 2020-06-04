//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//  Modify By:  * Yaffi Azmi
//              * yaffiazmi.dev@gmail.com
//              * https://github.com/yaffiazmidev
//

import UIKit

class ___VARIABLE_productName:identifier___ViewController: UIViewController {
    
	var interactor: ___VARIABLE_productName:identifier___InteractorInput?
	var router: ___VARIABLE_productName:identifier___RouterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        ___VARIABLE_productName:identifier___Configurator.configure(viewController: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        ___VARIABLE_productName:identifier___Configurator.configure(viewController: self)
    }
}

extension ___VARIABLE_productName:identifier___ViewController: ___VARIABLE_productName:identifier___PresenterOutput {
	// do someting...
}

extension ___VARIABLE_productName:identifier___ViewController {
	// do someting...
}
