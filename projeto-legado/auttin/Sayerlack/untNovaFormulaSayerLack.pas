unit untNovaFormulaSayerLack;

interface

uses
  untINovaFormula, DB, Uni,  SysUtils, Classes,
   untAbstractNovaFormulaImobiliaria;

type
  TNovaFormulaSayerLack = class(TAbstractNovaFormulaImobiliaria, INovaFormula)
  private
    qryCadSay: TUniQuery;
    qryCadEmb: TUniQuery;
  public
    function GetIdePro: string; override;
    function GetNomeTabelaNovaFormula: string; override;
    function GravarNovaFormula(const qryNfm: TDataSet): Boolean; override;
    procedure RemoverNovaFormula(const strCodNfm: string); override;
    procedure pCriaDataSets(const qryNfm: TDataSet); override;
    procedure pInicializaIndices(const stlCampos, stlCamInd, stlDesInd: TStringList); override;
    function GetNomeTabelaComponete: string; override;
    function GetSqlSelectComponente(const qryNfm: TDataSet): string; override;
    function GetTamanhoCampoComponente: Integer; override;
    constructor Create();
    destructor Destroy; override;
  end;

implementation

uses untFuncoesSimples;

{ TNovaFormulaSayerLack }

constructor TNovaFormulaSayerLack.Create;
begin
  qryCadSay := fCriaQuery();
  qryCadSay.SQL.Text := 'SELECT * FROM SAY_CADSAY WHERE FALSE';
  qryCadSay.Open;

  qryCadEmb := fCriaQuery();
  qryCadEmb.SQL.Text :=
    ' SELECT DISTINCT                ' +
    '   SAY_CADEMB.*                 ' +
    ' FROM                           ' +
    '   SAY_CADEMB                   ' +
    '   INNER JOIN SAY_CADBAS        ' +
    '     ON EMB_DESEMB = BAS_DESEMB ';
  qryCadEmb.Open;
end;

destructor TNovaFormulaSayerLack.Destroy;
begin
  if Assigned(qryCadSay) then FreeAndNil(qryCadSay);
  if Assigned(qryCadEmb) then FreeAndNil(qryCadEmb);
  inherited;
end;

function TNovaFormulaSayerLack.GetIdePro: string;
begin
  Result := 'SAY';
end;

function TNovaFormulaSayerLack.GetNomeTabelaComponete: string;
begin
  Result := 'SAY_CADCOL';
end;

function TNovaFormulaSayerLack.GetNomeTabelaNovaFormula: string;
begin
  Result := 'SAY_CADNFM';
end;

function TNovaFormulaSayerLack.GetSqlSelectComponente(
  const qryNfm: TDataSet): string;
begin
  Result :=
  ' SELECT                                       ' +
  '     SAY_CADCOL.AUTOINCREM                    ' +
  '   , COL_CODCOL AS ''Código do Colorante''    ' +
  '   , COL_DESCRI AS ''Descrição do Colorante'' ' +
  '   , ITE_CODITE AS ''Código do Item''         ' +
  '   , ITE_DESITE AS ''Descrição do Item''      ' +
  '   , ITE_REFERE AS ''Referência do Item''     ' +
  ' FROM                                         ' +
  '   SAY_CADCOL                                 ' +
  '   LEFT JOIN CADITE                           ' +
  '     ON COL_CODITE = ITE_CODITE               ';
end;

function TNovaFormulaSayerLack.GetTamanhoCampoComponente: Integer;
begin
  Result := 15;
end;

function TNovaFormulaSayerLack.GravarNovaFormula(const qryNfm: TDataSet): Boolean;
var
  intCont: Integer;
  fltFator: Double;
