import React, { Component } from "react";

class Content extends Component {
    constructor(props) {
        super(props);

        this.state = {
            pStyles: { backgroundColor: "white", color: "black" },
            liStyles: { backgroundColor: "white", color: "black" },
            lastClickedElement: null,
        };
    }
    pClick = () => {
        this.setState(() => ({
            pStyles: { backgroundColor: "red", color: "white" },
            liStyles: { backgroundColor: "blue", color: "yellow" },
            lastClickedElement: "p",
        }));
    };

    liClick = () => {
        this.setState(() => ({
            pStyles: { backgroundColor: "red", color: "white" },
            liStyles: { backgroundColor: "blue", color: "yellow" },
            lastClickedElement: "li",
        }));
    };
    render() {
        const { pStyles, liStyles, lastClickedElement } = this.state;
        return (
            <main>
                <div>
                    <p>Хоббі:</p>
                    <ul>
                        <li>Комп'ютерні ігри</li>
                        <li>Баскетбол</li>
                        <li>Колекціонування Хотвілс</li>
                    </ul>
                </div>
                <div>
                    <p style={lastClickedElement === "p" ? liStyles : pStyles} onClick={this.pClick}>
                        Улюблені фільми:
                    </p>
                    <ol>
                        <li style={lastClickedElement === "li" ? liStyles : pStyles} onClick={this.liClick}>
                            Престиж
                        </li>
                        <li>Острів проклятих</li>
                        <li>Втеча із Шоушенка</li>
                    </ol>
                </div>
                <p>
                    Гданськ — культурний, науковий та господарчий центр, а також потужний транспортний вузол Північної
                    Польщі. Місто є великим портом на Балтійському морі, центр промисловості, зокрема нафтохімічної і
                    машинобудування (розвинені суднобудування і судноремонт). Населення — 463 тисячі мешканців (6-те за
                    розміром у Польщі). Разом із Гдинею і Сопотом утворює міську агломерацію — так зване Тримісто (пол.
                    Trójmiasto, Труймясто) з населенням понад 1 мільйон мешканців. Історія міста налічує понад 1000
                    років, його ідентичність формувалася під впливом різних культур. Гданськ відомий як місто, з якого
                    почалася Друга світова війна і розпочався занепад комунізму в Центральній Європі.
                </p>
            </main>
        );
    }
}

export default Content;
