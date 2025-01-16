/* Summary of average salary by Job Title */
proc sql;
   create table salary_summary_sql as
   select 
      "Job Title" as JobTitle format=$21., 
      avg(Salary) as AverageSalary 
   from 
      salary_data
   group by 
      "Job Title"
   order by 
      AverageSalary desc;
quit;
