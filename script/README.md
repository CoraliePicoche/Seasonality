#19th March 2018 (AS)
* `check_for_stability_m`: A script which checks for convergence in the saved files, based on species richness, total abundance over a cycle, maximum biomass of each species over a cycle and coefficent of variation of the total biomass. UPDATE 2018/04/13 (CP) : consider this script deprecated (see `convergence_function.m`)
* `compute_temperature.m`: A function which returns a vector of temperature for each day of the simulation following a normal distribution. This function is called in `SV16_comm_assembly.m`.
* `compute_temperature_season.m`: A function which returns a vector of temperature for each day of the simulation. Temperatures are sampled following a normal distribution centred on a mean values which changes sinusoidally over time with period 365 days.
* `correlationCircles.m`: A function by David Legland which represents correlation matrix using colored circles.
* `event_invasion.m`: Event function which detects when dynamics reach invasion time.
* `event_is_zero.m`: Event function which detects the extinction of the invasive species. This event function is called in the ode integration of `SV16_species_removal.m`.
* `figure_1.m`: A function which draws a two-panel figure describing the thermal niche of S species, and their mean long-term growth rates against their thermal optima.
* `frac_max.m`: A function which calculates the fraction of maximum growth achieved for one speceis as a function of temperature, its thermal optimum and its niche breadth.
* `growth_response.m`: A function which returns a species' maximum growth rate as a function of temperature and reference temperature.
* `invasion_post_treatment.m`: A script which works on the outputs from `SV16_comm_assembly.m`. It detects communities of 2, 3, or 4 extant species, and looks for their thermal optima to describe the community structure (cf. Fig. 3 in report and Scranton & Vasseur 2016).
* `post_treatment_bis.m`: This scripts draws species synchrony over time and the distribution of thermal optima for the extant species (cf. Fig. 2 in report). UPDATE 2018/04/13 (CP) : consider this script deprecated (see `diagnostics_simulation.m`)
* `species_removal_post_treatment.m`: A script which works on the outputs from `SV16_LV_no_GR_in_competition.m`, `SV16_main.m`, and `SV16_species_removal.m`. It calculates the density variation caused by each species removal from the community, and draws the effect of knocking out species on the other species density (cf. Fig. 4 in Scranton & Vasseur (2016) and report).
* `SV16_comm_assembly.m`: *Community assembly* simulation from Scranton & Vasseur (2016) mimicking the assembly of one community starting with one species with regular addition of a new species picked from the pool of species which are not present in the community. Outputs are community dynamics over 200 years of the assembly process, and species thermal optima. Calls `SV16_ode_integration.m` for species growth rates.
* `SV16_comm_assembly_no_stochasticity.m`: Same as the above, but with the same random seed for all simulations, and the same three invaders. Temperature varies seasonally (calling `compute_temperature_season.m`). Invasion times are regularly spaced over the simulation time.
* `SV16_higherintracompetition.m`: *Species sorting* simulation from Scranton & Vasseur (2016) initiated with 60 species of equal densities 1/(alpha*S) and repeated 10 times, but with greater intra-specific competition rates.
* `SV16_main.m`: *Species sorting* simulation from Scranton & Vasseur (2016) initiated with 60 species of equal densities 1/(alpha*S) and repeated 10 times. Calls `SV16_ode_integration.m` for species growth rates.
* `SV16_ode_integration.m`: A function describing species growth rate following the model of Scranton & Vasseur (2016) with environmental forcing embedded both in the intrinsic growth rates and the competition rates.
* `SV16_ode_integration_no_GR_in_competition.m`:  A function describing species growth rate following the model of Scranton & Vasseur (2016) with environmental forcing embedded only in the intrinsic growth rates.
* `SV16_species_removal`: *Species removal and re-introduction* simulation from Scranton & Vasseur (2016). Temperatures are generated with `compute_temperature.m` without seasonality. Initial conditions are taken from a previous simulation, and the program mimicks the extinction of each species (as many simulations as there are species) and the dynamics following the primary extinction. Outputs are species dynamics over 500 years.
* `temperature_visualisation`: A script which draws the differences between different values of theta on the temperature signal.

#11th April 2018 (CP)
* `myplot_RAC` : A folder which contains the scripts by  Wei-Ting Lin to plot the Rank Abundance Curves for each community obtained at the end of the simulation. The `myplot_RAC.m` script was modified by CP to draw more "readable" graphs.
* `RAC.m` : A script which draws the RAC plots for the output communities
* `main_without_forced_competition.m`: A script corresponding to the 'Species sorting' (or `SV_main` in our folder), removing the effect of environmental forcing on the interaction coefficients (ie., removing the embedded storage effect). Different parameterisations of the community matrix A have been tried: same values for all coefficients, rows weighted by the mean growth rate of the corresponding species, or diagonal coefficients larger than the ones out of the diagonal. 
* `main_without_forced_competition_Ashby.m` : Same as above, but the coefficients of A are computed according to Ashby et al. 2017 formulation.
* `SV16_Ashbyformulation.m`: Same as `SV16_main.m`, but the coefficients of A are computed according to Ashby et al. 2017 formulation.

#13th April 2018 (CP)
* `analysis_growth_rates.m` : A script which compute the maximum, standard deviation and mean values of species-specific growth rates in different environmental conditions. It plots these values and output the text file `growth_rate_analysis` 
* `community_wide_indices.m` : A function which computes the annual synchrony indices developped by Loreau & Mazancourt (2008) and Gross et al. (2013). It outputs a table (row1=Loreau, row2=Gross, each column corresponds to a year). It is used in `synchronys_comparison`
* `synchonys_comparison.m` : A script which computes community-level synchrony indices for the regular SV model, with and without randomized temperatures.
* `species_specific_synchrony.m` : A function which computes the moving-average synchrony indices for each species, given a matrix of abundances. (corresponding to first part of Fig. 2 in SV16)
* `species_mean_value.m` : A function which computes the mean biomass of each species at the end of a simulation, given a matrix of abundances and a total number of years over which computing the mean value. (corresponding to second part of Fig. 2 in SV16)
* `convergence_function.m` : A function which computes the variation on total number of extant species and the coefficient of variation of total biomass to be able to check for simulation convergence, given a matrix of abundances. 
* `diagnostics_simulation.m` : A script which plots a series of diagnostics, given a simulation file. 
* `RAC_noforcedcompetition.m` : Same script as `RAC.m`, to compare communities without explicit storage effect. 
* `SV16_random_matrix.m` : A script corrresponding to `SV16_main.m`, always using the same environmental forcing but with different community matrices. Coefficients of interactions follow a normal distribution (more details in report). 
