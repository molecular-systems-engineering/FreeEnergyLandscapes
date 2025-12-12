## Reaction Paths on the Free Energy Landscapes and Reaction Kinetics

### String-based and minimum-action path optimization

While FESs capture the thermodynamic stability of molecular states, they
also provide the natural framework for investigating reaction paths and
associated kinetics. Before the emergence of trajectory-based sampling
approaches such as Transition Path Sampling, a family of algorithms had
been developed to compute representative transition pathways by
minimizing an effective energy or action functional, the nudged elastic
band (NEB) method, introduced by Jónsson and co-workers
[@jonsson1998nudged] and later refined [@henkelman2000improved],
determines minimum-energy paths on potential-energy surfaces by relaxing
a discretized chain of replicas connecting two metastable basins until
the perpendicular component of the force vanishes. NEB is a remarkably
effective algorithm that is still one of the workhorses in the
exploration of reactive pathways. Extensions and adaptations of these
ideas include, for example, the "nebterpolation" method
[@wang2016automated], which automates the identification and refinement
of reaction paths from molecular-dynamics trajectories, the generalized
solid-state nudged elastic band, which allows studying reaction pathways
of solid--solid transformations, and the recent NEB-TS for improved
convergence in the search of reactive paths [@asgeirsson2021nudged]. In
contrast to trajectory-sampling approaches, such as Transition Path
Sampling, which define the transition state probabilistically through
ensembles of reactive trajectories, NEB-type methods locate it
energetically as the saddle point along a typically minimum-energy path.

Extending the NEB concept to finite temperatures and taking into account
entropic effects, Ren and Vanden-Eijnden developed the string (or tube)
method, in which a continuous curve evolves under the projected mean
force until it converges to the minimum free-energy path connecting the
metastable regions
[@weinan2002string; @weinan2005finite; @ren2007simplified]. These
geometric approaches offer an intuitive representation of transitions on
complex free-energy surfaces, inspiring numerous subsequent algorithms
for exploring reactive pathways.

Another similar class of approaches is based on the Onsager-Machlup
action [@onsager1953fluctuations; @adib2008stochastic], which, when
extremized, provides the most probable path connecting two states in the
canonical ensemble, assuming that the overdamped Langevin equation
governs the underlying dynamics. Building on these variational
principles and switching from a time-dependent formulation to an energy
one via the Hamilton-Jacobi formulation of mechanics, Faccioli and
coworkers formulated the Dominant Reaction Pathway (DRP) method
[@elber2000temperature; @faccioli2006dominant; @sega2007quantitative; @autieri2009dominant].
The action to be minimized takes the form.
$$S_{HJ}(\mathbf{x}_0,\mathbf{x}_1) = \int_{s_0}^{s_1} ds \sqrt{2E_\mathrm{eff} + D^2 \left( \frac{1}{kT} \frac{\partial U(\mathbf{x}(s))}{\partial \mathbf x} \right)^2 
- \frac{2D^2}{kT} \frac{\partial^2 U(\mathbf{x}(s))}{\partial \mathbf x^2} },$$
Where $D$ is the diffusion coefficient, $E_\mathrm{eff}$ selects the
transition time, and the Laplacian term modulates the local entropic
contribution. This method has recently been recast in a form suitable
for quantum computing, by mapping the search for dominant paths onto an
Ising optimization problem solvable via quantum annealing
[@hauke2021dominant].

In systems characterized by rare transitions between metastable basins,
dynamics can be viewed as sequences of transitions through the narrow
regions of configuration space that connect these basins. Quantifying
these transition events requires linking the static information encoded
in $F(\xi)$ to the probability and rate of barrier crossings. This
connection underlies transition-state theory (TST) and its descendants,
which are based on the transition path ensemble.

### The Bennett-Chandler algorithm

