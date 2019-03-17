
_frisbee:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
int cur_owner = 0;

void *frisbee_task(void *arg);


int main(int argc, char *argv[]) {
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	83 e4 f0             	and    $0xfffffff0,%esp
   9:	83 ec 20             	sub    $0x20,%esp
   c:	8b 5d 0c             	mov    0xc(%ebp),%ebx

  numpass = argc > 2 ? atoi(argv[2]) : 6;
   f:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)
  13:	0f 8f f4 00 00 00    	jg     10d <main+0x10d>
  19:	c7 05 e8 11 00 00 06 	movl   $0x6,0x11e8
  20:	00 00 00 
  numthreads = argc > 1 ? atoi(argv[1]) : 4;
  23:	b8 04 00 00 00       	mov    $0x4,%eax
  28:	0f 84 ef 00 00 00    	je     11d <main+0x11d>
  2e:	a3 ec 11 00 00       	mov    %eax,0x11ec

  struct lock_t lock;
  lock_init(&lock);

  // Create arguments for threads
  targs *thread_args = malloc(numthreads * sizeof(targs));
  33:	c1 e0 03             	shl    $0x3,%eax

  int time = 0;
  time -= uptime();

  int i;
  for(i=0; i<numthreads; i++){
  36:	31 ff                	xor    %edi,%edi
  targs *thread_args = malloc(numthreads * sizeof(targs));
  38:	89 04 24             	mov    %eax,(%esp)
  3b:	8d 74 24 1c          	lea    0x1c(%esp),%esi

/* Spin Lock */

void lock_init(struct lock_t *lk)
{
  lk->lock = 0;
  3f:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
  46:	00 
  47:	e8 c4 0a 00 00       	call   b10 <malloc>
  4c:	89 c3                	mov    %eax,%ebx
  time -= uptime();
  4e:	e8 87 07 00 00       	call   7da <uptime>
  53:	89 44 24 0c          	mov    %eax,0xc(%esp)
  for(i=0; i<numthreads; i++){
  57:	a1 ec 11 00 00       	mov    0x11ec,%eax
  5c:	85 c0                	test   %eax,%eax
  5e:	7e 68                	jle    c8 <main+0xc8>
    thread_args[i].tid = i;
  60:	89 3b                	mov    %edi,(%ebx)
  for(i=0; i<numthreads; i++){
  62:	83 c7 01             	add    $0x1,%edi
    thread_args[i].lock = &lock;
  65:	89 73 04             	mov    %esi,0x4(%ebx)

    thread_create(&frisbee_task, (void *)&thread_args[i]);
  68:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  6c:	83 c3 08             	add    $0x8,%ebx
  6f:	c7 04 24 70 01 00 00 	movl   $0x170,(%esp)
  76:	e8 95 01 00 00       	call   210 <thread_create>
  for(i=0; i<numthreads; i++){
  7b:	8b 15 ec 11 00 00    	mov    0x11ec,%edx
  81:	39 fa                	cmp    %edi,%edx
  83:	7f db                	jg     60 <main+0x60>
  }

  for(i=0; i<numthreads; i++){
  85:	85 d2                	test   %edx,%edx
  87:	7e 3f                	jle    c8 <main+0xc8>
  89:	31 db                	xor    %ebx,%ebx
  8b:	eb 0e                	jmp    9b <main+0x9b>
  8d:	8d 76 00             	lea    0x0(%esi),%esi
  90:	83 c3 01             	add    $0x1,%ebx
  93:	39 1d ec 11 00 00    	cmp    %ebx,0x11ec
  99:	7e 2d                	jle    c8 <main+0xc8>
    if( wait() < 0)
  9b:	e8 aa 06 00 00       	call   74a <wait>
  a0:	85 c0                	test   %eax,%eax
  a2:	79 ec                	jns    90 <main+0x90>
      printf(1, "Sorry! Error occurred in the time of thread exiting\n");
  a4:	c7 44 24 04 c4 0c 00 	movl   $0xcc4,0x4(%esp)
  ab:	00 
  for(i=0; i<numthreads; i++){
  ac:	83 c3 01             	add    $0x1,%ebx
      printf(1, "Sorry! Error occurred in the time of thread exiting\n");
  af:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  b6:	e8 d5 07 00 00       	call   890 <printf>
  for(i=0; i<numthreads; i++){
  bb:	39 1d ec 11 00 00    	cmp    %ebx,0x11ec
  c1:	7f d8                	jg     9b <main+0x9b>
  c3:	90                   	nop
  c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  time += uptime();
  c8:	e8 0d 07 00 00       	call   7da <uptime>
  printf(1, "The FRISBEE GAME is finished, with  %d rounds\n", numpass);
  cd:	c7 44 24 04 6c 0c 00 	movl   $0xc6c,0x4(%esp)
  d4:	00 
  d5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  time += uptime();
  dc:	89 c3                	mov    %eax,%ebx
  printf(1, "The FRISBEE GAME is finished, with  %d rounds\n", numpass);
  de:	a1 e8 11 00 00       	mov    0x11e8,%eax
  time += uptime();
  e3:	2b 5c 24 0c          	sub    0xc(%esp),%ebx
  printf(1, "The FRISBEE GAME is finished, with  %d rounds\n", numpass);
  e7:	89 44 24 08          	mov    %eax,0x8(%esp)
  eb:	e8 a0 07 00 00       	call   890 <printf>
  printf(1, "\nFrisbee Game Total Running Time: %d\n", time);
  f0:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  f4:	c7 44 24 04 9c 0c 00 	movl   $0xc9c,0x4(%esp)
  fb:	00 
  fc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 103:	e8 88 07 00 00       	call   890 <printf>

  exit();
 108:	e8 35 06 00 00       	call   742 <exit>
  numpass = argc > 2 ? atoi(argv[2]) : 6;
 10d:	8b 43 08             	mov    0x8(%ebx),%eax
 110:	89 04 24             	mov    %eax,(%esp)
 113:	e8 c8 05 00 00       	call   6e0 <atoi>
 118:	a3 e8 11 00 00       	mov    %eax,0x11e8
  numthreads = argc > 1 ? atoi(argv[1]) : 4;
 11d:	8b 43 04             	mov    0x4(%ebx),%eax
 120:	89 04 24             	mov    %eax,(%esp)
 123:	e8 b8 05 00 00       	call   6e0 <atoi>
 128:	e9 01 ff ff ff       	jmp    2e <main+0x2e>
 12d:	66 90                	xchg   %ax,%ax
 12f:	90                   	nop

00000130 <thread_routine>:
void thread_routine(void *(*routine)(void *), void *arg, void *stack){
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	83 ec 18             	sub    $0x18,%esp
  (*routine)(arg);
 136:	8b 45 0c             	mov    0xc(%ebp),%eax
 139:	89 04 24             	mov    %eax,(%esp)
 13c:	ff 55 08             	call   *0x8(%ebp)
  free(stack);
 13f:	8b 45 10             	mov    0x10(%ebp),%eax
 142:	89 04 24             	mov    %eax,(%esp)
 145:	e8 36 09 00 00       	call   a80 <free>
  exit();
 14a:	e8 f3 05 00 00       	call   742 <exit>
 14f:	90                   	nop

00000150 <thread_panic>:
void thread_panic(void){
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	83 ec 18             	sub    $0x18,%esp
     printf(1, "** Thread shouldn't execute this instruction **\n");
 156:	c7 44 24 04 f8 0b 00 	movl   $0xbf8,0x4(%esp)
 15d:	00 
 15e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 165:	e8 26 07 00 00       	call   890 <printf>
   }
 16a:	c9                   	leave  
 16b:	c3                   	ret    
 16c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000170 <frisbee_task>:
}

void *frisbee_task(void *arg){
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	56                   	push   %esi
 174:	53                   	push   %ebx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
 175:	bb 01 00 00 00       	mov    $0x1,%ebx
 17a:	83 ec 20             	sub    $0x20,%esp
 17d:	8b 75 08             	mov    0x8(%ebp),%esi
 180:	8b 56 04             	mov    0x4(%esi),%edx
 183:	90                   	nop
 184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 188:	89 d8                	mov    %ebx,%eax
 18a:	f0 87 02             	lock xchg %eax,(%edx)
}

void lock_acquire(struct lock_t *lk){
  while (xchg(&lk->lock, 1) != 0);
 18d:	85 c0                	test   %eax,%eax
 18f:	75 f7                	jne    188 <frisbee_task+0x18>
  targs *args = (targs*) arg;

  while(1){
    lock_acquire(args->lock);

    if(passes > numpass){
 191:	8b 15 d4 11 00 00    	mov    0x11d4,%edx
 197:	3b 15 e8 11 00 00    	cmp    0x11e8,%edx
 19d:	7f 60                	jg     1ff <frisbee_task+0x8f>
      lock_release(args->lock);
      break;
    }

    if(cur_owner == args->tid){
 19f:	8b 06                	mov    (%esi),%eax
 1a1:	3b 05 d8 11 00 00    	cmp    0x11d8,%eax
 1a7:	74 0f                	je     1b8 <frisbee_task+0x48>
}

void lock_release(struct lock_t *lk){
  xchg(&lk->lock, 0);
 1a9:	8b 56 04             	mov    0x4(%esi),%edx
 1ac:	31 c0                	xor    %eax,%eax
 1ae:	f0 87 02             	lock xchg %eax,(%edx)
 1b1:	eb cd                	jmp    180 <frisbee_task+0x10>
 1b3:	90                   	nop
 1b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      cur_owner++;
 1b8:	83 c0 01             	add    $0x1,%eax
      if(cur_owner >= numthreads)
 1bb:	3b 05 ec 11 00 00    	cmp    0x11ec,%eax
      cur_owner++;
 1c1:	a3 d8 11 00 00       	mov    %eax,0x11d8
      if(cur_owner >= numthreads)
 1c6:	7c 0c                	jl     1d4 <frisbee_task+0x64>
        cur_owner = 0;
 1c8:	c7 05 d8 11 00 00 00 	movl   $0x0,0x11d8
 1cf:	00 00 00 
 1d2:	31 c0                	xor    %eax,%eax

      printf(1, "Pass number: %d, Thread %d is passing the token to thread %d\n", passes, args->tid, cur_owner);
 1d4:	89 44 24 10          	mov    %eax,0x10(%esp)
 1d8:	8b 06                	mov    (%esi),%eax
 1da:	89 54 24 08          	mov    %edx,0x8(%esp)
 1de:	c7 44 24 04 2c 0c 00 	movl   $0xc2c,0x4(%esp)
 1e5:	00 
 1e6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1ed:	89 44 24 0c          	mov    %eax,0xc(%esp)
 1f1:	e8 9a 06 00 00       	call   890 <printf>
      passes++;
 1f6:	83 05 d4 11 00 00 01 	addl   $0x1,0x11d4
 1fd:	eb aa                	jmp    1a9 <frisbee_task+0x39>
 1ff:	8b 56 04             	mov    0x4(%esi),%edx
 202:	f0 87 02             	lock xchg %eax,(%edx)

    lock_release(args->lock);
  }

  return 0;
}
 205:	83 c4 20             	add    $0x20,%esp
 208:	31 c0                	xor    %eax,%eax
 20a:	5b                   	pop    %ebx
 20b:	5e                   	pop    %esi
 20c:	5d                   	pop    %ebp
 20d:	c3                   	ret    
 20e:	66 90                	xchg   %ax,%ax

00000210 <thread_create>:
void thread_create(void *(*start_routine)(void *), void *arg) {
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	56                   	push   %esi
 214:	53                   	push   %ebx
 215:	83 ec 10             	sub    $0x10,%esp
 218:	8b 5d 08             	mov    0x8(%ebp),%ebx
  void *stack = malloc(size);
 21b:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
void thread_create(void *(*start_routine)(void *), void *arg) {
 222:	8b 75 0c             	mov    0xc(%ebp),%esi
  void *stack = malloc(size);
 225:	e8 e6 08 00 00       	call   b10 <malloc>
  *(--endstack) = (uint) stack;
 22a:	89 80 fc 0f 00 00    	mov    %eax,0xffc(%eax)
  *(--endstack) = (uint) arg;
 230:	89 b0 f8 0f 00 00    	mov    %esi,0xff8(%eax)
  *(--endstack) = (uint) start_routine;
 236:	89 98 f4 0f 00 00    	mov    %ebx,0xff4(%eax)
  *(--endstack) = (uint) &thread_panic;
 23c:	c7 80 f0 0f 00 00 50 	movl   $0x150,0xff0(%eax)
 243:	01 00 00 
  *(--endstack) = (uint) &thread_routine;
 246:	c7 80 ec 0f 00 00 30 	movl   $0x130,0xfec(%eax)
 24d:	01 00 00 
  clone(stack, size);
 250:	c7 45 0c ec 0f 00 00 	movl   $0xfec,0xc(%ebp)
 257:	89 45 08             	mov    %eax,0x8(%ebp)
}
 25a:	83 c4 10             	add    $0x10,%esp
 25d:	5b                   	pop    %ebx
 25e:	5e                   	pop    %esi
 25f:	5d                   	pop    %ebp
  clone(stack, size);
 260:	e9 7d 05 00 00       	jmp    7e2 <clone>
 265:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000270 <lock_init>:
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
  lk->lock = 0;
 273:	8b 45 08             	mov    0x8(%ebp),%eax
 276:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
 27c:	5d                   	pop    %ebp
 27d:	c3                   	ret    
 27e:	66 90                	xchg   %ax,%ax

00000280 <lock_acquire>:
void lock_acquire(struct lock_t *lk){
 280:	55                   	push   %ebp
 281:	b9 01 00 00 00       	mov    $0x1,%ecx
 286:	89 e5                	mov    %esp,%ebp
 288:	8b 55 08             	mov    0x8(%ebp),%edx
 28b:	90                   	nop
 28c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 290:	89 c8                	mov    %ecx,%eax
 292:	f0 87 02             	lock xchg %eax,(%edx)
  while (xchg(&lk->lock, 1) != 0);
 295:	85 c0                	test   %eax,%eax
 297:	75 f7                	jne    290 <lock_acquire+0x10>
}
 299:	5d                   	pop    %ebp
 29a:	c3                   	ret    
 29b:	90                   	nop
 29c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002a0 <lock_release>:
void lock_release(struct lock_t *lk){
 2a0:	55                   	push   %ebp
 2a1:	31 c0                	xor    %eax,%eax
 2a3:	89 e5                	mov    %esp,%ebp
 2a5:	8b 55 08             	mov    0x8(%ebp),%edx
 2a8:	f0 87 02             	lock xchg %eax,(%edx)
}
 2ab:	5d                   	pop    %ebp
 2ac:	c3                   	ret    
 2ad:	8d 76 00             	lea    0x0(%esi),%esi

000002b0 <seqlock_init>:

/* Sequence Lock */

void seqlock_init(struct seqlock_t *lk){
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->seq = 0;
 2b6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->splk = 0;
 2bc:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
}
 2c3:	5d                   	pop    %ebp
 2c4:	c3                   	ret    
 2c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002d0 <seqlock_read>:

uint seqlock_read(struct seqlock_t *lk, uint *mem) {
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	56                   	push   %esi
 2d4:	8b 75 0c             	mov    0xc(%ebp),%esi
 2d7:	53                   	push   %ebx
 2d8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint seqi, seqf;
  uint retval;
  while (1) {
    seqi = lk->seq;
    retval = *mem;
 2db:	8b 06                	mov    (%esi),%eax
 2dd:	8b 0b                	mov    (%ebx),%ecx
    asm volatile("":: : "memory"); // prevent reordering the reads
    seqf = lk->seq;
 2df:	8b 13                	mov    (%ebx),%edx
    if ( (seqi != seqf) || (seqi & 0x1)) continue;
 2e1:	39 ca                	cmp    %ecx,%edx
 2e3:	74 0d                	je     2f2 <seqlock_read+0x22>
 2e5:	8d 76 00             	lea    0x0(%esi),%esi
 2e8:	89 d1                	mov    %edx,%ecx
    retval = *mem;
 2ea:	8b 06                	mov    (%esi),%eax
    seqf = lk->seq;
 2ec:	8b 13                	mov    (%ebx),%edx
    if ( (seqi != seqf) || (seqi & 0x1)) continue;
 2ee:	39 ca                	cmp    %ecx,%edx
 2f0:	75 f6                	jne    2e8 <seqlock_read+0x18>
 2f2:	83 e1 01             	and    $0x1,%ecx
 2f5:	75 f1                	jne    2e8 <seqlock_read+0x18>
    return retval;
  }
}
 2f7:	5b                   	pop    %ebx
 2f8:	5e                   	pop    %esi
 2f9:	5d                   	pop    %ebp
 2fa:	c3                   	ret    
 2fb:	90                   	nop
 2fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000300 <seqlock_write>:

void seqlock_write(struct seqlock_t *lk, uint *mem, uint val){
 300:	55                   	push   %ebp
 301:	b9 01 00 00 00       	mov    $0x1,%ecx
 306:	89 e5                	mov    %esp,%ebp
 308:	53                   	push   %ebx
 309:	8b 5d 08             	mov    0x8(%ebp),%ebx
 30c:	8d 53 04             	lea    0x4(%ebx),%edx
 30f:	90                   	nop
 310:	89 c8                	mov    %ecx,%eax
 312:	f0 87 02             	lock xchg %eax,(%edx)
  // spinlock to prevent write conflict
     while (xchg(&lk->splk, 1) != 0);
 315:	85 c0                	test   %eax,%eax
 317:	75 f7                	jne    310 <seqlock_write+0x10>
lk->seq++;
 319:	83 03 01             	addl   $0x1,(%ebx)
  asm volatile(""::: "memory"); // prevent reordering the writes
  *mem = val;
 31c:	8b 4d 10             	mov    0x10(%ebp),%ecx
 31f:	8b 55 0c             	mov    0xc(%ebp),%edx
 322:	89 0a                	mov    %ecx,(%edx)
  asm volatile(""::: "memory"); // prevent reordering the writes
  lk->seq++;
 324:	83 03 01             	addl   $0x1,(%ebx)
 327:	f0 87 43 04          	lock xchg %eax,0x4(%ebx)

  //release spinlock
    xchg(&lk->splk, 0);
    }
 32b:	5b                   	pop    %ebx
 32c:	5d                   	pop    %ebp
 32d:	c3                   	ret    
 32e:	66 90                	xchg   %ax,%ax

00000330 <mcslock_init>:

/* MCS Lock */

void mcslock_init(mcs_lock_t *lk){
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->next = NULL;
 336:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->spin = 0;
 33c:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
}
 343:	5d                   	pop    %ebp
 344:	c3                   	ret    
 345:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000350 <mcslock_acquire>:

void mcslock_acquire(mcs_lock_t *lk, mcs_lock_t *qnode){
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	8b 55 0c             	mov    0xc(%ebp),%edx
 356:	8b 4d 08             	mov    0x8(%ebp),%ecx
  mcs_lock_t *tail;

  qnode->next = NULL;
 359:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
 35f:	89 d0                	mov    %edx,%eax
  qnode->spin = 0;
 361:	c7 42 04 00 00 00 00 	movl   $0x0,0x4(%edx)
 368:	f0 87 01             	lock xchg %eax,(%ecx)

  // Place itself in the queue if exists
  tail = (mcs_lock_t*) xchg((uint*) &lk->next, (uint) qnode);
  if (!tail) return; // queue is empty
 36b:	85 c0                	test   %eax,%eax
 36d:	74 10                	je     37f <mcslock_acquire+0x2f>

  tail->next = qnode; // Attach after queue if present
 36f:	89 10                	mov    %edx,(%eax)
 371:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile ("" ::: "memory"); // put a memory barrier
  while (!qnode->spin);
 378:	8b 42 04             	mov    0x4(%edx),%eax
 37b:	85 c0                	test   %eax,%eax
 37d:	74 f9                	je     378 <mcslock_acquire+0x28>
  return;
}
 37f:	5d                   	pop    %ebp
 380:	c3                   	ret    
 381:	eb 0d                	jmp    390 <mcslock_release>
 383:	90                   	nop
 384:	90                   	nop
 385:	90                   	nop
 386:	90                   	nop
 387:	90                   	nop
 388:	90                   	nop
 389:	90                   	nop
 38a:	90                   	nop
 38b:	90                   	nop
 38c:	90                   	nop
 38d:	90                   	nop
 38e:	90                   	nop
 38f:	90                   	nop

00000390 <mcslock_release>:

void mcslock_release(mcs_lock_t *lk, mcs_lock_t *qnode){
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 396:	53                   	push   %ebx

  if (!qnode->next){ // No successor yet
 397:	8b 01                	mov    (%ecx),%eax
 399:	85 c0                	test   %eax,%eax
 39b:	74 0b                	je     3a8 <mcslock_release+0x18>
 // Wait for successor to update qnode
      while(!qnode->next);
        }
 //
 //         // Unlock next one
            qnode->next->spin = 1;
 39d:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
            }
 3a4:	5b                   	pop    %ebx
 3a5:	5d                   	pop    %ebp
 3a6:	c3                   	ret    
 3a7:	90                   	nop
 3a8:	8b 45 08             	mov    0x8(%ebp),%eax
 3ab:	bb 01 00 00 00       	mov    $0x1,%ebx
 3b0:	8d 50 04             	lea    0x4(%eax),%edx
 3b3:	90                   	nop
 3b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3b8:	89 d8                	mov    %ebx,%eax
 3ba:	f0 87 02             	lock xchg %eax,(%edx)
  while (xchg(&lk->spin, 1) != 0);
 3bd:	85 c0                	test   %eax,%eax
 3bf:	75 f7                	jne    3b8 <mcslock_release+0x28>
    t = lk->next;
 3c1:	8b 45 08             	mov    0x8(%ebp),%eax
 3c4:	8b 10                	mov    (%eax),%edx
    if(t == qnode) lk->next = NULL;
 3c6:	39 ca                	cmp    %ecx,%edx
 3c8:	74 16                	je     3e0 <mcslock_release+0x50>
 3ca:	31 c0                	xor    %eax,%eax
 3cc:	8b 5d 08             	mov    0x8(%ebp),%ebx
 3cf:	f0 87 43 04          	lock xchg %eax,0x4(%ebx)
    if(t == qnode) return;
 3d3:	39 ca                	cmp    %ecx,%edx
 3d5:	74 cd                	je     3a4 <mcslock_release+0x14>
 3d7:	8b 01                	mov    (%ecx),%eax
      while(!qnode->next);
 3d9:	85 c0                	test   %eax,%eax
 3db:	75 c0                	jne    39d <mcslock_release+0xd>
 3dd:	eb fe                	jmp    3dd <mcslock_release+0x4d>
 3df:	90                   	nop
    if(t == qnode) lk->next = NULL;
 3e0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
 3e6:	eb e2                	jmp    3ca <mcslock_release+0x3a>
 3e8:	90                   	nop
 3e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003f0 <arraylock_init>:

void arraylock_init(struct arraylock_t *lk, uint size)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	56                   	push   %esi
 3f4:	53                   	push   %ebx
 3f5:	83 ec 10             	sub    $0x10,%esp
 3f8:	8b 75 0c             	mov    0xc(%ebp),%esi
 3fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  lk->size = size;
  lk->lock = (uint*) malloc(lk->size * sizeof(uint));
 3fe:	8d 04 b5 00 00 00 00 	lea    0x0(,%esi,4),%eax
  lk->size = size;
 405:	89 73 0c             	mov    %esi,0xc(%ebx)
  lk->lock = (uint*) malloc(lk->size * sizeof(uint));
 408:	89 04 24             	mov    %eax,(%esp)
 40b:	e8 00 07 00 00       	call   b10 <malloc>

  int i;
  for(i = 1; i < size; i++) lk->lock[i] = 0;
 410:	83 fe 01             	cmp    $0x1,%esi
  lk->lock = (uint*) malloc(lk->size * sizeof(uint));
 413:	89 03                	mov    %eax,(%ebx)
  for(i = 1; i < size; i++) lk->lock[i] = 0;
 415:	76 25                	jbe    43c <arraylock_init+0x4c>
 417:	b9 01 00 00 00       	mov    $0x1,%ecx
 41c:	ba 01 00 00 00       	mov    $0x1,%edx
 421:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 428:	83 c2 01             	add    $0x1,%edx
 42b:	8d 04 88             	lea    (%eax,%ecx,4),%eax
 42e:	39 f2                	cmp    %esi,%edx
 430:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
 436:	89 d1                	mov    %edx,%ecx
 438:	8b 03                	mov    (%ebx),%eax
 43a:	75 ec                	jne    428 <arraylock_init+0x38>
  lk->lock[0] = 1;
 43c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)

  lk->next = 0;
 442:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  lk->m = 0;
 449:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
}
 450:	83 c4 10             	add    $0x10,%esp
 453:	5b                   	pop    %ebx
 454:	5e                   	pop    %esi
 455:	5d                   	pop    %ebp
 456:	c3                   	ret    
 457:	89 f6                	mov    %esi,%esi
 459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000460 <arraylock_acquire>:
void arraylock_acquire(struct arraylock_t *lk){
 460:	55                   	push   %ebp
 461:	b9 01 00 00 00       	mov    $0x1,%ecx
 466:	89 e5                	mov    %esp,%ebp
 468:	53                   	push   %ebx
 469:	8b 5d 08             	mov    0x8(%ebp),%ebx
 46c:	8d 53 10             	lea    0x10(%ebx),%edx
 46f:	90                   	nop
 470:	89 c8                	mov    %ecx,%eax
 472:	f0 87 02             	lock xchg %eax,(%edx)
  uint pos;
  // makeshift read-modify-write using xchg
  while (xchg(&lk->m, 1) != 0);
 475:	85 c0                	test   %eax,%eax
 477:	75 f7                	jne    470 <arraylock_acquire+0x10>
  pos = lk->next;
 479:	8b 4b 08             	mov    0x8(%ebx),%ecx
  lk->next = pos + 1;
 47c:	8d 41 01             	lea    0x1(%ecx),%eax
  if(lk->next == lk->size) lk->next = 0;
 47f:	3b 43 0c             	cmp    0xc(%ebx),%eax
  lk->next = pos + 1;
 482:	89 43 08             	mov    %eax,0x8(%ebx)
  if(lk->next == lk->size) lk->next = 0;
 485:	74 21                	je     4a8 <arraylock_acquire+0x48>
 487:	31 c0                	xor    %eax,%eax
 489:	f0 87 43 10          	lock xchg %eax,0x10(%ebx)
 48d:	8b 03                	mov    (%ebx),%eax
 48f:	8d 14 88             	lea    (%eax,%ecx,4),%edx
 492:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  xchg(&lk->m, 0);

  while(lk->lock[pos] == 0);
 498:	8b 02                	mov    (%edx),%eax
 49a:	85 c0                	test   %eax,%eax
 49c:	74 fa                	je     498 <arraylock_acquire+0x38>
  lk->lockpos = pos;
 49e:	89 4b 04             	mov    %ecx,0x4(%ebx)
}
 4a1:	5b                   	pop    %ebx
 4a2:	5d                   	pop    %ebp
 4a3:	c3                   	ret    
 4a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(lk->next == lk->size) lk->next = 0;
 4a8:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
 4af:	eb d6                	jmp    487 <arraylock_acquire+0x27>
 4b1:	eb 0d                	jmp    4c0 <arraylock_release>
 4b3:	90                   	nop
 4b4:	90                   	nop
 4b5:	90                   	nop
 4b6:	90                   	nop
 4b7:	90                   	nop
 4b8:	90                   	nop
 4b9:	90                   	nop
 4ba:	90                   	nop
 4bb:	90                   	nop
 4bc:	90                   	nop
 4bd:	90                   	nop
 4be:	90                   	nop
 4bf:	90                   	nop

000004c0 <arraylock_release>:

void arraylock_release(struct arraylock_t *lk){
 4c0:	55                   	push   %ebp
 4c1:	31 c0                	xor    %eax,%eax
 4c3:	89 e5                	mov    %esp,%ebp
 4c5:	8b 55 08             	mov    0x8(%ebp),%edx
 4c8:	56                   	push   %esi
 4c9:	53                   	push   %ebx
  uint nextpos = lk->lockpos + 1;
 4ca:	8b 4a 04             	mov    0x4(%edx),%ecx
 4cd:	8d 59 01             	lea    0x1(%ecx),%ebx
 4d0:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
 4d7:	39 5a 0c             	cmp    %ebx,0xc(%edx)
  if(nextpos == lk->size) nextpos = 0;

  lk->lock[lk->lockpos] = 0; // Clear own ticket
 4da:	8b 1a                	mov    (%edx),%ebx
 4dc:	0f 45 c6             	cmovne %esi,%eax
 4df:	8d 0c 8b             	lea    (%ebx,%ecx,4),%ecx
 4e2:	c7 01 00 00 00 00    	movl   $0x0,(%ecx)
  lk->lock[nextpos] = 1; // Set next ticket
 4e8:	03 02                	add    (%edx),%eax
 4ea:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
}
 4f0:	5b                   	pop    %ebx
 4f1:	5e                   	pop    %esi
 4f2:	5d                   	pop    %ebp
 4f3:	c3                   	ret    
 4f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000500 <arraylock_destroy>:

void arraylock_destroy(struct arraylock_t *lk){
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
  free((void *) lk->lock);
 503:	8b 45 08             	mov    0x8(%ebp),%eax
 506:	8b 00                	mov    (%eax),%eax
 508:	89 45 08             	mov    %eax,0x8(%ebp)
}
 50b:	5d                   	pop    %ebp
  free((void *) lk->lock);
 50c:	e9 6f 05 00 00       	jmp    a80 <free>
 511:	66 90                	xchg   %ax,%ax
 513:	66 90                	xchg   %ax,%ax
 515:	66 90                	xchg   %ax,%ax
 517:	66 90                	xchg   %ax,%ax
 519:	66 90                	xchg   %ax,%ax
 51b:	66 90                	xchg   %ax,%ax
 51d:	66 90                	xchg   %ax,%ax
 51f:	90                   	nop

00000520 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	8b 45 08             	mov    0x8(%ebp),%eax
 526:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 529:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 52a:	89 c2                	mov    %eax,%edx
 52c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 530:	83 c1 01             	add    $0x1,%ecx
 533:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 537:	83 c2 01             	add    $0x1,%edx
 53a:	84 db                	test   %bl,%bl
 53c:	88 5a ff             	mov    %bl,-0x1(%edx)
 53f:	75 ef                	jne    530 <strcpy+0x10>
    ;
  return os;
}
 541:	5b                   	pop    %ebx
 542:	5d                   	pop    %ebp
 543:	c3                   	ret    
 544:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 54a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000550 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	8b 55 08             	mov    0x8(%ebp),%edx
 556:	53                   	push   %ebx
 557:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 55a:	0f b6 02             	movzbl (%edx),%eax
 55d:	84 c0                	test   %al,%al
 55f:	74 2d                	je     58e <strcmp+0x3e>
 561:	0f b6 19             	movzbl (%ecx),%ebx
 564:	38 d8                	cmp    %bl,%al
 566:	74 0e                	je     576 <strcmp+0x26>
 568:	eb 2b                	jmp    595 <strcmp+0x45>
 56a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 570:	38 c8                	cmp    %cl,%al
 572:	75 15                	jne    589 <strcmp+0x39>
    p++, q++;
 574:	89 d9                	mov    %ebx,%ecx
 576:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 579:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 57c:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 57f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 583:	84 c0                	test   %al,%al
 585:	75 e9                	jne    570 <strcmp+0x20>
 587:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 589:	29 c8                	sub    %ecx,%eax
}
 58b:	5b                   	pop    %ebx
 58c:	5d                   	pop    %ebp
 58d:	c3                   	ret    
 58e:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
 591:	31 c0                	xor    %eax,%eax
 593:	eb f4                	jmp    589 <strcmp+0x39>
 595:	0f b6 cb             	movzbl %bl,%ecx
 598:	eb ef                	jmp    589 <strcmp+0x39>
 59a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000005a0 <strlen>:

uint
strlen(const char *s)
{
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 5a6:	80 39 00             	cmpb   $0x0,(%ecx)
 5a9:	74 12                	je     5bd <strlen+0x1d>
 5ab:	31 d2                	xor    %edx,%edx
 5ad:	8d 76 00             	lea    0x0(%esi),%esi
 5b0:	83 c2 01             	add    $0x1,%edx
 5b3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 5b7:	89 d0                	mov    %edx,%eax
 5b9:	75 f5                	jne    5b0 <strlen+0x10>
    ;
  return n;
}
 5bb:	5d                   	pop    %ebp
 5bc:	c3                   	ret    
  for(n = 0; s[n]; n++)
 5bd:	31 c0                	xor    %eax,%eax
}
 5bf:	5d                   	pop    %ebp
 5c0:	c3                   	ret    
 5c1:	eb 0d                	jmp    5d0 <memset>
 5c3:	90                   	nop
 5c4:	90                   	nop
 5c5:	90                   	nop
 5c6:	90                   	nop
 5c7:	90                   	nop
 5c8:	90                   	nop
 5c9:	90                   	nop
 5ca:	90                   	nop
 5cb:	90                   	nop
 5cc:	90                   	nop
 5cd:	90                   	nop
 5ce:	90                   	nop
 5cf:	90                   	nop

000005d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 5d0:	55                   	push   %ebp
 5d1:	89 e5                	mov    %esp,%ebp
 5d3:	8b 55 08             	mov    0x8(%ebp),%edx
 5d6:	57                   	push   %edi
  asm volatile("cld; rep stosb" :
 5d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 5da:	8b 45 0c             	mov    0xc(%ebp),%eax
 5dd:	89 d7                	mov    %edx,%edi
 5df:	fc                   	cld    
 5e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 5e2:	89 d0                	mov    %edx,%eax
 5e4:	5f                   	pop    %edi
 5e5:	5d                   	pop    %ebp
 5e6:	c3                   	ret    
 5e7:	89 f6                	mov    %esi,%esi
 5e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005f0 <strchr>:

char*
strchr(const char *s, char c)
{
 5f0:	55                   	push   %ebp
 5f1:	89 e5                	mov    %esp,%ebp
 5f3:	8b 45 08             	mov    0x8(%ebp),%eax
 5f6:	53                   	push   %ebx
 5f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 5fa:	0f b6 18             	movzbl (%eax),%ebx
 5fd:	84 db                	test   %bl,%bl
 5ff:	74 1d                	je     61e <strchr+0x2e>
    if(*s == c)
 601:	38 d3                	cmp    %dl,%bl
 603:	89 d1                	mov    %edx,%ecx
 605:	75 0d                	jne    614 <strchr+0x24>
 607:	eb 17                	jmp    620 <strchr+0x30>
 609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 610:	38 ca                	cmp    %cl,%dl
 612:	74 0c                	je     620 <strchr+0x30>
  for(; *s; s++)
 614:	83 c0 01             	add    $0x1,%eax
 617:	0f b6 10             	movzbl (%eax),%edx
 61a:	84 d2                	test   %dl,%dl
 61c:	75 f2                	jne    610 <strchr+0x20>
      return (char*)s;
  return 0;
 61e:	31 c0                	xor    %eax,%eax
}
 620:	5b                   	pop    %ebx
 621:	5d                   	pop    %ebp
 622:	c3                   	ret    
 623:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000630 <gets>:

char*
gets(char *buf, int max)
{
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	57                   	push   %edi
 634:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 635:	31 f6                	xor    %esi,%esi
{
 637:	53                   	push   %ebx
 638:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 63b:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 63e:	eb 31                	jmp    671 <gets+0x41>
    cc = read(0, &c, 1);
 640:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 647:	00 
 648:	89 7c 24 04          	mov    %edi,0x4(%esp)
 64c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 653:	e8 02 01 00 00       	call   75a <read>
    if(cc < 1)
 658:	85 c0                	test   %eax,%eax
 65a:	7e 1d                	jle    679 <gets+0x49>
      break;
    buf[i++] = c;
 65c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 660:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 662:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 665:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 667:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 66b:	74 0c                	je     679 <gets+0x49>
 66d:	3c 0a                	cmp    $0xa,%al
 66f:	74 08                	je     679 <gets+0x49>
  for(i=0; i+1 < max; ){
 671:	8d 5e 01             	lea    0x1(%esi),%ebx
 674:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 677:	7c c7                	jl     640 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 679:	8b 45 08             	mov    0x8(%ebp),%eax
 67c:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 680:	83 c4 2c             	add    $0x2c,%esp
 683:	5b                   	pop    %ebx
 684:	5e                   	pop    %esi
 685:	5f                   	pop    %edi
 686:	5d                   	pop    %ebp
 687:	c3                   	ret    
 688:	90                   	nop
 689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000690 <stat>:

int
stat(const char *n, struct stat *st)
{
 690:	55                   	push   %ebp
 691:	89 e5                	mov    %esp,%ebp
 693:	56                   	push   %esi
 694:	53                   	push   %ebx
 695:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 698:	8b 45 08             	mov    0x8(%ebp),%eax
 69b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 6a2:	00 
 6a3:	89 04 24             	mov    %eax,(%esp)
 6a6:	e8 d7 00 00 00       	call   782 <open>
  if(fd < 0)
 6ab:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 6ad:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 6af:	78 27                	js     6d8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 6b1:	8b 45 0c             	mov    0xc(%ebp),%eax
 6b4:	89 1c 24             	mov    %ebx,(%esp)
 6b7:	89 44 24 04          	mov    %eax,0x4(%esp)
 6bb:	e8 da 00 00 00       	call   79a <fstat>
  close(fd);
 6c0:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 6c3:	89 c6                	mov    %eax,%esi
  close(fd);
 6c5:	e8 a0 00 00 00       	call   76a <close>
  return r;
 6ca:	89 f0                	mov    %esi,%eax
}
 6cc:	83 c4 10             	add    $0x10,%esp
 6cf:	5b                   	pop    %ebx
 6d0:	5e                   	pop    %esi
 6d1:	5d                   	pop    %ebp
 6d2:	c3                   	ret    
 6d3:	90                   	nop
 6d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 6d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 6dd:	eb ed                	jmp    6cc <stat+0x3c>
 6df:	90                   	nop

000006e0 <atoi>:

int
atoi(const char *s)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 6e6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 6e7:	0f be 11             	movsbl (%ecx),%edx
 6ea:	8d 42 d0             	lea    -0x30(%edx),%eax
 6ed:	3c 09                	cmp    $0x9,%al
  n = 0;
 6ef:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 6f4:	77 17                	ja     70d <atoi+0x2d>
 6f6:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 6f8:	83 c1 01             	add    $0x1,%ecx
 6fb:	8d 04 80             	lea    (%eax,%eax,4),%eax
 6fe:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 702:	0f be 11             	movsbl (%ecx),%edx
 705:	8d 5a d0             	lea    -0x30(%edx),%ebx
 708:	80 fb 09             	cmp    $0x9,%bl
 70b:	76 eb                	jbe    6f8 <atoi+0x18>
  return n;
}
 70d:	5b                   	pop    %ebx
 70e:	5d                   	pop    %ebp
 70f:	c3                   	ret    

00000710 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 710:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 711:	31 d2                	xor    %edx,%edx
{
 713:	89 e5                	mov    %esp,%ebp
 715:	56                   	push   %esi
 716:	8b 45 08             	mov    0x8(%ebp),%eax
 719:	53                   	push   %ebx
 71a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 71d:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 720:	85 db                	test   %ebx,%ebx
 722:	7e 12                	jle    736 <memmove+0x26>
 724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 728:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 72c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 72f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 732:	39 da                	cmp    %ebx,%edx
 734:	75 f2                	jne    728 <memmove+0x18>
  return vdst;
}
 736:	5b                   	pop    %ebx
 737:	5e                   	pop    %esi
 738:	5d                   	pop    %ebp
 739:	c3                   	ret    

0000073a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 73a:	b8 01 00 00 00       	mov    $0x1,%eax
 73f:	cd 40                	int    $0x40
 741:	c3                   	ret    

00000742 <exit>:
SYSCALL(exit)
 742:	b8 02 00 00 00       	mov    $0x2,%eax
 747:	cd 40                	int    $0x40
 749:	c3                   	ret    

0000074a <wait>:
SYSCALL(wait)
 74a:	b8 03 00 00 00       	mov    $0x3,%eax
 74f:	cd 40                	int    $0x40
 751:	c3                   	ret    

00000752 <pipe>:
SYSCALL(pipe)
 752:	b8 04 00 00 00       	mov    $0x4,%eax
 757:	cd 40                	int    $0x40
 759:	c3                   	ret    

0000075a <read>:
SYSCALL(read)
 75a:	b8 05 00 00 00       	mov    $0x5,%eax
 75f:	cd 40                	int    $0x40
 761:	c3                   	ret    

00000762 <write>:
SYSCALL(write)
 762:	b8 10 00 00 00       	mov    $0x10,%eax
 767:	cd 40                	int    $0x40
 769:	c3                   	ret    

0000076a <close>:
SYSCALL(close)
 76a:	b8 15 00 00 00       	mov    $0x15,%eax
 76f:	cd 40                	int    $0x40
 771:	c3                   	ret    

00000772 <kill>:
SYSCALL(kill)
 772:	b8 06 00 00 00       	mov    $0x6,%eax
 777:	cd 40                	int    $0x40
 779:	c3                   	ret    

0000077a <exec>:
SYSCALL(exec)
 77a:	b8 07 00 00 00       	mov    $0x7,%eax
 77f:	cd 40                	int    $0x40
 781:	c3                   	ret    

00000782 <open>:
SYSCALL(open)
 782:	b8 0f 00 00 00       	mov    $0xf,%eax
 787:	cd 40                	int    $0x40
 789:	c3                   	ret    

0000078a <mknod>:
SYSCALL(mknod)
 78a:	b8 11 00 00 00       	mov    $0x11,%eax
 78f:	cd 40                	int    $0x40
 791:	c3                   	ret    

00000792 <unlink>:
SYSCALL(unlink)
 792:	b8 12 00 00 00       	mov    $0x12,%eax
 797:	cd 40                	int    $0x40
 799:	c3                   	ret    

0000079a <fstat>:
SYSCALL(fstat)
 79a:	b8 08 00 00 00       	mov    $0x8,%eax
 79f:	cd 40                	int    $0x40
 7a1:	c3                   	ret    

000007a2 <link>:
SYSCALL(link)
 7a2:	b8 13 00 00 00       	mov    $0x13,%eax
 7a7:	cd 40                	int    $0x40
 7a9:	c3                   	ret    

000007aa <mkdir>:
SYSCALL(mkdir)
 7aa:	b8 14 00 00 00       	mov    $0x14,%eax
 7af:	cd 40                	int    $0x40
 7b1:	c3                   	ret    

000007b2 <chdir>:
SYSCALL(chdir)
 7b2:	b8 09 00 00 00       	mov    $0x9,%eax
 7b7:	cd 40                	int    $0x40
 7b9:	c3                   	ret    

000007ba <dup>:
SYSCALL(dup)
 7ba:	b8 0a 00 00 00       	mov    $0xa,%eax
 7bf:	cd 40                	int    $0x40
 7c1:	c3                   	ret    

000007c2 <getpid>:
SYSCALL(getpid)
 7c2:	b8 0b 00 00 00       	mov    $0xb,%eax
 7c7:	cd 40                	int    $0x40
 7c9:	c3                   	ret    

000007ca <sbrk>:
SYSCALL(sbrk)
 7ca:	b8 0c 00 00 00       	mov    $0xc,%eax
 7cf:	cd 40                	int    $0x40
 7d1:	c3                   	ret    

000007d2 <sleep>:
SYSCALL(sleep)
 7d2:	b8 0d 00 00 00       	mov    $0xd,%eax
 7d7:	cd 40                	int    $0x40
 7d9:	c3                   	ret    

000007da <uptime>:
SYSCALL(uptime)
 7da:	b8 0e 00 00 00       	mov    $0xe,%eax
 7df:	cd 40                	int    $0x40
 7e1:	c3                   	ret    

000007e2 <clone>:
SYSCALL(clone)
 7e2:	b8 16 00 00 00       	mov    $0x16,%eax
 7e7:	cd 40                	int    $0x40
 7e9:	c3                   	ret    
 7ea:	66 90                	xchg   %ax,%ax
 7ec:	66 90                	xchg   %ax,%ax
 7ee:	66 90                	xchg   %ax,%ax

000007f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 7f0:	55                   	push   %ebp
 7f1:	89 e5                	mov    %esp,%ebp
 7f3:	57                   	push   %edi
 7f4:	56                   	push   %esi
 7f5:	89 c6                	mov    %eax,%esi
 7f7:	53                   	push   %ebx
 7f8:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 7fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 7fe:	85 db                	test   %ebx,%ebx
 800:	74 09                	je     80b <printint+0x1b>
 802:	89 d0                	mov    %edx,%eax
 804:	c1 e8 1f             	shr    $0x1f,%eax
 807:	84 c0                	test   %al,%al
 809:	75 75                	jne    880 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 80b:	89 d0                	mov    %edx,%eax
  neg = 0;
 80d:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 814:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 817:	31 ff                	xor    %edi,%edi
 819:	89 ce                	mov    %ecx,%esi
 81b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 81e:	eb 02                	jmp    822 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 820:	89 cf                	mov    %ecx,%edi
 822:	31 d2                	xor    %edx,%edx
 824:	f7 f6                	div    %esi
 826:	8d 4f 01             	lea    0x1(%edi),%ecx
 829:	0f b6 92 03 0d 00 00 	movzbl 0xd03(%edx),%edx
  }while((x /= base) != 0);
 830:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 832:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 835:	75 e9                	jne    820 <printint+0x30>
  if(neg)
 837:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 83a:	89 c8                	mov    %ecx,%eax
 83c:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 83f:	85 d2                	test   %edx,%edx
 841:	74 08                	je     84b <printint+0x5b>
    buf[i++] = '-';
 843:	8d 4f 02             	lea    0x2(%edi),%ecx
 846:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 84b:	8d 79 ff             	lea    -0x1(%ecx),%edi
 84e:	66 90                	xchg   %ax,%ax
 850:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 855:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 858:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 85f:	00 
 860:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 864:	89 34 24             	mov    %esi,(%esp)
 867:	88 45 d7             	mov    %al,-0x29(%ebp)
 86a:	e8 f3 fe ff ff       	call   762 <write>
  while(--i >= 0)
 86f:	83 ff ff             	cmp    $0xffffffff,%edi
 872:	75 dc                	jne    850 <printint+0x60>
    putc(fd, buf[i]);
}
 874:	83 c4 4c             	add    $0x4c,%esp
 877:	5b                   	pop    %ebx
 878:	5e                   	pop    %esi
 879:	5f                   	pop    %edi
 87a:	5d                   	pop    %ebp
 87b:	c3                   	ret    
 87c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 880:	89 d0                	mov    %edx,%eax
 882:	f7 d8                	neg    %eax
    neg = 1;
 884:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 88b:	eb 87                	jmp    814 <printint+0x24>
 88d:	8d 76 00             	lea    0x0(%esi),%esi

00000890 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 890:	55                   	push   %ebp
 891:	89 e5                	mov    %esp,%ebp
 893:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 894:	31 ff                	xor    %edi,%edi
{
 896:	56                   	push   %esi
 897:	53                   	push   %ebx
 898:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 89b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 89e:	8d 45 10             	lea    0x10(%ebp),%eax
{
 8a1:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 8a4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 8a7:	0f b6 13             	movzbl (%ebx),%edx
 8aa:	83 c3 01             	add    $0x1,%ebx
 8ad:	84 d2                	test   %dl,%dl
 8af:	75 39                	jne    8ea <printf+0x5a>
 8b1:	e9 c2 00 00 00       	jmp    978 <printf+0xe8>
 8b6:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 8b8:	83 fa 25             	cmp    $0x25,%edx
 8bb:	0f 84 bf 00 00 00    	je     980 <printf+0xf0>
  write(fd, &c, 1);
 8c1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 8c4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 8cb:	00 
 8cc:	89 44 24 04          	mov    %eax,0x4(%esp)
 8d0:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 8d3:	88 55 e2             	mov    %dl,-0x1e(%ebp)
  write(fd, &c, 1);
 8d6:	e8 87 fe ff ff       	call   762 <write>
 8db:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 8de:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 8e2:	84 d2                	test   %dl,%dl
 8e4:	0f 84 8e 00 00 00    	je     978 <printf+0xe8>
    if(state == 0){
 8ea:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 8ec:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 8ef:	74 c7                	je     8b8 <printf+0x28>
      }
    } else if(state == '%'){
 8f1:	83 ff 25             	cmp    $0x25,%edi
 8f4:	75 e5                	jne    8db <printf+0x4b>
      if(c == 'd'){
 8f6:	83 fa 64             	cmp    $0x64,%edx
 8f9:	0f 84 31 01 00 00    	je     a30 <printf+0x1a0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 8ff:	25 f7 00 00 00       	and    $0xf7,%eax
 904:	83 f8 70             	cmp    $0x70,%eax
 907:	0f 84 83 00 00 00    	je     990 <printf+0x100>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 90d:	83 fa 73             	cmp    $0x73,%edx
 910:	0f 84 a2 00 00 00    	je     9b8 <printf+0x128>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 916:	83 fa 63             	cmp    $0x63,%edx
 919:	0f 84 35 01 00 00    	je     a54 <printf+0x1c4>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 91f:	83 fa 25             	cmp    $0x25,%edx
 922:	0f 84 e0 00 00 00    	je     a08 <printf+0x178>
  write(fd, &c, 1);
 928:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 92b:	83 c3 01             	add    $0x1,%ebx
 92e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 935:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 936:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 938:	89 44 24 04          	mov    %eax,0x4(%esp)
 93c:	89 34 24             	mov    %esi,(%esp)
 93f:	89 55 d0             	mov    %edx,-0x30(%ebp)
 942:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 946:	e8 17 fe ff ff       	call   762 <write>
        putc(fd, c);
 94b:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 94e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 951:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 958:	00 
 959:	89 44 24 04          	mov    %eax,0x4(%esp)
 95d:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 960:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 963:	e8 fa fd ff ff       	call   762 <write>
  for(i = 0; fmt[i]; i++){
 968:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 96c:	84 d2                	test   %dl,%dl
 96e:	0f 85 76 ff ff ff    	jne    8ea <printf+0x5a>
 974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }
}
 978:	83 c4 3c             	add    $0x3c,%esp
 97b:	5b                   	pop    %ebx
 97c:	5e                   	pop    %esi
 97d:	5f                   	pop    %edi
 97e:	5d                   	pop    %ebp
 97f:	c3                   	ret    
        state = '%';
 980:	bf 25 00 00 00       	mov    $0x25,%edi
 985:	e9 51 ff ff ff       	jmp    8db <printf+0x4b>
 98a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 990:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 993:	b9 10 00 00 00       	mov    $0x10,%ecx
      state = 0;
 998:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 99a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 9a1:	8b 10                	mov    (%eax),%edx
 9a3:	89 f0                	mov    %esi,%eax
 9a5:	e8 46 fe ff ff       	call   7f0 <printint>
        ap++;
 9aa:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 9ae:	e9 28 ff ff ff       	jmp    8db <printf+0x4b>
 9b3:	90                   	nop
 9b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 9b8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 9bb:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 9bf:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 9c1:	b8 fc 0c 00 00       	mov    $0xcfc,%eax
 9c6:	85 ff                	test   %edi,%edi
 9c8:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 9cb:	0f b6 07             	movzbl (%edi),%eax
 9ce:	84 c0                	test   %al,%al
 9d0:	74 2a                	je     9fc <printf+0x16c>
 9d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 9d8:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 9db:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 9de:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 9e1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 9e8:	00 
 9e9:	89 44 24 04          	mov    %eax,0x4(%esp)
 9ed:	89 34 24             	mov    %esi,(%esp)
 9f0:	e8 6d fd ff ff       	call   762 <write>
        while(*s != 0){
 9f5:	0f b6 07             	movzbl (%edi),%eax
 9f8:	84 c0                	test   %al,%al
 9fa:	75 dc                	jne    9d8 <printf+0x148>
      state = 0;
 9fc:	31 ff                	xor    %edi,%edi
 9fe:	e9 d8 fe ff ff       	jmp    8db <printf+0x4b>
 a03:	90                   	nop
 a04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 a08:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 a0b:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 a0d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 a14:	00 
 a15:	89 44 24 04          	mov    %eax,0x4(%esp)
 a19:	89 34 24             	mov    %esi,(%esp)
 a1c:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 a20:	e8 3d fd ff ff       	call   762 <write>
 a25:	e9 b1 fe ff ff       	jmp    8db <printf+0x4b>
 a2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 a30:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 a33:	b9 0a 00 00 00       	mov    $0xa,%ecx
      state = 0;
 a38:	66 31 ff             	xor    %di,%di
        printint(fd, *ap, 10, 1);
 a3b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 a42:	8b 10                	mov    (%eax),%edx
 a44:	89 f0                	mov    %esi,%eax
 a46:	e8 a5 fd ff ff       	call   7f0 <printint>
        ap++;
 a4b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 a4f:	e9 87 fe ff ff       	jmp    8db <printf+0x4b>
        putc(fd, *ap);
 a54:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 a57:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 a59:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 a5b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 a62:	00 
 a63:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 a66:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 a69:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 a6c:	89 44 24 04          	mov    %eax,0x4(%esp)
 a70:	e8 ed fc ff ff       	call   762 <write>
        ap++;
 a75:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 a79:	e9 5d fe ff ff       	jmp    8db <printf+0x4b>
 a7e:	66 90                	xchg   %ax,%ax

00000a80 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a80:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a81:	a1 dc 11 00 00       	mov    0x11dc,%eax
{
 a86:	89 e5                	mov    %esp,%ebp
 a88:	57                   	push   %edi
 a89:	56                   	push   %esi
 a8a:	53                   	push   %ebx
 a8b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a8e:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 a90:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a93:	39 d0                	cmp    %edx,%eax
 a95:	72 11                	jb     aa8 <free+0x28>
 a97:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a98:	39 c8                	cmp    %ecx,%eax
 a9a:	72 04                	jb     aa0 <free+0x20>
 a9c:	39 ca                	cmp    %ecx,%edx
 a9e:	72 10                	jb     ab0 <free+0x30>
 aa0:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aa2:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aa4:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aa6:	73 f0                	jae    a98 <free+0x18>
 aa8:	39 ca                	cmp    %ecx,%edx
 aaa:	72 04                	jb     ab0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aac:	39 c8                	cmp    %ecx,%eax
 aae:	72 f0                	jb     aa0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 ab0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 ab3:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 ab6:	39 cf                	cmp    %ecx,%edi
 ab8:	74 1e                	je     ad8 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 aba:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 abd:	8b 48 04             	mov    0x4(%eax),%ecx
 ac0:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 ac3:	39 f2                	cmp    %esi,%edx
 ac5:	74 28                	je     aef <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 ac7:	89 10                	mov    %edx,(%eax)
  freep = p;
 ac9:	a3 dc 11 00 00       	mov    %eax,0x11dc
}
 ace:	5b                   	pop    %ebx
 acf:	5e                   	pop    %esi
 ad0:	5f                   	pop    %edi
 ad1:	5d                   	pop    %ebp
 ad2:	c3                   	ret    
 ad3:	90                   	nop
 ad4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 ad8:	03 71 04             	add    0x4(%ecx),%esi
 adb:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 ade:	8b 08                	mov    (%eax),%ecx
 ae0:	8b 09                	mov    (%ecx),%ecx
 ae2:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 ae5:	8b 48 04             	mov    0x4(%eax),%ecx
 ae8:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 aeb:	39 f2                	cmp    %esi,%edx
 aed:	75 d8                	jne    ac7 <free+0x47>
    p->s.size += bp->s.size;
 aef:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 af2:	a3 dc 11 00 00       	mov    %eax,0x11dc
    p->s.size += bp->s.size;
 af7:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 afa:	8b 53 f8             	mov    -0x8(%ebx),%edx
 afd:	89 10                	mov    %edx,(%eax)
}
 aff:	5b                   	pop    %ebx
 b00:	5e                   	pop    %esi
 b01:	5f                   	pop    %edi
 b02:	5d                   	pop    %ebp
 b03:	c3                   	ret    
 b04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 b0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000b10 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b10:	55                   	push   %ebp
 b11:	89 e5                	mov    %esp,%ebp
 b13:	57                   	push   %edi
 b14:	56                   	push   %esi
 b15:	53                   	push   %ebx
 b16:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b19:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 b1c:	8b 1d dc 11 00 00    	mov    0x11dc,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b22:	8d 48 07             	lea    0x7(%eax),%ecx
 b25:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 b28:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b2a:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 b2d:	0f 84 9b 00 00 00    	je     bce <malloc+0xbe>
 b33:	8b 13                	mov    (%ebx),%edx
 b35:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 b38:	39 fe                	cmp    %edi,%esi
 b3a:	76 64                	jbe    ba0 <malloc+0x90>
 b3c:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 b43:	bb 00 80 00 00       	mov    $0x8000,%ebx
 b48:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 b4b:	eb 0e                	jmp    b5b <malloc+0x4b>
 b4d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b50:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 b52:	8b 78 04             	mov    0x4(%eax),%edi
 b55:	39 fe                	cmp    %edi,%esi
 b57:	76 4f                	jbe    ba8 <malloc+0x98>
 b59:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b5b:	3b 15 dc 11 00 00    	cmp    0x11dc,%edx
 b61:	75 ed                	jne    b50 <malloc+0x40>
  if(nu < 4096)
 b63:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 b66:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 b6c:	bf 00 10 00 00       	mov    $0x1000,%edi
 b71:	0f 43 fe             	cmovae %esi,%edi
 b74:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 b77:	89 04 24             	mov    %eax,(%esp)
 b7a:	e8 4b fc ff ff       	call   7ca <sbrk>
  if(p == (char*)-1)
 b7f:	83 f8 ff             	cmp    $0xffffffff,%eax
 b82:	74 18                	je     b9c <malloc+0x8c>
  hp->s.size = nu;
 b84:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 b87:	83 c0 08             	add    $0x8,%eax
 b8a:	89 04 24             	mov    %eax,(%esp)
 b8d:	e8 ee fe ff ff       	call   a80 <free>
  return freep;
 b92:	8b 15 dc 11 00 00    	mov    0x11dc,%edx
      if((p = morecore(nunits)) == 0)
 b98:	85 d2                	test   %edx,%edx
 b9a:	75 b4                	jne    b50 <malloc+0x40>
        return 0;
 b9c:	31 c0                	xor    %eax,%eax
 b9e:	eb 20                	jmp    bc0 <malloc+0xb0>
    if(p->s.size >= nunits){
 ba0:	89 d0                	mov    %edx,%eax
 ba2:	89 da                	mov    %ebx,%edx
 ba4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 ba8:	39 fe                	cmp    %edi,%esi
 baa:	74 1c                	je     bc8 <malloc+0xb8>
        p->s.size -= nunits;
 bac:	29 f7                	sub    %esi,%edi
 bae:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 bb1:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 bb4:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 bb7:	89 15 dc 11 00 00    	mov    %edx,0x11dc
      return (void*)(p + 1);
 bbd:	83 c0 08             	add    $0x8,%eax
  }
}
 bc0:	83 c4 1c             	add    $0x1c,%esp
 bc3:	5b                   	pop    %ebx
 bc4:	5e                   	pop    %esi
 bc5:	5f                   	pop    %edi
 bc6:	5d                   	pop    %ebp
 bc7:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 bc8:	8b 08                	mov    (%eax),%ecx
 bca:	89 0a                	mov    %ecx,(%edx)
 bcc:	eb e9                	jmp    bb7 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 bce:	c7 05 dc 11 00 00 e0 	movl   $0x11e0,0x11dc
 bd5:	11 00 00 
    base.s.size = 0;
 bd8:	ba e0 11 00 00       	mov    $0x11e0,%edx
    base.s.ptr = freep = prevp = &base;
 bdd:	c7 05 e0 11 00 00 e0 	movl   $0x11e0,0x11e0
 be4:	11 00 00 
    base.s.size = 0;
 be7:	c7 05 e4 11 00 00 00 	movl   $0x0,0x11e4
 bee:	00 00 00 
 bf1:	e9 46 ff ff ff       	jmp    b3c <malloc+0x2c>
