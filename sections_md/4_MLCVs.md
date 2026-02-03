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
systems - translation, rotation, and permutation invariance of identical
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


```{figure} ./Figures/Figure_MLCVs.png
:label: fig:MLCVs_and_gradients
:alt: Figure 3
:align: center

**Data-driven (CVs) derived from deep learning**. 
**A,B.** Deep-LDA
[@bonati2020data] combines nonlinear neural-network
transformations of physical descriptors with linear discriminant
analysis to extract a one-dimensional CV that best separates metastable
basins, yielding committor-like behavior (panel B) and interpretable
feature rankings. **C,D.** Graph neural-network (GNN) CVs [@Dietrich2023] operate directly on molecular graphs built from atomic coordinates, aggregating local environments through message-passing
layers and pooling to produce permutation-invariant, differentiable CVs
transferable across system sizes and materials. These CVs can be deployed to carry out biased sampling with adaptive methods and thus compute FES, as seen in panel C, associated with the two-step nucleation
of a colloidal system.
```


The natural complement to MLCVs is their integration with enhanced
sampling methods (see section [sec:Computing](#sec:Computing)), where
CVs serve as biasing coordinates to accelerate the simulation of rare
events. Machine learning can be used both to discover effective CVs and
to mitigate bias potential in real time. Iterative schemes such as
active enhanced sampling alternate between sampling and learning,
progressively refining the CV toward a dynamically optimal
coordinate [@ribeiro2018reweighted; @ray2023deep; @trizio2025everything].
Such approaches are often developed in three main steps: (i) learn a
low-dimensional representation of slow dynamics, (ii) deploy a given
learnt representation as a biasing coordinate in MetaD/VES/OPES/ABF (see
Section [sec:Computing](#sec:Computing)), and (iii) periodically
re-train or fine-tune the model on newly sampled configurations. This
iterative workflow, exemplified by, i.e. RAVE [@ribeiro2018reweighted], is
highlighted and discussed in detail across recent reviews [@noe2020machine; @mehdi2024enhanced; @zhu2025enhanced]  and case studies, where the bias is either optimized variationally [@ves_valsson2014; @bonati2019neural]  or built adaptively from sampling statistics.

(machine-learning-the-committor)=
## Machine-Learning the Committor

The accurate sampling and learning of the committor in high-dimensional
molecular systems remains an area of active research, uniting
developments in enhanced-sampling algorithms, transition-path theory and
machine-learning representations to make the "ideal" reaction coordinate
a practical and learnable object. In the variational approach presented
by Kang et al. [@kang2024computing] and Trizio et al.
[@trizio2025everything], the committor is represented as a
differentiable model
$p_B(\mathbf{r}) = [1 + e^{-q(\mathbf{r}|w)}]^{-1}$, where
$q(\mathbf{r}|w)$ is a neural-network, function of physically motivated
descriptors. The parameters of the neural network, $w$, are optimized by
maximizing the consistency between predicted and observed transition
outcomes. This strategy generalizes the likelihood maximization of
Peters and Trout [@peters2006obtaining], and directly yields a smooth,
differentiable approximation to the committor that can be analyzed,
differentiated, and even symbolically regressed to human-interpretable
forms. Applying a variational principle allows this problem to be
reformulated in terms of the Kolmogorov functional:
$$K[q] = \langle |\nabla q(\mathbf{r})|^2 \rangle$$ whose minimization
under boundary conditions $q(\mathbf{r}_A)=0$ and $q(\mathbf{r}_B)=1$
yields the committor function satisfying the Kolmogorov equation for
overdamped dynamics [@trizio2025everything].

This principle defines the Kolmogorov ensemble, in which configurations
are sampled with probability
$p_K(\mathbf{r}) \propto e^{-\beta [U(\mathbf{r}) + V_K(\mathbf{r})]}$,
and where the committor-dependent bias
$V_K(\mathbf{r}) = -\beta^{-1}\log|\nabla q(\mathbf{r})|^2$ stabilizes
configurations belonging to the transition-state region [@kang2024computing]. 
Using this framework, Trizio et al. demonstrated
that the learned approximation of the committor can be used not only to
characterize the transition-state ensemble but also to drive enhanced
sampling by coupling the Kolmogorov bias with on-the-fly probability
enhanced sampling (OPES)[@kang2024computing; @trizio2025everything]. In this extended formulation, the
pre-activation $q(\mathbf{r})$ of the neural network trained to yield
the committor serves as a smooth CV that acts as a proxy for the
committor itself and enables the exploration of metastable basins *and*
transition states within a single self-consistent workflow. The
resulting probability-based enhanced sampling approach, was used to model
processes ranging from protein folding to ligand binding, accurately
reproducing free-energy surfaces and reactive pathways while retaining
interpretability and physical transparency [@@trizio2025everything].

(fess-and-sampling-with-mlcvs-some-cautionary-tales)=
## FESs and sampling with MLCVs: some cautionary tales

As discussed above, MLCVs hold remarkable potential to complement the
definition and calculation of useful FESs. Projecting onto MLCV spaces,
however, raises subtle issues. As highlighted in Ref. [@Dietrich2025], the mapping $\xi(\mathbf{r})$, when obtained through
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
[@HartmannSchutte07; @Hartmann2011]: $$F_G({\xi}) = -kT \ln p_G({\xi}), \quad p_G({\xi}) = \int_{\Sigma_{\xi}} e^{-\beta U(\mathbf r)} d\sigma,$$ where $\int_{\Sigma_\xi}$ indicates the integral on the hypersurface
defined by the level-set of all the configurations degenerate in $\xi$, and $d\sigma$ the infinitesimal element of such hypersurface. 
This effectively removes the explicit Jacobian dependence of $F(\xi)$.
Moreover, $F_G(\xi)$ is invariant under any monotonic transformation of the CVs, ensuring that the levels of free energy minima, barriers, and saddle points are consistent across different training runs. This gauge
invariance makes $F_G$ the natural framework for comparing FESs obtained from independently trained instances of MLCVs with the same architecture, and it favors comparisons across architectures parameterized with different hyperparameters. Another area where the application of MLCVs requires care is the reproducibility of sampling
efficiency in biased simulations, since variability in the Jacobian arising from stochastic training and hyperparameter choices can lead to unreproducible biasing forces - including spikes or vanishing
gradients - across different training instances (see Fig. [fig:MLCVs_and_gradients](#fig:MLCVs_and_gradients)b) [@Dietrich2025]. Building on the concept of Geometric FES discussed above, Ref. [@Dietrich2025] proposes gradient
normalization as a simple and effective approach to mitigate this issue.

(machine-learningenhanced-transition-path-sampling)=
## Machine-Learning--Enhanced Transition-Path Sampling

Machine learning is reshaping transition-path sampling (TPS) by enabling
adaptive discovery of reactive trajectories in complex systems. Recent
approaches merge ML inference with path-sampling algorithms, allowing
the committor, transition paths, and even full path ensembles to be
learned directly from data. Bolhuis and co-workers developed AIMMD [@lazzeri2023molecular], which trains a surrogate model for adaptive reweighting and importance sampling in trajectory space. Applied to
chignolin folding, it reproduces free energies, rates, and mechanisms at
a fraction of the cost of conventional TPS by learning the committor
self-consistently. Jung et al. [@jung2023machine] introduced an
autonomous ML-TPS framework that iteratively trains a neural-network
committor from shooting outcomes, refocusing sampling near transition
states. Tested on ion association, hydrate nucleation, polymer folding,
and membrane-protein assembly, it yields accurate rates and
interpretable mechanisms without predefined reaction coordinates. Chipot
and co-workers [@chen2023discovering] implemented the
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

{#refs .references .csl-bib-body .hanging-indent entry-spacing="0"}
