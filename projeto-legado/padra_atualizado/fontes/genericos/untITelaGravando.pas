unit untITelaGravando;

interface

type
  ITelaGravando = interface
    ['{8B6D56CB-F584-4F7B-BFD4-0F42F3E3F3D9}']
    function GetTexto: String;
    procedure SetTexto(const strTexto: string);

    procedure RegistrarProgresso(const intInicio, intAtual, intFinal: Integer);
    property Texto: string read GetTexto write SetTexto;
  end;

implementation

end.
