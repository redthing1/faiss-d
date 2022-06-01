module faiss.index_shards;

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

/** Index that concatenates the results from several sub-indexes
 */

struct FaissIndex_H;
alias FaissIndexShards = FaissIndex_H;
void faiss_IndexShards_free (FaissIndexShards* obj);
int faiss_IndexShards_own_fields (const(FaissIndexShards)*);
void faiss_IndexShards_set_own_fields (FaissIndexShards*, int);
int faiss_IndexShards_successive_ids (const(FaissIndexShards)*);
void faiss_IndexShards_set_successive_ids (FaissIndexShards*, int);
int faiss_IndexShards_new (FaissIndexShards** p_index, idx_t d);
int faiss_IndexShards_new_with_options (
    FaissIndexShards** p_index,
    idx_t d,
    int threaded,
    int successive_ids);
int faiss_IndexShards_add_shard (FaissIndexShards* index, FaissIndex* shard);
int faiss_IndexShards_remove_shard (FaissIndexShards* index, FaissIndex* shard);
FaissIndex* faiss_IndexShards_at (FaissIndexShards* index, int i);

