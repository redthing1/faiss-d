module faiss.clustering;

import faiss.common;
import faiss.index;

/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

// Copyright 2004-present Facebook. All Rights Reserved
// -*- c -*-

extern (C):

/** Class for the clustering parameters. Can be passed to the
 * constructor of the Clustering object.
 */
struct FaissClusteringParameters
{
    int niter; ///< clustering iterations
    int nredo; ///< redo clustering this many times and keep best

    int verbose; ///< (bool)
    int spherical; ///< (bool) do we want normalized centroids?
    int int_centroids; ///< (bool) round centroids coordinates to integer
    int update_index; ///< (bool) update index after each iteration?
    int frozen_centroids; ///< (bool) use the centroids provided as input and do
    ///< not change them during iterations

    int min_points_per_centroid; ///< otherwise you get a warning
    int max_points_per_centroid; ///< to limit size of dataset

    int seed; ///< seed for the random number generator
    size_t decode_block_size; ///< how many vectors at a time to decode
}

/// Sets the ClusteringParameters object with reasonable defaults
void faiss_ClusteringParameters_init (FaissClusteringParameters* params);

/** clustering based on assignment - centroid update iterations
 *
 * The clustering is based on an Index object that assigns training
 * points to the centroids. Therefore, at each iteration the centroids
 * are added to the index.
 *
 * On output, the centroids table is set to the latest version
 * of the centroids and they are also added to the index. If the
 * centroids table it is not empty on input, it is also used for
 * initialization.
 *
 * To do several clusterings, just call train() several times on
 * different training sets, clearing the centroid table in between.
 */
struct FaissClustering_H;
alias FaissClustering = FaissClustering_H;

int faiss_Clustering_niter (const(FaissClustering)*);
int faiss_Clustering_nredo (const(FaissClustering)*);
int faiss_Clustering_verbose (const(FaissClustering)*);
int faiss_Clustering_spherical (const(FaissClustering)*);
int faiss_Clustering_int_centroids (const(FaissClustering)*);
int faiss_Clustering_update_index (const(FaissClustering)*);
int faiss_Clustering_frozen_centroids (const(FaissClustering)*);

int faiss_Clustering_min_points_per_centroid (const(FaissClustering)*);
int faiss_Clustering_max_points_per_centroid (const(FaissClustering)*);

int faiss_Clustering_seed (const(FaissClustering)*);
size_t faiss_Clustering_decode_block_size (const(FaissClustering)*);

/// getter for d
size_t faiss_Clustering_d (const(FaissClustering)*);

/// getter for k
size_t faiss_Clustering_k (const(FaissClustering)*);

struct FaissClusteringIterationStats_H;
alias FaissClusteringIterationStats = FaissClusteringIterationStats_H;
float faiss_ClusteringIterationStats_obj (const(FaissClusteringIterationStats)*);
double faiss_ClusteringIterationStats_time (const(FaissClusteringIterationStats)*);
double faiss_ClusteringIterationStats_time_search (const(FaissClusteringIterationStats)*);
double faiss_ClusteringIterationStats_imbalance_factor (const(FaissClusteringIterationStats)*);
int faiss_ClusteringIterationStats_nsplit (const(FaissClusteringIterationStats)*);

/// getter for centroids (size = k * d)
void faiss_Clustering_centroids (
    FaissClustering* clustering,
    float** centroids,
    size_t* size);

/// getter for iteration stats
void faiss_Clustering_iteration_stats (
    FaissClustering* clustering,
    FaissClusteringIterationStats** iteration_stats,
    size_t* size);

/// the only mandatory parameters are k and d
int faiss_Clustering_new (FaissClustering** p_clustering, int d, int k);

int faiss_Clustering_new_with_params (
    FaissClustering** p_clustering,
    int d,
    int k,
    const(FaissClusteringParameters)* cp);

int faiss_Clustering_train (
    FaissClustering* clustering,
    idx_t n,
    const(float)* x,
    FaissIndex* index);

void faiss_Clustering_free (FaissClustering* clustering);

/** simplified interface
 *
 * @param d dimension of the data
 * @param n nb of training vectors
 * @param k nb of output centroids
 * @param x training set (size n * d)
 * @param centroids output centroids (size k * d)
 * @param q_error final quantization error
 * @return error code
 */
int faiss_kmeans_clustering (
    size_t d,
    size_t n,
    size_t k,
    const(float)* x,
    float* centroids,
    float* q_error);

