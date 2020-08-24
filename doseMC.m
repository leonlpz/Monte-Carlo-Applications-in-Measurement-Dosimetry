E = load('e220kv01cmcu_cum.dat');
W = load('coef_at_WATER1.dat');
B = load('coef_at_BONE1.dat');
T = load('coef_at_TISSUE1.dat');

table=input('WATER press 1, BONE press 2, TISSUE press 3 : ');
if table==1
    disp('WATER:')
    txt='WATER, ';
    X=W;
end
if table==2
    disp('BONE:')
    txt='BONE, ';
    B([3,6,10,13,17],:)=[];
    X=B;
end
if table==3
    disp('TISSUE:')
    txt='TISSUE, ';
    T([3,7,10,13,16],:)=[];
    X=T;
end
L=input('Enter depth in cm: ');
res=input('Enter resolution in cm: ');
m=input('Enter number of photons to interact (>1): ');
n=m+1;
nc=ceil(L/res);
dose=zeros(1,nc);
vdose=zeros(1,nc);
suma=zeros(1,nc);
suma1=zeros(1,nc);
depth=(res:res:L);
x=0; y=0; z=0;
u=0; v=1; w=0;
ph=0;
energy_p=0;
countcomp=0;
countphoto=0;
out=0;
Nprim=0;
Nscatt=0;
%Einitial=0;
tic;
while n > 1
 n=n-1;
  f=rand(1);
  E1=E(:,1);
  E2=E(:,2);
  E1(1)=[];
  E2(1)=[];
  spectre=interp1(E2,E1,f);
  
  if energy_p <= 0.001
      energy=spectre;
      y=0;v=1;d=0;
      %Einitial=Einitial+energy;
      
  else
      energy=energy_p;
      n=n+1;
  end
  
%mass coefficient
 Etable=X(:,1);
 ucomp=X(:,3);
 uphoto=X(:,4);
 mucomp=interp1(Etable,ucomp,energy);
 muphoto=interp1(Etable,uphoto,energy);
 mutotal=mucomp+muphoto;
 r1=rand(1);
 d= (-1/mutotal)*log(r1);
 y=y+v*d;
 
 if energy==spectre && y>L
     Nprim=Nprim+1;
 end
 if energy==energy_p && y>L
     Nscatt=Nscatt+1;
 end
      if y>=0 && y<=L
      
        if r1<=(muphoto/mutotal)
          
           countphoto=countphoto+1;
           energy_p=0;
           P=ceil(y/res);
           if P == 0
               P=1;
           end
           suma(P)=energy/(res*m);
           suma1(P)=energy*energy/(res*res);
           dose=dose+suma;
           vdose=vdose+suma1;
           suma=zeros(1,nc);  
           suma1=zeros(1,nc);
           
        else
             countcomp=countcomp+1;
             th=pi*rand(1);
             ph=acot((1 + (energy/0.511))*tan(0.5*th));
             energy_p = energy/(1+(energy/.511)*(1-cos(th)));
             Tenergy = energy - energy_p;
             v=v*cos(th) + (sin(th)/sqrt(1-w*w))*(v*w*cos(ph)+u*sin(ph));
      
             P=ceil(y/res);
             if P == 0
                 P=1;
             end
             suma(P)=Tenergy/(res*m);
             suma1(P)=Tenergy*Tenergy/(res*res);
             dose=dose+suma;
             vdose=vdose+suma1;
             suma=zeros(1,nc);  
             suma1=zeros(1,nc);
         end
      else
          out=out+1;
          energy_p=0;
      end 
    
end
Sx=sqrt((vdose - (dose.*dose)))/m;
errorbar(depth,dose,Sx);
title([txt,'Number of photons= ',num2str(m)]);
xlabel('Depth (cm)');
ylabel('Absorbed Energy per length (MeV/cm)')
xlim([0 L]);
%##########
time=toc;
j=dose(1);
k=dose(nc);
fprintf('Photoelectric Interactions %d.\n',countfoto);
fprintf('Compton Interactions %d.\n',countcomp);
fprintf('Photons out of the volume (total) %d.\n',out);
fprintf('Primary photons out of the volume %d.\n',Nprim);
fprintf('Scattered photons out of the volume %d.\n',Nscatt);
fprintf('Initial Dose %d.\n',j);
fprintf('Final Dose %d.\n',k);
fprintf('Percentage of energy absorbed per unit length %d.\n',100*k/j);
fprintf('The process took approximately %d minutes', round(time/60));

