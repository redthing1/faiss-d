module faiss.vector_transform;

import faiss.common;
import faiss.index;

/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

// Copyright 2004-present Facebook. All Rights Reserved.
// -*- c -*-

extern (C):

/** Defines a few objects that apply transformations to a set of
 * vectors Often these are pre-processing steps.
 */

/// Opaque type for referencing to a VectorTransform object
struct FaissVectorTransform_H;
alias FaissVectorTransform = FaissVectorTransform_H;
void faiss_VectorTransform_free (FaissVectorTransform* obj);

/// Getter for is_trained
int faiss_VectorTransform_is_trained (const(FaissVectorTransform)*);

/// Getter for input dimension
int faiss_VectorTransform_d_in (const(FaissVectorTransform)*);

/// Getter for output dimension
int faiss_VectorTransform_d_out (const(FaissVectorTransform)*);

/** Perform training on a representative set of vectors
 *
 * @param vt     opaque pointer to VectorTransform object
 * @param n      nb of training vectors
 * @param x      training vectors, size n * d
 */
int faiss_VectorTransform_train (
    FaissVectorTransform* vt,
    idx_t n,
    const(float)* x);

/** apply the random rotation, return new allocated matrix
 * @param     x size n * d_in
 * @return    size n * d_out
 */
float* faiss_VectorTransform_apply (
    const(FaissVectorTransform)* vt,
    idx_t n,
    const(float)* x);

/** apply transformation and result is pre-allocated
 * @param     x size n * d_in
 * @param     xt size n * d_out
 */
void faiss_VectorTransform_apply_noalloc (
    const(FaissVectorTransform)* vt,
    idx_t n,
    const(float)* x,
    float* xt);

/// reverse transformation. May not be implemented or may return
/// approximate result
void faiss_VectorTransform_reverse_transform (
    const(FaissVectorTransform)* vt,
    idx_t n,
    const(float)* xt,
    float* x);

/// Opaque type for referencing to a LinearTransform object
alias FaissLinearTransform = FaissVectorTransform_H;
void faiss_LinearTransform_free (FaissLinearTransform* obj);

/// compute x = A^T * (x - b)
/// is reverse transform if A has orthonormal lines
void faiss_LinearTransform_transform_transpose (
    const(FaissLinearTransform)* vt,
    idx_t n,
    const(float)* y,
    float* x);

/// compute A^T * A to set the is_orthonormal flag
void faiss_LinearTransform_set_is_orthonormal (FaissLinearTransform* vt);

/// Getter for have_bias
int faiss_LinearTransform_have_bias (const(FaissLinearTransform)*);

/// Getter for is_orthonormal
int faiss_LinearTransform_is_orthonormal (const(FaissLinearTransform)*);

alias FaissRandomRotationMatrix = FaissVectorTransform_H;
void faiss_RandomRotationMatrix_free (FaissRandomRotationMatrix* obj);

int faiss_RandomRotationMatrix_new_with (
    FaissRandomRotationMatrix** p_vt,
    int d_in,
    int d_out);

alias FaissPCAMatrix = FaissVectorTransform_H;
void faiss_PCAMatrix_free (FaissPCAMatrix* obj);

int faiss_PCAMatrix_new_with (
    FaissPCAMatrix** p_vt,
    int d_in,
    int d_out,
    float eigen_power,
    int random_rotation);

/// Getter for eigen_power
float faiss_PCAMatrix_eigen_power (const(FaissPCAMatrix)*);

/// Getter for random_rotation
int faiss_PCAMatrix_random_rotation (const(FaissPCAMatrix)*);

alias FaissITQMatrix = FaissVectorTransform_H;
void faiss_ITQMatrix_free (FaissITQMatrix* obj);

int faiss_ITQMatrix_new_with (FaissITQMatrix** p_vt, int d);

alias FaissITQTransform = FaissVectorTransform_H;
void faiss_ITQTransform_free (FaissITQTransform* obj);

int faiss_ITQTransform_new_with (
    FaissITQTransform** p_vt,
    int d_in,
    int d_out,
    int do_pca);

/// Getter for do_pca
int faiss_ITQTransform_do_pca (const(FaissITQTransform)*);

alias FaissOPQMatrix = FaissVectorTransform_H;
void faiss_OPQMatrix_free (FaissOPQMatrix* obj);

int faiss_OPQMatrix_new_with (FaissOPQMatrix** p_vt, int d, int M, int d2);

int faiss_OPQMatrix_verbose (const(FaissOPQMatrix)*);
void faiss_OPQMatrix_set_verbose (FaissOPQMatrix*, int);
int faiss_OPQMatrix_niter (const(FaissOPQMatrix)*);
void faiss_OPQMatrix_set_niter (FaissOPQMatrix*, int);
int faiss_OPQMatrix_niter_pq (const(FaissOPQMatrix)*);
void faiss_OPQMatrix_set_niter_pq (FaissOPQMatrix*, int);

alias FaissRemapDimensionsTransform = FaissVectorTransform_H;
void faiss_RemapDimensionsTransform_free (FaissRemapDimensionsTransform* obj);

int faiss_RemapDimensionsTransform_new_with (
    FaissRemapDimensionsTransform** p_vt,
    int d_in,
    int d_out,
    int uniform);

alias FaissNormalizationTransform = FaissVectorTransform_H;
void faiss_NormalizationTransform_free (FaissNormalizationTransform* obj);

int faiss_NormalizationTransform_new_with (
    FaissNormalizationTransform** p_vt,
    int d,
    float norm);

float faiss_NormalizationTransform_norm (const(FaissNormalizationTransform)*);

alias FaissCenteringTransform = FaissVectorTransform_H;
void faiss_CenteringTransform_free (FaissCenteringTransform* obj);

int faiss_CenteringTransform_new_with (FaissCenteringTransform** p_vt, int d);

