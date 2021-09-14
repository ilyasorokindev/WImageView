import UIKit
import WImage

public class WImageView: UIImageView {
    
    private var item: WItem?
    private var needUpdateImage = false
    
    public override var frame: CGRect {
        get {
            super.frame
        } set {
            if super.frame.size != newValue.size && self.item != nil {
                super.frame = newValue
                self.setNeedsUpdateImage()
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
            self.setNeedsUpdateImage()
        }
    }
    
    @IBInspectable public var filter: String? {
        didSet {
            if self.filter != oldValue {
                self.setNeedsUpdateImage()
            }
        }
    }
    
    func setNeedsUpdateImage() {
        if self.needUpdateImage {
            return
        }
        self.needUpdateImage = true
        DispatchQueue.main.async {
            self.updateImage()
            self.needUpdateImage = false
        }
    }
    
    private func updateImage() {
        if let path = self.imagePath {
            self.item = WImage.shared.load(path: path, width: self.frame.width, height: self.frame.height, filter: self.filter, priority: .normal) {  [weak self] image in
                self?.image = image
            }
        } 
    }
}
