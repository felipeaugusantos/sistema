unit untNovaFormulaBrasimixImobiliaria;

interface

uses
  untINovaFormula, DB, Uni,  SysUtils, Classes;

type
  TNovaFormulaBrasimixImobiliaria = class(TInterfacedObject, INovaFormula)
  private
    qryCadBzi: TUniQuery;
    function GetColorante(const strComponente: string; const qryNfm: TDataSet): TUniQuery;
  public
    procedure GetCamposChaves(var arrChaves: array of string);
    function GetCountCamposChaves: Integer;
    function GetIdePro: string;
    function GetNomeConfProCod: string;
    function GetNomeTabelaNovaFormula: string;
    function GetSqlSelectNovasFormulas: string;
    function GravarNovaFormula(const qryNfm: TDataSet): Boolean;
    procedure RemoverNovaFormula(const strCodNfm: string);
    function GetCountModos: Integer;
    function GetMaximoComponentes: Integer;
    function GetNomeModo(const index: Integer): string;
    function GetPrefixoComponente: string;
    function GetPrefixoQuantidade(const intModo: Integer): string;
    function GetTamanhoCampoComponente: Integer;
    function GetTamanhoModo(const index: Integer): Integer;
    function GetTipoModo(const index: Integer): TFieldType;
    procedure pCriaDataSets(const qryNfm: TDataSet);
    procedure pInicializaIndices(const stlCampos, stlCamInd, stlDesInd: TStringList);
    function ComponenteValido(const strComponente: string; const qryNfm: TDataSet): Boolean;
    procedure ValidaComponente(const strComponente: string; const qryNfm: TDataSet);
    function GetNomeTabelaComponete: string;
    function GetSqlSelectComponente(const qryNfm: TDataSet): string;
    procedure MontaIndicesConsultaComponentes(const stlCamposIndices: TStringList; const stlDescricaoIndices: TStringList);
    function GetNomeCampoComponente: string;
    function IsValorVazio(const strValor: string): Boolean;
    constructor Create();
    destructor Destroy; override;
  end;

implementation

uses untFuncoesSimples;

{ TNovaFormulaBrasimixImobiliaria }

function TNovaFormulaBrasimixImobiliaria.ComponenteValido(const strComponente: string; const qryNfm: TDataSet): Boolean;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Result := False;
  Try
    Try
      qryGen := GetColorante(strComponente, qryNfm);
      Result := (not qryGen.IsEmpty);
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

constructor TNovaFormulaBrasimixImobiliaria.Create;
begin
  qryCadBzi := fCriaQuery();
  qryCadBzi.SQL.Text := 'SELECT * FROM BZI_CADBZI WHERE FALSE';
  qryCadBzi.Open;
end;

destructor TNovaFormulaBrasimixImobiliaria.Destroy;
begin
  if Assigned(qryCadBzi) then FreeAndNil(qryCadBzi);
  inherited;
end;

procedure TNovaFormulaBrasimixImobiliaria.GetCamposChaves(var arrChaves: array of string);
begin
  arrChaves[0] := 'NFM_CODNFM';
end;

function TNovaFormulaBrasimixImobiliaria.GetColorante(const strComponente: string; const qryNfm: TDataSet): TUniQuery;
begin
  Result := fCriaQuery();
  Result.SQL.Text := GetSqlSelectComponente(qryNfm);
  Result.SQL.Text := Result.SQL.Text +
    'WHERE COL_CODCOL = :CODCOL ';
  Result.ParamByName('CODCOL').AsString := strComponente;
  Result.Open;
end;

function TNovaFormulaBrasimixImobiliaria.GetCountCamposChaves: Integer;
begin
  Result := 1;
end;

function TNovaFormulaBrasimixImobiliaria.GetCountModos: Integer;
begin
  Result := 1;
end;

function TNovaFormulaBrasimixImobiliaria.GetIdePro: string;
begin
  Result := 'BZI';
end;

function TNovaFormulaBrasimixImobiliaria.GetMaximoComponentes: Integer;
begin
  Result := 10;
end;

function TNovaFormulaBrasimixImobiliaria.GetNomeCampoComponente: string;
begin
  Result := 'COL_CODCOL';
end;

function TNovaFormulaBrasimixImobiliaria.GetNomeConfProCod: string;
begin
  Result := 'NFMBRI';
end;

function TNovaFormulaBrasimixImobiliaria.GetNomeModo(const index: Integer): string;
begin
  Result := '';
