// #include <stdio.h>
// #include <stdlib.h>
// #include <time.h>
import core.stdc.stdio;
import core.stdc.stdlib;
import core.stdc.time;

// #include "AutoTune_c.h"
// #include "IndexFlat_c.h"
// #include "Index_c.h"
// #include "clone_index_c.h"
// #include "error_c.h"
// #include "index_factory_c.h"
// #include "index_io_c.h"
import faiss;
import faiss.autotune;
import faiss.index_flat;
import faiss.index;
import faiss.clone_index;
import faiss.error;
import faiss.index_factory;
import faiss.index_io;

// #define FAISS_TRY(C)                                       \
//     {                                                      \
//         if (C) {                                           \
//             fprintf(stderr, "%s", faiss_get_last_error()); \
//             exit(-1);                                      \
//         }                                                  \
//     }

void FAISS_TRY(T)(T something) {
	if (something) {
		fprintf(stderr, "%s", faiss_get_last_error());
		exit(-1);
	}
}

double drand() {
	// return (double)rand() / (double)RAND_MAX;
	return cast(double) rand() / cast(double) RAND_MAX;
}

int main() {
	time_t seed = time(null);
	srand(cast(uint) seed);
	printf("Generating some data...\n");
	int d = 128; // dimension
	int nb = 100000; // database size
	int nq = 10000; // nb of queries
	// float* xb = malloc(d * nb * sizeof(float));
	// float* xq = malloc(d * nq * sizeof(float));
	float* xb = cast(float*) malloc(d * nb * float.sizeof);
	float* xq = cast(float*) malloc(d * nq * float.sizeof);

	for (int i = 0; i < nb; i++) {
		for (int j = 0; j < d; j++)
			xb[d * i + j] = drand();
		xb[d * i] += i / 1000.;
	}
	for (int i = 0; i < nq; i++) {
		for (int j = 0; j < d; j++)
			xq[d * i + j] = drand();
		xq[d * i] += i / 1000.;
	}

	printf("Building an index...\n");

	FaissIndex* index = null;
	FAISS_TRY(faiss_index_factory(
			&index, d, "Flat", FaissMetricType.METRIC_L2)); // use factory to create index
	printf("is_trained = %s\n",
		faiss_Index_is_trained(index) ? cast(char*)"true" : cast(char*)"false");
	FAISS_TRY(faiss_Index_add(index, nb, xb)); // add vectors to the index
	printf("ntotal = %lld\n", faiss_Index_ntotal(index));

	printf("Searching...\n");
	int k = 5;

	{ // sanity check: search 5 first vectors of xb
		// idx_t* I = malloc(k * 5 * sizeof(idx_t));
		// float* D = malloc(k * 5 * sizeof(float));
		idx_t* I = cast(idx_t*) malloc(k * 5 * idx_t.sizeof);
		float* D = cast(float*) malloc(k * 5 * float.sizeof);
		FAISS_TRY(faiss_Index_search(index, 5, xb, k, D, I));
		printf("I=\n");
		for (int i = 0; i < 5; i++) {
			for (int j = 0; j < k; j++)
				printf("%5lld (d=%2.3f)  ", I[i * k + j], D[i * k + j]);
			printf("\n");
		}
		free(I);
		free(D);
	}
	{ // search xq
		// idx_t* I = malloc(k * nq * sizeof(idx_t));
		// float* D = malloc(k * nq * sizeof(float));
		idx_t* I = cast(idx_t*) malloc(k * nq * idx_t.sizeof);
		float* D = cast(float*) malloc(k * nq * float.sizeof);
		FAISS_TRY(faiss_Index_search(index, 5, xb, k, D, I));
		printf("I=\n");
		for (int i = 0; i < 5; i++) {
			for (int j = 0; j < k; j++)
				printf("%5lld (d=%2.3f)  ", I[i * k + j], D[i * k + j]);
			printf("\n");
		}
		free(I);
		free(D);
	}

	printf("Saving index to disk...\n");
	FAISS_TRY(faiss_write_index_fname(index, "example.index"));

	printf("Freeing index...\n");
	faiss_Index_free(index);
	printf("Done.\n");

	return 0;
}