In equilibrium systems, the rate constant for transitions from a basin
$A$ to another $B$ can be expressed as a time correlation function,
known as the Bennett--Chandler (BC) relation:
$$k_{AB} = \frac{\langle \dot{\xi}(0)  \delta[\xi(0)-\xi^\ddagger]  h_B[\xi(t)]\rangle}
{\langle h_A \rangle},$$ where $\xi(x)$ is a reaction coordinate,
$\dot\xi$ its time derivative, $\xi^\ddagger$ defines a dividing
surface, and $h_A$, and $h_B$ are characteristic functions identifying
configurations within $A$ and $B$. In the short--time limit $t\to{}0^+$,
where no recrossings occur, this reduces to the transition--state theory
(TST) rate: $$k_\mathrm{TST} =
\frac{\langle \dot{\xi}(0) \theta[\dot{\xi}(0)] \delta[\xi(0)-\xi^\ddagger]\rangle}
{\langle h_A\rangle}.$$ The ratio $\kappa = k_{AB} / k_\mathrm{TST}$
defines the transmission coefficient discussed in
Sec.[sec:kinetics](#sec:kinetics), which quantifies dynamical
recrossings of the dividing surface and measures the deviation from
ideal TST behavior.

Because both expressions depend on averages over configurations near the
transition state $(\xi^\ddagger$), efficient evaluation typically
requires enhanced sampling. This can be achieved, for example, with US
along the coordinate $\xi$, or equivalently by constraining
$\xi=\xi^\ddagger$ and computing averages in the Blue Moon ensemble.
Both techniques concentrate sampling around the dividing surface where
the reactive flux originates.

When barrier crossings are highly diffusive, frequent recrossings make
$\kappa \ll 1$, but the relative statistical error scales as
$\Delta \kappa / \kappa \sim  1/ (\kappa\sqrt{n}),$ With the number of
trajectories $n$, the number of simulations required for convergence
becomes prohibitive. Some methods, such as the Ruiz-Montero-Frenkel-Brey
[@ruiz-montero_efficient_1997] approach, improve the convergence of the
Bennett-Chandler method, but are still limited by the necessity to know
the location of the transition state and by the assumption that only one
state is relevant for the rate calculation. This is not true for more
complex landscapes, as noted by Vanden-Eijnden
[@vanden2006transition; @vanden2010transition], where one must sample
the bundle of transition paths.

### Transition Path Sampling[]{#sec:tps label="sec:tps"}

For a Markovian dynamics, the probability density of a trajectory
$\{\mathbf{r}\}=(\mathbf{r}_0,\mathbf{r}_1,\dots,\mathbf{r}_t)$ is
$$P[\{\mathbf{r}\}] = \rho(\mathbf{r}_0)\prod_{i=0}^{t-1}p(\mathbf{r}_{i+1}|\mathbf{r}_i),\label{eq:path-prob}$$
where $\rho(\mathbf{r}_0)$ is the equilibrium distribution and $p$ the
conditional propagator [@bolhuis2002transition]. The probability that a
trajectory initiated in $A$ reaches $B$ at time $t$ is
$$C(t) = \frac{\langle h_A(\mathbf{r}_0),h_B(\mathbf{r}_t)\rangle}{\langle h_A(\mathbf{r}_0)\rangle}
= \frac{\mathcal{Z}_{AB}(t)}{\mathcal{Z}_A},$$ with
$$\mathcal{Z}_A = \int\mathcal{D}\{\mathbf{x}\}h_A(\mathbf{r}_0)P[\{\mathbf{r}\}]\qquad
\mathcal{Z}_{AB} = \int \mathcal{D}\{\mathbf{r}\} h_A(\mathbf{r}_0)P[\{\mathbf{r}\}]h_B(\mathbf{r}_t),$$
where $\mathcal{Z}_A$ is the probability of a trajectory to start from
$\mathbf{r}_0$, regardles of where it ends at time $t$, and
$\mathcal{Z}_{AB}$ that to start in $r_0$ and end in $r_t$. These
probabilities are expressed in terms of path integrals, effectively
functional integrals over the set of all possible paths
[@feynman1948space; @kleinert2009path; @seifert2012stochastic]. The rate
constant, for example, follows from the long-time derivative
[@bolhuis2002transition],
$$k_{AB} = \lim_{t\to\infty}\frac{d}{dt}\left(\frac{Z_{AB}(t)}{Z_A}\right),$$
and the problem of evaluating the rate $k_{AB}$ reduces to sampling the
path ensemble in the same conceptual way as equilibrium properties are
obtained from the Boltzmann distribution.

It can be shown that one can generate trajectories that sample the
biased probability of starting in region $A$ and ending in region $B$
without recrossing (the transition path ensemble) in a straightforward
manner. Starting from one (even roughly sampled) reactive path, new
trial trajectories $\{\mathbf{r}'\}$ are generated by small stochastic
modifications and integrated forward and backward in time, accepting or
rejecting the new path $\{\mathbf{r}'\}$ using a Metropolis scheme
[@metropolis1949monte; @kalos2009monte; @frenkel_understanding_2023]. In
the microcanonical ensemble or other generalized microcanonical
ensembles with extended Hamiltonians, the acceptance probability becomes
remarkably simple [@dellago2002transition] becomes remarkably simple:
$$\text{acc}(\{\mathbf{r}\}\to\{\mathbf{r}'\})
= h_A\left(\{\mathbf{r}
_0\})h_B(\{\mathbf{r}_t]\}\right),$$ and all reactive proposals are
accepted. This is, in essence, the basic Transition Path Sampling (TPS)
algorithm. Having access to trajectories in this ensemble does not, at
first sight, help in the calculation of quantities like the rate
$k_{AB}$, as such a quantity is computed with a normalization factor
over the path starting in $A$ and ending at any point. However, TPS
provides direct access to the transmission function
$\kappa(t) = k(t)/k_{tst}$ via
$\kappa(t) = \langle \dot h_B(t) \rangle_{AB} / \langle \dot h_B(0) \rangle_{AB}$,
and the rate constant can be accessed by supplementing the TPS
calculation with a US in the TPE [@dellago1999calculation]. Having
access to the TPE enables a straightforward computation of the committor
function $p_B(\mathbf r)$ (also known as splitting probability,
originally introduced by Onsager [@onsager1938initial], see the
associated box in the CVs section). The committor is defined as the
probability that a configuration $\mathbf r$, with randomized momenta
drawn from the equilibrium distribution, will reach state $B$ before
returning to $A$. Because algorithms like TPS naturally generate
reactive trajectories that cross this separatrix, one can easily
identify transition-state configurations by launching short trajectories
from frames along the generated paths and selecting those for which
$p_B\simeq{0.5}$.

Related path-sampling methods include Transition Interface Sampling
(TIS) [@van2003novel; @van2005elaborating], Forward Flux Sampling (FFS)
[@allen2009forward], and Markov State Models (MSMs)
[@prinz2011markov; @chodera2014markov]. TIS extends the TPS framework by
introducing a hierarchy of interfaces between $A$ and $B$, and sampling
conditional path ensembles connecting successive interfaces. The rate is
then obtained as the product of these conditional probabilities,
multiplied by the initial flux through the first interface. FFS, on the
other hand, employs forward-only stochastic propagation of trajectories
across interfaces and is particularly suited to non-equilibrium or
stochastic dynamics where time reversibility does not hold. Finally,
MSMs describe kinetics in terms of transitions between discrete
metastable states, reconstructing long-time dynamics from many short
unbiased trajectories; rates and committors follow from the
eigenstructure of the resulting transition matrix.

Several refinements have been proposed to improve upon the original TPS
and other path-related algorithms, such as Precision Shooting
[@grunwald2008precision], S-Shooting [@menzl2016s], Aimless Shooting
[@peters2006obtaining], or combining it with different sampling
techniques, including metadynamics [@borrero2016avoiding] and replica
exchange [@van2007reaction]. The reader is referred to a recent review
for a comprehensive discussion of these developments
[@bolhuis2021transition].

# References
