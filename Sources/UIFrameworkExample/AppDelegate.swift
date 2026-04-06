//
//  AppDelegate.swift
//  ui-framework
//
//  Created by Fang Ling on 2026/3/22.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import FoundationFramework
import UIFramework

@available(macOS 13.3.0, *)
class MainViewController: ViewController {
  lazy var label = Label(frame: .init(x: 36, y: 48, width: 360, height: 480))
  lazy var button = Button(type: .system)

  override func viewDidLoad() {
    super.viewDidLoad()

    setupLabel()
    setupButton()
  }

  func setupLabel() {
//    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = String("Hello, 🌍!")

    view.addSubview(label)

//    LayoutConstraint.activate([
//      label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//      label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50)
//    ])
  }

  func setupButton() {
//    button.translatesAutoresizingMaskIntoConstraints = false
    button.frame = .init(x: 36, y: 58, width: 360, height: 580)
    button.setTitle(String("Click me!"), for: .normal)
    button.addAction(
      Action(handler: { [weak self] _ in
        self?.label.text = String("You clicked me!")
      }),
      for: .touchUpInside
    )

    view.addSubview(button)

//    LayoutConstraint.activate([
//      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//      button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 50)
//    ])
  }
}

@available(macOS 13.3.0, *)
@main @MainActor final class AppDelegate: ApplicationDelegate {
  var window: Window?

  func applicationDidFinishLaunching() {
    let viewController = MainViewController()
//    viewController.view.translatesAutoresizingMaskIntoConstraints = false

    window = Window(frame: Screen.main.bounds)
    window?.rootViewController = viewController
    window?.makeKeyAndVisible()
  }

  static func main() {
    ApplicationMain(delegate: AppDelegate())
  }
}
