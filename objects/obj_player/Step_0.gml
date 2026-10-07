//step
arc_progress += 1/arc_time;
arc_progress = clamp(arc_progress, 0, 1);
x = lerp(points[0].x, points[1].x, arc_progress);
y = jump_arc(points[0], points[1], 100, arc_progress);