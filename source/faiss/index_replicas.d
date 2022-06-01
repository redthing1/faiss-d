module faiss.index_replicas;

/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

// Copyright 2004-present Facebook. All Rights Reserved.
// -*- c++ -*-

extern (C):

/** Index that concatenates the results from several sub-indexes
 */

struct FaissIndex_H;
alias FaissIndexReplicas = FaissIndex_H;
void faiss_IndexReplicas_free (FaissIndexReplicas* obj);
int faiss_IndexReplicas_own_fields (const(FaissIndexReplicas)*);
void faiss_IndexReplicas_set_own_fields (FaissIndexReplicas*, int);
int faiss_IndexReplicas_new (FaissIndexReplicas** p_index, idx_t d);
int faiss_IndexReplicas_new_with_options (
    FaissIndexReplicas** p_index,
    idx_t d,
    int threaded);
int faiss_IndexReplicas_add_replica (
    FaissIndexReplicas* index,
    FaissIndex* replica);
int faiss_IndexReplicas_remove_replica (
    FaissIndexReplicas* index,
    FaissIndex* replica);
FaissIndex* faiss_IndexReplicas_at (FaissIndexReplicas* index, int i);

