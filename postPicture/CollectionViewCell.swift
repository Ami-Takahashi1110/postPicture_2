//
//  CollectionViewCell.swift
//  postPicture
//
//  Created by USER on 2023/05/07.
//

import UIKit
import FirebaseStorage

class CollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // 参照の作成
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageRef = storageRef.child("images/example.jpg")
        // ダウンロード先のファイルURLを取得する
        imageRef.downloadURL { (url, error) in
            if let error = error {
                // ダウンロード中にエラーが発生した場合の処理
                print("ダウンロードエラー: \(error.localizedDescription)")
            } else {
                // ダウンロードが成功した場合の処理
                if let downloadURL = url {
                    // ダウンロードしたファイルのURLを使用して、イメージを表示するなどの処理を行う
                    // UIImageViewにイメージを設定する
                    DispatchQueue.main.async {
                        cell.imageView.sd_setImage(with: downloadURL, completed: nil)
                    }
                }
            }
        }
        
    }
    

}
