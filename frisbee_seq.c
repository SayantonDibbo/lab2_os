#include "types.h"
#include "user.h"
#include "libthread.h"
#include "libthread.c"
typedef struct{
  uint tid;
  struct seqlock_t *lock;
} targs;

uint passes = 1;
uint numthreads;
uint maxpass;
uint cur_owner = 0;

void *frisbee_task(void *arg);


int main(int argc, char *argv[]) {

  maxpass = argc > 2 ? (uint) atoi(argv[2]) : 60;
  numthreads = argc > 1 ? (uint) atoi(argv[1]) : 20;

  struct seqlock_t lock;
  seqlock_init(&lock);

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
  uint owner;
  uint cpass;

  while(1) {
    owner = seqlock_read(args->lock, &cur_owner);
    cpass = passes;

    if(cpass > maxpass) break;
    if(owner != tid){ // This thread has no work to do
//      sleep(1);       // Yield so that other threads run
            continue;
                }

                    owner++; // get next owner id
                        if(owner >= numthreads) owner = 0;

                            printf(1, "Pass number: %d, Thread %d is passing the token to thread %d\n", passes, tid, owner);

                                seqlock_write(args->lock, &passes, passes + 1);
                                    seqlock_write(args->lock, &cur_owner, owner);
                                      }

                                        return 0;
                                        }
