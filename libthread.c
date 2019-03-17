#include "types.h"
#include "libthread.h"
#include <stddef.h>
#include "user.h"
#include "x86.h"

void thread_routine(void *(*routine)(void *), void *arg, void *stack){
  (*routine)(arg);
  free(stack);
  exit();
}

void thread_panic(void){
  // This will only be called in errors
     printf(1, "** Thread shouldn't execute this instruction **\n");
   }

void thread_create(void *(*start_routine)(void *), void *arg) {
  uint size = 4096;
  void *stack = malloc(size);

uint *endstack;
  endstack = (uint*)(stack + size);
  *(--endstack) = (uint) stack;
  *(--endstack) = (uint) arg;
  *(--endstack) = (uint) start_routine;
  *(--endstack) = (uint) &thread_panic;
  *(--endstack) = (uint) &thread_routine;

 size -= sizeof(uint*) * 5; // 5 elements are already taken up

  clone(stack, size);
}

/* Spin Lock */

void lock_init(struct lock_t *lk)
{
  lk->lock = 0;
}

void lock_acquire(struct lock_t *lk){
  while (xchg(&lk->lock, 1) != 0);
}

void lock_release(struct lock_t *lk){
  xchg(&lk->lock, 0);
}

/* Sequence Lock */

void seqlock_init(struct seqlock_t *lk){
  lk->seq = 0;
  lk->splk = 0;
}

uint seqlock_read(struct seqlock_t *lk, uint *mem) {
  uint seqi, seqf;
  uint retval;
  while (1) {
    seqi = lk->seq;
    retval = *mem;
    asm volatile("":: : "memory"); // prevent reordering the reads
    seqf = lk->seq;
    if ( (seqi != seqf) || (seqi & 0x1)) continue;
    return retval;
  }
}

void seqlock_write(struct seqlock_t *lk, uint *mem, uint val){
  // spinlock to prevent write conflict
     while (xchg(&lk->splk, 1) != 0);
lk->seq++;
  asm volatile(""::: "memory"); // prevent reordering the writes
  *mem = val;
  asm volatile(""::: "memory"); // prevent reordering the writes
  lk->seq++;

  //release spinlock
    xchg(&lk->splk, 0);
    }

/* MCS Lock */

void mcslock_init(mcs_lock_t *lk){
  lk->next = NULL;
  lk->spin = 0;
}

void mcslock_acquire(mcs_lock_t *lk, mcs_lock_t *qnode){
  mcs_lock_t *tail;

  qnode->next = NULL;
  qnode->spin = 0;

  // Place itself in the queue if exists
  tail = (mcs_lock_t*) xchg((uint*) &lk->next, (uint) qnode);
  if (!tail) return; // queue is empty

  tail->next = qnode; // Attach after queue if present
  asm volatile ("" ::: "memory"); // put a memory barrier
  while (!qnode->spin);
  return;
}

void mcslock_release(mcs_lock_t *lk, mcs_lock_t *qnode){

  if (!qnode->next){ // No successor yet
    // Compare and swap
    //     // Use lock's spin as spinlock for release
             mcs_lock_t *t;
  while (xchg(&lk->spin, 1) != 0);
    t = lk->next;
    if(t == qnode) lk->next = NULL;
    xchg(&lk->spin, 0);

    if(t == qnode) return;



 // Wait for successor to update qnode
      while(!qnode->next);
        }
 //
 //         // Unlock next one
            qnode->next->spin = 1;
            }

void arraylock_init(struct arraylock_t *lk, uint size)
{
  lk->size = size;
  lk->lock = (uint*) malloc(lk->size * sizeof(uint));

  int i;
  for(i = 1; i < size; i++) lk->lock[i] = 0;
  lk->lock[0] = 1;

  lk->next = 0;
  lk->m = 0;
}
void arraylock_acquire(struct arraylock_t *lk){
  uint pos;
  // makeshift read-modify-write using xchg
  while (xchg(&lk->m, 1) != 0);
  pos = lk->next;
  lk->next = pos + 1;
  if(lk->next == lk->size) lk->next = 0;
  xchg(&lk->m, 0);

  while(lk->lock[pos] == 0);
  lk->lockpos = pos;
}

void arraylock_release(struct arraylock_t *lk){
  uint nextpos = lk->lockpos + 1;
  if(nextpos == lk->size) nextpos = 0;

  lk->lock[lk->lockpos] = 0; // Clear own ticket
  lk->lock[nextpos] = 1; // Set next ticket
}

void arraylock_destroy(struct arraylock_t *lk){
  free((void *) lk->lock);
}















