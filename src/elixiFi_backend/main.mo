import Text "mo:base/Text";
import Array "mo:base/Array";
import Char "mo:base/Char";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";

actor {
    public func validateDocument(document : Text) : async Bool {
        let documentClean = await removeNonDigits(document);

        if(documentClean.size() != 11 and documentClean.size() != 14) {
            return false
        };

        if(documentClean.size() == 11) {
            await validateCPF(documentClean)
        } 
        else {
            await validateCNPJ(documentClean)
        }
    };

    public query func validateCPF(cpf: Text): async Bool {
        let caracters = Text.toArray(cpf);

        let digitos = Array.map<Char, Nat>(caracters, func(c: Char): Nat {
            let charAsText = Char.toText(c);
            switch (Nat.fromText(charAsText)) {
                case (?n) { n };
                case null { 0 };
            }
        });

        let verificarDigito = func(digitos: [Nat], pesos: [Nat]) : Nat {
            var soma = 0;
            for (i in Iter.range(0, Array.size(pesos) - 1)) {
                soma += digitos[i] * pesos[i];
            };
            let resto = soma % 11;
            return if (resto < 2) 0 else 11 - resto;
        };

        let pesos1 = [10, 9, 8, 7, 6, 5, 4, 3, 2];
        let pesos2 = [11, 10, 9, 8, 7, 6, 5, 4, 3, 2];

        let digito1 = verificarDigito(Array.subArray<Nat>(digitos, 0, 9), pesos1);
        let digito2 = verificarDigito(Array.subArray<Nat>(digitos, 0, 10), pesos2);

        return (digitos[9] == digito1) and (digitos[10] == digito2);
    };

    public query func validateCNPJ(cnpj : Text) : async Bool {
        let caracters = Text.toArray(cnpj);

        for(c in caracters.vals()) {

        };

        let digitos = Array.map<Char, Nat>(caracters, func(c: Char): Nat {
            let charAsText = Char.toText(c);
            switch (Nat.fromText(charAsText)) {
                case (?n) { n };
                case null { 0 };
            }
        });

        let verificarDigito = func(digitos: [Nat], pesos: [Nat]) : Nat {
            var soma = 0;
            for (i in Iter.range(0, Array.size(pesos) - 1)) {
                soma += digitos[i] * pesos[i];
            };
            let resto = soma % 11;
            return if (resto < 2) 0 else 11 - resto;
        };

        let pesos1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
        let pesos2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
        
        let digito1 = verificarDigito(Array.subArray<Nat>(digitos, 0, 12), pesos1);
        let digito2 = verificarDigito(Array.subArray<Nat>(digitos, 0, 13), pesos2);
        
        return (digitos[12] == digito1) and (digitos[13] == digito2);
    };

    public query func removeNonDigits(text : Text) : async Text {
        let result = Text.translate(text, func(c) {
            if (c == '.' or c == '/' or c == ',' or c == '-') {
                ""
            } else {
                Text.fromChar(c)
            }
        });

        return result;
    };
};
