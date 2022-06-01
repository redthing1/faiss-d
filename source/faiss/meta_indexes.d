module faiss.meta_indexes;

/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

// Copyright 2004-present Facebook. All Rights Reserved.
// -*- c++ -*-

extern (C):

/** Index that translates search results to ids */

/** attempt a dynamic cast to a IDMap, thus checking
 * check whether the underlying index type is `IndexIDMap`.
 *
 * @param index opaque pointer to index object
 * @return the same pointer if the index is a IDMap index, NULL otherwise
 */

/** get a pointer to the index map's internal ID vector (the `id_map` field).
 * The outputs of this function become invalid after any operation that can
 * modify the index.
 *
 * @param index   opaque pointer to index object
 * @param p_id_map    output, the pointer to the beginning of `id_map`.
 * @param p_size  output, the current length of `id_map`.
 */
struct FaissIndex_H;
alias FaissIndexIDMap = FaissIndex_H;
int faiss_IndexIDMap_own_fields (const(FaissIndexIDMap)*);
void faiss_IndexIDMap_set_own_fields (FaissIndexIDMap*, int);
int faiss_IndexIDMap_new (FaissIndexIDMap** p_index, FaissIndex* index);
FaissIndexIDMap* faiss_IndexIDMap_cast (FaissIndex*);
void faiss_IndexIDMap_id_map (
    FaissIndexIDMap* index,
    idx_t** p_id_map,
    size_t* p_size);

/** get a pointer to the sub-index (the `index` field).
 * The outputs of this function become invalid after any operation that can
 * modify the index.
 *
 * @param index   opaque pointer to index object
 */
FaissIndex* faiss_IndexIDMap_sub_index (FaissIndexIDMap* index);

/** same as IndexIDMap but also provides an efficient reconstruction
    implementation via a 2-way index */
alias FaissIndexIDMap2 = FaissIndex_H;

int faiss_IndexIDMap2_own_fields (const(FaissIndexIDMap2)*);
void faiss_IndexIDMap2_set_own_fields (FaissIndexIDMap2*, int);

int faiss_IndexIDMap2_new (FaissIndexIDMap2** p_index, FaissIndex* index);

/// make the rev_map from scratch
int faiss_IndexIDMap2_construct_rev_map (FaissIndexIDMap2* index);

/** attempt a dynamic cast to a IDMap2, thus checking
 * check whether the underlying index type is `IndexIDMap`.
 *
 * @param index opaque pointer to index object
 * @return the same pointer if the index is a IDMap2 index, NULL otherwise
 */
FaissIndexIDMap2* faiss_IndexIDMap2_cast (FaissIndex*);

/** get a pointer to the index map's internal ID vector (the `id_map` field).
 * The outputs of this function become invalid after any operation that can
 * modify the index.
 *
 * @param index   opaque pointer to index object
 * @param p_id_map    output, the pointer to the beginning of `id_map`.
 * @param p_size  output, the current length of `id_map`.
 */
void faiss_IndexIDMap2_id_map (
    FaissIndexIDMap2* index,
    idx_t** p_id_map,
    size_t* p_size);

/** get a pointer to the sub-index (the `index` field).
 * The outputs of this function become invalid after any operation that can
 * modify the index.
 *
 * @param index   opaque pointer to index object
 */
FaissIndex* faiss_IndexIDMap2_sub_index (FaissIndexIDMap2* index);

