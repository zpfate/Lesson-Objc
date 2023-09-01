//
//  XCUITEST.swift
//  XCUITEST
//
//  Created by Twisted Fate on 2023/9/1.
//

import XCTest

final class XCUITEST: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication(bundleIdentifier: "com.apple.shortcuts")
        app.launch()

        let btns = app.buttons["批量一键发送"]
        let edit = btns.buttons.element(boundBy: 0)
        edit.tap()
        
        let textviews = app.textViews
        
        let phone = textviews.element(boundBy: 2)
        phone.tap()
        phone.typeText("+17204214188\n+17204724360\n")
        
//        let done = app.buttons["完成"]
//        XCTAssertTrue(done.waitForExistence(timeout: 10), "按钮未出现")

        let firstButton = app.navigationBars.buttons["完成"]
        firstButton.tap()
        
        
        btns.tap()

        app.waitForExistence(timeout: 3)
        
        let textview = app.windows.textViews["文本"]
        textview.typeText("this is a test")
        
        let send = app.buttons["完成"]
        send.tap()
        
        
//        let newBtns = app.buttons
//        print("======\(newBtns.count)")
//
//        newBtns.element(boundBy: newBtns.count - 1).tap()

        // 输入短信文本
//        let textviews = app.textViews
//        let messageTextView = textviews.element(boundBy: 1) // 捷径 App 中的文本视图
//        messageTextView.tap()
//        messageTextView.typeText("12345678") // 替换为实际的文本


        
        
        
        // 打开信息 App，假设按钮上有 "消息" 文字
//              app.buttons["消息"].tap() // "消息" 是中文界面的标签
//
//              // 点击写新信息按钮（可以根据实际情况修改标识符）
//              app.buttons["新信息"].tap() // "新信息" 是中文界面的标签
//
//              // 输入多个手机号，以逗号分隔
//              let phoneNumberTextField = app.textFields["收件人"]
//              phoneNumberTextField.tap()
//              phoneNumberTextField.typeText("1234567890,9876543210") // 替换为实际的手机号，用逗号分隔
//
//              // 输入短信文本
//              let messageTextView = app.textViews.element(boundBy: 0) // 捷径 App 中的文本视图
//              messageTextView.tap()
//              messageTextView.typeText("你好，这是一条测试消息。") // 替换为实际的文本
//
//              // 发送短信
//              app.buttons["发送"].tap() // "发送" 是中文界面的标签

              // 在这里添加验证步骤，以确保短信已成功发送
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            
//            let app = XCUIApplication()
////            app.launch()
//
//            // 打开信息 App，假设按钮上有 "消息" 文字
//                  app.buttons["消息"].tap() // "消息" 是中文界面的标签
//
//                  // 点击写新信息按钮（可以根据实际情况修改标识符）
//                  app.buttons["新信息"].tap() // "新信息" 是中文界面的标签
//
//                  // 输入多个手机号，以逗号分隔
//                  let phoneNumberTextField = app.textFields["收件人"]
//                  phoneNumberTextField.tap()
//                  phoneNumberTextField.typeText("1234567890,9876543210") // 替换为实际的手机号，用逗号分隔
//
//                  // 输入短信文本
//                  let messageTextView = app.textViews.element(boundBy: 0) // 捷径 App 中的文本视图
//                  messageTextView.tap()
//                  messageTextView.typeText("你好，这是一条测试消息。") // 替换为实际的文本
//
//                  // 发送短信
//                  app.buttons["发送"].tap() // "发送" 是中文界面的标签
//            
            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
        }
    }
}
