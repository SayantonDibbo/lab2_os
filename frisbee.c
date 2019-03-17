#include "types.h"
#include "user.h"
#include "libthread.h"
#include "libthread.c"
typedef struct{
  int tid;
  struct lock_t *lock;
} targs;

int passes = 1;
int numthreads;
int numpass;
int cur_owner = 0;

void *frisbee_task(void *arg);


int main(int argc, char *argv[]) {

  numpass = argc > 2 ? atoi(argv[2]) : 6;
  numthreads = argc > 1 ? atoi(argv[1]) : 4;

  struct lock_t lock;
  lock_init(&lock);

  // Create arguments for threads
  targs *thread_args = malloc(numthreads * sizeof(targs));

  int time = 0;
  time -= uptime();

  int i;
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
  printf(1, "The FRISBEE GAME is finished, with  %d rounds\n", numpass);
  printf(1, "\nFrisbee Game Total Running Time: %d\n", time);

  exit();
}

void *frisbee_task(void *arg){
  targs *args = (targs*) arg;

  while(1){
    lock_acquire(args->lock);

    if(passes > numpass){
      lock_release(args->lock);
      break;
    }

    if(cur_owner == args->tid){
      cur_owner++;
      if(cur_owner >= numthreads)
        cur_owner = 0;

      printf(1, "Pass number: %d, Thread %d is passing the token to thread %d\n", passes, args->tid, cur_owner);
      passes++;
    }

    lock_release(args->lock);
  }

  return 0;
}
