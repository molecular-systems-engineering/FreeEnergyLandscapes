# Machine-Learned Collective Variables and Their Associated Free Energy Surfaces

The rapid convergence of machine learning with enhanced sampling and
free-energy methodologies marks a genuine paradigm shift: starting with
the automated design of collective variables, machine learning is now
reshaping how we represent, explore, and interpret molecular free-energy
landscapes-blurring the boundaries between sampling, bias
construction, and thermodynamic inference, and signalling a revolution
in the way atomistic simulations generate physical insight. Building on
the theoretical and computational foundations discussed in the previous
sections, this new generation of approaches leverages data-driven
representations to couple learning and sampling in closed loops,
enabling adaptive exploration of high-dimensional configuration spaces.
Here, we focus on some key aspects relevant to the computation and
interpretation of free-energy surfaces. For a broader, more
comprehensive perspective on the ongoing integration of machine
learning, enhanced sampling, and free energy methods, we refer the
reader to the extensive overviews by Noé et al. [@noe2020machine], Mehdi
et al. [@mehdi2024enhanced], and Zhu et al. [@zhu2025enhanced].

(machine-learning-cvs)=
## Machine-Learning CVs

Traditionally, collective variables (CVs) have been designed from
physical intuition, for example, distances in ion-pair association,
torsional angles in peptide isomerization, or bond-order parameters in
crystallization. Such handcrafted descriptors have been instrumental in
molecular simulations for decades, enabling the projection of complex
dynamics onto interpretable coordinates (see Section
[sec:CVs](#sec:CVs)). Yet, they are rarely optimal. In high-dimensional
systems, where the relevant slow modes arise from nonlinear couplings of
many atomic degrees of freedom, physically inspired CVs may fail to
distinguish metastable states or to capture the true kinetic bottlenecks
of phase-space exploration. This realization has prompted the
development of machine-learned collective variables (MLCVs), which
employ data-driven algorithms to infer optimal low-dimensional
representations directly from simulation trajectories [@gokdemir2025machine; @desgranges2025deciphering; @neha2022collective]. The
field of MLCVs encompasses a spectrum of methodologies that can be
broadly grouped by the learning principle they adopt. Unsupervised
approaches - including principal component analysis [@garcia1992large; @amadei1993essential; @hegger2007complex; @wetzel2017unsupervised],
diffusion maps [@ferguson2011integrating; @preto2014fast],
sketch-map [@ceriotti2011simplifying; @tribello2012using], and autoencoders [@chen2018molecular; @wehmeyer2018time; @lemke2019encodermap]-learn low-dimensional
manifolds that preserve the variance or geometric structure of the
high-dimensional trajectory data. These methods are effective for
capturing dominant structural fluctuations, such as protein
conformational changes or order--disorder transitions in solids. Still,
they do not guarantee the recovery of dynamical slow modes. In contrast,
variational and supervised methods explicitly target dynamical
relevance. The variational approach to conformational dynamics (VAC)
[@noe2013variational; @nuske2014variational], defines an optimal reaction
coordinate as the mapping that maximizes the time-lagged autocorrelation
of the projected dynamics---equivalently, the leading eigenfunction of
the transfer operator. Implementations such as time-lagged independent
component analysis (TICA) [@perez2013identification], VAMPnets [@mardt2018vampnets], and state-free reversible VAMPnets (SRV) [@chen2019nonlinear] learn nonlinear transformations that approximate these slow eigenmodes, often in the form of neural-network embeddings.
Closely related are information-bottleneck formulations, such as RAVE
(reweighted autoencoded variational Bayes for enhanced sampling) [@ribeiro2018reweighted], SPIB [@wang2019past] and
variational dynamic encoders (VDE) [@hernandez2018variational], which train
neural networks to identify minimally complex yet maximally predictive
latent variables, thus approximating the committor function (see the
dedicated box above). Complementary to these are discriminant-based
approaches that use labeled metastable states: linear discriminant
analysis (LDA) and its harmonic variant (HLDA) construct transparent,
differentiable linear CVs that maximize between-state separation
[@mendels2018collective; @piccini2018metadynamics]. 
Their nonlinear extensions, Deep-LDA and Deep-TDA, replace the
linear map with a neural network, yielding smooth, expressive CVs that
integrate seamlessly with biased enhanced sampling methods such as US,
MetaD, VES, and OPES for free-energy reconstruction [@bonati2020data; @trizio2021enhanced]. These algorithms have found widespread applications across various fields, including ligand binding [@wang2019past], conformational transitions
[@hernandez2018variational; @mardt2018vampnets; @chen2019nonlinear], self-assembly [@jung2023machine; @boninsegna2018data], and phase transformations [@finney2023variational].

A recent frontier in the construction of MLCVs is the use of graph
neural networks (GNNs) and geometric deep learning architectures, which
natively encode the fundamental symmetries of molecular
systems---translation, rotation, and permutation invariance of identical
atoms. By representing atomic environments as graphs with nodes (atoms)
and edges (interactions), these architectures eliminate the need for
explicit handcrafted descriptors such as symmetry functions or
Steinhardt order parameters [@Dietrich2023; @zhang2024descriptor]. Two
recent examples demonstrate the potential of this approach. In Dietrich
et al. [@Dietrich2023], graph-based models were trained to approximate
nucleation order parameters in colloidal and metallic systems. The
learned variables reproduced the behaviour of conventional $Q_6$-based
crystallinity measures, but with an order-of-magnitude computational
speedup, enabling on-the-fly biasing in umbrella sampling and
metadynamics. Similarly, Zhang et al. [@zhang2024descriptor] introduced
descriptor-free collective variables from geometric graph neural
networks, extending the concept to molecular systems and demonstrating
how equivariant layers can learn rotationally consistent embeddings of
atomic environments without predefined order parameters.


```{figure} ./Figure_MLCVs.png
:label: fig:MLCVs_and_gradients
:alt: Figure 3
:align: center

**Data-driven (CVs) derived from deep learning**. 
**A,B.** Deep-LDA
[@bonati2020data] combines nonlinear neural-network
transformations of physical descriptors with linear discriminant
analysis to extract a one-dimensional CV that best separates metastable
basins, yielding committor-like behavior (panel B) and interpretable
feature rankings. **C,D.** Graph neural-network (GNN) CVs [@Dietrich2023] operate directly on molecular graphs built from atomic
coordinates, aggregating local environments through message-passing
layers and pooling to produce permutation-invariant, differentiable CVs
transferable across system sizes and materials. These CVs can be
deployed to carry out biased sampling with adaptive methods and thus
compute FES, as seen in panel C, associated with the two-step nucleation
of a colloidal system.
```


The natural complement to MLCVs is their integration with enhanced
sampling methods (see section [sec:Computing](#sec:Computing)), where
CVs serve as biasing coordinates to accelerate the simulation of rare
events. Machine learning can be used both to discover effective CVs and
to mitigate bias potential in real time. Iterative schemes such as
active enhanced sampling alternate between sampling and learning,
progressively refining the CV toward a dynamically optimal
coordinate.(Ribeiro et al. 2018; Wang, Ribeiro, and Tiwary 2019; Ray,
Trizio, and Parrinello 2023; Trizio, Kang, and Parrinello 2025) Such
approaches are often developed in three main steps: (i) learn a
low-dimensional representation of slow dynamics, (ii) deploy a given
learnt representation as a biasing coordinate in MetaD/VES/OPES/ABF (see
Section [sec:Computing](#sec:Computing)), and (iii) periodically
re-train or fine-tune the model on newly sampled configurations. This
iterative workflow, exemplified by, i.e. RAVE (Ribeiro et al. 2018), is
highlighted and discussed in detail across recent reviews (Noé et al.
2020; Hénin et al. 2022; Mehdi et al. 2024; Zhu et al. 2025) and case
studies, where the bias is either optimized variationally (Valsson and
Parrinello 2014; Bonati, Zhang, and Parrinello 2019) or built adaptively
from sampling statistics.

(machine-learning-the-committor)=
## Machine-Learning the Committor

The accurate sampling and learning of the committor in high-dimensional
molecular systems remains an area of active research, uniting
developments in enhanced-sampling algorithms, transition-path theory and
machine-learning representations to make the "ideal" reaction coordinate
a practical and learnable object. In the variational approach presented
by Kang et al. (Kang, Trizio, and Parrinello 2024) and Trizio et al.
(Trizio, Kang, and Parrinello 2025), the committor is represented as a
differentiable model
$p_B(\mathbf{r}) = [1 + e^{-q(\mathbf{r}|w)}]^{-1}$, where
$q(\mathbf{r}|w)$ is a neural-network, function of physically motivated
descriptors. The parameters of the neural network, $w$, are optimized by
maximizing the consistency between predicted and observed transition
outcomes. This strategy generalizes the likelihood maximization of
Peters and Trout (Peters and Trout 2006) and directly yields a smooth,
differentiable approximation to the committor that can be analyzed,
differentiated, and even symbolically regressed to human-interpretable
forms. Applying a variational principle allows this problem to be
reformulated in terms of the Kolmogorov functional:
$$K[q] = \langle |\nabla q(\mathbf{r})|^2 \rangle$$ whose minimization
under boundary conditions $q(\mathbf{r}_A)=0$ and $q(\mathbf{r}_B)=1$
yields the committor function satisfying the Kolmogorov equation for
overdamped dynamics(Trizio, Kang, and Parrinello 2025).

This principle defines the Kolmogorov ensemble, in which configurations
are sampled with probability
$p_K(\mathbf{r}) \propto e^{-\beta [U(\mathbf{r}) + V_K(\mathbf{r})]}$,
and where the committor-dependent bias
$V_K(\mathbf{r}) = -\beta^{-1}\log|\nabla q(\mathbf{r})|^2$ stabilizes
configurations belonging to the transition-state region(Kang, Trizio,
and Parrinello 2024). Using this framework, Trizio et al. demonstrated
that the learned approximation of the committor can be used not only to
characterize the transition-state ensemble but also to drive enhanced
sampling by coupling the Kolmogorov bias with on-the-fly probability
enhanced sampling (OPES)(Kang, Trizio, and Parrinello 2024; Trizio,
Kang, and Parrinello 2025). In this extended formulation, the
pre-activation $q(\mathbf{r})$ of the neural network trained to yield
the committor serves as a smooth CV that acts as a proxy for the
committor itself and enables the exploration of metastable basins *and*
transition states within a single self-consistent workflow. The
resulting probability-based enhanced sampling approach, as applied by
Trizio et al. (Trizio, Kang, and Parrinello 2025), was used to model
processes ranging from protein folding to ligand binding, accurately
reproducing free-energy surfaces and reactive pathways while retaining
interpretability and physical transparency.

(fess-and-sampling-with-mlcvs-some-cautionary-tales)=
## FESs and sampling with MLCVs: some cautionary tales

As discussed above, MLCVs hold remarkable potential to complement the
definition and calculation of useful FESs. Projecting onto MLCV spaces,
however, raises subtle issues. As highlighted in Ref. (Dietrich and
Salvalaglio 2025), the mapping $\xi(\mathbf{r})$, when obtained through
an MLCV is not uniquely defined: different neural network trainings with
identical architectures and hyperparameters can lead to different
embeddings, altering the Jacobian matrix
$J_\xi = \partial \xi/\partial \mathbf{r}$. Given that
$$p({\xi}) = \frac{1}{Z_{NVT}} \int_{\Sigma_{\xi}} e^{-\beta U(\mathbf r)} \mathrm{vol}(J_\xi)^{-1} d\sigma$$
The shape of $F(\xi)$ can vary across training instances even when all
models capture the same metastable states. This non-reproducibility
problem is specific to machine-learned CVs and is absent in physically
defined variables. An effective solution is the adoption of an
alternative definition of the FES, common to applications in
computational kinetics, i.e., the *gauge-invariant* or *Geometric* FES
(Carsten Hartmann and Schütte 2007; C. Hartmann, Latorre, and Ciccotti
2011; Bal et al. 2020):
$$F_G({\xi}) = -\kT \ln p_G({\xi}), \quad p_G({\xi}) = \int_{\Sigma_{\xi}} e^{-\beta U(\mathbf r)} d\sigma,$$
where $\int_{\Sigma_\xi}$ indicates the integral on the hypersurface
defined by the level-set of all the configurations degenerate in $\xi$,
and $d\sigma$ the infinitesimal element of such hypersurface. This
effectively removes the explicit Jacobian dependence of $F(\xi)$.
Moreover, $F_G(\xi)$ is invariant under any monotonic transformation of
the CVs, ensuring that the levels of free energy minima, barriers, and
saddle points are consistent across different training runs. This gauge
invariance makes $F_G$ the natural framework for comparing FESs obtained
from independently trained instances of MLCVs with the same
architecture, and it favors comparisons across architectures
parameterized with different hyperparameters. Another area where the
application of MLCVs requires care is the reproducibility of sampling
efficiency in biased simulations, since variability in the Jacobian
arising from stochastic training and hyperparameter choices can lead to
unreproducible biasing forces---including spikes or vanishing
gradients---across different training instances (see Fig.
[fig:MLCVs_and_gradients](#fig:MLCVs_and_gradients)b) (Dietrich and
Salvalaglio 2025). Building on the concept of Geometric FES discussed
above, Ref. (Dietrich and Salvalaglio 2025) proposes gradient
normalization as a simple and effective approach to mitigate this issue.

(machine-learningenhanced-transition-path-sampling)=
## Machine-Learning--Enhanced Transition-Path Sampling

Machine learning is reshaping transition-path sampling (TPS) by enabling
adaptive discovery of reactive trajectories in complex systems. Recent
approaches merge ML inference with path-sampling algorithms, allowing
the committor, transition paths, and even full path ensembles to be
learned directly from data. Bolhuis and co-workers developed AIMMD
(Lazzeri et al. 2023), which trains a surrogate model for adaptive
reweighting and importance sampling in trajectory space. Applied to
chignolin folding, it reproduces free energies, rates, and mechanisms at
a fraction of the cost of conventional TPS by learning the committor
self-consistently. Jung et al. (Jung et al. 2023) introduced an
autonomous ML-TPS framework that iteratively trains a neural-network
committor from shooting outcomes, refocusing sampling near transition
states. Tested on ion association, hydrate nucleation, polymer folding,
and membrane-protein assembly, it yields accurate rates and
interpretable mechanisms without predefined reaction coordinates. Chipot
and co-workers (H. Chen, Roux, and Chipot 2023) implemented the
variational principle of transition-path theory using neural networks,
inspiring later committor-consistent schemes such as PCCANN by Megías et
al., which minimizes the finite-time-lag committor correlation function
$C_{qq}(\tau)=\tfrac12\langle(q(\tau)-q(0))^2\rangle$, to learn dominant
transition tubes. Iteratively coupling biased MD sampling and committor
retraining, PCCANN identifies committor-consistent pathways and multiple
competing channels, demonstrated for NANMA isomerization and chignolin
folding. Together, these studies mark a shift from fixed-bias sampling
to data-driven path ensembles, in which machine learning reuses
trajectory data, reduces costs, and generalizes across systems---laying
the groundwork for future generative or diffusion-based transition-path
theories.

# References

::::::::::::::::::::::::::::::::::::::::::::::::::: {#refs .references .csl-bib-body .hanging-indent entry-spacing="0"}
::: {#ref-amadei1993essential .csl-entry}
Amadei, Andrea, Antonius BM Linssen, and Herman JC Berendsen. 1993.
"Essential Dynamics of Proteins." *Proteins: Struct. Func. Bioinf.* 17
(4): 412--25.
:::

::: {#ref-BalGauge .csl-entry}
Bal, Kristof M., Satoru Fukuhara, Yasushi Shibuta, and Erik C. Neyts.
2020. "[Free energy barriers from biased molecular dynamics
simulations]{.nocase}." *J. Chem. Phys.* 153 (11): 114118.
<https://doi.org/10.1063/5.0020240>.
:::

::: {#ref-bonati2020data .csl-entry}
Bonati, Luigi, Valerio Rizzi, and Michele Parrinello. 2020. "Data-Driven
Collective Variables for Enhanced Sampling." *J. Phys. Chem. Lett.* 11
(8): 2998--3004.
:::

::: {#ref-bonati2019neural .csl-entry}
Bonati, Luigi, Yue-Yu Zhang, and Michele Parrinello. 2019. "Neural
Networks-Based Variationally Enhanced Sampling." *Proc. Nat. Acad. Sci.*
116 (36): 17641--47.
:::

::: {#ref-boninsegna2018data .csl-entry}
Boninsegna, Lorenzo, Ralf Banisch, and Cecilia Clementi. 2018. "A
Data-Driven Perspective on the Hierarchical Assembly of Molecular
Structures." *J. Chem. Theory Comput.* 14 (1): 453--60.
:::

::: {#ref-ceriotti2011simplifying .csl-entry}
Ceriotti, Michele, Gareth A Tribello, and Michele Parrinello. 2011.
"Simplifying the Representation of Complex Free-Energy Landscapes Using
Sketch-Map." *Proc. Nat. Acad. Sci.* 108 (32): 13023--28.
:::

::: {#ref-chen2023discovering .csl-entry}
Chen, Haochuan, Benoı̂t Roux, and Christophe Chipot. 2023. "Discovering
Reaction Pathways, Slow Variables, and Committor Probabilities with
Machine Learning." *J. Chem. Theory Comput.* 19 (14): 4414--26.
:::

::: {#ref-chen2018molecular .csl-entry}
Chen, Wei, and Andrew L Ferguson. 2018. "Molecular Enhanced Sampling
with Autoencoders: On-the-Fly Collective Variable Discovery and
Accelerated Free Energy Landscape Exploration." *J. Comput. Chem.* 39
(25): 2079--2102.
:::

::: {#ref-chen2019nonlinear .csl-entry}
Chen, Wei, Hythem Sidky, and Andrew L Ferguson. 2019. "Nonlinear
Discovery of Slow Molecular Modes Using State-Free Reversible VAMPnets."
*J. Chem. Phys.* 150 (21).
:::

::: {#ref-desgranges2025deciphering .csl-entry}
Desgranges, Caroline, and Jerome Delhommelle. 2025. "Deciphering the
Complexities of Crystalline State (s) with Molecular Simulations."
*Communications Chemistry* 8 (1): 281.
:::

::: {#ref-Dietrich2025 .csl-entry}
Dietrich, Florian M., and Matteo Salvalaglio. 2025. "A Variational
Approach to Assess Reaction Coordinates for Two-Step Crystallization."
*J. Chem. Phys.* 163 (October). <https://doi.org/10.1063/5.0287912>.
:::

::: {#ref-Dietrich2023 .csl-entry}
F., Dietrich, Advincula X., Gobbo G., Bellucci M., and Salvalaglio M.
2023. "Machine Learning Nucleation Collective Variables with Graph
Neural Networks." *J. Chem. Theory Comput.*, October.
<https://doi.org/10.1021/acs.jctc.3c00722>.
:::

::: {#ref-ferguson2011integrating .csl-entry}
Ferguson, Andrew L, Athanassios Z Panagiotopoulos, Pablo G Debenedetti,
and Ioannis G Kevrekidis. 2011. "Integrating Diffusion Maps with
Umbrella Sampling: Application to Alanine Dipeptide." *J. Chem. Phys.*
134 (13).
:::

::: {#ref-finney2023variational .csl-entry}
Finney, A. R., and M. Salvalaglio. 2023. "A Variational Approach to
Assess Reaction Coordinates for Two-Step Crystallization." *J. Chem.
Phys.* 158 (9): 094503. <https://doi.org/10.1063/5.0139842>.
:::

::: {#ref-garcia1992large .csl-entry}
Garcı́a, Angel E. 1992. "Large-Amplitude Nonlinear Motions in Proteins."
*Phys. Rev. Lett.* 68 (17): 2696.
:::

::: {#ref-gokdemir2025machine .csl-entry}
Gökdemir, Tuğçe, and Jakub Rydzewski. 2025. "Machine Learning of Slow
Collective Variables and Enhanced Sampling via Spatial Techniques."
*Chem. Phys. Rev.* 6 (1).
:::

::: {#ref-HartmannSchutte07 .csl-entry}
Hartmann, Carsten, and Christof Schütte. 2007. "Comment on Two Distinct
Notions of Free Energy." *Physica D: Nonlinear Phenomena* 228 (1):
59--63. https://doi.org/<https://doi.org/10.1016/j.physd.2007.02.006>.
:::

::: {#ref-Hartmann2011 .csl-entry}
Hartmann, C., J. C. Latorre, and G. Ciccotti. 2011. "On Two Possible
Definitions of the Free Energy for Collective Variables." *The European
Physical Journal Special Topics* 200 (November): 73--89.
<https://doi.org/10.1140/epjst/e2011-01519-7>.
:::

::: {#ref-hegger2007complex .csl-entry}
Hegger, Rainer, Alexandros Altis, Phuong H Nguyen, and Gerhard Stock.
2007. "How Complex Is the Dynamics of Peptide Folding?" *Phys. Rev.
Lett.* 98 (2): 028102.
:::

::: {#ref-henin2022enhanced .csl-entry}
Hénin, Jérôme, Tony Lelièvre, Michael R Shirts, Omar Valsson, and Lucie
Delemotte. 2022. "Enhanced Sampling Methods for Molecular Dynamics
Simulations." *arXiv Preprint arXiv:2202.04164*.
:::

::: {#ref-hernandez2018variational .csl-entry}
Hernández, Carlos X, Hannah K Wayment-Steele, Mohammad M Sultan, Brooke
E Husic, and Vijay S Pande. 2018. "Variational Encoding of Complex
Dynamics." *Phys. Rev. E* 97 (6): 062412.
:::

::: {#ref-jung2023machine .csl-entry}
Jung, Hendrik, Roberto Covino, A Arjun, Christian Leitold, Christoph
Dellago, Peter G Bolhuis, and Gerhard Hummer. 2023. "Machine-Guided Path
Sampling to Discover Mechanisms of Molecular Self-Organization." *Nat.
Comput. Science* 3 (4): 334--45.
:::

::: {#ref-kang2024computing .csl-entry}
Kang, Peilin, Enrico Trizio, and Michele Parrinello. 2024. "Computing
the Committor with the Committor to Study the Transition State
Ensemble." *Nature Computational Science* 4 (6): 451--60.
:::

::: {#ref-lazzeri2023molecular .csl-entry}
Lazzeri, Gianmarco, Hendrik Jung, Peter G Bolhuis, and Roberto Covino.
2023. "Molecular Free Energies, Rates, and Mechanisms from
Data-Efficient Path Sampling Simulations." *J. Chem. Theory Comput.* 19
(24): 9060--76.
:::

::: {#ref-lemke2019encodermap .csl-entry}
Lemke, Tobias, and Christine Peter. 2019. "Encodermap: Dimensionality
Reduction and Generation of Molecule Conformations." *J. Chem. Theory
Comput.* 15 (2): 1209--15.
:::

::: {#ref-mardt2018vampnets .csl-entry}
Mardt, Andreas, Luca Pasquali, Hao Wu, and Frank Noé. 2018. "VAMPnets
for Deep Learning of Molecular Kinetics." *Nat. Comm.* 9 (1): 5.
:::

::: {#ref-mehdi2024enhanced .csl-entry}
Mehdi, Shams, Zachary Smith, Lukas Herron, Ziyue Zou, and Pratyush
Tiwary. 2024. "Enhanced Sampling with Machine Learning." *Ann. Rev.
Phys. Chem.* 75 (2024): 347--70.
:::

::: {#ref-mendels2018collective .csl-entry}
Mendels, Dan, GiovanniMaria Piccini, and Michele Parrinello. 2018.
"Collective Variables from Local Fluctuations." *J. Phys. Chem. Lett.* 9
(11): 2776--81.
:::

::: {#ref-neha2022collective .csl-entry}
Neha, Vikas Tiwari, Soumya Mondal, Nisha Kumari, and Tarak Karmakar.
2022. "Collective Variables for Crystallization Simulations─ from Early
Developments to Recent Advances." *ACS Omega* 8 (1): 127--46.
:::

::: {#ref-noe2013variational .csl-entry}
Noé, Frank, and Feliks Nuske. 2013. "A Variational Approach to Modeling
Slow Processes in Stochastic Dynamical Systems." *Multiscale Modeling &
Simulation* 11 (2): 635--55.
:::

::: {#ref-noe2020machine .csl-entry}
Noé, Frank, Alexandre Tkatchenko, Klaus-Robert Müller, and Cecilia
Clementi. 2020. "Machine Learning for Molecular Simulation." *Ann. Rev.
Phys. Chem.* 71 (1): 361--90.
:::

::: {#ref-nuske2014variational .csl-entry}
Nuske, Feliks, Bettina G Keller, Guillermo Pérez-Hernández, Antonia SJS
Mey, and Frank Noé. 2014. "Variational Approach to Molecular Kinetics."
*J. Chem. Theory Comput.* 10 (4): 1739--52.
:::

::: {#ref-perez2013identification .csl-entry}
Pérez-Hernández, Guillermo, Fabian Paul, Toni Giorgino, Gianni De
Fabritiis, and Frank Noé. 2013. "Identification of Slow Molecular Order
Parameters for Markov Model Construction." *J. Chem. Phys.* 139 (1).
:::

::: {#ref-peters2006obtaining .csl-entry}
Peters, Baron, and Bernhardt L Trout. 2006. "Obtaining Reaction
Coordinates by Likelihood Maximization." *J. Chem. Phys.* 125 (5).
:::

::: {#ref-piccini2018metadynamics .csl-entry}
Piccini, GiovanniMaria, Dan Mendels, and Michele Parrinello. 2018.
"Metadynamics with Discriminants: A Tool for Understanding Chemistry."
*J. Chem. Theory Comput.* 14 (10): 5040--44.
:::

::: {#ref-preto2014fast .csl-entry}
Preto, Jordane, and Cecilia Clementi. 2014. "Fast Recovery of Free
Energy Landscapes via Diffusion-Map-Directed Molecular Dynamics." *Phys.
Chem. Chem. Phys.* 16 (36): 19181--91.
:::

::: {#ref-ray2023deep .csl-entry}
Ray, Dhiman, Enrico Trizio, and Michele Parrinello. 2023. "Deep Learning
Collective Variables from Transition Path Ensemble." *J. Chem. Phys.*
158 (20).
:::

::: {#ref-ribeiro2018reweighted .csl-entry}
Ribeiro, João Marcelo Lamim, Pablo Bravo, Yihang Wang, and Pratyush
Tiwary. 2018. "Reweighted Autoencoded Variational Bayes for Enhanced
Sampling (RAVE)." *J. Chem. Phys.* 149 (7).
:::

::: {#ref-tribello2012using .csl-entry}
Tribello, Gareth A, Michele Ceriotti, and Michele Parrinello. 2012.
"Using Sketch-Map Coordinates to Analyze and Bias Molecular Dynamics
Simulations." *Proc. Nat. Acad. Sci.* 109 (14): 5196--5201.
:::

::: {#ref-trizio2025everything .csl-entry}
Trizio, Enrico, Peilin Kang, and Michele Parrinello. 2025. "Everything
Everywhere All at Once: A Probability-Based Enhanced Sampling Approach
to Rare Events." *Nature Computational Science*, 1--10.
:::

::: {#ref-trizio2021enhanced .csl-entry}
Trizio, Enrico, and Michele Parrinello. 2021. "From Enhanced Sampling to
Reaction Profiles." *J. Phys. Chem. Lett.* 12 (35): 8621--26.
:::

::: {#ref-ves_valsson2014 .csl-entry}
Valsson, Omar, and Michele Parrinello. 2014. "Variational Approach to
Enhanced Sampling and Free Energy Calculations." *Phys. Rev. Lett.* 113
(August): 090601. <https://doi.org/10.1103/PhysRevLett.113.090601>.
:::

::: {#ref-wang2019past .csl-entry}
Wang, Yihang, João Marcelo Lamim Ribeiro, and Pratyush Tiwary. 2019.
"Past--Future Information Bottleneck for Sampling Molecular Reaction
Coordinate Simultaneously with Thermodynamics and Kinetics." *Nature
Communications* 10 (1): 3573.
:::

::: {#ref-wehmeyer2018time .csl-entry}
Wehmeyer, Christoph, and Frank Noé. 2018. "Time-Lagged Autoencoders:
Deep Learning of Slow Collective Variables for Molecular Kinetics." *J.
Chem. Phys.* 148 (24).
:::

::: {#ref-wetzel2017unsupervised .csl-entry}
Wetzel, Sebastian J. 2017. "Unsupervised Learning of Phase Transitions:
From Principal Component Analysis to Variational Autoencoders." *Phys.
Rev. E* 96 (2): 022140.
:::

::: {#ref-zhang2024descriptor .csl-entry}
Zhang, Jintu, Luigi Bonati, Enrico Trizio, Odin Zhang, Yu Kang, TingJun
Hou, and Michele Parrinello. 2024. "Descriptor-Free Collective Variables
from Geometric Graph Neural Networks." *J. Chem. Theory Comput.* 20
(24): 10787--97.
:::

::: {#ref-zhu2025enhanced .csl-entry}
Zhu, Kai, Enrico Trizio, Jintu Zhang, Renling Hu, Linlong Jiang, Tingjun
Hou, and Luigi Bonati. 2025. "Enhanced Sampling in the Age of Machine
Learning: Algorithms and Applications." *arXiv Preprint
arXiv:2509.04291*.
:::

::: {#ref-ziyue2023driving .csl-entry}
Zou, Ziyue, Eric R. Beyerle, Sun-Ting Tsai, and Pratyush Tiwary. 2023.
"Driving and Characterizing Nucleation of Urea and Glycine Polymorphs in
Water." *Proc. Nat. Acad. Sci.* 120 (7): e2216099120.
<https://doi.org/10.1073/pnas.2216099120>.
:::
:::::::::::::::::::::::::::::::::::::::::::::::::::
