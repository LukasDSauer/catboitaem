* Define library name ("." is the current directory);
libname mylib ".";
* Filter relevant data;
data orsales;
set sashelp.orsales;
where (Product_Line = "Sports" or Product_Line = "Children")
and (Product_Category = "Children Sports"
     or Product_Category = "Team Sports"
     or Product_Category="Racket Sports");
run;
* Generate spaghetti plot and save in .\fig\-subfolder.;
ods _all_ close;
ods listing gpath="%sysfunc(pathname(mylib))\fig";
ods graphics / imagename="spaghetti_plot"
               imagefmt=png reset=index;
proc sgplot data=orsales;
   title 'Development of profit in different products';
   series x=Quarter y=Profit/ group=Product_Group
               grouplc=Product_Line
               grouplp=Product_Category name='grouping';
   keylegend 'grouping' / type=linecolor title="Product line";
   keylegend 'grouping' /
                 type=linepattern title="Product Category";
   xaxis label="Quarter";
   yaxis label="Profit [$]";
run;