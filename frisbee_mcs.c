#include "types.h"
#include "user.h"
#include "libthread.h"
#include "libthread.c"
typedef struct{
  uint tid;
  mcs_lock_t *lock;
} targs;

uint passes = 1;
uint numthreads;
uint maxpass;
uint cur_owner = 0;

void *frisbee_task(void *arg);


int main(int argc, char *argv[]) {

  maxpass = argc > 2 ? (uint) atoi(argv[2]) : 60;
  numthreads = argc > 1 ? (uint) atoi(argv[1]) : 20;

  mcs_lock_t lock;
  mcslock_init(&lock);

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

  exit();
}

void *frisbee_task(void *arg){
  targs *args = (targs*) arg;
  uint tid = args->tid;

  mcs_lock_t qnode;

  while(1) {
    if(passes > maxpass) break;

    mcslock_acquire(args->lock, &qnode);
    if (passes > maxpass) {
      mcslock_release(args->lock, &qnode);
      break;
    }

    if(cur_owner == tid) {
      cur_owner++;
      if(cur_owner == numthreads) cur_owner = 0;
      printf(1, "Pass number: %d, Thread %d is passing the token to thread %d\n", passes, tid, cur_owner);

      passes++;
    }

    mcslock_release(args->lock, &qnode);
  }

  return 0;
}

