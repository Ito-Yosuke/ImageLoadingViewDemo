//
//  ViewController.swift
//  Sandbox
//
//  Created by Yosuke Ito on 2023/06/14.
//

import UIKit

typealias IconListType = (iconImage: UIImage?, iconName: String)

class ViewController: UIViewController {
    @IBOutlet weak var iconTableView: UITableView!
    
    let iconNameList: [String] = [
        "bookmark",
        "shift",
        "eject",
        "seal",
        "heart",
        "none",
        "crop",
        "pencil",
        "clear",
        "phone",
        "cart",
        "scroll",
        "mic",
        "bolt",
        "tag",
        "message",
        "chevron.right",
        "envelope",
        "none2",
        "person",
        "cloud",
        "sunrise",
        "drop"
    ]
    
    // UITableViewのData
    var iconList = [IconListType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iconTableView.dataSource = self
        
        // 初期状態ではnilを入れておく
        // cellが読み込まれた段階でUIImageとして取得する
        iconList = iconNameList.map{(nil, $0)}
        
    }
    
    
}

// UITableViewDataSource
extension ViewController: UITableViewDataSource {
    // numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.iconList.count
    }
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "iconList", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        // サムネイルの取得
        if self.iconList[indexPath.row].iconImage == nil {
            // 擬似的に非同期処理を再現
            // 3.0秒後にUIImageをセット
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                if let iconImage = UIImage(systemName: self.iconList[indexPath.row].iconName) {
                    self.iconList[indexPath.row].iconImage = iconImage
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            }
        }
        
        // cellの中身を作成
        cell.configure(self.iconList[indexPath.row])
        
        return cell
    }
    
}

