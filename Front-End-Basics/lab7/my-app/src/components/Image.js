import React, { useState } from "react";

function Image() {
    const [imageWidth, setImageWidth] = useState(1000);
    const imageZoomIn = () => {
        setImageWidth((prevWidth) => prevWidth + 100);
    };
    const imageZoomOut = () => {
        setImageWidth((prevWidth) => prevWidth - 100);
    };

    const [imageVisible, setImageVisible] = useState(true);
    const imageDelete = () => {
        setImageVisible(false);
    };
    const imageAdd = () => {
        setImageVisible(true);
    };
    return (
        <div>
            <div>
                <button onClick={imageAdd}>Додати</button>
                <button onClick={imageZoomIn}>Збільшити</button>
                <button onClick={imageZoomOut}>Зменшити</button>
                <button onClick={imageDelete}>Видалити</button>
            </div>

            <a href="https://www.gdansk.uw.gov.pl/" target="_blank" rel="noreferrer">
                {imageVisible && (
                    <img
                        src="https://zakavto.com.ua/images/data/Gdansk-1.jpg"
                        alt="Gdansk"
                        style={{ width: `${imageWidth}px` }}
                    />
                )}
            </a>
        </div>
    );
}

export default Image;
