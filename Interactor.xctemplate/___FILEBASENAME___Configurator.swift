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

class ___VARIABLE_productName:identifier___Configurator {
    
    static func configure(viewController: ___VARIABLE_productName:identifier___ViewController) {
        
        let worker: ___VARIABLE_productName:identifier___Worker = ___VARIABLE_productName:identifier___Worker()
        let presenter: ___VARIABLE_productName:identifier___Presenter = ___VARIABLE_productName:identifier___Presenter()
        presenter.output = viewController
        
        let router: ___VARIABLE_productName:identifier___Router = ___VARIABLE_productName:identifier___Router()
        router.parentController = viewController
        
        let interactor: ___VARIABLE_productName:identifier___Interactor = ___VARIABLE_productName:identifier___Interactor()
        interactor.output = presenter
        interactor.worker = worker
        
        viewController.interactor = interactor
        viewController.router = router
        
    }
}
