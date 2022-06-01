module faiss.autotune;

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

/// possible values of a parameter, sorted from least to most expensive/accurate
struct FaissParameterRange_H;
alias FaissParameterRange = FaissParameterRange_H;

const(char)* faiss_ParameterRange_name (const(FaissParameterRange)*);

/// Getter for the values in the range. The output values are invalidated
/// upon any other modification of the range.
void faiss_ParameterRange_values (FaissParameterRange*, double**, size_t*);

/** Uses a-priori knowledge on the Faiss indexes to extract tunable parameters.
 */
struct FaissParameterSpace_H;
alias FaissParameterSpace = FaissParameterSpace_H;

void faiss_ParameterSpace_free (FaissParameterSpace* obj);

/// Parameter space default constructor
int faiss_ParameterSpace_new (FaissParameterSpace** space);

/// nb of combinations, = product of values sizes
size_t faiss_ParameterSpace_n_combinations (const(FaissParameterSpace)*);

/// get string representation of the combination
/// by writing it to the given character buffer.
/// A buffer size of 1000 ensures that the full name is collected.
int faiss_ParameterSpace_combination_name (
    const(FaissParameterSpace)*,
    size_t,
    char*,
    size_t);

/// set a combination of parameters described by a string
int faiss_ParameterSpace_set_index_parameters (
    const(FaissParameterSpace)*,
    FaissIndex*,
    const(char)*);

/// set a combination of parameters on an index
int faiss_ParameterSpace_set_index_parameters_cno (
    const(FaissParameterSpace)*,
    FaissIndex*,
    size_t);

/// set one of the parameters
int faiss_ParameterSpace_set_index_parameter (
    const(FaissParameterSpace)*,
    FaissIndex*,
    const(char)*,
    double);

/// print a description on stdout
void faiss_ParameterSpace_display (const(FaissParameterSpace)*);

/// add a new parameter (or return it if it exists)
int faiss_ParameterSpace_add_range (
    FaissParameterSpace*,
    const(char)*,
    FaissParameterRange**);

