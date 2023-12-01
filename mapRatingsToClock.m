function a = mapRatingsToClock( value, from1,  to1,  from2,  to2) 
   a = (value - from1) / (to1 - from1) * (to2 - from2) + from2;
end