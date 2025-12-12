# Theory: Defining a Free Energy Surface {#sec:Theory}

## Thermodynamic Potentials and Partition Functions

In the canonical ensemble, which describes a system at constant number
of particles ($N$), volume ($V$), and temperature ($T$), the probability
density $f(\mathbf{r}, \mathbf{p})$ of finding the system in a
particular *microstate* characterized by the 6-N dimensional phase space
vector of atomic (Cartesian, for simplicity) coordinates and momenta
$\Gamma = (\mathbf{r},\mathbf{p})$ is proportional to the Boltzmann
factor $e^{-\beta H(\mathbf{x},\mathbf{p})}$, which measures the total
energy of the microstate, expressed by the Hamiltonian $H$, in units of
the thermal energy $kT = 1/\beta$, $k$ being the Boltzmann constant and
$T$ the absolute
temperature.[@chandler1978statistical; @frenkel_understanding_2023; @tuckerman2023statistical]

:::{aside}
**Phase Space Vector** Indicated with $\Gamma$, it is, for a system
without constraints, a 6$N$-tuple that encompasses the positions
$\mathbf{r}=(\mathbf{r}_1,\ldots\mathbf{r}_N)$ and momenta
$\mathbf{p}=(\mathbf{p}_1,\ldots\mathbf{p}_N)$ of all $N$ particles in a
system. Here, we represent this as: $\Gamma = (\mathbf{r},\mathbf{p})$.\
**Microstate** A specific realization of the phase space vector $\Gamma$
represents a single point in the 6N-dimensional phase space, defining
the complete microscopic state of a classical system at a given instant
in time.\
**Hamiltonian** Indicated with $H(\Gamma)$, it is a fundamental function
in classical mechanics that describes the total energy of a system as a
function of its generalized coordinates and conjugate momenta.
[@tuckerman2023statistical]

:::

The normalization constant of the phase-space density
$f(\mathbf{r}, \mathbf{p})$ is the *partition function* - $Z$ - which
is, in essence, a (Boltzmann-weighted) count of the number of accessible
microstates and enables a direct connection between molecular
configurations (i.e., realizations of $\mathbf{r}, \mathbf{p}$), and
thermodynamic concepts familiar to an engineering audience.

The partition function in the canonical ensemble for a system of $N$
identical particles is written as:
$$Z_{NVT} = \frac{1}{N! h^{3N}}\int d\Gamma e^{-\beta H(\Gamma)}.
\label{eq:partitionNVT}$$ The normalisation factor ${N! h^{3N}}$
includes two inherently quantum-mechanical terms: the factorial of the
number of particles $N!$ and the $N$-th power of Planck's constant $h$.
The former factor takes into account the permutations of identical
particles. It is necessary, even if particles are classical, to recover
an extensive entropy and avoid mixing entropy (Gibbs)
paradoxes[@noyes1961entropy; @frenkel_understanding_2023; @tuckerman2023statistical].
At the same time, the latter is a measure of the minimum phase space
volume set by the intedermination principle and recovers the
Sackur-Tetrode entropy of the ideal gas[@Huang].

If the Hamiltonian can be written as the sum of independent potential
and kinetic terms, $H(\Gamma) = U(\mathbf{r}) +K(\mathbf{p})$, momenta
can be integrated out and the partition function can be expressed in
terms of the configurational integral (also called configurational
partition function) $Q_{NVT}$, as $$Z_{NVT}
=\frac{1}{N! \Lambda^{3N}} Q_{NVT},$$ with
$$Q_{NVT} = \int d\mathbf{r} e^{-\beta U(\mathbf{r})}$$ and
$\Lambda = h/\sqrt{2\pi m kT}$ is the thermal wavelength for particles
of mass $m$.

:::{important}
:icon: false
### Z or Q?

There is often confusion about which symbol refers to the full partition
function, and which to the configurational one, and for good reasons!
While IUPAC[@brett2023quantities]lists both $Z$ and $Q$ as possible
symbols for the partition function, without specifying whether it is the
full or the configurational one, classic textbooks including
Huang[@Huang], Frenkel and Smit[@frenkel_understanding_2023], and Allen
and Tildesley[@allen2017computer], use $Q$ for the full partition
function, while Rowlinson and Widom[@rowlinson2002molecular],
Kittel[@kittel2004elementary] and Landau and Lifshitz[@landau5] use $Z$.
Here, we follow the latter convention.

