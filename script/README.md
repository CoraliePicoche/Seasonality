Scripts

This folder contains all the scripts which are necessary to reproduce the results in "How self-regulation, the storage effect and their interaction contribute to coexistence in stochastic and seasonal environments" (Picoche & Barraquand 2019). They are listed below. 
* `main_all_at_once_mortavariable.m`: This script simulates the dynamics of the community for 8 different combinations of coexistence mechanisms and environmental signals. It uses the functions `compute_temperature_season` to model a random temperature signal, `growth_response` and `frac_max` to compute the growth rates of the different species as a function of the daily temperature and `SV16_ode_integration` and `SV16_ode_integration_no_GR_in_competition` to integrate their dynamics with and without the storage effect. In this file, mortality varies between species: the `m_var` parameter needs to be set to 0 to keep mortality constant.
* `analysis_growth_rates.m` outputs a textfile containing the minimum, mean and maximum growth rates over 100 simulations.
* `figure1_article.m` prints Fig. 1  in the article, showing the dynamics of the species for one simulation
* `nb_extant_species.m` prints Fig. 2 in the article, showing the number of species at the end of the simulations
* `mean_biomass_stable_cases.m` prints Fig. 3, showing the biomass distribution in the cases with none of the coexistence mechanisms, and with both of them. It uses the function `species_mean_value.m` to compute the mean biomass of each species at the end of each simulation.
* `mean_biomass_unstable_draft.m` prints Fig. 4, showing the biomass distribution in the cases with either the storage effect or a strong self-regulation. It uses the function `species_mean_value.m` to compute the mean biomass of each species at the end of each simulation.

A few other scripts were used to process and output intermediate results. They are stored in the "exploratory" directory. 
