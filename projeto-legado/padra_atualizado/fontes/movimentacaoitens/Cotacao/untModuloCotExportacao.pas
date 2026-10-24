unit untModuloCotExportacao;

interface

uses
  SysUtils, Classes, frxClass, frxDBSet, frxExportXLS, frxExportPDF, DB,
  Uni, UniClientDataSet, Variants, Forms, Datasnap.DBClient;

type
  TfrmModuloCotExportacao = class(TForm)
    frxPDFExport: TfrxPDFExport;
    frxXLSExport: TfrxXLSExport;
    frxReportPDF: TfrxReport;
    frxDBTitulo: TfrxDBDataset;
    frxItens: TfrxDBDataset;
    dtsItens: TDataSource;
    frxReportXLS: TfrxReport;
    frxUser: TfrxUserDataSet;
    frxReportPDF_P: TfrxReport;
    procedure DataModuleCreate(Sender: TObject);
    procedure frxUserGetValue(const VarName: String; var Value: Variant);
    function frxReportPDFUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxReportPDF_PUserFunction(const MethodName: string;
      var Params: Variant): Variant;
  private
    { Private declarations }
    qryTitulo: TUniQuery;

    Procedure pLeEmpresa;

    function fRetCodFab(strCodIte: String): String;

  public
    { Public declarations }
    strIndFor: String;
    cdsItensExp: TUniClientDataSet;

    FTabprf: Boolean;
    FCodFor: String;
  end;

var
  frmModuloCotExportacao: TfrmModuloCotExportacao;

implementation

uses untFuncoesSimples;

{$R *.dfm}

function TfrmModuloCotExportacao.fRetCodFab(strCodIte: String): String;
var
  FqryConsulta: TUniQuery;
  FqryCodFabPrincipal: TUniQuery;
  intCnt: Integer;
begin

  FqryConsulta:= fCriaQuery();
  FqryCodFabPrincipal:= fCriaQuery();
  Try
    FqryConsulta.sql.Clear;
    FqryConsulta.SQL.Add('   SELECT COUNT(1) AS CNT FROM ITEFOR F ');
    FqryConsulta.SQL.Add('   WHERE F.ITE_CODITE = :CODITE         ');
    FqryConsulta.SQL.Add('     AND F.ITE_CODFOR = :CODFOR         ');
    FqryConsulta.ParamByName('CODITE').AsString := strCodIte;
    FqryConsulta.ParamByName('CODFOR').AsString := FCodFor;
    FqryConsulta.Open;
    intCnt := FqryConsulta.FieldByName('CNT').AsInteger;

    If intCnt > 1 Then
    Begin
      FqryConsulta.sql.Clear;
      FqryConsulta.SQL.Add('  SELECT SQL_NO_CACHE            ');
      FqryConsulta.SQL.Add('   I02_CPROD                     ');
      FqryConsulta.SQL.Add('  FROM DETELE                    ');
      FqryConsulta.SQL.Add('  INNER JOIN GERELE G            ');
      FqryConsulta.SQL.Add('    ON DET_SEQGER = G.AUTOINCREM ');
      FqryConsulta.SQL.Add('  WHERE G.GER_CODFOR = :CODFOR   ');
      FqryConsulta.SQL.Add('      AND DET_CODITE = :CODITE   ');
      FqryConsulta.SQL.Add('  ORDER BY                       ');
      FqryConsulta.SQL.Add('    G.B10_DSAIENT DESC LIMIT 1   ');
      FqryConsulta.ParamByName('CODITE').AsString := strCodIte;
      FqryConsulta.ParamByName('CODFOR').AsString := FCodFor;
      FqryConsulta.Open;
      Result := FqryConsulta.FieldByName('I02_CPROD').AsString;
      Exit;
    End;

    FqryConsulta.sql.Clear;
    IF FTabprf Then
    begin
      FqryConsulta.SQL.Add('   SELECT * FROM ITEFOR F');
      FqryConsulta.SQL.Add('    WHERE  F.ITE_CODFAB IS NOT NULL');
      FqryConsulta.SQL.Add('      AND (SELECT COUNT(*) FROM TABPRE');
      FqryConsulta.SQL.Add('            WHERE F.ITE_CODTAB = TAB_CODTAB AND TAB_ATICMP = "S") > 0');
      FqryConsulta.SQL.Add('     AND F.ITE_CODITE = :CODITE');
      FqryConsulta.SQL.Add('      AND F.ITE_CODFOR = :CODFOR');
      FqryConsulta.SQL.Add('      GROUP BY F.ITE_CODFAB');
    End
    Else
    Begin
      FqryConsulta.SQL.Add('SELECT * FROM ITEFOR F');
      FqryConsulta.SQL.Add('  WHERE F.ITE_CODITE = :CODITE');
      FqryConsulta.SQL.Add('    AND F.ITE_CODFOR = :CODFOR');
      FqryConsulta.SQL.Add('    AND F.AUTOINCREM = (SELECT MAX(FF.AUTOINCREM) FROM ITEFOR FF');
      FqryConsulta.SQL.Add('                         WHERE FF.ITE_CODITE = :CODITE');
      FqryConsulta.SQL.Add('                          AND  FF.ITE_CODFOR = :CODFOR)');
    End;

    FqryConsulta.ParamByName('CODITE').AsString := strCodIte;
    FqryConsulta.ParamByName('CODFOR').AsString := FCodFor;
    FqryConsulta.Open;

    FqryCodFabPrincipal.Close;
    FqryCodFabPrincipal.SQL.Clear;
    FqryCodFabPrincipal.SQL.Add('   SELECT ITE_CODFAB FROM CADITE ');
    FqryCodFabPrincipal.SQL.Add('    WHERE  ITE_CODITE = :CODITE');
    FqryCodFabPrincipal.ParamByName('CODITE').AsString := strCodIte;
    FqryCodFabPrincipal.Open;

    If FqryConsulta.IsEmpty Then
    Begin
      Result := FqryCodFabPrincipal.FieldByName('ITE_CODFAB').AsString;
    End
    Else
    Begin
      If FTabprf Then
        Result :=  IIF(FqryConsulta.FieldByName('ITE_CODFAB').AsString = '' , FqryCodFabPrincipal.FieldByName('ITE_CODFAB').AsString, FqryConsulta.FieldByName('ITE_CODFAB').AsString)
      Else
        Result :=  IIF(FqryConsulta.FieldByName('ITE_CODITF').AsString = '' , FqryCodFabPrincipal.FieldByName('ITE_CODFAB').AsString, FqryConsulta.FieldByName('ITE_CODITF').AsString);
    End;

  Finally
    FreeAndNil(FqryConsulta);
    FreeAndNil(FqryCodFabPrincipal);
  End;