:::

The configuration (marginal) probability density function is in this
case [@tuckerman2023statistical]:
$$f(\mathbf{r}) = \frac{e^{-\beta U(\mathbf{r})}}{Q_{NVT}} = \frac{e^{-\beta U(\mathbf{r})}}{\int d\mathbf{r} e^{-\beta U(\mathbf{r})}}$$

### From Partition Functions to Thermodynamic Potentials

The partition function $Z$ is a central quantity because it encodes all
the thermodynamic information of the system in this ensemble. In
particular, the thermodynamic potential for the canonical ensemble, or
Helmholtz free energy, $A$, can be written as: $$A = -kT \ln Z_{NVT},$$
or, in terms of the configuration integral,
$$A = -kT \ln Q_{NVT}  + kT\ln\left( N!\Lambda^{3N}\right), 
\label{eq:FE}$$ where the first term on the right-hand side is the
configurational free energy and the second one the translational free
energy. Other thermodynamic quantities (that is, quantities that depend
on the macroscopic control parameters $N,V,T$ only) can then be computed
as derivatives of $A_{NVT}$. Other statistical ensembles can be derived,
for instance---but not necessarily---from the canonical ensemble through
a Legendre transformation with respect to one control variable. This
operation yields a new distribution function that corresponds to the
Laplace transform of the original one. In what follows, we use the
symbol $F$ to refer to the free energy or thermodynamic potential
without connection to an ensemble in particular. The specific meaning of
$F$ ---whether Helmholtz or Gibbs free energy--- depends on the
statistical ensemble used to generate the molecular samples used to
compute free energy surfaces as discussed in Section
[sec:Computing](#sec:Computing).

:::{aside}
**Isothermal-Isobaric Ensemble** The isothermal--isobaric partition
function is related to the canonical partition function via
[@tuckerman2023statistical]:
$\Delta_{NPT}=\int_0^\infty dV  e^{-\beta PV}  Z_{NVT}\label{note:NPT}$

:::

### From Thermodynamic Potential to Free Energy Differences

Now, let us consider two disconnected regions of the phase space,
$\Omega_i$ and $\Omega_j$, representing two sets of microstates
associated with two distinct states of the system, $i$ and $j$. Such
ensembles of configurations could correspond to the reactants and
products of a chemical reaction, two different phases of the same
substance, the unfolded and folded configurations of a biopolymer,
etc.). By integrating the normalised canonical phase space distribution
within $\Omega_i$ (or $\Omega_i$), one can obtain the equilibrium
probability to observe the system in state $i$ (or $j$), or have access
to the free energy difference between the two states:

$$\Delta{F}_{i\rightarrow j}=-
kT\ln\left[{\frac{\int
{\mathbf{1}_{\mathbf{r}\in{\Omega_j}}f(\mathbf{r})}d\mathbf{r}}{\int
{\mathbf{1}_{\mathbf{r}\in{\Omega_i}}f(\mathbf{r})}d\mathbf{r}}}\right]
\label{eq:DF}$$

where $\mathbf{1}_{\mathbf{r}\in{i,j}}$ is an indicator function that
selects only microstates belonging to a given state, for example, state
$i$, and $\int
{\mathbf{1}_{\mathbf{r}\in{\Omega_i}}f(\mathbf{r})}d\mathbf{r}=P_{i}$,
is the equilibrium probability of said state $i$.

```{figure} Figures/Figure_FES_concept.png
:name: fig:FES_idea
:width: 1.2\linewidth
From microscopic configurations to the free energy surface. Each molecular configuration ($\mathbf{r}_i \in \mathbf{R}^{3N}$, where $N$ is the number of atoms) is mapped to a point in a reduced, low dimensional space of collective variables ($\xi(\mathbf{r}) \in \mathbf{R}^m$), with $m \ll 3N$. In the following, to favour readability, we indicate $\xi$ as a scalar; however, its dimensionality can be higher than one, and extensions to higher dimensionality are straightforward(Laio and Parrinello 2002; Kästner 2011). The marginal equilibrium probability $p(\xi)$, which quantifies the relative likelihood of observing configurations consistent with a given value of $\xi=[\xi_1,\xi_2]$. The corresponding free energy surface $F(\xi) = -kT \ln (\xi) + C$ provides a readable map of thermodynamic stability and metastability in configuration space. Basins A and B correspond to metastable states separated by a free energy barrier.
```

