Tiwary and Parrinello [@metaD_reweight] address the metadynamics
limitation that the evolving bias $V(\xi,t)$ yields $F(\xi)$ only up to
a time-dependent constant. Their approach is based on the observation
that, in the quasi-stationary regime, the instantaneous distribution is
written as
$$p(\mathbf{r},t)=p_0(\mathbf{r}) e^{-\beta [V(\xi(\mathbf{r}),t)-c(t)]}
\label{eq:metad_sampled_prob}$$ where $p_0(\mathbf{r})$ is the Boltzmann
distribution, and the offset $c(t)$ is defined by:
$$c(t)=\beta^{-1}\ln\frac{\displaystyle\int d\xi e^{-\beta F(\xi)}}{\displaystyle\int d\xi e^{-\beta F(\xi)+\beta V(\xi,t)}}
\label{eq:coft}$$ This makes explicit that $c(t)$ is the additive
correction that restores the unbiased Boltzmann measure.

Introducing a scaled time $\tau$ via $d\tau/dt=e^{\beta c(t)}$, they
derive a \*\*time-independent free-energy estimator\*\* valid after a
short transient and for both well-tempered (WT) and standard
metadynamics:
$$F(s)= -\frac{\gamma}{\Delta T} k_BT V(\xi,t)+k_BT\ln\int d\xi \exp\left[\frac{\gamma}{\Delta T} \frac{V(\xi,t)}{k_BT}\right],$$
with $\gamma=(T+\Delta T)/T)$. This expression removes the explicit time
dependence of $F(s)$, enabling local convergence checks and direct
comparison of FESs from simulations performed with different parameters.
Moreover, Ref. [@metaD_reweight] provides a practical route to compute
$c(t)$ on the fly.

Once $c(t)$ is available, reweighting generic observables from biased
trajectories follows from:
$$\langle O\rangle_0=\big\langle O(\mathbf R) e^{\beta [V(\xi(\mathbf R) t)-c(t)]}\big\rangle_b$$
which is analogous to the Zwanzig reweighting typically applied to
time-independent biases [@Zwanzig1954] (see Sec. [sec:FEP](#sec:FEP)).
This approach yields a rigorous reweighting for any observable, under
the assumption that the bias evolves slowly compared to CV relaxation.
It is especially effective in the well-tempered limit, where the bias
growth rate diminishes exponentially with time
[@marinova2019time; @gimondi2018building].

# References
