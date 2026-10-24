unit untTIntegracaoCartoes;

interface

Uses
  Classes, untIIntegracaoCartoes, untIDataSet, untFuncoesRel;

Type
  TIntegracaoCartoes = Class(TInterfacedObject, IIntegracaoCartoes)
    function fGetDataSet: IDataSet;
    function fICurrentDate: String;
    function fIMensagem(const strTitulo: String; const strTexto: String; arrOpcoes: Array Of String;
      intFocoBotao: Integer = 1; blnSaiComEsc: Boolean = False; intEstFon: Integer = 1; intWidBut: Integer = 0;
      blnAutoSize: Boolean = False; intSomarTop: Integer = 0): Integer;
End;

Type
  TCartoesEditorRelatorios = Class(TInterfacedObject, ICartoesEditorRelatorios)
    procedure prcIExecutaRelatorio(intCodigoAtalho,
                                   intChaveDefault: integer;
                                   intChavesPossiveis: Array Of Integer;
                                   arrParametros: Array Of String;
                                   arrValores: Array Of String;
                                   SenderChamada: TObject;
                                   arrParametrosReadOnly: Array Of String;
                                   blnExecutarDireto: Boolean = False;
                                   blnExibirMensagem: Boolean = True;
                                   strDirAce: String = '';
                                   blnUsuarioLogadoDefaultVerdeVermelho: Boolean = False);
  End;

implementation

uses untFuncoesSimples, untUniQueryDataSetWrapper;

{ TIntegracaoCartoes }

function TIntegracaoCartoes.fICurrentDate: String;
begin
  Result := fCurrentDate;
end;

function TIntegracaoCartoes.fGetDataSet: IDataSet;
begin
  Result := TUniQueryDataSetWrapper.Create as IDataSet;
end;

function TIntegracaoCartoes.fIMensagem(const strTitulo, strTexto: String;
  arrOpcoes: array of String; intFocoBotao: Integer; blnSaiComEsc: Boolean;
  intEstFon, intWidBut: Integer; blnAutoSize: Boolean; intSomarTop: Integer): Integer;
begin
  Result := fMensagem(strTitulo, strTexto, arrOpcoes, intFocoBotao, blnSaiComEsc, intEstFon, intWidBut, blnAutoSize, intSomarTop);
end;

{ TCartoesEditorRelatorios }

procedure TCartoesEditorRelatorios.prcIExecutaRelatorio(intCodigoAtalho,
  intChaveDefault: integer; intChavesPossiveis: array of Integer; arrParametros,
  arrValores: array of String; SenderChamada: TObject;
  arrParametrosReadOnly: array of String; blnExecutarDireto,
  blnExibirMensagem: Boolean; strDirAce: String;
  blnUsuarioLogadoDefaultVerdeVermelho: Boolean);
begin
  untFuncoesRel.prcExecutaRelatorio(intCodigoAtalho,
                                    intChaveDefault,
                                    intChavesPossiveis,
                                    arrParametros,
                                    arrValores,
                                    SenderChamada,
                                    Nil,
                                    blnExecutarDireto,
                                    blnExibirMensagem,
                                    strDirAce,
                                    blnUsuarioLogadoDefaultVerdeVermelho);
end;

end.
