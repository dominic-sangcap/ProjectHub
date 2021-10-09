-- user defined functions
CREATE or REPLACE FUNCTION harmonic_mean (x numeric, y numeric) RETURNS numeric 
AS $$
    SELECT round(((2 * x * y) / (x + y))::numeric,2) 
$$ LANGUAGE SQL;

SELECT harmonic_mean(1,2)

-- overloaded functions
CREATE or REPLACE FUNCTION harmonic_mean (x text, y text) RETURNS numeric 
AS $$
    SELECT round(((2 * x::numeric * y::numeric) / (x::numeric + y::numeric))::numeric,2) 
$$ LANGUAGE SQL;

SELECT harmonic_mean('1.1','2.2')

-- function volatility (volatile, stable, or immutable)
CREATE or REPLACE FUNCTION harmonic_mean (x numeric, y numeric) RETURNS numeric 
AS $$
    SELECT round(((2 * x * y) / (x + y))::numeric,2) 
$$ LANGUAGE SQL VOLATILE;



