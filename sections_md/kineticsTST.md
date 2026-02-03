(free-energy-barriers-and-generalised-transition-state-theory)=
# Free Energy Barriers and Generalised Transition State Theory

Once a suitable RC $\xi(\mathbf{r})$ is defined, the free energy surface
$F(\xi) = -kT \ln p(\xi)$ quantifies the reversible work required to
bring the system to a configuration of progress $\xi$. Minima of
$F(\xi)$ identify metastable states (reactants, products), while the
maximum along the minimum free-energy path defines the transition state
at $\xi^\ddagger$. The corresponding free energy difference
$$\Delta F_\xi^{\ddagger} = F(\xi^\ddagger) - F(\xi_\mathrm{R})$$
represents the free energy barrier that the system must overcome to
transform from reactants to products, thus opening the door to a kinetic
interpretation of the free energy surface. The *generalised
transition-state theory* (TST) links thermodynamics and kinetics by
expressing the rate constant as the thermal average of the flux through
a dividing surface in configuration space: 

$$
k_{\mathrm{TST}} =
\underbrace{\frac{1}{2}\langle|\dot{\xi}|\rangle_{\xi^\ddagger}}_{\text{kinetic prefactor}}
\underbrace{\exp[-\beta{\Delta F_\xi^{\ddagger}}]}_{\text{Boltzmann factor}} 
\label{eq:TSTPeters}
$$ 

The prefactor represents the average crossing
velocity, while the Boltzmann factor gives the equilibrium probability
of reaching the transition state. This form follows from the
flux--over--population formalism of Hänggi, Talkner, and
Borkovec(Hänggi, Talkner, and Borkovec 1990), where the rate of barrier
crossing is the ratio of the reactive flux $J$ to the reactant
population $n_\mathrm{R}$,
$$k = \frac{J}{n_\mathrm{R}} = \frac{\int \dot{\xi}  \delta(\xi-\xi^\ddagger)  \Theta(\dot{\xi})  e^{-\beta H(\mathbf{r},\mathbf{p})}   d\mathbf{r} d\mathbf{p}}{\int_{\xi < \xi^\ddagger} e^{-\beta H(\mathbf{r},\mathbf{p})}   d\mathbf{r} d\mathbf{p}}.
\label{eq:TSTHanggi}$$ Here $\delta(\xi-\xi^\ddagger)$ selects
configurations on the dividing surface, $\Theta(\dot{\xi})$ retains
forward crossings, and $e^{-\beta H}$ is the Boltzmann weight. Assuming
equilibration of degrees of freedom orthogonal to $\xi$,
Eq. [eq:TSTHanggi](#eq:TSTHanggi) reduces to
Eq. [eq:TSTPeters](#eq:TSTPeters), linking the rate constant directly to
the free-energy profile $F(\xi)$ obtainable with the methods discussed
in Sec. [sec:Computing](#sec:Computing). The exponential term is
obtained from the simulation, while the prefactor follows from the mean
thermal velocity along $\xi$. The TST formula does not consider barrier
recrossing; these are fully included in approaches like the
Bennett-Chandler reactive flux(Bennett, n.d.; Chandler 1978)
$$k_{BC}(t) = \frac{\langle \dot{\xi}(0)  \delta[\xi(0)-\xi^\ddagger]  h_B[\xi(t)]\rangle}
{\langle h_A \rangle},$$ where $h_A$ and $h_B$ are characteristic
functions identifying reactants and products, and the rate $k$ is
obtained from the plateau value of $k_{BC}(t)$. This formula and its
successive improvements(Ruiz-Montero, Frenkel, and Brey 1997) require an
accurate sampling of the transition state and are limited by the
necessity to locate it and the assumption of its uniqueness. Where this
is not true (Vanden-Eijnden 2006; Vanden-Eijnden et al. 2010), the
bundle of transition paths must be sampled, as discussed in Section
[sec:tps](#sec:tps).

# References
