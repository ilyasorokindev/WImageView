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
        set {
            if newValue == self.item?.path {
                return
            }
            if let item = self.item {
                WImage.shared.cancel(item: item)
            }
            if let path = newValue {
                self.item = WImage.shared.load(path: path)
            } else {
                self.item = nil
            }
            self.updateImage()
        }
        get {
            return self.item?.path
        }
    }
    
    private func updateImage() {
        if let path = self.imagePath {
            WImage.shared.load(path: path, width: self.frame.width, height: self.frame.height, priority: .normal) {  [weak self] image in
                self?.image = image
            }
        } else {
            self.image = nil
        }
    }
}
