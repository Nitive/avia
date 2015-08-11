var rows = document.getElementsByClassName('aviaboard__tbody'),
	aviaboard = document.getElementsByClassName('aviaboard')[0],
	checkDeparture = document.getElementsByClassName('aviaboard__control-button--departure')[0],
	checkArrival = document.getElementsByClassName('aviaboard__control-button--arrival')[0],
	len = rows.length,
	prev = null;

for (var i = 0; i < len; i++) {
	rows[i].onclick = function() {
		if (prev && prev !== this)
			prev.classList.remove('aviaboard__tbody--opened');
		prev = this;

		this.classList.toggle('aviaboard__tbody--opened');
	}
}

checkDeparture.onclick = function() {
	aviaboard.classList.toggle('aviaboard__hide-departure');
}

checkArrival.onclick = function() {
	aviaboard.classList.toggle('aviaboard__hide-arrival');
}
