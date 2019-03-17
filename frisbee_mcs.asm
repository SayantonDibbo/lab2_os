
_frisbee_mcs:     file format elf32-i386


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

  mcs_lock_t lock;
  mcslock_init(&lock);

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

/* MCS Lock */

void mcslock_init(mcs_lock_t *lk){
  lk->next = NULL;
  3f:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  46:	00 
  lk->spin = 0;
  47:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
  4e:	00 
  4f:	e8 2c 0b 00 00       	call   b80 <malloc>
  54:	89 c3                	mov    %eax,%ebx
  time -= uptime();
  56:	e8 ef 07 00 00       	call   84a <uptime>
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
  77:	c7 04 24 60 03 00 00 	movl   $0x360,(%esp)
  7e:	e8 fd 00 00 00       	call   180 <thread_create>
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
  a3:	e8 12 07 00 00       	call   7ba <wait>
  a8:	85 c0                	test   %eax,%eax
  aa:	79 ec                	jns    98 <main+0x98>
      printf(1, "Sorry! Error occurred in the time of thread exiting\n");
  ac:	c7 44 24 04 34 0d 00 	movl   $0xd34,0x4(%esp)
  b3:	00 
  for(i=0; i<numthreads; i++){
  b4:	83 c3 01             	add    $0x1,%ebx
      printf(1, "Sorry! Error occurred in the time of thread exiting\n");
  b7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  be:	e8 3d 08 00 00       	call   900 <printf>
  for(i=0; i<numthreads; i++){
  c3:	39 1d 70 12 00 00    	cmp    %ebx,0x1270
  c9:	77 d8                	ja     a3 <main+0xa3>
  cb:	90                   	nop
  cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  time += uptime();
  d0:	e8 75 07 00 00       	call   84a <uptime>
  printf(1, "The FRISBEE GAME is finished, with  %d rounds\n", maxpass);
  d5:	c7 44 24 04 dc 0c 00 	movl   $0xcdc,0x4(%esp)
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
  f3:	e8 08 08 00 00       	call   900 <printf>
  printf(1, "\nFrisbee Game Total Running Time: %d\n", time);
  f8:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  fc:	c7 44 24 04 0c 0d 00 	movl   $0xd0c,0x4(%esp)
 103:	00 
 104:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 10b:	e8 f0 07 00 00       	call   900 <printf>

  exit();
 110:	e8 9d 06 00 00       	call   7b2 <exit>
  maxpass = argc > 2 ? (uint) atoi(argv[2]) : 60;
 115:	8b 43 08             	mov    0x8(%ebx),%eax
 118:	89 04 24             	mov    %eax,(%esp)
 11b:	e8 30 06 00 00       	call   750 <atoi>
 120:	a3 6c 12 00 00       	mov    %eax,0x126c
  numthreads = argc > 1 ? (uint) atoi(argv[1]) : 20;
 125:	8b 43 04             	mov    0x4(%ebx),%eax
 128:	89 04 24             	mov    %eax,(%esp)
 12b:	e8 20 06 00 00       	call   750 <atoi>
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
 155:	e8 96 09 00 00       	call   af0 <free>
  exit();
 15a:	e8 53 06 00 00       	call   7b2 <exit>
 15f:	90                   	nop

00000160 <thread_panic>:
void thread_panic(void){
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	83 ec 18             	sub    $0x18,%esp
     printf(1, "** Thread shouldn't execute this instruction **\n");
 166:	c7 44 24 04 68 0c 00 	movl   $0xc68,0x4(%esp)
 16d:	00 
 16e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 175:	e8 86 07 00 00       	call   900 <printf>
   }
 17a:	c9                   	leave  
 17b:	c3                   	ret    
 17c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000180 <thread_create>:
void thread_create(void *(*start_routine)(void *), void *arg) {
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	56                   	push   %esi
 184:	53                   	push   %ebx
 185:	83 ec 10             	sub    $0x10,%esp
 188:	8b 5d 08             	mov    0x8(%ebp),%ebx
  void *stack = malloc(size);
 18b:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
void thread_create(void *(*start_routine)(void *), void *arg) {
 192:	8b 75 0c             	mov    0xc(%ebp),%esi
  void *stack = malloc(size);
 195:	e8 e6 09 00 00       	call   b80 <malloc>
  *(--endstack) = (uint) stack;
 19a:	89 80 fc 0f 00 00    	mov    %eax,0xffc(%eax)
  *(--endstack) = (uint) arg;
 1a0:	89 b0 f8 0f 00 00    	mov    %esi,0xff8(%eax)
  *(--endstack) = (uint) start_routine;
 1a6:	89 98 f4 0f 00 00    	mov    %ebx,0xff4(%eax)
  *(--endstack) = (uint) &thread_panic;
 1ac:	c7 80 f0 0f 00 00 60 	movl   $0x160,0xff0(%eax)
 1b3:	01 00 00 
  *(--endstack) = (uint) &thread_routine;
 1b6:	c7 80 ec 0f 00 00 40 	movl   $0x140,0xfec(%eax)
 1bd:	01 00 00 
  clone(stack, size);
 1c0:	c7 45 0c ec 0f 00 00 	movl   $0xfec,0xc(%ebp)
 1c7:	89 45 08             	mov    %eax,0x8(%ebp)
}
 1ca:	83 c4 10             	add    $0x10,%esp
 1cd:	5b                   	pop    %ebx
 1ce:	5e                   	pop    %esi
 1cf:	5d                   	pop    %ebp
  clone(stack, size);
 1d0:	e9 7d 06 00 00       	jmp    852 <clone>
 1d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001e0 <lock_init>:
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
  lk->lock = 0;
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
 1e6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
 1ec:	5d                   	pop    %ebp
 1ed:	c3                   	ret    
 1ee:	66 90                	xchg   %ax,%ax

000001f0 <lock_acquire>:
void lock_acquire(struct lock_t *lk){
 1f0:	55                   	push   %ebp
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
 1f1:	b9 01 00 00 00       	mov    $0x1,%ecx
 1f6:	89 e5                	mov    %esp,%ebp
 1f8:	8b 55 08             	mov    0x8(%ebp),%edx
 1fb:	90                   	nop
 1fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 200:	89 c8                	mov    %ecx,%eax
 202:	f0 87 02             	lock xchg %eax,(%edx)
  while (xchg(&lk->lock, 1) != 0);
 205:	85 c0                	test   %eax,%eax
 207:	75 f7                	jne    200 <lock_acquire+0x10>
}
 209:	5d                   	pop    %ebp
 20a:	c3                   	ret    
 20b:	90                   	nop
 20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000210 <lock_release>:
void lock_release(struct lock_t *lk){
 210:	55                   	push   %ebp
 211:	31 c0                	xor    %eax,%eax
 213:	89 e5                	mov    %esp,%ebp
 215:	8b 55 08             	mov    0x8(%ebp),%edx
 218:	f0 87 02             	lock xchg %eax,(%edx)
}
 21b:	5d                   	pop    %ebp
 21c:	c3                   	ret    
 21d:	8d 76 00             	lea    0x0(%esi),%esi

00000220 <seqlock_init>:
void seqlock_init(struct seqlock_t *lk){
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->seq = 0;
 226:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->splk = 0;
 22c:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
}
 233:	5d                   	pop    %ebp
 234:	c3                   	ret    
 235:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000240 <seqlock_read>:
uint seqlock_read(struct seqlock_t *lk, uint *mem) {
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	56                   	push   %esi
 244:	8b 75 0c             	mov    0xc(%ebp),%esi
 247:	53                   	push   %ebx
 248:	8b 5d 08             	mov    0x8(%ebp),%ebx
    retval = *mem;
 24b:	8b 06                	mov    (%esi),%eax
 24d:	8b 0b                	mov    (%ebx),%ecx
    seqf = lk->seq;
 24f:	8b 13                	mov    (%ebx),%edx
    if ( (seqi != seqf) || (seqi & 0x1)) continue;
 251:	39 ca                	cmp    %ecx,%edx
 253:	74 0d                	je     262 <seqlock_read+0x22>
 255:	8d 76 00             	lea    0x0(%esi),%esi
 258:	89 d1                	mov    %edx,%ecx
    retval = *mem;
 25a:	8b 06                	mov    (%esi),%eax
    seqf = lk->seq;
 25c:	8b 13                	mov    (%ebx),%edx
    if ( (seqi != seqf) || (seqi & 0x1)) continue;
 25e:	39 ca                	cmp    %ecx,%edx
 260:	75 f6                	jne    258 <seqlock_read+0x18>
 262:	83 e1 01             	and    $0x1,%ecx
 265:	75 f1                	jne    258 <seqlock_read+0x18>
}
 267:	5b                   	pop    %ebx
 268:	5e                   	pop    %esi
 269:	5d                   	pop    %ebp
 26a:	c3                   	ret    
 26b:	90                   	nop
 26c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000270 <seqlock_write>:
void seqlock_write(struct seqlock_t *lk, uint *mem, uint val){
 270:	55                   	push   %ebp
 271:	b9 01 00 00 00       	mov    $0x1,%ecx
 276:	89 e5                	mov    %esp,%ebp
 278:	53                   	push   %ebx
 279:	8b 5d 08             	mov    0x8(%ebp),%ebx
 27c:	8d 53 04             	lea    0x4(%ebx),%edx
 27f:	90                   	nop
 280:	89 c8                	mov    %ecx,%eax
 282:	f0 87 02             	lock xchg %eax,(%edx)
     while (xchg(&lk->splk, 1) != 0);
 285:	85 c0                	test   %eax,%eax
 287:	75 f7                	jne    280 <seqlock_write+0x10>
lk->seq++;
 289:	83 03 01             	addl   $0x1,(%ebx)
  *mem = val;
 28c:	8b 4d 10             	mov    0x10(%ebp),%ecx
 28f:	8b 55 0c             	mov    0xc(%ebp),%edx
 292:	89 0a                	mov    %ecx,(%edx)
  lk->seq++;
 294:	83 03 01             	addl   $0x1,(%ebx)
 297:	f0 87 43 04          	lock xchg %eax,0x4(%ebx)
    }
 29b:	5b                   	pop    %ebx
 29c:	5d                   	pop    %ebp
 29d:	c3                   	ret    
 29e:	66 90                	xchg   %ax,%ax

000002a0 <mcslock_init>:
void mcslock_init(mcs_lock_t *lk){
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->next = NULL;
 2a6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->spin = 0;
 2ac:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
}
 2b3:	5d                   	pop    %ebp
 2b4:	c3                   	ret    
 2b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002c0 <mcslock_acquire>:

void mcslock_acquire(mcs_lock_t *lk, mcs_lock_t *qnode){
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	8b 55 0c             	mov    0xc(%ebp),%edx
 2c6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  mcs_lock_t *tail;

  qnode->next = NULL;
 2c9:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
 2cf:	89 d0                	mov    %edx,%eax
  qnode->spin = 0;
 2d1:	c7 42 04 00 00 00 00 	movl   $0x0,0x4(%edx)
 2d8:	f0 87 01             	lock xchg %eax,(%ecx)

  // Place itself in the queue if exists
  tail = (mcs_lock_t*) xchg((uint*) &lk->next, (uint) qnode);
  if (!tail) return; // queue is empty
 2db:	85 c0                	test   %eax,%eax
 2dd:	74 10                	je     2ef <mcslock_acquire+0x2f>

  tail->next = qnode; // Attach after queue if present
 2df:	89 10                	mov    %edx,(%eax)
 2e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile ("" ::: "memory"); // put a memory barrier
  while (!qnode->spin);
 2e8:	8b 42 04             	mov    0x4(%edx),%eax
 2eb:	85 c0                	test   %eax,%eax
 2ed:	74 f9                	je     2e8 <mcslock_acquire+0x28>
  return;
}
 2ef:	5d                   	pop    %ebp
 2f0:	c3                   	ret    
 2f1:	eb 0d                	jmp    300 <mcslock_release>
 2f3:	90                   	nop
 2f4:	90                   	nop
 2f5:	90                   	nop
 2f6:	90                   	nop
 2f7:	90                   	nop
 2f8:	90                   	nop
 2f9:	90                   	nop
 2fa:	90                   	nop
 2fb:	90                   	nop
 2fc:	90                   	nop
 2fd:	90                   	nop
 2fe:	90                   	nop
 2ff:	90                   	nop

00000300 <mcslock_release>:

void mcslock_release(mcs_lock_t *lk, mcs_lock_t *qnode){
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 306:	53                   	push   %ebx

  if (!qnode->next){ // No successor yet
 307:	8b 01                	mov    (%ecx),%eax
 309:	85 c0                	test   %eax,%eax
 30b:	74 0b                	je     318 <mcslock_release+0x18>
 // Wait for successor to update qnode
      while(!qnode->next);
        }
 //
 //         // Unlock next one
            qnode->next->spin = 1;
 30d:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
            }
 314:	5b                   	pop    %ebx
 315:	5d                   	pop    %ebp
 316:	c3                   	ret    
 317:	90                   	nop
 318:	8b 45 08             	mov    0x8(%ebp),%eax
 31b:	bb 01 00 00 00       	mov    $0x1,%ebx
 320:	8d 50 04             	lea    0x4(%eax),%edx
 323:	90                   	nop
 324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 328:	89 d8                	mov    %ebx,%eax
 32a:	f0 87 02             	lock xchg %eax,(%edx)
  while (xchg(&lk->spin, 1) != 0);
 32d:	85 c0                	test   %eax,%eax
 32f:	75 f7                	jne    328 <mcslock_release+0x28>
    t = lk->next;
 331:	8b 45 08             	mov    0x8(%ebp),%eax
 334:	8b 10                	mov    (%eax),%edx
    if(t == qnode) lk->next = NULL;
 336:	39 ca                	cmp    %ecx,%edx
 338:	74 16                	je     350 <mcslock_release+0x50>
 33a:	31 c0                	xor    %eax,%eax
 33c:	8b 5d 08             	mov    0x8(%ebp),%ebx
 33f:	f0 87 43 04          	lock xchg %eax,0x4(%ebx)
    if(t == qnode) return;
 343:	39 ca                	cmp    %ecx,%edx
 345:	74 cd                	je     314 <mcslock_release+0x14>
 347:	8b 01                	mov    (%ecx),%eax
      while(!qnode->next);
 349:	85 c0                	test   %eax,%eax
 34b:	75 c0                	jne    30d <mcslock_release+0xd>
 34d:	eb fe                	jmp    34d <mcslock_release+0x4d>
 34f:	90                   	nop
    if(t == qnode) lk->next = NULL;
 350:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
 356:	eb e2                	jmp    33a <mcslock_release+0x3a>
 358:	90                   	nop
 359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000360 <frisbee_task>:
}

void *frisbee_task(void *arg){
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	57                   	push   %edi
 364:	56                   	push   %esi
 365:	53                   	push   %ebx
 366:	83 ec 3c             	sub    $0x3c,%esp
 369:	8b 75 08             	mov    0x8(%ebp),%esi
 36c:	8d 7d e0             	lea    -0x20(%ebp),%edi
  targs *args = (targs*) arg;
  uint tid = args->tid;
 36f:	8b 1e                	mov    (%esi),%ebx
      mcslock_release(args->lock, &qnode);
      break;
    }

    if(cur_owner == tid) {
      cur_owner++;
 371:	8d 43 01             	lea    0x1(%ebx),%eax
 374:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    if(passes > maxpass) break;
 377:	a1 6c 12 00 00       	mov    0x126c,%eax
 37c:	39 05 58 12 00 00    	cmp    %eax,0x1258
 382:	77 5c                	ja     3e0 <frisbee_task+0x80>
 384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    mcslock_acquire(args->lock, &qnode);
 388:	8b 4e 04             	mov    0x4(%esi),%ecx
 38b:	89 f8                	mov    %edi,%eax
  qnode->next = NULL;
 38d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  qnode->spin = 0;
 394:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 39b:	f0 87 01             	lock xchg %eax,(%ecx)
  if (!tail) return; // queue is empty
 39e:	85 c0                	test   %eax,%eax
 3a0:	74 0d                	je     3af <frisbee_task+0x4f>
  tail->next = qnode; // Attach after queue if present
 3a2:	89 38                	mov    %edi,(%eax)
 3a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while (!qnode->spin);
 3a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 3ab:	85 c0                	test   %eax,%eax
 3ad:	74 f9                	je     3a8 <frisbee_task+0x48>
    if (passes > maxpass) {
 3af:	a1 58 12 00 00       	mov    0x1258,%eax
 3b4:	3b 05 6c 12 00 00    	cmp    0x126c,%eax
 3ba:	77 7e                	ja     43a <frisbee_task+0xda>
    if(cur_owner == tid) {
 3bc:	39 1d 5c 12 00 00    	cmp    %ebx,0x125c
 3c2:	74 2c                	je     3f0 <frisbee_task+0x90>
      printf(1, "Pass number: %d, Thread %d is passing the token to thread %d\n", passes, tid, cur_owner);

      passes++;
    }

    mcslock_release(args->lock, &qnode);
 3c4:	89 7c 24 04          	mov    %edi,0x4(%esp)
 3c8:	8b 46 04             	mov    0x4(%esi),%eax
 3cb:	89 04 24             	mov    %eax,(%esp)
 3ce:	e8 2d ff ff ff       	call   300 <mcslock_release>
    if(passes > maxpass) break;
 3d3:	a1 6c 12 00 00       	mov    0x126c,%eax
 3d8:	39 05 58 12 00 00    	cmp    %eax,0x1258
 3de:	76 a8                	jbe    388 <frisbee_task+0x28>
  }

  return 0;
}
 3e0:	83 c4 3c             	add    $0x3c,%esp
 3e3:	31 c0                	xor    %eax,%eax
 3e5:	5b                   	pop    %ebx
 3e6:	5e                   	pop    %esi
 3e7:	5f                   	pop    %edi
 3e8:	5d                   	pop    %ebp
 3e9:	c3                   	ret    
 3ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cur_owner++;
 3f0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      if(cur_owner == numthreads) cur_owner = 0;
 3f3:	3b 15 70 12 00 00    	cmp    0x1270,%edx
      cur_owner++;
 3f9:	89 15 5c 12 00 00    	mov    %edx,0x125c
 3ff:	89 d1                	mov    %edx,%ecx
      if(cur_owner == numthreads) cur_owner = 0;
 401:	74 29                	je     42c <frisbee_task+0xcc>
      printf(1, "Pass number: %d, Thread %d is passing the token to thread %d\n", passes, tid, cur_owner);
 403:	89 4c 24 10          	mov    %ecx,0x10(%esp)
 407:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
 40b:	89 44 24 08          	mov    %eax,0x8(%esp)
 40f:	c7 44 24 04 9c 0c 00 	movl   $0xc9c,0x4(%esp)
 416:	00 
 417:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 41e:	e8 dd 04 00 00       	call   900 <printf>
      passes++;
 423:	83 05 58 12 00 00 01 	addl   $0x1,0x1258
 42a:	eb 98                	jmp    3c4 <frisbee_task+0x64>
      if(cur_owner == numthreads) cur_owner = 0;
 42c:	c7 05 5c 12 00 00 00 	movl   $0x0,0x125c
 433:	00 00 00 
 436:	31 c9                	xor    %ecx,%ecx
 438:	eb c9                	jmp    403 <frisbee_task+0xa3>
      mcslock_release(args->lock, &qnode);
 43a:	89 7c 24 04          	mov    %edi,0x4(%esp)
 43e:	8b 46 04             	mov    0x4(%esi),%eax
 441:	89 04 24             	mov    %eax,(%esp)
 444:	e8 b7 fe ff ff       	call   300 <mcslock_release>
}
 449:	83 c4 3c             	add    $0x3c,%esp
 44c:	31 c0                	xor    %eax,%eax
 44e:	5b                   	pop    %ebx
 44f:	5e                   	pop    %esi
 450:	5f                   	pop    %edi
 451:	5d                   	pop    %ebp
 452:	c3                   	ret    
 453:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000460 <arraylock_init>:

void arraylock_init(struct arraylock_t *lk, uint size)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	56                   	push   %esi
 464:	53                   	push   %ebx
 465:	83 ec 10             	sub    $0x10,%esp
 468:	8b 75 0c             	mov    0xc(%ebp),%esi
 46b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  lk->size = size;
  lk->lock = (uint*) malloc(lk->size * sizeof(uint));
 46e:	8d 04 b5 00 00 00 00 	lea    0x0(,%esi,4),%eax
  lk->size = size;
 475:	89 73 0c             	mov    %esi,0xc(%ebx)
  lk->lock = (uint*) malloc(lk->size * sizeof(uint));
 478:	89 04 24             	mov    %eax,(%esp)
 47b:	e8 00 07 00 00       	call   b80 <malloc>

  int i;
  for(i = 1; i < size; i++) lk->lock[i] = 0;
 480:	83 fe 01             	cmp    $0x1,%esi
  lk->lock = (uint*) malloc(lk->size * sizeof(uint));
 483:	89 03                	mov    %eax,(%ebx)
  for(i = 1; i < size; i++) lk->lock[i] = 0;
 485:	76 25                	jbe    4ac <arraylock_init+0x4c>
 487:	b9 01 00 00 00       	mov    $0x1,%ecx
 48c:	ba 01 00 00 00       	mov    $0x1,%edx
 491:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 498:	83 c2 01             	add    $0x1,%edx
 49b:	8d 04 88             	lea    (%eax,%ecx,4),%eax
 49e:	39 f2                	cmp    %esi,%edx
 4a0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
 4a6:	89 d1                	mov    %edx,%ecx
 4a8:	8b 03                	mov    (%ebx),%eax
 4aa:	75 ec                	jne    498 <arraylock_init+0x38>
  lk->lock[0] = 1;
 4ac:	c7 00 01 00 00 00    	movl   $0x1,(%eax)

  lk->next = 0;
 4b2:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  lk->m = 0;
 4b9:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
}
 4c0:	83 c4 10             	add    $0x10,%esp
 4c3:	5b                   	pop    %ebx
 4c4:	5e                   	pop    %esi
 4c5:	5d                   	pop    %ebp
 4c6:	c3                   	ret    
 4c7:	89 f6                	mov    %esi,%esi
 4c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004d0 <arraylock_acquire>:
void arraylock_acquire(struct arraylock_t *lk){
 4d0:	55                   	push   %ebp
 4d1:	b9 01 00 00 00       	mov    $0x1,%ecx
 4d6:	89 e5                	mov    %esp,%ebp
 4d8:	53                   	push   %ebx
 4d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
 4dc:	8d 53 10             	lea    0x10(%ebx),%edx
 4df:	90                   	nop
 4e0:	89 c8                	mov    %ecx,%eax
 4e2:	f0 87 02             	lock xchg %eax,(%edx)
  uint pos;
  // makeshift read-modify-write using xchg
  while (xchg(&lk->m, 1) != 0);
 4e5:	85 c0                	test   %eax,%eax
 4e7:	75 f7                	jne    4e0 <arraylock_acquire+0x10>
  pos = lk->next;
 4e9:	8b 4b 08             	mov    0x8(%ebx),%ecx
  lk->next = pos + 1;
 4ec:	8d 41 01             	lea    0x1(%ecx),%eax
  if(lk->next == lk->size) lk->next = 0;
 4ef:	3b 43 0c             	cmp    0xc(%ebx),%eax
  lk->next = pos + 1;
 4f2:	89 43 08             	mov    %eax,0x8(%ebx)
  if(lk->next == lk->size) lk->next = 0;
 4f5:	74 21                	je     518 <arraylock_acquire+0x48>
 4f7:	31 c0                	xor    %eax,%eax
 4f9:	f0 87 43 10          	lock xchg %eax,0x10(%ebx)
 4fd:	8b 03                	mov    (%ebx),%eax
 4ff:	8d 14 88             	lea    (%eax,%ecx,4),%edx
 502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  xchg(&lk->m, 0);

  while(lk->lock[pos] == 0);
 508:	8b 02                	mov    (%edx),%eax
 50a:	85 c0                	test   %eax,%eax
 50c:	74 fa                	je     508 <arraylock_acquire+0x38>
  lk->lockpos = pos;
 50e:	89 4b 04             	mov    %ecx,0x4(%ebx)
}
 511:	5b                   	pop    %ebx
 512:	5d                   	pop    %ebp
 513:	c3                   	ret    
 514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(lk->next == lk->size) lk->next = 0;
 518:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
 51f:	eb d6                	jmp    4f7 <arraylock_acquire+0x27>
 521:	eb 0d                	jmp    530 <arraylock_release>
 523:	90                   	nop
 524:	90                   	nop
 525:	90                   	nop
 526:	90                   	nop
 527:	90                   	nop
 528:	90                   	nop
 529:	90                   	nop
 52a:	90                   	nop
 52b:	90                   	nop
 52c:	90                   	nop
 52d:	90                   	nop
 52e:	90                   	nop
 52f:	90                   	nop

00000530 <arraylock_release>:

void arraylock_release(struct arraylock_t *lk){
 530:	55                   	push   %ebp
 531:	31 c0                	xor    %eax,%eax
 533:	89 e5                	mov    %esp,%ebp
 535:	8b 55 08             	mov    0x8(%ebp),%edx
 538:	56                   	push   %esi
 539:	53                   	push   %ebx
  uint nextpos = lk->lockpos + 1;
 53a:	8b 4a 04             	mov    0x4(%edx),%ecx
 53d:	8d 59 01             	lea    0x1(%ecx),%ebx
 540:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
 547:	39 5a 0c             	cmp    %ebx,0xc(%edx)
  if(nextpos == lk->size) nextpos = 0;

  lk->lock[lk->lockpos] = 0; // Clear own ticket
 54a:	8b 1a                	mov    (%edx),%ebx
 54c:	0f 45 c6             	cmovne %esi,%eax
 54f:	8d 0c 8b             	lea    (%ebx,%ecx,4),%ecx
 552:	c7 01 00 00 00 00    	movl   $0x0,(%ecx)
  lk->lock[nextpos] = 1; // Set next ticket
 558:	03 02                	add    (%edx),%eax
 55a:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
}
 560:	5b                   	pop    %ebx
 561:	5e                   	pop    %esi
 562:	5d                   	pop    %ebp
 563:	c3                   	ret    
 564:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 56a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000570 <arraylock_destroy>:

void arraylock_destroy(struct arraylock_t *lk){
 570:	55                   	push   %ebp
 571:	89 e5                	mov    %esp,%ebp
  free((void *) lk->lock);
 573:	8b 45 08             	mov    0x8(%ebp),%eax
 576:	8b 00                	mov    (%eax),%eax
 578:	89 45 08             	mov    %eax,0x8(%ebp)
}
 57b:	5d                   	pop    %ebp
  free((void *) lk->lock);
 57c:	e9 6f 05 00 00       	jmp    af0 <free>
 581:	66 90                	xchg   %ax,%ax
 583:	66 90                	xchg   %ax,%ax
 585:	66 90                	xchg   %ax,%ax
 587:	66 90                	xchg   %ax,%ax
 589:	66 90                	xchg   %ax,%ax
 58b:	66 90                	xchg   %ax,%ax
 58d:	66 90                	xchg   %ax,%ax
 58f:	90                   	nop

00000590 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 590:	55                   	push   %ebp
 591:	89 e5                	mov    %esp,%ebp
 593:	8b 45 08             	mov    0x8(%ebp),%eax
 596:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 599:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 59a:	89 c2                	mov    %eax,%edx
 59c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5a0:	83 c1 01             	add    $0x1,%ecx
 5a3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 5a7:	83 c2 01             	add    $0x1,%edx
 5aa:	84 db                	test   %bl,%bl
 5ac:	88 5a ff             	mov    %bl,-0x1(%edx)
 5af:	75 ef                	jne    5a0 <strcpy+0x10>
    ;
  return os;
}
 5b1:	5b                   	pop    %ebx
 5b2:	5d                   	pop    %ebp
 5b3:	c3                   	ret    
 5b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000005c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 5c0:	55                   	push   %ebp
 5c1:	89 e5                	mov    %esp,%ebp
 5c3:	8b 55 08             	mov    0x8(%ebp),%edx
 5c6:	53                   	push   %ebx
 5c7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 5ca:	0f b6 02             	movzbl (%edx),%eax
 5cd:	84 c0                	test   %al,%al
 5cf:	74 2d                	je     5fe <strcmp+0x3e>
 5d1:	0f b6 19             	movzbl (%ecx),%ebx
 5d4:	38 d8                	cmp    %bl,%al
 5d6:	74 0e                	je     5e6 <strcmp+0x26>
 5d8:	eb 2b                	jmp    605 <strcmp+0x45>
 5da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5e0:	38 c8                	cmp    %cl,%al
 5e2:	75 15                	jne    5f9 <strcmp+0x39>
    p++, q++;
 5e4:	89 d9                	mov    %ebx,%ecx
 5e6:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 5e9:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 5ec:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 5ef:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 5f3:	84 c0                	test   %al,%al
 5f5:	75 e9                	jne    5e0 <strcmp+0x20>
 5f7:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 5f9:	29 c8                	sub    %ecx,%eax
}
 5fb:	5b                   	pop    %ebx
 5fc:	5d                   	pop    %ebp
 5fd:	c3                   	ret    
 5fe:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
 601:	31 c0                	xor    %eax,%eax
 603:	eb f4                	jmp    5f9 <strcmp+0x39>
 605:	0f b6 cb             	movzbl %bl,%ecx
 608:	eb ef                	jmp    5f9 <strcmp+0x39>
 60a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000610 <strlen>:

