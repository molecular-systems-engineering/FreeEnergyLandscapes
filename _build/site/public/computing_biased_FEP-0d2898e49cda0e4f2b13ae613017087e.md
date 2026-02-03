# Computing Free Energy Surfaces

(estimating-pxi-from-samples-ergodicity)=
## Estimating $p(\xi)$ from Samples: Ergodicity

Computing an FES from Eq. [eq:FES](#eq:FES) requires estimating the
marginal equilibrium distribution $p(\xi)$, typically estimated from
molecular dynamics or Monte Carlo trajectories. This estimate assumes
*ergodicity*, hence implying that sufficiently long trajectories sample
phase space according to equilibrium weights, making time averages
equivalent to ensemble averages. Formally, for an observable
$O(\mathbf{r})$:
$$\lim_{\tau \to \infty} \frac{1}{\tau} \int_0^\tau O(\mathbf{r}(t)) dt = \int O(\mathbf{r}) f(\mathbf{r}) d\mathbf{r}$$
where $f(\mathbf{r}) = \frac{e^{-\beta U(\mathbf{r})}}{Q_{NVT}}$ is the
canonical distribution, $U(\mathbf{r})$ is the potential energy, and
$Q_{NVT}$ the configurational partition function. In the specific case
of a collective variable $\xi(\mathbf{r})$, the ergodic hypothesis
ensures that the empirical distribution of $\xi$ obtained from sampling,
converges to equilibrium in the long-time limit:
$$p(\xi) = \lim_{\tau \to \infty} \frac{1}{\tau} \int_0^\tau \delta\big(\xi(\mathbf{r}(t)) - \xi \big) dt = \frac{1}{Q_{NVT}} \int e^{-\beta U(\mathbf{r})} \delta\big(\xi(\mathbf{r}) - \xi\big) d\mathbf r .$$
When systems feature metastable states separated by high barriers,
unbiased simulations on practical timescales often fail to achieve
ergodic sampling, leading to incomplete estimates of $p(\xi)$; enhanced
sampling methods address this by accelerating rare transitions, ensuring
thorough exploration of relevant states, and yielding reliable FESs that
capture both thermodynamic stability and kinetic accessibility.

(recovering-ergodicity-via-biased-sampling-foundations)=
## Recovering Ergodicity via Biased Sampling: Foundations

Biased enhanced sampling methods aim to efficiently achieve ergodicity
by introducing an artificial bias potential $V(\xi)$ that modifies the
system Hamiltonian, $$H_1 = H_0 + V(\xi),$$ to alter the equilibrium
distribution $p(\xi)$ into a *biased* one $p_b(\xi)$. Reweighting
techniques, often rooted in Zwanzig's free energy perturbation [@Zwanzig1954], enable the recovery of unbiased distributions.
Building on these principles, methods such as Umbrella Sampling, Blue
Moon Ensemble, and Metadynamics enable the computation of FESs from
biased ensembles; for a comprehensive overview, see Ref. [@henin2022enhanced].

(free-energy-perturbation-and-thermodynamic-integration)=
### Free Energy Perturbation and Thermodynamic Integration[]{#sec:FEP label="sec:FEP"}

The term Free Energy perturbation (FEP) describes a series of methods
originating in the thermodynamic perturbation (TP) one, which evaluates
the free-energy change when switching from a reference Hamiltonian $H_0$
to a perturbed one $H_1$ via Zwanzig's formula [@Zwanzig1954],
$$\Delta F = -kT\ln \left\langle e^{-\beta(H_1-H_0)}\right\rangle_0,\label{eq:zwanzig}$$
where the subscript 0 is a reminder that the average has to be taken
using the unperturbed Hamiltonian $H_0$ to integrate the equations of
motions. The formula is exact for any value of $H_1$, so the term
"perturbation" is somewhat misleading. However, the sampling is
efficient only when configurations sampled under $H_0$ overlap well with
those favored by $H_1$. Stratifying the jump into neighboring states
$\xi_i\to \xi_{i+1}$ gives multistep TP,
$$\Delta F=\sum_i -kT\ln\left\langle e^{-\beta[H(\xi_{i+1})-H(\xi_i)]}\right\rangle_{\xi_i}.\label{eq:multiTP}$$
The principle of TP is at the core of numerous methods described in the
following sections.

(thermodynamic-integration)=
### Thermodynamic Integration

Thermodynamic integration (TI) is in effect an application of multistep
TP in the limiting case of infinitesimally small changes:
$$\Delta F=\int_{ s_0}^{ s_1}\Big\langle \frac{\partial H}{\partial  \xi}\Big\rangle_{ \xi=s}d s.\label{eq:TI}$$
Eq. [eq:TI](#eq:TI) can be rigorously derived from Eq.
[eq:multiTP](#eq:multiTP) using the first term of the cumulant expansion
[@kubo1962generalized]

$\ln\left\langle e^{\epsilon \delta s}\right\rangle \simeq \left\langle \epsilon \right\rangle \delta  s + O(\delta s^2)$,
or by integrating
$\partial F/\partial  s  =  -(kT/Z_{NVT}) \partial Z_{NVT}/\partial  s$.

The TI formula has a precise interpretation as the integral of the
generalized mean force; however, one needs to take care to ensure the
quasi-adiabatic limit. In fact, the early single-configuration TI (SCTI)
implementation replaced the ensemble average by a single instantaneous
value taken while changing $s$ continuously but showed hysteresis [@mitchell1991free] at finite switching rates $ds/dt$, a clear
sign of non-equilibrium. Multiconfiguration TI (MCTI) [@straatsma1991multiconfiguration] addresses this issue by calculating proper ensemble
averages at each value of $s$, yielding per-window statistical errors,
and is also an embarrassingly parallel algorithm. Despite the
development of more efficient methods, the flaw of implementing a
non-equilibrium sampling has sparked new interest in SCTI in the context
of Jarzynski's identity and steered molecular dynamics [@hummer2001fast; @park2004calculating], see Section
[sec:single-molecule-spectroscopy](#sec:single-molecule-spectroscopy) on
single molecule spectroscopy.

When the perturbation affects an internal CV rather than an interaction
parameter, the system has to be kept at or in the vicinity of the chosen
value of $\xi=s$. If the configuration change is driven by a
$\xi$-dependent perturbation in the form of a restraint $V(q,\xi)$,
typically a harmonic potential, the free energy of the unrestrained
system is recovered by unbiasing the TI result with TP of the
restraint [@straatsma1991multiconfiguration]:
$$\Delta F(s)=\int_{s_0}^{s}\left\langle \frac{\partial V}{\partial \xi}\right\rangle_{\xi=s'}ds'
+kT\ln\left\langle e^{\beta V(q,\xi)}\right\rangle_{\xi=s}
\label{eq:TI_gen}$$

Another way of looking at the TI when the RC is a function of atomic
coordinates instead of a parameter of the Hamiltonian, for example
$\xi(\mathbf{r}) = \left| \mathbf{r}_2 - \mathbf{r}_1 \right|$. In this
case the PMF along the RC in terms of the conditional probability $p(s)$
is written as
$$F(s) = -kT \ln \left\langle \delta\left(\xi(\mathbf r) - s \right)\right\rangle \equiv - kT \ln p(s),$$
The free energy difference takes the form
$$\Delta F = \int_{s_1}^{s_2}  \left\langle \frac{\partial H}{\partial \xi}\right\rangle^\mathrm{cond}_{\xi=s} ds$$
where the conditional average is defined by
$$\left\langle  \cdot \right\rangle^\mathrm{cond}_{\xi=s}=\frac{\left\langle \cdot \delta\left( \xi -s \right)\right\rangle}{\left\langle \delta\left( \xi -s \right)\right\rangle}.$$
This can easily be recovered as the stiff limit of a harmonic restraint.
In the case of holonomic constraints being imposed rather than
restraints, correct unbiasing requires more complex approaches described
in Sec.[sec:BM](#sec:BM).


```{figure} ./Figure_biased_sampling.png
:label: fig:biased
:alt: Figure 4
:align: center

**Overcoming sampling limitations with biased approaches** 
**A, B. Unbiased simulations.** When high free energy barriers hinder
transitions between metastable states, only local estimates of $p(\xi)$
are accurate. 
**C, D. Umbrella Sampling.** In US multiple restrained
simulations centered at reference positions $\xi_{ref}$ (red parabolas
in C), enable a uniform coverage of the reaction coordinate, shown in D;
the sampled biased histograms are subsequently combined to recover the
full free energy profile (see Sec.
[sec:UmbrellaSampling](#sec:UmbrellaSampling)). 
**E, F. Metadynamics**
In MetaD, the bias is history-dependent, progressively filling free
energy wells and promoting barrier crossing. The dynamics of $\xi(t)$,
under the effect of bias (panel F) shows how an ergodic exploration of
configuration space is associated with bias construction (see Sec.
[sec:metadynamics](#sec:metadynamics)).
```

(umbrella-sampling)=
## Umbrella Sampling

Umbrella sampling (US), introduced by Torrie and Valleau in the 1970s
[@Torrie1977; @kastner2011umbrella], is one of the earliest
enhanced-sampling methods to compute an FES along a CV $\xi$. US is a
*static* bias method, i.e., the biasing potential does not change in
time. The central idea of US is to overcome the poor sampling of
high-energy regions by introducing a ---usually harmonic--- restraint,
which localizes the sampling around a reference value
$\xi_i^{\mathrm{ref}}$:
$$V_i(\xi) = \frac{1}{2} K (\xi - \xi_i^{\mathrm{ref}})^2 .$$ In the
context of TP, $V_i(\xi)$ can be seen as the *perturbation* introduced
in the physical Hamiltonian of the system in each of the $i$
simulations.

In US, a series of such biased simulations ("windows", Fig.
[fig:biased](#fig:biased)C) is performed to span the full range of $\xi$
(see Fig. [fig:biased](#fig:biased)D). Each window produces a biased
distribution $p_i^b(\xi)$. The unbiased distribution in window $i$ is
formally recovered as
$$p_i(\xi) = p_i^b(\xi)  e^{\beta V_i(\xi)} \langle e^{-\beta V_i(\xi)} \rangle_0,$$
from which the free energy (or potential of mean force, PMF) is obtained
using Eq. [eq:FES](#eq:FES). Because each window only samples a narrow
range of $\xi$, the problem of stitching the windows together arises:
the free-energy offsets between windows $F_i$ are not known directly.

Several post-processing strategies exist, all rooted in FEP and TI
concepts [@Roux1995]. The Weighted Histogram Analysis Method (WHAM)
[@kumar1992weighted] is the *de facto* standard post-processing tool in
umbrella sampling and determines the free-energy offsets
self-consistently by minimizing statistical error, merging all biased
histograms into a single distribution (see also [@souaille2001extension; @hub2010g_wham]. The Multistate Bennett
Acceptance Ratio (MBAR) method provides an equivalent, statistically
optimal alternative to WHAM [@mbar_2008; @tan2012theory].

An alternative that avoids explicit offset estimation is umbrella
integration (UI) [@kastner2005bridging], which reconstructs the mean
force directly from the biased distribution,
$$\frac{\partial F}{\partial \xi} \;=\; -kT\frac{\partial \ln p_i^b(\xi)}{\partial \xi} - \frac{dV_i}{d\xi},$$
yielding the PMF by integration over $\xi$. This way, UI makes explicit
the proximity between US and thermodynamic integration methods,
effectively implementing an FES estimator similar to Eq.
[eq:TI_gen](#eq:TI_gen) We note that UI inspired the development of Mean
Force Integration, which can be applied to the post-processing of
sampling gathered with both static and adaptive biasing methods
[@Marinova2019; @MFI_Bjola; @Serse2024].

Overall, umbrella sampling can be viewed as a *restrained-sampling
framework* analyzed either by histogram reweighting (WHAM/MBAR) or by
mean-force integration (UI); both approaches converge to the same PMF
given sufficient sampling.

Over the years US has inspired many extensions. Adaptive US iteratively
refines the bias toward uniform sampling [@mezei1987adaptive], while local elevation US introduces a history-dependent bias reminiscent of early metadynamics [@huber1994local; @hansen2010using; @laio2002escaping]. Multidimensional
formulations [@bartels1997multidimensional; @kastner2009umbrella] treat coupled coordinates, and hybrid schemes, such as self-learning adaptive
variants [@wojtas2013self] or replica-exchange US [@jiang2012calculation], enable efficient, massively parallel implementations. These developments confirm US remains a versatile and widely used framework for free-energy calculations.

(constrained-reaction-coordinates-the-blue-moon-ensemble)=
## Constrained reaction coordinates: the Blue Moon Ensemble

Often, holonomic constraints, where the constraining force acts along
$\partial\xi/\partial \mathbf{r}$ [@goldstein1950classical; @van1984constraints], are used as an alternative to harmonic
restraints to enforce a specific value of the CV $\xi(\mathbf {r})=s$
using algorithms like SHAKE [@ryckaert1977numerical]. 
In this case, one needs to apply an unbiasing factor
$Z_{\xi}= \sum_i \left|\partial {\xi}/\partial \mathbf r_i\right|^2 / m_i$
to correct for momentum loss along the constraint [@carter1989constrained].
Combining this factor with the contribution from the integration over
(all, including the unbiased) kinetic degrees of freedom yields the Blue
Moon ensemble configurational formula (so named because it helps sample
events that happen "once in a blue moon") $$\frac{dF}{ds}
={\displaystyle \left\langle Z^{-1/2}_\xi\right\rangle^{-1}_{\xi=s}}
\displaystyle \left\langle Z^{-1/2}_\xi\left[ \frac{\partial V}{\partial \xi}-\frac{kT}{2}\frac{\partial \ln|M(\mathbf q)|}{\partial \xi}\right]\right\rangle_{\xi=s},$$
where $M$ is the mass-metric tensor appearing in Eq.
[eq:metric-factor-origin](#eq:metric-factor-origin). In this
formulation, the RC must be one of the generalized coordinates used to
describe the configurations. Sprick and Ciccotti derived an equivalent
expression that requires only the constraint force magnitude along with
a curvature correction [@sprik_free_1998]. The case of
multidimensional reaction constants is discussed in Ref.[@ciccotti1991molecular].

:::{tip} Unbiasing constraints
Constraints in the Blue Moon ensemble are
artifacts and their bias clearly must be removed. Structural constraints
(bond length, angles) can sometimes be corrected via the Fixman
potential [@fixman1978simulation]. Yet, it is debatable whether this is
appropriate, since both flexible and rigid bonds are approximations: the
former neglect high vibrational excitations, the latter ignore
conformation-dependent zero-point effects [@van1984constraints]. In
addition, as these bond length fluctuations are not independent modes,
they do not satisfy the general equipartition theorem
[@tolman1918general], which underpins the bias removal procedure.
:::

(sec:metadynamics)=
# Adaptive Bias Methods: Metadynamics and derived methods

A key ingredient of US is the use of a fixed set of windows chosen a
priori, with convergence depending on their overlap. A complementary
class of methods instead builds the bias adaptively as the simulation
progresses. Metadynamics (MetaD), introduced by Laio and Parrinello [@laio2002escaping], is one of the most influential adaptive-bias
algorithms for reconstructing FESs [@metaD_2; @laio2002escaping; @bussi2020using; @valsson2016enhancing]. Its central idea is to discourage a molecular
simulation from revisiting previously explored regions of the space of
CVs $\xi$; in doing so, metadynamics enhances the fluctuations along
$\xi$, thus speeding up the sampling [@valsson2016enhancing]. A MetaD simulation evolves under a time-dependent bias potential
$V(\xi,t)$ that is incrementally constructed as the trajectory
progresses. At regular time intervals, a small repulsive Gaussian hill
of height $w$ and width $\sigma$ is deposited at the instantaneous CV
value $\xi(t)$: $$V(\xi,t) = \sum_{t'<t} w
e^{-\frac{\left(\xi-\xi(t')\right)^2}{2\sigma^2 }}$$ This "computational
sand-filling" [@metaD_2] progressively raises the free-energy of ensembles of configurations visited during sampling, allowing the system to escape local minima and visit new regions of phase space. 
In the long-time limit, the accumulated bias offsets the underlying free-energy surface $F(\xi)$ up to an additive constant, so that $V(\xi,t \to \infty)\approx -F(\xi)$. Once this condition is reached, the biased dynamics samples a uniform probability distribution in CV space, effectively restoring ergodicity (see Sec. [sec:Theory](#sec:Theory)).

MetaD is conceptually related to other history-dependent approaches,
such as the local elevation method [@huber1994local]. In particular, MetaD shares with local elevation the general principle of discouraging revisits to previously explored regions of collective variable space, while differing in its formulation and bias-update protocol. Moreover, compared with earlier mean-force-based schemes such as the Adaptive Biasing Force (ABF) method
[@abf_2015; @abf_darve2001; @abf_darve2002], metadynamics constructs the bias from local visitation history rather than explicit force estimates. Despite its simplicity and general applicability, MetaD suffers from a few drawbacks: the continual deposition of Gaussians can lead to systematic overshooting of the free-energy surface; convergence depends on the choice of Gaussian height and width; and the time dependence of $V(\xi,t)$ complicates rigorous reweighting. 
These issues motivated the development of statistically controlled variants that address these shortcomings [@wt_metaD_1; @valsson2016enhancing; @bussi2020using].

Well-tempered metadynamics [@wt_metaD_1], is the
most popular variant of metadynamics that addresses several of these
issues. For instance, WTMetaD introduces a smooth tempering of the bias
deposition rate to achieve self-limiting convergence. This is achieved
by imposing a dynamic evolution of the Gaussian heights that decreases
exponentially with the local value of the bias already accumulated:
$$w(t) = w_0 e^\frac{-\beta{V(\xi(t),t)}}{(\gamma-1)}$$ where
$\gamma > 1$ is the *bias factor*. At the beginning of a simulation, the
Gaussian bias height is $w_0$; as $V(\xi,t)$ grows, the added bias
diminishes, so that $V$ asymptotically approaches a smoothed version of
the underlying FES as $V(\xi,t\to\infty) = -({1-1/\gamma}) F(\xi)$. The
bias factor $\gamma$ tunes the trade-off between exploration (large
$\gamma$) and accuracy (small $\gamma$). The stationary distribution
sampled by WTMetaD in the long-time limit is no longer flat but
*well-tempered*, i.e. $p(\xi)\propto {e^{-\beta F(\xi)/\gamma}}$. The
sampling along $\xi$ therefore occurs at an effectively elevated
temperature $T_\text{eff}=\gamma T$, which thus enhances barrier
crossing while maintaining a known, analytically recoverable bias.
WTMetaD has, *de facto*, become the standard formulation implemented in
modern software (e.g., PLUMED [@plumed2], GROMACS [@Lindahl2022], LAMMPS [@Thompson2022]) because it provides controlled
convergence, improved statistical efficiency, and the possibility to
monitor the flattening of the free-energy landscape on-the-fly.

One can combine WTMetaD with static biases (e.g., harmonic restraints,
walls, or custom static biases) in a straightforward, additive manner
[@Awasthi2016,@limongelli2013funnel,@MFI_Bjola]. If the WTMetaD bias is deposited sufficiently
slowly - so that transition states remain effectively bias-free - the
infrequent metadynamics framework allows barrier-crossing times to be
rescaled to recover physical rate constants [@tiwary2013metadynamics; @salvalaglio2014assessing;@palacio2022transition]. The bias potential accumulated during a MetaD or WTMetaD
simulation modifies the underlying probability distribution, so that
direct estimates of the free energy $F(\xi)$ from the bias $V(\xi,t)$
are inherently time-dependent. Several formulations have been proposed
to obtain *time-independent free-energy estimators*, which recover
$F(\xi)$ or the distribution of *other* observables from a trajectory
sampled under the effect of a time-dependent bias [@metaD_reweight; @wt_metaD_2; @Marinova2019; @giberti2019iterative; @Ono2020MetaD].

Recent developments have further generalized ideas originating from
metadynamics by recasting bias construction in probabilistic or
variational terms, giving rise to methods such as Variationally Enhanced
Sampling (VES) [@ves_valsson2014], On-the-fly Probabilty
Enhanced Sampling (OPES) [@invernizzi2020unified], and GAMBES [@debnath2020gaussian] which differ in how the target distribution is enforced. VES does so by minimizing a KL-based variational functional. In contrast, OPES
achieves it via an explicit on-the-fly estimate of the marginal biased
probability density and a reweighting-based update of the bias; GAMBES,
instead, reconstructs the bias from a Gaussian Mixture approximation of
the sampled probability distribution. We refer the reader interested in
additional details to the comprehensive review of Henin et al. [@henin2022enhanced].