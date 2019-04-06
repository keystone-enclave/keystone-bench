//******************************************************************************
// Copyright (c) 2018, The Regents of the University of California (Regents).
// All Rights Reserved. See LICENSE for license details.
//------------------------------------------------------------------------------
#include <iostream>
#include <cstdio>
#include "keystone.h"
#include "edge_call.h"

int main(int argc, char** argv)
{
  if(argc != 6)
  {
    printf("Usage: %s <eapp> <runtime> <untrusted_size(K)> <freemem_size(K)> <self_timing>\n", argv[0]);
    return 0;
  }

  size_t untrusted_size = atoi(argv[3])*1024;
  size_t freemem_size = atoi(argv[4])*1024;
  int force_timing = atoi(argv[5]);

  Keystone enclave;
  Params params;

  params.setFreeMemSize(freemem_size);
  params.setUntrustedMem(DEFAULT_UNTRUSTED_PTR, untrusted_size);

  enclave.init(argv[1], argv[2], params);

  edge_call_init_internals((uintptr_t)enclave.getSharedBuffer(),
			   enclave.getSharedBufferSize());

  printf("[keystone-bench] Params:\n\tuntrusted: %lu\n\tfreemem: %lu\n*********\n",untrusted_size,freemem_size);

  enclave.run();

  return 0;
}
