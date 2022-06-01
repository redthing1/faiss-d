module faiss.clone_index;

/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

//  Copyright 2004-present Facebook. All Rights Reserved
// -*- c++ -*-
// I/O code for indexes

extern (C):

/* cloning functions */

/** Clone an index. This is equivalent to `faiss::clone_index` */
int faiss_clone_index (const(FaissIndex)*, FaissIndex** p_out);

