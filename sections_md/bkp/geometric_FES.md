(sec:Geometric)=
## Position-dependent compression of configuration space: Geometric Free Energy Surfaces

When a free energy profile is expressed along a curvilinear coordinate,
geometric factors arise naturally. For example, with a distance
coordinate, the probability density scales with the hyperspherical shell
area, introducing an entropic term in the potential of mean force. This
contribution stems purely from configuration-space geometry, as a single
coordinate value need not represent a distinct macroscopic state.

(potential-of-mean-force-and-the-role-of-the-metric)=
### Potential of Mean Force and the role of the metric

The potential of mean force(Onsager 1933; Kirkwood and Buff 1949)
formalizes the idea that an effective two-body potential could describe
many-body correlations averaged over solvent and other particles. The
probability density $p(\xi)$ of a RC $\xi(\mathbf r)$ to have a specific
value $\xi$ is
$$p(\xi)=\frac{1}{Q}\int \delta\big(\xi^\prime(\mathbf r)-\xi\big)e^{-\beta U(\mathbf r)}d\mathbf r,$$
and the PMF with respect to a reference $\xi_0$ is usually written as
$$w(\xi)=-\kT\ln p(\xi)+w(\xi_0).$$ One subtlety of this expression is
the metric factor (with respect to the Cartesian coordinate) that is
implicitly carried by the probability density. Intuitively, when the
potential $U=0$, the PMF should be uniform, and the probability of
finding the system in a region of configuration space must be
proportional to the accessible volume. For the distance $r$ between two
particles, the probability scales with the volume of the spherical shell
$4\pi r^{2} dr$. This motivates writing the PMF from the probability
density of finding the particle between $r$ and $r+dr$ as
$$p(r) \propto 4\pi r^{2}e^{-\beta w(r)},
\qquad
w(r)=-\kT\ln \left[ p(r)/ 4 \pi r^2\right] +\mathrm{const}.$$ The extra
term $\kT\ln(4\pi r^2)$ is therefore of entropic origin, reflecting the
growing number of configurations at larger separations. The rigorous way
to determine the correct metric factor is by marginalizing the full
phase--space density. In generalized coordinates $\mathbf{q}$ with
conjugate momenta $\mathbf{p}$, the canonical distribution is (Gibbs
1928)
$$p(\mathbf{q},\mathbf{p})\propto e^{-\beta \left[ \frac{1}{2} \mathbf{p}^t M^{-1}(\mathbf{q})\mathbf{p} + U(\mathbf{q})\right]},\label{eq:metric-factor-origin}$$
with the mass--metric tensor
$M(\mathbf{q})=J_\mathbf{r}^t m J_\mathbf{r}$, where $J_\mathbf{r}$ is
the Jacobian matrix of the transformation from Cartesian to generalized
coordinates $J_\mathbf r = \partial \mathbf r/ \partial \mathbf q$, and
$m$ the diagonal matrix with the atomic masses. Integrating out momenta
via a Gaussian integral gives
$$\int e^{-\frac{1}{2}\beta \mathbf{p}^tM^{-1}\mathbf{p}}d\mathbf{p} 
= (2\pi \kT)^{n/2}\sqrt{\det M(\mathbf{q})},$$ so that the
configurational probability is
$$p(\mathbf{q})\propto \sqrt{\det M(\mathbf{q}) } e^{-\beta U(\mathbf{q})},$$
where the element of volume is
$\sqrt{\det M(\mathbf{q}) } d\mathbf q  =  \mathrm{vol}(J_\mathbf{r}) d\mathbf q$.
If the masses are all equal, they factorize out, and instead of $M$, the
metric factor $g(\mathbf q) = J_\mathbf{r}^t J_\mathbf{r}$ can be used.
For spherical coordinates of a relative vector,
$\sqrt{\det g} d\mathbf q =r^{2}\sin\theta dr d\theta d\phi$, and for an
isotropic environment, integrating over the solid angle one recovers the
intuitive result.

# References

:::::: {#refs .references .csl-bib-body .hanging-indent entry-spacing="0"}
::: {#ref-gibbs1906scientific .csl-entry}
Gibbs, Josiah Willard. 1928. *The Collected Works of J. Willard Gibbs*.
Vol. 2. New York, USA: Longmans, Green; Company.
:::

::: {#ref-kirkwood_statistical_1949 .csl-entry}
Kirkwood, John G., and Frank P. Buff. 1949. "The Statistical Mechanical
Theory of Surface Tension." *J. Chem. Phys.* 17 (3): 338--43.
<https://doi.org/10.1063/1.1747248>.
:::

::: {#ref-onsager1933theories .csl-entry}
Onsager, Lars. 1933. "Theories of Concentrated Electrolytes." *Chem.
Rev.* 13 (1): 73--89.
:::
::::::
