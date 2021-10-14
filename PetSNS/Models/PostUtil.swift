//
//  PostUtil.swift
//  PetSNS
//
//  Created by 坂本龍哉 on 2021/10/08.
//

import Foundation
import Firebase

final class PostUtil {
    
    let user = Auth.auth().currentUser
    
    func save(post: Post,
              completion: @escaping ResultHandler<Any?>) {
        guard let user = user else { return }
        let storeRef = Firestore.firestore().collection("users/\(user.uid)/posts/")
        let createdTime = FieldValue.serverTimestamp()
        let postData: [String: Any] = ["id": post.id,
                                       "text": post.text,
                                       "createdAt": createdTime]
        storeRef.addDocument(data: postData) { error in
            if let error = error {
                let message = self.firestoreErrorMessage(error)
                completion(.failure(message))
                return
            }
            completion(.success(nil))
        }
    }
    
    func saveData(postId: String,
                  data: Data,
                  completion: @escaping ResultHandler<Any?>) {
        guard let user = user else { return }
        let photosRef = Storage.storage().reference().child("users/\(user.uid)/posts/\(postId).jpg")
        let uploadTask = photosRef.putData(data, metadata: nil) { metadata, error in
            guard let metadata = metadata else {
                let message = self.storageErrorMessage(error)
                completion(.failure(message))
                return
            }
            completion(.success(nil))
            print(metadata)
        }
        uploadTask.resume()
    }
    
    private func firestoreErrorMessage(_ error: Error) -> String {
        if let errorCode = FirestoreErrorCode(rawValue: error._code) {
            switch errorCode {
            case .OK: return "操作は正常に完了しました。"
            case .cancelled: return "操作がキャンセルされました。"
            case .unknown: return "予期せぬエラーです。"
            case .invalidArgument: return "システムの状態に関わらず、問題のある引数を示します。"
            case .deadlineExceeded: return "時間内に操作が完了しませんでした。"
            case .notFound: return "要求されたドキュメントが見つかりません。"
            case .alreadyExists: return "既に存在しています。"
            case .permissionDenied: return "操作権限がありません。"
            case .resourceExhausted: return "容量が不足しています。"
            case .failedPrecondition: return "操作が拒否されました。"
            case .aborted: return "操作が中断されました。"
            case .outOfRange: return "無効な操作です。"
            case .unimplemented: return "この操作はサポートされていません。"
            case .internal: return "システムエラーです。"
            case .unavailable: return "現在このサービスは利用できません。"
            case .dataLoss: return "回復不可能なデータ損失が発生しました。"
            case .unauthenticated: return "有効な認証がありません。"
            default: return "未知のエラーです\(error)"
            }
        }
        return "不明なエラーが発生しました。"
    }
    
    private func storageErrorMessage(_ error: Error?) -> String {
        guard let error = error else { return "エラーはありません" }
        if let errorCode = StorageErrorCode(rawValue: error._code) {
            switch errorCode {
            case .unknown: return "不明なエラーが発生しました。"
            case .objectNotFound: return "オブジェクトが存在しません。"
            case .bucketNotFound: return "設定されているバケットはありません。"
            case .projectNotFound: return "プロジェクトがありません。"
            case .quotaExceeded: return "バケットのクオータが超過しました。"
            case .unauthenticated: return "認証してからやり直して下さい。"
            case .unauthorized: return "実行権限がありません。"
            case .retryLimitExceeded: return "操作の最大制限時間を超えました。"
            case .nonMatchingChecksum: return "チェックサムが一致しません。"
            case .downloadSizeExceeded: return "ダウンロードファイルのサイズがメモリ容量を超えています。"
            case .cancelled: return "キャンセルされました。"
            case .invalidArgument: return "無効な引数が指定されました。"
            default: return "不明なエラーが発生しました。"
            }
        }
        return "不明なエラーが発生しました。"
    }
}