end;

function TNovaFormulaBrasimixImobiliaria.GetNomeTabelaComponete: string;
begin
  Result := 'BZI_CADCOL';
end;

function TNovaFormulaBrasimixImobiliaria.GetNomeTabelaNovaFormula: string;
begin
  Result := 'BZI_CADNFM';
end;

function TNovaFormulaBrasimixImobiliaria.GetPrefixoComponente: string;
begin
  Result := 'NFM_CODC';
end;

function TNovaFormulaBrasimixImobiliaria.GetPrefixoQuantidade(const intModo: Integer): string;
begin
  Result := 'NFM_QTDC';
end;

function TNovaFormulaBrasimixImobiliaria.GetSqlSelectComponente(const qryNfm: TDataSet): string;
begin
  Result :=
    ' SELECT                                    ' +
    '   BZI_CADCOL.AUTOINCREM                   ' +
    '   , COL_CODCOL AS ''Código do Colorante'' ' +
    '   , ITE_CODITE AS ''Código do Item''      ' +
    '   , ITE_DESITE AS ''Descrição do Item''   ' +
    '   , ITE_REFERE AS ''Referência do Item''  ' +
    ' FROM                                      ' +
    '   BZI_CADCOL                              ' +
    '   LEFT JOIN CADITE                        ' +
    '     ON COL_CODITE = ITE_CODITE            ';
end;

function TNovaFormulaBrasimixImobiliaria.GetSqlSelectNovasFormulas: string;
begin
  Result := 'SELECT * FROM BZI_CADNFM';
end;

function TNovaFormulaBrasimixImobiliaria.GetTamanhoCampoComponente: Integer;
begin
  Result := 2;
end;

function TNovaFormulaBrasimixImobiliaria.GetTamanhoModo(const index: Integer): Integer;
begin
  Result := 0;
end;

function TNovaFormulaBrasimixImobiliaria.GetTipoModo(const index: Integer): TFieldType;
begin
  Result := ftFloat;
end;

function TNovaFormulaBrasimixImobiliaria.GravarNovaFormula(const qryNfm: TDataSet): Boolean;
const
  arrUnidades: array[0..2] of string = ('LT', 'GL', 'LA');
  arrPesos: array[0..2] of Double = (1.0, 4.0, 20.0);
var
  intCont: Integer;
  intUnidades: Integer;
  qryDelNfm: TUniQuery;
begin
  Result := true;

  try

    Try
      qryDelNfm := fCriaQuery;
      qryDelNfm.SQL.Text := 'DELETE FROM BZI_CADBZI WHERE BZI_CODIGO = :CODNFM';
      qryDelNfm.ParamByName('CODNFM').AsString := qryNfm.FieldByName('NFM_CODIGO').AsString;
      qryDelNfm.ExecSQL;
    Finally
      FreeAndNil(qryDelNfm);
    End;

    for intUnidades := 0 to 2 do
    begin
      qryCadBzi.Insert;
      qryCadBzi.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('BZI_CADBZI', qryNfm.FieldByName('NFM_CODEMP').AsString);
      qryCadBzi.FieldByName('BZI_CODIGO').AsString := qryNfm.FieldByName('NFM_CODIGO').AsString;
      qryCadBzi.FieldByName('BZI_DESCRI').AsString := qryNfm.FieldByName('NFM_DESCRI').AsString;
      qryCadBzi.FieldByName('BZI_REFERE').AsString := 'PERSONALIZADA';
      qryCadBzi.FieldByName('BZI_UNIDAD').AsString := arrUnidades[intUnidades];
      qryCadBzi.FieldByName('BZI_CODEMP').AsString := qryNfm.FieldByName('NFM_CODEMP').AsString;
      qryCadBzi.FieldByName('BZI_DTACAD').AsDateTime := qryNfm.FieldByName('NFM_DTACAD').AsDateTime;

      for intCont := 1 to 10 do
      begin
        if fEmptyStr(qryNfm.FieldByName('NFM_CODC' + fStrZero(intCont, 2)).AsString) then
          Break;

        qryCadBzi.FieldByName('BZI_CODC' + fStrZero(intCont, 2)).AsString := qryNfm.FieldByName('NFM_CODC' + fStrZero(intCont, 2)).AsString;
        qryCadBzi.FieldByName('BZI_QTDC' + fStrZero(intCont, 2)).AsFloat :=
          qryNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat * arrPesos[intUnidades];
      end;

      qryCadBzi.FieldByName('BZI_LINHA_').AsString := qryNfm.FieldByName('NFM_LINHA_').AsString;
      qryCadBzi.FieldByName('BZI_CODBAS').AsString := qryNfm.FieldByName('NFM_BASE__').AsString;
      qryCadBzi.FieldByName('BZI_CODUNI').AsString := arrUnidades[intUnidades];
      qryCadBzi.FieldByName('BZI_MD5KEY').AsString := GetMD5(qryCadBzi.FieldByName('BZI_CODIGO').AsString +
                                                            qryCadBzi.FieldByName('BZI_DESCRI').AsString +
                                                            qryCadBzi.FieldByName('BZI_REFERE').AsString +
                                                            qryCadBzi.FieldByName('BZI_UNIDAD').AsString +
                                                            qryCadBzi.FieldByName('BZI_LINHA_').AsString +
                                                            qryCadBzi.FieldByName('BZI_CODBAS').AsString +
                                                            qryCadBzi.FieldByName('BZI_CODUNI').AsString);
      qryCadBzi.Post;
    end;
  except
    on E: Exception do
    begin
      Result := False;
      fMensagem('Atenção','Erro ao inserir novas formulas no BZI_CADBZI !',['&Ok']);
    end;
  end;
