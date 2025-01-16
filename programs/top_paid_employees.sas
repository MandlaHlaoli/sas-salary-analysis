/* Retrieve top 5 highest paid employees by age */
proc sql outobs=5;
   create table top_paid_employees as
   select 
      aGE , 
      Gender format=$6.,
      Salary
   from 
      salary_data
   order by 
      Salary desc;
quit;
