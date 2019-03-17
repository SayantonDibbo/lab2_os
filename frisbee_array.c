#include "types.h"
#include "user.h"
#include "libthread.h"
#include "libthread.c"
typedef struct{
  uint tid;
  uint numthreads;
  uint count;
  struct arraylock_t *lock;
} targs;

uint passes = 1;
uint numthreads;
volatile uint maxpass;
volatile uint cur_owner = 0;

void *frisbee_task(void *arg);


int main(int argc, char *argv[]) {

  maxpass = argc > 2 ? (uint) atoi(argv[2]) : 60;
  numthreads = argc > 1 ? (uint) atoi(argv[1]) : 20;

  struct arraylock_t lock;
  arraylock_init(&lock, numthreads);

  // Create arguments for threads
  targs *thread_args = malloc(numthreads * sizeof(targs));

  // Record time
  int time = 0;
  time -= uptime();

  uint i;
  for(i=0; i<numthreads; i++){
    thread_args[i].tid = i;
    thread_args[i].lock = &lock;

    thread_create(&frisbee_task, (void *)&thread_args[i]);
  }

  for(i=0; i<numthreads; i++){
    if( wait() < 0)
      printf(1, "Sorry! Error occurred in the time of thread exiting\n");
  }

  time += uptime();
  printf(1, "The FRISBEE GAME is finished, with  %d rounds\n", maxpass);
  printf(1, "\nFrisbee Game Total Running Time: %d\n", time);

  arraylock_destroy(&lock);

  exit();
}

void *frisbee_task(void *arg){
  targs *args = (targs*) arg;
  uint tid = args->tid;

  while(1) {
    if(passes > maxpass) break;

    arraylock_acquire(args->lock);
    if (passes > maxpass) {
      arraylock_release(args->lock);
      break;
    }

    if(cur_owner == tid) {
      cur_owner++;
      if(cur_owner == numthreads) cur_owner = 0;
      printf(1, "Pass number: %d, Thread %d is passing the token to thread %d\n", passes, tid, cur_owner);

      passes++;
    }

    arraylock_release(args->lock);
  }

  return 0;
}
