# Collective Variables, Order Parameters, and Reaction Coordinates

The central role of $\xi$ is to provide a reduced representation of the
high-dimensional configuration space that retains the essential ability
to distinguish relevant metastable states, and slow transition modes
between them, for the molecular process of interest (Kirkwood 1935;
Frenkel and Smit 2023; Tuckerman 2023). Depending on the field of
application, the characteristics of the studied process, and its own
properties, the low-dimensional mapping $\xi$ can be referred to by
different names. The most common are collective variables (CVs), order
parameters (OPs), and reaction coordinates (RCs) (Hénin et al. 2022).
Although these terms overlap partially and are sometimes used
interchangeably by practitioners, they imply some fundamental
distinctions. Clarifying and understanding their differences is thus
crucial for a consistent interpretation of FESs associated with
molecular transformations.

```{figure} ../Figures/Figure_CVs2.png
:label: box:ionpairinCV
:alt: Figure 3
:align: center

**A. Reaction Coordinates and Collective Variables: Lessons from
Ion-Pair Dissociation in Water.** The distinction between CVs and RCs is
both conceptual and practical. An early and historically influential
example illustrating this difference is the dissociation of a
Na$^+$Cl$^-$ ion pair in water, investigated by Geissler et al. (Phillip
L. Geissler, Dellago, and Chandler 1999b). As illustrated by Geissler,
two landscapes $F(r_{\text{ion}}, q_S)$ with identical projections
$F(r_{\text{ion}})$ can imply distinct mechanisms. In the simplest
case,*(a)*, the barrier in $F(r_{\text{ion}})$ defines the transition
state, making $r_{\text{ion}}$ not only a good CV but also a RC.
However, when solvent reorganization adds an orthogonal coordinate
$q_S$, *b*, configurations at $r_{\text{ion}} = r^*$ belong to stable
basins rather than the transition region, so $r_{\text{ion}}$ remains a
good CV (able to distinguish dissociated from undissociated) but it is
not a good RC.\
**B. Choosing the Right Coordinate: The Ring Puckering Example.** The
choice of CVs is critical in free-energy calculations, but not always
obvious. Puckered ring conformers can be described by the Cremer--Pople
Cartesian coordinates, obtained from the out-of-plane displacements
$z_j$ of the 6-membered ring atoms as
$q_x =  \sum_{0}^5 z_j \cos\left[\frac{2\pi}{3}j\right]/\sqrt{3}$,
$q_y = -\sum_{0}^5 z_j \sin\left[\frac{2\pi}{3}j\right]/\sqrt{3}$,
$\quad q_z = \sum_{0}^5 (-1)^j z_j/ \sqrt{6}$, or by their polar
representation
$\left(Q \sin \theta \cos \phi, Q \sin \theta \sin \phi, Q\cos \theta\right)$
(left panel). Only $(\theta,\phi)$ are effective variables for biasing,
as they capture conformer connectivity. Using two polar coordinates,
metadynamics spans the entire puckering free-energy landscape for
glucuronic acid (middle panel, 5 kJ/mol isolines), whereas biasing along
Cartesian projections
$(q_x,q_y)=(Q\sin\theta\cos\phi,Q\sin\theta\sin\phi)$ fails near the
equatorial line. There, ergodicity is broken as the bias acts only
perpendicularly to the puckering sphere (right panel). (Sega, Autieri,
and Pederiva 2009).
```

(collective-variables-and-order-parameters)=
### Collective Variables and Order Parameters

