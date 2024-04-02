
data {
  int<lower=0> N; // Number of observations
  int<lower=1> K; // Number of parties, including 'Other'
  int<lower=1> J_age; // Number of age groups
  int<lower=1> J_edu; // Number of education levels
  int<lower=1> J_sex; // Number of sex categories
  // Interaction terms
  int<lower=1> J_age_edu;
  int<lower=1> J_age_sex;
  int<lower=1> J_edu_sex;
  // Data
  array[N] int<lower=1, upper=J_age> age;
  array[N] int<lower=1, upper=J_edu> edu;
  array[N] int<lower=1, upper=J_sex> sex;
  array[N] int<lower=1, upper=J_age_edu> age_edu;
  array[N] int<lower=1, upper=J_age_sex> age_sex;
  array[N] int<lower=1, upper=J_edu_sex> edu_sex;
  array[N] int<lower=0, upper=1> voted; // 1 if voted, 0 otherwise
  array[N] int<lower=1, upper=K> vote; // Party voted for, including 'Other'
}
parameters {
  // Voting preferences
  vector[K] beta_party; // Base preference for each party, including 'Other'
  // Turnout
  real alpha_turnout; // Base turnout intercept
  vector[J_age] beta_age_turnout;
  vector[J_edu] beta_edu_turnout;
  vector[J_sex] beta_sex_turnout;
  // Interactions
  vector[J_age_edu] beta_age_edu; // Voting preference interactions
  vector[J_age_sex] beta_age_sex;
  vector[J_edu_sex] beta_edu_sex;
  // Effects on voting for each party, including 'Other'
  matrix[K, J_age] gamma_age;
  matrix[K, J_edu] gamma_edu;
  matrix[K, J_sex] gamma_sex;
}
model {
  // Priors
  beta_party ~ normal(0, 2.5);
  alpha_turnout ~ normal(0, 2.5);
  beta_age_turnout ~ normal(0, 2.5);
  beta_edu_turnout ~ normal(0, 2.5);
  beta_sex_turnout ~ normal(0, 2.5);
  beta_age_edu ~ normal(0, 2.5);
  beta_age_sex ~ normal(0, 2.5);
  beta_edu_sex ~ normal(0, 2.5);
  for (k in 1:K) {
    gamma_age[k] ~ normal(0, 2.5);
    gamma_edu[k] ~ normal(0, 2.5);
    gamma_sex[k] ~ normal(0, 2.5);
  }

  // Likelihood
  for (n in 1:N) {
    // Turnout model
    real turnout_logit = alpha_turnout + beta_age_turnout[age[n]] + beta_edu_turnout[edu[n]] +
                         beta_sex_turnout[sex[n]];
    voted[n] ~ bernoulli_logit(turnout_logit);

    // Voting preference model (conditional on having voted)
    if (voted[n] == 1) {
      vector[K] vote_logit = beta_party +
                             beta_age_edu[age_edu[n]] +
                             beta_age_sex[age_sex[n]] +
                             beta_edu_sex[edu_sex[n]] +
                             to_vector(gamma_age[:, age[n]]) +
                             to_vector(gamma_edu[:, edu[n]]) +
                             to_vector(gamma_sex[:, sex[n]]);
      vote[n] ~ categorical_logit(vote_logit);
    }
  }
}
