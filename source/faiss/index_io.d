module faiss.index_io;

import faiss.common;
import faiss.index;

/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

//  Copyright 2004-present Facebook. All Rights Reserved
// -*- c++ -*-
// I/O code for indexes

import core.stdc.stdio;

extern (C):

/** Write index to a file.
 * This is equivalent to `faiss::write_index` when a file descriptor is
 * provided.
 */
int faiss_write_index (const(FaissIndex)* idx, FILE* f);

/** Write index to a file.
 * This is equivalent to `faiss::write_index` when a file path is provided.
 */
int faiss_write_index_fname (const(FaissIndex)* idx, const(char)* fname);

enum FAISS_IO_FLAG_MMAP = 1;
enum FAISS_IO_FLAG_READ_ONLY = 2;

/** Read index from a file.
 * This is equivalent to `faiss:read_index` when a file descriptor is given.
 */
int faiss_read_index (FILE* f, int io_flags, FaissIndex** p_out);

/** Read index from a file.
 * This is equivalent to `faiss:read_index` when a file path is given.
 */
int faiss_read_index_fname (const(char)* fname, int io_flags, FaissIndex** p_out);

