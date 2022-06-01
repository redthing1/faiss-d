module faiss.index_sh;

import faiss.common;
import faiss.index;

/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

// Copyright 2004-present Facebook. All Rights Reserved.
// -*- c++ -*-

extern (C):

/** The sign of each vector component is put in a binary signature */

struct FaissIndex_H;
alias FaissIndexLSH = FaissIndex_H;
void faiss_IndexLSH_free (FaissIndexLSH* obj);
FaissIndexLSH* faiss_IndexLSH_cast (FaissIndex*);
int faiss_IndexLSH_nbits (const(FaissIndexLSH)*);
int faiss_IndexLSH_code_size (const(FaissIndexLSH)*);
int faiss_IndexLSH_rotate_data (const(FaissIndexLSH)*);
int faiss_IndexLSH_train_thresholds (const(FaissIndexLSH)*);
int faiss_IndexLSH_new (FaissIndexLSH** p_index, idx_t d, int nbits);
int faiss_IndexLSH_new_with_options (
    FaissIndexLSH** p_index,
    idx_t d,
    int nbits,
    int rotate_data,
    int train_thresholds);

