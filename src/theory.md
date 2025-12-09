::: marginnote
:::

## Thermodynamic Potentials and Partition Functions

In the canonical ensemble, which describes a system at constant number
of particles (\\(N\\)), volume (\\(V\\)), and temperature (\\(T\\)), the probability
density \\(f(\mathbf{r}, \mathbf{p})\\) of finding the system in a
particular *microstate* characterized by the 6-N dimensional phase space
vector of atomic (Cartesian, for simplicity) coordinates and momenta
\\(\Gamma = (\mathbf{r},\mathbf{p})\\) is proportional to the Boltzmann
factor \\(e^{-\beta H(\mathbf{x},\mathbf{p})}\\), which measures the total
energy of the microstate, expressed by the Hamiltonian \\(H\\), in units of
the thermal energy \\(kT = 1/\beta\\), \\(k\\) being the Boltzmann constant and
\\(T\\) the absolute
temperature.[@chandler1978statistical; @frenkel_understanding_2023; @tuckerman2023statistical]

The normalization constant of the phase-space density
\\(f(\mathbf{r}, \mathbf{p})\\) is the *partition function* - \\(Z\\) - which
is, in essence, a (Boltzmann-weighted) count of the number of accessible
microstates and enables a direct connection between molecular
configurations (i.e., realizations of \\(\mathbf{r}, \mathbf{p}\\)), and
thermodynamic concepts familiar to an engineering audience.

The partition function in the canonical ensemble for a system of \\(N\\)
identical particles is written as:
\\[Z_{NVT} = \frac{1}{N!\,h^{3N}}\int d\Gamma e^{-\beta H(\Gamma)}.
\label{eq:partitionNVT}\\] The normalisation factor \\({N!\,h^{3N}}\\)
includes two inherently quantum-mechanical terms: the factorial of the
number of particles \\(N!\\) and the \\(N\\)-th power of Planck's constant \\(h\\).
The former factor takes into account the permutations of identical
particles. It is necessary, even if particles are classical, to recover
an extensive entropy and avoid mixing entropy (Gibbs)
paradoxes[@noyes1961entropy; @frenkel_understanding_2023; @tuckerman2023statistical].
At the same time, the latter is a measure of the minimum phase space
volume set by the intedermination principle and recovers the
Sackur-Tetrode entropy of the ideal gas[@Huang].

If the Hamiltonian can be written as the sum of independent potential
and kinetic terms, \\(H(\Gamma) = U(\mathbf{r}) +K(\mathbf{p})\\), momenta
can be integrated out and the partition function can be expressed in
terms of the configurational integral (also called configurational
partition function) \\(Q_{NVT}\\), as \\[Z_{NVT}
=\frac{1}{N!\,\Lambda^{3N}}\,Q_{NVT},\\] with
\\[Q_{NVT} = \int d\mathbf{r} e^{-\beta U(\mathbf{r})}\\] and
\\(\Lambda = h/\sqrt{2\pi m kT}\\) is the thermal wavelength for particles
of mass \\(m\\).

::: textbox
### Z or Q?

There is often confusion about which symbol refers to the full partition
function, and which to the configurational one, and for good reasons!
While IUPAC[@brett2023quantities]lists both \\(Z\\) and \\(Q\\) as possible
symbols for the partition function, without specifying whether it is the
full or the configurational one, classic textbooks including
Huang[@Huang], Frenkel and Smit[@frenkel_understanding_2023], and Allen
and Tildesley[@allen2017computer], use \\(Q\\) for the full partition
function, while Rowlinson and Widom[@rowlinson2002molecular],
Kittel[@kittel2004elementary] and Landau and Lifshitz[@landau5] use \\(Z\\).
Here, we follow the latter convention.
:::

The configuration (marginal) probability density function is in this
case [@tuckerman2023statistical]:
\\[f(\mathbf{r}) = \frac{e^{-\beta U(\mathbf{r})}}{Q_{NVT}} = \frac{e^{-\beta U(\mathbf{r})}}{\int d\mathbf{r} e^{-\beta U(\mathbf{r})}}\\]

### From Partition Functions to Thermodynamic Potentials

The partition function \\(Z\\) is a central quantity because it encodes all
the thermodynamic information of the system in this ensemble. In
particular, the thermodynamic potential for the canonical ensemble, or
Helmholtz free energy, \\(A\\), can be written as: \\[A = -kT \ln Z_{NVT},\\]
or, in terms of the configuration integral,
\\[A = -kT \ln Q_{NVT}  + kT\ln\left( N!\Lambda^{3N}\right), 
\label{eq:FE}\\] where the first term on the right-hand side is the
configurational free energy and the second one the translational free
energy. Other thermodynamic quantities (that is, quantities that depend
on the macroscopic control parameters \\(N,V,T\\) only) can then be computed
as derivatives of \\(A_{NVT}\\). Other statistical ensembles can be derived,
for instance---but not necessarily---from the canonical ensemble through
a Legendre transformation with respect to one control variable. This
operation yields a new distribution function that corresponds to the
Laplace transform of the original one. In what follows, we use the
symbol \\(F\\) to refer to the free energy or thermodynamic potential
without connection to an ensemble in particular. The specific meaning of
\\(F\\) ---whether Helmholtz or Gibbs free energy--- depends on the
statistical ensemble used to generate the molecular samples used to
compute free energy surfaces as discussed in Section
[\[sec:Computing\]](#sec:Computing){reference-type="ref"
reference="sec:Computing"}.

