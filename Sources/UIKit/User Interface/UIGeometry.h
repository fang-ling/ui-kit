/*
 *  UIGeometry.h
 *  ui-kit
 *
 *  Created by Fang Ling on 2026/6/7.
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

#include <CKit/CKit.h>

C_ASSUME_NONNULL_BEGIN

/**
 * Constants that specify an edge or a set of edges, taking the user interface
 * layout direction into account.
 */
typedef enum UIDirectionalRectangleEdge: CUnsignedInteger32 {
  /**
   * No specified edge.
   */
  kUIDirectionalRectangleEdgeNone = 0,

  /**
   * The top edge.
   */
  kUIDirectionalRectangleEdgeTop = 1 << 0,

  /**
   * The leading edge.
   */
  kUIDirectionalRectangleEdgeLeading = 1 << 1,

  /**
   * The bottom edge.
   */
  kUIDirectionalRectangleEdgeBottom = 1 << 2,

  /**
   * The trailing edge.
   */
  kUIDirectionalRectangleEdgeTrailing = 1 << 3,

  /**
   * All edges.
   */
  kUIDirectionalRectangleEdgeAll =
    kUIDirectionalRectangleEdgeTop |
    kUIDirectionalRectangleEdgeLeading |
    kUIDirectionalRectangleEdgeBottom |
    kUIDirectionalRectangleEdgeTrailing
} UIDirectionalRectangleEdge;

C_ASSUME_NONNULL_END
