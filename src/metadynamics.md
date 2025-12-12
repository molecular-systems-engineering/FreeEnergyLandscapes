## Adaptive Bias Methods: Metadynamics

Metadynamics (MetaD), introduced by Laio and Parrinello
[@laio2002escaping], is one of the most influential adaptive-bias
algorithms for reconstructing FESs
[@metaD_2; @metaD_1; @bussi2020using; @valsson2016enhancing]. Its
central idea is to discourage a molecular simulation from revisiting
previously explored regions of the space of CVs $\xi$; in doing so,
metadynamics enhances the fluctuations along $\xi$, thus speeding up the
sampling [@valsson2016enhancing]. A MetaD simulation evolves under a
time-dependent bias potential $V(\xi,t)$ that is incrementally
constructed as the trajectory progresses. At regular time intervals, a
small repulsive Gaussian hill of height $w$ and width $\sigma$ is
deposited at the instantaneous CV value $\xi(t)$:
$$V(\xi,t) = \sum_{t'<t} w
e^{-\frac{\left(\xi-\xi(t')\right)^2}{2\sigma^2 }}$$ This "computational
sand-filling" [@metaD_2] progressively raises the free-energy of
ensembles of configurations visited during sampling, allowing the system
to escape local minima and visit new regions of phase space. In the
long-time limit, the accumulated bias offsets the underlying free-energy
surface $F(\xi)$ up to an additive constant, so that
$V(\xi,t \to \infty)\approx -F(\xi)$. Once this condition is reached,
the biased dynamics samples a uniform probability distribution in CV
space, effectively restoring ergodicity (see Sec.
[sec:Theory](#sec:Theory)).

MetaD is conceptually related to other history-dependent approaches,
such as the local elevation method [@localelevation1994]. In particular,
MetaD shares with local elevation the general principle of discouraging
revisits to previously explored regions of collective variable space,
while differing in its formulation and bias-update protocol. Moreover,
compared with earlier mean-force-based schemes such as the Adaptive
Biasing Force (ABF) method [@abf_2015; @abf_darve2001; @abf_darve2002],
metadynamics constructs the bias from local visitation history rather
than explicit force estimates.

Despite its simplicity and general applicability, MetaD suffers from a
few drawbacks: the continual deposition of Gaussians can lead to
systematic overshooting of the free-energy surface; convergence depends
on the choice of Gaussian height and width; and the time dependence of
$V(\xi,t)$ complicates rigorous reweighting. These issues motivated the
development of statistically controlled variants that address these
shortcomings [@metaD_2; @valsson2016enhancing; @bussi2020using].

:::{important}
:icon: false
### Free-energy landscape of CO reduction on copper[]{#sec:case-study-reduction label="sec:case-study-reduction"}

An excellent example of the use of metadynamics to discover reaction
landscapes is the work by Cheng, Xiao, and Goddard III[@cheng2017full]
on the mechanism of CO reduction on copper. Copper remains the only
elemental catalyst capable of reducing CO$_2$ into hydrocarbons at
significant rates, but its product distribution and mechanistic pathways
have long been debated. Using ab initio molecular dynamics with explicit
water layers, combined with metadynamics and refined using the Blue Moon
ensemble, the authors computed atomistic free-energy barriers and
pathways. The analysis revealed that at moderate potentials (U \> --0.6
V vs RHE, pH 7), ethylene is the dominant product, formed via CO--CO
coupling in an Eley--Rideal pathway with water as the proton source
($\Delta G^\ddag = 0.69$ eV). At more negative potentials, hydrogen
competes for surface sites, suppressing C--C coupling and enabling
methane formation, with $^*$CHO identified as the key intermediate.

The impact of this study is twofold. First, it demonstrated how explicit
solvation and constant-potential modeling resolve longstanding
discrepancies in previous DFT work, where implicit solvation gave
inconsistent barriers. Second, by quantitatively reproducing the
observed potential- and pH-dependent product distribution, it suggested
a mechanism for for tuning selectivity in electrochemical CO$_2$
utilization, influencing subsequent efforts to design Cu-based alloys.

![image](images/goddard.pdf){width="\\linewidth"} *Free-energy landscape
for ethylene formation on Cu(100). (a) snapshots from ab-initio
simulations with explicit solvent revealed (b) that the Eley--Rideal
mechanism (black) has consistently lower barriers than
Langmuir--Hinshelwood (blue), establishing CO dimerization as the
rate-determining step.*

:::

### Well-Tempered Metadynamics (WTMetaD)

Well-tempered metadynamics [@wt_metaD_1] introduces a smooth tempering
of the bias deposition rate to achieve self-limiting convergence. In
WTMetaD the Gaussian height decreases exponentially with the local value
of the bias already accumulated:
$$w(t) = w_0 e^\frac{-\beta{V(\xi(t),t)}}{(\gamma-1)}$$

where $\gamma = (T + \Delta T)/T > 1$ is the *bias factor*. At the
beginning of a simulation, Gaussians start with height $w_0$; as
$V(\xi,t)$ grows, the added bias diminishes, so that (V) asymptotically
approaches a fraction of the underlying free energy:
$$V(\xi,t\to\infty) = -({\gamma-1})^{-1} F(\xi).$$

The bias factor $\gamma$ tunes the trade-off between exploration (large
$\gamma$) and accuracy (small $\gamma$). The stationary distribution
sampled by WTMetaD in the long-time limit is no longer flat but
*well-tempered*, i.e. $p(\xi)\propto {e^{-\beta F(\xi)/\gamma}}$. The
sampling along $\xi$ therefore occurs at an effectively elevated
temperature $T_\text{eff}=\gamma T$, which thus enhances barrier
crossing while maintaining a known, analytically recoverable bias.
WTMetaD has, *de facto*, become the standard formulation implemented in
modern software (e.g., PLUMED [@plumed214], GROMACS [@Lindahl2022],
LAMMPS [@Thompson2022]) because it provides controlled convergence,
improved statistical efficiency, and the possibility to monitor the
flattening of the free-energy landscape on-the-fly.

One can combine WTMetaD with static biases (e.g., harmonic restraints,
walls, or custom static biases) in a straightforward, additive manner
[@Awasthi2016; @limongelli2013funnel; @bjola2024estimating]. If the
WTMEtaD bias is deposited sufficiently slowly - so that transition
states remain effectively bias-free - the infrequent metadynamics
framework allows barrier-crossing times to be rescaled to recover
physical rate constants
[@tiwary2013metadynamics; @salvalaglio2014assessing; @palacio2022transition].

:::{important}
:icon: false
### Choosing the right coordinate: the ring puckering example

![image](Figures/Figure_puckering_2.png){width="1\\linewidth"} The
choice of collective variables (CVs) is critical in free-energy
calculations, but not always obvious. Puckered ring conformers can be
described by the Cremer--Pople cartesian coordinates, obtained from the
out-of-plane displacements $z_j$ of the 6-membered ring atoms as\
$$q_x =  \sqrt{\frac{1}{3}} \sum_{j=1}^6 z_j \cos\left[\frac{2\pi}{3}(j-1)\right],\quad  q_y = -\sqrt{\frac{1}{3}} \sum_{j=1}^6 z_j \sin\left[\frac{2\pi}{3}(j-1)\right],\quad q_z = \sqrt{\frac{1}{6}} \sum_{j=1}^6 (-1)^{j-1} z_j,$$
or by their polar representation
$\left(Q \sin \theta \cos \phi, Q \sin \theta \sin \phi, Q\cos \theta\right)$.
These coordinates correspond to a discrete Fourier decomposition of the
atomic elevations over the mean molecular plane, with the angular
coordinates spanning all pseudorotations (middle panel, where $\theta=0$
and $\pi$ correspond to the chair and inverted chair conformations,
respectively). Only the coordinates $(\theta,\phi)$ turn out to be
useful biasing variables, as they control connectivity between
conformers. The left panel shows the fully sampled puckering free energy
landscape of glucuronic acid from a metadynamics run using
$(\theta,\phi)$ as CVs (5 kJ/mol isolines). In contrast, biasing along
the Cartesian projection $(Q\sin\theta\cos\phi,  Q\sin\theta\sin\phi)$
might seem to work well initially, but only up to the equatorial line,
where boats and twisted boats conformers are located. There, the bias
force is perpendicular to the puckering sphere surface and only promotes
ring expansion/contraction, breaking the ergodic sampling. The right
panel shows the histogram of $Q$ and $q_r=|(q_x,q_y)|$ sampled during a
metadynamics run that uses $(q_x,q_y)$ as CVs. The algorithm becomes
stuck stretching the ring, as indicated by the strong correlation
between $q_r$ and the ring deformation $Q$, and is unable to leave the
northern (chair-like) hemisphere. Using the Cartesian projections as
CVs, the free energy estimates of accessible conformers are heavily
biased [@sega2009calculation].

:::

## Free-Energy Estimators for Metadynamics and Well-Tempered Metadynamics

The bias potential accumulated during a MetaD or WTMetaD simulation
modifies the underlying probability distribution, so that direct
estimates of the free energy $F(\xi)$ from the bias $V(\xi,t)$ are
inherently time-dependent. Several formulations have been proposed to
obtain *time-independent free-energy estimators*, which recover $F(\xi)$
or the distribution of *other* observables from a trajectory sampled
under the effect of a time-dependent bias
[@metaD_reweight; @wt_metaD_2; @Marinova2019; @giberti2019iterative; @Ono2020MetaD].

### Tiwary--Parrinello Time-Independent Estimator

Tiwary and Parrinello [@metaD_reweight] address the metadynamics
limitation that the evolving bias $V(\xi,t)$ yields $F(\xi)$ only up to
a time-dependent constant. Their approach is based on the observation
that, in the quasi-stationary regime, the instantaneous distribution is
written as
$$p(\mathbf{r},t)=p_0(\mathbf{r})\,e^{-\beta\,[V(\xi(\mathbf{r}),t)-c(t)]}
\label{eq:metad_sampled_prob}$$ where $p_0(\mathbf{r})$ is the Boltzmann
distribution, and the offset $c(t)$ is defined by:
$$c(t)=\beta^{-1}\ln\frac{\displaystyle\int d\xi\,e^{-\beta F(\xi)}}{\displaystyle\int d\xi\,e^{-\beta F(\xi)+\beta V(\xi,t)}}
\label{eq:coft}$$ This makes explicit that $c(t)$ is the additive
correction that restores the unbiased Boltzmann measure.

Introducing a scaled time $\tau$ via $d\tau/dt=e^{\beta c(t)}$, they
derive a \*\*time-independent free-energy estimator\*\* valid after a
short transient and for both well-tempered (WT) and standard
metadynamics:
$$F(s)= -\frac{\gamma}{\Delta T}\,k_BT\,V(\xi,t)+k_BT\ln\int d\xi\,\exp\left[\frac{\gamma}{\Delta T}\,\frac{V(\xi,t)}{k_BT}\right],$$
with $\gamma=(T+\Delta T)/T)$. This expression removes the explicit time
dependence of $F(s)$, enabling local convergence checks and direct
comparison of FESs from simulations performed with different parameters.
Moreover, Ref. [@metaD_reweight] provides a practical route to compute
$c(t)$ on the fly.

Once $c(t)$ is available, reweighting generic observables from biased
trajectories follows from:
$$\langle O\rangle_0=\big\langle O(\mathbf R)\,e^{\beta\,[V(\xi(\mathbf R)\,t)-c(t)]}\big\rangle_b$$
which is analogous to the Zwanzig reweighting typically applied to
time-independent biases [@Zwanzig1954] (see Sec. [sec:FEP](#sec:FEP)).
This approach yields a rigorous reweighting for any observable, under
the assumption that the bias evolves slowly compared to CV relaxation.
It is especially effective in the well-tempered limit, where the bias
growth rate diminishes exponentially with time
[@marinova2019time; @gimondi2018building].

### Bonomi--Barducci--Parrinello Reweighting.

Bonomi et al. introduce a simple, general reweighting scheme for WTMetaD
that recovers unbiased Boltzmann statistics of any observable---starting
from the same key identity defining $P(\mathbf r,t)$ (Eq.
[eq:metad_sampled_prob](#eq:metad_sampled_prob)), the definition of
$c(t)$ (Eq. [eq:coft](#eq:coft)) and the long-time limit of the bias
constructed with WTmetaD:
$V(\xi,t\to\infty)=-\Delta T/(\Delta T+T)\,F(\xi)$, Bonomi et al.
develop a reweighting approach that circumvents the need of computing
$c(t)$. By differentiating Eq.
[eq:metad_sampled_prob](#eq:metad_sampled_prob) for small time intervals
$\Delta t$, an evolution equation that eliminates $c(t)$ is derived:
$$p(\mathbf r,t+\Delta t)=e^{-\beta\,[\dot V(\xi(\mathbf r),t)-\langle \dot V(\xi,t)\rangle]\Delta t}\,p(\mathbf r,t)
\label{eq:propagator}$$ where $\dot c(t)=-\langle \dot V(\xi,t)\rangle$
and the average is over the biased distribution at time $t$. For WTMetaD
with Gaussian depositions, these results lead to a practical reweighting
algorithm based on three steps. (i) Accumulate a joint histogram
$N_t(\xi,f)$ for a target variable $f(\mathbf r)$ between Gaussian
updates; (ii) at each update, compute $\dot V$ and $\dot c$ using the
current accumulated histogram, and evolve $N_t$ using Eq.
[eq:propagator](#eq:propagator); (iii) reconstruct the unbiased
distribution of $f(\mathbf{r})$ as
$$p(f)=\frac{\sum_{\xi} e^{+\beta V(\xi,t)}\,N_t(\xi,f)}{\sum_{\xi,f} e^{+\beta V(\xi,t)}\,N_t(\xi,f)}.$$
The method is lightweight as it does not require any a posteriori
calculation of the total energy, it works in post-processing or (in
principle) on-the-fly, and it converges efficiently as shown in Refs.
[@gimondi2018building; @Marinova2019].

#### Mean Force Integration (MFI)

Extending Umbrella Integration (UI, see section
[sec:UmbrellaSampling](#sec:UmbrellaSampling)) to time-dependent biases,
Mean Force Integration (MFI) provides a general estimator for
history-dependent biasing schemes
[@marinova2019time; @bjola2024estimating]. Rather than computing the
non-local, time-dependent bias average $c(t)$, MFI reconstructs the FES
by integrating the *mean force* in $\xi$, computed at each bias-update
step: $$\nabla F_t(s) = -\beta^{-1}\nabla\ln p_b^t(s) - \nabla V_t(s),$$
where $p_b^t(s)$ is the biased probability density sampled while the
bias $V_t(s)$ remains unchanged between updates. Averaging these
mean-force estimates over successive updates and integrating numerically
yields a *time-independent FES*. This formulation reveals that
metadynamics, despite its adaptive nature, can be rigorously interpreted
within the TI framework: the accumulated bias corresponds to an
integrated mean force along the collective variables, and as such, it
circumvents the need to formulate equilibration assumptions on the bias
evolution. It can be applied to standard, well-tempered,
adaptive-Gaussian, or transition-tempered MetaD variants. Importantly,
MFI naturally supports *ensemble aggregation*---it can merge sampling
from multiple independent metadynamics runs without requiring continuous
trajectories or recrossings
[@marinova2019time; @bjola2024estimating; @serse2024unveiling].

### Variationally Enhanced Sampling (VES)

In contrast to the history-dependent or kernel-based approaches of
metadynamics, VES [@ves_valsson2014] formulates the problem of finding
the bias potential as a variational minimization of a functional of the
bias potential $V(\xi)$. Specifically, the stationary condition of the
functional ensures that the biased ensemble reproduces a desired
*target* probability distribution $p^*(\xi)$.

The bias potential is defined as the function $V(\xi)$ that minimizes
the Kullback--Leibler (KL) divergence between the sampled distribution
$p_V(\xi)$ and the target distribution:

$$\Omega[V] = \frac{1}{\beta} \ln \left[\int d\xi e^{-\beta [F(\xi) + V(\xi)]} \right]
 \int d\xi p^*(\xi) V(\xi),$$

where $F(\xi)$ is the underlying free energy. Minimizing $\Omega[V]$
with respect to $V$ yields the optimal bias

$$V^*(\xi) = -F(\xi) - \frac{1}{\beta} \ln p^*(\xi) + \text{const.}$$

In practice, the bias is expressed as a linear combination of basis
functions (e.g., polynomials, splines, or neural-network features) with
parameters optimized during the simulation through stochastic gradient
descent. This variational approach offers a systematic method for
constructing bias potentials that provide direct control over the
sampled distribution. When $p^*(\xi)$ is chosen to be uniform, VES
converges to a direct estimate of the free energy $F(\xi)$; when it is a
tempered distribution, it behaves analogously to well-tempered
metadynamics but with improved smoothness and convergence properties. A
key strength of VES is how naturally it fuses with modern ML: starting
from VES variational functional [@ves_valsson2014], the bias can be
parameterized by a neural network and optimized directly from simulation
--- an approach realized by Bonati et al. [@bonati2019neural]
("Deep-VES"), which treats the VES objective $\Omega[V]$ as a
differentiable loss and updates network parameters using gradients
estimated from the biased and target ensembles.

### On-the-fly Probability Enhanced Sampling (OPES)

OPES [@invernizzi2020rethinking; @invernizzi2020unified] extends
metadynamics by adopting a direct probabilistic formulation. Instead of
depositing Gaussians, OPES continuously estimates the marginal
probability distribution of the CVs and updates a bias potential
designed to transform the instantaneous distribution into a chosen
*target distribution* $\tilde p(\xi)$. In practice, the target is often
chosen to be uniform (for direct free-energy estimation) or follows a
well-tempered form to strike a balance between exploration and
stability. At every step, OPES computes the current biased histogram
$p_V(\xi)$ and defines the new bias as
$$V(\xi) = -k_BT \ln\left[\frac{p_V(\xi)}{\tilde p(\xi)}\right].$$ This
ensures that, upon convergence, the simulation samples
$p_V(\xi)=\tilde p(\xi)$. The bias, therefore, evolves self-consistently
to realise a desired stationary distribution rather than through
incremental hill deposition. In the *OPES-Explore* variant,
$\tilde p(\xi)$ is flat, providing a direct reconstruction of the FES;
in *OPES-Meta* the target adopts the same tempered form as WTMetaD,
producing controlled exploration similar to well-tempered sampling but
with faster convergence and reduced noise. Because OPES derives from an
explicit reweighting equation, it inherits a clear statistical
interpretation, and the accumulated bias approximates the free energy
according to $F(\xi) = -(\gamma-1) V(\xi) + \text{const}$, analogous to
WTMetaD but without relying on discrete Gaussian hills. The absence of
kernel summations makes OPES computationally cheaper and smoother in
high-dimensional CV spaces. Moreover, its probabilistic update scheme
naturally accommodates on-the-fly reweighting and can exploit adaptive
kernel density estimators to achieve rapid convergence even in
multi-dimensional landscapes. Finally, OPES offers a direct route to
target distributions using CVs that can be learned, enabling an
aggressive and efficient yet controlled exploration with a sound
statistical reweighting procedure
[@henin2022review; @invernizzi2020unified].

# References
