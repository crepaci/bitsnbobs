# reference for power calculations
# some functions include visualizations/power curve

# GWAS POWER -------------------------------------------------------------------------
#' We will perform GWAS (SNP as predictor on continuous additive scale, 0/1/2) 
#' for a binary trait (any incident of [disease] complication as the outcome). 
#' Alpha and N will be set. Want to solve for (and plot) detectable effect size 
#' for varying power and MAF settings. 
#' 
#' power calculation code developed from formulas in
# https://www.mv.helsinki.fi/home/mjxpirin/GWAS_course/material/GWAS3.html
# examples 3.7 and 3.8 especially helped
GWAS.power <- function(n, n.cases, bonferroni.alpha, maf.thresholds, effect.range, df) 
{
  q = qchisq(bonferroni.alpha, df, lower=F)
  phi = n.cases/n
  dat = setNames(data.frame(matrix(ncol = 3, nrow = 0)), c("maf", "beta", "power"))
  for (f in maf.thresholds) {
    for (beta in effect.range) {
      b = abs(log(beta))
      ncp = 2*f*(1-f)*n*phi*(1-phi)*(b^2)
      power = pchisq(q, df = df, ncp = ncp, lower=F)
      newrow = c(f, beta, power)
      dat[nrow(dat)+1, ] = newrow
    }
  }
  return(dat)
}

# example function call
#GWASpowermatrix = GWAS.power(n = 1463, n.cases = 725, bonferroni.alpha = 5e-8, maf.thresholds = c(0.1, 0.2, 0.35, 0.5), effect.range = seq(0, 4, by = 0.01), df = 1)

# plot GWAS power data
ggplot(data = GWASpowermatrix, aes(x = beta, y = power, group = as.factor(maf), color = as.factor(maf))) +
  geom_line(size = 2) +
  scale_color_manual(values = my_colors, name="MAF")+
  theme_bw() +
  theme(legend.position = c(0.85,0.28), text=element_text(size=16), legend.background = element_rect(fill="white",color="grey")) +
  scale_x_continuous(trans='log10', limits = c(1,4)) +
  geom_hline(yintercept=0.8, color = "black", size=1) +
  xlab('Effect Size (Odds Ratio)') +
  ylab('Power')



























