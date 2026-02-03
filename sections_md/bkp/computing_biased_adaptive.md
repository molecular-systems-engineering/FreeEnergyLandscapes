(sec:metadynamics)=
# Adaptive Bias Methods: Metadynamics and derived methods

A key ingredient of US is the use of a fixed set of windows chosen a
priori, with convergence depending on their overlap. A complementary
class of methods instead builds the bias adaptively as the simulation
progresses. Metadynamics (MetaD), introduced by Laio and Parrinello
(Laio and Parrinello 2002), is one of the most influential adaptive-bias
algorithms for reconstructing FESs (Barducci, Bonomi, and Parrinello
2011; Laio and Parrinello 2002; Bussi and Laio 2020; Valsson, Tiwary,
and Parrinello 2016). Its central idea is to discourage a molecular
simulation from revisiting previously explored regions of the space of
CVs $\xi$; in doing so, metadynamics enhances the fluctuations along
$\xi$, thus speeding up the sampling (Valsson, Tiwary, and Parrinello
2016). A MetaD simulation evolves under a time-dependent bias potential
$V(\xi,t)$ that is incrementally constructed as the trajectory
progresses. At regular time intervals, a small repulsive Gaussian hill
of height $w$ and width $\sigma$ is deposited at the instantaneous CV
value $\xi(t)$: $$V(\xi,t) = \sum_{t'<t} w
e^{-\frac{\left(\xi-\xi(t')\right)^2}{2\sigma^2 }}$$ This "computational
sand-filling" (Barducci, Bonomi, and Parrinello 2011) progressively
raises the free-energy of ensembles of configurations visited during
sampling, allowing the system to escape local minima and visit new
regions of phase space. In the long-time limit, the accumulated bias
offsets the underlying free-energy surface $F(\xi)$ up to an additive
constant, so that $V(\xi,t \to \infty)\approx -F(\xi)$. Once this
condition is reached, the biased dynamics samples a uniform probability
distribution in CV space, effectively restoring ergodicity (see Sec.
[sec:Theory](#sec:Theory)).

MetaD is conceptually related to other history-dependent approaches,
such as the local elevation method (Huber, Torda, and Van Gunsteren
1994). In particular, MetaD shares with local elevation the general
principle of discouraging revisits to previously explored regions of
collective variable space, while differing in its formulation and
bias-update protocol. Moreover, compared with earlier mean-force-based
schemes such as the Adaptive Biasing Force (ABF) method (Comer et al.
2015; Darve and Pohorille 2001; Darve, Wilson, and and 2002),
metadynamics constructs the bias from local visitation history rather
than explicit force estimates. Despite its simplicity and general
applicability, MetaD suffers from a few drawbacks: the continual
deposition of Gaussians can lead to systematic overshooting of the
free-energy surface; convergence depends on the choice of Gaussian
height and width; and the time dependence of $V(\xi,t)$ complicates
rigorous reweighting. These issues motivated the development of
statistically controlled variants that address these shortcomings
(Barducci, Bonomi, and Parrinello 2011; Valsson, Tiwary, and Parrinello
2016; Bussi and Laio 2020).

Well-tempered metadynamics(Barducci, Bussi, and Parrinello 2008), is the
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
modern software (e.g., PLUMED (Max Bonomi 2021), GROMACS (Lindahl et al.
2022), LAMMPS (Thompson et al. 2022)) because it provides controlled
convergence, improved statistical efficiency, and the possibility to
monitor the flattening of the free-energy landscape on-the-fly.

One can combine WTMetaD with static biases (e.g., harmonic restraints,
walls, or custom static biases) in a straightforward, additive manner
(S., V., and N. 2016; Limongelli, Bonomi, and Parrinello 2013; Bjola and
Salvalaglio 2024). If the WTMetaD bias is deposited sufficiently
slowly - so that transition states remain effectively bias-free - the
infrequent metadynamics framework allows barrier-crossing times to be
rescaled to recover physical rate constants (Tiwary and Parrinello 2013;
Salvalaglio, Tiwary, and Parrinello 2014; Palacio-Rodriguez et al.
2022). The bias potential accumulated during a MetaD or WTMetaD
simulation modifies the underlying probability distribution, so that
direct estimates of the free energy $F(\xi)$ from the bias $V(\xi,t)$
are inherently time-dependent. Several formulations have been proposed
to obtain *time-independent free-energy estimators*, which recover
$F(\xi)$ or the distribution of *other* observables from a trajectory
sampled under the effect of a time-dependent bias (Tiwary and Parrinello
2015; M. Bonomi, Barducci, and Parrinello 2009; Marinova and Salvalaglio
2019; "Iterative Unbiasing of Quasi-Equilibrium Sampling" 2019; Ono and
Nakai 2020).

Recent developments have further generalized ideas originating from
metadynamics by recasting bias construction in probabilistic or
variational terms, giving rise to methods such as Variationally Enhanced
Sampling (VES), (Valsson and Parrinello 2014) On-the-fly Probabilty
Enhanced Sampling (OPES), (M. and M. 2020; Invernizzi, Piaggi, and
Parrinello 2020; Hénin et al. 2022), and GAMBES(Debnath and Parrinello
2020) which differ in how the target distribution is enforced. VES does
so by minimizing a KL-based variational functional. In contrast, OPES
achieves it via an explicit on-the-fly estimate of the marginal biased
probability density and a reweighting-based update of the bias; GAMBES,
instead, reconstructs the bias from a Gaussian Mixture approximation of
the sampled probability distribution. We refer the reader interested in
additional details to the comprehensive review of Henin et al. (Hénin et
al. 2022).

# References

::::::::::::::::::::::::::::::: {#refs .references .csl-bib-body .hanging-indent entry-spacing="0"}
::: {#ref-metaD_2 .csl-entry}
Barducci, Alessandro, Massimiliano Bonomi, and Michele Parrinello. 2011.
"Metadynamics." *Wiley Interdisciplinary Reviews: Computational
Molecular Science* 1 (September): 826--43.
<https://doi.org/10.1002/wcms.31>.
:::

::: {#ref-wt_metaD_1 .csl-entry}
Barducci, Alessandro, Giovanni Bussi, and Michele Parrinello. 2008.
"Well-Tempered Metadynamics: A Smoothly Converging and Tunable
Free-Energy Method." *Phys. Rev. Lett.* 100 (January).
<https://doi.org/10.1103/PhysRevLett.100.020603>.
:::

::: {#ref-bjola2024estimating .csl-entry}
Bjola, Antoniu, and Matteo Salvalaglio. 2024. "Estimating Free-Energy
Surfaces and Their Convergence from Multiple, Independent Static and
History-Dependent Biased Molecular-Dynamics Simulations with Mean Force
Integration." *J. Chem. Theory Comput.* 20 (13): 5418--27.
:::

::: {#ref-plumed214 .csl-entry}
Bonomi, Max. 2021. "PLUMED: PLUMED Masterclass 21.4: Metadynamics."
*Made Public on March 1, 2021*.
<https://www.plumed.org/doc-v2.7/user-doc/html/masterclass-21-4.html>.
:::

::: {#ref-wt_metaD_2 .csl-entry}
Bonomi, M., A. Barducci, and M. Parrinello. 2009. "Reconstructing the
Equilibrium Boltzmann Distribution from Well-Tempered Metadynamics." *J.
Comput. Chem.* 30 (August): 1615--21.
<https://doi.org/10.1002/jcc.21305>.
:::

::: {#ref-bussi2020using .csl-entry}
Bussi, Giovanni, and Alessandro Laio. 2020. "Using Metadynamics to
Explore Complex Free-Energy Landscapes." *Nat. Rev. Phys.* 2 (4):
200--212.
:::

::: {#ref-abf_2015 .csl-entry}
Comer, Jeffrey, James C. Gumbart, Jérôme Hénin, Tony Lelièvre, Andrew
Pohorille, and Christophe Chipot. 2015. "The Adaptive Biasing Force
Method: Everything You Always Wanted to Know but Were Afraid to Ask."
*J. Phys. Chem. B* 119 (3): 1129--51.
<https://doi.org/10.1021/jp506633n>.
:::

::: {#ref-abf_darve2001 .csl-entry}
Darve, Eric, and Andrew Pohorille. 2001. "Calculating Free Energies
Using Average Force." *J. Chem. Phys.* 115 (20): 9169--83.
<https://doi.org/10.1063/1.1410978>.
:::

::: {#ref-abf_darve2002 .csl-entry}
Darve, Eric, Michael A. Wilson, and Andrew Pohorille and. 2002.
"Calculating Free Energies Using a Scaled-Force Molecular Dynamics
Algorithm." *Molecular Simulation* 28 (1-2): 113--44.
<https://doi.org/10.1080/08927020211975>.
:::

::: {#ref-debnath2020gaussian .csl-entry}
Debnath, Jayashrita, and Michele Parrinello. 2020. "Gaussian
Mixture-Based Enhanced Sampling for Statics and Dynamics." *The Journal
of Physical Chemistry Letters* 11 (13): 5076--80.
:::

::: {#ref-henin2022enhanced .csl-entry}
Hénin, Jérôme, Tony Lelièvre, Michael R Shirts, Omar Valsson, and Lucie
Delemotte. 2022. "Enhanced Sampling Methods for Molecular Dynamics
Simulations." *arXiv Preprint arXiv:2202.04164*.
:::

::: {#ref-localelevation1994 .csl-entry}
Huber, Thomas, Andrew E Torda, and Wilfred F Van Gunsteren. 1994. "Local
Elevation: A Method for Improving the Searching Properties of Molecular
Dynamics Simulation." *Journal of Computer-Aided Molecular Design* 8
(6): 695--708.
:::

::: {#ref-invernizzi2020unified .csl-entry}
Invernizzi, Michele, Pablo M Piaggi, and Michele Parrinello. 2020.
"Unified Approach to Enhanced Sampling." *Phys. Rev. X* 10 (4): 041034.
:::

::: {#ref-giberti2019iterative .csl-entry}
"Iterative Unbiasing of Quasi-Equilibrium Sampling." 2019. *J. Chem.
Theory Comput.* 16 (1): 100--107.
:::

::: {#ref-laio2002escaping .csl-entry}
Laio, Alessandro, and Michele Parrinello. 2002. "Escaping Free-Energy
Minima." *Proc. Nat. Acad. Sci.* 99 (20): 12562--66.
:::

::: {#ref-limongelli2013funnel .csl-entry}
Limongelli, Vittorio, Massimiliano Bonomi, and Michele Parrinello. 2013.
"Funnel Metadynamics as Accurate Binding Free-Energy Method." *Proc.
Nat. Acad. Sci.* 110 (16): 6358--63.
:::

::: {#ref-Lindahl2022 .csl-entry}
Lindahl, Abraham, Hess, and van der Spoel. 2022. "GROMACS 2021.5
Manual." *GROMACS*, January. <https://doi.org/10.5281/ZENODO.5849961>.
:::

::: {#ref-invernizzi2020rethinking .csl-entry}
M., Invernizzi, and Parrinello M. 2020. "Rethinking Metadynamics: From
Bias Potentials to Probability Distributions." *J. Phys. Chem. Lett.* 11
(7): 2731--36.
:::

::: {#ref-Marinova2019 .csl-entry}
Marinova, Veselina, and Matteo Salvalaglio. 2019. "Time-Independent Free
Energies from Metadynamics via Mean Force Integration." *Journal of
Chemical Physics* 151 (October). <https://doi.org/10.1063/1.5123498>.
:::

::: {#ref-Ono2020MetaD .csl-entry}
Ono, Junichi, and Hiromi Nakai. 2020. "Weighted Histogram Analysis
Method for Multiple Short-Time Metadynamics Simulations." *Chem. Phys.
Lett.* 751: 137384.
https://doi.org/<https://doi.org/10.1016/j.cplett.2020.137384>.
:::

::: {#ref-palacio2022transition .csl-entry}
Palacio-Rodriguez, Karen, Hadrien Vroylandt, Lukas S Stelzl, Fabio
Pietrucci, Gerhard Hummer, and Pilar Cossio. 2022. "Transition Rates and
Efficiency of Collective Variables from Time-Dependent Biased
Simulations." *J. Phys. Chem. Lett.* 13 (32): 7490--96.
:::

::: {#ref-Awasthi2016 .csl-entry}
S., Awasthi, Kapil V., and Nair N. 2016. "Sampling Free Energy Surfaces
as Slices by Combining Umbrella Sampling and Metadynamics." *J. Comput.
Chem.* 37 (June): 1413--24. <https://doi.org/10.1002/jcc.24349>.
:::

::: {#ref-salvalaglio2014assessing .csl-entry}
Salvalaglio, Matteo, Pratyush Tiwary, and Michele Parrinello. 2014.
"Assessing the Reliability of the Dynamics Reconstructed from
Metadynamics." *J. Chem. Theory Comput.* 10 (4): 1420--25.
:::

::: {#ref-Thompson2022 .csl-entry}
Thompson, A, H Aktulga, R Berger, D Bolintineanu, W Brown, P Crozier, P
in't Veld, et al. 2022. "LAMMPS - a Flexible Simulation Tool for
Particle-Based Materials Modeling at the Atomic, Meso, and Continuum
Scales." *Comput. Phys. Commun.* 271 (February).
<https://doi.org/10.1016/j.cpc.2021.108171>.
:::

::: {#ref-tiwary2013metadynamics .csl-entry}
Tiwary, Pratyush, and Michele Parrinello. 2013. "From Metadynamics to
Dynamics." *Phys. Rev. Lett.* 111 (23): 230602.
:::

::: {#ref-metaD_reweight .csl-entry}
---------. 2015. "A Time-Independent Free Energy Estimator for
Metadynamics." *Journal of Physical Chemistry B* 119 (January): 736--42.
<https://doi.org/10.1021/jp504920s>.
:::

::: {#ref-ves_valsson2014 .csl-entry}
Valsson, Omar, and Michele Parrinello. 2014. "Variational Approach to
Enhanced Sampling and Free Energy Calculations." *Phys. Rev. Lett.* 113
(August): 090601. <https://doi.org/10.1103/PhysRevLett.113.090601>.
:::

::: {#ref-valsson2016enhancing .csl-entry}
Valsson, Omar, Pratyush Tiwary, and Michele Parrinello. 2016. "Enhancing
Important Fluctuations: Rare Events and Metadynamics from a Conceptual
Viewpoint." *Ann. Rev. Phys. Chem.* 67 (1): 159--84.
:::
:::::::::::::::::::::::::::::::
