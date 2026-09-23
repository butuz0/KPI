// -----------------------------------Завдання 1-----------------------------------
function incorrectInput(form, inputName) {
    form.elements[inputName].classList.add("incorrect");
}
function correctInput(form, inputName) {
    form.elements[inputName].classList.remove("incorrect");
}

function formValidation(form) {
    let specialChars = /[`!@#$%^&*()_+\-=\[\]{};':"\\|,<>\/?~]/;

    const div = document.getElementById("correct_inputs");
    div.classList.add("invisible");

    // name validation
    const name = form.name.value;
    if (form.name != null && name.length < 7) {
        incorrectInput(form, "name");
        form.elements["name"].classList.add("incorrect");
        alert("ПІБ повинна бути не менше 7 символів");
        return false;
    } else if (specialChars.test(name) || /^\d+$/.test(name)) {
        incorrectInput(form, "name");
        alert("ПІБ не повинно містити спеціальних символів або чисел");
        return false;
    } else if (name.slice(-1)[0] !== "." || name.slice(-3)[0] !== "." || name.slice(-5)[0] !== " ") {
        incorrectInput(form, "name");
        alert("ПІБ Повинно відповідати формату: ТТТТТТ Т.Т.");
        return false;
    }
    correctInput(form, "name");

    // variant validation
    if (form.variant.value > 30 || form.variant.value <= 0) {
        incorrectInput(form, "variant");
        alert("Номер варіанту не може бути від'ємним або перевищувати 30");
        return false;
    }
    correctInput(form, "variant");

    specialChars = /[`!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~]/;

    // group validation
    const group = form.group.value;
    if (form.group != null && group.length !== 5) {
        incorrectInput(form, "group");
        alert("Номер групи повинен скаладатись із 5 символів");
        return false;
    } else if (
        specialChars.test(group.slice(0, 2)) ||
        /\d/.test(group.slice(0, 2)) ||
        group[2] !== "-" ||
        !/^\d+$/.test(group.slice(-2))
    ) {
        incorrectInput(form, "group");
        alert("Группа повинна відповідати формату: ТТ-ЧЧ");
        return false;
    }
    correctInput(form, "group");

    // faculty validation
    const faculty = form.faculty.value;
    if (form.name != null && faculty.length < 2) {
        incorrectInput(form, "faculty");
        alert("Назва факультету повинна бути не менше 2 символів");
        return false;
    } else if (specialChars.test(faculty) || /\d/.test(faculty)) {
        incorrectInput(form, "faculty");
        alert("Назва факультету не повинна містити спеціальних символів або чисел");
        return false;
    }
    correctInput(form, "faculty");

    // date of birth validation
    const date = new Date(form.dateOfBirth.value);
    const currentDate = new Date();
    if (date > currentDate) {
        incorrectInput(form, "dateOfBirth");
        alert("Дата народження не може перевищувати сьогоднішню дату");
        return false;
    }
    correctInput(form, "dateOfBirth");

    const inputLables = document.querySelectorAll("label");
    for (let i = 0; i < form.elements.length - 1; i++) {
        div.innerHTML += `<p><b>${inputLables[i].innerHTML}:</b> ${form.elements[i].value}</p>`;
        form.elements[i].value = null;
    }
    div.classList.remove("invisible");

    return false;
}

// -----------------------------------Завдання 2-----------------------------------
const table = document.getElementById("table");

let value = 0;
for (let i = 0; i < 6; i++) {
    const tr = table.insertRow();
    for (let j = 0; j < 6; j++) {
        const td = tr.insertCell();
        td.innerHTML = ++value;
    }
}

function randomColor() {
    return "#" + Math.floor(Math.random() * 16777215).toString(16);
}

const cells = document.getElementsByTagName("td");
const cell = cells[8];
const colorPicker = document.getElementById("colorInput");

cell.addEventListener("mouseover", () => {
    cell.style.backgroundColor = randomColor();
});

cell.addEventListener("click", () => {
    cell.style.backgroundColor = colorPicker.value;
});

cell.addEventListener("dblclick", () => {
    let cellIndex = 8;
    const color = randomColor();

    while (cellIndex < 36) {
        console.log(cellIndex);
        console.log(cells[cellIndex].innerHTML);
        cells[cellIndex].style.backgroundColor = color;
        cellIndex += 12;
    }
});
