unit Contabilidade.Classes.TValidaContasContabeis;

interface

uses Contabilidade.Interfaces, UniClientDataSet, Contabilidade.Model.Contabilizaveis,
  System.Generics.Collections;

type
  TValidaContaContabil = Class(TInterfacedObject, IValidaContaContabil, IUpdateContaContabil)
  private
    FDataSet : TUniClientDataSet;
    FDataSetWarning : TUniClientDataSet;
    FListaContabilizaveis : TObjectList<TContabilizaveis>;
    FUpdateContaContabil: IUpdateContaContabil;
    function GetDataSet: TUniClientDataSet;
    function GetDataSetWarnings: TUniClientDataSet;
  public
    function GetFiltrosExcecao: String;
    constructor Create;
    destructor Destroy; override;
    class function New: IValidaContaContabil;
    procedure pAddErro(recContaErro: TContaErro; const AContabilizaveis: TContabilizaveis; const AdtaLan: TDateTime = 0);
    procedure setContaContabil(const AConta, AIncDoc: string);
    function getContabilizaveis : TObjectList<TContabilizaveis>;
    property DataSet: TUniClientDataSet read GetDataSet;
    property DataSetWarning: TUniClientDataSet read GetDataSetWarnings;
    property FiltrosExcecao: String read GetFiltrosExcecao;
  End;

implementation

{ TValidaContaContabil }

uses System.SysUtils, Data.DB, Contabilidade.Classes.TUpdateContaContabil,
     Contabilidade.Funcoes, untFuncoesSimples, Uni;

constructor TValidaContaContabil.Create;
begin
  FDataSet := fCriarDataSetErros;
  FDataSetWarning := fCriarDataSetErros;
  FListaContabilizaveis := TObjectList<TContabilizaveis>.Create;
  FUpdateContaContabil := TUpdateContaContabil.New(FListaContabilizaveis);
end;

destructor TValidaContaContabil.Destroy;
begin
  FreeAndNil(FDataSet);
  FreeAndNil(FDataSetWarning);
  FListaContabilizaveis.Free;
  inherited;
end;

function TValidaContaContabil.getContabilizaveis: TObjectList<TContabilizaveis>;
begin
  Result := FListaContabilizaveis;
end;

function TValidaContaContabil.GetDataSetWarnings: TUniClientDataSet;
begin
  Result := FDataSetWarning;
end;

function TValidaContaContabil.GetFiltrosExcecao: String;
var
  qryConsulta : TUniQuery ;
  strRetorno : string ;
begin
  qryConsulta := fCriaQuery ;
  try
    qryConsulta.Close ;
    qryConsulta.SQL.Clear ;
    qryConsulta.SQL.Add('SELECT EXC_FLTTXT FROM PNLEXC') ;
    qryConsulta.Open ;
    qryConsulta.First ;
    strRetorno := '' ;
    while not qryConsulta.Eof do
    begin
      if fEmptyStr(strRetorno) then
      begin
        strRetorno := '(' + qryConsulta.FieldByName('EXC_FLTTXT').AsString + ') ' ;
      end
      else
      begin
        strRetorno := strRetorno + ' OR (' + qryConsulta.FieldByName('EXC_FLTTXT').AsString + ') ' ;
      end;
      qryConsulta.Next ;
    end;
    result := strRetorno ;
  finally
    FreeAndNil(qryConsulta);
  end;
end;

function TValidaContaContabil.GetDataSet: TUniClientDataSet;
begin
  Result := FDataSet;
end;

class function TValidaContaContabil.New: IValidaContaContabil;
begin
  Result := Self.Create;
end;

procedure TValidaContaContabil.pAddErro(recContaErro: TContaErro; const AContabilizaveis: TContabilizaveis; const AdtaLan: TDateTime = 0);
var
  LDataSet : TUniClientDataSet ;
  LblnConsumido: Boolean ;
begin
  LblnConsumido := False ;
  try
    if recContaErro.strWarning = 'N' then
    begin
      LDataSet := FDataSet ;
    end
    else
    begin
      LDataSet := FDataSetWarning ;
    end;

    LblnConsumido := FListaContabilizaveis.IndexOf(AContabilizaveis) >= 0 ;

    if (recContaErro.strWarning = 'S') And
       (not fEhAdmContabilidade) And
       (not fMostrarWarningGeracaoMovimento(recContaErro.strTipLan)) then
      exit;

    LDataSet.Insert;
    LDataSet.FieldByName('ERR_STATUS').AsString := 'EE';
    LDataSet.FieldByName('ERR_MOTIVO').AsString := recContaErro.strMotivo;
    LDataSet.FieldByName('ERR_HISTOR').AsString := recContaErro.strHistor;
    LDataSet.FieldByName('ERR_TIPLAN').AsString := recContaErro.strTipLan;
    LDataSet.FieldByName('ERR_DESVAL').AsString := recContaErro.strDesVal;
    LDataSet.FieldByName('ERR_NATOPE').AsString := recContaErro.strNatOpe;
    LDataSet.FieldByName('ERR_ORIPLA').AsString := recContaErro.strOriPla;
    LDataSet.FieldByName('ERR_CHVDOC').AsString := recContaErro.strChaveDocumento;
    LDataSet.FieldByName('ERR_TABELA').AsString := recContaErro.strTabela;
    LDataSet.FieldByName('ERR_WARNIN').AsString := recContaErro.strWarning;
    LDataSet.FieldByName('ERR_CODEMP').AsString := recContaErro.strCodEmp;
    // A data vem por parametro e nao no TContaErro: os chamadores das validacoes declaram o registro
    // sem zerar, e um TDateTime ali chegaria com lixo da pilha (Req. 470760).
    if AdtaLan > 0 then
      LDataSet.FieldByName('ERR_DTALAN').AsDateTime := AdtaLan;
    LDataSet.FieldByName('ERR_SIGLA').AsString := recContaErro.strSigla;
    LDataSet.Post;

    if not LblnConsumido then
    begin
      FListaContabilizaveis.Add(AContabilizaveis);
      LblnConsumido := True;
    end;

  finally
    if not LblnConsumido then
      AContabilizaveis.Free;
  end ;
end;

procedure TValidaContaContabil.setContaContabil(const AConta, AIncDoc: string);
begin
  FUpdateContaContabil.setContaContabil(AConta, AIncDoc);
end;

end.
