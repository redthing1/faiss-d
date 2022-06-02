# faiss-d

[FAISS](https://github.com/facebookresearch/faiss) bindings for D

currently binds to FAISS v1.7.2

## usage

simply add `faiss-d` as a dependency

if on unix, add this to make sure that the shared libs are found at runtime
```sh
lflags "-L./." "-rpath=./."
```

## notes

how to generate bindings:

run `dstep`:
```sh
dstep faiss_source/c_api/AutoTune_c.h faiss_source/c_api/clone_index_c.h faiss_source/c_api/Clustering_c.h faiss_source/c_api/error_c.h faiss_source/c_api/faiss_c.h faiss_source/c_api/Index_c.h faiss_source/c_api/index_factory_c.h faiss_source/c_api/IndexFlat_c.h faiss_source/c_api/index_io_c.h faiss_source/c_api/IndexIVF_c.h faiss_source/c_api/IndexIVFFlat_c.h faiss_source/c_api/IndexLSH_c.h faiss_source/c_api/IndexPreTransform_c.h faiss_source/c_api/IndexReplicas_c.h faiss_source/c_api/IndexScalarQuantizer_c.h faiss_source/c_api/IndexShards_c.h faiss_source/c_api/MetaIndexes_c.h faiss_source/c_api/VectorTransform_c.h -o source/faiss
```

then edit and clean up as necessary.
