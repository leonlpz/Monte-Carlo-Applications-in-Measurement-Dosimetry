# Monte-Carlo-Applications-in-Measurement-Dosimetry
Educational Objectives
	* Understand measurement dosimetry fundamentals 
	* Understand the role of Monte Carlo transport in measurement dosimetry
	* To appreciate the possibilities MC can give us in terms of making measurement dosimetry more accurate
The Monte Carlo technique for the simulation of the transport of electrons and photons through bulk media consist of using knowledge of the probability distributions governing the individual interactions of electrons and photons in materials to simulate the random trajectories of individual particles. One keeps track of physical quantities of interest for a large number of histories to provide the required information about the average quantities.
The code presented here shows a simple MC simulation of how particles move in discrete steps (Step length selection from probability distributions) from one interaction site (Interaction type selection from probability distributions) to the next using random number generation.
# Putting a Monte Carlo simulation together:
Input: Interaction probability distributions. Random Number Generator.
Output: Dose distributions, fluence spectra, …
# Simple photon simulation 
	Say: \Sigma_{total}=\Sigma_{compton}+\Sigma_{pair}\ \ \ \ \ \ \ \ cm^{-1}
	![formula](https://render.githubusercontent.com/render/math?math=e^{i \pi} = -1)
	Select 2 random numbers R1, R2
	Uniform between 0 and 1
	Whole careers devoted to doing this 
	Cycle length
# Photon transport (cont)
How far does photon go before interacting?
x=-ln\left(R1\right)/\Sigma_{total}\ \ \ \ \ \ \ \ \ \ cm
Is exponentially distributed [0, infinite].
With a mean of 
1/\Sigma_{total}
After going x, what interaction occurs?
ifR2<\frac{\Sigma_{compton}}{\Sigma_{total}}
Then a Compton scatter occurs otherwise a pair production event occurs 
# How is simulation used?
	Score whatever data wanted
	Average distance to interaction 
	How many of each type?
	Energy deposited by each type
	Etc
	More useful in complex cases