::: marginnote
The isothermal--isobaric partition function is related to the canonical
partition function via [@tuckerman2023statistical]:
\\(\Delta_{NPT}=\int_0^\infty dV\, e^{-\beta PV}\, Z_{NVT}\\) []{#note:NPT
label="note:NPT"}
:::

### From Thermodynamic Potential to Free Energy Differences

Now, let us consider two disconnected regions of the phase space,
\\(\Omega_i\\) and \\(\Omega_j\\), representing two sets of microstates
associated with two distinct states of the system, \\(i\\) and \\(j\\). Such
ensembles of configurations could correspond to the reactants and
products of a chemical reaction, two different phases of the same
substance, the unfolded and folded configurations of a biopolymer,
etc.). By integrating the normalised canonical phase space distribution
within \\(\Omega_i\\) (or \\(\Omega_i\\)), one can obtain the equilibrium
probability to observe the system in state \\(i\\) (or \\(j\\)), or have access
to the free energy difference between the two states:

\\[\Delta{F}\_{i\rightarrow\,j}=- kT\ln\left[{\frac{\int {\mathbf{1}\_{\mathbf{r}\in{\Omega\_j}}f(\mathbf{r})}d\mathbf{r}}{\int {\mathbf{1}\_{\mathbf{r}\in{\Omega\_i}}f(\mathbf{r})}d\mathbf{r}}}\right] \\]

where \\(\mathbf{1}_{\mathbf{r}\in{i,j}}\\) is an indicator function that
selects only microstates belonging to a given state, for example, state
\\(i\\), and \\(\int
{\mathbf{1}_{\mathbf{r}\in{\Omega_i}}f(\mathbf{r})}d\mathbf{r}=P_{i}\\),
is the equilibrium probability of said state \\(i\\).

![From microscopic configurations to the free energy surface. Each
molecular configuration (\\(\mathbf{r}_i \in \mathbf{R}^{3N}\\), where \\(N\\)
is the number of atoms) is mapped to a point in a reduced, low
dimensional space of collective variables
(\\(\xi(\mathbf{r}) \in \mathbf{R}^m\\)), with \\(m \ll 3N\\). In the following,
to favour readability, we indicate \\(\xi\\) as a scalar; however, its
dimensionality can be higher than one, and extensions to higher
dimensionality are
straightforward[@laio2002escaping; @kastner2011umbrella]. The marginal
equilibrium probability \\(p(\xi)\\), which quantifies the relative
likelihood of observing configurations consistent with a given value of
\\(\xi=[\xi_1,\xi_2]\\). The corresponding free energy surface
\\(F(\xi) = -kT \ln (\xi) + C\\) provides a readable map of thermodynamic
stability and metastability in configuration space. Basins A and B
correspond to metastable states separated by a free energy
barrier.](Figures/Figure_FES_concept.png){#fig:FES_idea
width="1.2\\linewidth"}

## Free Energy Surfaces: readable maps of the thermodynamic potential

The evaluation of the equilibrium probabilities \\(P_{i,j}\\) requires
defining the indicator function \\(\int
{\mathbf{1}_{\mathbf{r}\in{i}}f(\mathbf{r})}d\mathbf{r}\\), which
pinpoints configurations belonging to \\(\Omega_{i,j}\\). Given the inherent
high dimensionality of \\(\mathbf{r}\\), this is far from being a trivial
task, and can be achieved by introducing a suitable low-dimensional
function \\(\xi(\mathbf{r})\\) that maps microstates (specific realizations
of the coordinates vector \\(\mathbf{r}\\)) belonging to the same macrostate
close to one another.

The introduction of \\(\xi(\mathbf{r})\\) allows to define the marginal
equilibrium probability \\(p(\xi)\\) as
[@kirkwood1935statistical; @tuckerman2023statistical; @frenkel_understanding_2023]:
\\[p(\xi)=Q^{-1}\int{f(\mathbf{r})\delta({\xi^\prime({\mathbf{r}})-\xi})d\mathbf{r}}
\label{eq:marginal-prob}\\] where \\(p(\xi)\\) is the equilibrium probability
of the ensemble of microstates mapping to the same value of
\\(\xi(\mathbf{r})\\). In this context, \\(p(\xi)\\) can be interpreted as the
partition function associated with all the microstates mapped in
\\(p(\xi)\\).

In analogy with Eq.[\[eq:FE\]](#eq:FE){reference-type="ref"
reference="eq:FE"} we can therefore define a free energy for every \\(\xi\\)
as: \\[F(\xi)=-kT\ln{p(\xi)}+C
\label{eq:FES}\\] where \\(F(\xi)\\) is the FES, and \\(C\\) is an arbitrary
constant, indicating that \\(F(\xi)\\) is a measure of *relative*
thermodynamic stability between ensembles of states that map to
different values of \\(\xi\\).

