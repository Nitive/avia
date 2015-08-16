var aviaboard = document.getElementsByClassName('aviaboard')[0],
	rows = aviaboard.getElementsByClassName('aviaboard__tbody'),
	checkDeparture = aviaboard.getElementsByClassName('aviaboard__control-button--departure')[0],
	checkArrival = aviaboard.getElementsByClassName('aviaboard__control-button--arrival')[0];



// разворачивать по клику
var len = rows.length,
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
	aviaboard.classList.toggle('aviaboard--hide-departure');
	aviaboard.classList.remove('aviaboard--hide-arrival');
}

checkArrival.onclick = function() {
	aviaboard.classList.toggle('aviaboard--hide-arrival');
	aviaboard.classList.remove('aviaboard--hide-departure');
}


// при наведении на ячейку подсвечивается столбец
setColor = function (color, col) {
	var tds = document.querySelectorAll('.column_' + col);
	for (var i in tds) {
		if (typeof(tds[i]) === 'object') {
			tds[i].style.backgroundColor = color;
		}
	}
}

for (var j = 1; j <= 7; j++) {
	var elements = document.querySelectorAll('.column_' + j);
	for (var i in elements) {
		e = elements[i];
		if (typeof(e) === 'object') {
			e.onmouseover = setColor.bind(null, 'white', j);
			e.onmouseleave = setColor.bind(null, '', j);
		}
	}
}
