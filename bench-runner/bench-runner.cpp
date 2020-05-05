//******************************************************************************
// Copyright (c) 2018, The Regents of the University of California (Regents).
// All Rights Reserved. See LICENSE for license details.
//------------------------------------------------------------------------------
#include <iostream>
#include <cstdio>
#include "keystone.h"
#include "edge_call.h"
#include <getopt.h>

/* This is for asking the loader to use the FU540 physical address
range belonging to the scratchpad, rather than what the kernel
provides. This will only work with the appropriate SM plugins enabled
and working! (FU540 platform module set to use the scratchpad, SM
multimem plugin)
*/
#define SCRATCHPAD_PHYS 0

int main(int argc, char** argv)
{
  if(argc < 3 || argc > 8)
  {
    printf("Usage: %s <eapp> <runtime> [--utm-size SIZE(K)] [--freemem-size SIZE(K)] [--time] [--load-only] [--utm-ptr 0xPTR]\n", argv[0]);
    return 0;
  }


  int self_timing = 0;
  int load_only = 0;

  size_t untrusted_size = 1024*1024;
  size_t freemem_size = 20482*1024;
  uintptr_t utm_ptr = (uintptr_t)DEFAULT_UNTRUSTED_PTR;



  static struct option long_options[] =
    {
      {"time",         no_argument,       &self_timing, 1},
      {"load-only",    no_argument,       &load_only, 1},
      {"utm-size",     required_argument, 0, 'u'},
      {"utm-ptr",      required_argument, 0, 'p'},
      {"freemem-size", required_argument, 0, 'f'},
      {0, 0, 0, 0}
    };


  char* eapp_file = argv[1];
  char* rt_file = argv[2];

  int c;
  int opt_index = 3;
  while (1){

    c = getopt_long (argc, argv, "u:p:f:",
                     long_options, &opt_index);

    if (c == -1)
      break;

    switch (c){
    case 0:
      break;
    case 'u':
      untrusted_size = atoi(optarg)*1024;
      break;
    case 'p':
      utm_ptr = strtoll(optarg, NULL, 16);
      break;
    case 'f':
      freemem_size = atoi(optarg)*1024;
      break;
    }
  }

  Keystone enclave;
  Params params;
  unsigned long cycles1,cycles2,cycles3,cycles4;

  params.setFreeMemSize(freemem_size);
  params.setUntrustedMem(utm_ptr, untrusted_size);


  if( self_timing ){
    asm volatile ("rdcycle %0" : "=r" (cycles1));
  }
  if(SCRATCHPAD_PHYS)
    enclave.init(eapp_file, rt_file , params, 0x0A000000);
  else
    enclave.init(eapp_file, rt_file , params);

  if( self_timing ){
    asm volatile ("rdcycle %0" : "=r" (cycles2));
  }

  enclave.registerOcallDispatch(incoming_call_dispatch);
  edge_call_init_internals((uintptr_t)enclave.getSharedBuffer(),
			   enclave.getSharedBufferSize());


  printf("[keystone-bench] Params:\n\tuntrusted: %lu\n\tfreemem: %lu\n\t%s\n\t%s\n\t%s\n*********\n",untrusted_size,freemem_size,
         self_timing?"Performing internal timing":"No timing",
         load_only?"ONLY LOADING, not running":"Running benchmark",
         SCRATCHPAD_PHYS?"Loading to SCRATCHPAD":"");


  if( self_timing ){
    asm volatile ("rdcycle %0" : "=r" (cycles3));
  }

  if( !load_only )
    enclave.run();

  if( self_timing ){
    asm volatile ("rdcycle %0" : "=r" (cycles4));
    printf("[keystone-bench] Init: %lu cycles\r\n", cycles2-cycles1);
    printf("[keystone-bench] Runtime: %lu cycles\r\n", cycles4-cycles3);
  }

  return 0;
}
