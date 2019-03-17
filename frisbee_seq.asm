
_frisbee_seq:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
uint cur_owner = 0;

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

  maxpass = argc > 2 ? (uint) atoi(argv[2]) : 60;
   f:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)
  13:	0f 8f fc 00 00 00    	jg     115 <main+0x115>
  19:	c7 05 6c 12 00 00 3c 	movl   $0x3c,0x126c
  20:	00 00 00 
  numthreads = argc > 1 ? (uint) atoi(argv[1]) : 20;
  23:	b8 14 00 00 00       	mov    $0x14,%eax
  28:	0f 84 f7 00 00 00    	je     125 <main+0x125>
  2e:	a3 70 12 00 00       	mov    %eax,0x1270

  struct seqlock_t lock;
  seqlock_init(&lock);

  // Create arguments for threads
  targs *thread_args = malloc(numthreads * sizeof(targs));
  33:	c1 e0 03             	shl    $0x3,%eax
  // Record time
 int time = 0;
  time -= uptime();

  uint i;
  for(i=0; i<numthreads; i++){
  36:	31 ff                	xor    %edi,%edi
  targs *thread_args = malloc(numthreads * sizeof(targs));
  38:	89 04 24             	mov    %eax,(%esp)
  3b:	8d 74 24 18          	lea    0x18(%esp),%esi
}

/* Sequence Lock */

