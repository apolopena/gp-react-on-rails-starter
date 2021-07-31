import PropTypes from 'prop-types';
import React, { useState } from 'react';

const HelloWorld = (props) => {
  const [name, setName] = useState(props.name);

  return (
    <div>
      <h3>Hello, <span class="text-pink-300">{name}{name.length > 0 ? '!' : ''}</span></h3>
      <hr class="my-3" />
      <form>
        <label class="mt-6" htmlFor="name">
          Say hello to:
          <input
            id="name"
            type="text" value={name}
            onChange={(e) => setName(e.target.value)}
            class="ml-2.5 pl-1.5 text-pink-600"
          />
        </label>
      </form>
    </div>
  );
};

HelloWorld.propTypes = {
  name: PropTypes.string.isRequired, // this is passed from the Rails view
};

export default HelloWorld;
