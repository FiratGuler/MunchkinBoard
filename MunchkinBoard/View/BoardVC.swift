//
//  BoardVC.swift
//  MunchkinBoard
//
//  Created by Fırat Güler on 1.06.2024.
//

import UIKit

class BoardVC: UIViewController {
    
    
    
    var containerView: UIView!
    var imageView: UIImageView!
    var label: UILabel!
    var charArray = [SetupCharacter]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Board")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        for (index,char) in charArray.enumerated() {
            let containerView = createChar(char: char, position: CGPoint(x: 100 + index * 95, y: 100))
            self.view.addSubview(containerView)
        }
    }
    
    func createChar(char:SetupCharacter , position : CGPoint) -> UIView {
        
        guard let image = UIImage(named: char.imageName) else {return UIView()}
        let imageView = UIImageView(image: image)
        imageView.isUserInteractionEnabled = true
        imageView.frame = CGRect(x: 0, y: 30, width: 100, height: 100)
        
        let label = UILabel()
        label.text = char.name
        label.textColor = .white
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        
        let containerView = UIView(frame: CGRect(x: position.x,
                                                 y: position.y,
                                                 width: 100,
                                                 height: 130))
        containerView.addSubview(label)
        containerView.addSubview(imageView)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        containerView.addGestureRecognizer(panGesture)
        
        return containerView
        
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        // Gesture'ın taşındığı yeni konumu belirle
        if let viewToMove = gesture.view {
            viewToMove.center = CGPoint(x: viewToMove.center.x + translation.x, y: viewToMove.center.y + translation.y)
            gesture.setTranslation(CGPoint.zero, in: view) // Translation'ı sıfırla
        }
    }
    
    
    
    
}