begin
  Result := True;

  qryCadEmb.Filtered := False;
  qryCadEmb.Filter := 'EMB_DESEMB = ' + QuotedStr(qryNfm.FieldByName('NFM_DESEMB').AsString);
  qryCadEmb.Filtered := True;
  fltFator := qryCadEmb.FieldByName('EMB_EMBALA').AsFloat;

  qryCadEmb.Filtered := False;
  qryCadEmb.Filter := '';
  qryCadEmb.Filtered := True;
  qryCadEmb.First;

  while not qryCadEmb.Eof do
  begin
    Try
      Try
        qryCadSay.Insert;
        qryCadSay.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SAY_CADSAY', qryNfm.FieldByName('NFM_CODEMP').AsString);
        qryCadSay.FieldByName('SAY_CODEMP').AsString := qryNfm.FieldByName('NFM_CODEMP').AsString;
        qryCadSay.FieldByName('SAY_BASE__').AsString := qryNfm.FieldByName('NFM_BASE__').AsString;
        qryCadSay.FieldByName('SAY_CODBAS').AsString := qryNfm.FieldByName('NFM_CODBAS').AsString;
        qryCadSay.FieldByName('SAY_PRODUT').AsString := qryNfm.FieldByName('NFM_PRODUT').AsString;
        qryCadSay.FieldByName('SAY_DESEMB').AsString := qryCadEmb.FieldByName('EMB_DESEMB').AsString;
        qryCadSay.FieldByName('SAY_CODNFM').AsString := qryNfm.FieldByName('NFM_CODNFM').AsString;
        qryCadSay.FieldByName('SAY_DESCRI').AsString := qryNfm.FieldByName('NFM_DESCRI').AsString;
        qryCadSay.FieldByName('SAY_CODIGO').AsString := qryNfm.FieldByName('NFM_CODNFM').AsString;
        qryCadSay.FieldByName('SAY_DTACAD').AsDateTime := qryNfm.FieldByName('NFM_DTACAD').AsDateTime;
        
        for intCont := 1 to 20 do
        begin
          if qryNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat <= 0 then
            Break;

          if fEmptyStr(qryNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString) then
            Break;

          qryCadSay.FieldByName('SAY_FORM' + fStrZero(intCont, 2)).AsString := qryNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString;
          qryCadSay.FieldByName('SAY_QTDC' + fStrZero(intCont, 2)).AsFloat := qryNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat *
                                                                                qryCadEmb.FieldByName('EMB_EMBALA').AsFloat / fltFator;
        end;

        qryCadSay.FieldByName('SAY_MD5KEY').AsString := GetMD5(qryCadSay.FieldByName('SAY_BASE__').AsString +
          qryCadSay.FieldByName('SAY_CODBAS').AsString + qryCadSay.FieldByName('SAY_PRODUT').AsString +
          qryCadSay.FieldByName('SAY_CODIGO').AsString + qryCadSay.FieldByName('SAY_DESEMB').AsString);
        
        qryCadSay.Post;
      Except
        on E: Exception do
        begin
        end;
      End;
    Finally
      qryCadEmb.Next;
    End;
  end;
end;

procedure TNovaFormulaSayerLack.pCriaDataSets(const qryNfm: TDataSet);
var
  intCont: Integer;
begin
  inherited pCriaDataSets(qryNfm);
  qryNfm.FieldbyName('NFM_BASE__').DisplayLabel := 'Base';
  qryNfm.FieldbyName('NFM_CODBAS').DisplayLabel := 'Código Base';
  qryNfm.FieldbyName('NFM_PRODUT').DisplayLabel := 'Produto';
  qryNfm.FieldbyName('NFM_DESCRI').DisplayLabel := 'Descrição';
  qryNfm.FieldbyName('NFM_DESEMB').DisplayLabel := 'Embalagem';
  qryNfm.FieldbyName('NFM_CODNFM').DisplayLabel := 'Código';

  For intCont := 1 To 20 Do
  Begin
    TFloatField(qryNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2))).DisplayFormat := '0.00';
  End;
end;

procedure TNovaFormulaSayerLack.pInicializaIndices(const stlCampos, stlCamInd, stlDesInd: TStringList);
begin
  stlCampos.Add('NFM_DESCRI');
  stlCampos.Add('NFM_BASE__');
  stlCampos.Add('NFM_CODBAS');
  stlCampos.Add('NFM_PRODUT');
  stlCampos.Add('NFM_DESEMB');

  stlCamInd.Add('NFM_DESCRI');
  stlCamInd.Add('NFM_BASE__');
  stlCamInd.Add('NFM_CODBAS');
  stlCamInd.Add('NFM_PRODUT');
  stlCamInd.Add('NFM_DESEMB');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Base');
  stlDesInd.Add('Código Base');
  stlDesInd.Add('Produto');
  stlDesInd.Add('Embalagem');
end;

procedure TNovaFormulaSayerLack.RemoverNovaFormula(const strCodNfm: string);
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text := 'DELETE FROM SAY_CADSAY WHERE SAY_CODNFM = :CODNFM';
      qryGen.ParamByName('CODNFM').AsString := strCodNfm;
      qryGen.ExecSQL;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

end.
