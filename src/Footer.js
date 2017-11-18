import React, { Component } from 'react';
import './styles/Footer.css';

import logoFacebook from './images/logo-facebook.svg';
import logoGithub from './images/logo-github.svg';
import logoGooglePlus from './images/logo-google-plus.svg';
import logoTwitter from './images/logo-twitter.svg';

class Footer extends Component {
  render() {
    let openInPopup = (event) => {
      var el = event.currentTarget;
      event.preventDefault();
      window.open(el.href, '','menubar=no,toolbar=no,height=600,width=600');
    }

    return (
      <footer>
        <div className="container">
          <p>We made the right decision.</p>
          <ul className="internal-links">
            <li><a href="about.html">About This Thing</a></li>
            <li><a href="privacy.html">Privacy</a></li>
            <li><a href="contact.html">Contact Us</a></li>
          </ul>
          <ul className="share-links">
            <li>
              <a href="https://www.facebook.com/sharer/sharer.php?u=https://www.shouldiorderapizza.com&t=Should%20I%20Order%20A%20Pizza" onClick={openInPopup}>
                <img src={logoFacebook} alt="shouldiorderapizza on facebook" />
              </a>
            </li>
            <li>
              <a href="https://twitter.com/shouldiorder">
                <img src={logoTwitter} alt="shouldiorderapizza on twitter" />
              </a>
            </li>
            <li>
              <a href="https://plus.google.com/share?url=https://www.shouldiorderapizza.com/" onClick={openInPopup}>
                <img src={logoGooglePlus} alt="shouldiorderapizza on google plus" />
              </a>
            </li>
            <li>
              <a href="https://github.com/Sinetheta/shouldiorderapizza">
                <img src={logoGithub} alt="shouldiorderapizza on github" />
              </a>
            </li>
          </ul>
        </div>
      </footer>
    );
  }
}

export default Footer;
