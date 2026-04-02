function exponential_ease(a, b, amt, pwr)
{
    var progress = 0;
    
    amt = clamp(amt, 0, 1);
    
    if amt <= 0.5
    {
        progress = power(amt, pwr) * power(2, pwr - 1);
    }
    else
    { 
        progress = 1 - power((1 - amt), pwr) * power(2, pwr - 1);
    }
    
    return lerp(a, b, progress);
}

function exponential_out(a, b, amt, pwr)
{
    amt = clamp(amt, 0, 1);
    
    var progress = 1 - power((1 - amt), pwr);
    
    return lerp(a, b, progress);
}

function exponential_in(a, b, amt, pwr)
{
    amt = clamp(amt, 0, 1);
    
    var progress = power(amt, pwr);
    
    return lerp(a, b, progress);
}

function bezier_ease(a, b, amt)
{
    amt = clamp(amt, 0, 1);
    
    var progress =  amt * amt * (3 - 2 * amt);
    
    return lerp(a, b, progress);
}

function parametric_ease(a, b, amt, alpha)
{
    amt = clamp(amt, 0, 1);
    
    var progress = power(amt, alpha) / (power(amt, alpha) + power((1 - amt), alpha));
    
    return lerp(a, b, progress);
}