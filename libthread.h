#ifndef XV6_PUBLIC_LIBTHREAD_H
#define XV6_PUBLIC_LIBTHREAD_H

void thread_create(void *(*start_routine)(void*), void *arg);

/* Spin Lock */

struct lock_t {
  uint lock;
};

void lock_init(struct lock_t *);
void lock_acquire(struct lock_t *);
void lock_release(struct lock_t *);


/* Sequence Lock */

struct seqlock_t {
  uint seq;
  uint splk;
};

void seqlock_init(struct seqlock_t *);
uint seqlock_read(struct seqlock_t *lk, uint *mem);
void seqlock_write(struct seqlock_t *lk, uint *mem, uint val);


/* MCS Lock */

typedef struct mcs_lock_t mcs_lock_t;
struct mcs_lock_t
{
  mcs_lock_t *next;
  volatile uint spin;
};

void mcslock_init(mcs_lock_t *lk);
void mcslock_acquire(mcs_lock_t *lk, mcs_lock_t *qnode);
void mcslock_release(mcs_lock_t *lk, mcs_lock_t *qnode);

/* Array Lock */

struct arraylock_t {
  volatile uint *lock;
  uint lockpos;
  uint next;
  uint size;
  uint m;
};

void arraylock_init(struct arraylock_t *, uint size);
void arraylock_acquire(struct arraylock_t *);
void arraylock_release(struct arraylock_t *);
void arraylock_destroy(struct arraylock_t *);


#endif //XV6_PUBLIC_LIBTHREAD_H
