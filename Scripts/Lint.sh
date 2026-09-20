#!/bin/bash

##===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===##
##
##  Lint.sh
##  ui-kit
##
##  Created by Fang Ling on 2026/9/12.
##
##  This file is part of the UIKit open source project
##
##  Copyright (c) 2025-2026 Fang Ling <fangling@fangl.ing>
##  Licensed under Apache License v2.0
##
##  See LICENSE for license information
##
##  SPDX-License-Identifier: Apache-2.0
##
##===----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------===##

swift-format lint . --parallel --recursive --strict
