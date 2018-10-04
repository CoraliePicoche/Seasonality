rm(list=ls())
graphics.off()

set.seed(42)
mu=293
sigma=5
t=365*5
sub=24
a=rnorm(t,mu,sigma)

wn=rep(NA,t*sub)
for (i in 1:t){
	wn[(1+(i-1)*sub):(i*sub)]=rep(a[i],sub)
}
x = spectrum(wn, spans=50)

pdf("spectrum_white_noise.pdf")
plot(x$freq[(x$freq<0.1)],x$spec[(x$freq<0.1)])
dev.off()
