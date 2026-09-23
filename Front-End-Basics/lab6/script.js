const div = document.getElementById("people");

function getPeopleInfo() {
    for (let i = 0; i < 5; i++) {
        const personInfo = document.createElement("div");
        personInfo.className = "person";
        div.appendChild(personInfo);

        fetch("https://randomuser.me/api")
            .then((response) => {
                return response.json();
            })
            .then((data) => {
                console.log(data);
                personInfo.innerHTML += `<img src="${data["results"]["0"]["picture"]["large"]}" alt="" />`;
                personInfo.innerHTML += `<p><b>Name:</b> ${data["results"]["0"]["name"]["first"]} 
                ${data["results"]["0"]["name"]["last"]}</p>`;
                personInfo.innerHTML += `<p><b>City:</b> ${data["results"]["0"]["location"]["city"]}</p>`;
                personInfo.innerHTML += `<p><b>Postcode:</b> ${data["results"]["0"]["location"]["postcode"]}</p>`;
                personInfo.innerHTML += `<p><b>Cell:</b> ${data["results"]["0"]["cell"]}</p>`;
            });
    }
}
