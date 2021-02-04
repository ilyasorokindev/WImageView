import UIKit
import WImage

public class WImageView: UIImageView {
    
    private var item: WItem?
    
    public override var frame: CGRect {
        get {
            super.frame
        } set {
            if super.frame.size != newValue.size && self.item != nil {
                super.frame = newValue
                self.updateImage()
            } else {
                super.frame = newValue
            }
        }
    }
    
    @IBInspectable public var imagePath: String? {
        didSet {
            if self.imagePath == self.item?.path {
                return
            }
            if let item = self.item {
                WImage.shared.cancel(item: item)
                self.item = nil
            }
            self.image = nil
            self.updateImage()
        }
    }
    
    private func updateImage() {
        if let path = self.imagePath {
            self.item = WImage.shared.load(path: path, width: self.frame.width, height: self.frame.height, priority: .normal) {  [weak self] image in
                self?.image = image
            }
        } 
    }
}
