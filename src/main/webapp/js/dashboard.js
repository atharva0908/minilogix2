function toggleProfile(){
    const card = document.getElementById("profileCard");
    card.style.display = (card.style.display === "block") ? "none" : "block";
}
function showSection(id){
    document.querySelectorAll('.form-section').forEach(sec => sec.classList.add('hidden'));
    document.getElementById(id).classList.remove('hidden');
}
function toggleCargo(type){
    document.getElementById('airForm').classList.add('hidden');
    document.getElementById('landForm').classList.add('hidden');
    if(type==='air') document.getElementById('airForm').classList.remove('hidden');
    else document.getElementById('landForm').classList.remove('hidden');
}
function fetchFlights(){
    //AJAX call to servlet for flights (placeholder)
    const select = document.getElementById('flightSelect');
    select.innerHTML = `<option>Flight A - 10:00</option><option>Flight B - 15:00</option>`;
    document.getElementById('vehicleOptions').classList.remove('hidden');
}
function fetchTrains(){
    const select = document.getElementById('trainSelect');
    select.innerHTML = `<option>Train X - 9:00</option><option>Train Y - 13:00</option>`;
}
