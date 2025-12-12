The rapid convergence of machine learning with enhanced sampling and
free-energy methodologies marks a genuine paradigm shift: starting with
the automated design of collective variables, machine learning is now
reshaping how we represent, explore, and interpret molecular free-energy
landscapes---blurring the boundaries between sampling, bias
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
reader to the extensive overviews by Noe' et al. [@noe2020machine],
Mehdi et al. and [@mehdi2024enhanced], Zhu et al.[@zhu2025enhanced].

The natural complement to MLCVs is their integration with enhanced
sampling methods (see section [sec:Computing](#sec:Computing)), where
CVs serve as biasing coordinates to accelerate the simulation of rare
events. Machine learning can be used both to discover effective CVs and
to mitigate bias potential in real time. Iterative schemes such as
active enhanced sampling alternate between sampling and learning,
progressively refining the CV toward a dynamically optimal
coordinate.[@ribeiro2018reweighted; @wang2019past; @ray2023deep; @trizio2025everything]

## Synergies between Machine Learned CVs and Biased Sampling

The synergy between sampling and MLCVs lies in the ability to close the
loop between exploration and representation: sampling generates data to
train the MLCV, while the improved CV, in turn, enhances the exploration
of the configuration space. As discussed in Section
[sec:Computing](#sec:Computing), variational and autoencoder-based CVs
can be coupled with metadynamics, adaptive biasing force, or OPES
enhanced sampling, allowing the reconstruction of free energy surfaces
along machine-learned coordinates. In practice, one can (i) learn a
low-dimensional representation of slow dynamics, (ii) deploy a given
learnt representation as a biasing coordinate in MetaD/VES/OPES/ABF (see
Section [sec:Computing](#sec:Computing)), and (iii) periodically
re-train or fine-tune the model on newly sampled configurations. This
"close the loop" workflow, exemplified by, i.e. RAVE
[@ribeiro2018reweighted], is highlighted and discussed in detail across
recent reviews
[@noe2020machine; @henin2022enhanced; @mehdi2024enhanced; @zhu2025enhanced]
and case studies, where the bias is either optimized variationally
[@ves_valsson2014; @bonati2019neural] or built adaptively from
visitation statistics (as in MetaD, OPES or ABF), and estimators are
used to recover unbiased thermodynamics and kinetics from biased
trajectories[@comer2015adaptive; @metaD_reweight].

Conceptually, the shared thread is that learning and sampling are
mutually reinforcing: sampling provides diverse, dynamically relevant
data, while learning condenses this into CVs that maximize timescale
separation. Enhanced sampling uses those CVs to push the system into
under-explored regions of phase space. When combined with periodic
retraining, this loop yields CVs that are both physically meaningful and
effective, enabling the driving of rare events with minimal user
supervision
[@noe2020machine; @henin2022enhanced; @mehdi2024enhanced; @zhu2025enhanced].

## Machine Learning CVs

Traditionally, collective variables (CVs) have been designed from
physical intuition---for example, distances in ion-pair association,
torsional angles in peptide isomerization, or bond-order parameters in
crystallization. Such handcrafted descriptors have been instrumental in
molecular simulations for decades, enabling the projection of complex
dynamics onto interpretable coordinates (see Section
[sec:CVs](#sec:CVs)). Yet, they are rarely optimal. In high-dimensional
systems, where the relevant slow modes arise from nonlinear couplings of
many atomic degrees of freedom, physically inspired CVs may fail to
distinguish metastable states or to capture the true kinetic bottlenecks
of phase-space exploration (see Section [sec:CVs](#sec:CVs) and
committor box). This realization has prompted the development of
machine-learned collective variables (MLCVs), which employ data-driven
algorithms to infer optimal low-dimensional representations directly
from simulation trajectories
[@gokdemir2025machine; @desgranges2025deciphering; @neha2022collective].

The field of MLCVs encompasses a spectrum of methodologies that can be
broadly grouped by the learning principle they adopt. Unsupervised
approaches---including principal component analysis
[@garcia1992large; @amadei1993essential; @hegger2007complex; @wetzel2017unsupervised],
diffusion maps [@ferguson2011integrating; @preto2014fast], sketch-map
[@ceriotti2011simplifying; @tribello2012using], and autoencoders
[@chen2018molecular; @wehmeyer2018time; @lemke2019encodermap]---learn
low-dimensional manifolds that preserve the variance or geometric
structure of the high-dimensional trajectory data. These methods are
effective for capturing dominant structural fluctuations, such as
protein conformational changes or order--disorder transitions in solids,
but they are not guaranteed to recover dynamical slow modes.

In contrast, variational and supervised methods explicitly target
dynamical relevance. The variational approach to conformational dynamics
(VAC, [@noe2013variational; @nuske2014variational]) defines an optimal
reaction coordinate as the mapping that maximizes the time-lagged
autocorrelation of the projected dynamics---equivalently, the leading
eigenfunction of the transfer operator. Implementations such as
time-lagged independent component analysis (TICA)
[@perez2013identification], VAMPnets [@mardt2018vampnets], and
state-free reversible VAMPnets (SRV) [@chen2019nonlinear] learn
nonlinear transformations that approximate these slow eigenmodes, often
in the form of neural-network embeddings. Closely related are
information-bottleneck formulations, such as RAVE (reweighted
autoencoded variational Bayes for enhanced sampling)
[@ribeiro2018reweighted], SPIB [@wang2019past] and variational dynamic
encoders (VDE) [@hernandez2018variational], which train neural networks
to identify minimally complex yet maximally predictive latent variables,
thus approximating the committor function (see the dedicated box above).
Complementary to these are discriminant-based approaches that use
labeled metastable states: linear discriminant analysis (LDA) and its
harmonic variant (HLDA) construct transparent, differentiable linear CVs
that maximize between-state separation
[@mendels2018collective; @piccini2018metadynamics]. Their nonlinear
extensions, Deep-LDA and Deep-TDA, replace the linear map with a neural
network, yielding smooth, expressive CVs that integrate seamlessly with
biased enhanced sampling methods such as US, MetaD, VES, and OPES for
free-energy reconstruction [@bonati2020data; @trizio2021enhanced].

These algorithms have found widespread applications across various
fields, including ligand binding [@wang2019past], conformational
transitions
[@hernandez2018variational; @mardt2018vampnets; @chen2019nonlinear; @preto2014fast],
self-assembly[@jung2023machine; @boninsegna2018data], and phase
transformations [@finney2023variational; @ziyue2023driving].

## Graph-based and symmetry-aware CV architectures

A recent frontier in the construction of MLCVs is the use of graph
neural networks (GNNs) and geometric deep learning architectures, which
natively encode the fundamental symmetries of molecular
systems---translation, rotation, and permutation invariance of identical
atoms. By representing atomic environments as graphs with nodes (atoms)
and edges (interactions), these architectures eliminate the need for
explicit handcrafted descriptors such as symmetry functions or
Steinhardt order parameters [@Dietrich2023; @zhang2024descriptor].

In the GNN framework, CVs are learned as functions on graphs that
aggregate local neighborhood information through message passing and
pooling operations. This allows the model to infer collective measures
of order directly from atomic coordinates while preserving physical
invariances. Two recent examples demonstrate the potential of this
approach. In Dietrich et al. [@Dietrich2023], graph-based models were
trained to approximate nucleation order parameters in colloidal and
metallic systems. The learned variables reproduced the behaviour of
conventional $Q_6$-based crystallinity measures, but with an
order-of-magnitude computational speedup, enabling on-the-fly biasing in
umbrella sampling and metadynamics. The same trained network was
transferable across system sizes and even between distinct materials,
highlighting the potential of GNN-CVs as general-purpose descriptors of
local order. Similarly, Zhang et al. [@zhang2024descriptor] introduced
descriptor-free collective variables from geometric graph neural
networks, extending the concept to molecular systems and demonstrating
how equivariant layers can learn rotationally consistent embeddings of
atomic environments without predefined order parameters. The resulting
CVs proved robust under biasing with On-the-Fly Probability Enhanced
Sampling (OPES), maintaining physical interpretability and symmetry
preservation.

```{figure} Figures/Figure_MLCVs.png
:name: fig:MLCVs_and_gradients
:width: 1.2\linewidth
Graph neural network (GNN) models for learning nucleation collective variables (CVs) and subtle issues in their application within enhanced sampling for the calculation of FESs. (a) Schematic depiction of the GNN-based method. Molecular or atomic graphs are constructed using a neighbor list algorithm, and Cartesian coordinates are embedded into higher-dimensional representations via multilayer perceptrons. Node embeddings are iteratively updated through edge embeddings and pooled to yield one-dimensional CV predictions. Adapted with permission from Ref. (F. et al. 2023) (b) Spread of gradient norms of four models with two different architectures (25 latent dimensions + graph convolutional layer, red and blue; and 10 latent dimensions + 1 graph convolutional layer, gold and green) trained to the same accuracy over 100 random configurations. Dashed lines indicate the median norm of each model. Adapted with permission Ref. (Dietrich and Salvalaglio 2025)
```

## Machine Learning the Committor

In the variational approach presented by Kang et al.
[@kang2024computing] and Trizio et al. [@trizio2025everything], the
committor is represented as a differentiable model
$p_B(\mathbf{r}) = [1 + e^{-q(\mathbf{r}|w)}]^{-1}$, where
$q(\mathbf{r}|w)$ is a neural-network, function of physically motivated
descriptors. The parameters of the NN, $w$, are optimized by maximizing
the consistency between predicted and observed transition outcomes. This
strategy generalizes the likelihood maximization of Peters and Trout
[@peters2006obtaining] and directly yields a smooth, differentiable
approximation to the committor that can be analyzed, differentiated, and
even symbolically regressed to human-interpretable forms. Applying a
variational principle allows this problem to be reformulated in terms of
the Kolmogorov functional:
$$K[q] = \langle |\nabla q(\mathbf{r})|^2 \rangle_{U(\mathbf{r})}$$
whose minimization under boundary conditions $q(\mathbf{r}_A)=0$ and
$q(\mathbf{r}_B)=1$ yields the committor function satisfying the
Kolmogorov equation for overdamped dynamics[@trizio2025everything]. This
principle defines the Kolmogorov ensemble, in which configurations are
sampled with probability
$p_K(\mathbf{r}) \propto e^{-\beta [U(\mathbf{r}) + V_K(\mathbf{r})]}$,
and where the committor-dependent bias
$V_K(\mathbf{r}) = -\beta^{-1}\log|\nabla q(\mathbf{r})|^2$ stabilizes
configurations belonging to the transition-state
region[@kang2024computing]. Using this framework, Trizio et al.
demonstrated that the learned approximation of the committor can be used
not only to characterize the transition-state ensemble but also to drive
enhanced sampling by coupling the Kolmogorov bias with on-the-fly
probability enhanced sampling
(OPES)[@kang2024computing; @trizio2025everything]. In this extended
formulation, the pre-activation of the neural network, $z(\mathbf{r})$,
serves as a smooth committor-based CV, enabling the exploration of
metastable basins *and* transition states within a single
self-consistent workflow. The resulting probability-based enhanced
sampling approach, as applied by Trizio et al. [@trizio2025everything],
was used to model processes ranging from protein folding to ligand
binding, accurately reproducing free-energy surfaces and reactive
pathways while retaining interpretability and physical transparency.

Hummer and co-workers developed an autonomous path sampling algorithm
that integrates deep learning with TPS (see Sec. [sec:tps](#sec:tps)).
In this scheme, each trial shooting trajectory contributes a Bernoulli
data point -whether it commits to $A$ or $B$- used to refine the network
approximation of $p_B(x)$. The learned committor, in turn, guides
subsequent shooting moves toward regions of maximal reactive probability
$p_B\simeq1/2$, creating a feedback loop between learning and sampling.
Once trained, symbolic regression condenses the network into compact
analytical expressions that reveal the mechanistic coordinates
controlling the transition. Applied to diverse systems, including ion
association in water, methane clathrate nucleation, polymer folding, and
membrane-protein assembly, this framework uncovered interpretable
reaction coordinates: the coordination and reorientation of water around
cations in ion-pair formation, the interplay between temperature and
crystalline motifs in hydrate nucleation, and residue contacts in
protein dimerization. In each case, the learned committor provided an
operational route to the *ideal* reaction coordinate, linking
data-driven models with path-sampling theory.

The accurate sampling and learning of the committor in high-dimensional
molecular systems remains an area of active research, uniting
developments in transition-path theory, enhanced-sampling algorithms,
and machine-learning representations to make the "ideal" reaction
coordinate a practical and learnable object.

### FESs and sampling with MLCVs: some cautionary tales

As discussed above, MLCVs hold remarkable potential to complement the
definition and calculation of useful FESs. Projecting onto MLCV spaces,
however, raises subtle issues. As highlighted in Ref. [@Dietrich2025],
the mapping $\xi(\mathbf{r})$, when obtained through an MLCV is not
uniquely defined: different neural network trainings with identical
architectures and hyperparameters can lead to different embeddings,
altering the Jacobian $J_\xi = \partial \xi/\partial \mathbf{r}$, as
discussed in section [sec:Geometric](#sec:Geometric). Given that
$$p({\xi}) = \frac{1}{Z} \int_{\Sigma_{\xi}} e^{-\beta U(R)} \mathrm{vol}(J_\xi)^{-1} d\sigma$$
The shape of $F(\xi)$ can vary across training instances even when all
models capture the same metastable states. This non-reproducibility
problem is specific to machine-learned CVs and is absent in physically
defined variables. An effective solution is the adoption of an
alternative definition of the FES, common to applications in
computational kinetics, i.e., a *gauge-invariant* or *Geometric*
FES[@HartmannSchutte07; @Hartmann2011; @BalGauge]:
$$F_G({\xi}) = -kT \ln q({\xi}), \quad q({\xi}) = \int_{\Sigma_{\xi}} e^{-\beta U(R)} d\sigma,$$
where $\int_{\Sigma_\xi}$ indicates the integral on the hypersurface
defined by the level-set of all the configurations degenerate in $\xi$,
and $d\sigma$ the infinitesimal element of such hypersurface. This
effectively removes the explicit Jacobian dependence of $F(\xi)$.
Moreover, $F_G(\xi)$ is invariant under any monotonic transformation of
the CVs, ensuring that the levels of free energy minima, barriers, and
saddle points are consistent across different training runs. This gauge
invariance makes $F_G$ the natural framework for comparing free energy
surfaces obtained from independently trained instances of MLCVs with the
same architectures, and favours comparisons across architectures
parameterized with a different set of hyperparameters.

Another area where the application of MLCVs requires care is in the
reproducibility of the sampling efficiency associated with their
deployment in Biased simulations. For instance, in *biased* enhanced
sampling, the bias potential $V(\xi)$ is applied along the chosen CVs.
The forces introduced by this bias, responsible for the enhanced
exploration of configuration space, are proportional to the gradient of
the CVs with respect to atomic coordinates:
$$\mathbf{f} = -\nabla_\mathbf{r}V(\xi(\mathbf{r})) = - \frac{\partial V}{\partial \xi} \frac{\partial \xi}{\partial \mathbf{r}}.$$
For MLCVs, the variability in the Jacobian due to the inherent
stochasticity of the training process, as well as differences in the
hyperparameters chosen for a given CV model, can give rise to
unreproducible biasing forces (see Fig.
[fig:MLCVs_and_gradients](#fig:MLCVs_and_gradients)b) --- leading to
force spikes or vanishing gradients between different training
instances. In this context, Ref. [@Dietrich2025] proposes gradient
normalization as a practical and straightforward approach to alleviate
this effect, ensuring that the bias acts consistently across models and
equalizes the sampling behavior across different training instances of
the same family of ML models [@Dietrich2025]. Moreover, as discussed in
the following section, gradient normalization finds theoretical support
in the definition of the Geometrical FES, a concept that, while
pre-dating MLCVs [@HartmannSchutte07; @Hartmann2011], becomes central to
the reproducibility of FESs computed with MLCVs [@Dietrich2025].

## Machine-Learning--Enhanced Transition-Path Sampling

The impact of ML techniques on methods for sampling and evaluating FESs
is also significantly affecting methods based on transition-path
sampling. The search for reactive trajectories in complex molecular
systems is an inherently complex task. Recent work has begun to merge
these path-sampling algorithms with machine-learning inference, allowing
the committor, transition paths, and even the equilibrium path ensemble
to be learned adaptively from data. Bolhuis and coworkers, for example,
developed an algorithm (AIMMD) [@lazzeri2023molecular] that approximates
the equilibrium path ensemble from machine-learning-guided path-sampling
data. Their method trains a surrogate model to enable adaptive
reweighting and importance sampling in trajectory space. Applied to the
folding of chignolin, the algorithm yields accurate free energies,
rates, and mechanisms at a fraction of the cost of conventional TPS. The
reason for the high efficiency is rooted in the algorithm's ability to
learn the committor in a self-consistent manner.

```{figure} Figures/covino.jpeg
:name: fig:placeholder
:width: 0.6\linewidth
Efficient ML-enhanced TPS explains Chignolin folding. (a) Transition-state snapshot highlighting H-bonds d1–d3 and the Tyr2–Trp9 contact; (b) native structure; (c) example folding trajectory with the learned committor time series (network trained on the first 50 steps of run 1); (d) free energy vs. committor from AIMMD after 50 steps compared with long-equilibrium reference, with arrows marking contributions from state-A/B simulations and AIMMD trial paths; (e) Bayesian estimate of ν across committor values for multiple runs, with the 95% CI from equilibrium data. Reproduced with permission from Ref. (Lazzeri et al. 2023). 
```

Jung et al.[@jung2023machine] developed an autonomous machine-learning
TPS framework that iteratively trains a neural-network committor from
shooting outcomes and refocuses sampling near transition states, thereby
enhancing the ability to extract interpretable mechanistic models.
Demonstrated on ion association, hydrate nucleation, polymer folding,
and membrane-protein assembly, the method recovers rates, dominant
pathways, and reveals molecular mechanisms without predefined reaction
coordinates.

Chipot and co-workers[@chen2023discovering] introduced a
neural-network-based approach to determine the committor probability by
implementing the variational principle of transition path theory. This
work provided the theoretical foundation for later committor-consistent
learning schemes such as the method of Megías et al., who recently
proposed an iterative, variational neural-network framework that
simultaneously learns the committor function and a representation of the
dominant transition tube. Their path-committor-consistent ANN (PCCANN)
builds on a finite-time-lag variational principle, minimizing the
committor time-correlation function
$C_{qq}(\tau)=\tfrac12\langle(q(\tau)-q(0))^2\rangle$, thus avoiding the
overdamped Brownian approximation typical of earlier variational
committor networks. The network iteratively alternates between biased MD
sampling and committor retraining, progressively refining a
path-collective variable until convergence is achieved. This procedure
yields committor-consistent reaction pathways and identifies multiple
competing channels. Applications to benchmark systems, NANMA
isomerization, and chignolin folding demonstrate accurate rate constants
and mechanisms with robust performance across architectures.

Together, these developments signal a paradigm shift from fixed-bias or
coordinate-based enhanced sampling toward learned representations of
path ensembles. These approaches decouple transition-path discovery from
predefined collective variables and exploit machine learning to reuse
data, reduce sampling cost, and generalize across systems. They
represent the early generation of data-driven transition-path theories,
paving the way for future schemes that integrate generative models or
diffusion-based samplers to learn full reactive fluxes in
high-dimensional systems.

# References
