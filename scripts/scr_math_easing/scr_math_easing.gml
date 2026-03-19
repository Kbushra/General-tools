//Remove?
function ease(_start, _dest, _duration, _time, _mode) 
{
	#region Interpolation Types
	
	linear_interpolation = function()
	{
		var t = argument[0];
		var b = argument[1];
		var c = argument[2];
		var d = argument[3];
	
		t /= d;
	
		return (c * t) + b;
	}

	cubic_interpolation = function()
	{
		var t = argument[0];
		var b = argument[1];
		var c = argument[2];
		var d = argument[3];
	
		t /= d;
	
		return (c * t * t * t) + b;
	}
	
	soft_interpolation = function()
	{
		var t = argument[0];
		var b = argument[1];
		var c = argument[2];
		var d = argument[3];
	
		t /= (d / 2);
		
		if t < 1 { return c * 2 * t * t + b; }
		t --;
		
		return -c / 2 * (t * (t - 2) - 1) + b;
	}
	
	#endregion
	
	if _time < _duration
	{ 
		if _mode == 0 { return linear_interpolation(_time, _start, _dest - _start, _duration); }
		if _mode == 1 { return cubic_interpolation(_time, _start, _dest - _start, _duration); }
		if _mode == 2 { return soft_interpolation(_time, _start, _dest - _start, _duration); }
		assert(false, "ease()", false); //Mode should always be 0-2
	}
	
	return _dest;
}

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