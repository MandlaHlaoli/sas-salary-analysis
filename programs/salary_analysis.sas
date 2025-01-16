/* salary_analysis.sas */

/* Step 1: Import the salary dataset */
proc import datafile='/home/u51591032/sas-salary-analysis/data/salary_data.csv'
    out=salary_data
    dbms=csv
    replace;
    getnames=yes;
run;

/* Step 2: Inspect the first few rows of the dataset */
proc print data=salary_data (obs=5);
run;

/* Step 3: Clean the data - Handle missing values and create new variables */
data cleaned_data;
    set salary_data;
    /* Example: Create a new variable for salary range */
    if Salary < 50000 then salary_range = 'Low';
    else if Salary >= 50000 and Salary < 100000 then salary_range = 'Medium';
    else if Salary >= 100000 then salary_range = 'High';
run;

/* Step 4: Generate salary analysis by job title */
proc means data=cleaned_data mean median stddev;
    class Job_Title;
    var Salary;
    output out=salary_summary mean=mean_salary median=median_salary stddev=stddev_salary;
run;

/* Step 5: Generate salary analysis by experience level */
data experience_levels;
    set cleaned_data;
    if Experience < 5 then experience_level = 'Junior';
    else if Experience >= 5 and Experience < 15 then experience_level = 'Mid';
    else if Experience >= 15 then experience_level = 'Senior';
run;

proc means data=experience_levels mean median stddev;
    class experience_level;
    var Salary;
    output out=experience_salary_summary mean=mean_salary median=median_salary stddev=stddev_salary;
run;

/* Step 6: Export output to CSV */
proc export data=salary_summary
    outfile='/home/u51591032/sas-salary-analysis/output/salary_summary.csv'
    dbms=csv
    replace;
run;

proc export data=experience_salary_summary
    outfile='/home/u51591032/output/sas-salary-analysis/experience_salary_summary.csv'
    dbms=csv
    replace;
run;
