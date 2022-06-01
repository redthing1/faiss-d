module faiss.index_pre_transform;

import faiss.common;
import faiss.index;
import faiss.vector_transform;

/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

// Copyright 2004-present Facebook. All Rights Reserved.
// -*- c -*-

extern (C):

/** Index that applies a LinearTransform transform on vectors before
 *  handing them over to a sub-index */

struct FaissIndex_H;
alias FaissIndexPreTransform = FaissIndex_H;
void faiss_IndexPreTransform_free (FaissIndexPreTransform* obj);
FaissIndexPreTransform* faiss_IndexPreTransform_cast (FaissIndex*);
FaissIndex* faiss_IndexPreTransform_index (const(FaissIndexPreTransform)*);
int faiss_IndexPreTransform_own_fields (const(FaissIndexPreTransform)*);
void faiss_IndexPreTransform_set_own_fields (FaissIndexPreTransform*, int);
int faiss_IndexPreTransform_new (FaissIndexPreTransform** p_index);
int faiss_IndexPreTransform_new_with (
    FaissIndexPreTransform** p_index,
    FaissIndex* index);
int faiss_IndexPreTransform_new_with_transform (
    FaissIndexPreTransform** p_index,
    FaissVectorTransform* ltrans,
    FaissIndex* index);
int faiss_IndexPreTransform_prepend_transform (
    FaissIndexPreTransform* index,
    FaissVectorTransform* ltrans);

