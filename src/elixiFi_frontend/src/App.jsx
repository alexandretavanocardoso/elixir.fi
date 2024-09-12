import { useState } from 'react';
import { elixiFi_backend } from 'declarations/elixiFi_backend';

function App() {
  const [documento, setDocument] = useState('');
  const [isValid, setIsValid] = useState(null);


  function validateDocumento(event) {
    event.preventDefault();
    elixiFi_backend.validateDocument(documento).then((validate) => {
      setIsValid(validate);
    });
    return false;
  }

  return (
    <div className="main">
      
    </div>
  );
}

export default App;
