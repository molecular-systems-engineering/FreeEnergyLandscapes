(free-energy-profiles-and-equilibrium-constants)=
# Free Energy Profiles and Equilibrium Constants

Free energy profiles and PMFs link probabilities to partition functions, allowing computation of equilibrium constants for binding reactions.
Care must be taken when connecting to standard free energies, as
equilibrium constants in statistical mechanics depend on the reference concentration and are dimensionless, while experimental $\Delta G^\circ$ values refer to $c^\circ=1$ M. To avoid confusion, here we refer to the (concentration-based) mass action equilibrium constant using the symbol $K_c$. For association reactions $R+L\rightleftharpoons RL$, the mass action law gives $$K_c=\frac{[RL]}{[R][L]},\qquad \Delta G^\circ=-kT\ln(K_c c^\circ),$$ but this holds only in the thermodynamic limit. In finite simulation boxes containing one receptor and one ligand, the equilibrium constant is instead expressed through 
the ratio of Boltzmann probabilities for bound and unbound states [@de2011determining]:
$$\Delta G^\circ=-kT\ln\frac{p(RL)}{p(R+L)}-kT\ln(c^\circ/c),$$ where $c$ is the box concentration, and volume change effects are neglected.
Writing $p(RL)/p(R+L)=Q_{RL}/Q_{R+L}$, the corresponding mass action
equilibrium constant becomes $K_c=VQ_{RL}/Q_{R+L}$. Roux proposed an
equivalent form using a delta function to fix the ligand in bulk 
[@woo2005calculation; @roux2008comment]. Gilson et al. derived
the same constant from activities for a rigid ligand,

$$
\Delta G^\circ=-RT\ln\left(\frac{c^\circ}{8\pi^2}\frac{\sigma_R\sigma_L}{\sigma_{RL}}\frac{Q_{RL}Q_S}{Q_RQ_L}\right)+P^\circ\Delta\bar V_{AB},
$$

where the $8\pi^2$ term arises from rotational integration, $\sigma_i$
are symmetry numbers, and $Q_S$ the solvent partition function. The
contribution coming from volume changes
$\Delta \bar V_{LR} = V_{LR} -V_L -V_R$ is spelled out explicitly, and the infinite dilution identity $Q_RQ_L/ Q_S = Q_{R+L}$ has been used.
This formulation underpins the double--decoupling method (DDM), in which the ratio of partition functions is obtained by decoupling the ligand at the binding site and in the bulk. Boresch et al. introduced a minimal set of six restraints (one distance $r$, two angles $\theta_i$, and three dihedral angles $\phi_i$) to restore the free energy cost of decoupling. The correction is expressed in terms of the respective equilibrium distance $r_0$, angles $\theta_{i,0}$, and force constants $K_r$, $K_{\theta_i}$ and $K_{\phi_i}$, as
$$\Delta G_{\rm restr}=-kT\ln\frac{8\pi^2V\sqrt{K_rK_{\theta_1}K_{\theta_2}K_{\phi_1}K_{\phi_2}K_{\phi_3}}}{r_0^2\sin\theta_{1,0}\sin\theta_{2,0}(2\pi kT)^3}.$$
The DDM thus provides a general alchemical framework---encompassing
confine-and-release variants---whose rigor relies on the proper
application and unbiasing of restraints [@gilson1997statistical; @bian2025formally]. 