## Free Energy Surfaces: readable maps of the thermodynamic potential

The evaluation of the equilibrium probabilities $P_{i,j}$ requires
defining the indicator function $\int
{\mathbf{1}_{\mathbf{r}\in{i}}f(\mathbf{r})}d\mathbf{r}$, which
pinpoints configurations belonging to $\Omega_{i,j}$. Given the inherent
high dimensionality of $\mathbf{r}$, this is far from being a trivial
task, and can be achieved by introducing a suitable low-dimensional
function $\xi(\mathbf{r})$ that maps microstates (specific realizations
of the coordinates vector $\mathbf{r}$) belonging to the same macrostate
close to one another.

The introduction of $\xi(\mathbf{r})$ allows to define the marginal
equilibrium probability $p(\xi)$ as
[@kirkwood1935statistical; @tuckerman2023statistical; @frenkel_understanding_2023]:
$$p(\xi)=Q^{-1}\int{f(\mathbf{r})\delta({\xi^\prime({\mathbf{r}})-\xi})d\mathbf{r}}
\label{eq:marginal-prob}$$ where $p(\xi)$ is the equilibrium probability
of the ensemble of microstates mapping to the same value of
$\xi(\mathbf{r})$. In this context, $p(\xi)$ can be interpreted as the
partition function associated with all the microstates mapped in
$p(\xi)$.

