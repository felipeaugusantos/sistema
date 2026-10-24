unit Contabilidade.Classes.THistoricoLanCon;

interface

uses Uni, Classes, System.Generics.Collections;

type
  THistoricoLanCon = class(TComponent)
  strict private
    FIgnorarCFOP: Boolean;
    FComplemento: string;
    FqryDados : TUniQuery;
    function getFieldValue(Value: string): string;
    function getFieldValueAsDateFormat(Value: string): string;
    procedure addComplemento(var Result: string; const Value: string);
    procedure addComplementoIfContainsHistorico(var Result: string; const AHistorico: string; const AValue: string);
    function fTrataCodigoEmpresa:string ;
    function fTrataNomeEmpresa:string ;
    function fGetPortadorHistorico(const AstrCodPor: String; AdictControlePortadores: TDictionary<String,String>): String ;
  public
    constructor Create(AComplemento: string; qryDados: TUniQuery; const AIgnorarCFOP: Boolean = False); reintroduce;
    function getHistorico(AdictControlePortadores: TDictionary<String,String>): string;
  end;

implementation

uses untFuncoesSimples, SysUtils, Contabilidade.Funcoes;

{ THistoricoLanCon }

procedure THistoricoLanCon.addComplemento(var Result: string; const Value: string);
begin
  if fEmptyStr(Value) then
    exit;

  if fEmptyStr(Result) then
    Result := Value
  else
    Result := Concat(Result, ' / ', Value);
end;

constructor THistoricoLanCon.Create(AComplemento: string; qryDados: TUniQuery; const AIgnorarCFOP: Boolean);
begin
  FComplemento := AComplemento;
  FqryDados := qryDados;
  FIgnorarCFOP := AIgnorarCFOP;
end;

function THistoricoLanCon.fGetPortadorHistorico(const AstrCodPor: String;
  AdictControlePortadores: TDictionary<String,String>): String;
var
  LstrPortador: String ;
begin
  Result := '' ;
  if fEmptyStr(AstrCodPor) then
    Exit ;

  if not AdictControlePortadores.ContainsKey(AstrCodPor) then
  begin
    LstrPortador := fCampoTabela('POR_NOMPOR', 'CADPOR', ['POR_CODPOR'], [AstrCodPor], False) ;
    AdictControlePortadores.Add(AstrCodPor, LstrPortador);
  end
  else
    LstrPortador := AdictControlePortadores.Items[AstrCodPor] ;

  Result := concat('PORTADOR REC:', AstrCodPor, '-', LstrPortador ) ;

end;

function THistoricoLanCon.fTrataCodigoEmpresa: string;
begin
  result := '' ;

  if assigned(FqryDados.FindField('CDE_CODEMP')) then
  begin
    if not fEmptyStr(FqryDados.FieldByName('CDE_CODEMP').AsString) then
    begin
      result := FqryDados.FieldByName('CDE_CODEMP').AsString ;
      exit ;
    end;
  end;

  if assigned(FqryDados.FindField('CODEMP')) then
  begin
    result := FqryDados.FieldByName('CODEMP').AsString ;
  end;
end;

function THistoricoLanCon.fTrataNomeEmpresa: string;
begin
  result := '' ;

  if assigned(FqryDados.FindField('CDE_NOMEMP')) then
  begin
    if not fEmptyStr(FqryDados.FieldByName('CDE_NOMEMP').AsString) then
    begin
      result := FqryDados.FieldByName('CDE_NOMEMP').AsString ;
      exit ;
    end;
  end;

  if assigned(FqryDados.FindField('NOMEMP')) then
  begin
    result := FqryDados.FieldByName('NOMEMP').AsString ;
  end;
end;

procedure THistoricoLanCon.addComplementoIfContainsHistorico(var Result: string; const AHistorico: string; const AValue: string);
begin
  if FComplemento.Contains(AHistorico) then
    addComplemento(Result, AValue);
end;

function THistoricoLanCon.getHistorico(AdictControlePortadores: TDictionary<String,String>): string;
begin
  Result := '';

  if fEmptyStr(FComplemento) then
    exit;

  if FComplemento.Contains('N. Docto') then
  begin
    addComplemento(Result, fRemoveZerosEsquerda(getFieldValue('NUMDOC')) + '-' + getFieldValue('ESPDOC'));

    addComplemento(Result, IIF(fEmptyStr(getFieldValue('DOCORI')), '', 'Doc.Ori: ' + fRemoveZerosEsquerda(getFieldValue('DOCORI')) + '-' + getFieldValue('ESPORI')));
  end;

  addComplementoIfContainsHistorico(Result, 'Codigo Bem', getFieldValue('CODBEM'));
  addComplementoIfContainsHistorico(Result, 'N. Patrimonio', getFieldValue('NUMPAT'));
  addComplementoIfContainsHistorico(Result, 'Nome fornecedor/cliente', getFieldValue('NOME'));
  addComplementoIfContainsHistorico(Result, 'CNPJ', getFieldValue('CNPJ'));
  if not FIgnorarCFOP then
    addComplementoIfContainsHistorico(Result, 'CFOP', getFieldValue('CLAFIS'));
  addComplementoIfContainsHistorico(Result, 'Parcela', getFieldValue('PARCEL'));
  addComplementoIfContainsHistorico(Result, 'Nome Empresa', fTrataNomeEmpresa);
  addComplementoIfContainsHistorico(Result, 'Código Empresa', fTrataCodigoEmpresa);
  addComplementoIfContainsHistorico(Result, 'Data de Cadastro', getFieldValueAsDateFormat('DTACAD'));
  addComplementoIfContainsHistorico(Result, 'Data de Pagamento', getFieldValueAsDateFormat('DTAPAG'));
  addComplementoIfContainsHistorico(Result, 'Data de Recebimento', getFieldValueAsDateFormat('DTAREC'));
  addComplementoIfContainsHistorico(Result, 'Portador Recebimento', fGetPortadorHistorico(getFieldValue('CODIGO_PORTADOR'), AdictControlePortadores));
  addComplementoIfContainsHistorico(Result, 'Hist. Padrão', getFieldValue('HIST01'));
  addComplementoIfContainsHistorico(Result, 'Histórico da Baixa', getFieldValue('HISBAI'));
  addComplementoIfContainsHistorico(Result, 'N. Cheque', IIF(fEmptyStr(getFieldValue('CHQ_NUMCHQ')), '', Concat('CHEQUE(S) NÚMERO(S): ', getFieldValue('CHQ_NUMCHQ'))));
  addComplementoIfContainsHistorico(Result, 'Observação', getFieldValue('OBSERVACAO'));
  addComplementoIfContainsHistorico(Result, 'Nota Fiscal', getFieldValue('NOTAFISCAL'));

  if FComplemento.Contains('Histórico da Movimentação') then
  begin
    addComplemento(Result, getFieldValue('CTB_HIST01'));
    addComplemento(Result, getFieldValue('CTB_HIST02'));
  end;
end;

function THistoricoLanCon.getFieldValue(Value: string): string;
begin
  Result := '';

  if not Assigned(FqryDados.FindField(Value)) then
    exit;

  Result := FqryDados.FieldByName(Value).AsString;
end;

function THistoricoLanCon.getFieldValueAsDateFormat(Value: string): string;
begin
  Result := '';

  if not Assigned(FqryDados.FindField(Value)) then
    exit;

  if FqryDados.FieldByName(Value).isNull then
    exit;

  Result := FormatDateTime('dd/mm/yyyy', FqryDados.FieldByName(Value).AsDateTime);
end;

end.
