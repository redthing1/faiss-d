module faiss;

/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

// Copyright 2004-present Facebook. All Rights Reserved.
// -*- c -*-

/// Macros and typedefs for C wrapper API declarations

import core.stdc.config;

extern (C):

alias faiss_idx_t = c_long; ///< all indices are this type
alias idx_t = c_long;
alias faiss_component_t = float; ///< all vector components are this type
alias faiss_distance_t = float; ///< all distances between vectors are this type

/// Declare an opaque type for a class type `clazz`.

/// Declare an opaque type for a class type `clazz`, while
/// actually aliasing it to an existing parent class type `parent`.

/// Declare a dynamic downcast operation from a base `FaissIndex*` pointer
/// type to a more specific index type. The function returns the same pointer
/// if the downcast is valid, and `NULL` otherwise.

/// Declare a getter for the field `name` in class `clazz`,
/// of return type `ty`

/// Declare a setter for the field `name` in class `clazz`,
/// in which the user provides a value of type `ty`

/// Declare a getter and setter for the field `name` in class `clazz`.

/// Declare a destructor function which frees an object of
/// type `clazz`.