void seqlock_init(struct seqlock_t *lk){
  lk->seq = 0;
  3f:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  46:	00 
  lk->splk = 0;
  47:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
  4e:	00 
  4f:	e8 3c 0b 00 00       	call   b90 <malloc>
  54:	89 c3                	mov    %eax,%ebx
  time -= uptime();
  56:	e8 ff 07 00 00       	call   85a <uptime>
  5b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  for(i=0; i<numthreads; i++){
  5f:	a1 70 12 00 00       	mov    0x1270,%eax
  64:	85 c0                	test   %eax,%eax
  66:	74 68                	je     d0 <main+0xd0>
    thread_args[i].tid = i;
  68:	89 3b                	mov    %edi,(%ebx)
  for(i=0; i<numthreads; i++){
  6a:	83 c7 01             	add    $0x1,%edi
    thread_args[i].lock = &lock;
  6d:	89 73 04             	mov    %esi,0x4(%ebx)

    thread_create(&frisbee_task, (void *)&thread_args[i]);
  70:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  74:	83 c3 08             	add    $0x8,%ebx
  77:	c7 04 24 80 01 00 00 	movl   $0x180,(%esp)
  7e:	e8 0d 02 00 00       	call   290 <thread_create>
  for(i=0; i<numthreads; i++){
  83:	8b 15 70 12 00 00    	mov    0x1270,%edx
  89:	39 fa                	cmp    %edi,%edx
  8b:	77 db                	ja     68 <main+0x68>
  }

  for(i=0; i<numthreads; i++){
  8d:	85 d2                	test   %edx,%edx
  8f:	74 3f                	je     d0 <main+0xd0>
  91:	31 db                	xor    %ebx,%ebx
  93:	eb 0e                	jmp    a3 <main+0xa3>
  95:	8d 76 00             	lea    0x0(%esi),%esi
  98:	83 c3 01             	add    $0x1,%ebx
  9b:	39 1d 70 12 00 00    	cmp    %ebx,0x1270
  a1:	76 2d                	jbe    d0 <main+0xd0>
    if( wait() < 0)
  a3:	e8 22 07 00 00       	call   7ca <wait>
  a8:	85 c0                	test   %eax,%eax
  aa:	79 ec                	jns    98 <main+0x98>
      printf(1, "Sorry! Error occurred in the time of thread exiting\n");
  ac:	c7 44 24 04 44 0d 00 	movl   $0xd44,0x4(%esp)
  b3:	00 
  for(i=0; i<numthreads; i++){
  b4:	83 c3 01             	add    $0x1,%ebx
      printf(1, "Sorry! Error occurred in the time of thread exiting\n");
  b7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  be:	e8 4d 08 00 00       	call   910 <printf>
  for(i=0; i<numthreads; i++){
  c3:	39 1d 70 12 00 00    	cmp    %ebx,0x1270
  c9:	77 d8                	ja     a3 <main+0xa3>
  cb:	90                   	nop
  cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  time += uptime();
  d0:	e8 85 07 00 00       	call   85a <uptime>
  printf(1, "The FRISBEE GAME is finished, with  %d rounds\n", maxpass);
  d5:	c7 44 24 04 ec 0c 00 	movl   $0xcec,0x4(%esp)
  dc:	00 
  dd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  time += uptime();
  e4:	89 c3                	mov    %eax,%ebx
  printf(1, "The FRISBEE GAME is finished, with  %d rounds\n", maxpass);
  e6:	a1 6c 12 00 00       	mov    0x126c,%eax
  time += uptime();
  eb:	2b 5c 24 0c          	sub    0xc(%esp),%ebx
  printf(1, "The FRISBEE GAME is finished, with  %d rounds\n", maxpass);
  ef:	89 44 24 08          	mov    %eax,0x8(%esp)
  f3:	e8 18 08 00 00       	call   910 <printf>
  printf(1, "\nFrisbee Game Total Running Time: %d\n", time);
  f8:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  fc:	c7 44 24 04 1c 0d 00 	movl   $0xd1c,0x4(%esp)
 103:	00 
 104:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 10b:	e8 00 08 00 00       	call   910 <printf>

  exit();
 110:	e8 ad 06 00 00       	call   7c2 <exit>
  maxpass = argc > 2 ? (uint) atoi(argv[2]) : 60;
 115:	8b 43 08             	mov    0x8(%ebx),%eax
 118:	89 04 24             	mov    %eax,(%esp)
 11b:	e8 40 06 00 00       	call   760 <atoi>
 120:	a3 6c 12 00 00       	mov    %eax,0x126c
  numthreads = argc > 1 ? (uint) atoi(argv[1]) : 20;
 125:	8b 43 04             	mov    0x4(%ebx),%eax
 128:	89 04 24             	mov    %eax,(%esp)
 12b:	e8 30 06 00 00       	call   760 <atoi>
 130:	e9 f9 fe ff ff       	jmp    2e <main+0x2e>
 135:	66 90                	xchg   %ax,%ax
 137:	66 90                	xchg   %ax,%ax
 139:	66 90                	xchg   %ax,%ax
 13b:	66 90                	xchg   %ax,%ax
 13d:	66 90                	xchg   %ax,%ax
 13f:	90                   	nop

00000140 <thread_routine>:
void thread_routine(void *(*routine)(void *), void *arg, void *stack){
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	83 ec 18             	sub    $0x18,%esp
  (*routine)(arg);
 146:	8b 45 0c             	mov    0xc(%ebp),%eax
 149:	89 04 24             	mov    %eax,(%esp)
 14c:	ff 55 08             	call   *0x8(%ebp)
  free(stack);
 14f:	8b 45 10             	mov    0x10(%ebp),%eax
 152:	89 04 24             	mov    %eax,(%esp)
 155:	e8 a6 09 00 00       	call   b00 <free>
  exit();
 15a:	e8 63 06 00 00       	call   7c2 <exit>
 15f:	90                   	nop

00000160 <thread_panic>:
void thread_panic(void){
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	83 ec 18             	sub    $0x18,%esp
     printf(1, "** Thread shouldn't execute this instruction **\n");
 166:	c7 44 24 04 78 0c 00 	movl   $0xc78,0x4(%esp)
 16d:	00 
 16e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 175:	e8 96 07 00 00       	call   910 <printf>
   }
 17a:	c9                   	leave  
 17b:	c3                   	ret    
 17c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000180 <frisbee_task>:
}

void *frisbee_task(void *arg){
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	57                   	push   %edi
 184:	56                   	push   %esi
 185:	53                   	push   %ebx
 186:	83 ec 2c             	sub    $0x2c,%esp
 189:	8b 75 08             	mov    0x8(%ebp),%esi
  targs *args = (targs*) arg;
  uint tid = args->tid;
 18c:	8b 3e                	mov    (%esi),%edi
    if(owner != tid){ // This thread has no work to do
//      sleep(1);       // Yield so that other threads run
            continue;
                }

                    owner++; // get next owner id
 18e:	8d 47 01             	lea    0x1(%edi),%eax
 191:	89 45 dc             	mov    %eax,-0x24(%ebp)
 194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    owner = seqlock_read(args->lock, &cur_owner);
 198:	8b 4e 04             	mov    0x4(%esi),%ecx
uint seqlock_read(struct seqlock_t *lk, uint *mem) {
  uint seqi, seqf;
  uint retval;
  while (1) {
    seqi = lk->seq;
    retval = *mem;
 19b:	8b 1d 5c 12 00 00    	mov    0x125c,%ebx
 1a1:	8b 11                	mov    (%ecx),%edx
    asm volatile("":: : "memory"); // prevent reordering the reads
    seqf = lk->seq;
 1a3:	8b 01                	mov    (%ecx),%eax
    if ( (seqi != seqf) || (seqi & 0x1)) continue;
 1a5:	39 d0                	cmp    %edx,%eax
 1a7:	74 15                	je     1be <frisbee_task+0x3e>
 1a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1b0:	89 c2                	mov    %eax,%edx
    retval = *mem;
 1b2:	8b 1d 5c 12 00 00    	mov    0x125c,%ebx
    seqf = lk->seq;
 1b8:	8b 01                	mov    (%ecx),%eax
    if ( (seqi != seqf) || (seqi & 0x1)) continue;
 1ba:	39 d0                	cmp    %edx,%eax
 1bc:	75 f2                	jne    1b0 <frisbee_task+0x30>
 1be:	83 e2 01             	and    $0x1,%edx
 1c1:	75 ed                	jne    1b0 <frisbee_task+0x30>
    cpass = passes;
 1c3:	a1 58 12 00 00       	mov    0x1258,%eax
    if(cpass > maxpass) break;
 1c8:	3b 05 6c 12 00 00    	cmp    0x126c,%eax
 1ce:	0f 87 a4 00 00 00    	ja     278 <frisbee_task+0xf8>
    if(owner != tid){ // This thread has no work to do
 1d4:	39 df                	cmp    %ebx,%edi
 1d6:	75 c0                	jne    198 <frisbee_task+0x18>
                        if(owner >= numthreads) owner = 0;
 1d8:	8b 4d dc             	mov    -0x24(%ebp),%ecx
 1db:	bb 00 00 00 00       	mov    $0x0,%ebx
 1e0:	3b 0d 70 12 00 00    	cmp    0x1270,%ecx

                            printf(1, "Pass number: %d, Thread %d is passing the token to thread %d\n", passes, tid, owner);
 1e6:	89 44 24 08          	mov    %eax,0x8(%esp)
 1ea:	89 7c 24 0c          	mov    %edi,0xc(%esp)
                        if(owner >= numthreads) owner = 0;
 1ee:	0f 42 d9             	cmovb  %ecx,%ebx
                            printf(1, "Pass number: %d, Thread %d is passing the token to thread %d\n", passes, tid, owner);
 1f1:	89 5c 24 10          	mov    %ebx,0x10(%esp)
 1f5:	c7 44 24 04 ac 0c 00 	movl   $0xcac,0x4(%esp)
 1fc:	00 
 1fd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
                        if(owner >= numthreads) owner = 0;
 204:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
                            printf(1, "Pass number: %d, Thread %d is passing the token to thread %d\n", passes, tid, owner);
 207:	e8 04 07 00 00       	call   910 <printf>

                                seqlock_write(args->lock, &passes, passes + 1);
 20c:	a1 58 12 00 00       	mov    0x1258,%eax
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
 211:	b9 01 00 00 00       	mov    $0x1,%ecx
 216:	8b 5e 04             	mov    0x4(%esi),%ebx
 219:	83 c0 01             	add    $0x1,%eax
 21c:	89 45 e0             	mov    %eax,-0x20(%ebp)
 21f:	8d 53 04             	lea    0x4(%ebx),%edx
 222:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 228:	89 c8                	mov    %ecx,%eax
 22a:	f0 87 02             	lock xchg %eax,(%edx)
  }
}

void seqlock_write(struct seqlock_t *lk, uint *mem, uint val){
  // spinlock to prevent write conflict
     while (xchg(&lk->splk, 1) != 0);
 22d:	85 c0                	test   %eax,%eax
 22f:	75 f7                	jne    228 <frisbee_task+0xa8>
lk->seq++;
 231:	83 03 01             	addl   $0x1,(%ebx)
  asm volatile(""::: "memory"); // prevent reordering the writes
  *mem = val;
 234:	8b 4d e0             	mov    -0x20(%ebp),%ecx
 237:	89 0d 58 12 00 00    	mov    %ecx,0x1258
  asm volatile(""::: "memory"); // prevent reordering the writes
  lk->seq++;
 23d:	83 03 01             	addl   $0x1,(%ebx)
 240:	f0 87 43 04          	lock xchg %eax,0x4(%ebx)
                                    seqlock_write(args->lock, &cur_owner, owner);
 244:	8b 5e 04             	mov    0x4(%esi),%ebx
 247:	b9 01 00 00 00       	mov    $0x1,%ecx
 24c:	8d 53 04             	lea    0x4(%ebx),%edx
 24f:	90                   	nop
 250:	89 c8                	mov    %ecx,%eax
 252:	f0 87 02             	lock xchg %eax,(%edx)
     while (xchg(&lk->splk, 1) != 0);
 255:	85 c0                	test   %eax,%eax
 257:	75 f7                	jne    250 <frisbee_task+0xd0>
lk->seq++;
 259:	83 03 01             	addl   $0x1,(%ebx)
  *mem = val;
 25c:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 25f:	89 0d 5c 12 00 00    	mov    %ecx,0x125c
  lk->seq++;
 265:	83 03 01             	addl   $0x1,(%ebx)
 268:	f0 87 43 04          	lock xchg %eax,0x4(%ebx)
 26c:	e9 27 ff ff ff       	jmp    198 <frisbee_task+0x18>
 271:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                                      }

                                        return 0;
                                        }
 278:	83 c4 2c             	add    $0x2c,%esp
 27b:	31 c0                	xor    %eax,%eax
 27d:	5b                   	pop    %ebx
 27e:	5e                   	pop    %esi
 27f:	5f                   	pop    %edi
 280:	5d                   	pop    %ebp
 281:	c3                   	ret    
 282:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000290 <thread_create>:
void thread_create(void *(*start_routine)(void *), void *arg) {
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	56                   	push   %esi
 294:	53                   	push   %ebx
 295:	83 ec 10             	sub    $0x10,%esp
 298:	8b 5d 08             	mov    0x8(%ebp),%ebx
  void *stack = malloc(size);
 29b:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
void thread_create(void *(*start_routine)(void *), void *arg) {
 2a2:	8b 75 0c             	mov    0xc(%ebp),%esi
  void *stack = malloc(size);
 2a5:	e8 e6 08 00 00       	call   b90 <malloc>
  *(--endstack) = (uint) stack;
 2aa:	89 80 fc 0f 00 00    	mov    %eax,0xffc(%eax)
  *(--endstack) = (uint) arg;
 2b0:	89 b0 f8 0f 00 00    	mov    %esi,0xff8(%eax)
  *(--endstack) = (uint) start_routine;
 2b6:	89 98 f4 0f 00 00    	mov    %ebx,0xff4(%eax)
  *(--endstack) = (uint) &thread_panic;
 2bc:	c7 80 f0 0f 00 00 60 	movl   $0x160,0xff0(%eax)
 2c3:	01 00 00 
  *(--endstack) = (uint) &thread_routine;
 2c6:	c7 80 ec 0f 00 00 40 	movl   $0x140,0xfec(%eax)
 2cd:	01 00 00 
  clone(stack, size);
 2d0:	c7 45 0c ec 0f 00 00 	movl   $0xfec,0xc(%ebp)
 2d7:	89 45 08             	mov    %eax,0x8(%ebp)
}
 2da:	83 c4 10             	add    $0x10,%esp
 2dd:	5b                   	pop    %ebx
 2de:	5e                   	pop    %esi
 2df:	5d                   	pop    %ebp
  clone(stack, size);
 2e0:	e9 7d 05 00 00       	jmp    862 <clone>
 2e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002f0 <lock_init>:
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
  lk->lock = 0;
 2f3:	8b 45 08             	mov    0x8(%ebp),%eax
 2f6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
 2fc:	5d                   	pop    %ebp
 2fd:	c3                   	ret    
 2fe:	66 90                	xchg   %ax,%ax

00000300 <lock_acquire>:
void lock_acquire(struct lock_t *lk){
 300:	55                   	push   %ebp
 301:	b9 01 00 00 00       	mov    $0x1,%ecx
 306:	89 e5                	mov    %esp,%ebp
 308:	8b 55 08             	mov    0x8(%ebp),%edx
 30b:	90                   	nop
 30c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 310:	89 c8                	mov    %ecx,%eax
 312:	f0 87 02             	lock xchg %eax,(%edx)
  while (xchg(&lk->lock, 1) != 0);
 315:	85 c0                	test   %eax,%eax
 317:	75 f7                	jne    310 <lock_acquire+0x10>
}
 319:	5d                   	pop    %ebp
 31a:	c3                   	ret    
 31b:	90                   	nop
 31c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000320 <lock_release>:
void lock_release(struct lock_t *lk){
 320:	55                   	push   %ebp
 321:	31 c0                	xor    %eax,%eax
 323:	89 e5                	mov    %esp,%ebp
 325:	8b 55 08             	mov    0x8(%ebp),%edx
 328:	f0 87 02             	lock xchg %eax,(%edx)
}
 32b:	5d                   	pop    %ebp
 32c:	c3                   	ret    
 32d:	8d 76 00             	lea    0x0(%esi),%esi

00000330 <seqlock_init>:
void seqlock_init(struct seqlock_t *lk){
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->seq = 0;
 336:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->splk = 0;
 33c:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
}
 343:	5d                   	pop    %ebp
 344:	c3                   	ret    
 345:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000350 <seqlock_read>:
uint seqlock_read(struct seqlock_t *lk, uint *mem) {
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	56                   	push   %esi
 354:	8b 75 0c             	mov    0xc(%ebp),%esi
 357:	53                   	push   %ebx
 358:	8b 5d 08             	mov    0x8(%ebp),%ebx
    retval = *mem;
 35b:	8b 06                	mov    (%esi),%eax
 35d:	8b 0b                	mov    (%ebx),%ecx
    seqf = lk->seq;
 35f:	8b 13                	mov    (%ebx),%edx
    if ( (seqi != seqf) || (seqi & 0x1)) continue;
 361:	39 ca                	cmp    %ecx,%edx
 363:	74 0d                	je     372 <seqlock_read+0x22>
 365:	8d 76 00             	lea    0x0(%esi),%esi
 368:	89 d1                	mov    %edx,%ecx
    retval = *mem;
 36a:	8b 06                	mov    (%esi),%eax
    seqf = lk->seq;
 36c:	8b 13                	mov    (%ebx),%edx
    if ( (seqi != seqf) || (seqi & 0x1)) continue;
 36e:	39 ca                	cmp    %ecx,%edx
 370:	75 f6                	jne    368 <seqlock_read+0x18>
 372:	83 e1 01             	and    $0x1,%ecx
 375:	75 f1                	jne    368 <seqlock_read+0x18>
}
 377:	5b                   	pop    %ebx
 378:	5e                   	pop    %esi
 379:	5d                   	pop    %ebp
 37a:	c3                   	ret    
 37b:	90                   	nop
 37c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000380 <seqlock_write>:
void seqlock_write(struct seqlock_t *lk, uint *mem, uint val){
 380:	55                   	push   %ebp
 381:	b9 01 00 00 00       	mov    $0x1,%ecx
 386:	89 e5                	mov    %esp,%ebp
 388:	53                   	push   %ebx
 389:	8b 5d 08             	mov    0x8(%ebp),%ebx
 38c:	8d 53 04             	lea    0x4(%ebx),%edx
 38f:	90                   	nop
 390:	89 c8                	mov    %ecx,%eax
 392:	f0 87 02             	lock xchg %eax,(%edx)
     while (xchg(&lk->splk, 1) != 0);
 395:	85 c0                	test   %eax,%eax
 397:	75 f7                	jne    390 <seqlock_write+0x10>
lk->seq++;
 399:	83 03 01             	addl   $0x1,(%ebx)
  *mem = val;
 39c:	8b 4d 10             	mov    0x10(%ebp),%ecx
 39f:	8b 55 0c             	mov    0xc(%ebp),%edx
 3a2:	89 0a                	mov    %ecx,(%edx)
  lk->seq++;
 3a4:	83 03 01             	addl   $0x1,(%ebx)
 3a7:	f0 87 43 04          	lock xchg %eax,0x4(%ebx)

  //release spinlock
    xchg(&lk->splk, 0);
    }
 3ab:	5b                   	pop    %ebx
 3ac:	5d                   	pop    %ebp
 3ad:	c3                   	ret    
 3ae:	66 90                	xchg   %ax,%ax

000003b0 <mcslock_init>:

/* MCS Lock */

void mcslock_init(mcs_lock_t *lk){
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->next = NULL;
 3b6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->spin = 0;
 3bc:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
}
 3c3:	5d                   	pop    %ebp
 3c4:	c3                   	ret    
 3c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003d0 <mcslock_acquire>:

void mcslock_acquire(mcs_lock_t *lk, mcs_lock_t *qnode){
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	8b 55 0c             	mov    0xc(%ebp),%edx
 3d6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  mcs_lock_t *tail;

  qnode->next = NULL;
 3d9:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
 3df:	89 d0                	mov    %edx,%eax
  qnode->spin = 0;
 3e1:	c7 42 04 00 00 00 00 	movl   $0x0,0x4(%edx)
 3e8:	f0 87 01             	lock xchg %eax,(%ecx)

  // Place itself in the queue if exists
  tail = (mcs_lock_t*) xchg((uint*) &lk->next, (uint) qnode);
  if (!tail) return; // queue is empty
 3eb:	85 c0                	test   %eax,%eax
 3ed:	74 10                	je     3ff <mcslock_acquire+0x2f>

  tail->next = qnode; // Attach after queue if present
 3ef:	89 10                	mov    %edx,(%eax)
 3f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile ("" ::: "memory"); // put a memory barrier
  while (!qnode->spin);
 3f8:	8b 42 04             	mov    0x4(%edx),%eax
 3fb:	85 c0                	test   %eax,%eax
 3fd:	74 f9                	je     3f8 <mcslock_acquire+0x28>
  return;
}
 3ff:	5d                   	pop    %ebp
 400:	c3                   	ret    
 401:	eb 0d                	jmp    410 <mcslock_release>
 403:	90                   	nop
 404:	90                   	nop
 405:	90                   	nop
 406:	90                   	nop
 407:	90                   	nop
 408:	90                   	nop
 409:	90                   	nop
 40a:	90                   	nop
 40b:	90                   	nop
 40c:	90                   	nop
 40d:	90                   	nop
 40e:	90                   	nop
 40f:	90                   	nop

00000410 <mcslock_release>:

void mcslock_release(mcs_lock_t *lk, mcs_lock_t *qnode){
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 416:	53                   	push   %ebx

  if (!qnode->next){ // No successor yet
 417:	8b 01                	mov    (%ecx),%eax
 419:	85 c0                	test   %eax,%eax
 41b:	74 0b                	je     428 <mcslock_release+0x18>
 // Wait for successor to update qnode
      while(!qnode->next);
        }
 //
 //         // Unlock next one
            qnode->next->spin = 1;
 41d:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
            }
 424:	5b                   	pop    %ebx
 425:	5d                   	pop    %ebp
 426:	c3                   	ret    
 427:	90                   	nop
 428:	8b 45 08             	mov    0x8(%ebp),%eax
 42b:	bb 01 00 00 00       	mov    $0x1,%ebx
 430:	8d 50 04             	lea    0x4(%eax),%edx
 433:	90                   	nop
 434:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 438:	89 d8                	mov    %ebx,%eax
 43a:	f0 87 02             	lock xchg %eax,(%edx)
  while (xchg(&lk->spin, 1) != 0);
 43d:	85 c0                	test   %eax,%eax
 43f:	75 f7                	jne    438 <mcslock_release+0x28>
    t = lk->next;
 441:	8b 45 08             	mov    0x8(%ebp),%eax
 444:	8b 10                	mov    (%eax),%edx
    if(t == qnode) lk->next = NULL;
 446:	39 ca                	cmp    %ecx,%edx
 448:	74 16                	je     460 <mcslock_release+0x50>
 44a:	31 c0                	xor    %eax,%eax
 44c:	8b 5d 08             	mov    0x8(%ebp),%ebx
 44f:	f0 87 43 04          	lock xchg %eax,0x4(%ebx)
    if(t == qnode) return;
 453:	39 ca                	cmp    %ecx,%edx
 455:	74 cd                	je     424 <mcslock_release+0x14>
 457:	8b 01                	mov    (%ecx),%eax
      while(!qnode->next);
 459:	85 c0                	test   %eax,%eax
 45b:	75 c0                	jne    41d <mcslock_release+0xd>
 45d:	eb fe                	jmp    45d <mcslock_release+0x4d>
 45f:	90                   	nop
    if(t == qnode) lk->next = NULL;
 460:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
 466:	eb e2                	jmp    44a <mcslock_release+0x3a>
 468:	90                   	nop
 469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000470 <arraylock_init>:

void arraylock_init(struct arraylock_t *lk, uint size)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	56                   	push   %esi
 474:	53                   	push   %ebx
 475:	83 ec 10             	sub    $0x10,%esp
 478:	8b 75 0c             	mov    0xc(%ebp),%esi
 47b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  lk->size = size;
  lk->lock = (uint*) malloc(lk->size * sizeof(uint));
 47e:	8d 04 b5 00 00 00 00 	lea    0x0(,%esi,4),%eax
  lk->size = size;
 485:	89 73 0c             	mov    %esi,0xc(%ebx)
  lk->lock = (uint*) malloc(lk->size * sizeof(uint));
 488:	89 04 24             	mov    %eax,(%esp)
 48b:	e8 00 07 00 00       	call   b90 <malloc>

  int i;
  for(i = 1; i < size; i++) lk->lock[i] = 0;
 490:	83 fe 01             	cmp    $0x1,%esi
  lk->lock = (uint*) malloc(lk->size * sizeof(uint));
 493:	89 03                	mov    %eax,(%ebx)
  for(i = 1; i < size; i++) lk->lock[i] = 0;
 495:	76 25                	jbe    4bc <arraylock_init+0x4c>
 497:	b9 01 00 00 00       	mov    $0x1,%ecx
 49c:	ba 01 00 00 00       	mov    $0x1,%edx
 4a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4a8:	83 c2 01             	add    $0x1,%edx
 4ab:	8d 04 88             	lea    (%eax,%ecx,4),%eax
 4ae:	39 f2                	cmp    %esi,%edx
 4b0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
 4b6:	89 d1                	mov    %edx,%ecx
 4b8:	8b 03                	mov    (%ebx),%eax
 4ba:	75 ec                	jne    4a8 <arraylock_init+0x38>
  lk->lock[0] = 1;
 4bc:	c7 00 01 00 00 00    	movl   $0x1,(%eax)

  lk->next = 0;
 4c2:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  lk->m = 0;
 4c9:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
}
 4d0:	83 c4 10             	add    $0x10,%esp
 4d3:	5b                   	pop    %ebx
 4d4:	5e                   	pop    %esi
 4d5:	5d                   	pop    %ebp
 4d6:	c3                   	ret    
 4d7:	89 f6                	mov    %esi,%esi
 4d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004e0 <arraylock_acquire>:
void arraylock_acquire(struct arraylock_t *lk){
 4e0:	55                   	push   %ebp
 4e1:	b9 01 00 00 00       	mov    $0x1,%ecx
 4e6:	89 e5                	mov    %esp,%ebp
 4e8:	53                   	push   %ebx
 4e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
 4ec:	8d 53 10             	lea    0x10(%ebx),%edx
 4ef:	90                   	nop
 4f0:	89 c8                	mov    %ecx,%eax
 4f2:	f0 87 02             	lock xchg %eax,(%edx)
  uint pos;
  // makeshift read-modify-write using xchg
  while (xchg(&lk->m, 1) != 0);
 4f5:	85 c0                	test   %eax,%eax
 4f7:	75 f7                	jne    4f0 <arraylock_acquire+0x10>
  pos = lk->next;
 4f9:	8b 4b 08             	mov    0x8(%ebx),%ecx
  lk->next = pos + 1;
 4fc:	8d 41 01             	lea    0x1(%ecx),%eax
  if(lk->next == lk->size) lk->next = 0;
 4ff:	3b 43 0c             	cmp    0xc(%ebx),%eax
  lk->next = pos + 1;
 502:	89 43 08             	mov    %eax,0x8(%ebx)
  if(lk->next == lk->size) lk->next = 0;
 505:	74 21                	je     528 <arraylock_acquire+0x48>
 507:	31 c0                	xor    %eax,%eax
 509:	f0 87 43 10          	lock xchg %eax,0x10(%ebx)
 50d:	8b 03                	mov    (%ebx),%eax
 50f:	8d 14 88             	lea    (%eax,%ecx,4),%edx
 512:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  xchg(&lk->m, 0);

  while(lk->lock[pos] == 0);
 518:	8b 02                	mov    (%edx),%eax
 51a:	85 c0                	test   %eax,%eax
 51c:	74 fa                	je     518 <arraylock_acquire+0x38>
  lk->lockpos = pos;
 51e:	89 4b 04             	mov    %ecx,0x4(%ebx)
}
 521:	5b                   	pop    %ebx
 522:	5d                   	pop    %ebp
 523:	c3                   	ret    
 524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(lk->next == lk->size) lk->next = 0;
 528:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
 52f:	eb d6                	jmp    507 <arraylock_acquire+0x27>
 531:	eb 0d                	jmp    540 <arraylock_release>
 533:	90                   	nop
 534:	90                   	nop
 535:	90                   	nop
 536:	90                   	nop
 537:	90                   	nop
 538:	90                   	nop
 539:	90                   	nop
 53a:	90                   	nop
 53b:	90                   	nop
 53c:	90                   	nop
 53d:	90                   	nop
 53e:	90                   	nop
 53f:	90                   	nop

00000540 <arraylock_release>:

void arraylock_release(struct arraylock_t *lk){
 540:	55                   	push   %ebp
 541:	31 c0                	xor    %eax,%eax
 543:	89 e5                	mov    %esp,%ebp
 545:	8b 55 08             	mov    0x8(%ebp),%edx
 548:	56                   	push   %esi
 549:	53                   	push   %ebx
  uint nextpos = lk->lockpos + 1;
 54a:	8b 4a 04             	mov    0x4(%edx),%ecx
 54d:	8d 59 01             	lea    0x1(%ecx),%ebx
 550:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
 557:	39 5a 0c             	cmp    %ebx,0xc(%edx)
  if(nextpos == lk->size) nextpos = 0;

  lk->lock[lk->lockpos] = 0; // Clear own ticket
 55a:	8b 1a                	mov    (%edx),%ebx
 55c:	0f 45 c6             	cmovne %esi,%eax
 55f:	8d 0c 8b             	lea    (%ebx,%ecx,4),%ecx
 562:	c7 01 00 00 00 00    	movl   $0x0,(%ecx)
  lk->lock[nextpos] = 1; // Set next ticket
 568:	03 02                	add    (%edx),%eax
 56a:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
}
 570:	5b                   	pop    %ebx
 571:	5e                   	pop    %esi
 572:	5d                   	pop    %ebp
 573:	c3                   	ret    
 574:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 57a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000580 <arraylock_destroy>:

void arraylock_destroy(struct arraylock_t *lk){
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
  free((void *) lk->lock);
 583:	8b 45 08             	mov    0x8(%ebp),%eax
 586:	8b 00                	mov    (%eax),%eax
 588:	89 45 08             	mov    %eax,0x8(%ebp)
}
 58b:	5d                   	pop    %ebp
  free((void *) lk->lock);
 58c:	e9 6f 05 00 00       	jmp    b00 <free>
 591:	66 90                	xchg   %ax,%ax
 593:	66 90                	xchg   %ax,%ax
 595:	66 90                	xchg   %ax,%ax
 597:	66 90                	xchg   %ax,%ax
 599:	66 90                	xchg   %ax,%ax
 59b:	66 90                	xchg   %ax,%ax
 59d:	66 90                	xchg   %ax,%ax
 59f:	90                   	nop

000005a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	8b 45 08             	mov    0x8(%ebp),%eax
 5a6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 5a9:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 5aa:	89 c2                	mov    %eax,%edx
 5ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5b0:	83 c1 01             	add    $0x1,%ecx
 5b3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 5b7:	83 c2 01             	add    $0x1,%edx
 5ba:	84 db                	test   %bl,%bl
 5bc:	88 5a ff             	mov    %bl,-0x1(%edx)
 5bf:	75 ef                	jne    5b0 <strcpy+0x10>
    ;
  return os;
}
 5c1:	5b                   	pop    %ebx
 5c2:	5d                   	pop    %ebp
 5c3:	c3                   	ret    
 5c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000005d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 5d0:	55                   	push   %ebp
 5d1:	89 e5                	mov    %esp,%ebp
 5d3:	8b 55 08             	mov    0x8(%ebp),%edx
 5d6:	53                   	push   %ebx
 5d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 5da:	0f b6 02             	movzbl (%edx),%eax
 5dd:	84 c0                	test   %al,%al
 5df:	74 2d                	je     60e <strcmp+0x3e>
 5e1:	0f b6 19             	movzbl (%ecx),%ebx
 5e4:	38 d8                	cmp    %bl,%al
 5e6:	74 0e                	je     5f6 <strcmp+0x26>
 5e8:	eb 2b                	jmp    615 <strcmp+0x45>
 5ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5f0:	38 c8                	cmp    %cl,%al
 5f2:	75 15                	jne    609 <strcmp+0x39>
    p++, q++;
 5f4:	89 d9                	mov    %ebx,%ecx
 5f6:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 5f9:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 5fc:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 5ff:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 603:	84 c0                	test   %al,%al
 605:	75 e9                	jne    5f0 <strcmp+0x20>
 607:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 609:	29 c8                	sub    %ecx,%eax
}
 60b:	5b                   	pop    %ebx
 60c:	5d                   	pop    %ebp
 60d:	c3                   	ret    
 60e:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
 611:	31 c0                	xor    %eax,%eax
 613:	eb f4                	jmp    609 <strcmp+0x39>
 615:	0f b6 cb             	movzbl %bl,%ecx
 618:	eb ef                	jmp    609 <strcmp+0x39>
 61a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000620 <strlen>:

uint
strlen(const char *s)
{
 620:	55                   	push   %ebp
 621:	89 e5                	mov    %esp,%ebp
 623:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 626:	80 39 00             	cmpb   $0x0,(%ecx)
 629:	74 12                	je     63d <strlen+0x1d>
 62b:	31 d2                	xor    %edx,%edx
 62d:	8d 76 00             	lea    0x0(%esi),%esi
 630:	83 c2 01             	add    $0x1,%edx
 633:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 637:	89 d0                	mov    %edx,%eax
 639:	75 f5                	jne    630 <strlen+0x10>
    ;
  return n;
}
 63b:	5d                   	pop    %ebp
 63c:	c3                   	ret    
  for(n = 0; s[n]; n++)
 63d:	31 c0                	xor    %eax,%eax
}
 63f:	5d                   	pop    %ebp
 640:	c3                   	ret    
 641:	eb 0d                	jmp    650 <memset>
 643:	90                   	nop
 644:	90                   	nop
 645:	90                   	nop
 646:	90                   	nop
 647:	90                   	nop
 648:	90                   	nop
 649:	90                   	nop
 64a:	90                   	nop
 64b:	90                   	nop
 64c:	90                   	nop
 64d:	90                   	nop
 64e:	90                   	nop
 64f:	90                   	nop

00000650 <memset>:

void*
memset(void *dst, int c, uint n)
{
 650:	55                   	push   %ebp
 651:	89 e5                	mov    %esp,%ebp
 653:	8b 55 08             	mov    0x8(%ebp),%edx
 656:	57                   	push   %edi
  asm volatile("cld; rep stosb" :
 657:	8b 4d 10             	mov    0x10(%ebp),%ecx
 65a:	8b 45 0c             	mov    0xc(%ebp),%eax
 65d:	89 d7                	mov    %edx,%edi
 65f:	fc                   	cld    
 660:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 662:	89 d0                	mov    %edx,%eax
 664:	5f                   	pop    %edi
 665:	5d                   	pop    %ebp
 666:	c3                   	ret    
 667:	89 f6                	mov    %esi,%esi
 669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000670 <strchr>:

char*
strchr(const char *s, char c)
{
 670:	55                   	push   %ebp
 671:	89 e5                	mov    %esp,%ebp
 673:	8b 45 08             	mov    0x8(%ebp),%eax
 676:	53                   	push   %ebx
 677:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 67a:	0f b6 18             	movzbl (%eax),%ebx
 67d:	84 db                	test   %bl,%bl
 67f:	74 1d                	je     69e <strchr+0x2e>
    if(*s == c)
 681:	38 d3                	cmp    %dl,%bl
 683:	89 d1                	mov    %edx,%ecx
 685:	75 0d                	jne    694 <strchr+0x24>
 687:	eb 17                	jmp    6a0 <strchr+0x30>
 689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 690:	38 ca                	cmp    %cl,%dl
 692:	74 0c                	je     6a0 <strchr+0x30>
  for(; *s; s++)
 694:	83 c0 01             	add    $0x1,%eax
 697:	0f b6 10             	movzbl (%eax),%edx
 69a:	84 d2                	test   %dl,%dl
 69c:	75 f2                	jne    690 <strchr+0x20>
      return (char*)s;
  return 0;
 69e:	31 c0                	xor    %eax,%eax
}
 6a0:	5b                   	pop    %ebx
 6a1:	5d                   	pop    %ebp
 6a2:	c3                   	ret    
 6a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006b0 <gets>:

char*
gets(char *buf, int max)
{
 6b0:	55                   	push   %ebp
 6b1:	89 e5                	mov    %esp,%ebp
 6b3:	57                   	push   %edi
 6b4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 6b5:	31 f6                	xor    %esi,%esi
{
 6b7:	53                   	push   %ebx
 6b8:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 6bb:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 6be:	eb 31                	jmp    6f1 <gets+0x41>
    cc = read(0, &c, 1);
 6c0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6c7:	00 
 6c8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 6cc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 6d3:	e8 02 01 00 00       	call   7da <read>
    if(cc < 1)
 6d8:	85 c0                	test   %eax,%eax
 6da:	7e 1d                	jle    6f9 <gets+0x49>
      break;
    buf[i++] = c;
 6dc:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 6e0:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 6e2:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 6e5:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 6e7:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 6eb:	74 0c                	je     6f9 <gets+0x49>
 6ed:	3c 0a                	cmp    $0xa,%al
 6ef:	74 08                	je     6f9 <gets+0x49>
  for(i=0; i+1 < max; ){
 6f1:	8d 5e 01             	lea    0x1(%esi),%ebx
 6f4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 6f7:	7c c7                	jl     6c0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 6f9:	8b 45 08             	mov    0x8(%ebp),%eax
 6fc:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 700:	83 c4 2c             	add    $0x2c,%esp
 703:	5b                   	pop    %ebx
 704:	5e                   	pop    %esi
 705:	5f                   	pop    %edi
 706:	5d                   	pop    %ebp
 707:	c3                   	ret    
 708:	90                   	nop
 709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000710 <stat>:

int
stat(const char *n, struct stat *st)
{
 710:	55                   	push   %ebp
 711:	89 e5                	mov    %esp,%ebp
 713:	56                   	push   %esi
 714:	53                   	push   %ebx
 715:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 718:	8b 45 08             	mov    0x8(%ebp),%eax
 71b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 722:	00 
 723:	89 04 24             	mov    %eax,(%esp)
 726:	e8 d7 00 00 00       	call   802 <open>
  if(fd < 0)
 72b:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 72d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 72f:	78 27                	js     758 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 731:	8b 45 0c             	mov    0xc(%ebp),%eax
 734:	89 1c 24             	mov    %ebx,(%esp)
 737:	89 44 24 04          	mov    %eax,0x4(%esp)
 73b:	e8 da 00 00 00       	call   81a <fstat>
  close(fd);
 740:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 743:	89 c6                	mov    %eax,%esi
  close(fd);
 745:	e8 a0 00 00 00       	call   7ea <close>
  return r;
 74a:	89 f0                	mov    %esi,%eax
}
 74c:	83 c4 10             	add    $0x10,%esp
 74f:	5b                   	pop    %ebx
 750:	5e                   	pop    %esi
 751:	5d                   	pop    %ebp
 752:	c3                   	ret    
 753:	90                   	nop
 754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 758:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 75d:	eb ed                	jmp    74c <stat+0x3c>
 75f:	90                   	nop

00000760 <atoi>:

int
atoi(const char *s)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	8b 4d 08             	mov    0x8(%ebp),%ecx
 766:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 767:	0f be 11             	movsbl (%ecx),%edx
 76a:	8d 42 d0             	lea    -0x30(%edx),%eax
 76d:	3c 09                	cmp    $0x9,%al
  n = 0;
 76f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 774:	77 17                	ja     78d <atoi+0x2d>
 776:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 778:	83 c1 01             	add    $0x1,%ecx
 77b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 77e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 782:	0f be 11             	movsbl (%ecx),%edx
 785:	8d 5a d0             	lea    -0x30(%edx),%ebx
 788:	80 fb 09             	cmp    $0x9,%bl
 78b:	76 eb                	jbe    778 <atoi+0x18>
  return n;
}
 78d:	5b                   	pop    %ebx
 78e:	5d                   	pop    %ebp
 78f:	c3                   	ret    

00000790 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 790:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 791:	31 d2                	xor    %edx,%edx
{
 793:	89 e5                	mov    %esp,%ebp
 795:	56                   	push   %esi
 796:	8b 45 08             	mov    0x8(%ebp),%eax
 799:	53                   	push   %ebx
 79a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 79d:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 7a0:	85 db                	test   %ebx,%ebx
 7a2:	7e 12                	jle    7b6 <memmove+0x26>
 7a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 7a8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 7ac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 7af:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 7b2:	39 da                	cmp    %ebx,%edx
 7b4:	75 f2                	jne    7a8 <memmove+0x18>
  return vdst;
}
 7b6:	5b                   	pop    %ebx
 7b7:	5e                   	pop    %esi
 7b8:	5d                   	pop    %ebp
 7b9:	c3                   	ret    

000007ba <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 7ba:	b8 01 00 00 00       	mov    $0x1,%eax
 7bf:	cd 40                	int    $0x40
 7c1:	c3                   	ret    

000007c2 <exit>:
SYSCALL(exit)
 7c2:	b8 02 00 00 00       	mov    $0x2,%eax
 7c7:	cd 40                	int    $0x40
 7c9:	c3                   	ret    

000007ca <wait>:
SYSCALL(wait)
 7ca:	b8 03 00 00 00       	mov    $0x3,%eax
 7cf:	cd 40                	int    $0x40
 7d1:	c3                   	ret    

000007d2 <pipe>:
SYSCALL(pipe)
 7d2:	b8 04 00 00 00       	mov    $0x4,%eax
 7d7:	cd 40                	int    $0x40
 7d9:	c3                   	ret    

000007da <read>:
SYSCALL(read)
 7da:	b8 05 00 00 00       	mov    $0x5,%eax
 7df:	cd 40                	int    $0x40
 7e1:	c3                   	ret    

000007e2 <write>:
SYSCALL(write)
 7e2:	b8 10 00 00 00       	mov    $0x10,%eax
 7e7:	cd 40                	int    $0x40
 7e9:	c3                   	ret    

000007ea <close>:
SYSCALL(close)
 7ea:	b8 15 00 00 00       	mov    $0x15,%eax
 7ef:	cd 40                	int    $0x40
 7f1:	c3                   	ret    

000007f2 <kill>:
SYSCALL(kill)
 7f2:	b8 06 00 00 00       	mov    $0x6,%eax
 7f7:	cd 40                	int    $0x40
 7f9:	c3                   	ret    

000007fa <exec>:
SYSCALL(exec)
 7fa:	b8 07 00 00 00       	mov    $0x7,%eax
 7ff:	cd 40                	int    $0x40
 801:	c3                   	ret    

00000802 <open>:
SYSCALL(open)
 802:	b8 0f 00 00 00       	mov    $0xf,%eax
 807:	cd 40                	int    $0x40
 809:	c3                   	ret    

0000080a <mknod>:
SYSCALL(mknod)
 80a:	b8 11 00 00 00       	mov    $0x11,%eax
 80f:	cd 40                	int    $0x40
 811:	c3                   	ret    

00000812 <unlink>:
SYSCALL(unlink)
 812:	b8 12 00 00 00       	mov    $0x12,%eax
 817:	cd 40                	int    $0x40
 819:	c3                   	ret    

0000081a <fstat>:
SYSCALL(fstat)
 81a:	b8 08 00 00 00       	mov    $0x8,%eax
 81f:	cd 40                	int    $0x40
 821:	c3                   	ret    

00000822 <link>:
SYSCALL(link)
 822:	b8 13 00 00 00       	mov    $0x13,%eax
 827:	cd 40                	int    $0x40
 829:	c3                   	ret    

0000082a <mkdir>:
SYSCALL(mkdir)
 82a:	b8 14 00 00 00       	mov    $0x14,%eax
 82f:	cd 40                	int    $0x40
 831:	c3                   	ret    

00000832 <chdir>:
SYSCALL(chdir)
 832:	b8 09 00 00 00       	mov    $0x9,%eax
 837:	cd 40                	int    $0x40
 839:	c3                   	ret    

0000083a <dup>:
SYSCALL(dup)
 83a:	b8 0a 00 00 00       	mov    $0xa,%eax
 83f:	cd 40                	int    $0x40
 841:	c3                   	ret    

00000842 <getpid>:
SYSCALL(getpid)
 842:	b8 0b 00 00 00       	mov    $0xb,%eax
 847:	cd 40                	int    $0x40
 849:	c3                   	ret    

0000084a <sbrk>:
SYSCALL(sbrk)
 84a:	b8 0c 00 00 00       	mov    $0xc,%eax
 84f:	cd 40                	int    $0x40
 851:	c3                   	ret    

00000852 <sleep>:
SYSCALL(sleep)
 852:	b8 0d 00 00 00       	mov    $0xd,%eax
 857:	cd 40                	int    $0x40
 859:	c3                   	ret    

0000085a <uptime>:
SYSCALL(uptime)
 85a:	b8 0e 00 00 00       	mov    $0xe,%eax
 85f:	cd 40                	int    $0x40
 861:	c3                   	ret    

00000862 <clone>:
SYSCALL(clone)
 862:	b8 16 00 00 00       	mov    $0x16,%eax
 867:	cd 40                	int    $0x40
 869:	c3                   	ret    
 86a:	66 90                	xchg   %ax,%ax
 86c:	66 90                	xchg   %ax,%ax
 86e:	66 90                	xchg   %ax,%ax

00000870 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 870:	55                   	push   %ebp
 871:	89 e5                	mov    %esp,%ebp
 873:	57                   	push   %edi
 874:	56                   	push   %esi
 875:	89 c6                	mov    %eax,%esi
 877:	53                   	push   %ebx
 878:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 87b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 87e:	85 db                	test   %ebx,%ebx
 880:	74 09                	je     88b <printint+0x1b>
 882:	89 d0                	mov    %edx,%eax
 884:	c1 e8 1f             	shr    $0x1f,%eax
 887:	84 c0                	test   %al,%al
 889:	75 75                	jne    900 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 88b:	89 d0                	mov    %edx,%eax
  neg = 0;
 88d:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 894:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 897:	31 ff                	xor    %edi,%edi
 899:	89 ce                	mov    %ecx,%esi
 89b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 89e:	eb 02                	jmp    8a2 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 8a0:	89 cf                	mov    %ecx,%edi
 8a2:	31 d2                	xor    %edx,%edx
 8a4:	f7 f6                	div    %esi
 8a6:	8d 4f 01             	lea    0x1(%edi),%ecx
 8a9:	0f b6 92 83 0d 00 00 	movzbl 0xd83(%edx),%edx
  }while((x /= base) != 0);
 8b0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 8b2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 8b5:	75 e9                	jne    8a0 <printint+0x30>
  if(neg)
 8b7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 8ba:	89 c8                	mov    %ecx,%eax
 8bc:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 8bf:	85 d2                	test   %edx,%edx
 8c1:	74 08                	je     8cb <printint+0x5b>
    buf[i++] = '-';
 8c3:	8d 4f 02             	lea    0x2(%edi),%ecx
 8c6:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 8cb:	8d 79 ff             	lea    -0x1(%ecx),%edi
 8ce:	66 90                	xchg   %ax,%ax
 8d0:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 8d5:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 8d8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 8df:	00 
 8e0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 8e4:	89 34 24             	mov    %esi,(%esp)
 8e7:	88 45 d7             	mov    %al,-0x29(%ebp)
 8ea:	e8 f3 fe ff ff       	call   7e2 <write>
  while(--i >= 0)
 8ef:	83 ff ff             	cmp    $0xffffffff,%edi
 8f2:	75 dc                	jne    8d0 <printint+0x60>
    putc(fd, buf[i]);
}
 8f4:	83 c4 4c             	add    $0x4c,%esp
 8f7:	5b                   	pop    %ebx
 8f8:	5e                   	pop    %esi
 8f9:	5f                   	pop    %edi
 8fa:	5d                   	pop    %ebp
 8fb:	c3                   	ret    
 8fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 900:	89 d0                	mov    %edx,%eax
 902:	f7 d8                	neg    %eax
    neg = 1;
 904:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 90b:	eb 87                	jmp    894 <printint+0x24>
 90d:	8d 76 00             	lea    0x0(%esi),%esi

00000910 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 910:	55                   	push   %ebp
 911:	89 e5                	mov    %esp,%ebp
 913:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 914:	31 ff                	xor    %edi,%edi
{
 916:	56                   	push   %esi
 917:	53                   	push   %ebx
 918:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 91b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 91e:	8d 45 10             	lea    0x10(%ebp),%eax
{
 921:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 924:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 927:	0f b6 13             	movzbl (%ebx),%edx
 92a:	83 c3 01             	add    $0x1,%ebx
 92d:	84 d2                	test   %dl,%dl
 92f:	75 39                	jne    96a <printf+0x5a>
 931:	e9 c2 00 00 00       	jmp    9f8 <printf+0xe8>
 936:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 938:	83 fa 25             	cmp    $0x25,%edx
 93b:	0f 84 bf 00 00 00    	je     a00 <printf+0xf0>
  write(fd, &c, 1);
 941:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 944:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 94b:	00 
 94c:	89 44 24 04          	mov    %eax,0x4(%esp)
 950:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 953:	88 55 e2             	mov    %dl,-0x1e(%ebp)
  write(fd, &c, 1);
 956:	e8 87 fe ff ff       	call   7e2 <write>
 95b:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 95e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 962:	84 d2                	test   %dl,%dl
 964:	0f 84 8e 00 00 00    	je     9f8 <printf+0xe8>
    if(state == 0){
 96a:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 96c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 96f:	74 c7                	je     938 <printf+0x28>
      }
    } else if(state == '%'){
 971:	83 ff 25             	cmp    $0x25,%edi
 974:	75 e5                	jne    95b <printf+0x4b>
      if(c == 'd'){
 976:	83 fa 64             	cmp    $0x64,%edx
 979:	0f 84 31 01 00 00    	je     ab0 <printf+0x1a0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 97f:	25 f7 00 00 00       	and    $0xf7,%eax
 984:	83 f8 70             	cmp    $0x70,%eax
 987:	0f 84 83 00 00 00    	je     a10 <printf+0x100>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 98d:	83 fa 73             	cmp    $0x73,%edx
 990:	0f 84 a2 00 00 00    	je     a38 <printf+0x128>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 996:	83 fa 63             	cmp    $0x63,%edx
 999:	0f 84 35 01 00 00    	je     ad4 <printf+0x1c4>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 99f:	83 fa 25             	cmp    $0x25,%edx
 9a2:	0f 84 e0 00 00 00    	je     a88 <printf+0x178>
  write(fd, &c, 1);
 9a8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 9ab:	83 c3 01             	add    $0x1,%ebx
 9ae:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 9b5:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 9b6:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 9b8:	89 44 24 04          	mov    %eax,0x4(%esp)
 9bc:	89 34 24             	mov    %esi,(%esp)
 9bf:	89 55 d0             	mov    %edx,-0x30(%ebp)
 9c2:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 9c6:	e8 17 fe ff ff       	call   7e2 <write>
        putc(fd, c);
 9cb:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 9ce:	8d 45 e7             	lea    -0x19(%ebp),%eax
 9d1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 9d8:	00 
 9d9:	89 44 24 04          	mov    %eax,0x4(%esp)
 9dd:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 9e0:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 9e3:	e8 fa fd ff ff       	call   7e2 <write>
  for(i = 0; fmt[i]; i++){
 9e8:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 9ec:	84 d2                	test   %dl,%dl
 9ee:	0f 85 76 ff ff ff    	jne    96a <printf+0x5a>
 9f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }
}
 9f8:	83 c4 3c             	add    $0x3c,%esp
 9fb:	5b                   	pop    %ebx
 9fc:	5e                   	pop    %esi
 9fd:	5f                   	pop    %edi
 9fe:	5d                   	pop    %ebp
 9ff:	c3                   	ret    
        state = '%';
 a00:	bf 25 00 00 00       	mov    $0x25,%edi
 a05:	e9 51 ff ff ff       	jmp    95b <printf+0x4b>
 a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 a10:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 a13:	b9 10 00 00 00       	mov    $0x10,%ecx
      state = 0;
 a18:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 a1a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 a21:	8b 10                	mov    (%eax),%edx
 a23:	89 f0                	mov    %esi,%eax
 a25:	e8 46 fe ff ff       	call   870 <printint>
        ap++;
 a2a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 a2e:	e9 28 ff ff ff       	jmp    95b <printf+0x4b>
 a33:	90                   	nop
 a34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 a38:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 a3b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 a3f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 a41:	b8 7c 0d 00 00       	mov    $0xd7c,%eax
 a46:	85 ff                	test   %edi,%edi
 a48:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 a4b:	0f b6 07             	movzbl (%edi),%eax
 a4e:	84 c0                	test   %al,%al
 a50:	74 2a                	je     a7c <printf+0x16c>
 a52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 a58:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 a5b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 a5e:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 a61:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 a68:	00 
 a69:	89 44 24 04          	mov    %eax,0x4(%esp)
 a6d:	89 34 24             	mov    %esi,(%esp)
 a70:	e8 6d fd ff ff       	call   7e2 <write>
        while(*s != 0){
 a75:	0f b6 07             	movzbl (%edi),%eax
 a78:	84 c0                	test   %al,%al
 a7a:	75 dc                	jne    a58 <printf+0x148>
      state = 0;
 a7c:	31 ff                	xor    %edi,%edi
 a7e:	e9 d8 fe ff ff       	jmp    95b <printf+0x4b>
 a83:	90                   	nop
 a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 a88:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 a8b:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 a8d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 a94:	00 
 a95:	89 44 24 04          	mov    %eax,0x4(%esp)
 a99:	89 34 24             	mov    %esi,(%esp)
 a9c:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 aa0:	e8 3d fd ff ff       	call   7e2 <write>
 aa5:	e9 b1 fe ff ff       	jmp    95b <printf+0x4b>
 aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 ab0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 ab3:	b9 0a 00 00 00       	mov    $0xa,%ecx
      state = 0;
 ab8:	66 31 ff             	xor    %di,%di
        printint(fd, *ap, 10, 1);
 abb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 ac2:	8b 10                	mov    (%eax),%edx
 ac4:	89 f0                	mov    %esi,%eax
 ac6:	e8 a5 fd ff ff       	call   870 <printint>
        ap++;
 acb:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 acf:	e9 87 fe ff ff       	jmp    95b <printf+0x4b>
        putc(fd, *ap);
 ad4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 ad7:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 ad9:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 adb:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 ae2:	00 
 ae3:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 ae6:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 ae9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 aec:	89 44 24 04          	mov    %eax,0x4(%esp)
 af0:	e8 ed fc ff ff       	call   7e2 <write>
        ap++;
 af5:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 af9:	e9 5d fe ff ff       	jmp    95b <printf+0x4b>
 afe:	66 90                	xchg   %ax,%ax

00000b00 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b00:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b01:	a1 60 12 00 00       	mov    0x1260,%eax
{
 b06:	89 e5                	mov    %esp,%ebp
 b08:	57                   	push   %edi
 b09:	56                   	push   %esi
 b0a:	53                   	push   %ebx
 b0b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b0e:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 b10:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b13:	39 d0                	cmp    %edx,%eax
 b15:	72 11                	jb     b28 <free+0x28>
 b17:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b18:	39 c8                	cmp    %ecx,%eax
 b1a:	72 04                	jb     b20 <free+0x20>
 b1c:	39 ca                	cmp    %ecx,%edx
 b1e:	72 10                	jb     b30 <free+0x30>
 b20:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b22:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b24:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b26:	73 f0                	jae    b18 <free+0x18>
 b28:	39 ca                	cmp    %ecx,%edx
 b2a:	72 04                	jb     b30 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b2c:	39 c8                	cmp    %ecx,%eax
 b2e:	72 f0                	jb     b20 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b30:	8b 73 fc             	mov    -0x4(%ebx),%esi
 b33:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 b36:	39 cf                	cmp    %ecx,%edi
 b38:	74 1e                	je     b58 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 b3a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 b3d:	8b 48 04             	mov    0x4(%eax),%ecx
 b40:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 b43:	39 f2                	cmp    %esi,%edx
 b45:	74 28                	je     b6f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 b47:	89 10                	mov    %edx,(%eax)
  freep = p;
 b49:	a3 60 12 00 00       	mov    %eax,0x1260
}
 b4e:	5b                   	pop    %ebx
 b4f:	5e                   	pop    %esi
 b50:	5f                   	pop    %edi
 b51:	5d                   	pop    %ebp
 b52:	c3                   	ret    
 b53:	90                   	nop
 b54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 b58:	03 71 04             	add    0x4(%ecx),%esi
 b5b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 b5e:	8b 08                	mov    (%eax),%ecx
 b60:	8b 09                	mov    (%ecx),%ecx
 b62:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 b65:	8b 48 04             	mov    0x4(%eax),%ecx
 b68:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 b6b:	39 f2                	cmp    %esi,%edx
 b6d:	75 d8                	jne    b47 <free+0x47>
    p->s.size += bp->s.size;
 b6f:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 b72:	a3 60 12 00 00       	mov    %eax,0x1260
    p->s.size += bp->s.size;
 b77:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 b7a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 b7d:	89 10                	mov    %edx,(%eax)
}
 b7f:	5b                   	pop    %ebx
 b80:	5e                   	pop    %esi
 b81:	5f                   	pop    %edi
 b82:	5d                   	pop    %ebp
 b83:	c3                   	ret    
 b84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 b8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000b90 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b90:	55                   	push   %ebp
 b91:	89 e5                	mov    %esp,%ebp
 b93:	57                   	push   %edi
 b94:	56                   	push   %esi
 b95:	53                   	push   %ebx
 b96:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b99:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 b9c:	8b 1d 60 12 00 00    	mov    0x1260,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ba2:	8d 48 07             	lea    0x7(%eax),%ecx
 ba5:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 ba8:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 baa:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 bad:	0f 84 9b 00 00 00    	je     c4e <malloc+0xbe>
 bb3:	8b 13                	mov    (%ebx),%edx
 bb5:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 bb8:	39 fe                	cmp    %edi,%esi
 bba:	76 64                	jbe    c20 <malloc+0x90>
 bbc:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 bc3:	bb 00 80 00 00       	mov    $0x8000,%ebx
 bc8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 bcb:	eb 0e                	jmp    bdb <malloc+0x4b>
 bcd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bd0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 bd2:	8b 78 04             	mov    0x4(%eax),%edi
 bd5:	39 fe                	cmp    %edi,%esi
 bd7:	76 4f                	jbe    c28 <malloc+0x98>
 bd9:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 bdb:	3b 15 60 12 00 00    	cmp    0x1260,%edx
 be1:	75 ed                	jne    bd0 <malloc+0x40>
  if(nu < 4096)
 be3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 be6:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 bec:	bf 00 10 00 00       	mov    $0x1000,%edi
 bf1:	0f 43 fe             	cmovae %esi,%edi
 bf4:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 bf7:	89 04 24             	mov    %eax,(%esp)
 bfa:	e8 4b fc ff ff       	call   84a <sbrk>
  if(p == (char*)-1)
 bff:	83 f8 ff             	cmp    $0xffffffff,%eax
 c02:	74 18                	je     c1c <malloc+0x8c>
  hp->s.size = nu;
 c04:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 c07:	83 c0 08             	add    $0x8,%eax
 c0a:	89 04 24             	mov    %eax,(%esp)
 c0d:	e8 ee fe ff ff       	call   b00 <free>
  return freep;
 c12:	8b 15 60 12 00 00    	mov    0x1260,%edx
      if((p = morecore(nunits)) == 0)
 c18:	85 d2                	test   %edx,%edx
 c1a:	75 b4                	jne    bd0 <malloc+0x40>
        return 0;
 c1c:	31 c0                	xor    %eax,%eax
 c1e:	eb 20                	jmp    c40 <malloc+0xb0>
    if(p->s.size >= nunits){
 c20:	89 d0                	mov    %edx,%eax
 c22:	89 da                	mov    %ebx,%edx
 c24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 c28:	39 fe                	cmp    %edi,%esi
 c2a:	74 1c                	je     c48 <malloc+0xb8>
        p->s.size -= nunits;
 c2c:	29 f7                	sub    %esi,%edi
 c2e:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 c31:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 c34:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 c37:	89 15 60 12 00 00    	mov    %edx,0x1260
      return (void*)(p + 1);
 c3d:	83 c0 08             	add    $0x8,%eax
  }
}
 c40:	83 c4 1c             	add    $0x1c,%esp
 c43:	5b                   	pop    %ebx
 c44:	5e                   	pop    %esi
 c45:	5f                   	pop    %edi
 c46:	5d                   	pop    %ebp
 c47:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 c48:	8b 08                	mov    (%eax),%ecx
 c4a:	89 0a                	mov    %ecx,(%edx)
 c4c:	eb e9                	jmp    c37 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 c4e:	c7 05 60 12 00 00 64 	movl   $0x1264,0x1260
 c55:	12 00 00 
    base.s.size = 0;
 c58:	ba 64 12 00 00       	mov    $0x1264,%edx
    base.s.ptr = freep = prevp = &base;
 c5d:	c7 05 64 12 00 00 64 	movl   $0x1264,0x1264
 c64:	12 00 00 
    base.s.size = 0;
 c67:	c7 05 68 12 00 00 00 	movl   $0x0,0x1268
 c6e:	00 00 00 
 c71:	e9 46 ff ff ff       	jmp    bbc <malloc+0x2c>
