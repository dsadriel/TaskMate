import UIKit


// MARK: applyGradientMask
extension UIImageView {
    func applyGradientMask(colors: [UIColor]) {
        layoutIfNeeded() // força o layout antes de capturar bounds

        guard let image = self.image else {
            return
        }

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map(\.cgColor)
        gradientLayer.startPoint = CGPoint.zero
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = bounds

        let maskLayer = CALayer()
        maskLayer.contents = image.cgImage
        maskLayer.frame = bounds
        maskLayer.contentsGravity = .resizeAspect
        gradientLayer.mask = maskLayer

        layer.sublayers?.removeAll { $0.name == "gradientMask" }
        gradientLayer.name = "gradientMask"
        layer.addSublayer(gradientLayer)

        self.image = nil // remove a imagem original para mostrar só o gradiente mascarado
    }
}
