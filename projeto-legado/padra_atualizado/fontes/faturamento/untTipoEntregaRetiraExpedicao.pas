unit untTipoEntregaRetiraExpedicao;

interface

uses
  Classes,
  SysUtils;

Type
  TTipoEntregaRetiraExpedicao = class
    private
     FExiPedRetiraExpAntFat: boolean;
    public
      Const
        ENTREGA = 'E';
        RETIRA  = 'R';
        TODOS   = 'T';

      function fGetTipo : Char;
      property blnExiPedRetiraExpAntFat : boolean read FExiPedRetiraExpAntFat;

      constructor Create;
  End;

implementation

uses
  untFuncoesSimples;

{ TTipoEntregaRetiraExpedicao }

constructor TTipoEntregaRetiraExpedicao.Create;
begin
  FExiPedRetiraExpAntFat := (VS_strTipExp = '2') And (fCfgSis('PEDRET', varString) = 'S');
end;


function TTipoEntregaRetiraExpedicao.fGetTipo: Char;
begin
  If FExiPedRetiraExpAntFat Then
    Result := RETIRA

  Else If VS_strExpRetiraEntrega = RETIRA Then
    Result := RETIRA

  Else If VS_strExpRetiraEntrega = ENTREGA Then
    Result := ENTREGA

  Else
    Result := TODOS;
end;

end.

