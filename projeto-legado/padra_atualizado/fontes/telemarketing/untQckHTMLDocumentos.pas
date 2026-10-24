
unit untQckHTMLDocumentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB,   Uni, frxClass,
  frxDBSet, frxExportPDF, UniClientDataSet, untFuncoesGenerica, MemDS, DBAccess,
  Datasnap.DBClient;

type
  TfrmQckHTMLDocumentos = class(TForm)
    frxPagina: TfrxReport;
    frxExportaPDF: TfrxPDFExport;
    frxRelatorio: TfrxDBDataset;
    frxRomaneio: TfrxDBDataset;
    qryRelatorio: TUniQuery;
    qryRomaneio: TUniQuery;
    qryRomaneioHIS_NUMROM: TStringField;
    qryRomaneioHIS_DTAROM: TStringField;
    qryRomaneioHIS_NOMMOT: TStringField;
    qryRomaneioHIS_DTABAI: TStringField;
    qryRomaneioHIS_ENTREG: TStringField;
    qryRomaneioHIS_OBSERV: TMemoField;
    cdsDuplicatas: TUniClientDataSet;
    cdsDuplicatasVALOR: TFloatField;
    cdsDuplicatasVENCIMENTO: TStringField;
    cdsDuplicatasSEQUENCIA: TStringField;
    frxDuplicatas: TfrxDBDataset;
    qryModalidades: TUniQuery;
    frxModalidades: TfrxDBDataset;
    qryModalidadesMOD_NUMDOC: TStringField;
    qryModalidadesMOD_ESPDOC: TStringField;
    qryModalidadesMOD_CODEMP: TStringField;
    qryModalidadesMOD_CODCLI: TStringField;
    qryModalidadesMOD_SERIE_: TStringField;
    qryModalidadesMOD_CODMOD: TStringField;
    qryModalidadesMOD_DESMOD: TStringField;
    qryModalidadesMOD_VALMOD: TFloatField;
    qryModalidadesMOD_DOCUME: TStringField;
    qryModalidadesMOD_DTAVEN: TDateField;
    qryModalidadesAUTOINCREM: TStringField;
    cdsServicos: TUniClientDataSet;
    frxServicos: TfrxDBDataset;
    frxVendasPerdidas: TfrxDBDataset;
    qryVendasPerdidas: TUniQuery;
    function frxPaginaUserFunction(const MethodName: String;
      var Params: Variant): Variant;
    procedure FormCreate(Sender: TObject);
    procedure frxPaginaPrintReport(Sender: TObject);
    procedure frxPaginaPreview(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FPais: TPais;
    function fDadosMetragem(strAparel, strBenefi: String; fltQtdPec, fltComPec,
      fltLarPec, fltEspPec: Double): String;
    function fFormataFoneInterna(strTelefo: String): String;
    function fDescontoCliente: Boolean;
    function fGetDesCli: Double;
    function fRetornaMascara: String;
    function fGetEspDoc : String;
    function fEhDV: Boolean;
    { Private declarations }
  public
    { Public declarations }
    strDocsDev: String;
    stlClaIpi : TStringList;
    FstrEspDoc: String;
    FstrCodCli: String;    
    FfltDesCli: Double;
    FClaFis: String;
    procedure pCarregaItensCortados(strNumDoc, strEspDoc, strCodEmp: String);
  end;

var
  frmQckHTMLDocumentos: TfrmQckHTMLDocumentos;

implementation

uses  untfuncoesSimples, StrUtils;

{$R *.dfm}

function TfrmQckHTMLDocumentos.frxPaginaUserFunction(
  const MethodName: String; var Params: Variant): Variant;
begin
  If MethodName = 'FFORMATACONDPAG' Then
    Result := UpperCase(fFormataCondPag(Params[0]))

  Else If MethodName = 'FRETCLAIPI' Then
  Begin

    If stlClaIpi.IndexOf(Params[0]) >= 0 Then
      Result := fGetLetraAlfa(stlClaIpi.IndexOf(Params[0]) + 1)
    Else
      Result := '';

  End

  Else If MethodName = 'FFORMATACPFCGC' Then
      Result := fFormataCpfCgc(Params[0], FPais)

  Else If SameText(MethodName, 'fDadosMetragem') Then
    Result := fDadosMetragem(Params[0], Params[1], Params[2], Params[3], Params[4], Params[5])
  Else If (SameText(MethodName, 'fFormataFone')) Then
    Result := fFormataFoneInterna(Params[0])
  Else If (SameText(MethodName, 'fRetDesForPag')) Then
    Result := fRetDesForPag(Params[0])
  Else If (SameText(MethodName, 'fDescontoCliente')) Then
    Result := fDescontoCliente
  Else If (SameText(MethodName, 'fGetDesCli')) Then
    Result := fGetDesCli
  Else If (SameText(MethodName, 'fStrToFloat')) Then
    Result := fStrToFloat(Params[0])
  Else If (SameText(MethodName, 'fRetornaMascara')) Then
    Result := fRetornaMascara
  Else If (SameText(MethodName, 'fEhDV')) Then
    Result := fEhDV;
end;

function TfrmQckHTMLDocumentos.fFormataFoneInterna(strTelefo: String): String;
begin
  Result := fFormataFone(strTelefo);
end;

function TfrmQckHTMLDocumentos.fGetDesCli: Double;
begin
  Result := FfltDesCli;
end;

function TfrmQckHTMLDocumentos.fGetEspDoc: String;
begin
  Result := FstrEspDoc;
end;

function TfrmQckHTMLDocumentos.fDescontoCliente: Boolean;
begin
  Result := fDescontoClienteProfissional(FstrCodCli) And (Pos(FstrEspDoc, 'OR_PD_FF_DV_') > 0);
end;

function TfrmQckHTMLDocumentos.fEhDV: Boolean;
begin
  Result := ((fGetEspDoc = 'DV') Or (Pos(FClaFis, VS_strClaDev) > 0)) And (fGetEspDoc <> 'TR') ;
end;
                                                               
procedure TfrmQckHTMLDocumentos.FormCreate(Sender: TObject);
  Var
    strSQL: String;
    strSQLChq: String;
    intContador:integer;
begin
  {****************************************************}
  {*  DESABILITA OS BOTÕES SAVE, LOAD e EDIT DO FAST  *}
  {*18/05/2015**************************************RB*}
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin
    If (Self.Components[intContador] Is TfrxReport) Then
    Begin
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons :=
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons - [pbSave, pbLoad, pbEdit];
    End;
  End;

  FPais := fSetaPais;

  stlClaIpi := TStringList.Create;
  stlClaIpi.Sorted := True;
  stlClaIpi.Duplicates := dupIgnore;

  frxPagina.AddFunction('function fFormataCondPag(strCond : String): String');
  frxPagina.AddFunction('function fRetClaIpi(strClaIpi : String): String');
  frxPagina.AddFunction('function fDadosMetragem(strAparel, strBenefi: String; fltQtdPec, fltComPec, fltLarPec, fltEspPec: Double): String');
  frxPagina.AddFunction('function fFormataCpfCgc(strCGCCPF: String): String;');
  frxPagina.AddFunction('function fFormataFone(strTelefo: String): String;');
  frxPagina.AddFunction('function fRetDesForPag(strCodFpg: String): String;');
  frxPagina.AddFunction('function fDescontoCliente: Boolean;');
  frxPagina.AddFunction('function fGetDesCli: Double;');
  frxPagina.AddFunction('function fStrToFloat(strValorUnico: String): Double;');
  frxPagina.AddFunction('function fRetornaMascara: String;');
  frxPagina.AddFunction('function fEhDV: Boolean;');

  strSQLChq := '';
  strSQLChq := strSQLChq + '  SELECT ';
  strSQLChq := strSQLChq + '  	DISTINCT MOD_NUMDOC, ';
  strSQLChq := strSQLChq + '  	MOD_ESPDOC, ';
  strSQLChq := strSQLChq + '  	MOD_CODEMP, ';
  strSQLChq := strSQLChq + '  	MOD_CODCLI, ';
  strSQLChq := strSQLChq + '  	MOD_SERIE_, ';
  strSQLChq := strSQLChq + '  	MOD_CODMOD, ';
  strSQLChq := strSQLChq + '  	FPG_DESCRI AS MOD_DESMOD, ';
  strSQLChq := strSQLChq + '  	CHQ_VALCHQ AS MOD_VALMOD, ';
  strSQLChq := strSQLChq + '  	CONCAT_WS("-", CHQ_CODBCO, CHQ_NUMAGE, CHQ_CONCOR, CHQ_NUMCHQ) AS MOD_DOCUME, ';
  strSQLChq := strSQLChq + '  	CHQ_DTAVEN AS MOD_DTAVEN, ';
  strSQLChq := strSQLChq + '  	CADCHQ.AUTOINCREM ';
  strSQLChq := strSQLChq + '  FROM ';
  strSQLChq := strSQLChq + '  	MOVMOD ';
  strSQLChq := strSQLChq + '  JOIN CADFPG ON FPG_CODIGO = MOD_CODMOD ';
  strSQLChq := strSQLChq + '  JOIN CADCHQ ON CHQ_DOCUME = MOD_DOCUME ';
  strSQLChq := strSQLChq + '  WHERE ';
  strSQLChq := strSQLChq + '  	MOD_NUMDOC = :NUMDOC AND ';
  strSQLChq := strSQLChq + '  	MOD_ESPDOC = :ESPDOC AND ';
  strSQLChq := strSQLChq + '  	MOD_CODEMP = :CODEMP AND ';
  strSQLChq := strSQLChq + '  	MOD_CODCLI = :CODCLI ';
  strSQLChq := strSQLChq + '  GROUP BY ';
  strSQLChq := strSQLChq + '  	CHQ_CODBCO, CHQ_NUMAGE, CHQ_CONCOR, CHQ_NUMCHQ ';

  strSQL := '';
  strSQL := strSQL + '';

  strSQL := strSQL + '  SELECT ';
  strSQL := strSQL + '  	MOD_NUMDOC, ';
  strSQL := strSQL + '  	MOD_ESPDOC, ';
  strSQL := strSQL + '  	MOD_CODEMP, ';
  strSQL := strSQL + '  	MOD_CODCLI, ';
  strSQL := strSQL + '  	MOD_SERIE_, ';
  strSQL := strSQL + '  	MOD_CODMOD, ';
  strSQL := strSQL + '  	FPG_DESCRI AS MOD_DESMOD, ';
  strSQL := strSQL + '  	MOD_VALMOD, ';
  strSQL := strSQL + '  	FPG_DESCRI AS MOD_DOCUME, ';
  strSQL := strSQL + '  	NULL AS MOD_DTAVEN, ';
  strSQL := strSQL + '  	MOVMOD.AUTOINCREM ';
  strSQL := strSQL + '  FROM ';
  strSQL := strSQL + '  	MOVMOD ';
  strSQL := strSQL + '  JOIN CADFPG ON FPG_CODIGO = MOD_CODMOD ';
  strSQL := strSQL + '  WHERE ';
  strSQL := strSQL + '  	MOD_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  	MOD_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  	MOD_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  	MOD_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  	MOD_DOCUME = "" ';

  strSQL := strSQL + '  UNION ALL ';

  strSQL := strSQL + '  SELECT ';
  strSQL := strSQL + '  	DISTINCT MOD_NUMDOC, ';
  strSQL := strSQL + '  	MOD_ESPDOC, ';
  strSQL := strSQL + '  	MOD_CODEMP, ';
  strSQL := strSQL + '  	MOD_CODCLI, ';
  strSQL := strSQL + '  	MOD_SERIE_, ';
  strSQL := strSQL + '  	MOD_CODMOD, ';
  strSQL := strSQL + '  	FPG_DESCRI AS MOD_DESMOD, ';
  strSQL := strSQL + '  	MCA_VALSTA AS MOD_VALMOD, ';
  strSQL := strSQL + '  	CONCAT_WS("-", MCA_CODCAR, CAR_DESCAR, MCA_PARCEL) AS MOD_DOCUME, ';
  strSQL := strSQL + '  	MCA_DTAVEN AS MOD_DTAVEN, ';
  strSQL := strSQL + '  	MOVCAR.AUTOINCREM ';
  strSQL := strSQL + '  FROM ';
  strSQL := strSQL + '  	MOVMOD ';
  strSQL := strSQL + '  JOIN CADFPG ON FPG_CODIGO = MOD_CODMOD ';
  strSQL := strSQL + '  JOIN MOVCAR ON MCA_DOCUME = MOD_DOCUME ';
  strSQL := strSQL + '  JOIN CADCAR ON MCA_CODCAR = CAR_CODCAR ';
  strSQL := strSQL + '  WHERE ';
  strSQL := strSQL + '  	MOD_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  	MOD_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  	MOD_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  	MOD_CODCLI = :CODCLI ';
  strSQL := strSQL + '  GROUP BY ';
  strSQL := strSQL + '  	MCA_NUMDUP, MCA_PARCEL, MCA_CODEMP, MCA_CODCLI ';

  strSQL := strSQL + ' UNION ALL ' + strSQLChq;

  strSQL := strSQL + '  ORDER BY ';
  strSQL := strSQL + '  	6, 11 ';

  qryModalidades.SQL.Clear;
  qryModalidades.SQL.Add(strSQL);

  If (fCfgSis('VENMET') = '1') Then
    TfrxMemoView(frxPagina.FindObject('rllTitVen')).Text := 'Vendedor:'
  Else
    TfrxMemoView(frxPagina.FindObject('rllTitVen')).Text := 'Repres.(I):';

  If (Not fCfgSis('IREPOP', varBoolean)) Then
  Begin
    TfrxMemoView(frxPagina.FindObject('rllTitRep')).Visible := False;
    TfrxMemoView(frxPagina.FindObject('rdbNomRep')).Visible := False;
  End
  Else
  Begin
    TfrxMemoView(frxPagina.FindObject('rllTitRep')).Visible := True;
    TfrxMemoView(frxPagina.FindObject('rdbNomRep')).Visible := True;
  End;
end;

procedure TfrmQckHTMLDocumentos.FormDestroy(Sender: TObject);
begin
  FreeAndNil(stlClaIpi);
end;

procedure TfrmQckHTMLDocumentos.frxPaginaPrintReport(Sender: TObject);
begin
  frxPagina.DotMatrixReport := False;
  frxPagina.PrintOptions.PrintMode := pmScale;
  frxPagina.PrintOptions.PrintOnSheet := 9; // define Tamanho Papel A4
end;

function TfrmQckHTMLDocumentos.fRetornaMascara: String;
begin
  Result := '#,##0.00';

  case fCfgSis('DECUNI', varInteger) of
    1: Result := '#,##0.0';
    2: Result := '#,##0.00';
    3: Result := '#,##0.000';
    4: Result := '#,##0.0000';
  end;
end;

procedure TfrmQckHTMLDocumentos.frxPaginaPreview(Sender: TObject);
begin
  frxPagina.DotMatrixReport := False;
  frxPagina.PrintOptions.PrintMode := pmScale;
  frxPagina.PrintOptions.PrintOnSheet := 9; // define Tamanho Papel A4
end;

function TfrmQckHTMLDocumentos.fDadosMetragem(strAparel, strBenefi: String; fltQtdPec, fltComPec, fltLarPec, fltEspPec: Double): String;
begin

  Result := '';

  If (fltQtdPec > 0) Then
  Begin
    If fCfgSis('VENMAD',varBoolean) Then
    Begin
      If strAparel = 'S'       Then Result := Result + '/APARELHADA';
      If strBenefi = 'S'       Then Result := Result + '/BENEFICIADA';
      If Not fEmptyStr(Result) Then System.Delete(Result, 1, 1);

      Result := 'QTD.: '   + FloatToStrF( fltQtdPec, ffFixed, 12, 02 ) + ' ' +
                'COMP.: '  + FloatToStrF( fltComPec, ffFixed, 12, 05 ) + ' ' +
                'LARG.: '  + FloatToStrF( fltLarPec, ffFixed, 12, 05 ) + ' ' +
                'ESPES.: ' + FloatToStrF( fltEspPec, ffFixed, 12, 05 ) + ' ' + Result;
    End
    Else If fCfgSis('VENMTL',varBoolean) Then
    Begin
      Result := FloatToStrF( fltQtdPec, ffFixed, 12, 05 ) + ' PECAS DE ' +
                FloatToStrF( fltComPec, ffFixed, 12, 05 ) + ' MTS = ' +
                FloatToStrF( fltQtdPec *
                             fltComPec, ffFixed, 12, 05 ) + ' ';
    End
    Else
    Begin
      Result := 'QTD.: '   + FloatToStrF( fltQtdPec, ffFixed, 12, 02 ) + ' ' +
                'LARG.: '  + FloatToStrF( fltLarPec, ffFixed, 12, StrToIntDef(fFormataCasaDecimalVIDRO(5),5)) + ' ' +
                UpperCase(fRetornaInfMedVIDRO(True,True,False,False,True))+ FloatToStrF( fltComPec, ffFixed, 12, StrToIntDef(fFormataCasaDecimalVIDRO(5),0)) + ' ' ;
    End;
  End;

end;

procedure TfrmQckHTMLDocumentos.pCarregaItensCortados(strNumDoc, strEspDoc, strCodEmp: String);
begin
  qryVendasPerdidas.Close;
  qryVendasPerdidas.SQL.Clear;
  qryVendasPerdidas.SQL.Add('SELECT ');
  qryVendasPerdidas.SQL.Add('  VPD_CODITE AS CODITE, ');
  qryVendasPerdidas.SQL.Add('  VPD_DESITE AS DESITE, ');
  qryVendasPerdidas.SQL.Add('  VPD_QTDITE AS QTDITE, ');
  qryVendasPerdidas.SQL.Add('  ITE_PREVE1 AS UNITAR, ');
  qryVendasPerdidas.SQL.Add('  VPD_QTDITE * ITE_PREVE1 AS TOTITE ');
  qryVendasPerdidas.SQL.Add('FROM ');
  qryVendasPerdidas.SQL.Add('  MOVVPD ');
  qryVendasPerdidas.SQL.Add('  JOIN MOVVPG ON VPG_CODIGO = VPD_CODIGO ');
  qryVendasPerdidas.SQL.Add('  JOIN ITEGER ON ITE_CODITE = VPD_CODITE AND ');
  qryVendasPerdidas.SQL.Add('                 ITE_CODEMP = VPG_CODEMP ');
  qryVendasPerdidas.SQL.Add('WHERE ');
  qryVendasPerdidas.SQL.Add('  VPG_NUMDOC = :NUMDOC AND ');
  qryVendasPerdidas.SQL.Add('  VPG_ESPDOC = :ESPDOC AND ');
  qryVendasPerdidas.SQL.Add('  VPG_CODEMP = :CODEMP ');

  qryVendasPerdidas.ParamByName('NUMDOC').AsString := strNumDoc;
  qryVendasPerdidas.ParamByName('ESPDOC').AsString := strEspDoc;
  qryVendasPerdidas.ParamByName('CODEMP').AsString := strCodEmp;
  qryVendasPerdidas.Open;
end;

end.
