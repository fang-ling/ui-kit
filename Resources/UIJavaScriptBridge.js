//
//  UIJavaScriptBridge.js
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

export class UIJavaScriptBridge {
  static instance
  static memory
  static elements
  static eventListeners

  static initialize(instance, memory) {
    this.instance = instance
    this.memory = memory
    this.elements = new Map()
    this.eventListeners = new Map()
  }

  static readString(pointer, length) {
    const characters = new Uint32Array(
      this.memory.buffer,
      pointer,
      Number(length)
    )
    return String.fromCodePoint(...characters)
  }

  static getElement(id) {
    if (id === 0) {
      return document.body
    }

    return this.elements.get(id)
  }

  static updateElementText(id, text, textCount) {
    this.getElement(id).textContent = this.readString(text, textCount)
  }

  static initializeElement(htmlElementType, id, parentID) {
    const elementType = (() => {
      switch (htmlElementType) {
        case 1: return "div"
        case 2: return "span"
        case 3: return "button"
      }
    })()

    const element = document.createElement(elementType)
    if (id === 1 || id === 2) { // window or rootViewController
      element.className = "view-root"
    } else {
      element.className = "view"
    }
    element.style.setProperty("anchor-name", `--view-${id}`)
    element.dataset.viewIdentifier = id.toString()
    this.elements.set(id, element)

    document.body.appendChild(element)
  }

  static setStyleProperty(id, property, propertyCount, value, valueCount) {
    this.getElement(id)?.style.setProperty(
      this.readString(property, propertyCount),
      this.readString(value, valueCount)
    )
  }

  static addEventListener(htmlEventType, id) {
    const eventType = (() => {
      switch (htmlEventType) {
        case 1: return "click" // touchUpInside
      }
    })()

    const eventHandler = () => {
      this.instance.exports.UIJavaScriptBridge_HTMLElement_DispatchEvent(
        id,
        htmlEventType
      )
    }

    if (!this.eventListeners.has(id)) {
      this.eventListeners.set(id, new Map())
    }
    this.eventListeners.get(id).set(htmlEventType, eventHandler)

    this.elements.get(id)?.addEventListener(eventType, eventHandler)
  }
}
