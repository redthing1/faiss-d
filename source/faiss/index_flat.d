module faiss.index_flat;

/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

// Copyright 2004-present Facebook. All Rights Reserved
// -*- c -*-

extern (C):

// forward declaration

/** Opaque type for IndexFlat */

/** get a pointer to the index's internal data (the `xb` field). The outputs
 * become invalid after any data addition or removal operation.
 *
 * @param index   opaque pointer to index object
 * @param p_xb    output, the pointer to the beginning of `xb`.
 * @param p_size  output, the current size of `sb` in number of float values.
 */

/** attempt a dynamic cast to a flat index, thus checking
 * check whether the underlying index type is `IndexFlat`.
 *
 * @param index opaque pointer to index object
 * @return the same pointer if the index is a flat index, NULL otherwise
 */
struct FaissIndex_H;
alias FaissIndexFlat = FaissIndex_H;
int faiss_IndexFlat_new (FaissIndexFlat** p_index);
int faiss_IndexFlat_new_with (
    FaissIndexFlat** p_index,
    idx_t d,
    FaissMetricType metric);
void faiss_IndexFlat_xb (FaissIndexFlat* index, float** p_xb, size_t* p_size);
FaissIndexFlat* faiss_IndexFlat_cast (FaissIndex*);

void faiss_IndexFlat_free (FaissIndexFlat* obj);

/** compute distance with a subset of vectors
 *
 * @param index   opaque pointer to index object
 * @param x       query vectors, size n * d
 * @param labels  indices of the vectors that should be compared
 *                for each query vector, size n * k
 * @param distances
 *                corresponding output distances, size n * k
 */
int faiss_IndexFlat_compute_distance_subset (
    FaissIndex* index,
    idx_t n,
    const(float)* x,
    idx_t k,
    float* distances,
    const(idx_t)* labels);

/** Opaque type for IndexFlatIP */
alias FaissIndexFlatIP = FaissIndex_H;

FaissIndexFlatIP* faiss_IndexFlatIP_cast (FaissIndex*);
void faiss_IndexFlatIP_free (FaissIndexFlatIP* obj);

int faiss_IndexFlatIP_new (FaissIndexFlatIP** p_index);

int faiss_IndexFlatIP_new_with (FaissIndexFlatIP** p_index, idx_t d);

/** Opaque type for IndexFlatL2 */
alias FaissIndexFlatL2 = FaissIndex_H;

FaissIndexFlatL2* faiss_IndexFlatL2_cast (FaissIndex*);
void faiss_IndexFlatL2_free (FaissIndexFlatL2* obj);

int faiss_IndexFlatL2_new (FaissIndexFlatL2** p_index);

int faiss_IndexFlatL2_new_with (FaissIndexFlatL2** p_index, idx_t d);

/** Opaque type for IndexRefineFlat
 *
 * Index that queries in a base_index (a fast one) and refines the
 * results with an exact search, hopefully improving the results.
 */
alias FaissIndexRefineFlat = FaissIndex_H;

int faiss_IndexRefineFlat_new (
    FaissIndexRefineFlat** p_index,
    FaissIndex* base_index);

void faiss_IndexRefineFlat_free (FaissIndexRefineFlat* obj);
FaissIndexRefineFlat* faiss_IndexRefineFlat_cast (FaissIndex*);

int faiss_IndexRefineFlat_own_fields (const(FaissIndexRefineFlat)*);
void faiss_IndexRefineFlat_set_own_fields (FaissIndexRefineFlat*, int);

/// factor between k requested in search and the k requested from
/// the base_index (should be >= 1)
float faiss_IndexRefineFlat_k_factor (const(FaissIndexRefineFlat)*);
void faiss_IndexRefineFlat_set_k_factor (FaissIndexRefineFlat*, float);

/** Opaque type for IndexFlat1D
 *
 * optimized version for 1D "vectors"
 */
alias FaissIndexFlat1D = FaissIndex_H;

FaissIndexFlat1D* faiss_IndexFlat1D_cast (FaissIndex*);
void faiss_IndexFlat1D_free (FaissIndexFlat1D* obj);

int faiss_IndexFlat1D_new (FaissIndexFlat1D** p_index);
int faiss_IndexFlat1D_new_with (
    FaissIndexFlat1D** p_index,
    int continuous_update);

int faiss_IndexFlat1D_update_permutation (FaissIndexFlat1D* index);

