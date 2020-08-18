//
//  ConcentratitionThemeChooserViewController.swift
//  Concentration
//
//  Created by Kaloyan Simeonov on 29.05.20.
//  Copyright © 2020 Kaloyan Simeonov. All rights reserved.
//

import UIKit

class ConcentratitionThemeChooserViewController: UIViewController {
    
    private lazy var themes = ThemesProvider()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle {
                let theme = themes.getTheme(name: themeName)
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                }
            }
            
        }
    }
    

}
