import React, { Component } from 'react';
import './styles/Header.css';

import chef from './images/pizza-chef.png';

class Header extends Component {
  render() {
    return (
      <header>
        <div className="container">
          <p className="ribbon" ng-bind="main.byline"></p>
        </div>
        <div className="container-mobile">
          <img src={chef} alt="Pizza chef" className="lil-panucci" />;
          <h1>
            <a href="https://www.shouldiorderapizza.com">
              <span>Should<em>I</em></span>
              <span>Order<em>A</em></span>
              <span>Pizza<em>.com</em></span>
            </a>
          </h1>
        </div>
      </header>
    );
  }
}

export default Header;
