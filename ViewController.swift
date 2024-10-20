
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infiniteScrollableView: UIView!
    var mainDataSource : List<Object>? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        

    }
    
    func initView(){
        ListHandler.shared.create(arr: makeObjects())
        mainDataSource = ListHandler.shared.head!
        ListHandler.shared.circular(mainDataSource!)
        imageView.image = UIImage(systemName: mainDataSource!.value!.image!)
        titleLabel.text = mainDataSource!.value!.name
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        self.infiniteScrollableView.addGestureRecognizer(swipeRight)

        let swipeleft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeleft.direction = .left
        self.infiniteScrollableView.addGestureRecognizer(swipeleft)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        let data : Object?
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
                mainDataSource = mainDataSource?.next!
                data = mainDataSource?.value!
                addTransition(type: .fromLeft)
                imageView.image = UIImage(systemName: data!.image!)
                titleLabel.text = data!.name
            case .down:
                break
            case .left:
                print("Swiped left")
                mainDataSource = mainDataSource?.previous
                data = mainDataSource?.value!
                addTransition(type: .fromRight)
                imageView.image = UIImage(systemName: data!.image!)
                titleLabel.text = data!.name
            case .up:
               break
            default:
                break
            }
        }
    }
    
    func makeObjects() -> [Object]{
        var objArr = [Object]()
        let obj1 = Object(name: "Doc", image: "doc.plaintext.fill")
        let obj2 = Object(name: "Square", image: "square.and.arrow.up.fill")
        let obj3 = Object(name: "Rectangle", image: "rectangle.portrait.and.arrow.right.fill")
        let obj4 = Object(name: "Pencil", image: "pencil.circle.fill")
        let obj5 = Object(name: "Folder", image: "folder.fill")
        objArr.append(obj1)
        objArr.append(obj2)
        objArr.append(obj3)
        objArr.append(obj4)
        objArr.append(obj5)
        return objArr
    }
    
    func addTransition(type:CATransitionSubtype){
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = type
        self.infiniteScrollableView.layer.add(transition, forKey: nil)
    }
    
}


@propertyWrapper struct Trimmable {
    var wrappedValue: String {
        didSet { wrappedValue = wrappedValue.replacingOccurrences(of: " ", with: "") }
    }

    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue.replacingOccurrences(of: " ", with: "")
    }
}


struct SampleObj{
    @Trimmable var name:String = ""
    @Trimmable var place:String = ""
}
