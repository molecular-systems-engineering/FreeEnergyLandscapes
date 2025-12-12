Bonomi et al. introduce a simple, general reweighting scheme for WTMetaD
that recovers unbiased Boltzmann statistics of any observable---starting
from the same key identity defining $P(\mathbf r,t)$ (Eq.
[eq:metad_sampled_prob](#eq:metad_sampled_prob)), the definition of
$c(t)$ (Eq. [eq:coft](#eq:coft)) and the long-time limit of the bias
constructed with WTmetaD:
$V(\xi,t\to\infty)=-\Delta T/(\Delta T+T) F(\xi)$, Bonomi et al. develop
a reweighting approach that circumvents the need of computing $c(t)$. By
differentiating Eq. [eq:metad_sampled_prob](#eq:metad_sampled_prob) for
small time intervals $\Delta t$, an evolution equation that eliminates
$c(t)$ is derived:
$$p(\mathbf r,t+\Delta t)=e^{-\beta [\dot V(\xi(\mathbf r),t)-\langle \dot V(\xi,t)\rangle]\Delta t} p(\mathbf r,t)
\label{eq:propagator}$$ where $\dot c(t)=-\langle \dot V(\xi,t)\rangle$
and the average is over the biased distribution at time $t$. For WTMetaD
with Gaussian depositions, these results lead to a practical reweighting
algorithm based on three steps. (i) Accumulate a joint histogram
$N_t(\xi,f)$ for a target variable $f(\mathbf r)$ between Gaussian
updates; (ii) at each update, compute $\dot V$ and $\dot c$ using the
current accumulated histogram, and evolve $N_t$ using Eq.
[eq:propagator](#eq:propagator); (iii) reconstruct the unbiased
distribution of $f(\mathbf{r})$ as
$$p(f)=\frac{\sum_{\xi} e^{+\beta V(\xi,t)} N_t(\xi,f)}{\sum_{\xi,f} e^{+\beta V(\xi,t)} N_t(\xi,f)}.$$
The method is lightweight as it does not require any a posteriori
calculation of the total energy, it works in post-processing or (in
principle) on-the-fly, and it converges efficiently as shown in Refs.
[@gimondi2018building; @Marinova2019].

# References
