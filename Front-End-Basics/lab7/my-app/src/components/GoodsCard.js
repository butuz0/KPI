import React from "react";

function Product(props) {
    return (
        <div>
            <img src={props.link} alt={props.name} />
            <p>{props.name}</p>
            <p>Price: {props.price}</p>
        </div>
    );
}

export default Product;
