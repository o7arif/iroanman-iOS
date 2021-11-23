//
//  SmartPermission.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 11/24/21.
//

import SPPermissions

class SmartPermission {

    static let instance = SmartPermission()
    var completion: ((Bool) -> Void)?
    
    private init() {}
    
    func askFor(permissions: [SPPermissions.Permission], vc: UIViewController, completion: @escaping (Bool) -> ()) {
        
        self.completion = completion
        var permission_required: [SPPermissions.Permission] = []
        var permission_denied: [SPPermissions.Permission] = []
        
        for permission in permissions {
            if permission.denied {
                permission_denied.append(permission)
            } else if permission.authorized {
                print(permission.localisedName, "is already granted")
            } else {
                permission_required.append(permission)
            }
        }
        
        
        let controller = SPPermissions.native(permission_required)
        controller.present(on: vc)
    }
    
    func askFor(permission: SPPermissions.Permission, vc: UIViewController, completion: @escaping (Bool) -> ()) {
        
        if permission.denied {
            let controller = SPPermissions.native([permission])
            controller.delegate = self
            controller.present(on: vc)
            completion(false)
            return
        } else if permission.authorized {
            print(permission.debugName, "is already granted")
            completion(true)
            return
        } else {
            let controller = SPPermissions.native([permission])
            controller.delegate = self
            controller.present(on: vc)
        }
        self.completion = completion
    }
}

extension SmartPermission: SPPermissionsDelegate {

    func didHidePermissions(_ permissions: [SPPermissions.Permission]) {
//        for permission in permissions{
//            print("didHidePermissions", permission.localisedName)
//        }
//        if self.completion != nil{
//            self.completion!(false)
//        }
    }

    func didAllowPermission(_ permission: SPPermissions.Permission) {
        print("didAllowPermission", permission.debugName)
        if self.completion != nil {
            self.completion!(true)
        }
    }

    func didDeniedPermission(_ permission: SPPermissions.Permission) {
        print("didDeniedPermission", permission.debugName)
        if self.completion != nil {
            self.completion!(false)
        }
    }
}
