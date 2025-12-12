## FESs from experiments: single molecule force spectroscopy[]{#sec:single-molecule-spectroscopy label="sec:single-molecule-spectroscopy"}

The development of single-molecule force spectroscopy (SMFS) techniques,
such as atomic force microscopy (AFM), optical, or magnetic tweezers,
has opened up the possibility of directly probing molecular free-energy
landscapes experimentally. In these setups, a molecule or macromolecular
complex is tethered between a surface and a microscopic probe, which
applies a controlled force or displacement while recording the
corresponding extension and work performed on the system. The reaction
coordinate $\xi$ in this case is naturally associated with the molecular
extension $q$ along the pulling direction. The mechanical response of
the molecule encodes the underlying PMF $F(q)$, which can be
reconstructed from nonequilibrium work measurements using exact
statistical-mechanical relations.

A central theoretical foundation of this connection is Jarzynski's
equality, which relates nonequilibrium work to equilibrium free-energy
differences: $$e^{-\beta \Delta G(t)} =
\left\langle e^{-\beta W(t)} \right\rangle ,
\label{eq:Jarzynski}$$ where $W(t)$ is the external work performed along
the pulling trajectory, and $\langle \dots \rangle$ denotes an average
over many repetitions of the process. Remarkably, Eq.
[eq:Jarzynski](#eq:Jarzynski) holds even for transformations driven
arbitrarily far from equilibrium, providing a formal bridge between
dynamical experiments and equilibrium thermodynamics. Hummer and Szabo
[@hummer2005free] extended this result to the reconstruction of a full
free-energy profiles along the molecular extension coordinate (q),
obtaining $$e^{-\beta G_0(q)} =
\left\langle
\delta[q - q(x(t))]  e^{-\beta [W(t) - V(q(t),t)]}
\right\rangle ,
\label{eq:HummerSzabo}$$ where $V(q,t)$ is the time-dependent external
potential applied during pulling. For instance, in optical-tweezer or
AFM experiments, a harmonic trap of stiffness $k_s$ is displaced at
constant velocity $v$, $V(q,t)=\tfrac12 k_s(q-vt)^2$.

Equation [eq:HummerSzabo](#eq:HummerSzabo) thus provides an operational
route to obtain the equilibrium free-energy profile $F_0(q)$ from a
collection of nonequilibrium pulling trajectories. If the pulling
protocol is adiabatic---meaning it is so slow that the system remains at
equilibrium---then the mechanical work (W) equals the reversible work
$\Delta F$. The trap potential is effectively infinitely stiff. In this
quasistatic limit, the molecular coordinate follows the minimum of the
trap potential. In practice, experiments are rarely perfectly
quasistatic, and Eq. [eq:HummerSzabo](#eq:HummerSzabo) must be applied
in its complete nonequilibrium form. The stochastic dispersion of
measured work values---arising from thermal fluctuations, instrumental
noise, and molecular heterogeneity---requires averaging over a large
number of trajectories or the use of maximum-likelihood estimators to
converge the exponential average in Eq.
[eq:HummerSzabo](#eq:HummerSzabo). Despite these challenges, pioneering
work by Liphardt et al. [@liphardt2002equilibrium] provided the first
quantitative experimental validation of Jarzynski's equality by
unfolding single RNA hairpins with optical tweezers, demonstrating that
nonequilibrium pulling data can reproduce equilibrium free-energy
differences with sub-$kT$ accuracy.

Modern SMFS now routinely maps multidimensional free-energy landscapes
of biomolecules, synthetic polymers, and supramolecular assemblies. The
measured work distributions can be directly compared to simulations
using steered molecular dynamics (SMD) and fast-growth thermodynamic
integration, where analogous pulling protocols are applied
computationally. Such combined experimental--computational analyses
enable the identification of metastable intermediates and hidden
barriers, providing a quantitative picture of molecular stability and
kinetics under mechanical stress.

In this sense, single-molecule pulling experiments extend the conceptual
framework of free-energy surface reconstruction beyond the realm of
simulations. By exploiting nonequilibrium work theorems, they offer a
direct, experimentally accessible analogue to biased-sampling approaches
such as umbrella sampling or metadynamics, allowing one to read and
interpret molecular free-energy surfaces from the controlled deformation
of single molecules.

# References