uint
strlen(const char *s)
{
 610:	55                   	push   %ebp
 611:	89 e5                	mov    %esp,%ebp
 613:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 616:	80 39 00             	cmpb   $0x0,(%ecx)
 619:	74 12                	je     62d <strlen+0x1d>
 61b:	31 d2                	xor    %edx,%edx
 61d:	8d 76 00             	lea    0x0(%esi),%esi
 620:	83 c2 01             	add    $0x1,%edx
 623:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 627:	89 d0                	mov    %edx,%eax
 629:	75 f5                	jne    620 <strlen+0x10>
    ;
  return n;
}
 62b:	5d                   	pop    %ebp
 62c:	c3                   	ret    
  for(n = 0; s[n]; n++)
 62d:	31 c0                	xor    %eax,%eax
}
 62f:	5d                   	pop    %ebp
 630:	c3                   	ret    
 631:	eb 0d                	jmp    640 <memset>
 633:	90                   	nop
 634:	90                   	nop
 635:	90                   	nop
 636:	90                   	nop
 637:	90                   	nop
 638:	90                   	nop
 639:	90                   	nop
 63a:	90                   	nop
 63b:	90                   	nop
 63c:	90                   	nop
 63d:	90                   	nop
 63e:	90                   	nop
 63f:	90                   	nop

