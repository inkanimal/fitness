$(() => {
    bindClickHandler()
})

const bindClickHandler = () => {
    $('#all_workouts').on('click', (e) => {
     e.preventDefault()   
     history.pushState(null, null, "workouts")
      getWorkouts()
   })

$(document).on('click', ".show_link", function(e) {
    e.preventDefault()
   
    let id = $(this).attr('data-id')
    fetch(`/workouts/${id}.json`)
    .then(res => res.json())
    .then(workout => {
        $('#output').html('')
        let newWorkout = new Workout(workout)
        let workoutHtml = newWorkout.formatShow()
        $('#output').append(workoutHtml)
    })
  })

  $(document).on('click', 'next-workout', function(e) {
    e.preventDefault()
    let id = $(this).attr('data-id')
    fetch(`workouts/${id}/next`)
    .then(res => res.json())
    .then(workout => {
        $('#output').html('')
        let newWorkout = new Workout(workout)
        let workoutHtml = newWorkout.formatShow()
        $('#output').append(workoutHtml)
    })
  })

 $('#new_workout').on('submit', function(e) {
     e.preventDefault()
     const values = $(this).serialize()

     $.post("/workouts", values).done(function(data){
        
         $('#output').html('')
         const newWorkout = new Workout(data)
         const htmlToAdd = newWorkout.formatNew()
         $('#output').html(htmlToAdd)
     })
 }) 
}

const getWorkouts = () => {
    fetch(`/workouts.json`)
    .then(res => res.json())
    .then(workouts => {
        $('#output').html('')
        workouts.forEach(workout => {
          let newWorkout = new Workout(workout)
          let workoutHtml = newWorkout.formatIndex()
          $('#output').append(workoutHtml)
        })
    })

}


$(() => {
    filterWorkout()
});
// $( document ).ready(function() {
//     filterWorkout()
//     // Handler for .ready() called.
//   });
const filterWorkout = () => {
    $('.filter').on('click', (e) => { 
        fetch(`/workouts.json`)
        .then(res => res.json())
        .then(workouts => {
             $('#output').html('')
        // console.log(workouts)
        workouts.sort(function(a, b) {
            var nameA = a.name.toUpperCase(); // ignore upper and lowercase
            var nameB = b.name.toUpperCase(); // ignore upper and lowercase
            if (nameA < nameB) {
              return -1;
            }
            if (nameA > nameB) {
              return 1;
            }
          
            // names must be equal
            return 0;
          });
          workouts.forEach(workout => {
            let newWorkout = new Workout(workout)
            let workoutHtml = newWorkout.formatIndex()
            $('#output').append(workoutHtml)
        })
  })
})
}


function Workout(workout){
    this.id = workout.id
    this.name = workout.name
    this.date = workout.date
    this.duration = workout.duration
    this.notes = workout.notes
    this.exercises = workout.exercises.map(exercise => { return (`${exercise.name}`)})
    this.worksets = workout.worksets
    
}

Workout.prototype.formatIndex = function() {

    eName = this.exercises.join(" | ")
        
    let wSets = this.worksets.map(workset => {return (`${workset.sets}`)})
    let wSetsJoined = wSets.join(' | ')

    let wReps = this.worksets.map(workset => {return (`${workset.reps}`)})
    let wRepsJoined = wReps.join(' | ')

    let wWeight = this.worksets.map(workset => {return (`${workset.weight}`)})
    let wWeightJoined = wWeight.join(' | ')

    let workoutHtml = `
    <a href="/workouts/${this.id}" data-id="${this.id}" class="show_link"><h2><strong>${this.name}</strong></h2>
    <h3>${this.date}</h3>
    <h3>${this.duration}</h3> <h3>${this.notes}</h3>
    
    <h4>Exercises: <strong>${eName}</strong></h4>
    <h4>Sets: ${wSetsJoined}</h4>
    <h4>Reps: ${wRepsJoined}</h4>
    <h4>Weight: ${wWeightJoined}</h4>
    <br>
    
    
    <table class="table is-bordered is-striped is-narrow is-hoverable">
    <thead>
    <tr>
      <th colspan="4" style="text-align: left">WORKOUT</th>
    </tr>
    <tr>
    <td colspan="4"><a href="/workouts/${this.id}" data-id="${this.id}" class="show_link"><strong style="font-size: 20px">${this.name}</strong><br>
    ${this.date}</td>
    
    </tr>
    <tr>
    <td colspan="4"><strong>Time:</strong> ${this.duration} | <strong>Notes:</strong> ${this.notes}</td>
    <tr>
    </thead>
    <tbody>
    <tr class="1">
    <th style="text-align: center">Exercise</th>
    <th style="text-align: center">Sets</th>
    <th style="text-align: center">Reps</th>
    <th style="text-align: center">Weight(lbs)</th>
 </tr>
 <tr class="1">
 <td style="text-align: center" id="test">${eName}</td>
 <td style="text-align: center">${wSetsJoined}</td>
 <td style="text-align: center">${wRepsJoined}</td>
 <td style="text-align: center">${wWeightJoined}</td>

</tr>



</tbody>
</table>


     
    `
    return workoutHtml
}

Workout.prototype.formatShow = function() {
    eName = this.exercises.join(" | ")
        
    let wSets = this.worksets.map(workset => {return (`${workset.sets}`)})
    let wSetsJoined = wSets.join(' | ')

    let wReps = this.worksets.map(workset => {return (`${workset.reps}`)})
    let wRepsJoined = wReps.join(' | ')

    let wWeight = this.worksets.map(workset => {return (`${workset.weight}`)})
    let wWeightJoined = wWeight.join(' | ')
    
    let workoutHtml = `
    <h3><strong>${this.name}</stong></h3>
    <h3>${this.date}</h3>
    <h3>${this.duration}</h3> <h3>${this.notes}</h3>
    <br>
    <h4><strong>${eName}</strong></h4>
    <h4>Sets: ${wSetsJoined}</h4>
    <h4>Reps: ${wRepsJoined}</h4>
    <h4>Weight: ${wWeightJoined}</h4>
    <br>
   
    <button class="next-workout">Next Workout</button>
    `
    return workoutHtml
}


Workout.prototype.formatNew = function() {
    eName = this.exercises.join(" | ")
        
    let wSets = this.worksets.map(workset => {return (`${workset.sets}`)})
    let wSetsJoined = wSets.join(' | ')

    let wReps = this.worksets.map(workset => {return (`${workset.reps}`)})
    let wRepsJoined = wReps.join(' | ')

    let wWeight = this.worksets.map(workset => {return (`${workset.weight}`)})
    let wWeightJoined = wWeight.join(' | ')

    let workoutHtml = `
    <h3><strong>${this.name}</stong></h3>
    <h3>${this.date}</h3>
    <h3>${this.duration}</h3> <h3>${this.notes}</h3>
    <br>
    <h4><strong>${eName}</strong></h4>
    <h4>Sets: ${wSetsJoined}</h4>
    <h4>Reps: ${wRepsJoined}</h4>
    <h4>Weight: ${wWeightJoined}</h4>
    <br>
    
   
    `
    return workoutHtml
}


