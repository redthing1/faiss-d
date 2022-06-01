module faiss.index_ivf_flat;

/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

// Copyright 2004-present Facebook. All Rights Reserved.
// -*- c -*-

extern (C):

/** Inverted file with stored vectors. Here the inverted file
 * pre-selects the vectors to be searched, but they are not otherwise
 * encoded, the code array just contains the raw float entries.
 */

/// number of possible key values

/// number of probes at query time

/// quantizer that maps vectors to inverted lists

/**
 * = 0: use the quantizer as index in a kmeans training
 * = 1: just pass on the training set to the train() of the quantizer
 * = 2: kmeans training on a flat index + add the centroids to the quantizer
 */

struct FaissIndex_H;
alias FaissIndexIVFFlat = FaissIndex_H;
void faiss_IndexIVFFlat_free (FaissIndexIVFFlat* obj);
FaissIndexIVFFlat* faiss_IndexIVFFlat_cast (FaissIndex*);
size_t faiss_IndexIVFFlat_nlist (const(FaissIndexIVFFlat)*);
size_t faiss_IndexIVFFlat_nprobe (const(FaissIndexIVFFlat)*);
void faiss_IndexIVFFlat_set_nprobe (FaissIndexIVFFlat*, size_t);
FaissIndex* faiss_IndexIVFFlat_quantizer (const(FaissIndexIVFFlat)*);
char faiss_IndexIVFFlat_quantizer_trains_alone (const(FaissIndexIVFFlat)*); /// whether object owns the quantizer
int faiss_IndexIVFFlat_own_fields (const(FaissIndexIVFFlat)*);
void faiss_IndexIVFFlat_set_own_fields (FaissIndexIVFFlat*, int);

int faiss_IndexIVFFlat_new (FaissIndexIVFFlat** p_index);

int faiss_IndexIVFFlat_new_with (
    FaissIndexIVFFlat** p_index,
    FaissIndex* quantizer,
    size_t d,
    size_t nlist);

int faiss_IndexIVFFlat_new_with_metric (
    FaissIndexIVFFlat** p_index,
    FaissIndex* quantizer,
    size_t d,
    size_t nlist,
    FaissMetricType metric);

int faiss_IndexIVFFlat_add_core (
    FaissIndexIVFFlat* index,
    idx_t n,
    const(float)* x,
    const(idx_t)* xids,
    const(long)* precomputed_idx);

/** Update a subset of vectors.
 *
 * The index must have a direct_map
 *
 * @param nv     nb of vectors to update
 * @param idx    vector indices to update, size nv
 * @param v      vectors of new values, size nv*d
 */
int faiss_IndexIVFFlat_update_vectors (
    FaissIndexIVFFlat* index,
    int nv,
    idx_t* idx,
    const(float)* v);

