module faiss.index_factory;

/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

// Copyright 2004-present Facebook. All Rights Reserved.
// -*- c -*-

extern (C):

/** Build and index with the sequence of processing steps described in
 *  the string.
 */
int faiss_index_factory (
    FaissIndex** p_index,
    int d,
    const(char)* description,
    FaissMetricType metric);

