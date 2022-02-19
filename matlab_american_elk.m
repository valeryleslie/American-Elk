% Deter model w/ hacking (year 2) (base)
mbirth= 0.18914774
mdeath = 0.09850035421
year = (2001: 2012)
p = zeros(1, 10)
p(1) = 27

for n = 2:12
    p(n)=(1+mbirth - mdeath)*p(n-1)
    if n ==2
        p(n) = p(n) + 27
    end
end

figure(1)
plot(year, p)
xlabel('Time (in years)')
ylabel('Elk Population')
title('Deterministic Model of Elk Population')

% Environmental + Demographic Stochasticity 
trials = 20
endyear= 2111
year = [2011; 2021; 2021; 2031; 2041; 2051; 2061; 2071; 2081; 2091; 2111]

popu = zeros(trials, 11)

popu(:,1) = 140*ones(trials,1);

mbirth = 0.1510121757
sdbirth = 0.04118475633

for i = 1:trials
    for j = 1:10
        % Birth Rate
        brate = normrnd(mbirth, sdbirth)
       
        % Poaching Rate
        orate = normrnd(0.001976246106, 0.004831446727)
        if orate < 0
            orate = 0
        end
        
        % Accident Rate
        arate = normrnd(0.006310201175, 0.008731077902)
        if arate < 0
            arate = 0
        end
       
        % Predator Rate
        prate = normrnd(0.01927315914, 0.03631033543)
        if prate < 0
            prate = 0
        end
        
        % Sickness Rate
        srate = normrnd(0.01214902865, 0.01709012995)
        if srate < 0
            srate = 0
        end

        % Unknown Rate
        urate = normrnd(0.01322746721, 0.0215714263)
        if urate < 0
            urate = 0
        end
       % Intrinsic Growth
        rgrowth = 1 + brate - prate -srate - urate - orate - arate
        carrcap = normrnd(7030,1170)

       % What we end up with:
       % A logistic deterministic model with stochastic properties from 
       % usage of random variables for different rates affecting elks
        popu(i,j+1) = popu(i,j)*(rgrowth*(1-(popu(i,j)/carrcap)))

        if j == 1
            popu(i,j+1) = popu(i, j+1) + 27
        end
    end
end

% printing of the population figure 
figure(2)
plot(year, popu)
xlabel('Time (in years)')
ylabel('Elk Population')
title('Population Model of Elk with Carrying Capacity')