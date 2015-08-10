var rows = document.getElementsByClassName('aviaboard__tbody');
var len = rows.length;
var prev = null;

for (var i = 0; i < len; i++) {
	rows[i].onclick = function() {
		if (prev && prev !== this)
			prev.classList.remove('aviaboard__tbody--opened');
		prev = this;

		this.classList.toggle('aviaboard__tbody--opened');
	}
}