/*
 *  AppDelegate.m
 *  ui-kit
 *
 *  Created by Fang Ling on 2026/3/22.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

#import "AppDelegate.h"

#import "ViewController.h"

C_ASSUME_NONNULL_BEGIN

@interface AppDelegate()

@property (nonatomic) UIWindow* window;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching {
  let viewController = [[ViewController alloc] init];
  ////    viewController.view.translatesAutoresizingMaskIntoConstraints = false
  
  self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
  self.window.rootViewController = viewController;
  [self.window makeKeyAndVisible];
}

@end

C_ASSUME_NONNULL_END

//@available(macOS 13.3.0, *)
//class MainViewController: ViewController {
//  lazy var button = Button(type: .system)
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//
//    setupButton()
//  }
//
//  func setupButton() {
////    button.translatesAutoresizingMaskIntoConstraints = false
//    button.frame = .init(x: 36, y: 58, width: 360, height: 580)
//    button.setTitle(String("Click me!"), for: .normal)
//    button.addAction(
//      Action(handler: { [weak self] _ in
//        self?.label.text = String("You clicked me!")
//      }),
//      for: .touchUpInside
//    )
//
//    view.addSubview(button)
//
////    LayoutConstraint.activate([
////      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
////      button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 50)
////    ])
//  }
//}
