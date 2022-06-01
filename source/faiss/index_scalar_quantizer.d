module faiss.index_scalar_quantizer;

/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

// Copyright 2004-present Facebook. All Rights Reserved.
// -*- c -*-

extern (C):

enum FaissQuantizerType
{
    QT_8bit = 0, ///< 8 bits per component
    QT_4bit = 1, ///< 4 bits per component
    QT_8bit_uniform = 2, ///< same, shared range for all dimensions
    QT_4bit_uniform = 3,
    QT_fp16 = 4,
    QT_8bit_direct = 5, ///< fast indexing of uint8s
    QT_6bit = 6 ///< 6 bits per component
}

// forward declaration

/** Opaque type for IndexScalarQuantizer */

struct FaissIndex_H;
alias FaissIndexScalarQuantizer = FaissIndex_H;
int faiss_IndexScalarQuantizer_new (FaissIndexScalarQuantizer** p_index);
int faiss_IndexScalarQuantizer_new_with (
    FaissIndexScalarQuantizer** p_index,
    idx_t d,
    FaissQuantizerType qt,
    FaissMetricType metric);

FaissIndexScalarQuantizer* faiss_IndexScalarQuantizer_cast (FaissIndex*);

void faiss_IndexScalarQuantizer_free (FaissIndexScalarQuantizer* obj);

/** Opaque type for IndexIVFScalarQuantizer */
alias FaissIndexIVFScalarQuantizer = FaissIndex_H;

FaissIndexIVFScalarQuantizer* faiss_IndexIVFScalarQuantizer_cast (FaissIndex*);

void faiss_IndexIVFScalarQuantizer_free (FaissIndexIVFScalarQuantizer* obj);

int faiss_IndexIVFScalarQuantizer_new (FaissIndexIVFScalarQuantizer** p_index);

int faiss_IndexIVFScalarQuantizer_new_with (
    FaissIndexIVFScalarQuantizer** p_index,
    FaissIndex* quantizer,
    idx_t d,
    size_t nlist,
    FaissQuantizerType qt);

int faiss_IndexIVFScalarQuantizer_new_with_metric (
    FaissIndexIVFScalarQuantizer** p_index,
    FaissIndex* quantizer,
    size_t d,
    size_t nlist,
    FaissQuantizerType qt,
    FaissMetricType metric,
    int encode_residual);

/// number of possible key values
size_t faiss_IndexIVFScalarQuantizer_nlist (const(FaissIndexIVFScalarQuantizer)*);
/// number of probes at query time
size_t faiss_IndexIVFScalarQuantizer_nprobe (const(FaissIndexIVFScalarQuantizer)*);
void faiss_IndexIVFScalarQuantizer_set_nprobe (FaissIndexIVFScalarQuantizer*, size_t);
/// quantizer that maps vectors to inverted lists
FaissIndex* faiss_IndexIVFScalarQuantizer_quantizer (const(FaissIndexIVFScalarQuantizer)*);

/// whether object owns the quantizer
int faiss_IndexIVFScalarQuantizer_own_fields (const(FaissIndexIVFScalarQuantizer)*);
void faiss_IndexIVFScalarQuantizer_set_own_fields (FaissIndexIVFScalarQuantizer*, int);

int faiss_IndexIVFScalarQuantizer_add_core (
    FaissIndexIVFScalarQuantizer* index,
    idx_t n,
    const(float)* x,
    const(idx_t)* xids,
    const(idx_t)* precomputed_idx);

int faiss_IndexIVFScalarQuantizer_train_residual (
    FaissIndexIVFScalarQuantizer* index,
    idx_t n,
    const(float)* x);