end;

Procedure TfrmModuloCotExportacao.pLeEmpresa;
  Var
    strSQL: String;
Begin
  frxDBTitulo.DataSet := qryTitulo;

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  EMP_NOMEMP, ';
  strSQL := strSQL + '  CONCAT(EMP_ENDERE, ", ", IFNULL(EMP_ENDNUM,""), "  ", IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT("  ", EMP_ENDCMP)), " - ", EMP_BAIRRO) AS EMP_ENDERE, ';
  strSQL := strSQL + '  CONCAT(CADCID.CID_NOMCID, "-", CADCID.CID_ESTADO, "   CEP: ", EMP_C_E_P_) AS EMP_NOMCID, ';
  strSQL := strSQL + '  EMP_FONE01, ';
  strSQL := strSQL + '  EMP_F_A_X_, ';
  strSQL := strSQL + '  EMP_EMAIL_ ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADEMP, ';
  strSQL := strSQL + '  CADCID ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CADEMP.EMP_CODCID = CADCID.CID_CODCID AND ';
  strSQL := strSQL + '  CADEMP.EMP_CODEMP = :CODEMP ';

  With qryTitulo Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
  End;

End;


procedure TfrmModuloCotExportacao.DataModuleCreate(Sender: TObject);
  var
    intContador:integer;
begin
  {****************************************************}
  {*  DESABILITA OS BOTÕES SAVE, LOAD e EDIT DO FAST  *}
  {*11/05/2015**************************************RB*}
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin

    If (Self.Components[intContador] Is TfrxReport) Then
    Begin
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons :=
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons - [pbSave, pbLoad, pbEdit];
    End;
  End;

  qryTitulo := fCriaQuery(Self);

  pLeEmpresa;

  FTabprf:= False;
  FCodFor:= '';

  frxReportPDF.AddFunction('function fRetCodFab(strCodIte: String): String;');
  frxReportPDF_P.AddFunction('function fRetCodFab(strCodIte: String): String;');

end;

function TfrmModuloCotExportacao.frxReportPDFUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If SameText(UpperCase(MethodName), UpperCase('fRetCodFab')) Then
    Result := fRetCodFab(Params[0]);
end;

function TfrmModuloCotExportacao.frxReportPDF_PUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If SameText(UpperCase(MethodName), UpperCase('fRetCodFab')) Then
    Result := fRetCodFab(Params[0]);
end;

procedure TfrmModuloCotExportacao.frxUserGetValue(const VarName: String;
  var Value: Variant);
begin

  With dtsItens.DataSet Do
  If SameText('VALUNI',VarName) Then
  Begin
    Value := FieldByName('VALUNI' + strIndFor).AsFloat
  End

  Else If SameText('IPIENT',VarName) Then
  Begin
    Value := FieldByName('IPIENT' + strIndFor).AsFloat
  End

  Else If SameText('SUBSTI',VarName) Then
  Begin
    Value := FieldByName('SUBSTI' + strIndFor).AsFloat
  End

  Else If SameText('VALTOT',VarName) Then
  Begin
    Value := FieldByName('VALTOT' + strIndFor).AsFloat
  End

  Else If SameText('FREENT',VarName) Then
  Begin
    Value := FieldByName('FREENT' + strIndFor).AsFloat
  End


  Else If SameText('CODFAB',VarName) Then
  Begin
    cdsItensExp.FieldByName('CODFOR').AsString;
    cdsItensExp.FieldByName('CODITE').AsString;
    Value := '''' + FieldByName('CODFAB').AsString
  End

end;

end.
