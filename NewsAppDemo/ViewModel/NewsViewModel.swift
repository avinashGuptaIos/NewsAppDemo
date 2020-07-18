//
//  NewsViewModel.swift
//  NewsAppDemo
//
//  Created by hasher on 18/07/20.
//  Copyright © 2020 Avinash. All rights reserved.
//

import Foundation

class NewsViewModel{
    
    var news: Box<[Article]> = Box([])
    
    func getNews() {
        
        ServiceManager.shared.methodType(requestType: GET_REQUEST, url: GET_NEWS(page: 1), completion: { (response, responseData, statusCode) in
            print("News response is \(response)")
        }) { (response, statusCode) in
            print("Something wrong happened \(response)")
        }
    }
    
//    //MARK: Get messages in small intervals
//    static func getMesagesFrom_Pred(needFreshCall: Bool, startIndex: Int, screenTitle: String ,predicate: NSPredicate, isAscending: Bool, currentList: [PersonalSpace.PersonalTableModel], aggregationCount: Int, noAggregationCountCallback: @escaping () -> (), noDataCallback: @escaping ( _ tableList: [PersonalSpace.PersonalTableModel]?) -> (), dbDataCallback: @escaping (_ tableList: [PersonalSpace.PersonalTableModel],_ msgList: [MyMessages], _ isThereNoMoreData: Bool) -> (), newPageCallback: @escaping ( _ tableList: [PersonalSpace.PersonalTableModel]?) -> ())
//    {
//        if aggregationCount == 0 {
//            noAggregationCountCallback()
//            return
//        }
//
//        let fetchSize = 10
//        let currentListCount = startIndex * fetchSize > aggregationCount ? aggregationCount : startIndex * fetchSize
//        let estimateCount = currentListCount + fetchSize > aggregationCount ? aggregationCount : currentListCount + fetchSize
//
//        var resultofdb1 = Manager.RealmManager.fetchObjectsWithEnableIdentitiesPredicate(pred: predicate)
//        resultofdb1 = resultofdb1?.sorted(byKeyPath: "lastUpdated", ascending: isAscending)
//        print("resultofdb1?.count",resultofdb1?.count)
//        if resultofdb1!.count == 0
//        {
//            noDataCallback(nil)
//        }
//        else if estimateCount <= resultofdb1!.count {
//            var msgGroups = [String]()
//            for i in currentListCount ..< estimateCount {
//                let msgObj = resultofdb1?[i] as! MyMessages
//                if msgObj.UId != nil{
//                    msgGroups.append(msgObj.group ?? "")
//                }
//            }
//
//            let groupPredicate = NSPredicate(format: "group IN %@",msgGroups)
//            var resultofdb2 = Manager.RealmManager.fetchObjectsWithEnableIdentitiesPredicate(pred: groupPredicate)
//            resultofdb2 = resultofdb2?.sorted(byKeyPath: "lastUpdated", ascending: isAscending)
//            //            let tableList = self.getMessagesinGroup(screenTitle: screenTitle, currentListCount: currentListCount, tempTableList: needFreshCall ? [PersonalSpace.PersonalTableModel]() : currentList, resultList: resultofdb2!, estimatedCount: needFreshCall ? resultofdb2!.count : resultofdb1!.count)
//
//            getMessagesinGroupForSmallIntervals(currentList: needFreshCall ? [PersonalSpace.PersonalTableModel]() : currentList, resultList:  resultofdb2!) { (tableList) in
//                var msgsArray = [MyMessages]()   //msgList is not getting used anywhere
//                for msgItem in resultofdb2! {
//                    if let msgItemAsRealmModel = msgItem as? MyMessages { msgsArray.append(msgItemAsRealmModel) }
//                }
//
//                dbDataCallback(tableList, msgsArray, estimateCount == aggregationCount)
//            }
//        }
//        else {
//            newPageCallback(nil)
//        }
//    }
}


