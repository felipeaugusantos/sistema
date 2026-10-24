unit untTIntegracaoPixCitel;

interface

Uses
  System.Classes, untIIntegracaoPixCitel, untIDataSet, System.SysUtils;

Type
  TIntegracaoPixCitel = Class({$IFNDEF LINUX}TInterfacedPersistent{$ELSE}TInterfacedObject{$ENDIF}, IIntegracaoPixCitel)
    function fGetDataSet: IDataSet;
    function fGetEmpresaLogada: String;
    function fICurrentDate: String;
    function fIMensagem(const strTitulo: String; const strTexto: String; arrOpcoes: Array Of String;
      intFocoBotao: Integer = 1; blnSaiComEsc: Boolean = False; intEstFon: Integer = 1; intWidBut: Integer = 0;
      blnAutoSize: Boolean = False; intSomarTop: Integer = 0): Integer;
    function fIRetAutoIncrem(const ATabela, AEmpresaLogada: String): String;
    function fIRetOperadorLogado: String;

    function fIAtualizadoMonitoramento: Boolean;
    function fIStartTransaction: Boolean;
    function fICommit: Boolean;
    function fIRollBack: Boolean;
End;

implementation

uses untFuncoesSimples, untUniQueryDataSetWrapper;

{ TIntegracaoCartoes }

function TIntegracaoPixCitel.fGetEmpresaLogada: String;
begin
  Result := VS_strCodEmp;
end;

function TIntegracaoPixCitel.fIAtualizadoMonitoramento: Boolean;
begin
  Result := True;
end;

function TIntegracaoPixCitel.fICommit: Boolean;
begin
  Result := fCommit;
end;

function TIntegracaoPixCitel.fICurrentDate: String;
begin
  Result := fCurrentDate;
end;

function TIntegracaoPixCitel.fGetDataSet: IDataSet;
begin
  Result := TUniQueryDataSetWrapper.Create as IDataSet;
end;

function TIntegracaoPixCitel.fIMensagem(const strTitulo, strTexto: String;
  arrOpcoes: array of String; intFocoBotao: Integer; blnSaiComEsc: Boolean;
  intEstFon, intWidBut: Integer; blnAutoSize: Boolean; intSomarTop: Integer): Integer;
begin
  Result := fMensagem(strTitulo, strTexto, arrOpcoes, intFocoBotao, blnSaiComEsc, intEstFon, intWidBut, blnAutoSize, intSomarTop);
end;

function TIntegracaoPixCitel.fIRetAutoIncrem(const ATabela,
  AEmpresaLogada: String): String;
begin
  Result := fRetAutoIncrem(ATabela, AEmpresaLogada);
end;

function TIntegracaoPixCitel.fIRetOperadorLogado: String;
begin
  Result := strLoginUsuarioLogado;
end;

function TIntegracaoPixCitel.fIRollBack: Boolean;
begin
  Result := fRollBack;
end;

function TIntegracaoPixCitel.fIStartTransaction: Boolean;
begin
  Result := False;

  If Not fInTransaction Then
    Result := fStartTransaction;
end;

end.
