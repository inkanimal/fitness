module WorkoutHelper

def user_reps(workouts, user)
  final_string = ""
  workouts.each do |workout|

    if user.id == workout.user_id

      final_string << '<tr><td style="text-align: center">' + (link_to workout.name, workout, class:"special-links") + '</td>
                         <td style="text-align: center">' + (workout.date.strftime('%A, %B, %d')) + '</td>'
    end
  end
  final_string.html_safe
end

end