A CV is the most general of the three denominations: it is any function
of the atomic coordinates designed to reduce the enormous dimensionality
of a molecular system into a smaller, more interpretable set of
descriptors. To be useful, CVs must distinguish all the relevant
long-lived metastable states involved in a transformation, i.e., the
reactants and the products. In this case, the metastable states of
interest will appear as local maxima in $p(\xi)$, and local minima in
the FES, $F(\xi)$. Typical CVs include simple geometrical descriptors,
such as distances and angles (Hénin et al. 2022; Fiorin, Klein, and
Hénin 2013; "Promoting Transparency and Reproducibility in Enhanced
Molecular Simulations" 2019; Tribello et al. 2025), as well as more
complex functions, including measures of structural similarity
(Pietrucci and Laio 2009) or progress along a path defined by a set of
reference structures (Branduardi, Gervasio, and Parrinello 2007). It
should be noted that CVs do not necessarily require a direct physical
interpretation, and they can be abstract or highly engineered (Pietrucci
and Andreoni 2011). For instance, combinations of distances, angles, or
latent variables from dimensionality-reduction algorithms can be
effective CVs by allowing for a clear distinction between metastable
states (Tribello et al. 2014), while losing a direct physical
interpretability (see an extended discussion in section
[sec:MLCVs](#sec:MLCVs)). OPs are a specific type of CV introduced in
statistical mechanics to distinguish between different thermodynamic
phases or states of matter (Neha et al. 2022; Desgranges and Delhommelle
2025; Giberti, Salvalaglio, and Parrinello 2015). OPs typically reflect
a symmetry-breaking or structural feature that changes qualitatively at
a phase transition---for example, density in liquid--gas coexistence,
orientational alignment in liquid crystals, and roto-translational
invariance in crystalline systems (Steinhardt, Nelson, and Ronchetti
1983; Tribello et al. 2017; Gimondi and Salvalaglio 2017; Piaggi and
Parrinello 2019). Although OPs are often used to obtain a global
description of an atomistic system, they are typically constructed from
local contributions within well-defined atomic environments (Lechner and
Dellago 2008; Bartók, Kondor, and Csányi 2013; Piaggi and Parrinello
2017; Giberti, Salvalaglio, and Parrinello 2015; Caruso et al. 2025).
When dealing with characterising the state of molecular solids, OPs
based on measures of similarity between distributions capturing the
translational, orientational, and conformational order are particularly
effective (Gobbo et al. 2018; Gimondi and Salvalaglio 2018; Francia et
al. 2020)

(reaction-coordinates)=
### Reaction Coordinates

An RC implies a further specialization: it is a low-dimensional
descriptor intended to capture the progress of *the* most probable
transition pathway between reactants and products. An ideal RC is not
only correlated with the transition but also uniquely parameterizes the
progress of the reaction and identifies the transition state
ensemble(Vanden-Eijnden 2006; Peters and Trout 2006; Peters 2017). An
important point to note is that, when (a combination of) CVs provide a
good approximation of the RC for a given physical transformation, saddle
points in $F(\xi)$ correspond to the projection of the transition state
ensemble of configurations associated with that transformation. For
configurations belonging to the transition state ensemble, the
probability of completing the crossing of the saddle point and
*committing* to the products (see Sec. [sec:committor](#sec:committor))
is narrowly distributed around $\frac{1}{2}$.

(sec:committor)=
### The Committor Function

The committor function $p_B(\mathbf{r})$ ---also known as splitting
probability, originally introduced by Onsager (Onsager 1938)--- provides
the most rigorous definition of a reaction coordinate for a system
evolving from state A to state B. It is the probability that a
trajectory starting from configuration $\mathbf{r}$, with momenta drawn
from equilibrium, reaches B before returning to A. By definition,
$p_A(\mathbf{r}) + p_B(\mathbf{r}) = 1$, and the transition state
ensemble corresponds to the isosurface $p_B = 1/2$. Iso-committor
surfaces partition configuration space into metastable basins, giving a
unique dynamical measure of progress along the reaction. Unlike
heuristic collective variables, the committor fully determines kinetic
observables such as rate constants and reactive fluxes (Vanden-Eijnden
2006). Although computing it exactly is infeasible for high-dimensional
systems, it remains a key reference: an ideal reaction coordinate
correlates monotonically with $p_B(\mathbf{r})$ and minimizes its
variance within isosurfaces. Thus, the committor defines the optimal
projection of dynamics---any reduced representation that preserves its
distribution across the transition ensemble retains complete kinetic
information (Phillip L. Geissler, Dellago, and Chandler 1999a), a
concept central to both path sampling (Bolhuis et al. 2002; Van Erp and
Bolhuis 2005) and modern data-driven approaches.