Mapping configurations onto a physically meaningful \\(\xi\\) such that,
i.e., it captures slow transitions in the configurational ensemble (see
Section [\[sec:CVs\]](#sec:CVs){reference-type="ref"
reference="sec:CVs"}), renders the features of \\(F(\xi)\\) informative. For
instance, for a good choice of \\(\xi\\), metastable states correspond to
local minima in \\(F(\xi)\\). As a consequence, free energy differences
between metastable states become tractable as the domain of integration
(\\(\Omega_i\\) in Eq. [\[eq:DF\]](#eq:DF){reference-type="ref"
reference="eq:DF"}) can be identified in reduced-dimensionality \\(\xi\\)
(see Fig. [1](#fig:FES_idea){reference-type="ref"
reference="fig:FES_idea"}).

A subtle but important point is that free energy surfaces are
low-dimensional representations of the configurational space of a given
molecular system. Each point in \\(\xi\\) collects an ensemble of
configurations that may be energetically distinct but indistinguishable
(or degenerate) at the level of the chosen variable. This degeneracy
directly contributes to the configurational entropy surface \\(S(\xi)\\)
(see box [\[box:entropy\]](#box:entropy){reference-type="ref"
reference="box:entropy"}).[@gimondi2018building; @dietschreit2023entropy]
If a given \\(\xi\\) value corresponds to many structurally diverse
microstates - thus displaying a large degeneracy - its associated
configurational entropy will be higher. Conversely, if \\(\xi\\) selects a
narrowly defined set of configurations, the entropic contribution will
be smaller, and \\(F(\xi)\\) will more closely follow \\(U(\xi)\\). This effect
is well illustrated in the simple 2D model systems reported in Fig.
[2](#fig:entropy){reference-type="ref" reference="fig:entropy"}a. Two
basins with identical potential energy can display different free
energies when projected onto a single CV if one basin corresponds to a
broader configurational ensemble. In Fig.
[2](#fig:entropy){reference-type="ref" reference="fig:entropy"}b, the
difference in free energy between metastable states arises entirely from
conformational entropy. In biomolecular and soft-matter contexts, such
degeneracy-driven entropy contributions are crucial; for example,
conformational transitions may be stabilized not by enthalpy, but by the
sheer number of accessible microstates consistent with a specific CV
value. Similarly, free energy barriers can reflect entropic bottlenecks
where the accessible volume of phase space
narrows.[@gimondi2018building; @polino2020collective; @kollias2020role; @leanza2023into; @serse2024unveiling]

![(a) Two-dimensional model potential energy surface, \\(E_P(x,y)\\), and
corresponding projection on the map variable (x) used to illustrate the
decomposition of the free energy surface into energetic and entropic
contributions, following Gimondi, Tribello, and Salvalaglio (2018). The
potential energy landscape features two basins of comparable depth (A
and B) but markedly different widths along the hidden coordinate (y).
When the free energy is projected on (x), this degeneracy in the hidden
coordinate manifests as an apparent stabilization of basin B due to
entropic effects. (b) One-dimensional profiles of the free energy
\\(\Delta F(x)\\) (blue), average potential energy \\(\Delta U(x)\\) (red), and
entropic term \\(-T \Delta S(x)\\) (green). This decomposition illustrates
that, although the two minima have identical potential energies, basin B
exhibits a lower free energy because of its greater configurational
degeneracy in (y), which increases its entropy. This simple model
highlights how projecting a multidimensional energy landscape onto a
limited set of collective variables can lead to apparent thermodynamic
stabilization arising from hidden entropic contributions. Reproduced
with permission from Gimondi and Salavalaglio JCP
2018[@gimondi2018building]](Figures/Figure_Entropy.png){#fig:entropy
width="\\linewidth"}

::: textbox
### Energy--Entropy Decomposition of a Free Energy Surface

The FES \\(F(\xi)\\) maps the thermodynamic potential used to characterize
the thermodynamic stability of molecular configurations mapped onto
\\(\xi\\). By construction, it encapsulates both energetic and entropic
contributions: \\(F(\xi) = U(\xi) - T S(\xi).\\) The internal energy
contribution is obtained as a conditional ensemble average over all
microstates compatible with the value of \\(\xi\\):
\\[U(\xi) = \langle U(\mathbf{r}) \rangle_{\xi} =
 \frac{\int d\mathbf{r} U(\mathbf{r}) e^{-\beta U(\mathbf{r})} \delta(\xi(\mathbf{r})-\xi)}{\int d\mathbf{r} e^{-\beta U(\mathbf{r})} \delta(\xi(\mathbf{r})-\xi)}\\]
The entropy then follows from: \\(S(\xi) = T^{-1}(U(\xi) - F(\xi))\\).
[]{#box:entropy label="box:entropy"}
:::
