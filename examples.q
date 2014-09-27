/ Event study
n1:3050
n2:1000
horizon:20
event:([]sym:n1#`ts; time:09:30:00 + sums (1 + n1 ? 100); code: n1 ? 2) 
prices:([]sym:n2#`ts; time:09:30:00 + sums (1 + n2 ? 100); mid: 100 + n2 ? 20)
f:`time         / common field
w:(2,(count event.time))#(event.time,event.time + horizon)
res:wj[w;f;event;(price;(::;`mid))]
chg: last each res.mid - first each res.mid
avg chg

/ Generate random variables from a provided distribution
pi:acos -1 
normrnd:{$[x=2*n:x div 2;raze sqrt[-2*log n?1f]*/:(sin;cos)@\:(2*pi)*n?1f;-1_.z.s 1+x]}

/ Genetic Optimiser Algorithm
nextGen:{[pop; obFn]     
    /get parameters
    popSize: count pop;
    /sort population and cull
    surv:select from pop where fitness > percentile[fitness;50];            
    /generate the next population
    tmp_fit: ();
    tmp_gene: ();        
    do[popSize;
        /select a random gene
        mom:select from surv where i in 1 ? count surv;
        dad:select from surv where i in 1 ? count surv;
        /average the genes
        kid:((raze flip key dad) + raze flip key mom)%2;
        /mutate the genes
        kid: kid + (-0.5f + (count kid) ? 1f);
        /append results to list     
        tmp_fit: (tmp_fit, obFn[kid]);        
        tmp_gene: (tmp_gene, kid);
    ];
    /return the new population    
    ([chromosome: tmp_gene] fitness: tmp_fit)       
}

/Genetic algorithm
chroSize:2
popSize:5
numIter:100
obFn:{[chro] sum each chro}
/Generate initial population table
chromosome: (popSize,chroSize) # (popSize*chroSize) ? 2
initPop: ([chromosome] fitness:obFn[chromosome])
/iterate generations
pop:initPop
do[numIter;pop:nextGen[pop;obFn];]
pop

/ K-nearest neighbour algorithm
K:3
N:50   / number of data points (vectors) in the sample
M:3    / dimension of each vector
data: ([idx:til N; y: (N*1)?100] x:(N,M)#(N*M)?100)   /must be in this format!
norm:{[x;y] (sum (raze x-raze y) xexp 2) xexp 0.5}  
query: 0 0 0
/ we can partially specify the arguments to a function
res:asc norm[query; ] each data 
a:(raze avg (key res)[til K])[1] / calculate the forecast mean