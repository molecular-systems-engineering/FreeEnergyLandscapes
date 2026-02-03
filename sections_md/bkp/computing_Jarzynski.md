(fess-from-experiments-single-molecule-force-spectroscopy)=
# FESs from experiments: single molecule force spectroscopy

Single-molecule force spectroscopy (SMFS) methods---such as AFM and
optical or magnetic tweezers---enable experimental probing of molecular
free-energy landscapes. A molecule is stretched between a surface and a
probe applying controlled force or displacement, with the extension $s$
serving as the reaction coordinate. The resulting mechanical response
encodes the potential of mean force $F(s)$, recoverable from
nonequilibrium work measurements via statistical--mechanical relations.
A central theoretical foundation of this connection is Jarzynski's
equality [@jarzynski1997nonequilibrium], which relates nonequilibrium work to
equilibrium free-energy differences: $$e^{-\beta \Delta G(t)} =
\left\langle e^{-\beta W(t)} \right\rangle ,
\label{eq:Jarzynski}$$ where $W(t)$ is the external work performed along
the pulling trajectory, and $\langle \dots \rangle$ denotes an average
over many repetitions of the process. Remarkably, Eq.
[eq:Jarzynski](#eq:Jarzynski) holds even for transformations driven
arbitrarily far from equilibrium, providing a formal bridge between
dynamical experiments and equilibrium thermodynamics. Hummer and Szabo [@hummer_free_2005], extended this result to the reconstruction of a full free-energy profile along the molecular extension coordinate $s$,
obtaining $$e^{-\beta F_0(s)} =
\left\langle
\delta[s - s(x(t))]  e^{-\beta [W(t) - V(s(t),t)]}
\right\rangle ,
\label{eq:HummerSzabo}$$ where $V(s,t)$ is the time-dependent external
potential applied during pulling. For instance, in optical-tweezer or AFM experiments, a harmonic trap of stiffness $k_s$ is displaced at constant velocity $v$, $V(s,t)=\tfrac12 k_s(s-vt)^2$.

Equation [eq:HummerSzabo](#eq:HummerSzabo) enables reconstruction of the
equilibrium free-energy profile $F_0(s)$ from nonequilibrium pulling
trajectories. In the adiabatic limit, the work $W$ equals the reversible
$\Delta F$, but real experiments require averaging over many
trajectories to account for stochastic fluctuations. Liphardt et al. [@liphardt2002equilibrium] first validated this approach, showing RNA
hairpin unfolding reproduced equilibrium free energies with sub-$kT$ accuracy. These combined experimental--computational approaches reveal
intermediates and barriers, extending free-energy surface reconstruction into the experimental domain through nonequilibrium work theorems.

