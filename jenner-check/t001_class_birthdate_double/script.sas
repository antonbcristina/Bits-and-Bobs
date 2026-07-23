/* Self-contained adaptation of a program.sas.

   Upstream reads gitstuff.class_birthdate from a SAS Viya home library and
   doubles every record with two OUTPUT statements. Here the same libname is
   pointed at a local directory and seeded from sashelp.class with a Birthdate
   column (class_birthdate is sashelp.class plus Birthdate), so the doubling
   logic below runs exactly as written. PROC SQL at the end surfaces the row
   count so the doubling (19 -> 38) is visible in the listing. */

libname gitstuff ".";

data gitstuff.class_birthdate;
	set sashelp.class;
	Birthdate = intnx('year', '15SEP2024'd, -Age, 'same');
	format Birthdate date9.;
run;

/* --- upstream logic, verbatim: two OUTPUT statements double every row --- */
data gitstuff.class_birthdate;
	set gitstuff.class_birthdate;
	output;
	output;
run;

proc sql;
	select count(*) as n_rows label='Rows after doubling'
	from gitstuff.class_birthdate;
quit;