In analogy with Eq.[eq:FE](#eq:FE) we can therefore define a free energy
for every $\xi$ as: $$F(\xi)=-kT\ln{p(\xi)}+C
\label{eq:FES}$$ where $F(\xi)$ is the FES, and $C$ is an arbitrary
constant, indicating that $F(\xi)$ is a measure of *relative*
thermodynamic stability between ensembles of states that map to
different values of $\xi$.

Mapping configurations onto a physically meaningful $\xi$ such that,
i.e., it captures slow transitions in the configurational ensemble (see
Section [sec:CVs](#sec:CVs)), renders the features of $F(\xi)$
informative. For instance, for a good choice of $\xi$, metastable states
correspond to local minima in $F(\xi)$. As a consequence, free energy
differences between metastable states become tractable as the domain of
integration ($\Omega_i$ in Eq. [eq:DF](#eq:DF)) can be identified in
reduced-dimensionality $\xi$ (see Fig. [fig:FES_idea](#fig:FES_idea)).

A subtle but important point is that free energy surfaces are
low-dimensional representations of the configurational space of a given
molecular system. Each point in $\xi$ collects an ensemble of
configurations that may be energetically distinct but indistinguishable
(or degenerate) at the level of the chosen variable. This degeneracy
directly contributes to the configurational entropy surface $S(\xi)$
(see box
[box:entropy](#box:entropy)).[@gimondi2018building; @dietschreit2023entropy]
If a given $\xi$ value corresponds to many structurally diverse
microstates - thus displaying a large degeneracy - its associated
configurational entropy will be higher. Conversely, if $\xi$ selects a
narrowly defined set of configurations, the entropic contribution will
be smaller, and $F(\xi)$ will more closely follow $U(\xi)$. This effect
is well illustrated in the simple 2D model systems reported in Fig.
[fig:entropy](#fig:entropy)a. Two basins with identical potential energy
can display different free energies when projected onto a single CV if
one basin corresponds to a broader configurational ensemble. In Fig.
[fig:entropy](#fig:entropy)b, the difference in free energy between
metastable states arises entirely from conformational entropy. In
biomolecular and soft-matter contexts, such degeneracy-driven entropy
contributions are crucial; for example, conformational transitions may
be stabilized not by enthalpy, but by the sheer number of accessible
microstates consistent with a specific CV value. Similarly, free energy
barriers can reflect entropic bottlenecks where the accessible volume of
phase space
narrows.[@gimondi2018building; @polino2020collective; @kollias2020role; @leanza2023into; @serse2024unveiling]

```{figure} Figures/Figure_Entropy.png
:name: fig:entropy
:width: \linewidth
(a) Two-dimensional model potential energy surface, $E_P(x,y)$, and corresponding projection on the map variable (x) used to illustrate the decomposition of the free energy surface into energetic and entropic contributions, following Gimondi, Tribello, and Salvalaglio (2018). The potential energy landscape features two basins of comparable depth (A and B) but markedly different widths along the hidden coordinate (y). When the free energy is projected on (x), this degeneracy in the hidden coordinate manifests as an apparent stabilization of basin B due to entropic effects. (b) One-dimensional profiles of the free energy $\Delta F(x)$ (blue), average potential energy $\Delta U(x)$ (red), and entropic term $-T \Delta S(x)$ (green). This decomposition illustrates that, although the two minima have identical potential energies, basin B exhibits a lower free energy because of its greater configurational degeneracy in (y), which increases its entropy. This simple model highlights how projecting a multidimensional energy landscape onto a limited set of collective variables can lead to apparent thermodynamic stabilization arising from hidden entropic contributions. Reproduced with permission from Gimondi and Salavalaglio JCP 2018(Gimondi, Tribello, and Salvalaglio 2018)
```
:::{important}
:icon: false
### Energy--Entropy Decomposition of a Free Energy Surface

The FES $F(\xi)$ maps the thermodynamic potential used to characterize
the thermodynamic stability of molecular configurations mapped onto
$\xi$. By construction, it encapsulates both energetic and entropic
contributions: $F(\xi) = U(\xi) - T S(\xi).$ The internal energy
contribution is obtained as a conditional ensemble average over all
microstates compatible with the value of $\xi$:
$$U(\xi) = \langle U(\mathbf{r}) \rangle_{\xi} =
 \frac{\int d\mathbf{r} U(\mathbf{r}) e^{-\beta U(\mathbf{r})} \delta(\xi(\mathbf{r})-\xi)}{\int d\mathbf{r} e^{-\beta U(\mathbf{r})} \delta(\xi(\mathbf{r})-\xi)}$$
The entropy then follows from: $S(\xi) = T^{-1}(U(\xi) - F(\xi))$.
[]{#box:entropy label="box:entropy"}

:::

## Collective Variables, Order Parameters, and Reaction Coordinates: defining $\xi$[]{#sec:CVs label="sec:CVs"}

The central role of $\xi$ is to provide a reduced representation of the
high-dimensional configuration space that retains the essential ability
to distinguish relevant metastable states, and slow transition modes
between them, for the molecular process of interest
[@kirkwood1935statistical; @frenkel_understanding_2023; @tuckerman2023statistical].
Depending on the field of application, the characteristics of the
studied process, and its own properties, the low-dimensional mapping
$\xi$ can be referred to by different names. The most common are
collective variables (CVs), order parameters (OPs), and reaction
coordinates (RCs) [@henin2022enhanced]. Although these terms overlap
partially and are sometimes used interchangeably by practitioners, they
imply some fundamental distinctions. Clarifying and understanding their
differences is thus crucial for a consistent interpretation of FESs
associated with molecular transformations.

### Collective Variables and Order Parameters

CV is the most general of the three denominations: it is any function of
the atomic coordinates designed to reduce the enormous dimensionality of
a molecular system into a smaller, more interpretable set of
descriptors. To be useful, CVs must distinguish all the relevant
long-lived metastable states involved in a transformation, i.e., the
reactants and the products. In this case, the metastable states of
interest will appear as local maxima in $p(\xi)$, and local minima in
the FES, $F(\xi)$. Typical CVs include simple geometrical descriptors,
such as distances and angles
[@enhanced_sampling_review; @fiorin2013using; @plumed2019promoting; @tribello2025plumed],
as well as more complex functions, including measures of structural
similarity [@pietrucci2009collective] or progress along a path defined
by a set of reference structures [@branduardi2007b]. It should be noted
that CVs do not necessarily require a direct physical interpretation,
and they can be abstract or highly engineered [@pietrucci2011graph]. For
instance, combinations of distances, angles, or latent variables from
dimensionality-reduction algorithms can be effective CVs by allowing for
a clear distinction between metastable states [@tribello2014plumed],
while losing a direct physical interpretability (see an extended
discussion in section [sec:MLCVs](#sec:MLCVs)). OPs are a specific type
of CV introduced in statistical mechanics to distinguish between
different thermodynamic phases or states of matter
[@neha2022collective; @desgranges2025deciphering; @Giberti2015]. OPs
typically reflect a symmetry-breaking or structural feature that changes
qualitatively at a phase transition---for example, density in
liquid--gas coexistence, orientational alignment in liquid crystals, and
roto-translational invariance in crystalline systems
[@Steinhardt1983; @tribello2017analyzing; @Gimondi_2017; @piaggi2019calculation].
Although OPs are often used to obtain a global description of an
atomistic system, they are typically constructed from local
contributions within well-defined atomic environments
[@lechner2008accurate; @bartok2013representing; @piaggi2017entropy; @Giberti2015; @caruso2025classification].
When dealing with characterising the state of molecular solids, OPs
based on measures of similarity between distributions capturing the
translational, orientational, and conformational order are particularly
effective [@gobbo2018nucleation; @gimondi2018co; @francia2020systematic]

### Reaction Coordinates

A RC implies a further specialisation: it is a low-dimensional
descriptor intended to capture the progress of *the* most probable
transition pathway between reactants and products. An ideal RC is not
only correlated with the transition but also uniquely parameterizes the
progress of the reaction and identifies the transition state
ensemble[@vanden2006transition; @peters2006obtaining; @Peters_2017]. In
practice, RCs represent the collective coordinate along which the
*committor probability* (see Box below) depends most strongly. An
important point to note is that, when (a combination of) CVs provide a
good approximation of the RC for a given physical transformation, saddle
points in $F(\xi)$ correspond to the projection of the transition state
ensemble of configurations associated with a given transformation and
its associated committor probability is narrowly distributed around
$\frac{1}{2}$.

:::{important}
:icon: false
### The Committor Function

The committor function $p_B(x)$ provides the most rigorous and general
definition of a reaction coordinate, for a system that can evolve from
an initial state A to a final state B, $p_B(x)$ is defined as the
probability that a trajectory initiated at configuration (x), with
momenta drawn from the equilibrium (usually Maxwell--Boltzmann)
distribution, will reach B before returning to A. By construction, the
committor satisfies $p_A(x) + p_B(x) = 1$, and identifies the transition
state ensemble as the isosurface where $p_B = 1/2$. In the ideal limit,
iso-committor surfaces partition configuration space into basins of
attraction that correspond precisely to metastable states, providing a
unique, dynamical definition of "progress along the reaction". Unlike
heuristic collective variables, the committor is both necessary and
sufficient to determine kinetic observables such as rate constants or
reactive fluxes, as formalized in Transition Path Theory (TPT)
[@vanden2006transition]. Despite its elegance, the exact committor is
generally inaccessible for high-dimensional systems because evaluating
it requires initiating and propagating a large number of trajectories
from each configuration. Nevertheless, it serves as a theoretical
benchmark against which approximate reaction coordinates can be judged:
a good RC correlates monotonically with $p_B(x)$ and minimizes the
variance of $p_B(x)$ within isosurfaces of the coordinate. In this
sense, the committor defines an optimal projection of dynamics --- any
lower-dimensional representation that preserves the distribution of
committor values across the transition ensemble retains complete kinetic
information [@Geissler1999]. This principle underpins both classical
path-sampling methods (e.g., Transition Path Sampling
[@bolhuis2002transition], Transition Interface Sampling
[@van2005elaborating]) and modern data-driven approaches that seek to
learn effective reaction coordinates from simulation data.
[]{#box:committor label="box:committor"}

:::
:::{important}
:icon: false
### Reaction Coordinates and Collective Variables: Lessons from Ion-Pair Dissociation in Water

The distinction between CVs and RCs is both conceptual and practical.
CVs are low-dimensional functions of the atomic coordinates introduced
to compress the complexity of configuration space into interpretable
descriptors. An RC is a special CV that uniquely parameterizes progress
along a transition pathway, such that the committor probability---i.e.,
the likelihood of reaching a product versus a reactant basin---depends
monotonically on it.

![image](Figures/Figure_GeisslerDellagoChandler.png){width="0.5\\linewidth"}
An early and historically influential example illustrating this
difference is the dissociation of a Na$^+$Cl$^-$ ion pair in water,
investigated by Geissler, Dellago, and Chandler[@geissler1999kinetic].
As shown schematically in the iconic figure from Geissler et al.
[@geissler1999kinetic] reproduced here, two free-energy landscapes
$F(r_{\text{ion}}, q_S)$ with identical projections $F(r_{\text{ion}})$
can correspond to very different transition mechanisms. *(a)* In the
simplest case, the maximum of $F(r_{\text{ion}})$ coincides with the
dividing surface separating stable basins A (associated) and B
(dissociated). Motion across this barrier occurs primarily along
$r_{\text{ion}}$, and a surface $r_{\text{ion}} = r^*$ identifies the
transition state. In this case, $r_{\text{ion}}$ is both a CV and a good
representation of the ion pairing RC. *(b)* In the more realistic case
uncovered by Geissler et al, solvent reorganization introduces an
additional coordinate $q_S$, orthogonal to $r_{\text{ion}}$. Although
$F(r_{\text{ion}})$ appears identical, configurations at
$r_{\text{ion}} = r^*$ belong mainly to either stable basin rather than
the true transition region. In this case, that was uncovered to be
closer to reality by Geissler et al., $r_{\text{ion}}$ remains a good
CV, but it is *not* a good approximation of the ion pairing RC.
[]{#box:ionpairinCV label="box:ionpairinCV"}

:::

### Reaction Coordinates: subtleties and cautionary tales

It is essential to emphasize that, while one is free to construct any
RC, not all are equally beneficial. Essentially, an RC might not be
able, by construction, to pass through the lowest saddle point or
transition state of the system under scrutiny. For simple free energy
landscapes, the accurate determination of the saddle point free energy
is usually enough for the characterization of reaction rates, as the
time spent by the system in non-stationary points has a negligible
influence on the kinetics. This problem, however, is exacerbated in the
case of complex landscapes with multiple, quasi-degenerate saddle
points.

This has profound implications for many methods that enhance the
sampling of rare events, as discussed in
Sec.[sec:Computing](#sec:Computing). In most cases, this issue results
in overestimating free energy barriers. Incidentally, this provides a
variational definition of the \"best\" reaction coordinate as the one
that minimizes the transition state free energy. The relative
populations of reactants and products are, instead, largely unaffected
by the choice of the RC, provided that it connects the two states. This
might not always be self-evident, especially when the RC is complex
enough, as in the case of puckering coordinates in ring flip transitions
[@sega2009calculation].

One should also carefully consider assumptions of local equilibrium at
transition states and how they affect the determination of, for example,
kinetic properties. Kramer's theory is a perfect example of this, as the
process of crossing a free energy barrier is modeled under the
requirements of local equilibrium both in the reagents/product free
energy minima, as well as in the saddle point of the transition state.
In other words, all the degrees of freedom that are orthogonal to the
reaction coordinate are required to be ergodically sampling their
subspace [@hanggi_reaction-rate_1990]. A beautiful example illustrating
one case where this condition is not satisfied is the translocation of a
polymer through a narrow pore [@gauthier2009nondriven], as the
relaxation of the slowest Rouse modes of the chain occurs on a
comparable timescale, albeit still shorter, than the translocation
itself. In this case, the polymer is never at equilibrium, no matter
which RC is chosen to describe the translocation. In this case, an
unbiased simulation would necessarily yield a different value for the
free energy barrier as extracted from a probability histogram than, for
example, a potential of mean force calculation.

## Position-dependent compression of configuration space: Geometric Free Energy Surface {#sec:Geometric}

When a free energy profile is expressed along a curvilinear reaction
coordinate, geometric contributions naturally appear. For instance, in
the case of a distance coordinate, the probability density scales with
the measure of the corresponding hyperspherical shell, leading to an
entropic term in the associated potential of mean force. This
contribution is not specific to any interaction but arises purely from
the geometry of configuration space. It reflects the fact that a single
value of a coordinate might not necessarily correspond to a macroscopic,
identifiable state.

### Potential of Mean Force and the role of the metric

The potential of mean
force[@onsager1933theories; @kirkwood_statistical_1949] formalizes the
idea that an effective two-body potential could describe many-body
correlations averaged over solvent and other particles. The probability
density $P(\xi)$ of a RC $\xi(\mathbf r)$ to have a specific value $\xi$
is
$$p(\xi)=\frac{1}{Q}\int d\mathbf r\,\delta\big(\xi(\mathbf r)-\xi\big)e^{-\beta U(\mathbf r)},$$
and the PMF with respect to a reference $\xi_0$ is
$$w(\xi)=-kT\ln P(\xi)+w(\xi_0)$$

### Intuitive view:

when the potential $U=0$, the PMF should be uniform and the probability
of finding the system in a region of configuration space must be
proportional to the accessible volume. For the distance $r$ between two
particles, the probability scales with the volume of the spherical shell
$4\pi r^{2} dr$. This motivates the definition of the PMF from the
radial probability density, $$P(r) \propto 4\pi r^{2}e^{-\beta w(r)},
\qquad
w(r)=-kT\ln \left[ P(r)/ 4 \pi r^2\right] +\mathrm{const}.$$ The extra
term $kT\ln(4\pi r^2)$ is therefore entropic, reflecting the growing
number of configurations at larger separations.

### Which probability?

One may ask whether to define probabilities directly in terms of $w$ or
to include geometric factors "by hand". The rigorous answer is that the
correct measure is determined by marginalizing the full phase--space
density. In generalized coordinates $\mathbf{q}$ with conjugate momenta
$\mathbf{p}$, the canonical distribution is [@gibbs1906scientific]
$$P(\mathbf{q},\mathbf{p})\propto e^{-\beta \left[ \frac{1}{2} \mathbf{p}^t M^{-1}(\mathbf{q})\mathbf{p} + U(\mathbf{q})\right]},$$
with the mass--metric tensor
$M(\mathbf{q})=J(\mathbf{q})^t m J(\mathbf{q})$, where $J$ is the
Jacobian of the transformation from Cartesian to generalized coordinates
and $m$ the diagonal matrix with the atomic masses. Integrating out
momenta via a Gaussian integral gives
$$\int d\mathbf{p} e^{-\frac{1}{2}\beta \mathbf{p}^tM^{-1}\mathbf{p}}
= (2\pi kT)^{n/2}\sqrt{\det M(\mathbf{q})},$$ so that the
configurational probability is
$$P(\mathbf{q})\propto \sqrt{\det M(\mathbf{q}) } e^{-\beta U(\mathbf{q})}.$$
If the masses are all equal, they factorize out, and instead of $M$, the
metric factor $g = J_\mathbf{q}^t J_\mathbf{q}$ is used, where
$\sqrt{\det g} = \vol{J_\mathbf{q}}$ is the volume element. For
spherical coordinates of a relative vector,
$\sqrt{\det g}=r^{2}\sin\theta$, and for an isotropic environment,
integrating over the solid angle one recovers the intuitive result.

## Free Energy Barriers and Generalised Transition State Theory[]{#sec:kinetics label="sec:kinetics"}

Once a suitable RC $\xi(\mathbf{r})$ is defined, the free energy surface
$F(\xi) = -kT \ln p(\xi)$ quantifies the reversible work required to
bring the system to a configuration of progress $\xi$. Minima of
$F(\xi)$ identify metastable states (reactants, products), while the
maximum along the minimum free-energy path defines the transition state
at $\xi^\ddagger$. The corresponding free energy difference
$$\Delta F_\xi^{\ddagger} = F(\xi^\ddagger) - F(\xi_\mathrm{R})$$
represents the free energy barrier that the system must overcome to
transform from reactants to products, thus opening the door to a kinetic
interpretation of the free energy surface.

The *generalised transition-state theory* (TST) provides a direct link
between this thermodynamic picture and the kinetics of rare events. In
its most general form, TST expresses the rate constant as the thermal
average of the flux through a dividing surface in configuration space:
$$k_{\mathrm{TST}} =
\underbrace{\frac{1}{2}\langle|\dot{\xi}|\rangle_{\xi^\ddagger}}_{\text{kinetic prefactor}}
\,
\underbrace{\exp[-\beta{\Delta F_\xi^{\ddagger}}]}_{\text{Boltzmann factor}} 
\label{eq:TSTPeters}$$

This compact expression highlights two essential components: a kinetic
prefactor, representing the average rate at which trajectories cross the
dividing surface, and a Boltzmann factor giving the equilibrium
probability of reaching the transition state. This formulation is
entirely general and applies to any free-energy landscape computed from
molecular simulation. The prefactor accounts for the rate at which
configurations cross the transition-state surface, while the exponential
term represents the equilibrium probability of reaching that surface
from the reactant basin.

This formulation follows naturally from the flux--over--population
formalism described in Hänggi, Talkner, and Borkovec's seminal
review[@hanggi_reaction-rate_1990]. There, the rate of barrier crossing
is expressed as the ratio of a stationary reactive flux $J$ to the
reactant population $n_\mathrm{R}$:
$$k = \frac{J}{n_\mathrm{R}} = \frac{\int \dot{\xi}\, \delta(\xi-\xi^\ddagger)\, \Theta(\dot{\xi})\, e^{-\beta H(\mathbf{r},\mathbf{p})} \, d\mathbf{r}\,d\mathbf{p}}{\int_{\xi < \xi^\ddagger} e^{-\beta H(\mathbf{r}\,\mathbf{p})} \, d\mathbf{r}\,d\mathbf{p}} 
\label{eq:TSTHanggi}$$ where $\delta(\xi - \xi^\ddagger)$ selects
configurations located precisely on the dividing surface
($\xi = \xi^\ddagger$), ensuring that only configurations at the
transition state contribute to the flux. $\Theta(\dot{\xi})$ is a
Heaviside step function, which filters out backward trajectories
($\dot{\xi}<0$) and retains only forward crossings ($\dot{\xi}>0$),
i.e., transitions that move from reactants toward products. Finally,
$e^{-\beta H(\mathbf{r},\mathbf{p})}$ is the Boltzmann factor weighting
each phase-space point by its equilibrium probability.

Assuming that all degrees of freedom orthogonal to $\xi$ are
equilibrated on both sides of the dividing surface, Eq.
[eq:TSTHanggi](#eq:TSTHanggi) simplifies to Eq.
[eq:TSTPeters](#eq:TSTPeters), thus connecting the exponential Boltzmann
term rate constant directly to the free-energy profile $F(\xi)$.

The appeal of this generalised TST framework lies in its compatibility
with free-energy surfaces obtained from molecular simulations. Any
method capable of computing $F(\xi)$ (see Sec.
[sec:Computing](#sec:Computing)) provides the necessary thermodynamic
ingredient to estimate kinetic rates. The exponential term in Eq.
[eq:TSTPeters](#eq:TSTPeters) is directly obtained from the simulation,
while the prefactor can be evaluated from the mean thermal velocity
along $\xi$. Equation [eq:TSTPeters](#eq:TSTPeters) can be further
simplified when the reaction coordinate properly identifies the dynamic
bottleneck. In that case, local equilibrium at the transition state
allows one to replace the prefactor with the universal Eyring
expression,
$$k_{\mathrm{TST}} = \frac{kT}{h}\, e^{-\beta \Delta F_\xi^{\ddagger}}\,
\label{eq:kTST}$$ which emerges naturally from the separation of time
scales between fast intrabasin equilibration and slow barrier crossing.
This classical form implicitly assumes harmonic free-energy wells and a
single dominant saddle point---conditions that may break down in
condensed-phase reactions, diffusion-limited processes, or
solvent-controlled kinetics. Deviations from this ideal behaviour can be
captured by introducing a *transmission coefficient* $\kappa$,
accounting for dynamic recrossings and frictional damping:
$k = \kappa\,k_{\mathrm{TST}},\quad 0 < \kappa \leq 1$, so that the rate
from transition state theory result is always larger than the real
rate[@hanggi_reaction-rate_1990].

# References
