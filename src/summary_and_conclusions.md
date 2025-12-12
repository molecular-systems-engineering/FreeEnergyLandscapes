This review aims to provide a comprehensive view of the necessary
framework for quantitatively understanding free energy landscapes from
the foundations to calculation techniques to modern ML approaches. By
linking the principles of statistical mechanics with molecular
simulation methodologies, we aim to bring together the conceptual and
practical steps necessary to connect microscopic configurations sampled
in molecular simulations with macroscopic thermodynamic observables.
This is particularly important, as with the rise of digital workflows,
Chemical and Biochemical Engineers increasingly turn to molecular
modeling to obtain information on the stability, reactivity, and
selectivity of molecular processes that underpin technological
applications [@digitaldesign].

We have shown how FESs translate equilibrium probabilities into readable
maps of thermodynamic stability and how their interpretation depends
critically on the choice of collective variables (CVs), order
parameters, or reaction coordinates. These variables compress the
complexity of the configuration space while retaining the essential
degrees of freedom that govern transformation and kinetics. Recognising
the interplay between the definition of CVs and the resulting FESs is
crucial for extracting physically meaningful insights from simulations.

On the computational side, we reviewed how ensuring ergodicity underlies
the estimation of equilibrium distributions of configurational
variables, and how biased sampling techniques---such as umbrella
sampling, metadynamics, and related approaches---extend the reach of
molecular simulation to processes that occur over timescales
inaccessible to brute force. Each of these methods can be understood as
a controlled modification of the sampled ensemble, designed to restore
ergodic sampling, and also to enable an unbiased recovery of
quantitative free energies.

Looking ahead, Machine Learning now complements FES practice by
proposing data-driven collective variables, variationally optimizing
bias potentials, and learning mean forces or free energies with
uncertainty estimates. Within the statistical-mechanical framework
outlined here, these tools automate aspects of the FES calculations
workflow, such as identifying efficient CVs, while maintaining
thermodynamic consistency.

We recognise that computational molecular science is evolving rapidly.
This review presents a transferable set of principles---supported by
relevant methodological implementations and examples---to help readers
address both established topics and the latest developments, enabling
molecular simulations to serve as tools for design and discovery in
molecular and process engineering.

# References
