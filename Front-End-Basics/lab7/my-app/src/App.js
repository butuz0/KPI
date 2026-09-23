import React from "react";
import Header from "./components/Header";
import MainContent from "./components/MainContent";
import Image from "./components/Image";
import Product from "./components/GoodsCard";

function App() {
    const flex = {
        display: "flex",
        justifyContent: "space-around",
    };
    const goodsData = {
        links: [
            require("./images/apple.png"),
            require("./images/cherry.png"),
            require("./images/kiwi.png"),
            require("./images/pear.png"),
            require("./images/pineapple.png"),
            require("./images/pomegranate.png"),
            require("./images/watermelon.png"),
        ],
        names: ["apple", "cherry", "kiwi", "pear", "pineapple", "pomegranate", "watermelon"],
        prices: [10, 30, 50, 15, 60, 40, 10],
    };
    return (
        <>
            <div>
                <Header />
                <MainContent />
                <Image />
            </div>
            <h1>Галерея товарів</h1>
            <div style={flex}>
                {goodsData.names.map((name, index) => (
                    <Product link={goodsData.links[index]} name={name} price={goodsData.prices[index]} />
                ))}
            </div>
        </>
    );
}
export default App;