00000640 <memset>:

void*
memset(void *dst, int c, uint n)
{
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	8b 55 08             	mov    0x8(%ebp),%edx
 646:	57                   	push   %edi
  asm volatile("cld; rep stosb" :
 647:	8b 4d 10             	mov    0x10(%ebp),%ecx
 64a:	8b 45 0c             	mov    0xc(%ebp),%eax
 64d:	89 d7                	mov    %edx,%edi
 64f:	fc                   	cld    
 650:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 652:	89 d0                	mov    %edx,%eax
 654:	5f                   	pop    %edi
 655:	5d                   	pop    %ebp
 656:	c3                   	ret    
 657:	89 f6                	mov    %esi,%esi
 659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000660 <strchr>:

char*
strchr(const char *s, char c)
{
 660:	55                   	push   %ebp
 661:	89 e5                	mov    %esp,%ebp
 663:	8b 45 08             	mov    0x8(%ebp),%eax
 666:	53                   	push   %ebx
 667:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 66a:	0f b6 18             	movzbl (%eax),%ebx
 66d:	84 db                	test   %bl,%bl
 66f:	74 1d                	je     68e <strchr+0x2e>
    if(*s == c)
 671:	38 d3                	cmp    %dl,%bl
 673:	89 d1                	mov    %edx,%ecx
 675:	75 0d                	jne    684 <strchr+0x24>
 677:	eb 17                	jmp    690 <strchr+0x30>
 679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 680:	38 ca                	cmp    %cl,%dl
 682:	74 0c                	je     690 <strchr+0x30>
  for(; *s; s++)
 684:	83 c0 01             	add    $0x1,%eax
 687:	0f b6 10             	movzbl (%eax),%edx
 68a:	84 d2                	test   %dl,%dl
 68c:	75 f2                	jne    680 <strchr+0x20>
      return (char*)s;
  return 0;
 68e:	31 c0                	xor    %eax,%eax
}
 690:	5b                   	pop    %ebx
 691:	5d                   	pop    %ebp
 692:	c3                   	ret    
 693:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006a0 <gets>:

char*
gets(char *buf, int max)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	57                   	push   %edi
 6a4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 6a5:	31 f6                	xor    %esi,%esi
{
 6a7:	53                   	push   %ebx
 6a8:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 6ab:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 6ae:	eb 31                	jmp    6e1 <gets+0x41>
    cc = read(0, &c, 1);
 6b0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6b7:	00 
 6b8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 6bc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 6c3:	e8 02 01 00 00       	call   7ca <read>
    if(cc < 1)
 6c8:	85 c0                	test   %eax,%eax
 6ca:	7e 1d                	jle    6e9 <gets+0x49>
      break;
    buf[i++] = c;
 6cc:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 6d0:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 6d2:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 6d5:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 6d7:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 6db:	74 0c                	je     6e9 <gets+0x49>
 6dd:	3c 0a                	cmp    $0xa,%al
 6df:	74 08                	je     6e9 <gets+0x49>
  for(i=0; i+1 < max; ){
 6e1:	8d 5e 01             	lea    0x1(%esi),%ebx
 6e4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 6e7:	7c c7                	jl     6b0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 6e9:	8b 45 08             	mov    0x8(%ebp),%eax
 6ec:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 6f0:	83 c4 2c             	add    $0x2c,%esp
 6f3:	5b                   	pop    %ebx
 6f4:	5e                   	pop    %esi
 6f5:	5f                   	pop    %edi
 6f6:	5d                   	pop    %ebp
 6f7:	c3                   	ret    
 6f8:	90                   	nop
 6f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000700 <stat>:

int
stat(const char *n, struct stat *st)
{
 700:	55                   	push   %ebp
 701:	89 e5                	mov    %esp,%ebp
 703:	56                   	push   %esi
 704:	53                   	push   %ebx
 705:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 708:	8b 45 08             	mov    0x8(%ebp),%eax
 70b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 712:	00 
 713:	89 04 24             	mov    %eax,(%esp)
 716:	e8 d7 00 00 00       	call   7f2 <open>
  if(fd < 0)
 71b:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 71d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 71f:	78 27                	js     748 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 721:	8b 45 0c             	mov    0xc(%ebp),%eax
 724:	89 1c 24             	mov    %ebx,(%esp)
 727:	89 44 24 04          	mov    %eax,0x4(%esp)
 72b:	e8 da 00 00 00       	call   80a <fstat>
  close(fd);
 730:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 733:	89 c6                	mov    %eax,%esi
  close(fd);
 735:	e8 a0 00 00 00       	call   7da <close>
  return r;
 73a:	89 f0                	mov    %esi,%eax
}
 73c:	83 c4 10             	add    $0x10,%esp
 73f:	5b                   	pop    %ebx
 740:	5e                   	pop    %esi
 741:	5d                   	pop    %ebp
 742:	c3                   	ret    
 743:	90                   	nop
 744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 748:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 74d:	eb ed                	jmp    73c <stat+0x3c>
 74f:	90                   	nop

00000750 <atoi>:

int
atoi(const char *s)
{
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	8b 4d 08             	mov    0x8(%ebp),%ecx
 756:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 757:	0f be 11             	movsbl (%ecx),%edx
 75a:	8d 42 d0             	lea    -0x30(%edx),%eax
 75d:	3c 09                	cmp    $0x9,%al
  n = 0;
 75f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 764:	77 17                	ja     77d <atoi+0x2d>
 766:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 768:	83 c1 01             	add    $0x1,%ecx
 76b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 76e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 772:	0f be 11             	movsbl (%ecx),%edx
 775:	8d 5a d0             	lea    -0x30(%edx),%ebx
 778:	80 fb 09             	cmp    $0x9,%bl
 77b:	76 eb                	jbe    768 <atoi+0x18>
  return n;
}
 77d:	5b                   	pop    %ebx
 77e:	5d                   	pop    %ebp
 77f:	c3                   	ret    

00000780 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 780:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 781:	31 d2                	xor    %edx,%edx
{
 783:	89 e5                	mov    %esp,%ebp
 785:	56                   	push   %esi
 786:	8b 45 08             	mov    0x8(%ebp),%eax
 789:	53                   	push   %ebx
 78a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 78d:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 790:	85 db                	test   %ebx,%ebx
 792:	7e 12                	jle    7a6 <memmove+0x26>
 794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 798:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 79c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 79f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 7a2:	39 da                	cmp    %ebx,%edx
 7a4:	75 f2                	jne    798 <memmove+0x18>
  return vdst;
}
 7a6:	5b                   	pop    %ebx
 7a7:	5e                   	pop    %esi
 7a8:	5d                   	pop    %ebp
 7a9:	c3                   	ret    

000007aa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 7aa:	b8 01 00 00 00       	mov    $0x1,%eax
 7af:	cd 40                	int    $0x40
 7b1:	c3                   	ret    

000007b2 <exit>:
SYSCALL(exit)
 7b2:	b8 02 00 00 00       	mov    $0x2,%eax
 7b7:	cd 40                	int    $0x40
 7b9:	c3                   	ret    

000007ba <wait>:
SYSCALL(wait)
 7ba:	b8 03 00 00 00       	mov    $0x3,%eax
 7bf:	cd 40                	int    $0x40
 7c1:	c3                   	ret    

000007c2 <pipe>:
SYSCALL(pipe)
 7c2:	b8 04 00 00 00       	mov    $0x4,%eax
 7c7:	cd 40                	int    $0x40
 7c9:	c3                   	ret    

000007ca <read>:
SYSCALL(read)
 7ca:	b8 05 00 00 00       	mov    $0x5,%eax
 7cf:	cd 40                	int    $0x40
 7d1:	c3                   	ret    

000007d2 <write>:
SYSCALL(write)
 7d2:	b8 10 00 00 00       	mov    $0x10,%eax
 7d7:	cd 40                	int    $0x40
 7d9:	c3                   	ret    

000007da <close>:
SYSCALL(close)
 7da:	b8 15 00 00 00       	mov    $0x15,%eax
 7df:	cd 40                	int    $0x40
 7e1:	c3                   	ret    

000007e2 <kill>:
SYSCALL(kill)
 7e2:	b8 06 00 00 00       	mov    $0x6,%eax
 7e7:	cd 40                	int    $0x40
 7e9:	c3                   	ret    

000007ea <exec>:
SYSCALL(exec)
 7ea:	b8 07 00 00 00       	mov    $0x7,%eax
 7ef:	cd 40                	int    $0x40
 7f1:	c3                   	ret    

000007f2 <open>:
SYSCALL(open)
 7f2:	b8 0f 00 00 00       	mov    $0xf,%eax
 7f7:	cd 40                	int    $0x40
 7f9:	c3                   	ret    

000007fa <mknod>:
SYSCALL(mknod)
 7fa:	b8 11 00 00 00       	mov    $0x11,%eax
 7ff:	cd 40                	int    $0x40
 801:	c3                   	ret    

00000802 <unlink>:
SYSCALL(unlink)
 802:	b8 12 00 00 00       	mov    $0x12,%eax
 807:	cd 40                	int    $0x40
 809:	c3                   	ret    

0000080a <fstat>:
SYSCALL(fstat)
 80a:	b8 08 00 00 00       	mov    $0x8,%eax
 80f:	cd 40                	int    $0x40
 811:	c3                   	ret    

00000812 <link>:
SYSCALL(link)
 812:	b8 13 00 00 00       	mov    $0x13,%eax
 817:	cd 40                	int    $0x40
 819:	c3                   	ret    

0000081a <mkdir>:
SYSCALL(mkdir)
 81a:	b8 14 00 00 00       	mov    $0x14,%eax
 81f:	cd 40                	int    $0x40
 821:	c3                   	ret    

00000822 <chdir>:
SYSCALL(chdir)
 822:	b8 09 00 00 00       	mov    $0x9,%eax
 827:	cd 40                	int    $0x40
 829:	c3                   	ret    

0000082a <dup>:
SYSCALL(dup)
 82a:	b8 0a 00 00 00       	mov    $0xa,%eax
 82f:	cd 40                	int    $0x40
 831:	c3                   	ret    

00000832 <getpid>:
SYSCALL(getpid)
 832:	b8 0b 00 00 00       	mov    $0xb,%eax
 837:	cd 40                	int    $0x40
 839:	c3                   	ret    

0000083a <sbrk>:
SYSCALL(sbrk)
 83a:	b8 0c 00 00 00       	mov    $0xc,%eax
 83f:	cd 40                	int    $0x40
 841:	c3                   	ret    

00000842 <sleep>:
SYSCALL(sleep)
 842:	b8 0d 00 00 00       	mov    $0xd,%eax
 847:	cd 40                	int    $0x40
 849:	c3                   	ret    

0000084a <uptime>:
SYSCALL(uptime)
 84a:	b8 0e 00 00 00       	mov    $0xe,%eax
 84f:	cd 40                	int    $0x40
 851:	c3                   	ret    

00000852 <clone>:
SYSCALL(clone)
 852:	b8 16 00 00 00       	mov    $0x16,%eax
 857:	cd 40                	int    $0x40
 859:	c3                   	ret    
 85a:	66 90                	xchg   %ax,%ax
 85c:	66 90                	xchg   %ax,%ax
 85e:	66 90                	xchg   %ax,%ax

00000860 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 860:	55                   	push   %ebp
 861:	89 e5                	mov    %esp,%ebp
 863:	57                   	push   %edi
 864:	56                   	push   %esi
 865:	89 c6                	mov    %eax,%esi
 867:	53                   	push   %ebx
 868:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 86b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 86e:	85 db                	test   %ebx,%ebx
 870:	74 09                	je     87b <printint+0x1b>
 872:	89 d0                	mov    %edx,%eax
 874:	c1 e8 1f             	shr    $0x1f,%eax
 877:	84 c0                	test   %al,%al
 879:	75 75                	jne    8f0 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 87b:	89 d0                	mov    %edx,%eax
  neg = 0;
 87d:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 884:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 887:	31 ff                	xor    %edi,%edi
 889:	89 ce                	mov    %ecx,%esi
 88b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 88e:	eb 02                	jmp    892 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 890:	89 cf                	mov    %ecx,%edi
 892:	31 d2                	xor    %edx,%edx
 894:	f7 f6                	div    %esi
 896:	8d 4f 01             	lea    0x1(%edi),%ecx
 899:	0f b6 92 73 0d 00 00 	movzbl 0xd73(%edx),%edx
  }while((x /= base) != 0);
 8a0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 8a2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 8a5:	75 e9                	jne    890 <printint+0x30>
  if(neg)
 8a7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 8aa:	89 c8                	mov    %ecx,%eax
 8ac:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 8af:	85 d2                	test   %edx,%edx
 8b1:	74 08                	je     8bb <printint+0x5b>
    buf[i++] = '-';
 8b3:	8d 4f 02             	lea    0x2(%edi),%ecx
 8b6:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 8bb:	8d 79 ff             	lea    -0x1(%ecx),%edi
 8be:	66 90                	xchg   %ax,%ax
 8c0:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 8c5:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 8c8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 8cf:	00 
 8d0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 8d4:	89 34 24             	mov    %esi,(%esp)
 8d7:	88 45 d7             	mov    %al,-0x29(%ebp)
 8da:	e8 f3 fe ff ff       	call   7d2 <write>
  while(--i >= 0)
 8df:	83 ff ff             	cmp    $0xffffffff,%edi
 8e2:	75 dc                	jne    8c0 <printint+0x60>
    putc(fd, buf[i]);
}
 8e4:	83 c4 4c             	add    $0x4c,%esp
 8e7:	5b                   	pop    %ebx
 8e8:	5e                   	pop    %esi
 8e9:	5f                   	pop    %edi
 8ea:	5d                   	pop    %ebp
 8eb:	c3                   	ret    
 8ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 8f0:	89 d0                	mov    %edx,%eax
 8f2:	f7 d8                	neg    %eax
    neg = 1;
 8f4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 8fb:	eb 87                	jmp    884 <printint+0x24>
 8fd:	8d 76 00             	lea    0x0(%esi),%esi

00000900 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 900:	55                   	push   %ebp
 901:	89 e5                	mov    %esp,%ebp
 903:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 904:	31 ff                	xor    %edi,%edi
{
 906:	56                   	push   %esi
 907:	53                   	push   %ebx
 908:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 90b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 90e:	8d 45 10             	lea    0x10(%ebp),%eax
{
 911:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 914:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 917:	0f b6 13             	movzbl (%ebx),%edx
 91a:	83 c3 01             	add    $0x1,%ebx
 91d:	84 d2                	test   %dl,%dl
 91f:	75 39                	jne    95a <printf+0x5a>
 921:	e9 c2 00 00 00       	jmp    9e8 <printf+0xe8>
 926:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 928:	83 fa 25             	cmp    $0x25,%edx
 92b:	0f 84 bf 00 00 00    	je     9f0 <printf+0xf0>
  write(fd, &c, 1);
 931:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 934:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 93b:	00 
 93c:	89 44 24 04          	mov    %eax,0x4(%esp)
 940:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 943:	88 55 e2             	mov    %dl,-0x1e(%ebp)
  write(fd, &c, 1);
 946:	e8 87 fe ff ff       	call   7d2 <write>
 94b:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 94e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 952:	84 d2                	test   %dl,%dl
 954:	0f 84 8e 00 00 00    	je     9e8 <printf+0xe8>
    if(state == 0){
 95a:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 95c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 95f:	74 c7                	je     928 <printf+0x28>
      }
    } else if(state == '%'){
 961:	83 ff 25             	cmp    $0x25,%edi
 964:	75 e5                	jne    94b <printf+0x4b>
      if(c == 'd'){
 966:	83 fa 64             	cmp    $0x64,%edx
 969:	0f 84 31 01 00 00    	je     aa0 <printf+0x1a0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 96f:	25 f7 00 00 00       	and    $0xf7,%eax
 974:	83 f8 70             	cmp    $0x70,%eax
 977:	0f 84 83 00 00 00    	je     a00 <printf+0x100>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 97d:	83 fa 73             	cmp    $0x73,%edx
 980:	0f 84 a2 00 00 00    	je     a28 <printf+0x128>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 986:	83 fa 63             	cmp    $0x63,%edx
 989:	0f 84 35 01 00 00    	je     ac4 <printf+0x1c4>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 98f:	83 fa 25             	cmp    $0x25,%edx
 992:	0f 84 e0 00 00 00    	je     a78 <printf+0x178>
  write(fd, &c, 1);
 998:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 99b:	83 c3 01             	add    $0x1,%ebx
 99e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 9a5:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 9a6:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 9a8:	89 44 24 04          	mov    %eax,0x4(%esp)
 9ac:	89 34 24             	mov    %esi,(%esp)
 9af:	89 55 d0             	mov    %edx,-0x30(%ebp)
 9b2:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 9b6:	e8 17 fe ff ff       	call   7d2 <write>
        putc(fd, c);
 9bb:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 9be:	8d 45 e7             	lea    -0x19(%ebp),%eax
 9c1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 9c8:	00 
 9c9:	89 44 24 04          	mov    %eax,0x4(%esp)
 9cd:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 9d0:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 9d3:	e8 fa fd ff ff       	call   7d2 <write>
  for(i = 0; fmt[i]; i++){
 9d8:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 9dc:	84 d2                	test   %dl,%dl
 9de:	0f 85 76 ff ff ff    	jne    95a <printf+0x5a>
 9e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }
}
 9e8:	83 c4 3c             	add    $0x3c,%esp
 9eb:	5b                   	pop    %ebx
 9ec:	5e                   	pop    %esi
 9ed:	5f                   	pop    %edi
 9ee:	5d                   	pop    %ebp
 9ef:	c3                   	ret    
        state = '%';
 9f0:	bf 25 00 00 00       	mov    $0x25,%edi
 9f5:	e9 51 ff ff ff       	jmp    94b <printf+0x4b>
 9fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 a00:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 a03:	b9 10 00 00 00       	mov    $0x10,%ecx
      state = 0;
 a08:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 a0a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 a11:	8b 10                	mov    (%eax),%edx
 a13:	89 f0                	mov    %esi,%eax
 a15:	e8 46 fe ff ff       	call   860 <printint>
        ap++;
 a1a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 a1e:	e9 28 ff ff ff       	jmp    94b <printf+0x4b>
 a23:	90                   	nop
 a24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 a28:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 a2b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 a2f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 a31:	b8 6c 0d 00 00       	mov    $0xd6c,%eax
 a36:	85 ff                	test   %edi,%edi
 a38:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 a3b:	0f b6 07             	movzbl (%edi),%eax
 a3e:	84 c0                	test   %al,%al
 a40:	74 2a                	je     a6c <printf+0x16c>
 a42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 a48:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 a4b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 a4e:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 a51:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 a58:	00 
 a59:	89 44 24 04          	mov    %eax,0x4(%esp)
 a5d:	89 34 24             	mov    %esi,(%esp)
 a60:	e8 6d fd ff ff       	call   7d2 <write>
        while(*s != 0){
 a65:	0f b6 07             	movzbl (%edi),%eax
 a68:	84 c0                	test   %al,%al
 a6a:	75 dc                	jne    a48 <printf+0x148>
      state = 0;
 a6c:	31 ff                	xor    %edi,%edi
 a6e:	e9 d8 fe ff ff       	jmp    94b <printf+0x4b>
 a73:	90                   	nop
 a74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 a78:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 a7b:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 a7d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 a84:	00 
 a85:	89 44 24 04          	mov    %eax,0x4(%esp)
 a89:	89 34 24             	mov    %esi,(%esp)
 a8c:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 a90:	e8 3d fd ff ff       	call   7d2 <write>
 a95:	e9 b1 fe ff ff       	jmp    94b <printf+0x4b>
 a9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 aa0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 aa3:	b9 0a 00 00 00       	mov    $0xa,%ecx
      state = 0;
 aa8:	66 31 ff             	xor    %di,%di
        printint(fd, *ap, 10, 1);
 aab:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 ab2:	8b 10                	mov    (%eax),%edx
 ab4:	89 f0                	mov    %esi,%eax
 ab6:	e8 a5 fd ff ff       	call   860 <printint>
        ap++;
 abb:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 abf:	e9 87 fe ff ff       	jmp    94b <printf+0x4b>
        putc(fd, *ap);
 ac4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 ac7:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 ac9:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 acb:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 ad2:	00 
 ad3:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 ad6:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 ad9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 adc:	89 44 24 04          	mov    %eax,0x4(%esp)
 ae0:	e8 ed fc ff ff       	call   7d2 <write>
        ap++;
 ae5:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 ae9:	e9 5d fe ff ff       	jmp    94b <printf+0x4b>
 aee:	66 90                	xchg   %ax,%ax

00000af0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 af0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 af1:	a1 60 12 00 00       	mov    0x1260,%eax
{
 af6:	89 e5                	mov    %esp,%ebp
 af8:	57                   	push   %edi
 af9:	56                   	push   %esi
 afa:	53                   	push   %ebx
 afb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 afe:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 b00:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b03:	39 d0                	cmp    %edx,%eax
 b05:	72 11                	jb     b18 <free+0x28>
 b07:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b08:	39 c8                	cmp    %ecx,%eax
 b0a:	72 04                	jb     b10 <free+0x20>
 b0c:	39 ca                	cmp    %ecx,%edx
 b0e:	72 10                	jb     b20 <free+0x30>
 b10:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b12:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b14:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b16:	73 f0                	jae    b08 <free+0x18>
 b18:	39 ca                	cmp    %ecx,%edx
 b1a:	72 04                	jb     b20 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b1c:	39 c8                	cmp    %ecx,%eax
 b1e:	72 f0                	jb     b10 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b20:	8b 73 fc             	mov    -0x4(%ebx),%esi
 b23:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 b26:	39 cf                	cmp    %ecx,%edi
 b28:	74 1e                	je     b48 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 b2a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 b2d:	8b 48 04             	mov    0x4(%eax),%ecx
 b30:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 b33:	39 f2                	cmp    %esi,%edx
 b35:	74 28                	je     b5f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 b37:	89 10                	mov    %edx,(%eax)
  freep = p;
 b39:	a3 60 12 00 00       	mov    %eax,0x1260
}
 b3e:	5b                   	pop    %ebx
 b3f:	5e                   	pop    %esi
 b40:	5f                   	pop    %edi
 b41:	5d                   	pop    %ebp
 b42:	c3                   	ret    
 b43:	90                   	nop
 b44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 b48:	03 71 04             	add    0x4(%ecx),%esi
 b4b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 b4e:	8b 08                	mov    (%eax),%ecx
 b50:	8b 09                	mov    (%ecx),%ecx
 b52:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 b55:	8b 48 04             	mov    0x4(%eax),%ecx
 b58:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 b5b:	39 f2                	cmp    %esi,%edx
 b5d:	75 d8                	jne    b37 <free+0x47>
    p->s.size += bp->s.size;
 b5f:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 b62:	a3 60 12 00 00       	mov    %eax,0x1260
    p->s.size += bp->s.size;
 b67:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 b6a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 b6d:	89 10                	mov    %edx,(%eax)
}
 b6f:	5b                   	pop    %ebx
 b70:	5e                   	pop    %esi
 b71:	5f                   	pop    %edi
 b72:	5d                   	pop    %ebp
 b73:	c3                   	ret    
 b74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 b7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000b80 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b80:	55                   	push   %ebp
 b81:	89 e5                	mov    %esp,%ebp
 b83:	57                   	push   %edi
 b84:	56                   	push   %esi
 b85:	53                   	push   %ebx
 b86:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b89:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 b8c:	8b 1d 60 12 00 00    	mov    0x1260,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b92:	8d 48 07             	lea    0x7(%eax),%ecx
 b95:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 b98:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b9a:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 b9d:	0f 84 9b 00 00 00    	je     c3e <malloc+0xbe>
 ba3:	8b 13                	mov    (%ebx),%edx
 ba5:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 ba8:	39 fe                	cmp    %edi,%esi
 baa:	76 64                	jbe    c10 <malloc+0x90>
 bac:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 bb3:	bb 00 80 00 00       	mov    $0x8000,%ebx
 bb8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 bbb:	eb 0e                	jmp    bcb <malloc+0x4b>
 bbd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bc0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 bc2:	8b 78 04             	mov    0x4(%eax),%edi
 bc5:	39 fe                	cmp    %edi,%esi
 bc7:	76 4f                	jbe    c18 <malloc+0x98>
 bc9:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 bcb:	3b 15 60 12 00 00    	cmp    0x1260,%edx
 bd1:	75 ed                	jne    bc0 <malloc+0x40>
  if(nu < 4096)
 bd3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 bd6:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 bdc:	bf 00 10 00 00       	mov    $0x1000,%edi
 be1:	0f 43 fe             	cmovae %esi,%edi
 be4:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 be7:	89 04 24             	mov    %eax,(%esp)
 bea:	e8 4b fc ff ff       	call   83a <sbrk>
  if(p == (char*)-1)
 bef:	83 f8 ff             	cmp    $0xffffffff,%eax
 bf2:	74 18                	je     c0c <malloc+0x8c>
  hp->s.size = nu;
 bf4:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 bf7:	83 c0 08             	add    $0x8,%eax
 bfa:	89 04 24             	mov    %eax,(%esp)
 bfd:	e8 ee fe ff ff       	call   af0 <free>
  return freep;
 c02:	8b 15 60 12 00 00    	mov    0x1260,%edx
      if((p = morecore(nunits)) == 0)
 c08:	85 d2                	test   %edx,%edx
 c0a:	75 b4                	jne    bc0 <malloc+0x40>
        return 0;
 c0c:	31 c0                	xor    %eax,%eax
 c0e:	eb 20                	jmp    c30 <malloc+0xb0>
    if(p->s.size >= nunits){
 c10:	89 d0                	mov    %edx,%eax
 c12:	89 da                	mov    %ebx,%edx
 c14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 c18:	39 fe                	cmp    %edi,%esi
 c1a:	74 1c                	je     c38 <malloc+0xb8>
        p->s.size -= nunits;
 c1c:	29 f7                	sub    %esi,%edi
 c1e:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 c21:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 c24:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 c27:	89 15 60 12 00 00    	mov    %edx,0x1260
      return (void*)(p + 1);
 c2d:	83 c0 08             	add    $0x8,%eax
  }
}
 c30:	83 c4 1c             	add    $0x1c,%esp
 c33:	5b                   	pop    %ebx
 c34:	5e                   	pop    %esi
 c35:	5f                   	pop    %edi
 c36:	5d                   	pop    %ebp
 c37:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 c38:	8b 08                	mov    (%eax),%ecx
 c3a:	89 0a                	mov    %ecx,(%edx)
 c3c:	eb e9                	jmp    c27 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 c3e:	c7 05 60 12 00 00 64 	movl   $0x1264,0x1260
 c45:	12 00 00 
    base.s.size = 0;
 c48:	ba 64 12 00 00       	mov    $0x1264,%edx
    base.s.ptr = freep = prevp = &base;
 c4d:	c7 05 64 12 00 00 64 	movl   $0x1264,0x1264
 c54:	12 00 00 
    base.s.size = 0;
 c57:	c7 05 68 12 00 00 00 	movl   $0x0,0x1268
 c5e:	00 00 00 
 c61:	e9 46 ff ff ff       	jmp    bac <malloc+0x2c>
