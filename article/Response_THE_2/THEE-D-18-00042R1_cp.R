
require(deSolve) ## for solving ODEs
require(nleqslv) ## for solving nonlinear algebraic equations (to obtain the b's)
require(tidyverse) ## for efficient data manipulation and plotting

## intrinsic growth function
## input:
## - tau: temperature [K]
## - tauopt: vector of species' thermal optima [K]
## - b: vector of scaling factors (obtained from Eq. 4 in the manuscript) [1/K^3]
## - artau0: growth rate at reference temperature [1/yr]
## - Er: activation energy [eV]
## - tau0: reference temperature [K]
## - k: Boltzmann's constant [eV/K]
## output: intrinsic growth rate [1/yr]
r <- function(tau, tauopt, b, artau0=386, Er=0.467, tau0=293, k=8.617e-5) {
    return(
        artau0*exp(Er*(tau-tau0)/(k*tau*tau0))*
        ifelse(tau<=tauopt,exp(-abs(tau-tauopt)^3/b),exp(-5*abs(tau-tauopt)^3/b))
    )
}

## function to obtain the b's by numerically solving Eq. 4 in the manuscript
## input:
## - tauopt: thermal optimum of one species [K]
## - A: niche breadth [K/yr]
## - artau0: growth rate at reference temperature [1/yr]
## - Er: activation energy [eV]
## - tau0: reference temperature [K]
## - k: Boltzmann's constant [eV/K]
## output: scaling factor b of one species
getb <- function(tauopt, A=10^3.1, artau0=386, Er=0.467, tau0=293, k=8.617e-5) {
    b <- rep(0, length(tauopt))
    for (i in 1:length(tauopt)) { ## solve for b[i] of each species in turn
        b[i] <- nleqslv(10, function(b) sum(r(seq(280, 330, by=0.01),
                                              tauopt[i], b))*0.01-A)$x
    }
    return(b)
}

## apply smoothed step function to a vector (to help with numerical integration):
## values less than 0 are set to 0, values between 0 and the designated
## threshold a are set to 3*(n/a)^2-2*(n/a)^3, and those larger than a are set to 1
## input:
## - n: vector of values
## - a: cutoff threshold
## output: array of values with smoothed step function applied to them
cutoff <- function(n, a=1e-8) {
    return(1*(n<a)*(3*(n/a)^2-2*(n/a)^3)*ifelse(n<0, 0, 1)+ifelse(n<a, 0, 1))
}

## right hand side of differential equations, with the smoothed cutoff function
## applied to avoid numerical truncation to negative densities
## input:
## - time: moment at which rhs is evaluated
## - n: vector of species' densities
## - pars: list of model parameters (tauopt, b, a, m)
## output: vector of time derivatives of species' densities
eqs <- function(time, n, pars) {
    rtau <- r(temp[floor(time/pars$h)+1], pars$tauopt, pars$b)
    return(list(n*(rtau*(1-pars$a%*%n)-pars$m)*cutoff(n)))
}

set.seed(54321) ## set random seed (for reproducibility)
S <- 60 ## number of species
alpha <- 0.001 ## interspecific competition strength [1/density]
theta <- 0 ## scaling between white and monochromatic noise {0, 1.3}
rho <- alpha ## ratio of intra- to interspecific competition {alpha, 10*alpha}
a <- matrix(alpha, S, S) + diag(rep(rho-alpha, S)) ## competition matrix
m <- 15 + 0.1*runif(S, -1, 1) ## mortalities with species-specific variation [1/yr]
mu <- 293 ## mean temperature [K]
sigma <- 5 ## temperature standard deviation [K]
taumin <- 288 ## minimum thermal optimum [K]
taumax <- 298 ## maximum thermal optimum [K]
tauopt <- sort(runif(S, taumin, taumax)) ## species' thermal optima [K]
b <- getb(tauopt) ## solve for species' scaling factors b
h <- 1/365 ## size of time step
tmax <- 5000 ## number of years to integrate for
tmax <- 500 ## JUST CHECKING WE HAVE THE SAME RESULTS CP
time <- seq(0, tmax, by=h) ## time axis
time2 <- seq(tmax-2, tmax, by=h) ## time axis to output CP
temp <- mu + theta*sigma*sin(2*pi*time) +
    rnorm(length(time),0,5*sqrt(1-theta^2/2)) ## temperature time series
ninit <- rep(1/(alpha*S), S) ## initial conditions
pars <- list(tauopt=tauopt, b=b, a=a, m=m, h=h) ## coerce parameters into list

print(Sys.time()) #CP
## solve ODEs and organize data
#sol <- ode(func=eqs, y=ninit, parms=pars, times=c(time[0],time2), method="rk4") %>% #CP modified times, was times=time before
sol <- ode(func=eqs, y=ninit, parms=pars, times=time, method="rk4") %>% 
    as.data.frame %>% ## convert to data frame (must be done for next step to work)
    as_data_frame %>% ## convert to tibble (same as data frame but better)
    gather("species", "density", 2:(S+1), factor_key=TRUE) ## key-value pairs
print(Sys.time()) #CP

stop() #CP
## plot time series for last 2 years
sol %>%
    filter(time>=(tmax-2)) %>% ## restrict data to last 2 years only
    ggplot() + ## start plotting
    geom_line(aes(x=time, y=density, colour=species))

## table of mean densities of extant species over the last 2 years
sol %>%
    filter(time>=(tmax-2)) %>% ## restrict to last 2 years
    group_by(species) %>% ## grouping variable: species
    summarise(meandensity=mean(density)) %>% ## obtain mean density per species
    filter(meandensity>1e-6) %>% ## drop extinct species
    print(n=Inf) ## print on screen, without omitting any rows

## plot number of extant species against time
sol %>%
    mutate(time=50*trunc(time/50)) %>% ## truncate time
    group_by(species, time) %>% ## for each species and (truncated) time point:
    summarise(meandensity=mean(density)) %>% ## obtain mean density
    mutate(extant=ifelse(meandensity>1e-6, 1, 0)) %>% ## species extinct below 1e-6
    ungroup %>% ## remove grouping information
    group_by(time) %>% ## now group by time only:
    summarise(numsp=sum(extant)) %>% ## get number of extant species
    ggplot() + ## start plotting
    geom_point(aes(x=time, y=numsp)) +
    geom_line(aes(x=time, y=numsp), linetype="dashed", alpha=0.2) +
    scale_y_continuous(name="number of species", limits=c(0, S))