end;

function TNovaFormulaBrasimixImobiliaria.IsValorVazio(const strValor: string): Boolean;
begin
  Result := fStrToFloat(strValor) <= 0;
end;

procedure TNovaFormulaBrasimixImobiliaria.MontaIndicesConsultaComponentes(const stlCamposIndices, stlDescricaoIndices: TStringList);
begin
  stlCamposIndices.Add('COL_CODCOL');
  stlCamposIndices.Add('ITE_CODITE');
  stlCamposIndices.Add('ITE_DESITE');
  stlCamposIndices.Add('ITE_REFERE');

  stlDescricaoIndices.Add('Código do Colorante');
  stlDescricaoIndices.Add('Código do Item');
  stlDescricaoIndices.Add('Descrição do Item');
  stlDescricaoIndices.Add('Referência do Item');
end;

procedure TNovaFormulaBrasimixImobiliaria.pCriaDataSets(const qryNfm: TDataSet);
var
  intCont: Integer;
begin
  qryNfm.FieldbyName('NFM_CODIGO').DisplayLabel := 'Código';
  qryNfm.FieldbyName('NFM_LINHA_').DisplayLabel := 'Linha';
  qryNfm.FieldbyName('NFM_BASE__').DisplayLabel := 'Base';
  qryNfm.FieldbyName('NFM_DESCRI').DisplayLabel := 'Descrição';
  qryNfm.FieldbyName('NFM_UNIDAD').DisplayLabel := 'Unidade';
  qryNfm.FieldByName('AUTOINCREM').Visible := False;

  For intCont := 1 To 20 Do
  Begin
    TFloatField(qryNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2))).DisplayFormat := '0.00';
  End;
end;

procedure TNovaFormulaBrasimixImobiliaria.pInicializaIndices(const stlCampos, stlCamInd, stlDesInd: TStringList);
begin
  stlCampos.Add('NFM_CODIGO');
  stlCampos.Add('NFM_LINHA_');
  stlCampos.Add('NFM_BASE__');
  stlCampos.Add('NFM_DESCRI');
  stlCampos.Add('NFM_UNIDAD');

  stlCamInd.Add('NFM_CODIGO');
  stlCamInd.Add('NFM_LINHA_');
  stlCamInd.Add('NFM_BASE__');
  stlCamInd.Add('NFM_DESCRI');
  stlCamInd.Add('NFM_UNIDAD');

  stlDesInd.Add('Código');
  stlDesInd.Add('Linha');
  stlDesInd.Add('Base');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Unidade');
end;

procedure TNovaFormulaBrasimixImobiliaria.RemoverNovaFormula(const strCodNfm: string);
begin
  fExecutaSQL('DELETE FROM BZI_CADBZI WHERE BZI_CODIGO = ' + AnsiQuotedStr(strCodNfm, '"'));
end;

procedure TNovaFormulaBrasimixImobiliaria.ValidaComponente(const strComponente: string; const qryNfm: TDataSet);
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := GetColorante(strComponente, qryNfm);
      if qryGen.IsEmpty then
        raise Exception.CreateFmt('O componente [%s] não está cadastrado!', [strComponente]);
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
