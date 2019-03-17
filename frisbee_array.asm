
_frisbee_array:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
volatile uint cur_owner = 0;

void *frisbee_task(void *arg);


int main(int argc, char *argv[]) {
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	83 e4 f0             	and    $0xfffffff0,%esp
   9:	83 ec 30             	sub    $0x30,%esp
   c:	8b 5d 0c             	mov    0xc(%ebp),%ebx

  maxpass = argc > 2 ? (uint) atoi(argv[2]) : 60;
   f:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)
  13:	0f 8f 10 01 00 00    	jg     129 <main+0x129>
  19:	c7 05 a0 12 00 00 3c 	movl   $0x3c,0x12a0
  20:	00 00 00 
  numthreads = argc > 1 ? (uint) atoi(argv[1]) : 20;
  23:	b8 14 00 00 00       	mov    $0x14,%eax
  28:	0f 84 0b 01 00 00    	je     139 <main+0x139>

  struct arraylock_t lock;
  arraylock_init(&lock, numthreads);
  2e:	8d 74 24 1c          	lea    0x1c(%esp),%esi
  // Record time
  int time = 0;
  time -= uptime();

  uint i;
  for(i=0; i<numthreads; i++){
  32:	31 ff                	xor    %edi,%edi
  arraylock_init(&lock, numthreads);
  34:	89 44 24 04          	mov    %eax,0x4(%esp)
  38:	89 34 24             	mov    %esi,(%esp)
  numthreads = argc > 1 ? (uint) atoi(argv[1]) : 20;
  3b:	a3 a4 12 00 00       	mov    %eax,0x12a4
  arraylock_init(&lock, numthreads);
  40:	e8 2b 03 00 00       	call   370 <arraylock_init>
  targs *thread_args = malloc(numthreads * sizeof(targs));
  45:	a1 a4 12 00 00       	mov    0x12a4,%eax
  4a:	c1 e0 04             	shl    $0x4,%eax
  4d:	89 04 24             	mov    %eax,(%esp)
  50:	e8 6b 0b 00 00       	call   bc0 <malloc>
  55:	89 c3                	mov    %eax,%ebx
  time -= uptime();
  57:	e8 2e 08 00 00       	call   88a <uptime>
  5c:	89 44 24 0c          	mov    %eax,0xc(%esp)
  for(i=0; i<numthreads; i++){
  60:	a1 a4 12 00 00       	mov    0x12a4,%eax
  65:	85 c0                	test   %eax,%eax
  67:	74 6f                	je     d8 <main+0xd8>
  69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    thread_args[i].tid = i;
  70:	89 3b                	mov    %edi,(%ebx)
  for(i=0; i<numthreads; i++){
  72:	83 c7 01             	add    $0x1,%edi
    thread_args[i].lock = &lock;
  75:	89 73 0c             	mov    %esi,0xc(%ebx)

    thread_create(&frisbee_task, (void *)&thread_args[i]);
  78:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  7c:	83 c3 10             	add    $0x10,%ebx
  7f:	c7 04 24 40 04 00 00 	movl   $0x440,(%esp)
  86:	e8 05 01 00 00       	call   190 <thread_create>
  for(i=0; i<numthreads; i++){
  8b:	8b 15 a4 12 00 00    	mov    0x12a4,%edx
  91:	39 fa                	cmp    %edi,%edx
  93:	77 db                	ja     70 <main+0x70>
  }

  for(i=0; i<numthreads; i++){
  95:	85 d2                	test   %edx,%edx
  97:	74 3f                	je     d8 <main+0xd8>
  99:	31 db                	xor    %ebx,%ebx
  9b:	eb 0e                	jmp    ab <main+0xab>
  9d:	8d 76 00             	lea    0x0(%esi),%esi
  a0:	83 c3 01             	add    $0x1,%ebx
  a3:	39 1d a4 12 00 00    	cmp    %ebx,0x12a4
  a9:	76 2d                	jbe    d8 <main+0xd8>
    if( wait() < 0)
  ab:	e8 4a 07 00 00       	call   7fa <wait>
  b0:	85 c0                	test   %eax,%eax
  b2:	79 ec                	jns    a0 <main+0xa0>
      printf(1, "Sorry! Error occurred in the time of thread exiting\n");
  b4:	c7 44 24 04 74 0d 00 	movl   $0xd74,0x4(%esp)
  bb:	00 
  for(i=0; i<numthreads; i++){
  bc:	83 c3 01             	add    $0x1,%ebx
      printf(1, "Sorry! Error occurred in the time of thread exiting\n");
  bf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c6:	e8 75 08 00 00       	call   940 <printf>
  for(i=0; i<numthreads; i++){
  cb:	39 1d a4 12 00 00    	cmp    %ebx,0x12a4
  d1:	77 d8                	ja     ab <main+0xab>
  d3:	90                   	nop
  d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  time += uptime();
  d8:	e8 ad 07 00 00       	call   88a <uptime>
  printf(1, "The FRISBEE GAME is finished, with  %d rounds\n", maxpass);
  dd:	c7 44 24 04 1c 0d 00 	movl   $0xd1c,0x4(%esp)
  e4:	00 
  e5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  time += uptime();
  ec:	89 c3                	mov    %eax,%ebx
  printf(1, "The FRISBEE GAME is finished, with  %d rounds\n", maxpass);
  ee:	a1 a0 12 00 00       	mov    0x12a0,%eax
  time += uptime();
  f3:	2b 5c 24 0c          	sub    0xc(%esp),%ebx
  printf(1, "The FRISBEE GAME is finished, with  %d rounds\n", maxpass);
  f7:	89 44 24 08          	mov    %eax,0x8(%esp)
  fb:	e8 40 08 00 00       	call   940 <printf>
  printf(1, "\nFrisbee Game Total Running Time: %d\n", time);
 100:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 104:	c7 44 24 04 4c 0d 00 	movl   $0xd4c,0x4(%esp)
 10b:	00 
 10c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 113:	e8 28 08 00 00       	call   940 <printf>
  lk->lock[lk->lockpos] = 0; // Clear own ticket
  lk->lock[nextpos] = 1; // Set next ticket
}

void arraylock_destroy(struct arraylock_t *lk){
  free((void *) lk->lock);
 118:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 11c:	89 04 24             	mov    %eax,(%esp)
 11f:	e8 0c 0a 00 00       	call   b30 <free>

  arraylock_destroy(&lock);

  exit();
 124:	e8 c9 06 00 00       	call   7f2 <exit>
  maxpass = argc > 2 ? (uint) atoi(argv[2]) : 60;
 129:	8b 43 08             	mov    0x8(%ebx),%eax
 12c:	89 04 24             	mov    %eax,(%esp)
 12f:	e8 5c 06 00 00       	call   790 <atoi>
 134:	a3 a0 12 00 00       	mov    %eax,0x12a0
  numthreads = argc > 1 ? (uint) atoi(argv[1]) : 20;
 139:	8b 43 04             	mov    0x4(%ebx),%eax
 13c:	89 04 24             	mov    %eax,(%esp)
 13f:	e8 4c 06 00 00       	call   790 <atoi>
 144:	e9 e5 fe ff ff       	jmp    2e <main+0x2e>
 149:	66 90                	xchg   %ax,%ax
 14b:	66 90                	xchg   %ax,%ax
 14d:	66 90                	xchg   %ax,%ax
 14f:	90                   	nop

00000150 <thread_routine>:
void thread_routine(void *(*routine)(void *), void *arg, void *stack){
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	83 ec 18             	sub    $0x18,%esp
  (*routine)(arg);
 156:	8b 45 0c             	mov    0xc(%ebp),%eax
 159:	89 04 24             	mov    %eax,(%esp)
 15c:	ff 55 08             	call   *0x8(%ebp)
  free(stack);
 15f:	8b 45 10             	mov    0x10(%ebp),%eax
 162:	89 04 24             	mov    %eax,(%esp)
 165:	e8 c6 09 00 00       	call   b30 <free>
  exit();
 16a:	e8 83 06 00 00       	call   7f2 <exit>
 16f:	90                   	nop

00000170 <thread_panic>:
void thread_panic(void){
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	83 ec 18             	sub    $0x18,%esp
     printf(1, "** Thread shouldn't execute this instruction **\n");
 176:	c7 44 24 04 a8 0c 00 	movl   $0xca8,0x4(%esp)
 17d:	00 
 17e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 185:	e8 b6 07 00 00       	call   940 <printf>
   }
 18a:	c9                   	leave  
 18b:	c3                   	ret    
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000190 <thread_create>:
void thread_create(void *(*start_routine)(void *), void *arg) {
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	56                   	push   %esi
 194:	53                   	push   %ebx
 195:	83 ec 10             	sub    $0x10,%esp
 198:	8b 5d 08             	mov    0x8(%ebp),%ebx
  void *stack = malloc(size);
 19b:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
void thread_create(void *(*start_routine)(void *), void *arg) {
 1a2:	8b 75 0c             	mov    0xc(%ebp),%esi
  void *stack = malloc(size);
 1a5:	e8 16 0a 00 00       	call   bc0 <malloc>
  *(--endstack) = (uint) stack;
 1aa:	89 80 fc 0f 00 00    	mov    %eax,0xffc(%eax)
  *(--endstack) = (uint) arg;
 1b0:	89 b0 f8 0f 00 00    	mov    %esi,0xff8(%eax)
  *(--endstack) = (uint) start_routine;
 1b6:	89 98 f4 0f 00 00    	mov    %ebx,0xff4(%eax)
  *(--endstack) = (uint) &thread_panic;
 1bc:	c7 80 f0 0f 00 00 70 	movl   $0x170,0xff0(%eax)
 1c3:	01 00 00 
  *(--endstack) = (uint) &thread_routine;
 1c6:	c7 80 ec 0f 00 00 50 	movl   $0x150,0xfec(%eax)
 1cd:	01 00 00 
  clone(stack, size);
 1d0:	c7 45 0c ec 0f 00 00 	movl   $0xfec,0xc(%ebp)
 1d7:	89 45 08             	mov    %eax,0x8(%ebp)
}
 1da:	83 c4 10             	add    $0x10,%esp
 1dd:	5b                   	pop    %ebx
 1de:	5e                   	pop    %esi
 1df:	5d                   	pop    %ebp
  clone(stack, size);
 1e0:	e9 ad 06 00 00       	jmp    892 <clone>
 1e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001f0 <lock_init>:
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
  lk->lock = 0;
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
 1fc:	5d                   	pop    %ebp
 1fd:	c3                   	ret    
 1fe:	66 90                	xchg   %ax,%ax

00000200 <lock_acquire>:
void lock_acquire(struct lock_t *lk){
 200:	55                   	push   %ebp
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
 201:	b9 01 00 00 00       	mov    $0x1,%ecx
 206:	89 e5                	mov    %esp,%ebp
 208:	8b 55 08             	mov    0x8(%ebp),%edx
 20b:	90                   	nop
 20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 210:	89 c8                	mov    %ecx,%eax
 212:	f0 87 02             	lock xchg %eax,(%edx)
  while (xchg(&lk->lock, 1) != 0);
 215:	85 c0                	test   %eax,%eax
 217:	75 f7                	jne    210 <lock_acquire+0x10>
}
 219:	5d                   	pop    %ebp
 21a:	c3                   	ret    
 21b:	90                   	nop
 21c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000220 <lock_release>:
void lock_release(struct lock_t *lk){
 220:	55                   	push   %ebp
 221:	31 c0                	xor    %eax,%eax
 223:	89 e5                	mov    %esp,%ebp
 225:	8b 55 08             	mov    0x8(%ebp),%edx
 228:	f0 87 02             	lock xchg %eax,(%edx)
}
 22b:	5d                   	pop    %ebp
 22c:	c3                   	ret    
 22d:	8d 76 00             	lea    0x0(%esi),%esi

00000230 <seqlock_init>:
void seqlock_init(struct seqlock_t *lk){
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->seq = 0;
 236:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->splk = 0;
 23c:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
}
 243:	5d                   	pop    %ebp
 244:	c3                   	ret    
 245:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <seqlock_read>:
uint seqlock_read(struct seqlock_t *lk, uint *mem) {
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	56                   	push   %esi
 254:	8b 75 0c             	mov    0xc(%ebp),%esi
 257:	53                   	push   %ebx
 258:	8b 5d 08             	mov    0x8(%ebp),%ebx
    retval = *mem;
 25b:	8b 06                	mov    (%esi),%eax
 25d:	8b 0b                	mov    (%ebx),%ecx
    seqf = lk->seq;
 25f:	8b 13                	mov    (%ebx),%edx
    if ( (seqi != seqf) || (seqi & 0x1)) continue;
 261:	39 ca                	cmp    %ecx,%edx
 263:	74 0d                	je     272 <seqlock_read+0x22>
 265:	8d 76 00             	lea    0x0(%esi),%esi
 268:	89 d1                	mov    %edx,%ecx
    retval = *mem;
 26a:	8b 06                	mov    (%esi),%eax
    seqf = lk->seq;
 26c:	8b 13                	mov    (%ebx),%edx
    if ( (seqi != seqf) || (seqi & 0x1)) continue;
 26e:	39 ca                	cmp    %ecx,%edx
 270:	75 f6                	jne    268 <seqlock_read+0x18>
 272:	83 e1 01             	and    $0x1,%ecx
 275:	75 f1                	jne    268 <seqlock_read+0x18>
}
 277:	5b                   	pop    %ebx
 278:	5e                   	pop    %esi
 279:	5d                   	pop    %ebp
 27a:	c3                   	ret    
 27b:	90                   	nop
 27c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000280 <seqlock_write>:
void seqlock_write(struct seqlock_t *lk, uint *mem, uint val){
 280:	55                   	push   %ebp
 281:	b9 01 00 00 00       	mov    $0x1,%ecx
 286:	89 e5                	mov    %esp,%ebp
 288:	53                   	push   %ebx
 289:	8b 5d 08             	mov    0x8(%ebp),%ebx
 28c:	8d 53 04             	lea    0x4(%ebx),%edx
 28f:	90                   	nop
 290:	89 c8                	mov    %ecx,%eax
 292:	f0 87 02             	lock xchg %eax,(%edx)
     while (xchg(&lk->splk, 1) != 0);
 295:	85 c0                	test   %eax,%eax
 297:	75 f7                	jne    290 <seqlock_write+0x10>
lk->seq++;
 299:	83 03 01             	addl   $0x1,(%ebx)
  *mem = val;
 29c:	8b 4d 10             	mov    0x10(%ebp),%ecx
 29f:	8b 55 0c             	mov    0xc(%ebp),%edx
 2a2:	89 0a                	mov    %ecx,(%edx)
  lk->seq++;
 2a4:	83 03 01             	addl   $0x1,(%ebx)
 2a7:	f0 87 43 04          	lock xchg %eax,0x4(%ebx)
    }
 2ab:	5b                   	pop    %ebx
 2ac:	5d                   	pop    %ebp
 2ad:	c3                   	ret    
 2ae:	66 90                	xchg   %ax,%ax

000002b0 <mcslock_init>:
void mcslock_init(mcs_lock_t *lk){
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->next = NULL;
 2b6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->spin = 0;
 2bc:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
}
 2c3:	5d                   	pop    %ebp
 2c4:	c3                   	ret    
 2c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002d0 <mcslock_acquire>:
void mcslock_acquire(mcs_lock_t *lk, mcs_lock_t *qnode){
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	8b 55 0c             	mov    0xc(%ebp),%edx
 2d6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  qnode->next = NULL;
 2d9:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
 2df:	89 d0                	mov    %edx,%eax
  qnode->spin = 0;
 2e1:	c7 42 04 00 00 00 00 	movl   $0x0,0x4(%edx)
 2e8:	f0 87 01             	lock xchg %eax,(%ecx)
  if (!tail) return; // queue is empty
 2eb:	85 c0                	test   %eax,%eax
 2ed:	74 10                	je     2ff <mcslock_acquire+0x2f>
  tail->next = qnode; // Attach after queue if present
 2ef:	89 10                	mov    %edx,(%eax)
 2f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while (!qnode->spin);
 2f8:	8b 42 04             	mov    0x4(%edx),%eax
 2fb:	85 c0                	test   %eax,%eax
 2fd:	74 f9                	je     2f8 <mcslock_acquire+0x28>
}
 2ff:	5d                   	pop    %ebp
 300:	c3                   	ret    
 301:	eb 0d                	jmp    310 <mcslock_release>
 303:	90                   	nop
 304:	90                   	nop
 305:	90                   	nop
 306:	90                   	nop
 307:	90                   	nop
 308:	90                   	nop
 309:	90                   	nop
 30a:	90                   	nop
 30b:	90                   	nop
 30c:	90                   	nop
 30d:	90                   	nop
 30e:	90                   	nop
 30f:	90                   	nop

00000310 <mcslock_release>:
void mcslock_release(mcs_lock_t *lk, mcs_lock_t *qnode){
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 316:	53                   	push   %ebx
  if (!qnode->next){ // No successor yet
 317:	8b 01                	mov    (%ecx),%eax
 319:	85 c0                	test   %eax,%eax
 31b:	74 0b                	je     328 <mcslock_release+0x18>
            qnode->next->spin = 1;
 31d:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
            }
 324:	5b                   	pop    %ebx
 325:	5d                   	pop    %ebp
 326:	c3                   	ret    
 327:	90                   	nop
 328:	8b 45 08             	mov    0x8(%ebp),%eax
 32b:	bb 01 00 00 00       	mov    $0x1,%ebx
 330:	8d 50 04             	lea    0x4(%eax),%edx
 333:	90                   	nop
 334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 338:	89 d8                	mov    %ebx,%eax
 33a:	f0 87 02             	lock xchg %eax,(%edx)
  while (xchg(&lk->spin, 1) != 0);
 33d:	85 c0                	test   %eax,%eax
 33f:	75 f7                	jne    338 <mcslock_release+0x28>
    t = lk->next;
 341:	8b 45 08             	mov    0x8(%ebp),%eax
 344:	8b 10                	mov    (%eax),%edx
    if(t == qnode) lk->next = NULL;
 346:	39 ca                	cmp    %ecx,%edx
 348:	74 16                	je     360 <mcslock_release+0x50>
 34a:	31 c0                	xor    %eax,%eax
 34c:	8b 5d 08             	mov    0x8(%ebp),%ebx
 34f:	f0 87 43 04          	lock xchg %eax,0x4(%ebx)
    if(t == qnode) return;
 353:	39 ca                	cmp    %ecx,%edx
 355:	74 cd                	je     324 <mcslock_release+0x14>
 357:	8b 01                	mov    (%ecx),%eax
      while(!qnode->next);
 359:	85 c0                	test   %eax,%eax
 35b:	75 c0                	jne    31d <mcslock_release+0xd>
 35d:	eb fe                	jmp    35d <mcslock_release+0x4d>
 35f:	90                   	nop
    if(t == qnode) lk->next = NULL;
 360:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
 366:	eb e2                	jmp    34a <mcslock_release+0x3a>
 368:	90                   	nop
 369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000370 <arraylock_init>:
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	56                   	push   %esi
 374:	53                   	push   %ebx
 375:	83 ec 10             	sub    $0x10,%esp
 378:	8b 75 0c             	mov    0xc(%ebp),%esi
 37b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  lk->lock = (uint*) malloc(lk->size * sizeof(uint));
 37e:	8d 04 b5 00 00 00 00 	lea    0x0(,%esi,4),%eax
  lk->size = size;
 385:	89 73 0c             	mov    %esi,0xc(%ebx)
  lk->lock = (uint*) malloc(lk->size * sizeof(uint));
 388:	89 04 24             	mov    %eax,(%esp)
 38b:	e8 30 08 00 00       	call   bc0 <malloc>
  for(i = 1; i < size; i++) lk->lock[i] = 0;
 390:	83 fe 01             	cmp    $0x1,%esi
  lk->lock = (uint*) malloc(lk->size * sizeof(uint));
 393:	89 03                	mov    %eax,(%ebx)
  for(i = 1; i < size; i++) lk->lock[i] = 0;
 395:	76 25                	jbe    3bc <arraylock_init+0x4c>
 397:	b9 01 00 00 00       	mov    $0x1,%ecx
 39c:	ba 01 00 00 00       	mov    $0x1,%edx
 3a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3a8:	83 c2 01             	add    $0x1,%edx
 3ab:	8d 04 88             	lea    (%eax,%ecx,4),%eax
 3ae:	39 f2                	cmp    %esi,%edx
 3b0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
 3b6:	89 d1                	mov    %edx,%ecx
 3b8:	8b 03                	mov    (%ebx),%eax
 3ba:	75 ec                	jne    3a8 <arraylock_init+0x38>
  lk->lock[0] = 1;
 3bc:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  lk->next = 0;
 3c2:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  lk->m = 0;
 3c9:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
}
 3d0:	83 c4 10             	add    $0x10,%esp
 3d3:	5b                   	pop    %ebx
 3d4:	5e                   	pop    %esi
 3d5:	5d                   	pop    %ebp
 3d6:	c3                   	ret    
 3d7:	89 f6                	mov    %esi,%esi
 3d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003e0 <arraylock_acquire>:
void arraylock_acquire(struct arraylock_t *lk){
 3e0:	55                   	push   %ebp
 3e1:	b9 01 00 00 00       	mov    $0x1,%ecx
 3e6:	89 e5                	mov    %esp,%ebp
 3e8:	53                   	push   %ebx
 3e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
 3ec:	8d 53 10             	lea    0x10(%ebx),%edx
 3ef:	90                   	nop
 3f0:	89 c8                	mov    %ecx,%eax
 3f2:	f0 87 02             	lock xchg %eax,(%edx)
  while (xchg(&lk->m, 1) != 0);
 3f5:	85 c0                	test   %eax,%eax
 3f7:	75 f7                	jne    3f0 <arraylock_acquire+0x10>
  pos = lk->next;
 3f9:	8b 4b 08             	mov    0x8(%ebx),%ecx
  lk->next = pos + 1;
 3fc:	8d 41 01             	lea    0x1(%ecx),%eax
  if(lk->next == lk->size) lk->next = 0;
 3ff:	3b 43 0c             	cmp    0xc(%ebx),%eax
  lk->next = pos + 1;
 402:	89 43 08             	mov    %eax,0x8(%ebx)
  if(lk->next == lk->size) lk->next = 0;
 405:	74 21                	je     428 <arraylock_acquire+0x48>
 407:	31 c0                	xor    %eax,%eax
 409:	f0 87 43 10          	lock xchg %eax,0x10(%ebx)
 40d:	8b 03                	mov    (%ebx),%eax
 40f:	8d 14 88             	lea    (%eax,%ecx,4),%edx
 412:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  while(lk->lock[pos] == 0);
 418:	8b 02                	mov    (%edx),%eax
 41a:	85 c0                	test   %eax,%eax
 41c:	74 fa                	je     418 <arraylock_acquire+0x38>
  lk->lockpos = pos;
 41e:	89 4b 04             	mov    %ecx,0x4(%ebx)
}
 421:	5b                   	pop    %ebx
 422:	5d                   	pop    %ebp
 423:	c3                   	ret    
 424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(lk->next == lk->size) lk->next = 0;
 428:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
 42f:	eb d6                	jmp    407 <arraylock_acquire+0x27>
 431:	eb 0d                	jmp    440 <frisbee_task>
 433:	90                   	nop
 434:	90                   	nop
 435:	90                   	nop
 436:	90                   	nop
 437:	90                   	nop
 438:	90                   	nop
 439:	90                   	nop
 43a:	90                   	nop
 43b:	90                   	nop
 43c:	90                   	nop
 43d:	90                   	nop
 43e:	90                   	nop
 43f:	90                   	nop

00000440 <frisbee_task>:
}

void *frisbee_task(void *arg){
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	57                   	push   %edi
 444:	56                   	push   %esi
 445:	53                   	push   %ebx
 446:	83 ec 2c             	sub    $0x2c,%esp
 449:	8b 75 08             	mov    0x8(%ebp),%esi
  targs *args = (targs*) arg;
  uint tid = args->tid;
 44c:	8b 06                	mov    (%esi),%eax
 44e:	89 45 e4             	mov    %eax,-0x1c(%ebp)

  while(1) {
    if(passes > maxpass) break;
 451:	a1 a0 12 00 00       	mov    0x12a0,%eax
 456:	3b 05 8c 12 00 00    	cmp    0x128c,%eax
 45c:	73 46                	jae    4a4 <frisbee_task+0x64>
 45e:	e9 e8 00 00 00       	jmp    54b <frisbee_task+0x10b>
 463:	90                   	nop
 464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "Pass number: %d, Thread %d is passing the token to thread %d\n", passes, tid, cur_owner);

      passes++;
    }

    arraylock_release(args->lock);
 468:	8b 56 0c             	mov    0xc(%esi),%edx
 46b:	31 c0                	xor    %eax,%eax
  uint nextpos = lk->lockpos + 1;
 46d:	8b 4a 04             	mov    0x4(%edx),%ecx
 470:	8d 59 01             	lea    0x1(%ecx),%ebx
 473:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
 47a:	3b 5a 0c             	cmp    0xc(%edx),%ebx
  lk->lock[lk->lockpos] = 0; // Clear own ticket
 47d:	8b 1a                	mov    (%edx),%ebx
 47f:	0f 45 c7             	cmovne %edi,%eax
 482:	8d 0c 8b             	lea    (%ebx,%ecx,4),%ecx
 485:	c7 01 00 00 00 00    	movl   $0x0,(%ecx)
  lk->lock[nextpos] = 1; // Set next ticket
 48b:	03 02                	add    (%edx),%eax
 48d:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
    if(passes > maxpass) break;
 493:	a1 a0 12 00 00       	mov    0x12a0,%eax
 498:	39 05 8c 12 00 00    	cmp    %eax,0x128c
 49e:	0f 87 a7 00 00 00    	ja     54b <frisbee_task+0x10b>
    arraylock_acquire(args->lock);
 4a4:	8b 46 0c             	mov    0xc(%esi),%eax
 4a7:	89 04 24             	mov    %eax,(%esp)
 4aa:	e8 31 ff ff ff       	call   3e0 <arraylock_acquire>
    if (passes > maxpass) {
 4af:	a1 8c 12 00 00       	mov    0x128c,%eax
 4b4:	8b 15 a0 12 00 00    	mov    0x12a0,%edx
 4ba:	39 d0                	cmp    %edx,%eax
 4bc:	77 62                	ja     520 <frisbee_task+0xe0>
    if(cur_owner == tid) {
 4be:	8b 15 90 12 00 00    	mov    0x1290,%edx
 4c4:	3b 55 e4             	cmp    -0x1c(%ebp),%edx
 4c7:	75 9f                	jne    468 <frisbee_task+0x28>
      cur_owner++;
 4c9:	8b 15 90 12 00 00    	mov    0x1290,%edx
 4cf:	83 c2 01             	add    $0x1,%edx
 4d2:	89 15 90 12 00 00    	mov    %edx,0x1290
      if(cur_owner == numthreads) cur_owner = 0;
 4d8:	8b 15 90 12 00 00    	mov    0x1290,%edx
 4de:	3b 15 a4 12 00 00    	cmp    0x12a4,%edx
 4e4:	74 72                	je     558 <frisbee_task+0x118>
      printf(1, "Pass number: %d, Thread %d is passing the token to thread %d\n", passes, tid, cur_owner);
 4e6:	8b 15 90 12 00 00    	mov    0x1290,%edx
 4ec:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 4ef:	89 44 24 08          	mov    %eax,0x8(%esp)
 4f3:	c7 44 24 04 dc 0c 00 	movl   $0xcdc,0x4(%esp)
 4fa:	00 
 4fb:	89 54 24 10          	mov    %edx,0x10(%esp)
 4ff:	89 7c 24 0c          	mov    %edi,0xc(%esp)
 503:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 50a:	e8 31 04 00 00       	call   940 <printf>
      passes++;
 50f:	83 05 8c 12 00 00 01 	addl   $0x1,0x128c
 516:	e9 4d ff ff ff       	jmp    468 <frisbee_task+0x28>
 51b:	90                   	nop
 51c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      arraylock_release(args->lock);
 520:	8b 56 0c             	mov    0xc(%esi),%edx
 523:	31 c0                	xor    %eax,%eax
  uint nextpos = lk->lockpos + 1;
 525:	8b 4a 04             	mov    0x4(%edx),%ecx
 528:	8d 59 01             	lea    0x1(%ecx),%ebx
 52b:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
 532:	3b 5a 0c             	cmp    0xc(%edx),%ebx
  lk->lock[lk->lockpos] = 0; // Clear own ticket
 535:	8b 1a                	mov    (%edx),%ebx
 537:	0f 45 c6             	cmovne %esi,%eax
 53a:	8d 0c 8b             	lea    (%ebx,%ecx,4),%ecx
 53d:	c7 01 00 00 00 00    	movl   $0x0,(%ecx)
  lk->lock[nextpos] = 1; // Set next ticket
 543:	03 02                	add    (%edx),%eax
 545:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  }

  return 0;
}
 54b:	83 c4 2c             	add    $0x2c,%esp
 54e:	31 c0                	xor    %eax,%eax
 550:	5b                   	pop    %ebx
 551:	5e                   	pop    %esi
 552:	5f                   	pop    %edi
 553:	5d                   	pop    %ebp
 554:	c3                   	ret    
 555:	8d 76 00             	lea    0x0(%esi),%esi
      if(cur_owner == numthreads) cur_owner = 0;
 558:	c7 05 90 12 00 00 00 	movl   $0x0,0x1290
 55f:	00 00 00 
 562:	eb 82                	jmp    4e6 <frisbee_task+0xa6>
 564:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 56a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000570 <arraylock_release>:
void arraylock_release(struct arraylock_t *lk){
 570:	55                   	push   %ebp
 571:	31 c0                	xor    %eax,%eax
 573:	89 e5                	mov    %esp,%ebp
 575:	8b 55 08             	mov    0x8(%ebp),%edx
 578:	56                   	push   %esi
 579:	53                   	push   %ebx
  uint nextpos = lk->lockpos + 1;
 57a:	8b 4a 04             	mov    0x4(%edx),%ecx
 57d:	8d 59 01             	lea    0x1(%ecx),%ebx
 580:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
 587:	39 5a 0c             	cmp    %ebx,0xc(%edx)
  lk->lock[lk->lockpos] = 0; // Clear own ticket
 58a:	8b 1a                	mov    (%edx),%ebx
 58c:	0f 45 c6             	cmovne %esi,%eax
 58f:	8d 0c 8b             	lea    (%ebx,%ecx,4),%ecx
 592:	c7 01 00 00 00 00    	movl   $0x0,(%ecx)
  lk->lock[nextpos] = 1; // Set next ticket
 598:	03 02                	add    (%edx),%eax
 59a:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
}
 5a0:	5b                   	pop    %ebx
 5a1:	5e                   	pop    %esi
 5a2:	5d                   	pop    %ebp
 5a3:	c3                   	ret    
 5a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000005b0 <arraylock_destroy>:
void arraylock_destroy(struct arraylock_t *lk){
 5b0:	55                   	push   %ebp
 5b1:	89 e5                	mov    %esp,%ebp
  free((void *) lk->lock);
 5b3:	8b 45 08             	mov    0x8(%ebp),%eax
 5b6:	8b 00                	mov    (%eax),%eax
 5b8:	89 45 08             	mov    %eax,0x8(%ebp)
}
 5bb:	5d                   	pop    %ebp
  free((void *) lk->lock);
 5bc:	e9 6f 05 00 00       	jmp    b30 <free>
 5c1:	66 90                	xchg   %ax,%ax
 5c3:	66 90                	xchg   %ax,%ax
 5c5:	66 90                	xchg   %ax,%ax
 5c7:	66 90                	xchg   %ax,%ax
 5c9:	66 90                	xchg   %ax,%ax
 5cb:	66 90                	xchg   %ax,%ax
 5cd:	66 90                	xchg   %ax,%ax
 5cf:	90                   	nop

000005d0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 5d0:	55                   	push   %ebp
 5d1:	89 e5                	mov    %esp,%ebp
 5d3:	8b 45 08             	mov    0x8(%ebp),%eax
 5d6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 5d9:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 5da:	89 c2                	mov    %eax,%edx
 5dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5e0:	83 c1 01             	add    $0x1,%ecx
 5e3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 5e7:	83 c2 01             	add    $0x1,%edx
 5ea:	84 db                	test   %bl,%bl
 5ec:	88 5a ff             	mov    %bl,-0x1(%edx)
 5ef:	75 ef                	jne    5e0 <strcpy+0x10>
    ;
  return os;
}
 5f1:	5b                   	pop    %ebx
 5f2:	5d                   	pop    %ebp
 5f3:	c3                   	ret    
 5f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000600 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 600:	55                   	push   %ebp
 601:	89 e5                	mov    %esp,%ebp
 603:	8b 55 08             	mov    0x8(%ebp),%edx
 606:	53                   	push   %ebx
 607:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 60a:	0f b6 02             	movzbl (%edx),%eax
 60d:	84 c0                	test   %al,%al
 60f:	74 2d                	je     63e <strcmp+0x3e>
 611:	0f b6 19             	movzbl (%ecx),%ebx
 614:	38 d8                	cmp    %bl,%al
 616:	74 0e                	je     626 <strcmp+0x26>
 618:	eb 2b                	jmp    645 <strcmp+0x45>
 61a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 620:	38 c8                	cmp    %cl,%al
 622:	75 15                	jne    639 <strcmp+0x39>
    p++, q++;
 624:	89 d9                	mov    %ebx,%ecx
 626:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 629:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 62c:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 62f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 633:	84 c0                	test   %al,%al
 635:	75 e9                	jne    620 <strcmp+0x20>
 637:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 639:	29 c8                	sub    %ecx,%eax
}
 63b:	5b                   	pop    %ebx
 63c:	5d                   	pop    %ebp
 63d:	c3                   	ret    
 63e:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
 641:	31 c0                	xor    %eax,%eax
 643:	eb f4                	jmp    639 <strcmp+0x39>
 645:	0f b6 cb             	movzbl %bl,%ecx
 648:	eb ef                	jmp    639 <strcmp+0x39>
 64a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000650 <strlen>:

uint
strlen(const char *s)
{
 650:	55                   	push   %ebp
 651:	89 e5                	mov    %esp,%ebp
 653:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 656:	80 39 00             	cmpb   $0x0,(%ecx)
 659:	74 12                	je     66d <strlen+0x1d>
 65b:	31 d2                	xor    %edx,%edx
 65d:	8d 76 00             	lea    0x0(%esi),%esi
 660:	83 c2 01             	add    $0x1,%edx
 663:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 667:	89 d0                	mov    %edx,%eax
 669:	75 f5                	jne    660 <strlen+0x10>
    ;
  return n;
}
 66b:	5d                   	pop    %ebp
 66c:	c3                   	ret    
  for(n = 0; s[n]; n++)
 66d:	31 c0                	xor    %eax,%eax
}
 66f:	5d                   	pop    %ebp
 670:	c3                   	ret    
 671:	eb 0d                	jmp    680 <memset>
 673:	90                   	nop
 674:	90                   	nop
 675:	90                   	nop
 676:	90                   	nop
 677:	90                   	nop
 678:	90                   	nop
 679:	90                   	nop
 67a:	90                   	nop
 67b:	90                   	nop
 67c:	90                   	nop
 67d:	90                   	nop
 67e:	90                   	nop
 67f:	90                   	nop

00000680 <memset>:

void*
memset(void *dst, int c, uint n)
{
 680:	55                   	push   %ebp
 681:	89 e5                	mov    %esp,%ebp
 683:	8b 55 08             	mov    0x8(%ebp),%edx
 686:	57                   	push   %edi
  asm volatile("cld; rep stosb" :
 687:	8b 4d 10             	mov    0x10(%ebp),%ecx
 68a:	8b 45 0c             	mov    0xc(%ebp),%eax
 68d:	89 d7                	mov    %edx,%edi
 68f:	fc                   	cld    
 690:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 692:	89 d0                	mov    %edx,%eax
 694:	5f                   	pop    %edi
 695:	5d                   	pop    %ebp
 696:	c3                   	ret    
 697:	89 f6                	mov    %esi,%esi
 699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006a0 <strchr>:

char*
strchr(const char *s, char c)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	8b 45 08             	mov    0x8(%ebp),%eax
 6a6:	53                   	push   %ebx
 6a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 6aa:	0f b6 18             	movzbl (%eax),%ebx
 6ad:	84 db                	test   %bl,%bl
 6af:	74 1d                	je     6ce <strchr+0x2e>
    if(*s == c)
 6b1:	38 d3                	cmp    %dl,%bl
 6b3:	89 d1                	mov    %edx,%ecx
 6b5:	75 0d                	jne    6c4 <strchr+0x24>
 6b7:	eb 17                	jmp    6d0 <strchr+0x30>
 6b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6c0:	38 ca                	cmp    %cl,%dl
 6c2:	74 0c                	je     6d0 <strchr+0x30>
  for(; *s; s++)
 6c4:	83 c0 01             	add    $0x1,%eax
 6c7:	0f b6 10             	movzbl (%eax),%edx
 6ca:	84 d2                	test   %dl,%dl
 6cc:	75 f2                	jne    6c0 <strchr+0x20>
      return (char*)s;
  return 0;
 6ce:	31 c0                	xor    %eax,%eax
}
 6d0:	5b                   	pop    %ebx
 6d1:	5d                   	pop    %ebp
 6d2:	c3                   	ret    
 6d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006e0 <gets>:

char*
gets(char *buf, int max)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	57                   	push   %edi
 6e4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 6e5:	31 f6                	xor    %esi,%esi
{
 6e7:	53                   	push   %ebx
 6e8:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 6eb:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 6ee:	eb 31                	jmp    721 <gets+0x41>
    cc = read(0, &c, 1);
 6f0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6f7:	00 
 6f8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 6fc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 703:	e8 02 01 00 00       	call   80a <read>
    if(cc < 1)
 708:	85 c0                	test   %eax,%eax
 70a:	7e 1d                	jle    729 <gets+0x49>
      break;
    buf[i++] = c;
 70c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 710:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 712:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 715:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 717:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 71b:	74 0c                	je     729 <gets+0x49>
 71d:	3c 0a                	cmp    $0xa,%al
 71f:	74 08                	je     729 <gets+0x49>
  for(i=0; i+1 < max; ){
 721:	8d 5e 01             	lea    0x1(%esi),%ebx
 724:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 727:	7c c7                	jl     6f0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 729:	8b 45 08             	mov    0x8(%ebp),%eax
 72c:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 730:	83 c4 2c             	add    $0x2c,%esp
 733:	5b                   	pop    %ebx
 734:	5e                   	pop    %esi
 735:	5f                   	pop    %edi
 736:	5d                   	pop    %ebp
 737:	c3                   	ret    
 738:	90                   	nop
 739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000740 <stat>:

int
stat(const char *n, struct stat *st)
{
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	56                   	push   %esi
 744:	53                   	push   %ebx
 745:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 748:	8b 45 08             	mov    0x8(%ebp),%eax
 74b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 752:	00 
 753:	89 04 24             	mov    %eax,(%esp)
 756:	e8 d7 00 00 00       	call   832 <open>
  if(fd < 0)
 75b:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 75d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 75f:	78 27                	js     788 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 761:	8b 45 0c             	mov    0xc(%ebp),%eax
 764:	89 1c 24             	mov    %ebx,(%esp)
 767:	89 44 24 04          	mov    %eax,0x4(%esp)
 76b:	e8 da 00 00 00       	call   84a <fstat>
  close(fd);
 770:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 773:	89 c6                	mov    %eax,%esi
  close(fd);
 775:	e8 a0 00 00 00       	call   81a <close>
  return r;
 77a:	89 f0                	mov    %esi,%eax
}
 77c:	83 c4 10             	add    $0x10,%esp
 77f:	5b                   	pop    %ebx
 780:	5e                   	pop    %esi
 781:	5d                   	pop    %ebp
 782:	c3                   	ret    
 783:	90                   	nop
 784:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 788:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 78d:	eb ed                	jmp    77c <stat+0x3c>
 78f:	90                   	nop

00000790 <atoi>:

int
atoi(const char *s)
{
 790:	55                   	push   %ebp
 791:	89 e5                	mov    %esp,%ebp
 793:	8b 4d 08             	mov    0x8(%ebp),%ecx
 796:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 797:	0f be 11             	movsbl (%ecx),%edx
 79a:	8d 42 d0             	lea    -0x30(%edx),%eax
 79d:	3c 09                	cmp    $0x9,%al
  n = 0;
 79f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 7a4:	77 17                	ja     7bd <atoi+0x2d>
 7a6:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 7a8:	83 c1 01             	add    $0x1,%ecx
 7ab:	8d 04 80             	lea    (%eax,%eax,4),%eax
 7ae:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 7b2:	0f be 11             	movsbl (%ecx),%edx
 7b5:	8d 5a d0             	lea    -0x30(%edx),%ebx
 7b8:	80 fb 09             	cmp    $0x9,%bl
 7bb:	76 eb                	jbe    7a8 <atoi+0x18>
  return n;
}
 7bd:	5b                   	pop    %ebx
 7be:	5d                   	pop    %ebp
 7bf:	c3                   	ret    

000007c0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 7c0:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 7c1:	31 d2                	xor    %edx,%edx
{
 7c3:	89 e5                	mov    %esp,%ebp
 7c5:	56                   	push   %esi
 7c6:	8b 45 08             	mov    0x8(%ebp),%eax
 7c9:	53                   	push   %ebx
 7ca:	8b 5d 10             	mov    0x10(%ebp),%ebx
 7cd:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 7d0:	85 db                	test   %ebx,%ebx
 7d2:	7e 12                	jle    7e6 <memmove+0x26>
 7d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 7d8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 7dc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 7df:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 7e2:	39 da                	cmp    %ebx,%edx
 7e4:	75 f2                	jne    7d8 <memmove+0x18>
  return vdst;
}
 7e6:	5b                   	pop    %ebx
 7e7:	5e                   	pop    %esi
 7e8:	5d                   	pop    %ebp
 7e9:	c3                   	ret    

000007ea <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 7ea:	b8 01 00 00 00       	mov    $0x1,%eax
 7ef:	cd 40                	int    $0x40
 7f1:	c3                   	ret    

000007f2 <exit>:
SYSCALL(exit)
 7f2:	b8 02 00 00 00       	mov    $0x2,%eax
 7f7:	cd 40                	int    $0x40
 7f9:	c3                   	ret    

000007fa <wait>:
SYSCALL(wait)
 7fa:	b8 03 00 00 00       	mov    $0x3,%eax
 7ff:	cd 40                	int    $0x40
 801:	c3                   	ret    

00000802 <pipe>:
SYSCALL(pipe)
 802:	b8 04 00 00 00       	mov    $0x4,%eax
 807:	cd 40                	int    $0x40
 809:	c3                   	ret    

0000080a <read>:
SYSCALL(read)
 80a:	b8 05 00 00 00       	mov    $0x5,%eax
 80f:	cd 40                	int    $0x40
 811:	c3                   	ret    

00000812 <write>:
SYSCALL(write)
 812:	b8 10 00 00 00       	mov    $0x10,%eax
 817:	cd 40                	int    $0x40
 819:	c3                   	ret    

0000081a <close>:
SYSCALL(close)
 81a:	b8 15 00 00 00       	mov    $0x15,%eax
 81f:	cd 40                	int    $0x40
 821:	c3                   	ret    

00000822 <kill>:
SYSCALL(kill)
 822:	b8 06 00 00 00       	mov    $0x6,%eax
 827:	cd 40                	int    $0x40
 829:	c3                   	ret    

0000082a <exec>:
SYSCALL(exec)
 82a:	b8 07 00 00 00       	mov    $0x7,%eax
 82f:	cd 40                	int    $0x40
 831:	c3                   	ret    

00000832 <open>:
SYSCALL(open)
 832:	b8 0f 00 00 00       	mov    $0xf,%eax
 837:	cd 40                	int    $0x40
 839:	c3                   	ret    

0000083a <mknod>:
SYSCALL(mknod)
 83a:	b8 11 00 00 00       	mov    $0x11,%eax
 83f:	cd 40                	int    $0x40
 841:	c3                   	ret    

00000842 <unlink>:
SYSCALL(unlink)
 842:	b8 12 00 00 00       	mov    $0x12,%eax
 847:	cd 40                	int    $0x40
 849:	c3                   	ret    

0000084a <fstat>:
SYSCALL(fstat)
 84a:	b8 08 00 00 00       	mov    $0x8,%eax
 84f:	cd 40                	int    $0x40
 851:	c3                   	ret    

00000852 <link>:
SYSCALL(link)
 852:	b8 13 00 00 00       	mov    $0x13,%eax
 857:	cd 40                	int    $0x40
 859:	c3                   	ret    

0000085a <mkdir>:
SYSCALL(mkdir)
 85a:	b8 14 00 00 00       	mov    $0x14,%eax
 85f:	cd 40                	int    $0x40
 861:	c3                   	ret    

00000862 <chdir>:
SYSCALL(chdir)
 862:	b8 09 00 00 00       	mov    $0x9,%eax
 867:	cd 40                	int    $0x40
 869:	c3                   	ret    

0000086a <dup>:
SYSCALL(dup)
 86a:	b8 0a 00 00 00       	mov    $0xa,%eax
 86f:	cd 40                	int    $0x40
 871:	c3                   	ret    

00000872 <getpid>:
SYSCALL(getpid)
 872:	b8 0b 00 00 00       	mov    $0xb,%eax
 877:	cd 40                	int    $0x40
 879:	c3                   	ret    

0000087a <sbrk>:
SYSCALL(sbrk)
 87a:	b8 0c 00 00 00       	mov    $0xc,%eax
 87f:	cd 40                	int    $0x40
 881:	c3                   	ret    

00000882 <sleep>:
SYSCALL(sleep)
 882:	b8 0d 00 00 00       	mov    $0xd,%eax
 887:	cd 40                	int    $0x40
 889:	c3                   	ret    

0000088a <uptime>:
SYSCALL(uptime)
 88a:	b8 0e 00 00 00       	mov    $0xe,%eax
 88f:	cd 40                	int    $0x40
 891:	c3                   	ret    

00000892 <clone>:
SYSCALL(clone)
 892:	b8 16 00 00 00       	mov    $0x16,%eax
 897:	cd 40                	int    $0x40
 899:	c3                   	ret    
 89a:	66 90                	xchg   %ax,%ax
 89c:	66 90                	xchg   %ax,%ax
 89e:	66 90                	xchg   %ax,%ax

000008a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 8a0:	55                   	push   %ebp
 8a1:	89 e5                	mov    %esp,%ebp
 8a3:	57                   	push   %edi
 8a4:	56                   	push   %esi
 8a5:	89 c6                	mov    %eax,%esi
 8a7:	53                   	push   %ebx
 8a8:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 8ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
 8ae:	85 db                	test   %ebx,%ebx
 8b0:	74 09                	je     8bb <printint+0x1b>
 8b2:	89 d0                	mov    %edx,%eax
 8b4:	c1 e8 1f             	shr    $0x1f,%eax
 8b7:	84 c0                	test   %al,%al
 8b9:	75 75                	jne    930 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 8bb:	89 d0                	mov    %edx,%eax
  neg = 0;
 8bd:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 8c4:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 8c7:	31 ff                	xor    %edi,%edi
 8c9:	89 ce                	mov    %ecx,%esi
 8cb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 8ce:	eb 02                	jmp    8d2 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 8d0:	89 cf                	mov    %ecx,%edi
 8d2:	31 d2                	xor    %edx,%edx
 8d4:	f7 f6                	div    %esi
 8d6:	8d 4f 01             	lea    0x1(%edi),%ecx
 8d9:	0f b6 92 b3 0d 00 00 	movzbl 0xdb3(%edx),%edx
  }while((x /= base) != 0);
 8e0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 8e2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 8e5:	75 e9                	jne    8d0 <printint+0x30>
  if(neg)
 8e7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 8ea:	89 c8                	mov    %ecx,%eax
 8ec:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 8ef:	85 d2                	test   %edx,%edx
 8f1:	74 08                	je     8fb <printint+0x5b>
    buf[i++] = '-';
 8f3:	8d 4f 02             	lea    0x2(%edi),%ecx
 8f6:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 8fb:	8d 79 ff             	lea    -0x1(%ecx),%edi
 8fe:	66 90                	xchg   %ax,%ax
 900:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 905:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 908:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 90f:	00 
 910:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 914:	89 34 24             	mov    %esi,(%esp)
 917:	88 45 d7             	mov    %al,-0x29(%ebp)
 91a:	e8 f3 fe ff ff       	call   812 <write>
  while(--i >= 0)
 91f:	83 ff ff             	cmp    $0xffffffff,%edi
 922:	75 dc                	jne    900 <printint+0x60>
    putc(fd, buf[i]);
}
 924:	83 c4 4c             	add    $0x4c,%esp
 927:	5b                   	pop    %ebx
 928:	5e                   	pop    %esi
 929:	5f                   	pop    %edi
 92a:	5d                   	pop    %ebp
 92b:	c3                   	ret    
 92c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 930:	89 d0                	mov    %edx,%eax
 932:	f7 d8                	neg    %eax
    neg = 1;
 934:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 93b:	eb 87                	jmp    8c4 <printint+0x24>
 93d:	8d 76 00             	lea    0x0(%esi),%esi

00000940 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 940:	55                   	push   %ebp
 941:	89 e5                	mov    %esp,%ebp
 943:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 944:	31 ff                	xor    %edi,%edi
{
 946:	56                   	push   %esi
 947:	53                   	push   %ebx
 948:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 94b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 94e:	8d 45 10             	lea    0x10(%ebp),%eax
{
 951:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 954:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 957:	0f b6 13             	movzbl (%ebx),%edx
 95a:	83 c3 01             	add    $0x1,%ebx
 95d:	84 d2                	test   %dl,%dl
 95f:	75 39                	jne    99a <printf+0x5a>
 961:	e9 c2 00 00 00       	jmp    a28 <printf+0xe8>
 966:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 968:	83 fa 25             	cmp    $0x25,%edx
 96b:	0f 84 bf 00 00 00    	je     a30 <printf+0xf0>
  write(fd, &c, 1);
 971:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 974:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 97b:	00 
 97c:	89 44 24 04          	mov    %eax,0x4(%esp)
 980:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 983:	88 55 e2             	mov    %dl,-0x1e(%ebp)
  write(fd, &c, 1);
 986:	e8 87 fe ff ff       	call   812 <write>
 98b:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 98e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 992:	84 d2                	test   %dl,%dl
 994:	0f 84 8e 00 00 00    	je     a28 <printf+0xe8>
    if(state == 0){
 99a:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 99c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 99f:	74 c7                	je     968 <printf+0x28>
      }
    } else if(state == '%'){
 9a1:	83 ff 25             	cmp    $0x25,%edi
 9a4:	75 e5                	jne    98b <printf+0x4b>
      if(c == 'd'){
 9a6:	83 fa 64             	cmp    $0x64,%edx
 9a9:	0f 84 31 01 00 00    	je     ae0 <printf+0x1a0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 9af:	25 f7 00 00 00       	and    $0xf7,%eax
 9b4:	83 f8 70             	cmp    $0x70,%eax
 9b7:	0f 84 83 00 00 00    	je     a40 <printf+0x100>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 9bd:	83 fa 73             	cmp    $0x73,%edx
 9c0:	0f 84 a2 00 00 00    	je     a68 <printf+0x128>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 9c6:	83 fa 63             	cmp    $0x63,%edx
 9c9:	0f 84 35 01 00 00    	je     b04 <printf+0x1c4>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 9cf:	83 fa 25             	cmp    $0x25,%edx
 9d2:	0f 84 e0 00 00 00    	je     ab8 <printf+0x178>
  write(fd, &c, 1);
 9d8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 9db:	83 c3 01             	add    $0x1,%ebx
 9de:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 9e5:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 9e6:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 9e8:	89 44 24 04          	mov    %eax,0x4(%esp)
 9ec:	89 34 24             	mov    %esi,(%esp)
 9ef:	89 55 d0             	mov    %edx,-0x30(%ebp)
 9f2:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 9f6:	e8 17 fe ff ff       	call   812 <write>
        putc(fd, c);
 9fb:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 9fe:	8d 45 e7             	lea    -0x19(%ebp),%eax
 a01:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 a08:	00 
 a09:	89 44 24 04          	mov    %eax,0x4(%esp)
 a0d:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 a10:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 a13:	e8 fa fd ff ff       	call   812 <write>
  for(i = 0; fmt[i]; i++){
 a18:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 a1c:	84 d2                	test   %dl,%dl
 a1e:	0f 85 76 ff ff ff    	jne    99a <printf+0x5a>
 a24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }
}
 a28:	83 c4 3c             	add    $0x3c,%esp
 a2b:	5b                   	pop    %ebx
 a2c:	5e                   	pop    %esi
 a2d:	5f                   	pop    %edi
 a2e:	5d                   	pop    %ebp
 a2f:	c3                   	ret    
        state = '%';
 a30:	bf 25 00 00 00       	mov    $0x25,%edi
 a35:	e9 51 ff ff ff       	jmp    98b <printf+0x4b>
 a3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 a40:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 a43:	b9 10 00 00 00       	mov    $0x10,%ecx
      state = 0;
 a48:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 a4a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 a51:	8b 10                	mov    (%eax),%edx
 a53:	89 f0                	mov    %esi,%eax
 a55:	e8 46 fe ff ff       	call   8a0 <printint>
        ap++;
 a5a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 a5e:	e9 28 ff ff ff       	jmp    98b <printf+0x4b>
 a63:	90                   	nop
 a64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 a68:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 a6b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 a6f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 a71:	b8 ac 0d 00 00       	mov    $0xdac,%eax
 a76:	85 ff                	test   %edi,%edi
 a78:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 a7b:	0f b6 07             	movzbl (%edi),%eax
 a7e:	84 c0                	test   %al,%al
 a80:	74 2a                	je     aac <printf+0x16c>
 a82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 a88:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 a8b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 a8e:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 a91:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 a98:	00 
 a99:	89 44 24 04          	mov    %eax,0x4(%esp)
 a9d:	89 34 24             	mov    %esi,(%esp)
 aa0:	e8 6d fd ff ff       	call   812 <write>
        while(*s != 0){
 aa5:	0f b6 07             	movzbl (%edi),%eax
 aa8:	84 c0                	test   %al,%al
 aaa:	75 dc                	jne    a88 <printf+0x148>
      state = 0;
 aac:	31 ff                	xor    %edi,%edi
 aae:	e9 d8 fe ff ff       	jmp    98b <printf+0x4b>
 ab3:	90                   	nop
 ab4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 ab8:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 abb:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 abd:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 ac4:	00 
 ac5:	89 44 24 04          	mov    %eax,0x4(%esp)
 ac9:	89 34 24             	mov    %esi,(%esp)
 acc:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 ad0:	e8 3d fd ff ff       	call   812 <write>
 ad5:	e9 b1 fe ff ff       	jmp    98b <printf+0x4b>
 ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 ae0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 ae3:	b9 0a 00 00 00       	mov    $0xa,%ecx
      state = 0;
 ae8:	66 31 ff             	xor    %di,%di
        printint(fd, *ap, 10, 1);
 aeb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 af2:	8b 10                	mov    (%eax),%edx
 af4:	89 f0                	mov    %esi,%eax
 af6:	e8 a5 fd ff ff       	call   8a0 <printint>
        ap++;
 afb:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 aff:	e9 87 fe ff ff       	jmp    98b <printf+0x4b>
        putc(fd, *ap);
 b04:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 b07:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 b09:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 b0b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 b12:	00 
 b13:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 b16:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 b19:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 b1c:	89 44 24 04          	mov    %eax,0x4(%esp)
 b20:	e8 ed fc ff ff       	call   812 <write>
        ap++;
 b25:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 b29:	e9 5d fe ff ff       	jmp    98b <printf+0x4b>
 b2e:	66 90                	xchg   %ax,%ax

00000b30 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b30:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b31:	a1 94 12 00 00       	mov    0x1294,%eax
{
 b36:	89 e5                	mov    %esp,%ebp
 b38:	57                   	push   %edi
 b39:	56                   	push   %esi
 b3a:	53                   	push   %ebx
 b3b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b3e:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 b40:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b43:	39 d0                	cmp    %edx,%eax
 b45:	72 11                	jb     b58 <free+0x28>
 b47:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b48:	39 c8                	cmp    %ecx,%eax
 b4a:	72 04                	jb     b50 <free+0x20>
 b4c:	39 ca                	cmp    %ecx,%edx
 b4e:	72 10                	jb     b60 <free+0x30>
 b50:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b52:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b54:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b56:	73 f0                	jae    b48 <free+0x18>
 b58:	39 ca                	cmp    %ecx,%edx
 b5a:	72 04                	jb     b60 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b5c:	39 c8                	cmp    %ecx,%eax
 b5e:	72 f0                	jb     b50 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b60:	8b 73 fc             	mov    -0x4(%ebx),%esi
 b63:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 b66:	39 cf                	cmp    %ecx,%edi
 b68:	74 1e                	je     b88 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 b6a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 b6d:	8b 48 04             	mov    0x4(%eax),%ecx
 b70:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 b73:	39 f2                	cmp    %esi,%edx
 b75:	74 28                	je     b9f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 b77:	89 10                	mov    %edx,(%eax)
  freep = p;
 b79:	a3 94 12 00 00       	mov    %eax,0x1294
}
 b7e:	5b                   	pop    %ebx
 b7f:	5e                   	pop    %esi
 b80:	5f                   	pop    %edi
 b81:	5d                   	pop    %ebp
 b82:	c3                   	ret    
 b83:	90                   	nop
 b84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 b88:	03 71 04             	add    0x4(%ecx),%esi
 b8b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 b8e:	8b 08                	mov    (%eax),%ecx
 b90:	8b 09                	mov    (%ecx),%ecx
 b92:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 b95:	8b 48 04             	mov    0x4(%eax),%ecx
 b98:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 b9b:	39 f2                	cmp    %esi,%edx
 b9d:	75 d8                	jne    b77 <free+0x47>
    p->s.size += bp->s.size;
 b9f:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 ba2:	a3 94 12 00 00       	mov    %eax,0x1294
    p->s.size += bp->s.size;
 ba7:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 baa:	8b 53 f8             	mov    -0x8(%ebx),%edx
 bad:	89 10                	mov    %edx,(%eax)
}
 baf:	5b                   	pop    %ebx
 bb0:	5e                   	pop    %esi
 bb1:	5f                   	pop    %edi
 bb2:	5d                   	pop    %ebp
 bb3:	c3                   	ret    
 bb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 bba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000bc0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 bc0:	55                   	push   %ebp
 bc1:	89 e5                	mov    %esp,%ebp
 bc3:	57                   	push   %edi
 bc4:	56                   	push   %esi
 bc5:	53                   	push   %ebx
 bc6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bc9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 bcc:	8b 1d 94 12 00 00    	mov    0x1294,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bd2:	8d 48 07             	lea    0x7(%eax),%ecx
 bd5:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 bd8:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bda:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 bdd:	0f 84 9b 00 00 00    	je     c7e <malloc+0xbe>
 be3:	8b 13                	mov    (%ebx),%edx
 be5:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 be8:	39 fe                	cmp    %edi,%esi
 bea:	76 64                	jbe    c50 <malloc+0x90>
 bec:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 bf3:	bb 00 80 00 00       	mov    $0x8000,%ebx
 bf8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 bfb:	eb 0e                	jmp    c0b <malloc+0x4b>
 bfd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c00:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 c02:	8b 78 04             	mov    0x4(%eax),%edi
 c05:	39 fe                	cmp    %edi,%esi
 c07:	76 4f                	jbe    c58 <malloc+0x98>
 c09:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c0b:	3b 15 94 12 00 00    	cmp    0x1294,%edx
 c11:	75 ed                	jne    c00 <malloc+0x40>
  if(nu < 4096)
 c13:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 c16:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 c1c:	bf 00 10 00 00       	mov    $0x1000,%edi
 c21:	0f 43 fe             	cmovae %esi,%edi
 c24:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 c27:	89 04 24             	mov    %eax,(%esp)
 c2a:	e8 4b fc ff ff       	call   87a <sbrk>
  if(p == (char*)-1)
 c2f:	83 f8 ff             	cmp    $0xffffffff,%eax
 c32:	74 18                	je     c4c <malloc+0x8c>
  hp->s.size = nu;
 c34:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 c37:	83 c0 08             	add    $0x8,%eax
 c3a:	89 04 24             	mov    %eax,(%esp)
 c3d:	e8 ee fe ff ff       	call   b30 <free>
  return freep;
 c42:	8b 15 94 12 00 00    	mov    0x1294,%edx
      if((p = morecore(nunits)) == 0)
 c48:	85 d2                	test   %edx,%edx
 c4a:	75 b4                	jne    c00 <malloc+0x40>
        return 0;
 c4c:	31 c0                	xor    %eax,%eax
 c4e:	eb 20                	jmp    c70 <malloc+0xb0>
    if(p->s.size >= nunits){
 c50:	89 d0                	mov    %edx,%eax
 c52:	89 da                	mov    %ebx,%edx
 c54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 c58:	39 fe                	cmp    %edi,%esi
 c5a:	74 1c                	je     c78 <malloc+0xb8>
        p->s.size -= nunits;
 c5c:	29 f7                	sub    %esi,%edi
 c5e:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 c61:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 c64:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 c67:	89 15 94 12 00 00    	mov    %edx,0x1294
      return (void*)(p + 1);
 c6d:	83 c0 08             	add    $0x8,%eax
  }
}
 c70:	83 c4 1c             	add    $0x1c,%esp
 c73:	5b                   	pop    %ebx
 c74:	5e                   	pop    %esi
 c75:	5f                   	pop    %edi
 c76:	5d                   	pop    %ebp
 c77:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 c78:	8b 08                	mov    (%eax),%ecx
 c7a:	89 0a                	mov    %ecx,(%edx)
 c7c:	eb e9                	jmp    c67 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 c7e:	c7 05 94 12 00 00 98 	movl   $0x1298,0x1294
 c85:	12 00 00 
    base.s.size = 0;
 c88:	ba 98 12 00 00       	mov    $0x1298,%edx
    base.s.ptr = freep = prevp = &base;
 c8d:	c7 05 98 12 00 00 98 	movl   $0x1298,0x1298
 c94:	12 00 00 
    base.s.size = 0;
 c97:	c7 05 9c 12 00 00 00 	movl   $0x0,0x129c
 c9e:	00 00 00 
 ca1:	e9 46 ff ff ff       	jmp    bec <malloc+0x2c>
