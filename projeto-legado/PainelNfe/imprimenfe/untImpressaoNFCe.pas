unit untImpressaoNFCe;

interface

uses
{$IF Defined(LINUX)}
  Uni, System.IOUtils,
  FMX.frxClass, FMX.frxDBSet, FMX.frxDesgn, FMX.frxExportPDF,
  FMX.frxBarcode, FMX.frxDelphiZXingQRCode, FMX.Graphics,
  FMX.Objects, FMX.Forms,
{$ELSE}
  ShellAPI, DBCtrls, Windows, Messages, Dialogs,
  Graphics, Controls, Forms, frxClass, ComCtrls, StdCtrls, ExtCtrls,
  frxBarcode, frxDBSet, frxDelphiZXingQRCode, frxDesgn, frxExportPDF,
  {$IF Defined(UNIDAC)}
    UniClientDataSet, Uni, MySQLUniProvider, UniProvider,
  {$ELSE}
   ZConnection, ZDataset, ZDbcIntfs,
  {$IFEND}
{$IFEND}
  SysUtils, Variants, Classes,
  StrUtils, DB, MemDS, untConexaoBD, untUtil,
  ACBrUtil, untImagemBase64;

const
  arrConsumidor : Array[1..4] Of String = ('CONSUMIDOR', 'BALCAO', 'SEGURADORA', 'AUTO ATENDIMENTO');

type
  TImpressaoNFCe = class
  private
    ConexaoBD : TConexaoBD;
    frxDanfe: TfrxReport;
    frxDbDanfe: TfrxDBDataset;
    frxDesigner: TfrxDesigner;
    frxPDFExport: TfrxPDFExport;
    FModoTeste: String;
    FXmlTeste: String;
    FResultadoTeste: TStringList;
    FVariaveisTeste: TStringList;
    FDadosTeste: TStrings;
    FintNaoEsperadas: Integer;

    function fAmbienteHomologacao: Boolean;
    function fGanhouNetpoints(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie: String; var intQtdNps: Integer): Boolean;
    function fNumeroDoItem: String;
    function fArredondaUnit(strCampo: String): String;
    function frxDesignerSaveReport(Report: TfrxReport; SaveAs: Boolean): Boolean;
    function fVerificarItensEmPromocao(qryTmp: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}): Boolean;
    function frxDanfeUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    procedure pConfigurarLogotipoDanfce;
    function fEhSomenteUmaVia(blnPDF_Gerar, blnReimpressao: Boolean; intQtdVias: Integer; blnEscolheuNaoImprimirViaNfe: Boolean): Boolean;
    procedure pNfeInfAdicDocumentosCreditoUsados( strNumDoc, strEspDoc, strCodEmp, strCodCli: String; var strDocumentosCreditoUsados: string);
    procedure pNfeInfAdicSaldoCreditoDoCliente( strCodEmp, strCodCli: String; var strSaldoCreditoDoCliente: string);
    procedure pQuantidadeDeSelos(strNumDoc, strEspDoc, strCodEmp, strCodCli: String; var intQtdSelos: Integer);
    procedure pValorCashBack(strNumDoc, strEspDoc, strCodEmp, strCodCli: String; var fltCashBack : Double);
  public
    dtsConf: TDataSource;
    constructor Create();
    destructor Destroy; override;
    property ModoTeste: String read FModoTeste write FModoTeste;
    property XmlTeste: String read FXmlTeste write FXmlTeste;
    property ResultadoTeste: TStringList read FResultadoTeste;
    property VariaveisTeste: TStringList read FVariaveisTeste;
    property DadosTeste: TStrings read FDadosTeste write FDadosTeste;
    property NaoEsperadas: Integer read FintNaoEsperadas;
    procedure Imprimir(strCodigoEmpresa, strChaveAcesso, strImpressora: string; blnDesignReport: boolean=False; strModelo: String='NFCE';
                       blnPDF_Gerar: Boolean = False; strPDF_Diretorio: String = ''; blnPDF_Apresentar: Boolean = False; blnPDF_Banco: Boolean = False;
                       blnReimpressao: Boolean = False);
  end;

implementation

uses
{$IF Defined(LINUX)}
  NFe.Modulo, untModuloReplicacao;
{$ELSE}
 untModulo, {$IF Defined(UNIDAC)} untModuloReplicacao, Vcl.Printers {$ELSE} untModuloReplicacaoZeos {$IFEND},
 {$IF Defined(VER250) Or Defined(VER270) Or Defined(VER280) Or Defined(VER300)}System.UITypes,{$IFEND} untConfImpressora,
 untNfceDinamico, untNfsDinamico;
{$IFEND}

{ TImpressaoNFCe }

constructor TImpressaoNFCe.Create();
begin
  ConexaoBD := TConexaoBD.Create(frmModulo.Database);

  frxPDFExport := TfrxPDFExport.Create(nil);
  frxPDFExport.Background    := True;
  frxPDFExport.EmbeddedFonts := True;
  frxPDFExport.Subject       := 'Exportando DANFE para PDF';
  frxPDFExport.ShowProgress  := False;

  FModoTeste := '';
  FXmlTeste := '';
  FintNaoEsperadas := 0;
  FResultadoTeste := TStringList.Create;
  FVariaveisTeste := TStringList.Create;
end;

destructor TImpressaoNFCe.Destroy();
begin
  FreeAndNil(FResultadoTeste);
  FreeAndNil(FVariaveisTeste);
  ConexaoBD.Free();

  If Assigned(frxPDFExport) Then
    frxPDFExport.Free;
end;

function TImpressaoNFCe.fNumeroDoItem: String;
begin
  Result := IntToStr(frxDbDanfe.RecNo+1);
end;

function TImpressaoNFCe.fAmbienteHomologacao: Boolean;
  Var
    strUrl: String;
begin
  strUrl := AnsiLowerCase(ConexaoBD.CarregarCFGSIS('CITURL'));

            //SOVOS
  Result := (Pos('ws.hom',  strUrl) > 0)
         Or (Pos('hom.dfe', strUrl) > 0)

            //CITEL
         Or (Pos('nfe-hom', strUrl) > 0)
         Or (Pos('hom.cit', strUrl) > 0)

            //GERAL
         Or (Pos('homolog', strUrl) > 0)
end;

function TImpressaoNFCe.fArredondaUnit(strCampo: String): String;
begin
  Result := FloatToStr(fFormataFloat(frxDbDanfe.DataSet.FieldByName(strCampo).AsFloat, 2));
end;

function TImpressaoNFCe.fEhSomenteUmaVia(blnPDF_Gerar, blnReimpressao: Boolean; intQtdVias: Integer; blnEscolheuNaoImprimirViaNfe: Boolean): Boolean;
begin
  Result := False;

  If (blnPDF_Gerar) Or (blnReimpressao) Or (IIF(blnEscolheuNaoImprimirViaNfe, 1, intQtdVias) <= 0) Then
    Result := True;
end;

function TImpressaoNFCe.fGanhouNetpoints(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie: String; var intQtdNps: Integer): Boolean;
Var
  qryCadNps: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  intQtdNps := 0;

  qryCadNps := fCriaQuery(Nil);
  Try
    Try
      With qryCadNps Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT NPS_NPSCAL, NPS_QTDNPS ');
        SQL.Add('   FROM CADNPS ');
        SQL.Add('  WHERE NPS_NUMDOC = :NUMDOC ');
        SQL.Add('    AND NPS_ESPDOC = :ESPDOC ');
        SQL.Add('    AND NPS_CODEMP = :CODEMP ');
        SQL.Add('    AND NPS_CODCLI = :CODCLI ');
        SQL.Add('    AND NPS_SERIE_ = :SERIE_ ');
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODCLI').AsString := strCodCli;
        ParamByName('SERIE_').AsString := strSerie;
        Open;

        If (Not IsEmpty) Then
        Begin
          intQtdNps := FieldByName('NPS_QTDNPS').AsInteger;
          If (intQtdNps <= 0) Then
            intQtdNps := FieldByName('NPS_NPSCAL').AsInteger;
        End;

        Close;
      End;
    Except
      On E: Exception Do
      Begin
        intQtdNps := 0;
      End;
    End;
  Finally
    FreeAndNil(qryCadNps);
  End;

  Result := (intQtdNps > 0);
end;

procedure TImpressaoNFCe.pNfeInfAdicDocumentosCreditoUsados( strNumDoc, strEspDoc, strCodEmp, strCodCli: String; var strDocumentosCreditoUsados: string);
var
  qryDocumentosCredito: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  qrySenCon: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  strDocumentosCreditoUsados := EmptyStr;

  qryDocumentosCredito := fCriaQuery;
  qrySenCon := fCriaQuery;

  try

      qrySenCon.SQL.Clear;
      qrySenCon.SQL.Add('SELECT DISTINCT               ');
      qrySenCon.SQL.Add('  C1.CTR_SEQCON,              ');
      qrySenCon.SQL.Add('  C1.CTR_EMPBAI               ');
      qrySenCon.SQL.Add('FROM                          ');
      qrySenCon.SQL.Add('  CADREC C1                   ');
      qrySenCon.SQL.Add('WHERE C1.CTR_NUMDUP = :NUMDOC ');
      qrySenCon.SQL.Add('  AND C1.CTR_ESPDOC = :ESPDOC ');
      qrySenCon.SQL.Add('  AND C1.CTR_CODEMP = :CODEMP ');
      qrySenCon.SQL.Add('  AND C1.CTR_CODCLI = :CODCLI ');
      qrySenCon.SQL.Add('ORDER BY C1.CTR_DTABAI DESC;  ');

      qrySenCon.ParamByName('NUMDOC').asString := strNumDoc;
      qrySenCon.ParamByName('ESPDOC').asString := strEspDoc;
      qrySenCon.ParamByName('CODEMP').asString := strCodEmp;
      qrySenCon.ParamByName('CODCLI').asString := strCodCli;

      qrySenCon.Open;

      if not(qrySenCon.isEmpty) and not(qrySenCon.FieldByName('CTR_SEQCON').asString = '0') then
      begin

        qryDocumentosCredito.SQL.Clear;
        qryDocumentosCredito.SQL.Add('SELECT                     ');
        qryDocumentosCredito.SQL.Add('  CONCAT(                  ');
        qryDocumentosCredito.SQL.Add('    "DOCS DE CRED: ",      ');
        qryDocumentosCredito.SQL.Add('    GROUP_CONCAT(          ');
        qryDocumentosCredito.SQL.Add('      CTR_NUMDUP,          ');
        qryDocumentosCredito.SQL.Add('      "-",                 ');
        qryDocumentosCredito.SQL.Add('      CTR_ESPDOC,          ');
        qryDocumentosCredito.SQL.Add('      "-",                 ');
        qryDocumentosCredito.SQL.Add('      CTR_CODEMP,          ');
        qryDocumentosCredito.SQL.Add('      "-VLR R$ ",          ');
        qryDocumentosCredito.SQL.Add('      (CTR_VALORI * - 1)   ');
        qryDocumentosCredito.SQL.Add('    )                      ');
        qryDocumentosCredito.SQL.Add('  ) AS DOCSCRED            ');
        qryDocumentosCredito.SQL.Add('FROM                       ');
        qryDocumentosCredito.SQL.Add('  CADREC                   ');
        qryDocumentosCredito.SQL.Add('WHERE CTR_SEQCON = :SEQCON ');
        qryDocumentosCredito.SQL.Add('  AND CTR_EMPBAI = :EMPBAI ');
        qryDocumentosCredito.SQL.Add('  AND CTR_VALORI < 0;      ');
        qryDocumentosCredito.ParamByName('SEQCON').asString := qrySenCon.FieldByName('CTR_SEQCON').asString;
        qryDocumentosCredito.ParamByName('EMPBAI').asString := qrySenCon.FieldByName('CTR_EMPBAI').asString;
        qryDocumentosCredito.Open;

        strDocumentosCreditoUsados := qryDocumentosCredito.FieldByName('DOCSCRED').asString;

      end;

  finally
    FreeAndNil(qrySenCon);
    FreeAndNil(qryDocumentosCredito);
  end;

end;

procedure TImpressaoNFCe.pNfeInfAdicSaldoCreditoDoCliente( strCodEmp, strCodCli: String; var strSaldoCreditoDoCliente: string);
var
  qryUsaSldCred: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  strSaldoCreditoDoCliente := EmptyStr;

  qryUsaSldCred := fCriaQuery;

  try

    qryUsaSldCred.SQL.Clear;
    qryUsaSldCred.SQL.Add('SELECT                                ');
    qryUsaSldCred.SQL.Add('  CONCAT(                             ');
    qryUsaSldCred.SQL.Add('    "SALDO DE CREDITO EM ABERTO = ",  ');
    qryUsaSldCred.SQL.Add('    FORMAT(SUM(CTR_VALDUP) * - 1, 2)  ');
    qryUsaSldCred.SQL.Add('  ) AS SLDCRD                         ');
    qryUsaSldCred.SQL.Add('FROM                                  ');
    qryUsaSldCred.SQL.Add('  CADREC                              ');
    qryUsaSldCred.SQL.Add('WHERE CTR_VALDUP <> 0.00              ');
    qryUsaSldCred.SQL.Add('  AND CTR_VALDUP LIKE "-%"            ');
    qryUsaSldCred.SQL.Add('  AND CTR_CODCLI = :CODCLI            ');
    qryUsaSldCred.SQL.Add('  AND CTR_CODEMP = :CODEMP            ');
    qryUsaSldCred.ParamByName('CODCLI').asString := strCodCli;
    qryUsaSldCred.ParamByName('CODEMP').asString := strCodEmp;
    qryUsaSldCred.Open;

    strSaldoCreditoDoCliente := qryUsaSldCred.FieldByName('SLDCRD').asString;

  finally
    FreeAndNil(qryUsaSldCred);
  end;

end;

procedure TImpressaoNFCe.pQuantidadeDeSelos(strNumDoc, strEspDoc, strCodEmp, strCodCli: String; var intQtdSelos: Integer);
Var
  qrySelos: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  qryPDFaturado: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  intQtdSelos   := 0;

  If (Not ConexaoBD.fTabelaExiste('CPPGER')) Then
    Exit;

  qrySelos      := Nil;
  qryPDFaturado := Nil;
  Try
    qrySelos := fCriaQuery(Nil);

    qrySelos.Close;
    qrySelos.SQL.Text := 'SELECT TRUE FROM CPPGER LIMIT 1';
    qrySelos.Open;

    If (qrySelos.IsEmpty) Then
      Exit;

    qrySelos.Close;
    qrySelos.SQL.Clear;
    qrySelos.SQL.Add('SELECT                     ');
    qrySelos.SQL.Add('  COUNT(*) AS QTDSELOS     ');
    qrySelos.SQL.Add('FROM                       ');
    qrySelos.SQL.Add('  CPPGER                   ');
    qrySelos.SQL.Add('WHERE CPG_NUMDOC = :NUMDOC ');
    qrySelos.SQL.Add('  AND CPG_ESPDOC = :ESPDOC ');
    qrySelos.SQL.Add('  AND CPG_CODEMP = :CODEMP ');
    qrySelos.SQL.Add('  AND CPG_CODCLI = :CODCLI ');

    qrySelos.ParamByName('NUMDOC').AsString := strNumDoc;
    qrySelos.ParamByName('ESPDOC').AsString := strEspDoc;
    qrySelos.ParamByName('CODEMP').AsString := strCodEmp;
    qrySelos.ParamByName('CODCLI').AsString := strCodCli;

    qrySelos.Open;

    If (qrySelos.FieldByName('QTDSELOS').AsInteger > 0) Then
      intQtdSelos := qrySelos.FieldByName('QTDSELOS').AsInteger;

    qrySelos.Close;

    If (intQtdSelos = 0) Then
    Begin
      qryPDFaturado := fCriaQuery(Nil);

      qryPDFaturado.SQL.Clear;
      qryPDFaturado.SQL.Add(' SELECT DISTINCT                                 ');
      qryPDFaturado.SQL.Add('  DET_NUM_PD, DET_EMP_PD, DET_ESP_PD, DET_CODCLI ');
      qryPDFaturado.SQL.Add('FROM                                             ');
      qryPDFaturado.SQL.Add('  MOVDET                                         ');
      qryPDFaturado.SQL.Add('WHERE DET_NUMDOC = :NUMDOC                       ');
      qryPDFaturado.SQL.Add('  AND DET_ESPDOC = :ESPDOC                       ');
      qryPDFaturado.SQL.Add('  AND DET_CODEMP = :CODEMP                       ');
      qryPDFaturado.SQL.Add('  AND DET_CODCLI = :CODCLI                       ');

      qryPDFaturado.ParamByName('NUMDOC').AsString := strNumDoc;
      qryPDFaturado.ParamByName('ESPDOC').AsString := strEspDoc;
      qryPDFaturado.ParamByName('CODEMP').AsString := strCodEmp;
      qryPDFaturado.ParamByName('CODCLI').AsString := strCodCli;
      qryPDFaturado.Open;

      qryPDFaturado.First;
      While Not qryPDFaturado.Eof Do
      Begin
        If fEmptyStr(qryPDFaturado.FieldByName('DET_NUM_PD').AsString) Then
        Begin
          qryPDFaturado.Next;
          Continue;
        End;

        qrySelos.SQL.Clear;
        qrySelos.SQL.Add('SELECT                     ');
        qrySelos.SQL.Add('  COUNT(*) AS QTDSELOS     ');
        qrySelos.SQL.Add('FROM                       ');
        qrySelos.SQL.Add('  CPPGER                   ');
        qrySelos.SQL.Add('WHERE CPG_NUMDOC = :NUMDOC ');
        qrySelos.SQL.Add('  AND CPG_ESPDOC = :ESPDOC ');
        qrySelos.SQL.Add('  AND CPG_CODEMP = :CODEMP ');
        qrySelos.SQL.Add('  AND CPG_CODCLI = :CODCLI ');

        qrySelos.ParamByName('NUMDOC').AsString := qryPDFaturado.FieldByName('DET_NUM_PD').asString;
        qrySelos.ParamByName('ESPDOC').AsString := qryPDFaturado.FieldByName('DET_ESP_PD').asString;
        qrySelos.ParamByName('CODEMP').AsString := qryPDFaturado.FieldByName('DET_EMP_PD').asString;
        qrySelos.ParamByName('CODCLI').AsString := qryPDFaturado.FieldByName('DET_CODCLI').asString;
        qrySelos.Open;

        If (qrySelos.FieldByName('QTDSELOS').AsInteger > 0) Then
          intQtdSelos := intQtdSelos + qrySelos.FieldByName('QTDSELOS').AsInteger;

        qrySelos.Close;
        qryPDFaturado.Next;

      End;

      qryPDFaturado.Close;
    End;
  Finally
    If Assigned(qrySelos) Then
      FreeAndNil(qrySelos);

    If Assigned(qryPDFaturado) Then
     FreeAndNil(qryPDFaturado);
  End;
end;

procedure TImpressaoNFCe.pValorCashBack(strNumDoc, strEspDoc, strCodEmp, strCodCli: String; var fltCashBack : Double);
Var
  qryVenCsh: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  fltCashBack := 0;

  If (Not ConexaoBD.fTabelaExiste('VENCSH')) Then
    Exit;

  qryVenCsh := Nil;

  Try
    qryVenCsh := fCriaQuery(Nil);

    qryVenCsh.Close;
    qryVenCsh.SQL.Clear;

    qryVenCsh.SQL.Add('SELECT                      ');
    qryVenCsh.SQL.Add('  SUM(VCB_VLRCSH) AS VLRCSH ');
    qryVenCsh.SQL.Add('FROM                        ');
    qryVenCsh.SQL.Add('  VENCSH                    ');
    qryVenCsh.SQL.Add('WHERE VCB_NUMDOC = :NUMDOC  ');
    qryVenCsh.SQL.Add('  AND VCB_ESPDOC = :ESPDOC  ');
    qryVenCsh.SQL.Add('  AND VCB_CODEMP = :CODEMP  ');
    qryVenCsh.SQL.Add('  AND VCB_CODCLI = :CODCLI  ');

    qryVenCsh.ParamByName('NUMDOC').AsString := strNumDoc;
    qryVenCsh.ParamByName('ESPDOC').AsString := strEspDoc;
    qryVenCsh.ParamByName('CODEMP').AsString := strCodEmp;
    qryVenCsh.ParamByName('CODCLI').AsString := strCodCli;

    qryVenCsh.Open;

    If (qryVenCsh.FieldByName('VLRCSH').AsFloat > 0) Then
      fltCashBack := qryVenCsh.FieldByName('VLRCSH').AsFloat;

  Finally
    If Assigned(qryVenCsh) Then
      FreeAndNil(qryVenCsh);
  End;
end;

function TImpressaoNFCe.frxDesignerSaveReport(Report: TfrxReport;
  SaveAs: Boolean): Boolean;
var
  lstArquivo: TStringList;
  strFile: String;
begin
  strFile := ExtractFilePath(ParamStr(0)) + 'TempImprNFeFr3.fr3';
  lstArquivo := TStringList.Create;

  Try
    if FileExists(strFile) then
      DeleteFile(strFile);

    Report.SaveToFile(strFile);

    {$IF Defined(UNIDAC)}
    try
      lstArquivo.LoadFromFile(strFile, TEncoding.UTF8);
    except
      lstArquivo.LoadFromFile(UTF8Encode(strFile));
    end;
    {$ELSE}
    lstArquivo.LoadFromFile(UTF8Encode(strFile));
    {$IFEND}

    If Assigned(dtsConf) Then
    Begin
      dtsConf.DataSet.Edit;
      dtsConf.DataSet.FieldByName('NFE_LAYRET').Text := lstArquivo.Text;
      dtsConf.DataSet.Post;

      If SaveAs Then
        Report.SaveToFile('DANFCE.FR3');
    End;
  Finally
    Result := True;

    FreeAndNil(lstArquivo);

    If FileExists(strFile) then
      DeleteFile(strFile);
  End;
end;

function TImpressaoNFCe.fVerificarItensEmPromocao(qryTmp: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}): Boolean;
begin
  Result := False;

  if (ConexaoBD.CarregarCFGSIS('NFEPRO') = 'S') then
  begin
    qryTmp.First;

    while not qryTmp.Eof do
    begin
      if Copy(qryTmp.FieldByName('CODITE').AsString, 1, 1) = '*' then
      begin
        Result := True;
        Break;
      end;

      qryTmp.Next;
    end;

    qryTmp.First;
  end;
end;

procedure TImpressaoNFCe.Imprimir(strCodigoEmpresa, strChaveAcesso, strImpressora: string; blnDesignReport: boolean=False; strModelo: String='NFCE';
                                  blnPDF_Gerar: Boolean = False; strPDF_Diretorio: String = ''; blnPDF_Apresentar: Boolean = False; blnPDF_Banco: Boolean = False;
                                  blnReimpressao: Boolean = False);
  Const
    QrCodePeq = 100;
    QrCodeMed = 130;
    QrCodeGrd = 160;

    SQL_MOVCDB_CODBAR  = '(SELECT GROUP_CONCAT(DISTINCT CDB_CODBAR) AS CDB_CODBAR ' +
                         ' FROM   MOVCDB ' +
                         ' WHERE  CDB_SEQDET = MOVDET.AUTOINCREM ' +
                         ' GROUP BY CDB_SEQDET) ';
var
  blnCodBar: Boolean;
  strSQL,
  strSQLOriginal,
  strOrdIte: String;
  qryTmp: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strNomImp: String;
  strModalidades: String;
  strValores: String;
  strCarConPag: String;
  bmpQrCode: TBitmap;
  strEnderecoConsumidor: String;
  frxQrCode, frxQrCodeDadosAdicionais: TfrxPictureView;
 {$IF Defined(LINUX)}
  strPatImgQrCode: string;
 {$ELSE}
  stream: TMemoryStream;
 {$ENDIF}
  intTentativas: Integer;
  strImpostos: String;
  intQtdNps : Integer;
  strDirLogo : String;
  blnUsaSat: Boolean;
  blnSatComplementar: Boolean;
  strDesIteTemp: String;
  strEnderecoEntrega: String;
  strPRSGCL: String;
  strParcelasCartao: String;
  blnEscolheuNaoImprimirViaNfe: Boolean;
  strDocumentosCreditoUsados: string;
  strSaldoCreditoDoCliente: String;
  I: Integer;
  strIdePro: String;
  intQtdSelos: integer;
  strDescrCartao: String;
  fltCashBack: double;
  blnNfceDin: Boolean;
 {$IF not Defined(LINUX)}
  blnNfceCancelada: Boolean;
  strXmlNfceDin: String;
  entNfceDin: TNfceDinEntrada;
  objNfceDin: TNfceDinamico;
  dsNfceDin: TDataSet;
  lstFotoNova: TStringList;
  blnNfceDinImprimindo: Boolean;
 {$IFEND}

  function fCampo(const ANome: String): TField;
  begin
    Result := nil;
   {$IF not Defined(LINUX)}
    If blnNfceDin And Assigned(dsNfceDin) And dsNfceDin.Active And (Not dsNfceDin.IsEmpty) Then
      Result := dsNfceDin.FindField(ANome);
   {$IFEND}
    If Result = nil Then
      Result := qryTmp.FieldByName(ANome);
  end;

  procedure pSetVar(const ANome: String; const AValor: Variant);
  begin
    If Not blnNfceDin Then
      frxDanfe.Script.Variables[ANome] := AValor;
  end;

  function fImprimirEnderecoDeEntrega: Boolean;
  begin
    Result := (ConexaoBD.CarregarCFGSIS('ENTNFC')='S');
  end;

  function fImprimirEnderecoEntregaItensEntrega: Boolean;
  begin
    Result := ((fCampo('ENTRET').asString='E') Or (fCampo('ENTRET').asString='F'));
  end;

  function fImprimirEnderecoEntregaItensRetira: Boolean;
  begin
    Result := ((fCampo('ENTRET').asString='R') And (ConexaoBD.CarregarCFGSIS('ENDRET')='S'));
  end;

  function fContingencia(strAcesso: String): Boolean;
  begin
    Result := StrToIntDef(Copy(strAcesso, 35, 1), 0) In [4,6,7,9];
  end;

  function fConsumidorIdentificado: Boolean;
  begin
    Result := (Not fEmptyStr(fCampo('CGCCON').AsString)) And
              (Not fStringRepetida(fCampo('CGCCON').AsString)) And
              (fTestaCgc(fCampo('CGCCON').AsString) Or
               fValidaCPF(fCampo('CGCCON').AsString));
  end;

  function fRetornaMascaraQtd(AQtdCasasDecimais:Integer): string;
  begin
    case AQtdCasasDecimais of
      1: Result := '#,##0.0';
      2: Result := '#,##0.00';
      3: Result := '#,##0.000';
      4: Result := '#,##0.0000';
    end;
  end;

  function fVariavelExiste(AVariavel: String): Boolean;
  var
    LValor: Variant;
  begin
    Result := True;
    try
      LValor := frxDanfe.Script.Variables[AVariavel];
    except
      Result := False;
    end;
  end;

 {$IF not Defined(LINUX)}
  procedure pGravaLogNfceDin(const AMensagem, AErro: String);
  begin
    If FModoTeste <> '' Then
    Begin
      FResultadoTeste.Add(AMensagem);
      FResultadoTeste.Add(AErro);
      Exit;
    End;

    TNfsDinamico.pGravaLogDin('Erro NfeImpressao NFCe Dinamico', strChaveAcesso, AMensagem, AErro);
  end;

  function fUsaNfceDinamica: Boolean;
  begin
    Result := False;
    strXmlNfceDin := '';
    If blnDesignReport Or blnUsaSat Then
      Exit;
    If (FModoTeste = '') And (ConexaoBD.CarregarCFGSIS('EDTIMC') <> 'S') Then
      Exit;
    If fContingencia(strChaveAcesso) Then
      Exit;
    If Not TNfceDinamico.fDisponivel(cstProvedorCupomFiscal) Then
    Begin
      If FModoTeste = '' Then
        TNfsDinamico.pGravaLogDin('Aviso NfeImpressao NFCe Dinamico', strChaveAcesso,
          'CFG_EDTIMC = S, mas a rotina dinamica da NFC-e esta indisponivel (SCRIPT_PAINEL_003/004 ou provedor ' +
          cstProvedorCupomFiscal + ' sem dataset em IMPNFE_CDS): a impressao seguiu pela rotina antiga.', '', True);
      Exit;
    End;

    Try
      If Not fEmptyStr(FXmlTeste) Then
        strXmlNfceDin := FXmlTeste
      Else
        strXmlNfceDin := ConexaoBD.CarregarXML(strChaveAcesso);
    Except
      On E: Exception Do
      Begin
        pGravaLogNfceDin('XML da NFC-e nao encontrado (XMLNFE): a nota foi impressa pela rotina antiga.', E.Message);
        Exit;
      End;
    End;
    Result := Not fEmptyStr(strXmlNfceDin);
    If Not Result Then
      pGravaLogNfceDin('XML da NFC-e nao encontrado (XMLNFE): a nota foi impressa pela rotina antiga.',
        'XML vazio ou nulo na XMLNFE.');
  end;

  procedure pCriaNfceDin;
  begin
    If Not Assigned(entNfceDin) Then
      entNfceDin := TNfceDinEntrada.Create;
    If Not Assigned(objNfceDin) Then
      objNfceDin := TNfceDinamico.Create(entNfceDin);

    entNfceDin.strProvedor    := cstProvedorCupomFiscal;
    entNfceDin.strXml         := strXmlNfceDin;
    entNfceDin.strAcesso      := strChaveAcesso;
    entNfceDin.strCodEmp      := strCodigoEmpresa;
    entNfceDin.strNumDoc      := qryTmp.FieldByName('NUMDOC').AsString;
    entNfceDin.strEspDoc      := qryTmp.FieldByName('ESPDOC').AsString;
    entNfceDin.strSerie       := qryTmp.FieldByName('SERIE_').AsString;
    entNfceDin.dsDoc          := qryTmp;
    entNfceDin.frxReport      := frxDanfe;
    entNfceDin.blnReimpressao := blnReimpressao;
    If FModoTeste <> '' Then
      entNfceDin.lstErros := FResultadoTeste
    Else
      entNfceDin.lstErros := nil;

    objNfceDin.pCriarEstrutura(frxDanfe);
    pLogImp('Impressao dinamica da NFC-e ativa (provedor ' + cstProvedorCupomFiscal + ')');
  end;

  procedure pPreencheNfceDin;
  begin
    If Assigned(TfrxMemoView(frxDanfe.FindObject('memInfComp'))) then
      entNfceDin.strInfCplDoc := ConexaoBD.fGetInfComplementar(qryTmp, sLineBreak, EmptyStr, fVerificarItensEmPromocao(qryTmp), False, False)
    Else
      entNfceDin.strInfCplDoc := ConexaoBD.fGetInfComplementar(qryTmp, sLineBreak, EmptyStr, fVerificarItensEmPromocao(qryTmp));

    entNfceDin.strDtaVen := '';
    If Assigned(TfrxMemoView(frxDanfe.FindObject('memDtaVen'))) then
      entNfceDin.strDtaVen := ConexaoBD.fMontaDtaVenCarteira(qryTmp.FieldByName('NUMDOC').AsString,
                                                             qryTmp.FieldByName('ESPDOC').AsString,
                                                             qryTmp.FieldByName('CODEMP').AsString);

    entNfceDin.strModalidadesDoc := strModalidades;
    entNfceDin.strValoresDoc     := strValores;
    entNfceDin.strCarConPag      := strCarConPag;
    entNfceDin.strParcelasCartao := strParcelasCartao;
    entNfceDin.strDescrCartao    := strDescrCartao;
    entNfceDin.strIdePro         := strIdePro;
    entNfceDin.strDocsCred       := strDocumentosCreditoUsados;
    entNfceDin.strSldCred        := strSaldoCreditoDoCliente;
    entNfceDin.intQtdNps         := intQtdNps;
    entNfceDin.intQtdSelos       := intQtdSelos;
    entNfceDin.fltCashBack       := fltCashBack;

    objNfceDin.pPreencher;

    dsNfceDin := objNfceDin.fDataSet(cstCdsItensNFCe);
    If Assigned(dsNfceDin) And dsNfceDin.Active Then
      dsNfceDin.First;
  end;

  function fNfceDinamicaPreparou(out AErro: String): Boolean;
  var
    LModo: TfrxSilentMode;
  begin
    // RF13 - preparacao de validacao, silenciosa, antes de imprimir/exportar
    AErro := '';
    LModo := frxDanfe.EngineOptions.NewSilentMode;
    frxDanfe.EngineOptions.NewSilentMode := simReThrow;
    Try
      Try
        Result := frxDanfe.PrepareReport;
        If Not Result Then
          AErro := frxDanfe.Errors.Text;
      Except
        On E: Exception Do
        Begin
          Result := False;
          AErro := E.ClassName + ': ' + E.Message;
        End;
      End;
    Finally
      frxDanfe.EngineOptions.NewSilentMode := LModo;
    End;
  end;

  procedure pCopiaDadosNfceDin;
  var
    lstNomes: TStringList;
    k: Integer;
  begin
    lstNomes := TStringList.Create;
    try
      TNfsDinamico.pNomesCds(cstProvedorCupomFiscal, lstNomes);
      for k := 0 to lstNomes.Count - 1 do
        TNfsDinamico.pAddDadosTeste(lstNomes[k], objNfceDin.fDataSet(lstNomes[k]), FDadosTeste);
    finally
      FreeAndNil(lstNomes);
    end;
  end;

  procedure pDesligaNfceDin;
  begin
    FreeAndNil(frxDanfe);   // o relatorio referencia os datasets dinamicos
    FreeAndNil(frxDbDanfe);
    blnNfceDin := False;
    dsNfceDin := nil;
    FreeAndNil(objNfceDin);
    ConexaoBD.CarregarConfiguracao(strChaveAcesso, strCodigoEmpresa, 'NFCE', 4.00,
                                   qryTmp.FieldByName('HISTOR').AsString,
                                   qryTmp.FieldByName('CLAFIS').AsString);
  end;
 {$IFEND}

  procedure pDanfeNFCe(strPRSGCL: String = '');
  var
    i, intQtdVias: Integer;
    fltTopLocFis: Double;
    strTipCnd: String;
    LStreamDanfe: TStringStream;
   {$IF not Defined(LINUX)}
    strErroNfceDin: String;
    lstFotoAntiga: TStringList;
   {$IFEND}
  Begin
    Try
      If Not blnNfceDin Then
      Begin
        frxDbDanfe := TfrxDBDataset.Create(nil);
        frxDbDanfe.UserName := 'frxNFce';
        frxDbDanfe.DataSet := qryTmp;
      End;

      frxDanfe := TfrxReport.Create(nil);

     {$IF not Defined(LINUX)}
      If blnNfceDin Then
      Begin
        Try
          pCriaNfceDin;
          LStreamDanfe := fStringToStreamDanfe(ConexaoBD.FConfiguracao.LayoutRetrato);
          Try
            frxDanfe.LoadFromStream(LStreamDanfe);
          Finally
            LStreamDanfe.Free;
          End;
          pPreencheNfceDin;
        Except
          On E: Exception Do
          Begin
            pGravaLogNfceDin('Impressao dinamica da NFC-e (provedor ' + cstProvedorCupomFiscal +
              ') falhou; a nota foi impressa pela rotina antiga.', E.ClassName + ': ' + E.Message);
            pDesligaNfceDin;
            If FModoTeste = '' Then
              pDanfeNFCe(strPRSGCL);
            Exit;
          End;
        End;
      End
      Else
     {$IFEND}
      Begin
        LStreamDanfe := fStringToStreamDanfe(ConexaoBD.FConfiguracao.LayoutRetrato);
        frxDanfe.LoadFromStream(LStreamDanfe);
        LStreamDanfe.Free;
      End;

      pSetVar('PROFIS', ConexaoBD.CarregarCFGSIS('PROFIS') + ':');
      pSetVar('CODDIV', fCampo('CODDIV').AsString);
      pSetVar('NOMDIV', fCampo('NOMDIV').AsString);

      if TfrxChild(frxDanfe.FindObject('ChdContribuinte')).Visible then
      begin
        if blnDesignReport Or ( (ConexaoBD.CarregarCFGSIS('NFCADC') = 'S') and (not fEmptyStr(fCampo('CODDIV').AsString)) ) then
        begin
          TfrxChild(frxDanfe.FindObject('ChdContribuinte')).Height  := 83.15; //20.54;
          If Assigned(TfrxMemoView(frxDanfe.FindObject('rllProfissional'))) Then
            TfrxMemoView(frxDanfe.FindObject('rllProfissional')).Visible := True;
        end
        else
        begin
          frxDanfe.Script.Variables['PROFIS'] := '';
          frxDanfe.Script.Variables['CODDIV'] := '';
          frxDanfe.Script.Variables['NOMDIV'] := '';
          If Assigned(TfrxMemoView(frxDanfe.FindObject('rllProfissional'))) Then
          begin
            TfrxMemoView(frxDanfe.FindObject('rllProfissional')).Visible := False;
            TfrxMemoView(frxDanfe.FindObject('rllProfissional')).Top := 1.03;
          end;
          TfrxChild(frxDanfe.FindObject('ChdContribuinte')).Height := 56.70; //1.60;
        end;
      end
      else
      begin
        if blnDesignReport Or ( (ConexaoBD.CarregarCFGSIS('NFCADC') = 'S') and (not fEmptyStr(fCampo('CODDIV').AsString)) ) then
        begin
          TfrxChild(frxDanfe.FindObject('ChdContribuinte')).Visible := True;
          TfrxChild(frxDanfe.FindObject('ChdContribuinte')).Height  := 83.15; //20.54;
          If Assigned(TfrxMemoView(frxDanfe.FindObject('rllProfissional'))) Then
            TfrxMemoView(frxDanfe.FindObject('rllProfissional')).Visible := True;
        end;
      end;

      If Assigned(TfrxChild(frxDanfe.FindObject('ChdBarDoc'))) Then
      begin
        TfrxChild(frxDanfe.FindObject('ChdBarDoc')).Visible := True;
        TfrxBarCodeView(frxDanfe.FindObject('cbBarDoc')).Text := '1'+
                                                                 fCampo('NUMDOC').AsString+
                                                                 '02'+
                                                                 fCampo('CODEMP').AsString;
      end;

      pConfigurarLogotipoDanfce;

      If (ConexaoBD.CarregarCFGSIS('NFEMAR') = 'S') Or (ConexaoBD.CarregarCFGSIS('NFEFAB') = 'S') Then
      begin
        TfrxMasterData(frxDanfe.FindObject('MasterData1')).Visible := False;
        TfrxMasterData(frxDanfe.FindObject('MasterData2')).Visible := True;

        If (ConexaoBD.CarregarCFGSIS('NFEFAB')='S') And (Not (ConexaoBD.CarregarCFGSIS('NFEMAR')='S')) Then
          If Assigned(TfrxMemoView(frxDanfe.FindObject('MemoCodFab'))) Then
            TfrxMemoView(frxDanfe.FindObject('MemoCodFab')).Left := 5.3;

        If ConexaoBD.CarregarCFGSIS('NFEMAR')='S' Then
          TfrxMemoView(frxDanfe.FindObject('MemoMarca')).Visible := True
        Else
          TfrxMemoView(frxDanfe.FindObject('MemoMarca')).Visible := False;

        If ConexaoBD.CarregarCFGSIS('NFEFAB')='S' Then
        begin
          If Assigned(TfrxMemoView(frxDanfe.FindObject('MemoCodFabrica'))) Then
            TfrxMemoView(frxDanfe.FindObject('MemoCodFabrica')).Visible := True
          else
            TfrxMemoView(frxDanfe.FindObject('MemoCodFab')).Visible := True;
        end
        Else
        begin
          If Assigned(TfrxMemoView(frxDanfe.FindObject('MemoCodFabrica'))) Then
            TfrxMemoView(frxDanfe.FindObject('MemoCodFabrica')).Visible := False
          else
            TfrxMemoView(frxDanfe.FindObject('MemoCodFab')).Visible := False;
        end;

        If Assigned(TfrxMemoView(frxDanfe.FindObject('memLocFis2'))) Then
        Begin
          if (ConexaoBD.CarregarCFGSIS('NFCLOC') = 'N') then
          begin
            If ConexaoBD.CarregarCFGSIS('NFEMAR')='S' Then
              fltTopLocFis := TfrxMemoView(frxDanfe.FindObject('memLocFis2')).Top
            Else
              fltTopLocFis := TfrxMemoView(frxDanfe.FindObject('memLocFis2')).Top - TfrxMemoView(frxDanfe.FindObject('MemoMarca')).Height;
            TfrxMemoView(frxDanfe.FindObject('memLocFis2')).Visible := False;
            TfrxMemoView(frxDanfe.FindObject('memQtdIte2')).Top := fltTopLocFis;
            TfrxMemoView(frxDanfe.FindObject('memUnidad2')).Top := fltTopLocFis;
            TfrxMemoView(frxDanfe.FindObject('memUnitar2')).Top := fltTopLocFis;
            TfrxMemoView(frxDanfe.FindObject('memTotIte2')).Top := fltTopLocFis;

            if Assigned(TfrxMemoView(frxDanfe.FindObject('memQtdEmb2'))) then
              TfrxMemoView(frxDanfe.FindObject('memQtdEmb2')).Top := fltTopLocFis;
          end;
        End;

        If Assigned(TfrxMemoView(frxDanfe.FindObject('memDesEspVal2'))) Then
        begin
          if ( ConexaoBD.CarregarCFGSIS('NFDESC')='S')  And ( fCampo('DESESP').AsFloat > 0 ) then
          begin
            if not (ConexaoBD.CarregarCFGSIS('NFCLOC')='S') then
              TfrxMemoView(frxDanfe.FindObject('memDesEspVal2')).Top := 40
            else
              TfrxMemoView(frxDanfe.FindObject('memDesEspVal2')).Top := 55;
            TfrxMemoView(frxDanfe.FindObject('memDesEspVal2')).Visible := True;
          end
          else
          begin
            TfrxMemoView(frxDanfe.FindObject('memDesEspVal2')).Top := TfrxMemoView(frxDanfe.FindObject('memTotIte2')).Top;
            TfrxMemoView(frxDanfe.FindObject('memDesEspVal2')).Visible := False;
          end;
        end;

      end
      Else
      begin
        TfrxMasterData(frxDanfe.FindObject('MasterData2')).Visible := False;
        TfrxMasterData(frxDanfe.FindObject('MasterData1')).Visible := True;

        If Assigned(TfrxMemoView(frxDanfe.FindObject('memLocFis1'))) Then
        Begin
          if (ConexaoBD.CarregarCFGSIS('NFCLOC') = 'N') then
          begin
            fltTopLocFis := TfrxMemoView(frxDanfe.FindObject('memLocFis1')).Top;
            TfrxMemoView(frxDanfe.FindObject('memLocFis1')).Visible := False;
            TfrxMemoView(frxDanfe.FindObject('memQtdIte1')).Top := fltTopLocFis;
            TfrxMemoView(frxDanfe.FindObject('memUnidad1')).Top := fltTopLocFis;
            TfrxMemoView(frxDanfe.FindObject('memUnitar1')).Top := fltTopLocFis;
            TfrxMemoView(frxDanfe.FindObject('memTotIte1')).Top := fltTopLocFis;

            if Assigned(TfrxMemoView(frxDanfe.FindObject('memQtdEmb1'))) then
              TfrxMemoView(frxDanfe.FindObject('memQtdEmb1')).Top := fltTopLocFis;
          end;
        End;

        If Assigned(TfrxMemoView(frxDanfe.FindObject('memDesEspVal1'))) Then
        begin
          if ( ConexaoBD.CarregarCFGSIS('NFDESC')='S')  And ( fCampo('DESESP').AsFloat > 0 ) then
          begin
            if not (ConexaoBD.CarregarCFGSIS('NFCLOC')='S') then
              TfrxMemoView(frxDanfe.FindObject('memDesEspVal1')).Top := 25
            else
              TfrxMemoView(frxDanfe.FindObject('memDesEspVal1')).Top := 40;
            TfrxMemoView(frxDanfe.FindObject('memDesEspVal1')).Visible := True;
          end
          else
          begin
            TfrxMemoView(frxDanfe.FindObject('memDesEspVal1')).Top := TfrxMemoView(frxDanfe.FindObject('memTotIte1')).Top;
            TfrxMemoView(frxDanfe.FindObject('memDesEspVal1')).Visible := False;
          end;
        end;
      end;

      If Assigned(TfrxMemoView(frxDanfe.FindObject('memSubTtal'))) then
      Begin
        TfrxMemoView(frxDanfe.FindObject('memSubTtal')).DataField := '';

        If Assigned(TfrxMemoView(frxDanfe.FindObject('memDscTtal'))) then
          TfrxMemoView(frxDanfe.FindObject('memDscTtal')).DataField := '';

        If Assigned(TfrxMemoView(frxDanfe.FindObject('memVlrUnit1'))) then
          TfrxMemoView(frxDanfe.FindObject('memVlrUnit1')).DataField := '';
        If Assigned(TfrxMemoView(frxDanfe.FindObject('memVlrUnit2'))) then
          TfrxMemoView(frxDanfe.FindObject('memVlrUnit2')).DataField := '';

        If Assigned(TfrxMemoView(frxDanfe.FindObject('memTtalIte1'))) then
          TfrxMemoView(frxDanfe.FindObject('memTtalIte1')).DataField := '';
        If Assigned(TfrxMemoView(frxDanfe.FindObject('memTtalIte2'))) then
          TfrxMemoView(frxDanfe.FindObject('memTtalIte2')).DataField := '';

        If (fFormataFloat(fCampo('UNIDIG').AsFloat, strtointdef(fCfgSis('DECUNI'), 4)) > fFormataFloat(fCampo('UNITAR').AsFloat, strtointdef(fCfgSis('DECUNI'), 4)))
        and (fFormataFloat(fCampo('UNIDIG').AsFloat, strtointdef(fCfgSis('DECUNI'), 4)) > fFormataFloat(fCampo('UNIORI').AsFloat, strtointdef(fCfgSis('DECUNI'), 4))) then
        Begin
          If Assigned(TfrxMemoView(frxDanfe.FindObject('memVlrUnit1'))) then
            TfrxMemoView(frxDanfe.FindObject('memVlrUnit1')).Text := '[frxNFce."UNIDIG"]';
          If Assigned(TfrxMemoView(frxDanfe.FindObject('memVlrUnit2'))) then
            TfrxMemoView(frxDanfe.FindObject('memVlrUnit2')).Text := '[frxNFce."UNIDIG"]';

          If Assigned(TfrxMemoView(frxDanfe.FindObject('memTtalIte1'))) then
            TfrxMemoView(frxDanfe.FindObject('memTtalIte1')).Text := '[<frxNFce."UNIDIG"> * <frxNFce."QTDITE">]';
          If Assigned(TfrxMemoView(frxDanfe.FindObject('memTtalIte2'))) then
            TfrxMemoView(frxDanfe.FindObject('memTtalIte2')).Text := '[<frxNFce."UNIDIG"> * <frxNFce."QTDITE">]';

          TfrxMemoView(frxDanfe.FindObject('memSubTtal')).Text := '[SUM(<frxNFce."QTDITE"> * <frxNFce."UNIDIG">, MasterData1,2)]';

          If Assigned(TfrxMemoView(frxDanfe.FindObject('memDscTtal'))) then
            TfrxMemoView(frxDanfe.FindObject('memDscTtal')).Text := '[SUM(((<frxNFce."UNIDIG"> - <frxNFce."UNITAR">) * <frxNFce."QTDITE">),MasterData1,2) + <frxNFce."DESESP">]';
        End

        Else If fFormataFloat(fCampo('UNIORI').AsFloat, strtointdef(fCfgSis('DECUNI'), 4)) >= fFormataFloat(fCampo('UNITAR').AsFloat, strtointdef(fCfgSis('DECUNI'), 4)) then
        Begin
          If Assigned(TfrxMemoView(frxDanfe.FindObject('memVlrUnit1'))) then
            TfrxMemoView(frxDanfe.FindObject('memVlrUnit1')).Text := '[frxNFce."UNIORI"]';
          If Assigned(TfrxMemoView(frxDanfe.FindObject('memVlrUnit2'))) then
            TfrxMemoView(frxDanfe.FindObject('memVlrUnit2')).Text := '[frxNFce."UNIORI"]';

          If Assigned(TfrxMemoView(frxDanfe.FindObject('memTtalIte1'))) then
            TfrxMemoView(frxDanfe.FindObject('memTtalIte1')).Text := '[<frxNFce."UNIORI"> * <frxNFce."QTDITE">]';
          If Assigned(TfrxMemoView(frxDanfe.FindObject('memTtalIte2'))) then
            TfrxMemoView(frxDanfe.FindObject('memTtalIte2')).Text := '[<frxNFce."UNIORI"> * <frxNFce."QTDITE">]';

          TfrxMemoView(frxDanfe.FindObject('memSubTtal')).Text := '[SUM(<frxNFce."QTDITE"> * <frxNFce."UNIORI">, MasterData1,2)]';

          If Assigned(TfrxMemoView(frxDanfe.FindObject('memDscTtal'))) then
            TfrxMemoView(frxDanfe.FindObject('memDscTtal')).Text := '[SUM(((<frxNFce."UNIORI"> - <frxNFce."UNITAR">) * <frxNFce."QTDITE">),MasterData1,2) + <frxNFce."DESESP">]';
        End

        Else
        Begin
          If Assigned(TfrxMemoView(frxDanfe.FindObject('memVlrUnit1'))) then
            TfrxMemoView(frxDanfe.FindObject('memVlrUnit1')).Text := '[frxNFce."UNITAR"]';
          If Assigned(TfrxMemoView(frxDanfe.FindObject('memVlrUnit2'))) then
            TfrxMemoView(frxDanfe.FindObject('memVlrUnit2')).Text := '[frxNFce."UNITAR"]';

          If Assigned(TfrxMemoView(frxDanfe.FindObject('memTtalIte1'))) then
            TfrxMemoView(frxDanfe.FindObject('memTtalIte1')).Text := '[<frxNFce."UNITAR"> * <frxNFce."QTDITE">]';
          If Assigned(TfrxMemoView(frxDanfe.FindObject('memTtalIte2'))) then
            TfrxMemoView(frxDanfe.FindObject('memTtalIte2')).Text := '[<frxNFce."UNITAR"> * <frxNFce."QTDITE">]';

          TfrxMemoView(frxDanfe.FindObject('memSubTtal')).Text := '[SUM(<frxNFce."QTDITE"> * <frxNFce."UNITAR">, MasterData1,2)]';

          If Assigned(TfrxMemoView(frxDanfe.FindObject('memDscTtal'))) then
            TfrxMemoView(frxDanfe.FindObject('memDscTtal')).Text := '[SUM(((<frxNFce."UNITAR"> - <frxNFce."UNIORI">) * <frxNFce."QTDITE">),MasterData1,2) + <frxNFce."DESESP">]';
        End;
      End;

      If Assigned(TfrxMemoView(frxDanfe.FindObject('Memo41'))) then
      Begin
        strTipCnd := fCampo('TIPCND').AsString;

        if strTipCnd = ('V') then
        Begin
          TfrxMemoView(frxDanfe.FindObject('Memo41')).Text := 'TOTAL PAGO R$:'
        End
        Else
        Begin
          TfrxMemoView(frxDanfe.FindObject('Memo41')).Text := 'TOTAL A PAGAR R$:'
        End;
      End;


      if ConexaoBD.CarregarCFGSIS('DESNFC') = '2' then
      Begin

        if TfrxMasterData(frxDanfe.FindObject('MasterData1')).Visible then
        begin
          If Assigned(TfrxMemoView(frxDanfe.FindObject('memUnitar1'))) then
          begin
            TfrxMemoView(frxDanfe.FindObject('memUnitar1')).Datafield := '';
            TfrxMemoView(frxDanfe.FindObject('memUnitar1')).Text := '[<frxNFce."UNIORI">]';
          end;

          If Assigned(TfrxMemoView(frxDanfe.FindObject('memTotIte1'))) then
          begin
            TfrxMemoView(frxDanfe.FindObject('memTotIte1')).Datafield := '';
            TfrxMemoView(frxDanfe.FindObject('memTotIte1')).Text := '[<frxNFce."UNIORI"> * <frxNFce."QTDITE">]';
          end;

          if Assigned(TfrxMemoView(frxDanfe.FindObject('memo28'))) then
          begin
            TfrxMemoView(frxDanfe.FindObject('memo28')).Datafield := '';
            TfrxMemoView(frxDanfe.FindObject('memo28')).Text := '[SUM(<frxNFce."QTDITE">*<frxNFce."UNIORI">,MasterData1,2)]';
          end;
          if Assigned(TfrxMemoView(frxDanfe.FindObject('memo30'))) then
          begin
            TfrxMemoView(frxDanfe.FindObject('memo30')).Datafield := '';
            TfrxMemoView(frxDanfe.FindObject('memo30')).Text := '[SUM( ((<frxNFce."UNIORI">-<frxNFce."UNITAR">)*<frxNFce."QTDITE">),MasterData1,2 ) + <frxNFce."DESESP">]';
          end;

        end;

        if TfrxMasterData(frxDanfe.FindObject('MasterData2')).Visible then
        begin
          If Assigned(TfrxMemoView(frxDanfe.FindObject('memUnitar2'))) then
          begin
            TfrxMemoView(frxDanfe.FindObject('memUnitar2')).Datafield := '';
            TfrxMemoView(frxDanfe.FindObject('memUnitar2')).Text := '[<frxNFce."UNIORI">]';
          end;

          If Assigned(TfrxMemoView(frxDanfe.FindObject('memTotIte2'))) then
          begin
            TfrxMemoView(frxDanfe.FindObject('memTotIte2')).Datafield := '';
            TfrxMemoView(frxDanfe.FindObject('memTotIte2')).Text := '[<frxNFce."UNIORI"> * <frxNFce."QTDITE">]';
          end;

          If Assigned(TfrxMemoView(frxDanfe.FindObject('memo28'))) then
          begin
            TfrxMemoView(frxDanfe.FindObject('memo28')).Datafield := '';
            TfrxMemoView(frxDanfe.FindObject('memo28')).Text := '[SUM(<frxNFce."QTDITE">*<frxNFce."UNIORI">,MasterData2,2)]';
          end;

          If Assigned(TfrxMemoView(frxDanfe.FindObject('memo30'))) then
          begin
            TfrxMemoView(frxDanfe.FindObject('memo30')).Datafield := '';
            TfrxMemoView(frxDanfe.FindObject('memo30')).Text := '[SUM( ((<frxNFce."UNIORI">-<frxNFce."UNITAR">)*<frxNFce."QTDITE">),MasterData2,2 ) + <frxNFce."DESESP">]';
          end;
        end;
      End;

      pSetVar('NOMEMP', fCampo('NOMEMP').AsString);
      pSetVar('NMEFAN', fCampo('NMEFAN').AsString);
      pSetVar('CNPJ', fFormataCpfCgc(fCampo('C_G_C_').AsString));
      pSetVar('IE', fCampo('I_E_S_').AsString);

      if fVariavelExiste('IM') then
        pSetVar('IM', fCampo('INSMUN').AsString);

      pSetVar('ENDEMP', fCampo('ENDEMP').AsString);
      pSetVar('CEPEMP', fFormataCEP(AnsiReplaceStr(fCampo('CEPEMP').AsString, '-', '')));
      pSetVar('TELEMP', fFormataFone(fCampo('TELEMP').AsString));
      pSetVar('TELEM2', fFormataFone(fCampo('TELEM2').AsString));
      pSetVar('NUMDOC', fCampo('NUMDOC').AsString);
      pSetVar('SERIE_', fCampo('SERIE_').AsString);
      pSetVar('DTAEMI', FormatDateTime('dd/mm/yyyy', fCampo('DTAENT').AsDateTime) + ' ' + FormatDateTime('hh:mm:ss', fCampo('HORENT').AsDateTime));
      pSetVar('ACESSO', fTransform(fCampo('ACESSO').AsString, 4, ' '));
      pSetVar('PROTOC', fCampo('PROTOC').AsString);
      pSetVar('DPROTO', FormatDateTime('dd/mm/yyyy hh:nn:ss', fCampo('DPROTO').AsDateTime));
      pSetVar('NOMVEN', fCampo('NOMVEN').AsString);

      If Not blnNfceDin Then
      Begin
        If Assigned(TfrxMemoView(frxDanfe.FindObject('memInfComp'))) then
          frxDanfe.Script.Variables['INF_COMPLEMENTAR'] := ConexaoBD.fGetInfComplementar(qryTmp, sLineBreak, EmptyStr, fVerificarItensEmPromocao(qryTmp), False, False)
        Else
          frxDanfe.Script.Variables['INF_COMPLEMENTAR'] := ConexaoBD.fGetInfComplementar(qryTmp, sLineBreak, EmptyStr, fVerificarItensEmPromocao(qryTmp));
      End;

      If (fStatusCndPag(fCampo('CONPAG').AsString) = A_VISTA) Then
        pSetVar('CONDICAO_PAGAMENTO', 'A VISTA')
      Else
        pSetVar('CONDICAO_PAGAMENTO', fFormataCondPag(fCampo('CONPAG').AsString));

      pSetVar('MODALIDADES', strModalidades);
      pSetVar('VALORES_MOD', strValores);
      pSetVar('HOMEPA', fCampo('HOMEPA').AsString);

      If Assigned(TfrxMemoView(frxDanfe.FindObject('memDtaVen'))) And (Not blnNfceDin) then
      Begin
        frxDanfe.Script.Variables['DTAVEN'] := ConexaoBD.fMontaDtaVenCarteira(fCampo('NUMDOC').AsString,
                                                                              fCampo('ESPDOC').AsString,
                                                                              fCampo('CODEMP').AsString);
      End;

      If Assigned(TfrxMemoView(frxDanfe.FindObject('memParcelasCartao'))) then
        pSetVar('PARCELAS_CARTAO', strParcelasCartao);

      If Assigned(TfrxChild(frxDanfe.FindObject('chdInfCartao'))) Then
      Begin
        If Assigned(TfrxMemoView(frxDanfe.FindObject('memInfCartao'))) Then
        Begin
          If Not fEmptyStr(strCarConPag) then
            TfrxMemoView(frxDanfe.FindObject('memInfCartao')).Memo.Add(strCarConPag)
          Else
            TfrxChild(frxDanfe.FindObject('chdInfCartao')).Visible := False;
        End;
      End;

      If Assigned(TfrxBarCodeView(frxDanfe.FindObject('bcProtocolo'))) then
      begin
        TfrxBarCodeView(frxDanfe.FindObject('bcProtocolo')).Text := fCampo('ACESSO').AsString;
      end;

      strImpostos := '';
      If StrToIntDef(ConexaoBD.CarregarCFGSIS('IMPPAG'),0) = 1 Then
      Begin
        pSetVar('TOTAL_TRIBUTOS', FloatToStrF(fCampo('IMPPAG').AsFloat, ffNumber, 12, 2));
      End
      Else
      Begin
        If fCampo('FEDIMP').AsFloat + fCampo('ESTIMP').AsFloat + fCampo('MUNIMP').AsFloat = 0 Then
        Begin
          pSetVar('TOTAL_TRIBUTOS', '0,00');
        End
        Else
        Begin
          If fCampo('FEDIMP').AsFloat <> 0 Then
            strImpostos := strImpostos + FloatToStrF(fCampo('FEDIMP').AsFloat, ffNumber, 12, 2) + ' Fed';

          If fCampo('ESTIMP').AsFloat <> 0 Then
            strImpostos := strImpostos + '/' + FloatToStrF(fCampo('ESTIMP').AsFloat, ffNumber, 12, 2) + ' Est';

          If fCampo('MUNIMP').AsFloat <> 0 Then
            strImpostos := strImpostos + '/' + FloatToStrF(fCampo('MUNIMP').AsFloat, ffNumber, 12, 2) + ' Mun';

          pSetVar('TOTAL_TRIBUTOS', strImpostos + '/ Fonte:IBPT.');
        End;
      End;

      If Assigned(TfrxMemoView(frxDanfe.FindObject('mmLblTotalPago'))) Then
      begin
        If (fStatusCndPag(fCampo('CONPAG').AsString) = A_PRAZO) Then
        begin
          TfrxMemoView(frxDanfe.FindObject('mmLblTotalPago')).Text := 'FATURADO:';
        end;
      end;

      pSetVar('TROCO_', FloatToStrF(fCampo('TROCO_').AsFloat, ffNumber, 12, 2));

      If (not blnDesignReport) And (fCampo('TROCO_').AsFloat = 0) Then
      Begin
        If Assigned(TfrxMemoView(frxDanfe.FindObject('rllTroco'))) then
          TfrxMemoView(frxDanfe.FindObject('rllTroco')).Visible := False;
        If Assigned(TfrxMemoView(frxDanfe.FindObject('rllValTroco'))) then
          TfrxMemoView(frxDanfe.FindObject('rllValTroco')).Visible := False;

        TfrxChild(frxDanfe.FindObject('Child3')).Height := 0.4;
      End;

      TfrxChild(frxDanfe.FindObject('ChildTotFre')).Visible := (fCampo('TOTFRE').AsFloat > 0);
      TfrxChild(frxDanfe.FindObject('ChildDesAce')).Visible := (fCampo('DESACE').AsFloat > 0);
      TfrxChild(frxDanfe.FindObject('ChildTotRet')).Visible := (fCampo('TOTRET').AsFloat > 0);
      TfrxChild(frxDanfe.FindObject('ChildTotIpi')).Visible := (fCampo('TOTIPI').AsFloat > 0);

      TfrxChild(frxDanfe.FindObject('Child9')).Visible := fAmbienteHomologacao;

      pSetVar('QTDNPS', IntToStr(intQtdNps));
      TfrxChild(frxDanfe.FindObject('ChdNetpoints')).Visible := (intQtdNps > 0);

      if Assigned(TfrxChild(frxDanfe.FindObject('ChdSelos'))) Then
      begin
        pSetVar('QTDSELOS', IntToStr(intQtdSelos));
        TfrxChild(frxDanfe.FindObject('ChdSelos')).Visible := (intQtdSelos > 0);
      end;

      if Assigned(TfrxChild(frxDanfe.FindObject('ChildCashBack'))) Then
      begin
        pSetVar('VENCSH', FloatToStrF(fltCashBack, ffNumber, 12, 2));
        TfrxChild(frxDanfe.FindObject('ChildCashBack')).Visible := (fltCashBack > 0);
      end;

      if Assigned(TfrxChild(frxDanfe.FindObject('ChildFidelidade'))) Then
      begin
        pSetVar('PTOVEN', fCampo('PTOVEN').AsFloat);
        pSetVar('PTOSLD', fCampo('PTOSLD').AsFloat);
        TfrxChild(frxDanfe.FindObject('ChildFidelidade')).Visible := (fCampo('PTOVEN').AsFloat > 0) or
                                                                     (fCampo('PTOSLD').AsFloat > 0);
      end;

      if Assigned(TfrxMemoView(frxDanfe.FindObject('rllSaldos'))) Then
      begin
        pSetVar('DOCSCRED', strDocumentosCreditoUsados);
        pSetVar('SLDCRED', strSaldoCreditoDoCliente);
      end;

      If Assigned(TfrxMemoView(frxDanfe.FindObject('rllCliCon'))) Then
        TfrxMemoView(frxDanfe.FindObject('rllCliCon')).Memo.Clear;
      If Assigned(TfrxMemoView(frxDanfe.FindObject('rllConsumidor'))) Then
        TfrxMemoView(frxDanfe.FindObject('rllConsumidor')).Memo.Clear;

      If fConsumidorIdentificado Then
      Begin
        if (fCampo('NOTPAU').AsString = 'S') And
           (fCfgSis('ECPFNF') = 'S') then
        begin
          TfrxMemoView(frxDanfe.FindObject('rllConsumidor')).Memo.Add(iif(fTestaCgc(fCampo('CGCCON').AsString), 'CNPJ: ', 'CPF: ') +
                                                                     fFormataCpfCgc(fCampo('CGCCON').AsString));
        end;
        If Not fEmptyStr(fCampo('NOMCON').AsString) Then
        Begin
          TfrxMemoView(frxDanfe.FindObject('rllConsumidor')).Memo.Add(fCampo('NOMCON').AsString +
            IIF((Not blnNfceDin) And (ConexaoBD.CarregarCFGSIS('CCLNFE')='S'), ' ' + fCampo('CODCLI').AsString, ''));
          If Not fEmptyStr(fCampo('ENDERE').AsString) Then
          Begin
            strEnderecoConsumidor := fCampo('ENDERE').AsString +
              iif(fEmptyStr(fCampo('ENDNUM').AsString), '', ', ' + fCampo('ENDNUM').AsString) +
              iif(fEmptyStr(fCampo('ENDCOM').AsString), '', ', ' + fCampo('ENDCOM').AsString) +
              iif(fEmptyStr(fCampo('BAICON').AsString), '', ', ' + fCampo('BAICON').AsString) +
              iif(fEmptyStr(fCampo('CIDCON').AsString), '', ', ' + fCampo('CIDCON').AsString) +
              iif(fEmptyStr(fCampo('ESTCON').AsString), '', ', ' + fCampo('ESTCON').AsString);
            TfrxMemoView(frxDanfe.FindObject('rllConsumidor')).Memo.Add(strEnderecoConsumidor);
          End;

          If Not fEmptyStr(fCampo('TELCON').AsString) Then
            TfrxMemoView(frxDanfe.FindObject('rllConsumidor')).Memo.Add('TELEFONE: ' + fFormataFone(fCampo('TELCON').AsString));

          If Not fEmptyStr(fCampo('CELCON').AsString) Then
            TfrxMemoView(frxDanfe.FindObject('rllConsumidor')).Memo.Add('CELULAR: ' + fFormataFone(fCampo('CELCON').AsString));

          If (fImprimirEnderecoDeEntrega) And
             (fImprimirEnderecoEntregaItensRetira Or fImprimirEnderecoEntregaItensEntrega) Then
          Begin
            If Not fEmptyStr(fCampo('ENDENT').AsString) Then
            begin
              strEnderecoEntrega := 'END.P/ENTREGA: ' + fCampo('ENDENT').AsString +
                iif(fEmptyStr(fCampo('BAIENT').AsString), '', ', ' + fCampo('BAIENT').AsString) +
                iif(fEmptyStr(fCampo('CEPENT').AsString), '', ', ' + fCampo('CEPENT').AsString) +
                iif(fEmptyStr(fCampo('CIDENT').AsString), '', ', ' + fCampo('CIDENT').AsString);
              TfrxMemoView(frxDanfe.FindObject('rllConsumidor')).Memo.Add(strEnderecoEntrega);
            end;
            If Not fEmptyStr(fCampo('TELENT').AsString) Then
              TfrxMemoView(frxDanfe.FindObject('rllConsumidor')).Memo.Add('TELEFONE: ' + fFormataFone(fCampo('TELENT').AsString));
          End;
        End;
      End
      Else
      Begin
        If Assigned(TfrxMemoView(frxDanfe.FindObject('rllCliCon'))) Then
        Begin
          If Not fEmptyStr(fCampo('NOMCON').AsString) Then
          Begin
            TfrxMemoView(frxDanfe.FindObject('rllCliCon')).Memo.Add(fCampo('NOMCON').AsString);

            If Not fEmptyStr(fCampo('ENDERE').AsString) Then
            Begin
              strEnderecoConsumidor := fCampo('ENDERE').AsString +
                iif(fEmptyStr(fCampo('ENDNUM').AsString), '', ', ' + fCampo('ENDNUM').AsString) +
                iif(fEmptyStr(fCampo('ENDCOM').AsString), '', ', ' + fCampo('ENDCOM').AsString) +
                iif(fEmptyStr(fCampo('BAICON').AsString), '', ', ' + fCampo('BAICON').AsString) +
                iif(fEmptyStr(fCampo('CIDCON').AsString), '', ', ' + fCampo('CIDCON').AsString) +
                iif(fEmptyStr(fCampo('ESTCON').AsString), '', ', ' + fCampo('ESTCON').AsString);
              TfrxMemoView(frxDanfe.FindObject('rllCliCon')).Memo.Add(strEnderecoConsumidor);
            End;

            If Not fEmptyStr(fCampo('TELCON').AsString) Then
              TfrxMemoView(frxDanfe.FindObject('rllCliCon')).Memo.Add('TELEFONE: ' + fFormataFone(fCampo('TELCON').AsString));

            If (fImprimirEnderecoDeEntrega) And
               (fImprimirEnderecoEntregaItensRetira Or fImprimirEnderecoEntregaItensEntrega) Then
            Begin
              If Not fEmptyStr(fCampo('ENDENT').AsString) Then
              begin
                strEnderecoEntrega := 'END.P/ENTREGA: ' + fCampo('ENDENT').AsString +
                  iif(fEmptyStr(fCampo('BAIENT').AsString), '', ', ' + fCampo('BAIENT').AsString) +
                  iif(fEmptyStr(fCampo('CEPENT').AsString), '', ', ' + fCampo('CEPENT').AsString) +
                  iif(fEmptyStr(fCampo('CIDENT').AsString), '', ', ' + fCampo('CIDENT').AsString);
                TfrxMemoView(frxDanfe.FindObject('rllCliCon')).Memo.Add(strEnderecoEntrega);
              end;
              If Not fEmptyStr(fCampo('TELENT').AsString) Then
                TfrxMemoView(frxDanfe.FindObject('rllCliCon')).Memo.Add('TELEFONE: ' + fFormataFone(fCampo('TELENT').AsString));
            End;

          End;

        End
        Else
        begin
          TfrxMemoView(frxDanfe.FindObject('rllConsumidor')).Memo.Add('CONSUMIDOR NÃO IDENTIFICADO');
        end;
      End;

      TfrxMemoView(frxDanfe.FindObject('rllEnderecoConsulta')).Memo.Text := fCampo('LNKSIT').AsString;

      If fContingencia(fCampo('ACESSO').AsString) Then
      Begin
        TfrxChild(frxDanfe.FindObject('ChildContingencia1')).Visible := True;
        TfrxChild(frxDanfe.FindObject('ChildContingencia2')).Visible := True;

        if ConexaoBD.CarregarCFGSIS('NFCRED') = 'N' then
          if Assigned(TfrxMemoView(frxDanfe.FindObject('rllAreaMensagemFiscal'))) then
             TfrxMemoView(frxDanfe.FindObject('rllAreaMensagemFiscal')).Visible := False;

        TfrxMemoView(frxDanfe.FindObject('rllLabelProtocolo')).Visible := False;
        TfrxMemoView(frxDanfe.FindObject('rllProtocolo')).Visible := False;
      End
      Else
      Begin
        TfrxChild(frxDanfe.FindObject('ChildContingencia1')).Visible := False;
        TfrxChild(frxDanfe.FindObject('ChildContingencia2')).Visible := False;

        if ConexaoBD.CarregarCFGSIS('NFCRED') = 'N' then
          if Assigned(TfrxMemoView(frxDanfe.FindObject('rllAreaMensagemFiscal'))) then
             TfrxMemoView(frxDanfe.FindObject('rllAreaMensagemFiscal')).Visible := True;
      End;

      if Assigned(TfrxMemoView(frxDanfe.FindObject('rllMensagemAproveitaICMS'))) then
        TfrxMemoView(frxDanfe.FindObject('rllMensagemAproveitaICMS')).Visible := (ConexaoBD.CarregarCFGSIS('NFCEAC') = 'S');

      if Assigned(TfrxMemoView(frxDanfe.FindObject('ChdNumGuiche'))) then
        TfrxChild(frxDanfe.FindObject('ChdNumGuiche')).Visible := (Not fEmptyStr(fCampo('NUMGUI').AsString));

      If Assigned(TfrxMemoView(frxDanfe.FindObject('rllDocumento'))) Then
        TfrxMemoView(frxDanfe.FindObject('rllDocumento')).Text := fCampo('ESPDOC').AsString + ': ' + fCampo('NUMDOC').AsString;

      If Assigned(TfrxMemoView(frxDanfe.FindObject('rllPesoBruto'))) Then
        TfrxMemoView(frxDanfe.FindObject('rllPesoBruto')).Text := 'PESO BRUTO: ' + fCampo('PESBRU').AsString;

      If Assigned(TfrxMemoView(frxDanfe.FindObject('rllConferente'))) Then
      Begin
        TfrxMemoView(frxDanfe.FindObject('rllConferente')).Visible := ConexaoBD.CarregarCFGSIS('EXSECO') = 'S';
        TfrxMemoView(frxDanfe.FindObject('rllConferente')).Text := 'CONFERENTE: ' + fCampo('OPEEXP').AsString + ' - ' + fCampo('NOMEXP').AsString;
      End;

      If Assigned(TfrxChild(frxDanfe.FindObject('ChdNomeConferente'))) Then
        TfrxChild(frxDanfe.FindObject('ChdNomeConferente')).Visible := (Not fEmptyStr(fCampo('OPEEXP').AsString));

      If Assigned(TfrxChild(frxDanfe.FindObject('ChdNomeSeparador'))) Then
        TfrxChild(frxDanfe.FindObject('ChdNomeSeparador')).Visible := (Not fEmptyStr(fCampo('OPESEP').AsString));

      If ConexaoBD.CarregarCFGSIS('TAMQRC') = 'P' Then
      Begin
        TfrxPictureView(frxDanfe.FindObject('imgQRCode')).Height := QrCodePeq;
        TfrxPictureView(frxDanfe.FindObject('imgQRCode')).Width  := QrCodePeq;
      End
      Else If ConexaoBD.CarregarCFGSIS('TAMQRC') = 'M' Then
      Begin
        TfrxPictureView(frxDanfe.FindObject('imgQRCode')).Height := QrCodeMed;
        TfrxPictureView(frxDanfe.FindObject('imgQRCode')).Width  := QrCodeMed;
      End
      Else If ConexaoBD.CarregarCFGSIS('TAMQRC') = 'G' Then
      Begin
        TfrxPictureView(frxDanfe.FindObject('imgQRCode')).Height := QrCodeGrd;
        TfrxPictureView(frxDanfe.FindObject('imgQRCode')).Width  := QrCodeGrd;
      End;

      frxQrCode := TfrxPictureView(frxDanfe.FindObject('imgQRCode'));
      frxQrCodeDadosAdicionais := TfrxPictureView(frxDanfe.FindObject('imgQrCodeDadosAdicionais'));

      If frxDanfe.FindObject('memQtdIte1') <> nil Then
        TfrxMemoView(frxDanfe.FindObject('memQtdIte1')).DisplayFormat.FormatStr := fRetornaMascaraQtd(strToInt(ConexaoBD.CarregarCFGSIS('DECQTD')));

      If frxDanfe.FindObject('memQtdIte2') <> nil Then
        TfrxMemoView(frxDanfe.FindObject('memQtdIte2')).DisplayFormat.FormatStr := fRetornaMascaraQtd(StrToInt(ConexaoBD.CarregarCFGSIS('DECQTD')));

      If frxDanfe.FindObject('Memo40') <> nil Then
        TfrxMemoView(frxDanfe.FindObject('Memo40')).DisplayFormat.FormatStr := fRetornaMascaraQtd(StrToInt(ConexaoBD.CarregarCFGSIS('DECQTD')));

      If (frxDanfe.FindObject('Memo24') <> nil) and
         (frxDanfe.FindObject('Memo38') <> nil) and
         (strPRSGCL='1') Then
      begin
        TfrxMemoView(frxDanfe.FindObject('Memo24')).Visible := False;
        TfrxMemoView(frxDanfe.FindObject('Memo38')).Visible := False;
      end;

      pSetVar('MSGNFC', ConexaoBD.CarregarCFGSIS('MSGNFC'));
      pSetVar('IDEPRO', strIdePro);
      pSetVar('FN1VEN', fFormataFone(fCampo('FN1VEN').AsString));
      pSetVar('FN2VEN', fFormataFone(fCampo('FN2VEN').AsString));
      pSetVar('EMAVEN', fCampo('EMAVEN').AsString);
      If Assigned(TfrxMemoView(frxDanfe.FindObject('memWatermark'))) then
        pSetVar('MensagemReimpressao', IIF(blnReimpressao, '*** SEGUNDA VIA ***', ''));
      If Assigned(TfrxMemoView(frxDanfe.FindObject('memDescricaoCartao'))) then
        pSetVar('DESCRICAO_CARTAO', strDescrCartao);
      intTentativas := 0;

      While True Do
      Begin
        Try
          bmpQrCode := fGerarQRCode(fCampo('QRCODE').AsString);
          Sleep(100);
          Break;
        Except
          On E: Exception Do
          Begin
            Inc(intTentativas);
            If intTentativas > 30 Then
            Begin
              Raise;
            End;
            Sleep(500);
            Application.ProcessMessages;
          End;
        End;
      End;

     {$IF Defined(LINUX)}
      strPatImgQrCode := fGetUniqueTempPath('.bmp');
      try
        bmpQrCode.SaveToFile(strPatImgQrCode);
        frxQrCode.FileLink := strPatImgQrCode;
      finally
        FreeAndNil(bmpQrCode);
      end;
     {$ELSE}
      try
        stream := TMemoryStream.Create;
        bmpQrCode.SaveToStream(stream);
        frxQrCode.LoadPictureFromStream(stream);
        finally
        begin
          FreeAndNil(stream);
          FreeAndNil(bmpQrCode);
        end;
      end;
     {$IFEND}

      If FileExists(ConexaoBD.CarregarCFGSIS('PTNFCE') + '\opcoes_nfce.ini') Then
        If Not fEmptyStr(fArqIniLocal(0, 'NFCE', 'MARGEM', '', ConexaoBD.CarregarCFGSIS('PTNFCE') + '\opcoes_nfce.ini')) Then
          TfrxReportPage(frxDanfe.FindObject('Page1')).LeftMargin := fStrToFloat(fArqIniLocal(0, 'NFCE', 'MARGEM', '', ConexaoBD.CarregarCFGSIS('PTNFCE') + '\opcoes_nfce.ini')) * 10;

      if ((ConexaoBD.CarregarCFGSIS('QRCNFC') = 'S') and (ConexaoBD.CarregarCFGSIS('URLNFC') <> '')) then
      begin
        intTentativas := 0;

        While True Do
        Begin
          bmpQrCode := TBitmap.Create;
          Try
            bmpQrCode := fGerarQRCode(ConexaoBD.CarregarCFGSIS('URLNFC'));
            Sleep(100);
            Break;
          Except
            On E: Exception Do
            Begin
              Inc(intTentativas);
              If intTentativas > 30 Then
              Begin
                Raise;
              End;
              Sleep(500);
              Application.ProcessMessages;
            End;
          End;
        End;

       {$IF Defined(LINUX)}
        strPatImgQrCode := fGetUniqueTempPath('.bmp');
        try
          if Assigned(frxQrCodeDadosAdicionais) then
          begin
            bmpQrCode.SaveToFile(strPatImgQrCode);
            frxQrCodeDadosAdicionais.FileLink := strPatImgQrCode;
          end;
        finally
          FreeAndNil(bmpQrCode);
        end;
       {$ELSE}
        try
          stream := TMemoryStream.Create;
          bmpQrCode.SaveToStream(stream);
          if Assigned(frxQrCodeDadosAdicionais) then
          begin
            frxQrCodeDadosAdicionais.Visible := True;
            frxQrCodeDadosAdicionais.LoadPictureFromStream(stream);
          end;
        finally
          FreeAndNil(stream);
          FreeAndNil(bmpQrCode);
        end;
        {$IFEND}
      end;

     {$IF not Defined(LINUX)}
      If blnNfceDin And (FModoTeste = '') Then
      Begin
        If Not fNfceDinamicaPreparou(strErroNfceDin) Then
        Begin
          pGravaLogNfceDin('Impressao dinamica da NFC-e (provedor ' + cstProvedorCupomFiscal +
            ') falhou; a nota foi impressa pela rotina antiga.', strErroNfceDin);
          pDesligaNfceDin;
          pDanfeNFCe(strPRSGCL);
          Exit;
        End;
      End;

      If FModoTeste <> '' Then
      Begin
        If FModoTeste = 'V' Then
        Begin
          If Not blnNfceDin Then
            FResultadoTeste.Add('Rotina dinamica indisponivel para esta nota: verifique o SCRIPT_PAINEL_004, o provedor ' +
              cstProvedorCupomFiscal + ' (IMPNFE_CDS), o XML (XMLNFE) e se a nota nao e de contingencia.')
          Else
          Begin
            TNfsDinamico.pListaVariaveis(frxDanfe, cstProvedorCupomFiscal, FVariaveisTeste);
            If Assigned(FDadosTeste) Then
              pCopiaDadosNfceDin;
          End;
        End
        Else If FModoTeste = 'D' Then
        Begin
          If Not blnNfceDin Then
            FResultadoTeste.Add('Rotina dinamica indisponivel para esta nota: verifique o SCRIPT_PAINEL_004, o provedor ' +
              cstProvedorCupomFiscal + ' (IMPNFE_CDS), o XML (XMLNFE) e se a nota nao e de contingencia.')
          Else
          Begin
            If Not fNfceDinamicaPreparou(strErroNfceDin) Then
              FResultadoTeste.Add('Aviso: o relatorio com os datasets dinamicos nao foi preparado (' + strErroNfceDin + ').');
            If Not Assigned(frxDesigner) Then
              frxDesigner := TfrxDesigner.Create(nil);
            frxDanfe.DesignReport;
          End;
        End
        Else If blnNfceDin Then
        Begin
          // 1a passada (rotina nova): foto e refaz a nota pela rotina antiga
          If Not fNfceDinamicaPreparou(strErroNfceDin) Then
            FResultadoTeste.Add('Aviso: o relatorio pela rotina nova nao foi preparado (' + strErroNfceDin + ').');
          FreeAndNil(lstFotoNova);
          lstFotoNova := TStringList.Create;
          TNfceDinamico.pFotografa(dsNfceDin, frxDanfe, lstFotoNova);
          pDesligaNfceDin;
          pDanfeNFCe(strPRSGCL);
        End
        Else If Not Assigned(lstFotoNova) Then
          FResultadoTeste.Add('Rotina dinamica indisponivel para esta nota: verifique o SCRIPT_PAINEL_004, o provedor ' +
            cstProvedorCupomFiscal + ' (IMPNFE_CDS), o XML (XMLNFE) e se a nota nao e de contingencia.')
        Else
        Begin
          // 2a passada (rotina antiga): foto e comparacao
          lstFotoAntiga := TStringList.Create;
          Try
            TNfceDinamico.pFotografa(qryTmp, frxDanfe, lstFotoAntiga);
            FResultadoTeste.Add('NFC-e ' + strChaveAcesso + ': rotina antiga (consulta) x rotina nova (provedor ' +
              cstProvedorCupomFiscal + ')');
            FResultadoTeste.Add(StringOfChar('-', 78));
            TNfceDinamico.pComparar(lstFotoAntiga, lstFotoNova, FResultadoTeste, FintNaoEsperadas);
          Finally
            FreeAndNil(lstFotoAntiga);
          End;
        End;
        Exit;
      End;
     {$IFEND}

      If not blnDesignReport Then
      Begin
        If fEmptyStr(strImpressora) Then
        Begin
          strNomImp := fArqIniLocal(0, 'NFCE', 'IMPRESSORA', '', ConexaoBD.CarregarCFGSIS('PTNFCE') + '\opcoes_nfce.ini');
          If fArqIniLocal(0, 'GERAL', 'SPOOL_IMPRESSAO_CITEL', 'S', fPathOpcoesIni) <> 'N' Then
            if ConexaoBD.CarregarCFGSIS('SPOIMP') = 'S' then
              strNomImp := fArqIniLocal(0, 'NFCE', 'PONTO_IMPRESSAO', '', ConexaoBD.CarregarCFGSIS('PTNFCE') + '\opcoes_nfce.ini');
        End
        Else
          strNomImp := strImpressora;

        blnEscolheuNaoImprimirViaNfe := False;
        intQtdVias := StrToIntDef(ConexaoBD.CarregarCFGSIS('VIANFC'), 1);
        If (fCampo('VIANFE').AsInteger >= 0) Then
        Begin
          intQtdVias := fCampo('VIANFE').AsInteger;
          blnEscolheuNaoImprimirViaNfe := (intQtdVias = 0);
        End;

        If fEhSomenteUmaVia(blnPDF_Gerar, blnReimpressao, intQtdVias, blnEscolheuNaoImprimirViaNfe) Then
          intQtdVias := 1;

        If (StrToIntDef(ConexaoBD.CarregarCFGSIS('VIANFP'), 1) >= intQtdVias) And
           (fCampo('TIPCND').AsString = 'P') And
           (Not blnEscolheuNaoImprimirViaNfe) Then
        Begin
          intQtdVias := StrToIntDef(ConexaoBD.CarregarCFGSIS('VIANFP'), 1);
        End;

        If not blnPDF_Banco Then
        Begin
          pLogImp('pDanfeNFCe > intQtdVias = '+IntToStr(intQtdVias));
          For i := 1 To intQtdVias Do
          Begin
            If (blnPDF_Gerar) Then
            Begin
              frxDanfe.EngineOptions.NewSilentMode := simReThrow;
              frxPDFExport.FileName   := strPDF_Diretorio;
              frxPDFExport.ShowDialog := False;
              frxDanfe.PrintOptions.ShowDialog := False;
            {$IF Defined(LINUX)}
              frxDanfe.DataSets.Add(frxDbDanfe);
              frxDanfe.EnabledDataSets.Add(frxDbDanfe);
              frxDanfe.ShowProgress := False;
              frxPDFExport.ShowProgress := False;
              frxPDFExport.EmbeddedFonts := True;
            {$IFEND}
              frxDanfe.PrepareReport();
              frxDanfe.Export(frxPDFExport);

             {$IF Defined(LINUX)}
             {$ELSE}
              blnNfceDinImprimindo := True;
              If (blnPDF_Apresentar) Then
              Begin
                if FileExists(frxPDFExport.FileName) then
                  ShellExecute(0, nil, PChar(frxPDFExport.FileName), nil, nil, SW_SHOWNORMAL)
                else
                begin
                  frxPDFExport.ShowDialog := True;
                  pPreviewReport('NFeImpressao', 'NFC-e ' + strChaveAcesso, frxDanfe);
                end;
              End;
             {$IFEND}
            End
            Else
            Begin
             {$IF Defined(LINUX)}
             {$ELSE}
              frxDanfe.PrintOptions.Printer  := AnsiReplaceStr(strNomImp, '\\' + fRetNomeRede + '\', '');
              frxDanfe.PrintOptions.ShowDialog := False;
              If (frxDanfe.PrepareReport) Then
              Begin
                blnNfceDinImprimindo := True;
                pPrintReport('NFeImpressao', 'NFC-e ' + strChaveAcesso, strNomImp, frxDanfe);
              End
              Else If blnNfceDin Then
                pGravaLogNfceDin('Impressao dinamica da NFC-e (provedor ' + cstProvedorCupomFiscal +
                  '): o relatorio nao foi preparado e a via ' + IntToStr(i) + ' nao foi impressa.',
                  frxDanfe.Errors.Text);

              If (intQtdVias > 1) Then
                Sleep(1000);
             {$IFEND}
            End;
          End;
        End;

        pLogImp('untImpressaoNFCe.Imprimir - pDanfeNFCe');

        If Assigned(ConexaoBD) Then
        Begin
          ConexaoBD.pSalvarDFePDF(frxDanfe, strChaveAcesso);
        End;

      End
      Else
        frxDanfe.DesignReport;

    Finally
      FreeAndNil(frxDanfe);
      FreeAndNil(frxDbDanfe);
    End;

  End;

  procedure pDanfeNFCeDin(strPRSGCL: String = '');
  begin
   {$IF not Defined(LINUX)}
    blnNfceDinImprimindo := False;
    Try
      pDanfeNFCe(strPRSGCL);
    Except
      On E: Exception Do
      Begin
        If (Not blnNfceDin) Or (FModoTeste <> '') Then
          Raise;
        If blnNfceDinImprimindo Then
        Begin
          pGravaLogNfceDin('Impressao dinamica da NFC-e (provedor ' + cstProvedorCupomFiscal +
            ') falhou na impressao, depois da validacao; a impressao foi interrompida.',
            E.ClassName + ': ' + E.Message);
          Raise;
        End;
        pGravaLogNfceDin('Impressao dinamica da NFC-e (provedor ' + cstProvedorCupomFiscal +
          ') falhou; a nota foi impressa pela rotina antiga.', E.ClassName + ': ' + E.Message);
        pDesligaNfceDin;
        pDanfeNFCe(strPRSGCL);
      End;
    End;
   {$ELSE}
    pDanfeNFCe(strPRSGCL);
   {$IFEND}
  end;

  procedure pDanfeNFCe58MM(strPRSGCL: String = '');
  var
    i, intQtdVias: Integer;
    fltTopLocFis: Double;
    strTipCnd: String;
    LStreamDanfe: TStringStream;
  begin
    Try
      frxDbDanfe := TfrxDBDataset.Create(nil);
      frxDbDanfe.UserName := 'frxNFce';
      frxDbDanfe.DataSet := qryTmp;

      frxDanfe := TfrxReport.Create(nil);

      LStreamDanfe := fStringToStreamDanfe(ConexaoBD.FConfiguracao.LayoutSmartPOS);
      frxDanfe.LoadFromStream(LStreamDanfe);
      LStreamDanfe.Free;

      frxDanfe.Script.Variables['PROFIS'] := ConexaoBD.CarregarCFGSIS('PROFIS') + ':';
      frxDanfe.Script.Variables['CODDIV'] := qryTmp.FieldByName('CODDIV').AsString;
      frxDanfe.Script.Variables['NOMDIV'] := qryTmp.FIeldByName('NOMDIV').AsString;

      if TfrxChild(frxDanfe.FindObject('ChdContribuinte')).Visible then
      begin
        if blnDesignReport Or ( (ConexaoBD.CarregarCFGSIS('NFCADC') = 'S') and (not fEmptyStr(qryTmp.FieldByName('CODDIV').AsString)) ) then
        begin
          TfrxChild(frxDanfe.FindObject('ChdContribuinte')).Height  := 83.15; //20.54;
          If Assigned(TfrxMemoView(frxDanfe.FindObject('rllProfissional'))) Then
            TfrxMemoView(frxDanfe.FindObject('rllProfissional')).Visible := True;
        end
        else
        begin
          frxDanfe.Script.Variables['PROFIS'] := '';
          frxDanfe.Script.Variables['CODDIV'] := '';
          frxDanfe.Script.Variables['NOMDIV'] := '';
          If Assigned(TfrxMemoView(frxDanfe.FindObject('rllProfissional'))) Then
          begin
            TfrxMemoView(frxDanfe.FindObject('rllProfissional')).Visible := False;
            TfrxMemoView(frxDanfe.FindObject('rllProfissional')).Top := 1.03;
          end;
          TfrxChild(frxDanfe.FindObject('ChdContribuinte')).Height := 56.70; //1.60;
        end;
      end
      else
      begin
        if blnDesignReport Or ( (ConexaoBD.CarregarCFGSIS('NFCADC') = 'S') and (not fEmptyStr(qryTmp.FieldByName('CODDIV').AsString)) ) then
        begin
          TfrxChild(frxDanfe.FindObject('ChdContribuinte')).Visible := True;
          TfrxChild(frxDanfe.FindObject('ChdContribuinte')).Height  := 83.15; //20.54;
          If Assigned(TfrxMemoView(frxDanfe.FindObject('rllProfissional'))) Then
            TfrxMemoView(frxDanfe.FindObject('rllProfissional')).Visible := True;
        end;
      end;

      If Assigned(TfrxChild(frxDanfe.FindObject('ChdBarDoc'))) Then
      begin
        TfrxChild(frxDanfe.FindObject('ChdBarDoc')).Visible := True;
        TfrxBarCodeView(frxDanfe.FindObject('cbBarDoc')).Text := '1'+
                                                                 qryTmp.FieldByName('NUMDOC').AsString+
                                                                 '02'+
                                                                 qryTmp.FieldByName('CODEMP').AsString;
      end;

      If Assigned(TfrxChild(frxDanfe.FindObject('ChdLogo'))) Then
        TfrxChild(frxDanfe.FindObject('ChdLogo')).Visible := False;

      If blnDesignReport Or (ConexaoBD.CarregarCFGSIS('LOGNFC')='S') Then
      Begin
        strDirLogo := ConexaoBD.CarregarCFGSIS('PTLNFC');
        If (Not fEmptyStr(strDirLogo)) And (FileExists(strDirLogo)) Then
        Begin
          TfrxChild(frxDanfe.FindObject('ChdLogo')).Visible := True;
          TfrxPictureView(frxDanfe.FindObject('rllImagem')).Picture.LoadFromFile(strDirLogo);
        End;
      End;

      If (ConexaoBD.CarregarCFGSIS('NFEMAR') = 'S') Or (ConexaoBD.CarregarCFGSIS('NFEFAB') = 'S') Then
      begin
        TfrxMasterData(frxDanfe.FindObject('MasterData1')).Visible := False;
        TfrxMasterData(frxDanfe.FindObject('MasterData2')).Visible := True;

        If (ConexaoBD.CarregarCFGSIS('NFEFAB')='S') And (Not (ConexaoBD.CarregarCFGSIS('NFEMAR')='S')) Then
          TfrxMemoView(frxDanfe.FindObject('MemoCodFab')).Left := 5.3;

        If ConexaoBD.CarregarCFGSIS('NFEMAR')='S' Then
          TfrxMemoView(frxDanfe.FindObject('MemoMarca')).Visible := True
        Else
          TfrxMemoView(frxDanfe.FindObject('MemoMarca')).Visible := False;

        If ConexaoBD.CarregarCFGSIS('NFEFAB')='S' Then
          TfrxMemoView(frxDanfe.FindObject('MemoCodFab')).Visible := True
        Else
          TfrxMemoView(frxDanfe.FindObject('MemoCodFab')).Visible := False;

        If Assigned(TfrxMemoView(frxDanfe.FindObject('memLocFis2'))) Then
        Begin
          if (ConexaoBD.CarregarCFGSIS('NFCLOC') = 'N') then
          begin
            If ConexaoBD.CarregarCFGSIS('NFEMAR')='S' Then
              fltTopLocFis := TfrxMemoView(frxDanfe.FindObject('memLocFis2')).Top
            Else
              fltTopLocFis := TfrxMemoView(frxDanfe.FindObject('memLocFis2')).Top - TfrxMemoView(frxDanfe.FindObject('MemoMarca')).Height;
            TfrxMemoView(frxDanfe.FindObject('memLocFis2')).Visible := False;
            TfrxMemoView(frxDanfe.FindObject('memQtdIte2')).Top := fltTopLocFis;
            TfrxMemoView(frxDanfe.FindObject('memUnidad2')).Top := fltTopLocFis;
            TfrxMemoView(frxDanfe.FindObject('memUnitar2')).Top := fltTopLocFis;
            TfrxMemoView(frxDanfe.FindObject('memTotIte2')).Top := fltTopLocFis;
          end;
        End;

      end
      Else
      begin
        TfrxMasterData(frxDanfe.FindObject('MasterData2')).Visible := False;
        TfrxMasterData(frxDanfe.FindObject('MasterData1')).Visible := True;

        If Assigned(TfrxMemoView(frxDanfe.FindObject('memLocFis1'))) Then
        Begin
          if (ConexaoBD.CarregarCFGSIS('NFCLOC') = 'N') then
          begin
            fltTopLocFis := TfrxMemoView(frxDanfe.FindObject('memLocFis1')).Top;
            TfrxMemoView(frxDanfe.FindObject('memLocFis1')).Visible := False;
            TfrxMemoView(frxDanfe.FindObject('memQtdIte1')).Top := fltTopLocFis;
            TfrxMemoView(frxDanfe.FindObject('memUnidad1')).Top := fltTopLocFis;
            TfrxMemoView(frxDanfe.FindObject('memUnitar1')).Top := fltTopLocFis;
            TfrxMemoView(frxDanfe.FindObject('memTotIte1')).Top := fltTopLocFis;
          end;
        End;

      end;

      If Assigned(TfrxMemoView(frxDanfe.FindObject('memSubTtal'))) then
      Begin
        TfrxMemoView(frxDanfe.FindObject('memSubTtal')).DataField := '';

        If Assigned(TfrxMemoView(frxDanfe.FindObject('memDscTtal'))) then
          TfrxMemoView(frxDanfe.FindObject('memDscTtal')).DataField := '';

        If Assigned(TfrxMemoView(frxDanfe.FindObject('memVlrUnit1'))) then
          TfrxMemoView(frxDanfe.FindObject('memVlrUnit1')).DataField := '';
        If Assigned(TfrxMemoView(frxDanfe.FindObject('memVlrUnit2'))) then
          TfrxMemoView(frxDanfe.FindObject('memVlrUnit2')).DataField := '';

        If Assigned(TfrxMemoView(frxDanfe.FindObject('memTtalIte1'))) then
          TfrxMemoView(frxDanfe.FindObject('memTtalIte1')).DataField := '';
        If Assigned(TfrxMemoView(frxDanfe.FindObject('memTtalIte2'))) then
          TfrxMemoView(frxDanfe.FindObject('memTtalIte2')).DataField := '';

        If (fFormataFloat(qryTmp.FieldByName('UNIDIG').AsFloat, strtointdef(fCfgSis('DECUNI'), 4)) > fFormataFloat(qryTmp.FieldByName('UNITAR').AsFloat, strtointdef(fCfgSis('DECUNI'), 4)))
        and (fFormataFloat(qryTmp.FieldByName('UNIDIG').AsFloat, strtointdef(fCfgSis('DECUNI'), 4)) > fFormataFloat(qryTmp.FieldByName('UNIORI').AsFloat, strtointdef(fCfgSis('DECUNI'), 4))) then
        Begin
          If Assigned(TfrxMemoView(frxDanfe.FindObject('memVlrUnit1'))) then
            TfrxMemoView(frxDanfe.FindObject('memVlrUnit1')).Text := '[frxNFce."UNIDIG"]';
          If Assigned(TfrxMemoView(frxDanfe.FindObject('memVlrUnit2'))) then
            TfrxMemoView(frxDanfe.FindObject('memVlrUnit2')).Text := '[frxNFce."UNIDIG"]';

          If Assigned(TfrxMemoView(frxDanfe.FindObject('memTtalIte1'))) then
            TfrxMemoView(frxDanfe.FindObject('memTtalIte1')).Text := '[<frxNFce."UNIDIG"> * <frxNFce."QTDITE">]';
          If Assigned(TfrxMemoView(frxDanfe.FindObject('memTtalIte2'))) then
            TfrxMemoView(frxDanfe.FindObject('memTtalIte2')).Text := '[<frxNFce."UNIDIG"> * <frxNFce."QTDITE">]';

          TfrxMemoView(frxDanfe.FindObject('memSubTtal')).Text := '[SUM(<frxNFce."QTDITE"> * <frxNFce."UNIDIG">, MasterData1,2)]';

          If Assigned(TfrxMemoView(frxDanfe.FindObject('memDscTtal'))) then
            TfrxMemoView(frxDanfe.FindObject('memDscTtal')).Text := '[SUM(((<frxNFce."UNIDIG"> - <frxNFce."UNITAR">) * <frxNFce."QTDITE">),MasterData1,2) + <frxNFce."DESESP">]';
        End

        Else If fFormataFloat(qryTmp.FieldByName('UNIORI').AsFloat, strtointdef(fCfgSis('DECUNI'), 4)) >= fFormataFloat(qryTmp.FieldByName('UNITAR').AsFloat, strtointdef(fCfgSis('DECUNI'), 4)) then
        Begin
          If Assigned(TfrxMemoView(frxDanfe.FindObject('memVlrUnit1'))) then
            TfrxMemoView(frxDanfe.FindObject('memVlrUnit1')).Text := '[frxNFce."UNIORI"]';
          If Assigned(TfrxMemoView(frxDanfe.FindObject('memVlrUnit2'))) then
            TfrxMemoView(frxDanfe.FindObject('memVlrUnit2')).Text := '[frxNFce."UNIORI"]';

          If Assigned(TfrxMemoView(frxDanfe.FindObject('memTtalIte1'))) then
            TfrxMemoView(frxDanfe.FindObject('memTtalIte1')).Text := '[<frxNFce."UNIORI"> * <frxNFce."QTDITE">]';
          If Assigned(TfrxMemoView(frxDanfe.FindObject('memTtalIte2'))) then
            TfrxMemoView(frxDanfe.FindObject('memTtalIte2')).Text := '[<frxNFce."UNIORI"> * <frxNFce."QTDITE">]';

          TfrxMemoView(frxDanfe.FindObject('memSubTtal')).Text := '[SUM(<frxNFce."QTDITE"> * <frxNFce."UNIORI">, MasterData1,2)]';

          If Assigned(TfrxMemoView(frxDanfe.FindObject('memDscTtal'))) then
            TfrxMemoView(frxDanfe.FindObject('memDscTtal')).Text := '[SUM(((<frxNFce."UNIORI"> - <frxNFce."UNITAR">) * <frxNFce."QTDITE">),MasterData1,2) + <frxNFce."DESESP">]';
        End

        Else
        Begin
          If Assigned(TfrxMemoView(frxDanfe.FindObject('memVlrUnit1'))) then
            TfrxMemoView(frxDanfe.FindObject('memVlrUnit1')).Text := '[frxNFce."UNITAR"]';
          If Assigned(TfrxMemoView(frxDanfe.FindObject('memVlrUnit2'))) then
            TfrxMemoView(frxDanfe.FindObject('memVlrUnit2')).Text := '[frxNFce."UNITAR"]';

          If Assigned(TfrxMemoView(frxDanfe.FindObject('memTtalIte1'))) then
            TfrxMemoView(frxDanfe.FindObject('memTtalIte1')).Text := '[<frxNFce."UNITAR"> * <frxNFce."QTDITE">]';
          If Assigned(TfrxMemoView(frxDanfe.FindObject('memTtalIte2'))) then
            TfrxMemoView(frxDanfe.FindObject('memTtalIte2')).Text := '[<frxNFce."UNITAR"> * <frxNFce."QTDITE">]';

          TfrxMemoView(frxDanfe.FindObject('memSubTtal')).Text := '[SUM(<frxNFce."QTDITE"> * <frxNFce."UNITAR">, MasterData1,2)]';

          If Assigned(TfrxMemoView(frxDanfe.FindObject('memDscTtal'))) then
            TfrxMemoView(frxDanfe.FindObject('memDscTtal')).Text := '[SUM(((<frxNFce."UNITAR"> - <frxNFce."UNIORI">) * <frxNFce."QTDITE">),MasterData1,2) + <frxNFce."DESESP">]';
        End;
      End;

      If Assigned(TfrxMemoView(frxDanfe.FindObject('Memo41'))) then
      Begin
        strTipCnd := qryTmp.FieldByName('TIPCND').AsString;

        if strTipCnd = ('V') then
        Begin
          TfrxMemoView(frxDanfe.FindObject('Memo41')).Text := 'TOTAL PAGO R$:'
        End
        Else
        Begin
          TfrxMemoView(frxDanfe.FindObject('Memo41')).Text := 'TOTAL A PAGAR R$:'
        End;
      End;


      if ConexaoBD.CarregarCFGSIS('DESNFC') = '2' then
      Begin

        if TfrxMasterData(frxDanfe.FindObject('MasterData1')).Visible then
        begin
          If Assigned(TfrxMemoView(frxDanfe.FindObject('memUnitar1'))) then
          begin
            TfrxMemoView(frxDanfe.FindObject('memUnitar1')).Datafield := '';
            TfrxMemoView(frxDanfe.FindObject('memUnitar1')).Text := '[<frxNFce."UNIORI">]';
          end;

          If Assigned(TfrxMemoView(frxDanfe.FindObject('memTotIte1'))) then
          begin
            TfrxMemoView(frxDanfe.FindObject('memTotIte1')).Datafield := '';
            TfrxMemoView(frxDanfe.FindObject('memTotIte1')).Text := '[<frxNFce."UNIORI"> * <frxNFce."QTDITE">]';
          end;

          if Assigned(TfrxMemoView(frxDanfe.FindObject('memo28'))) then
          begin
            TfrxMemoView(frxDanfe.FindObject('memo28')).Datafield := '';
            TfrxMemoView(frxDanfe.FindObject('memo28')).Text := '[SUM(<frxNFce."QTDITE">*<frxNFce."UNIORI">,MasterData1,2)]';
          end;
          if Assigned(TfrxMemoView(frxDanfe.FindObject('memo30'))) then
          begin
            TfrxMemoView(frxDanfe.FindObject('memo30')).Datafield := '';
            TfrxMemoView(frxDanfe.FindObject('memo30')).Text := '[SUM( ((<frxNFce."UNIORI">-<frxNFce."UNITAR">)*<frxNFce."QTDITE">),MasterData1,2 ) + <frxNFce."DESESP">]';
          end;

        end;

        if TfrxMasterData(frxDanfe.FindObject('MasterData2')).Visible then
        begin
          If Assigned(TfrxMemoView(frxDanfe.FindObject('memUnitar2'))) then
          begin
            TfrxMemoView(frxDanfe.FindObject('memUnitar2')).Datafield := '';
            TfrxMemoView(frxDanfe.FindObject('memUnitar2')).Text := '[<frxNFce."UNIORI">]';
          end;

          If Assigned(TfrxMemoView(frxDanfe.FindObject('memTotIte2'))) then
          begin
            TfrxMemoView(frxDanfe.FindObject('memTotIte2')).Datafield := '';
            TfrxMemoView(frxDanfe.FindObject('memTotIte2')).Text := '[<frxNFce."UNIORI"> * <frxNFce."QTDITE">]';
          end;

          If Assigned(TfrxMemoView(frxDanfe.FindObject('memo28'))) then
          begin
            TfrxMemoView(frxDanfe.FindObject('memo28')).Datafield := '';
            TfrxMemoView(frxDanfe.FindObject('memo28')).Text := '[SUM(<frxNFce."QTDITE">*<frxNFce."UNIORI">,MasterData2,2)]';
          end;

          If Assigned(TfrxMemoView(frxDanfe.FindObject('memo30'))) then
          begin
            TfrxMemoView(frxDanfe.FindObject('memo30')).Datafield := '';
            TfrxMemoView(frxDanfe.FindObject('memo30')).Text := '[SUM( ((<frxNFce."UNIORI">-<frxNFce."UNITAR">)*<frxNFce."QTDITE">),MasterData2,2 ) + <frxNFce."DESESP">]';
          end;
        end;
      End;

      frxDanfe.Script.Variables['NOMEMP'] := qryTmp.FieldByName('NOMEMP').AsString;
      frxDanfe.Script.Variables['NMEFAN'] := qryTmp.FieldByName('NMEFAN').AsString;
      frxDanfe.Script.Variables['CNPJ']   := fFormataCpfCgc(qryTmp.FieldByName('C_G_C_').AsString);
      frxDanfe.Script.Variables['IE']     := qryTmp.FieldByName('I_E_S_').AsString;
      frxDanfe.Script.Variables['IM']     := qryTmp.FieldByName('INSMUN').AsString;
      frxDanfe.Script.Variables['ENDEMP'] := qryTmp.FieldByName('ENDEMP').AsString;
      frxDanfe.Script.Variables['CEPEMP'] := fFormataCEP(AnsiReplaceStr(qryTmp.FieldByName('CEPEMP').AsString, '-', ''));
      frxDanfe.Script.Variables['TELEMP'] := fFormataFone(qryTmp.FieldByName('TELEMP').AsString);
      frxDanfe.Script.Variables['TELEM2'] := fFormataFone(qryTmp.FieldByName('TELEM2').AsString);
      frxDanfe.Script.Variables['NUMDOC'] := qryTmp.FieldByName('NUMDOC').AsString;
      frxDanfe.Script.Variables['SERIE_'] := qryTmp.FieldByName('SERIE_').AsString;
      frxDanfe.Script.Variables['DTAEMI'] := FormatDateTime('dd/mm/yyyy', qryTmp.FieldByName('DTAENT').AsDateTime) + ' ' + FormatDateTime('hh:mm:ss', qryTmp.FieldByName('HORENT').AsDateTime);
      frxDanfe.Script.Variables['ACESSO'] := fTransform(qryTmp.FieldByName('ACESSO').AsString, 4, ' ');
      frxDanfe.Script.Variables['PROTOC'] := qryTmp.FieldByName('PROTOC').AsString;
      frxDanfe.Script.Variables['DPROTO'] := FormatDateTime('dd/mm/yyyy hh:nn:ss', qryTmp.FieldByName('DPROTO').AsDateTime);
      frxDanfe.Script.Variables['NOMVEN'] := qryTmp.FieldByName('NOMVEN').AsString;

      If Assigned(TfrxMemoView(frxDanfe.FindObject('memInfComp'))) then
        frxDanfe.Script.Variables['INF_COMPLEMENTAR'] := ConexaoBD.fGetInfComplementar(qryTmp, sLineBreak, EmptyStr, fVerificarItensEmPromocao(qryTmp), False, False)
      Else
        frxDanfe.Script.Variables['INF_COMPLEMENTAR'] := ConexaoBD.fGetInfComplementar(qryTmp, sLineBreak, EmptyStr, fVerificarItensEmPromocao(qryTmp));

      If (fStatusCndPag(qryTmp.FieldByName('CONPAG').AsString) = A_VISTA) Then
        frxDanfe.Script.Variables['CONDICAO_PAGAMENTO'] := 'A VISTA'
      Else
        frxDanfe.Script.Variables['CONDICAO_PAGAMENTO'] := fFormataCondPag(qryTmp.FieldByName('CONPAG').AsString);

      frxDanfe.Script.Variables['MODALIDADES'] := strModalidades;
      frxDanfe.Script.Variables['VALORES_MOD'] := strValores;
      frxDanfe.Script.Variables['HOMEPA'] := qryTmp.FieldByName('HOMEPA').AsString;

      If Assigned(TfrxMemoView(frxDanfe.FindObject('memParcelasCartao'))) then
        frxDanfe.Script.Variables['PARCELAS_CARTAO'] := strParcelasCartao;

      If Assigned(TfrxChild(frxDanfe.FindObject('chdInfCartao'))) Then
      Begin
        If Assigned(TfrxMemoView(frxDanfe.FindObject('memInfCartao'))) Then
        Begin
          If Not fEmptyStr(strCarConPag) then
            TfrxMemoView(frxDanfe.FindObject('memInfCartao')).Memo.Add(strCarConPag)
          Else
            TfrxChild(frxDanfe.FindObject('chdInfCartao')).Visible := False;
        End;
      End;

      strImpostos := '';
      If StrToIntDef(ConexaoBD.CarregarCFGSIS('IMPPAG'),0) = 1 Then
      Begin
        frxDanfe.Script.Variables['TOTAL_TRIBUTOS'] := FloatToStrF(qryTmp.FieldByName('IMPPAG').AsFloat, ffNumber, 12, 2);
      End
      Else
      Begin
        If qryTmp.FieldByName('FEDIMP').AsFloat + qryTmp.FieldByName('ESTIMP').AsFloat + qryTmp.FieldByName('MUNIMP').AsFloat = 0 Then
        Begin
          frxDanfe.Script.Variables['TOTAL_TRIBUTOS'] := '0,00';
        End
        Else
        Begin
          If qryTmp.FieldByName('FEDIMP').AsFloat <> 0 Then
            strImpostos := strImpostos + FloatToStrF(qryTmp.FieldByName('FEDIMP').AsFloat, ffNumber, 12, 2) + ' Fed';

          If qryTmp.FieldByName('ESTIMP').AsFloat <> 0 Then
            strImpostos := strImpostos + '/' + FloatToStrF(qryTmp.FieldByName('ESTIMP').AsFloat, ffNumber, 12, 2) + ' Est';

          If qryTmp.FieldByName('MUNIMP').AsFloat <> 0 Then
            strImpostos := strImpostos + '/' + FloatToStrF(qryTmp.FieldByName('MUNIMP').AsFloat, ffNumber, 12, 2) + ' Mun';

          frxDanfe.Script.Variables['TOTAL_TRIBUTOS'] := strImpostos + '/ Fonte:IBPT.';
        End;
      End;

      If Assigned(TfrxMemoView(frxDanfe.FindObject('mmLblTotalPago'))) Then
      begin
        If (fStatusCndPag(qryTmp.FieldByName('CONPAG').AsString) = A_PRAZO) Then
        begin
          TfrxMemoView(frxDanfe.FindObject('mmLblTotalPago')).Text := 'FATURADO:';
        end;
      end;

      frxDanfe.Script.Variables['TROCO_'] := FloatToStrF(qryTmp.FieldByName('TROCO_').AsFloat, ffNumber, 12, 2);

      If (not blnDesignReport) And (qryTmp.FieldByName('TROCO_').AsFloat = 0) Then
      Begin
        If Assigned(TfrxMemoView(frxDanfe.FindObject('rllTroco'))) then
          TfrxMemoView(frxDanfe.FindObject('rllTroco')).Visible := False;
        If Assigned(TfrxMemoView(frxDanfe.FindObject('rllValTroco'))) then
          TfrxMemoView(frxDanfe.FindObject('rllValTroco')).Visible := False;
      End;

      if Assigned(TfrxChild(frxDanfe.FindObject('ChildFidelidade'))) Then
      begin
        frxDanfe.Script.Variables['PTOVEN'] := qryTmp.FieldByName('PTOVEN').AsFloat;
        frxDanfe.Script.Variables['PTOSLD'] := qryTmp.FieldByName('PTOSLD').AsFloat;
        TfrxChild(frxDanfe.FindObject('ChildFidelidade')).Visible := (qryTmp.FieldByName('PTOVEN').AsFloat > 0) or
                                                                     (qryTmp.FieldByName('PTOSLD').AsFloat > 0);
      end;

      TfrxMemoView(frxDanfe.FindObject('rllConsumidor')).Memo.Clear;

      If fConsumidorIdentificado Then
      Begin
        if qryTmp.FieldByName('NOTPAU').AsString = 'S' then
        begin
          If fTestaCgc(qryTmp.FieldByName('CGCCON').AsString) Then
            TfrxMemoView(frxDanfe.FindObject('rllConsumidor')).Memo.Add('CNPJ: ' + fFormataCpfCgc(qryTmp.FieldByName('CGCCON').AsString))
          Else
            TfrxMemoView(frxDanfe.FindObject('rllConsumidor')).Memo.Add('CPF: '  + fFormataCpfCgc(qryTmp.FieldByName('CGCCON').AsString));
        end;
        If Not fEmptyStr(qryTmp.FieldByName('NOMCON').AsString) Then
        Begin
          TfrxMemoView(frxDanfe.FindObject('rllConsumidor')).Memo.Add(qryTmp.FieldByName('NOMCON').AsString +
                            IIF(ConexaoBD.CarregarCFGSIS('CCLNFE')='S', ' ' + qryTmp.FieldByName('CODCLI').AsString, ''));

          If Not fEmptyStr(qryTmp.FieldByName('ENDERE').AsString) Then
          Begin
            strEnderecoConsumidor := qryTmp.FieldByName('ENDERE').AsString + ', ';

            If Not fEmptyStr(qryTmp.FieldByName('ENDNUM').AsString) Then
              strEnderecoConsumidor := strEnderecoConsumidor + qryTmp.FieldByName('ENDNUM').AsString + ', ';

            If Not fEmptyStr(qryTmp.FieldByName('ENDCOM').AsString) Then
              strEnderecoConsumidor := strEnderecoConsumidor + qryTmp.FieldByName('ENDCOM').AsString + ', ';

            If Not fEmptyStr(qryTmp.FieldByName('BAICON').AsString) Then
              strEnderecoConsumidor := strEnderecoConsumidor + qryTmp.FieldByName('BAICON').AsString + ', ';

            strEnderecoConsumidor := strEnderecoConsumidor + qryTmp.FieldByName('CIDCON').AsString + ', ';
            strEnderecoConsumidor := strEnderecoConsumidor + qryTmp.FieldByName('ESTCON').AsString;

            TfrxMemoView(frxDanfe.FindObject('rllConsumidor')).Memo.Add(strEnderecoConsumidor);
          End;

          If Not fEmptyStr(qryTmp.FieldByName('TELCON').AsString) Then
            TfrxMemoView(frxDanfe.FindObject('rllConsumidor')).Memo.Add('TELEFONE: ' + fFormataFone(qryTmp.FieldByName('TELCON').AsString));

          If (fImprimirEnderecoDeEntrega) And
             (fImprimirEnderecoEntregaItensRetira Or fImprimirEnderecoEntregaItensEntrega) Then
          Begin
            If Not fEmptyStr(qryTmp.FieldByName('ENDENT').AsString) Then
              strEnderecoEntrega := 'END.P/ENTREGA: ' + qryTmp.FieldByName('ENDENT').AsString;

            If Not fEmptyStr(qryTmp.FieldByName('BAIENT').AsString) Then
              strEnderecoEntrega := strEnderecoEntrega + ', ' + qryTmp.FieldByName('BAIENT').AsString;

            If Not fEmptyStr(qryTmp.FieldByName('CEPENT').AsString) then
              strEnderecoEntrega := strEnderecoEntrega + ', ' + qryTmp.FieldByName('CEPENT').AsString;

            If Not fEmptyStr(qryTmp.FieldByName('CIDENT').AsString) then
              strEnderecoEntrega := strEnderecoEntrega + ', ' + qryTmp.FieldByName('CIDENT').AsString;

            TfrxMemoView(frxDanfe.FindObject('rllConsumidor')).Memo.Add(strEnderecoEntrega);

            If Not fEmptyStr(qryTmp.FieldByName('TELENT').AsString) Then
              TfrxMemoView(frxDanfe.FindObject('rllConsumidor')).Memo.Add('TELEFONE: ' + fFormataFone(qryTmp.FieldByName('TELENT').AsString));

          End;

        End;

      End
      Else
      Begin
        If Assigned(TfrxMemoView(frxDanfe.FindObject('rllCliCon'))) Then
        Begin
          If Not fEmptyStr(qryTmp.FieldByName('NOMCON').AsString) Then
           Begin
            TfrxMemoView(frxDanfe.FindObject('rllCliCon')).Memo.Add(qryTmp.FieldByName('NOMCON').AsString);

            If Not fEmptyStr(qryTmp.FieldByName('ENDERE').AsString) Then
            Begin
              strEnderecoConsumidor := qryTmp.FieldByName('ENDERE').AsString + ', ';

              If Not fEmptyStr(qryTmp.FieldByName('ENDNUM').AsString) Then
                strEnderecoConsumidor := strEnderecoConsumidor + qryTmp.FieldByName('ENDNUM').AsString + ', ';

              If Not fEmptyStr(qryTmp.FieldByName('ENDCOM').AsString) Then
                strEnderecoConsumidor := strEnderecoConsumidor + qryTmp.FieldByName('ENDCOM').AsString + ', ';

              If Not fEmptyStr(qryTmp.FieldByName('BAICON').AsString) Then
                strEnderecoConsumidor := strEnderecoConsumidor + qryTmp.FieldByName('BAICON').AsString + ', ';

              strEnderecoConsumidor := strEnderecoConsumidor + qryTmp.FieldByName('CIDCON').AsString + ', ';
              strEnderecoConsumidor := strEnderecoConsumidor + qryTmp.FieldByName('ESTCON').AsString;

              TfrxMemoView(frxDanfe.FindObject('rllCliCon')).Memo.Add(strEnderecoConsumidor);
            End;

            If Not fEmptyStr(qryTmp.FieldByName('TELCON').AsString) Then
              TfrxMemoView(frxDanfe.FindObject('rllCliCon')).Memo.Add('TELEFONE: ' + fFormataFone(qryTmp.FieldByName('TELCON').AsString));

            If (fImprimirEnderecoDeEntrega) And
              (fImprimirEnderecoEntregaItensRetira Or fImprimirEnderecoEntregaItensEntrega) Then
            Begin
              If Not fEmptyStr(qryTmp.FieldByName('ENDENT').AsString) Then
                strEnderecoEntrega := 'END.P/ENTREGA: ' + qryTmp.FieldByName('ENDENT').AsString;

              If Not fEmptyStr(qryTmp.FieldByName('BAIENT').AsString) Then
                strEnderecoEntrega := strEnderecoEntrega + ', ' + qryTmp.FieldByName('BAIENT').AsString;

              If Not fEmptyStr(qryTmp.FieldByName('CEPENT').AsString) then
                strEnderecoEntrega := strEnderecoEntrega + ', ' + qryTmp.FieldByName('CEPENT').AsString;

              If Not fEmptyStr(qryTmp.FieldByName('CIDENT').AsString) then
                strEnderecoEntrega := strEnderecoEntrega + ', ' + qryTmp.FieldByName('CIDENT').AsString;

              TfrxMemoView(frxDanfe.FindObject('rllCliCon')).Memo.Add(strEnderecoEntrega);

              If Not fEmptyStr(qryTmp.FieldByName('TELENT').AsString) Then
                TfrxMemoView(frxDanfe.FindObject('rllCliCon')).Memo.Add('TELEFONE: ' + fFormataFone(qryTmp.FieldByName('TELENT').AsString));

            End;

          End;

        End
        Else
          TfrxMemoView(frxDanfe.FindObject('rllConsumidor')).Memo.Add('CONSUMIDOR NÃO IDENTIFICADO');
      End;

      TfrxMemoView(frxDanfe.FindObject('rllEnderecoConsulta')).Memo.Text := qryTmp.FieldByName('LNKSIT').AsString;

      If fContingencia(qryTmp.FieldByName('ACESSO').AsString) Then
      Begin
        TfrxChild(frxDanfe.FindObject('ChildContingencia1')).Visible := True;

        if ConexaoBD.CarregarCFGSIS('NFCRED') = 'N' then
          if Assigned(TfrxMemoView(frxDanfe.FindObject('rllAreaMensagemFiscal'))) then
             TfrxMemoView(frxDanfe.FindObject('rllAreaMensagemFiscal')).Visible := False;

        TfrxMemoView(frxDanfe.FindObject('rllLabelProtocolo')).Visible := False;
        TfrxMemoView(frxDanfe.FindObject('rllProtocolo')).Visible := False;
      End
      Else
      Begin
        TfrxChild(frxDanfe.FindObject('ChildContingencia1')).Visible := False;

        if ConexaoBD.CarregarCFGSIS('NFCRED') = 'N' then
          if Assigned(TfrxMemoView(frxDanfe.FindObject('rllAreaMensagemFiscal'))) then
             TfrxMemoView(frxDanfe.FindObject('rllAreaMensagemFiscal')).Visible := True;
      End;

      TfrxMemoView(frxDanfe.FindObject('rllMensagemAproveitaICMS')).Visible := (ConexaoBD.CarregarCFGSIS('NFCEAC') = 'S');

      If ConexaoBD.CarregarCFGSIS('TAMQRC') = 'P' Then
      Begin
        TfrxPictureView(frxDanfe.FindObject('imgQRCode')).Height := QrCodePeq;
        TfrxPictureView(frxDanfe.FindObject('imgQRCode')).Width  := QrCodePeq;
      End
      Else If ConexaoBD.CarregarCFGSIS('TAMQRC') = 'M' Then
      Begin
        TfrxPictureView(frxDanfe.FindObject('imgQRCode')).Height := QrCodeMed;
        TfrxPictureView(frxDanfe.FindObject('imgQRCode')).Width  := QrCodeMed;
      End
      Else If ConexaoBD.CarregarCFGSIS('TAMQRC') = 'G' Then
      Begin
        TfrxPictureView(frxDanfe.FindObject('imgQRCode')).Height := QrCodeGrd;
        TfrxPictureView(frxDanfe.FindObject('imgQRCode')).Width  := QrCodeGrd;
      End;

      frxQrCode := TfrxPictureView(frxDanfe.FindObject('imgQRCode'));
      frxQrCodeDadosAdicionais := TfrxPictureView(frxDanfe.FindObject('imgQrCodeDadosAdicionais'));

      If frxDanfe.FindObject('memQtdIte1') <> nil Then
        TfrxMemoView(frxDanfe.FindObject('memQtdIte1')).DisplayFormat.FormatStr := fRetornaMascaraQtd(strToInt(ConexaoBD.CarregarCFGSIS('DECQTD')));

      If frxDanfe.FindObject('memQtdIte2') <> nil Then
        TfrxMemoView(frxDanfe.FindObject('memQtdIte2')).DisplayFormat.FormatStr := fRetornaMascaraQtd(StrToInt(ConexaoBD.CarregarCFGSIS('DECQTD')));

      If frxDanfe.FindObject('Memo40') <> nil Then
        TfrxMemoView(frxDanfe.FindObject('Memo40')).DisplayFormat.FormatStr := fRetornaMascaraQtd(StrToInt(ConexaoBD.CarregarCFGSIS('DECQTD')));

      If (frxDanfe.FindObject('Memo24') <> nil) and
         (frxDanfe.FindObject('Memo38') <> nil) and
         (strPRSGCL='1') Then
      begin
        TfrxMemoView(frxDanfe.FindObject('Memo24')).Visible := False;
        TfrxMemoView(frxDanfe.FindObject('Memo38')).Visible := False;
      end;

      TfrxChild(frxDanfe.FindObject('ChildDesconto')).Visible := qryTmp.FieldByName('DESESP').asFloat > 0 ;
      TfrxChild(frxDanfe.FindObject('ChildAcrescimo')).Visible := (qryTmp.FieldByName('TOTFRE').asFloat + qryTmp.FieldByName('DESACE').asFloat) > 0 ;

      intTentativas := 0;

      While True Do
      Begin
        Try
          bmpQrCode := fGerarQRCode(qryTmp.FieldByName('QRCODE').AsString);
          Sleep(100);
          Break;
        Except
          On E: Exception Do
          Begin
            Inc(intTentativas);
            If intTentativas > 30 Then
            Begin
              Raise;
            End;
            Sleep(500);
            Application.ProcessMessages;
          End;
        End;
      End;

     {$IF Defined(LINUX)}
      strPatImgQrCode := fGetUniqueTempPath('.bmp');
      try
        bmpQrCode.SaveToFile(strPatImgQrCode);
        frxQrCode.FileLink := strPatImgQrCode;
      finally
        FreeAndNil(bmpQrCode);
      end;
     {$ELSE}
      try
        stream := TMemoryStream.Create;
        bmpQrCode.SaveToStream(stream);
        frxQrCode.LoadPictureFromStream(stream);
      finally
        FreeAndNil(stream);
        FreeAndNil(bmpQrCode);
      end;
     {$IFEND}

      If FileExists(ConexaoBD.CarregarCFGSIS('PTNFCE') + '\opcoes_nfce.ini') Then
        If Not fEmptyStr(fArqIniLocal(0, 'NFCE', 'MARGEM', '', ConexaoBD.CarregarCFGSIS('PTNFCE') + '\opcoes_nfce.ini')) Then
          TfrxReportPage(frxDanfe.FindObject('Page1')).LeftMargin := fStrToFloat(fArqIniLocal(0, 'NFCE', 'MARGEM', '', ConexaoBD.CarregarCFGSIS('PTNFCE') + '\opcoes_nfce.ini')) * 10;

      if ((ConexaoBD.CarregarCFGSIS('QRCNFC') = 'S') and (ConexaoBD.CarregarCFGSIS('URLNFC') <> '')) then
      begin
        intTentativas := 0;

        While True Do
        Begin
          bmpQrCode := TBitmap.Create;
          Try
            bmpQrCode := fGerarQRCode(ConexaoBD.CarregarCFGSIS('URLNFC'));
            Sleep(100);
            Break;
          Except
            On E: Exception Do
            Begin
              Inc(intTentativas);
              If intTentativas > 30 Then
              Begin
                Raise;
              End;
              Sleep(500);
              Application.ProcessMessages;
            End;
          End;
        End;

       {$IF Defined(LINUX)}
        strPatImgQrCode := fGetUniqueTempPath('.bmp');
        try
          if Assigned(frxQrCodeDadosAdicionais) then
          begin
            bmpQrCode.SaveToFile(strPatImgQrCode);
            frxQrCodeDadosAdicionais.FileLink := strPatImgQrCode;
          end;
        finally
          FreeAndNil(bmpQrCode);
        end;
       {$ELSE}
        try
          stream := TMemoryStream.Create;
          bmpQrCode.SaveToStream(stream);
          if Assigned(frxQrCodeDadosAdicionais) then
          begin
            frxQrCodeDadosAdicionais.Visible := True;
            frxQrCodeDadosAdicionais.LoadPictureFromStream(stream);
          end;
        finally
          FreeAndNil(stream);
          FreeAndNil(bmpQrCode);
        end;
       {$IFEND}
      end;

      If not blnDesignReport Then
      Begin
        If fEmptyStr(strImpressora) Then
        Begin
          strNomImp := fArqIniLocal(0, 'NFCE', 'IMPRESSORA', '', ConexaoBD.CarregarCFGSIS('PTNFCE') + '\opcoes_nfce.ini');
          If fArqIniLocal(0, 'GERAL', 'SPOOL_IMPRESSAO_CITEL', 'S', fPathOpcoesIni) <> 'N' Then
            if ConexaoBD.CarregarCFGSIS('SPOIMP') = 'S' then
              strNomImp := fArqIniLocal(0, 'NFCE', 'PONTO_IMPRESSAO', '', ConexaoBD.CarregarCFGSIS('PTNFCE') + '\opcoes_nfce.ini');
        End
        Else
          strNomImp := strImpressora;

        blnEscolheuNaoImprimirViaNfe := False;
        intQtdVias := StrToIntDef(ConexaoBD.CarregarCFGSIS('VIANFC'), 1);
        If (qryTmp.FieldByName('VIANFE').AsInteger >= 0) Then
        Begin
          intQtdVias := qryTmp.FieldByName('VIANFE').AsInteger;
          blnEscolheuNaoImprimirViaNfe := (intQtdVias = 0);
        End;

        If fEhSomenteUmaVia(blnPDF_Gerar, blnReimpressao, intQtdVias, blnEscolheuNaoImprimirViaNfe) Then
          intQtdVias := 1;

        If not blnPDF_Banco Then
        Begin
          pLogImp('pDanfeNFCe58MM > intQtdVias = '+IntToStr(intQtdVias));
          For i := 1 To intQtdVias Do
          Begin
            If (blnPDF_Gerar) Then
            Begin
              frxDanfe.EngineOptions.NewSilentMode := simReThrow;
              frxPDFExport.FileName       := strPDF_Diretorio;
              frxPDFExport.ShowDialog     := False;
              frxPDFExport.PrintOptimized := True;
              frxDanfe.PrintOptions.ShowDialog := False;
            {$IF Defined(LINUX)}
              frxDanfe.DataSets.Add(frxDbDanfe);
              frxDanfe.EnabledDataSets.Add(frxDbDanfe);
              frxDanfe.ShowProgress := False;
              frxPDFExport.ShowProgress := False;
              frxPDFExport.EmbeddedFonts := True;
            {$IFEND}
              frxDanfe.PrepareReport();
              frxDanfe.Export(frxPDFExport);

             {$IF Defined(LINUX)}
             {$ELSE}
              If (blnPDF_Apresentar) Then
              Begin
                if FileExists(frxPDFExport.FileName) then
                  ShellExecute(0, nil, PChar(frxPDFExport.FileName), nil, nil, SW_SHOWNORMAL)
                else
                begin
                  frxPDFExport.ShowDialog := True;
                  pPreviewReport('NFeImpressao', 'NFC-e ' + strChaveAcesso, frxDanfe);
                end;
              End;
             {$IFEND}
            End
            Else
            Begin
             {$IF Defined(LINUX)}
             {$ELSE}
              frxDanfe.PrintOptions.Printer  := AnsiReplaceStr(strNomImp, '\\' + fRetNomeRede + '\', '');
              frxDanfe.PrintOptions.ShowDialog := False;

              If (frxDanfe.PrepareReport) Then
                pPrintReport('NFeImpressao', 'NFC-e ' + strChaveAcesso, strNomImp, frxDanfe);

              If (intQtdVias > 1) Then
                Sleep(1000);
             {$IFEND}
            End;
          End;
        End;

        pLogImp('untImpressaoNFCe.Imprimir - pDanfeNFCe');

      {$IF Defined(LINUX)}
        frxDanfe.DataSets.Add(frxDbDanfe);
        frxDanfe.EnabledDataSets.Add(frxDbDanfe);
        frxPDFExport.EmbeddedFonts := True;
      {$IFEND}

        If Assigned(ConexaoBD) Then
        Begin
          ConexaoBD.pSalvarDFePDF(frxDanfe, strChaveAcesso);
        End;

      End
      Else
        frxDanfe.DesignReport;

    Finally
      FreeAndNil(frxDanfe);
      FreeAndNil(frxDbDanfe);
    End;

  end;

  procedure pDanfeSat;
  var
    LPathSat: String;
    LStreamDanfe: TStringStream;
  Begin
    Try
      frxDbDanfe := TfrxDBDataset.Create(nil);
      frxDbDanfe.UserName := 'frxNFce';
      frxDbDanfe.DataSet := qryTmp;

      frxDanfe := TfrxReport.Create(nil);

      frxDanfe.AddFunction('function fNumeroDoItem: String');
      frxDanfe.AddFunction('function fArredondaUnit(strCampo: String): String');
      frxDanfe.OnUserFunction := frxDanfeUserFunction;

      ConexaoBD.CarregarConfiguracao(strChaveAcesso, strCodigoEmpresa, 'SAT', 4.00);

      LStreamDanfe := fStringToStreamDanfe(ConexaoBD.FConfiguracao.LayoutRetrato);
      frxDanfe.LoadFromStream(LStreamDanfe);
      LStreamDanfe.Free;

      frxDanfe.Script.Variables['NOMEMP'] := qryTmp.FieldByName('NOMEMP').AsString;
      frxDanfe.Script.Variables['NMEFAN'] := qryTmp.FieldByName('NMEFAN').AsString;
      frxDanfe.Script.Variables['CNPJ'] := fFormataCpfCgc(qryTmp.FieldByName('C_G_C_').AsString);
      frxDanfe.Script.Variables['IE'] := qryTmp.FieldByName('I_E_S_').AsString;
      frxDanfe.Script.Variables['IM'] := qryTmp.FieldByName('INSMUN').AsString;
      frxDanfe.Script.Variables['ENDEMP'] := qryTmp.FieldByName('ENDEMP').AsString;
      frxDanfe.Script.Variables['CEPEMP'] := fFormataCEP(AnsiReplaceStr(qryTmp.FieldByName('CEPEMP').AsString, '-', ''));
      frxDanfe.Script.Variables['TELEMP'] := fFormataFone(qryTmp.FieldByName('TELEMP').AsString);
      frxDanfe.Script.Variables['TELEM2'] := fFormataFone(qryTmp.FieldByName('TELEM2').AsString);
      frxDanfe.Script.Variables['NUMSER'] := LeftStr(fTransform(qryTmp.FieldByName('NUMSER').AsString, 3, '.'), 11);
      frxDanfe.Script.Variables['NUMCOO'] := qryTmp.FieldByName('NUMCOO').AsString;
      frxDanfe.Script.Variables['SERIE_'] := qryTmp.FieldByName('SERIE_').AsString;
      frxDanfe.Script.Variables['DTAEMI'] := FormatDateTime('dd/mm/yyyy', qryTmp.FieldByName('DTAENT').AsDateTime);
      frxDanfe.Script.Variables['ACESSO'] := fTransform(qryTmp.FieldByName('ACESSO').AsString, 4, ' ');
      frxDanfe.Script.Variables['PROTOC'] := qryTmp.FieldByName('PROTOC').AsString;
      frxDanfe.Script.Variables['DPROTO'] := FormatDateTime('dd/mm/yyyy hh:nn:ss', qryTmp.FieldByName('DPROTO').AsDateTime);

      strEnderecoConsumidor := '';

      If Not fEmptyStr(qryTmp.FieldByName('ENDERE').AsString) Then
      Begin
        strEnderecoConsumidor := 'END: ' + qryTmp.FieldByName('ENDERE').AsString;

        If Not fEmptyStr(qryTmp.FieldByName('ENDNUM').AsString) Then
          strEnderecoConsumidor := strEnderecoConsumidor + ', ' + qryTmp.FieldByName('ENDNUM').AsString;

        If Not fEmptyStr(qryTmp.FieldByName('ENDCOM').AsString) Then
          strEnderecoConsumidor := strEnderecoConsumidor + ', ' + qryTmp.FieldByName('ENDCOM').AsString;

        If Not fEmptyStr(qryTmp.FieldByName('BAICON').AsString) Then
          strEnderecoConsumidor := strEnderecoConsumidor + ', ' + qryTmp.FieldByName('BAICON').AsString;

        If Not fEmptyStr(qryTmp.FieldByName('CIDCON').AsString) then
          strEnderecoConsumidor := strEnderecoConsumidor + ', ' + qryTmp.FieldByName('CIDCON').AsString;

        If Not fEmptyStr(qryTmp.FieldByName('ESTCON').AsString) then
          strEnderecoConsumidor := strEnderecoConsumidor + ', ' + qryTmp.FieldByName('ESTCON').AsString;

        If Not fEmptyStr(qryTmp.FieldByName('IESCON').AsString) then
          strEnderecoConsumidor := strEnderecoConsumidor + ', IE: ' + qryTmp.FieldByName('IESCON').AsString;

        strEnderecoConsumidor := strEnderecoConsumidor + sLineBreak;
      End;

      If Assigned(TfrxMemoView(frxDanfe.FindObject('MemoMarca'))) then
        TfrxMemoView(frxDanfe.FindObject('MemoMarca')).Visible := (ConexaoBD.CarregarCFGSIS('NFEMAR') = 'S');

      If Assigned(TfrxMemoView(frxDanfe.FindObject('memSubTtal'))) then
      Begin
        If fFormataFloat(qryTmp.FieldByName('UNIORI').AsFloat, strtointdef(fCfgSis('DECUNI'), 4)) > fFormataFloat(qryTmp.FieldByName('UNITAR').AsFloat, strtointdef(fCfgSis('DECUNI'), 4)) then
        Begin
          TfrxMemoView(frxDanfe.FindObject('memSubTotal')).DataField := '';
          TfrxMemoView(frxDanfe.FindObject('memValLiq')).DataField := '';
          TfrxMemoView(frxDanfe.FindObject('Memo17')).DataField := '';
          TfrxMemoView(frxDanfe.FindObject('Memo15')).DataField := '';

          TfrxMemoView(frxDanfe.FindObject('Memo15')).Text := '[<frxNFce."UNIORI">]';
          TfrxMemoView(frxDanfe.FindObject('Memo17')).Text := '[<frxNFce."QTDITE">*<frxNFce."UNIORI">]'; //total dos itens unitario original
          TfrxMemoView(frxDanfe.FindObject('memSubTotal')).Text := '[SUM(<frxNFce."QTDITE">*<frxNFce."UNIORI">, MasterData1,2)]'; //subtotal da compra unitario original
          TfrxMemoView(frxDanfe.FindObject('memValLiq')).Text := '[(<frxNFce."QTDITE">*<frxNFce."UNIORI">) - <frxNFce."DET_DESESP">]'; // valor liquido unitario original
        End
        Else
        begin
          TfrxMemoView(frxDanfe.FindObject('memSubTotal')).DataField := '';
          TfrxMemoView(frxDanfe.FindObject('memValLiq')).DataField := '';
          TfrxMemoView(frxDanfe.FindObject('Memo15')).DataField := '';
          TfrxMemoView(frxDanfe.FindObject('Memo17')).DataField := '';

          TfrxMemoView(frxDanfe.FindObject('Memo15')).Text := '[<frxNFce."UNITAR">]';
          TfrxMemoView(frxDanfe.FindObject('Memo17')).Text := '[<frxNFce."QTDITE">*<frxNFce."UNITAR">]'; //total dos itens unitario
          TfrxMemoView(frxDanfe.FindObject('memSubTotal')).Text := '[SUM(<frxNFce."QTDITE">*<frxNFce."UNITAR">, MasterData1,2)]'; //subtotal da compra unitario
          TfrxMemoView(frxDanfe.FindObject('memValLiq')).Text := '[(<frxNFce."QTDITE">*<frxNFce."UNITAR">) - <frxNFce."DET_DESESP">]'; // valor liquido unitario
        end;
      end;

      If Assigned(frxDanfe.FindObject('memDesTot')) Then
      Begin
        TfrxMemoView(frxDanfe.FindObject('memDesTot')).DataField := '';

        If fFormataFloat(qryTmp.FieldByName('UNIORI').AsFloat, strtointdef(fCfgSis('DECUNI'), 4)) > fFormataFloat(qryTmp.FieldByName('UNITAR').AsFloat, strtointdef(fCfgSis('DECUNI'),4)) then
        Begin
         TfrxMemoView(frxDanfe.FindObject('memDesTot')).Text := '[SUM((<frxNFce."UNIORI"> - <frxNFce."UNITAR">) * <frxNFce."QTDITE">, MasterData1, 2 )]'; //desconto total da compra
        End
        Else
          TfrxMemoView(frxDanfe.FindObject('memDesTot')).Text := '0,00'
      End;

      frxDanfe.Script.Variables['INF_FISCO'] := qryTmp.FieldByName('OBSFIS').AsString;
      frxDanfe.Script.Variables['INF_COMPLEMENTAR'] := ConexaoBD.fGetInfComplementar(qryTmp, sLineBreak, strEnderecoConsumidor, fVerificarItensEmPromocao(qryTmp));

      frxDanfe.Script.Variables['MODALIDADES'] := strModalidades;
      frxDanfe.Script.Variables['VALORES_MOD'] := strValores;
      frxDanfe.Script.Variables['TOTAL_TRIBUTOS'] := FloatToStrF(qryTmp.FieldByName('IMPPAG').AsFloat, ffNumber, 12, 2);

      frxDanfe.Script.Variables['TROCO_'] := FloatToStrF(qryTmp.FieldByName('TROCO_').AsFloat, ffNumber, 12, 2);
      If qryTmp.FieldByName('TROCO_').AsFloat = 0 Then
        TfrxChild(frxDanfe.FindObject('Child3')).Visible := False;

      If fStringRepetida(qryTmp.FieldByName('CGCCON').AsString) Then
        frxDanfe.Script.Variables['CPF_CONSUMIDOR'] := ''
      Else If fTestaCgc(qryTmp.FieldByName('CGCCON').AsString) Then
        frxDanfe.Script.Variables['CPF_CONSUMIDOR'] := fFormataCpfCgc(qryTmp.FieldByName('CGCCON').AsString)
      Else
        frxDanfe.Script.Variables['CPF_CONSUMIDOR'] := fFormataCpfCgc(qryTmp.FieldByName('CGCCON').AsString);

      frxDanfe.Script.Variables['QTDNPS'] := IntToStr(intQtdNps);
      TfrxChild(frxDanfe.FindObject('ChdNetpoints')).Visible := (intQtdNps > 0);
      TfrxChild(frxDanfe.FindObject('ChdSimNac')).Visible := (ConexaoBD.CarregarCFGSIS('SIMNAC') = 'S');

      If blnSatComplementar Then
      Begin
        frxDanfe.Script.Variables['MODALIDADES'] := '';
        frxDanfe.Script.Variables['VALORES_MOD'] := '';
        frxDanfe.Script.Variables['INF_COMPLEMENTAR'] := 'CF-e complementar '+#13+
                                                            'Cliente: ' + qryTmp.FieldByName('CODCLI').AsString + ' - ' + qryTmp.FieldByName('NOMCON').AsString + sLineBreak +
                                                            strEnderecoConsumidor + sLineBreak +
                                                            'IF: ' + qryTmp.FieldByName('NUMDOC').AsString + sLineBreak +
                                                            'Documento fiscal Original: '+qryTmp.FieldByName('ESPORI').AsString+'-'+
                                                                                          qryTmp.FieldByName('DOCORI').AsString + sLineBreak +
                                                                                          'Chave: '+qryTmp.FieldByName('ACEORI').AsString;
        TfrxChild(frxDanfe.FindObject('Child7')).Visible := False;
        TfrxChild(frxDanfe.FindObject('ChdSimNac')).Visible := False;
      End;

      frxQrCode := TfrxPictureView(frxDanfe.FindObject('imgQRCode'));

      intTentativas := 0;

      While True Do
      Begin
        Try
          bmpQrCode := fGerarQRCode(qryTmp.FieldByName('QRCODE').AsString);
          Sleep(100);
          Break;
        Except
          On E: Exception Do
          Begin
            Inc(intTentativas);
            If intTentativas > 30 Then
            Begin
              Raise;
            End;
            Sleep(500);
            Application.ProcessMessages;
          End;
        End;
      End;

      If not fEmptyStr(VS_PathSat) Then
      Begin
        LPathSat := VS_PathSat;
      End
      Else
      Begin
        LPathSat := ConexaoBD.CarregarCFGSIS('PATSAT');
      End;

      If FileExists(LPathSat + '\opcoes_sat.ini') Then
        If Not fEmptyStr(fArqIniLocal(0, 'SATCFE', 'MARGEM', '', LPathSat + '\opcoes_sat.ini')) Then
          TfrxReportPage(frxDanfe.FindObject('Page1')).LeftMargin := fStrToFloat(fArqIniLocal(0, 'SATCFE', 'MARGEM', '', LPathSat + '\opcoes_sat.ini')) * 10;

     {$IF Defined(LINUX)}
      strPatImgQrCode := fGetUniqueTempPath('.bmp');
      try
        bmpQrCode.SaveToFile(strPatImgQrCode);
        frxQrCode.FileLink := strPatImgQrCode;
      finally
        FreeAndNil(bmpQrCode);
      end;
     {$ELSE}
      stream := TMemoryStream.Create;
      try
        bmpQrCode.SaveToStream(stream);
        frxQrCode.LoadPictureFromStream(stream);
      finally
        FreeAndNil(stream);
      end;
     {$IFEND}
      FreeAndNil(bmpQrCode);

      If not blnDesignReport Then
      Begin
        If fEmptyStr(strImpressora) Then
        Begin
          strNomImp := fArqIniLocal(0, 'SATCFE', 'IMPRESSORA', '', LPathSat + '\opcoes_sat.ini');
          If fArqIniLocal(0, 'GERAL', 'SPOOL_IMPRESSAO_CITEL', 'S', fPathOpcoesIni) <> 'N' Then
            If ConexaoBD.CarregarCFGSIS('SPOIMP') = 'S' Then
              strNomImp := fArqIniLocal(0, 'SATCFE', 'PONTO_IMPRESSAO', '', LPathSat + '\opcoes_sat.ini');
        End
        Else
          strNomImp := strImpressora;

        frxDanfe.PrintOptions.Printer := AnsiReplaceStr(strNomImp,'\\' + fRetNomeRede + '\','');
        frxDanfe.PrintOptions.ShowDialog := False;

       {$IF Defined(LINUX)}
       {$ELSE}
        If frxDanfe.PrepareReport Then
          pPrintReport('NFeImpressao', 'SAT ' + strChaveAcesso, strNomImp, frxDanfe);
       {$IFEND}
      End
      Else
        frxDanfe.DesignReport;

    Finally
      FreeAndNil(frxDanfe);
      FreeAndNil(frxDbDanfe);
    End;

  End;

  function fFormataFoneSQL(strCampo: String; strApelido: String = ''; blnAddApelido: Boolean = True): String;
  begin
    Result := '';
    Result := Result + ' IF(' + strCampo + '='''', '''', CONCAT("(",';
    Result := Result + ' SUBSTRING(' + strCampo + ', 1, 2), ") ",';
    Result := Result + ' SUBSTRING(' + strCampo + ', 3, 5), "-",';
    Result := Result + ' SUBSTRING(' + strCampo + ', 8, 4)))';
    If blnAddApelido Then
      Result := Result + ' AS ' + IIF(fEmptyStr(strApelido), strCampo, strApelido);
  end;

  function fSQLIFClienteConsumidor(const ACampoNomCli, ACampoCliCon, ACampoCadCli: String): String;
    Var
      LPalCon : String;
      LCnt : Integer;
      LInstrucao : String;
  begin
    Result := '';

    LPalCon := ConexaoBD.CarregarCFGSIS('PALCON');

    For LCnt := 1 To Length(LPalCon) Do
    Begin
      If (LPalCon[LCnt] <> 'S') Then
        Continue;

      If (LCnt > Length(arrConsumidor)) Then
        Break;

      LInstrucao := '(@NOMCLI LIKE "%' + arrConsumidor[LCnt] + '%")';

      If fEmptyStr(Result) Then
        Result := LInstrucao
      Else
        Result := Result + ' OR ' + LInstrucao;

      If (arrConsumidor[LCnt] = 'BALCAO') Then
        Result := Result + ' OR (@NOMCLI LIKE "%BALCÃO%")';
    End;

    If fEmptyStr(Result) Then
      Result := 'IF((@NOMCLI LIKE "%CONSUMIDOR%") OR (@NOMCLI LIKE "%BALCAO%") OR (@NOMCLI LIKE "%BALCÃO%") OR (@NOMCLI LIKE "%SEGURADORA%"), @CLICON, @CADCLI)'
    Else
      Result := 'IF(' + Result + ', @CLICON, @CADCLI)';

    Result := AnsiReplaceStr(Result, '@NOMCLI', ACampoNomCli);
    Result := AnsiReplaceStr(Result, '@CLICON', ACampoCliCon);
    Result := AnsiReplaceStr(Result, '@CADCLI', ACampoCadCli);
  end;

  function fCampoCelCon: string;
  begin
    If (ConexaoBD.fCampoExiste('AUXMOV', 'AUX_CELCON')) And (ConexaoBD.fCampoExiste('AUXNOT', 'AUX_CELCON')) Then
      Result := 'AUX_CELCON'
    Else
      Result := 'CLI_CELULA';
  end;

Begin
  pLogImp('untImpressaoNFCe.Imprimir');

  blnNfceDin := False;
  FintNaoEsperadas := 0;
 {$IF not Defined(LINUX)}
  blnNfceCancelada := False;
  entNfceDin := nil;
  objNfceDin := nil;
  dsNfceDin := nil;
  lstFotoNova := nil;
  If FModoTeste <> '' Then
  Begin
    FResultadoTeste.Clear;
    FVariaveisTeste.Clear;
  End;
 {$IFEND}

  Try
    Try
      blnUsaSat := ConexaoBD.fUsaSat;

      blnSatComplementar := blnUsaSat and ConexaoBD.fSatComplementar(strCodigoEmpresa, strChaveAcesso);

      {$IF not Defined(LINUX)}
      blnNfceDin := fUsaNfceDinamica;
      If blnNfceDin Then
        blnNfceCancelada := ConexaoBD.fNfeCancelada(strChaveAcesso, strCodigoEmpresa);
     {$IFEND}

      qryTmp := fCriaQuery(nil);
      strSQL := '';
      strSQLOriginal := '';

      If blnSatComplementar Then
      Begin
        qryTmp.SQL.Add('SELECT ');
        qryTmp.SQL.Add('  GER_DOCORI AS DOCORI, ');
        qryTmp.SQL.Add('  GER_ESPORI AS ESPORI, ');
        qryTmp.SQL.Add('  GER_EMPORI AS EMPORI, ');
        qryTmp.SQL.Add('  GER_SERORI AS SERORI, ');
        qryTmp.SQL.Add('  GER_ACEORI AS ACEORI, ');
        qryTmp.SQL.Add('  "0000" AS CODITE, ');
        qryTmp.SQL.Add('  "COMPLEMENTO DE ICMS" AS DESITE, ');
        qryTmp.SQL.Add('  "COMPLEMENTO DE ICMS" AS DESORI, ');
        qryTmp.SQL.Add('  0.00 AS QTDITE, ');
        qryTmp.SQL.Add('  0.00 AS TOTITE, ');
        qryTmp.SQL.Add('  0.00 AS DET_IMPPAG, ');
        qryTmp.SQL.Add('  0.00 AS UNITAR, ');
        qryTmp.SQL.Add('  0.00 AS UNIDIG, ');
        qryTmp.SQL.Add('  0.00 AS UNIORI, ');
        qryTmp.SQL.Add('  "UN" AS UNIDAD, ');
        qryTmp.SQL.Add('  "" AS FORITE, ');
        qryTmp.SQL.Add('  "" AS NUMLOT, ');
        qryTmp.SQL.Add('  "" AS LOCFIS, ');
        qryTmp.SQL.Add('  0.00 AS TOTITE, ');
        qryTmp.SQL.Add('  0.00 AS DET_DESESP, ');
        qryTmp.SQL.Add('  FIS_VLRIC1 AS DET_TOTLIQ, ');
        qryTmp.SQL.Add('  0.00 AS DESESP, ');
        qryTmp.SQL.Add('  FIS_BASIC1 AS TOTPRO, ');
        qryTmp.SQL.Add('  FIS_BASIC1 AS VLRCON, ');
        qryTmp.SQL.Add('  FIS_NUMDOC AS NUMDOC, ');
        qryTmp.SQL.Add('  FIS_ESPDOC AS ESPDOC, ');
        qryTmp.SQL.Add('  FIS_CODEMP AS CODEMP, ');
        qryTmp.SQL.Add('  FIS_SERIE_ AS SERIE_, ');
        qryTmp.SQL.Add('  FIS_ACESSO AS ACESSO, ');
        qryTmp.SQL.Add('  LEFT(FIS_ACESSO, 22) AS ACESSO1, ');
        qryTmp.SQL.Add('  RIGHT(FIS_ACESSO, 22) AS ACESSO2, ');
        qryTmp.SQL.Add('  FIS_NUMSER AS NUMSER, ');
        qryTmp.SQL.Add('  FIS_NUMCOO AS NUMCOO, ');
        qryTmp.SQL.Add('  FIS_ACESSO AS QRCODE, ');
        qryTmp.SQL.Add('  "" AS PROTOC, ');
        qryTmp.SQL.Add('  CURRENT_TIMESTAMP AS DPROTO, ');
        qryTmp.SQL.Add('  "" AS OBSFIS, ');
        qryTmp.SQL.Add('  "" AS PRTMSG, ');
        qryTmp.SQL.Add('  FIS_DTAENT AS DTAENT, ');
        qryTmp.SQL.Add('  CURRENT_TIME AS HORENT, ');
        qryTmp.SQL.Add('  CAST("N" AS CHAR(1)) AS DET_PROMOC, ');

        If (ConexaoBD.CarregarCFGSIS('RSNFNC') = 'F') Then
          qryTmp.SQL.Add('  EMP_NOMFAN AS NOMEMP, ')
        Else
          qryTmp.SQL.Add('  EMP_NOMEMP AS NOMEMP, ');

        qryTmp.SQL.Add('  EMP_NOMFAN AS NMEFAN, ');
        qryTmp.SQL.Add('  EMP_C_G_C_ AS C_G_C_, ');
        qryTmp.SQL.Add('  EMP_I_E_S_ AS I_E_S_, ');
        qryTmp.SQL.Add('  EMP_INSMUN AS INSMUN, ');
        qryTmp.SQL.Add('  CONCAT(EMP_ENDERE, ", ", EMP_ENDNUM, ", ", EMP_BAIRRO, " - " , CE.CID_NOMCID, "/", CE.CID_ESTADO) AS ENDEMP, ');
        qryTmp.SQL.Add('  CE.CID_ESTADO AS ESTEMP, ');
        qryTmp.SQL.Add('  (SELECT CNS_SITE FROM NFCCNS WHERE CNS_UF = CE.CID_ESTADO LIMIT 1) AS LNKSIT, ');
        qryTmp.SQL.Add('  EMP_C_E_P_ AS CEPEMP, ');
        qryTmp.SQL.Add('  EMP_FONE01 AS TELEMP, ');
        qryTmp.SQL.Add('  EMP_FONE02 AS TELEM2, ');
        qryTmp.SQL.Add('  EMP_HOMEPA AS HOMEPA, ');
        qryTmp.SQL.Add('  0.00 AS IMPPAG, ');
        qryTmp.SQL.Add('  "" AS MEN001, ');
        qryTmp.SQL.Add('  "" AS MEN002, ');
        qryTmp.SQL.Add('  "" AS MEN003, ');
        qryTmp.SQL.Add('  "" AS MEN004, ');
        qryTmp.SQL.Add('  "" AS MEN005, ');
        qryTmp.SQL.Add('  FIS_FORCLI AS CODCLI, ');
        qryTmp.SQL.Add('  CLI_NOMCLI AS NOMCLI, ');
        qryTmp.SQL.Add('  "" AS CODVEN, ');
        qryTmp.SQL.Add('  "" AS CODDIG, ');
        qryTmp.SQL.Add('  "" AS NOMVEN, ');
        qryTmp.SQL.Add('  "" AS NOMDIG, ');

        qryTmp.SQL.Add('  CLI_C_G_C_ AS CGCCON, ');
        qryTmp.SQL.Add('  CLI_NOMCLI AS NOMCON, ');
        qryTmp.SQL.Add('  CLI_FANSOB AS NOMFAN, ');
        qryTmp.SQL.Add('  CLI_BAIRRO AS BAICON, ');
        qryTmp.SQL.Add('  CLI_C_E_P_ AS CEPCON, ');
        qryTmp.SQL.Add('  CLI_FONE01 AS TELCON, ');
        qryTmp.SQL.Add('  CLI_CELULA AS CELCON, ');
        qryTmp.SQL.Add('  CLI_I_E_S_ AS IESCON, ');
        qryTmp.SQL.Add('  CLI_ENDERE AS ENDERE, ');
        qryTmp.SQL.Add('  CLI_ENDNUM AS ENDNUM, ');
        qryTmp.SQL.Add('  CLI_ENDCOM AS ENDCOM, ');

        qryTmp.SQL.Add('  CC.CID_ESTADO AS ESTCON, ');
        qryTmp.SQL.Add('  CC.CID_NOMCID AS CIDCON, ');

        qryTmp.SQL.Add('  "" AS BAIENT, ');
        qryTmp.SQL.Add('  "" AS CEPENT, ');
        qryTmp.SQL.Add('  "" AS TELENT, ');
        qryTmp.SQL.Add('  "" AS ENDENT, ');
        qryTmp.SQL.Add('  "" AS CIDENT, ');
        qryTmp.SQL.Add('  "" AS SITUAC, ');
        qryTmp.SQL.Add('  "" AS CODREG, ');
        qryTmp.SQL.Add('  "" AS DESREG, ');

        qryTmp.SQL.Add('  0.00 AS TROCO_ , ');
        qryTmp.SQL.Add('  0.00 AS ESTIMP , ');
        qryTmp.SQL.Add('  0.00 AS MUNIMP , ');
        qryTmp.SQL.Add('  0.00 AS FEDIMP , ');
        qryTmp.SQL.Add('  "" AS DESMAR , ');
        qryTmp.SQL.Add('  "" AS CODFAB , ');
        qryTmp.SQL.Add('  0.00 AS DESACE, ');
        qryTmp.SQL.Add('  0.00 AS TOTFRE, ');
        qryTmp.SQL.Add('  0.00 AS TOTRET, ');
        qryTmp.SQL.Add('  0.00 AS TOTIPI, ');
        qryTmp.SQL.Add('  0.00 AS PESBRU, ');
        qryTmp.SQL.Add('  "" AS CODDIV, ');
        qryTmp.SQL.Add('  "" AS NOMDIV, ');
        qryTmp.SQL.Add('  "" AS NUMGUI, ');
        qryTmp.SQL.Add('  "" AS CODCXA, ');
        qryTmp.SQL.Add('  "" AS NOMCXA, ');
        qryTmp.SQL.Add('  "" AS OPECXA, ');
        qryTmp.SQL.Add('  "" AS CONPAG, ');
        qryTmp.SQL.Add('  "" AS CODCND, ');
        qryTmp.SQL.Add('  "" AS DESCND, ');
        qryTmp.SQL.Add('  "" AS TIPCND, ');
        qryTmp.SQL.Add('  IFNULL((SELECT ');
        qryTmp.SQL.Add('            SUM(IF(FID.FID_CREDEB = "C", FID.FID_QTDPTO, FID.FID_QTDPTO*-1)) ');
        qryTmp.SQL.Add('          FROM ');
        qryTmp.SQL.Add('            CLUFID FID ');
        qryTmp.SQL.Add('            JOIN CADCLI CLI ON CLI.CLI_CODCLI = FID.FID_CODCLI ');
        qryTmp.SQL.Add('          WHERE ');
        qryTmp.SQL.Add('            FID.FID_CODCLI = FIS_FORCLI ');
        qryTmp.SQL.Add('            AND FIS_TIP_FC = "C" ');
        qryTmp.SQL.Add('            AND FID.FID_CODEMP = FIS_CODEMP ');
        qryTmp.SQL.Add('            AND FID.FID_ESPDOC = FIS_ESPDOC ');
        qryTmp.SQL.Add('            AND FID.FID_NUMDOC = FIS_NUMDOC ');
        qryTmp.SQL.Add('            AND CLI.CLI_CLUFID = "S" ), 0) AS PTOVEN, ');
        qryTmp.SQL.Add('  IFNULL((SELECT ');
        qryTmp.SQL.Add('            SUM(IF(FID.FID_CREDEB = "C", FID.FID_QTDPTO, FID.FID_QTDPTO*-1)) ');
        qryTmp.SQL.Add('          FROM ');
        qryTmp.SQL.Add('            CLUFID FID ');
        qryTmp.SQL.Add('            JOIN CADCLI CLI ON CLI.CLI_CODCLI = FID.FID_CODCLI ');
        qryTmp.SQL.Add('          WHERE ');
        qryTmp.SQL.Add('            FID.FID_CODCLI = FIS_FORCLI ');
        qryTmp.SQL.Add('            AND FIS_TIP_FC = "C" ');
        qryTmp.SQL.Add('            AND FID.FID_DTACAD <= FIS_DTAENT ');
        qryTmp.SQL.Add('            AND CLI.CLI_CLUFID = "S" ');
        qryTmp.SQL.Add('            AND (NOT (FID.FID_CODEMP = FIS_CODEMP ');
        qryTmp.SQL.Add('                      AND FID.FID_ESPDOC = FIS_ESPDOC ');
        qryTmp.SQL.Add('                      AND FID.FID_NUMDOC = FIS_NUMDOC ');
        qryTmp.SQL.Add('                      AND FID.FID_CODCLI = FIS_FORCLI ');
        qryTmp.SQL.Add('                      AND FIS_TIP_FC = "C"))), 0) AS PTOANT, ');

        qryTmp.SQL.Add('(SELECT                         ');
        qryTmp.SQL.Add('   SUM(                         ');
        qryTmp.SQL.Add('     IF(                        ');
        qryTmp.SQL.Add('       FID_CREDEB = "C",        ');
        qryTmp.SQL.Add('       FID_QTDPTO,              ');
        qryTmp.SQL.Add('       - FID_QTDPTO             ');
        qryTmp.SQL.Add('     )                          ');
        qryTmp.SQL.Add('   ) AS PTOSLD                  ');
        qryTmp.SQL.Add(' FROM                           ');
        qryTmp.SQL.Add('   CLUFID                       ');
        qryTmp.SQL.Add(' WHERE FID_CODCLI = FIS_FORCLI  ');
        qryTmp.SQL.Add(' GROUP BY FID_CODCLI) AS PTOSLD, ');

        qryTmp.SQL.Add('  "" AS ENTRET, ');

        qryTmp.SQL.Add('  "" AS OPEEXP, ');
        qryTmp.SQL.Add('  "" AS NOMEXP, ');

        qryTmp.SQL.Add('  "" AS OPESEP, ');
        qryTmp.SQL.Add('  "" AS NOMSEP, ');
        qryTmp.SQL.Add('  "" AS NUMPED, ');
        qryTmp.SQL.Add('  "" AS NOTPAU, ');
        qryTmp.SQL.Add('  "" AS DET_CODVEN, ');
        qryTmp.SQL.Add('  "" AS DET_NOMVEN, ');
        qryTmp.SQL.Add('  "" AS NUMCUP,  ');
        qryTmp.SQL.Add('  0  AS QTDEMB,  ');
        qryTmp.SQL.Add('  0.00 AS DET_PERDES_NOV, ');
        qryTmp.SQL.Add('  -1 AS VIANFE, ');
        qryTmp.SQL.Add(' "N" AS TEMTIN, ');
        qryTmp.SQL.Add('  CAST("" AS CHAR(1)) AS OPCDOC, ');
        qryTmp.SQL.Add('  FIS_HISTOR AS HISTOR, ');
        qryTmp.SQL.Add('  "" AS CLAFIS, ');
        qryTmp.SQL.Add('  "" AS PROMOC, ');
        qryTmp.SQL.Add('  0 AS QTDPEC,  ');
        qryTmp.SQL.Add('  0 AS COMPEC,  ');
        qryTmp.SQL.Add('  0 AS LARPEC,  ');
        qryTmp.SQL.Add('  0 AS ESPPEC,  ');
        qryTmp.SQL.Add('  "" AS AUTCTT, ');
        qryTmp.SQL.Add('  "" AS DESAMZ, ');
        qryTmp.SQL.Add('  "" AS OPLBRC, ');
        qryTmp.SQL.Add('  "" AS NMLBRC, ');
        qryTmp.SQL.Add('  "" AS CODFPG, ');
        qryTmp.SQL.Add('  "" AS FN1VEN, ');
        qryTmp.SQL.Add('  "" AS FN2VEN, ');
        qryTmp.SQL.Add('  "" AS EMAVEN, ');
        qryTmp.SQL.Add('  "" AS CODCAX  ');
        qryTmp.SQL.Add('FROM CADFIS ');
        qryTmp.SQL.Add('  JOIN CADEMP ON EMP_CODEMP = FIS_CODEMP ');
        qryTmp.SQL.Add('  JOIN CADCID CE ON CE.CID_CODCID = EMP_CODCID ');
        qryTmp.SQL.Add('  LEFT JOIN CADCLI    ON    CLI_CODCLI = FIS_FORCLI ');
        qryTmp.SQL.Add('  LEFT JOIN CADCID CC ON CC.CID_CODCID = CLI_CODCID ');
        qryTmp.SQL.Add('  LEFT JOIN NOTCOM ON NOTCOM.GER_SEQGER = CADFIS.AUTOINCREM ');
        qryTmp.SQL.Add('WHERE ');
        qryTmp.SQL.Add('  FIS_ACESSO = :ACESSO AND ');
        qryTmp.SQL.Add('  FIS_CODEMP = :CODEMP     ');
      End
      Else
      Begin

        blnCodBar := (ConexaoBD.CarregarCFGSIS('CBCODE') = 'S');
        strPRSGCL := ConexaoBD.CarregarCFGSIS('PRSGCL');

        qryTmp.SQL.Clear;
        qryTmp.SQL.Add('SELECT ');
        qryTmp.SQL.Add('  DET_NUMDOC AS NUMDOC, ');
        qryTmp.SQL.Add('  DET_ESPDOC AS ESPDOC, ');
        qryTmp.SQL.Add('  DET_CODEMP AS CODEMP, ');
        qryTmp.SQL.Add('  DET_CODCLI AS CODCLI, ');
        qryTmp.SQL.Add('  DET_CODFOR AS CODFOR, ');
        qryTmp.SQL.Add('  DET_TIP_FC AS TIP_FC, ');
        qryTmp.SQL.Add('  DET_SERIE_ AS SERIE_, ');

        if (ConexaoBD.CarregarCFGSIS('NFEPRO') = 'S') then
          qryTmp.SQL.Add('  IF(DET_PROMOC = "S", CONCAT("*", DET_CODITE), DET_CODITE) AS CODITE, ')
        else
          qryTmp.SQL.Add('  DET_CODITE AS CODITE, ');

        If blnCodBar Then
        Begin
          strDesIteTemp := '  CONCAT(LEFT(DET_DESCRI,35), ' +
                           '    IF(IFNULL(' + SQL_MOVCDB_CODBAR + ',"") = "", ' +
                           '       IF(IFNULL(BAR_CODBAR,"") = "", "", CONCAT(" - Cod.Barra: ",BAR_CODBAR)), ' +
                           '       CONCAT(" - Cod.Barra: ",' + SQL_MOVCDB_CODBAR + ') ' +
                           '      ))';

          if (ConexaoBD.CarregarCFGSIS('NFCEMF') = 'S') then
            strDesIteTemp := '  IF(IFNULL(ITE_MENFIS, "") = "", ' + strDesIteTemp + ', CONCAT(CONCAT(' + strDesIteTemp + ', " - "), ITE_MENFIS))';

          if (ConexaoBD.CarregarCFGSIS('NFCLOT') = 'S') then
            strDesIteTemp := '  IF(IFNULL(DET_NUMLOT, "") = "", ' + strDesIteTemp + ', CONCAT(CONCAT(' + strDesIteTemp + ', " - LOTE: "), DET_NUMLOT))';

          strDesIteTemp := ' IF(MD.DET_APAREL = "S", CONCAT('+ strDesIteTemp +', " - APARELHADA"), '+ strDesIteTemp +')';

          qryTmp.SQL.Add(strDesIteTemp + ' AS DESITE, ');
        End
        Else
        begin
          strDesIteTemp := ' DET_DESCRI ';
          if (ConexaoBD.CarregarCFGSIS('NFCEMF') = 'S') then
            strDesIteTemp := '  IF(IFNULL(ITE_MENFIS, "") = "", ' + strDesIteTemp + ', CONCAT(CONCAT(' + strDesIteTemp + ', " - "), ITE_MENFIS))';

          if (ConexaoBD.CarregarCFGSIS('NFCLOT') = 'S') then
            strDesIteTemp := '  IF(IFNULL(DET_NUMLOT, "") = "", ' + strDesIteTemp + ', CONCAT(CONCAT(' + strDesIteTemp + ', " - LOTE: "), DET_NUMLOT))';

          strDesIteTemp := ' IF(MD.DET_APAREL = "S", CONCAT('+ strDesIteTemp +', " - APARELHADA"), '+ strDesIteTemp +')';

          qryTmp.SQL.Add(strDesIteTemp + ' AS DESITE, ');
        end;

        qryTmp.SQL.Add('  UNI_SIGUNI AS UNIDAD, ');
        qryTmp.SQL.Add('  DET_FORITE AS FORITE, ');
        If ConexaoBD.fTabelaExiste('CADLOT') Then
          qryTmp.SQL.Add('  IF(IFNULL(DET_NUMLOT, "") = "", ITE_LOCFIS, LOT_LOCFIS) AS LOCFIS, ')
        Else
          qryTmp.SQL.Add('  ITE_LOCFIS AS LOCFIS, ');
        qryTmp.SQL.Add('  UNI_PESLIT AS PESLIT, ');
        qryTmp.SQL.Add('  DET_DESCRI AS DESORI, ');
        qryTmp.SQL.Add('  MOVDET.AUTOINCREM AS DET_AUTOINCREM, ');

        If (blnCodBar) Then
        Begin
          qryTmp.SQL.Add('  SUM(DET_QTDITE) AS QTDITE, ');
          qryTmp.SQL.Add('  SUM(DET_QTDITE * DET_UNITAR) AS TOTITE, ');
          qryTmp.SQL.Add('  SUM(DET_IMPPAG) AS DET_IMPPAG, ');
        End
        Else
        Begin
          qryTmp.SQL.Add('  DET_QTDITE AS QTDITE, ');
          qryTmp.SQL.Add('  DET_TOTITE AS TOTITE, ');
          qryTmp.SQL.Add('  DET_IMPPAG, ');
        End;

        if (strPRSGCL='1') then //Vlr Líquido
        begin
          qryTmp.SQL.Add('  0.00       AS VLRDES, ');
          qryTmp.SQL.Add('  DET_TOTITE AS VLRTOT, ');
        end
        else                    //Vlr Bruto com Desconto
        begin
          qryTmp.SQL.Add('  (DET_QTDITE * (DET_UNIORI - DET_UNITAR)) AS VLRDES, ');
          qryTmp.SQL.Add('  (DET_QTDITE * DET_UNIORI)                AS VLRTOT, ');
        end;

        qryTmp.SQL.Add('  DET_UNITAR AS UNITAR, ');
        qryTmp.SQL.Add('  DET_UNIDIG AS UNIDIG, ');
        qryTmp.SQL.Add('  DET_UNIORI AS UNIORI, ');
        qryTmp.SQL.Add('  DET_NUMLOT AS NUMLOT, ');

        qryTmp.SQL.Add('  DET_TOTITE AS TOTITE, ');
        qryTmp.SQL.Add('  DET_DESESP, ');
        qryTmp.SQL.Add('  DET_TOTITE-DET_DESESP AS DET_TOTLIQ, ');
        qryTmp.SQL.Add('  GER_DESESP AS DESESP, ');
        qryTmp.SQL.Add('  GER_TOTPRO AS TOTPRO, ');
        qryTmp.SQL.Add('  GER_VLRCON AS VLRCON, ');
        qryTmp.SQL.Add('  DET_NUMDOC AS NUMDOC, ');
        qryTmp.SQL.Add('  DET_SERIE_ AS SERIE_, ');
        qryTmp.SQL.Add('  FIS_ACESSO AS ACESSO, ');
        qryTmp.SQL.Add('  LEFT(FIS_ACESSO, 22) AS ACESSO1, ');
        qryTmp.SQL.Add('  RIGHT(FIS_ACESSO, 22) AS ACESSO2, ');
        qryTmp.SQL.Add('  FIS_NUMSER AS NUMSER, ');
        qryTmp.SQL.Add('  FIS_NUMCOO AS NUMCOO, ');
        qryTmp.SQL.Add('  MOV_QRCODE AS QRCODE, ');
        qryTmp.SQL.Add('  MOV_PROTOC AS PROTOC, ');
        qryTmp.SQL.Add('  MOV_DPROTO AS DPROTO, ');
        qryTmp.SQL.Add('  MOV_OBSFIS AS OBSFIS, ');

        If ConexaoBD.fCampoExiste('MOVOBS', 'MOV_PRTMSG') Then
          qryTmp.SQL.Add('  MOV_PRTMSG AS PRTMSG, ')
        Else
          qryTmp.SQL.Add('  "" AS PRTMSG, ');

        qryTmp.SQL.Add('  DET_DTAENT AS DTAENT, ');
        qryTmp.SQL.Add('  DET_HORENT AS HORENT, ');
        qryTmp.SQL.Add('  DET_PROMOC, ');

        If (ConexaoBD.CarregarCFGSIS('RSNFNC') = 'F') Then
          qryTmp.SQL.Add('  EMP_NOMFAN AS NOMEMP, ')
        Else
          qryTmp.SQL.Add('  EMP_NOMEMP AS NOMEMP, ');

        qryTmp.SQL.Add('  EMP_NOMFAN AS NMEFAN, ');
        qryTmp.SQL.Add('  EMP_C_G_C_ AS C_G_C_, ');
        qryTmp.SQL.Add('  EMP_I_E_S_ AS I_E_S_, ');
        qryTmp.SQL.Add('  EMP_INSMUN AS INSMUN, ');
        qryTmp.SQL.Add('  CONCAT(EMP_ENDERE, ", ", EMP_ENDNUM, ", ", EMP_BAIRRO, " - " , CE.CID_NOMCID, "/", CE.CID_ESTADO) AS ENDEMP, ');
        qryTmp.SQL.Add('  CE.CID_ESTADO AS ESTEMP, ');
        qryTmp.SQL.Add('  (SELECT CNS_SITE FROM NFCCNS WHERE CNS_UF = CE.CID_ESTADO LIMIT 1) AS LNKSIT, ');
        qryTmp.SQL.Add('  EMP_C_E_P_ AS CEPEMP, ');
        qryTmp.SQL.Add('  EMP_FONE01 AS TELEMP, ');
        qryTmp.SQL.Add('  EMP_FONE02 AS TELEM2, ');
        qryTmp.SQL.Add('  EMP_HOMEPA AS HOMEPA, ');
        qryTmp.SQL.Add('  AUX_IMPPAG AS IMPPAG, ');
        qryTmp.SQL.Add('  GER_MEN001 AS MEN001, ');
        qryTmp.SQL.Add('  GER_MEN002 AS MEN002, ');
        qryTmp.SQL.Add('  GER_MEN003 AS MEN003, ');
        qryTmp.SQL.Add('  GER_MEN004 AS MEN004, ');
        qryTmp.SQL.Add('  GER_MEN005 AS MEN005, ');
        qryTmp.SQL.Add('  GER_CODCLI AS CODCLI, ');
        qryTmp.SQL.Add('  CLI_NOMCLI AS NOMCLI, ');
        qryTmp.SQL.Add('  GER_CODVEN AS CODVEN, ');
        qryTmp.SQL.Add('  IFNULL(GER_CODDIG, " ") AS CODDIG, ');

        If ConexaoBD.CarregarCFGSIS('AUTCEN') = 'S' Then
        Begin
          qryTmp.SQL.Add(' (SELECT ');
          qryTmp.SQL.Add('    GROUP_CONCAT(DISTINCT  "", CONCAT(DET_CODVEN, "-", OPE_NOMOPE)) AS NOME ');
          qryTmp.SQL.Add('  FROM   ');
          qryTmp.SQL.Add('    MOVDET D INNER JOIN CADOPE O ON D.DET_CODVEN = O.OPE_CODOPE ');
          qryTmp.SQL.Add('  WHERE  ');
          qryTmp.SQL.Add('    D.DET_SEQGER = MOVGER.AUTOINCREM) AS NOMVEN,     ');

          qryTmp.SQL.Add(' (SELECT ');
          qryTmp.SQL.Add('    GROUP_CONCAT(DISTINCT  "", CONCAT(DET_CODDIG, "-", OPE_NOMOPE)) AS NOME ');
          qryTmp.SQL.Add('  FROM   ');
          qryTmp.SQL.Add('    MOVDET D INNER JOIN CADOPE O ON D.DET_CODDIG = O.OPE_CODOPE ');
          qryTmp.SQL.Add('  WHERE  ');
          qryTmp.SQL.Add('    D.DET_SEQGER = MOVGER.AUTOINCREM) AS NOMDIG,     ');
        End
        Else
        Begin
          If ConexaoBD.CarregarCFGSIS('FANVEN') = 'S' Then
            qryTmp.SQL.Add('  VE.OPE_NOMFAN AS NOMVEN, ')
          else
            qryTmp.SQL.Add('  VE.OPE_NOMOPE AS NOMVEN, ');
          qryTmp.SQL.Add('  DI.OPE_NOMOPE AS NOMDIG, ');
        End;

        qryTmp.SQL.Add(fSQLIFClienteConsumidor('CLI_NOMCLI', 'GER_CGCCON', 'CLI_C_G_C_') + ' AS CGCCON, ');
        qryTmp.SQL.Add(fSQLIFClienteConsumidor('CLI_NOMCLI', 'GER_NOMCON', 'CLI_NOMCLI') + ' AS NOMCON, ');
        qryTmp.SQL.Add(fSQLIFClienteConsumidor('CLI_NOMCLI', 'GER_NOMCON', 'CLI_FANSOB') + ' AS NOMFAN, ');
        qryTmp.SQL.Add(fSQLIFClienteConsumidor('CLI_NOMCLI', 'GER_BAICON', 'CLI_BAIRRO') + ' AS BAICON, ');
        qryTmp.SQL.Add(fSQLIFClienteConsumidor('CLI_NOMCLI', 'GER_CEPCON', 'CLI_C_E_P_') + ' AS CEPCON, ');
        qryTmp.SQL.Add(fSQLIFClienteConsumidor('CLI_NOMCLI', 'GER_TELCON', 'CLI_FONE01') + ' AS TELCON, ');
        qryTmp.SQL.Add(fSQLIFClienteConsumidor('CLI_NOMCLI', fCampoCelCon, 'CLI_CELULA') + ' AS CELCON, ');
        qryTmp.SQL.Add(fSQLIFClienteConsumidor('CLI_NOMCLI', 'GER_IESCON', 'CLI_I_E_S_') + ' AS IESCON, ');
        qryTmp.SQL.Add(fSQLIFClienteConsumidor('CLI_NOMCLI', 'GER_ENDCON', 'CLI_ENDERE') + ' AS ENDERE, ');
        qryTmp.SQL.Add(fSQLIFClienteConsumidor('CLI_NOMCLI', '""',         'CLI_ENDNUM') + ' AS ENDNUM, ');
        qryTmp.SQL.Add(fSQLIFClienteConsumidor('CLI_NOMCLI', '""',         'CLI_ENDCOM') + ' AS ENDCOM, ');

        qryTmp.SQL.Add('  CC.CID_ESTADO AS ESTCON, ');
        qryTmp.SQL.Add('  CC.CID_NOMCID AS CIDCON, ');

        qryTmp.SQL.Add('  EE.ETC_BAIENT AS BAIENT, ');
        qryTmp.SQL.Add('  EE.ETC_CEPENT AS CEPENT, ');
        qryTmp.SQL.Add('  EE.ETC_TELENT AS TELENT, ');
        qryTmp.SQL.Add('  EE.ETC_ENDENT AS ENDENT, ');
        qryTmp.SQL.Add('  CE2.CID_NOMCID AS CIDENT, ');
        qryTmp.SQL.Add('  EE.ETC_SITUAC AS SITUAC, ');
        qryTmp.SQL.Add('  EE.ETC_CODREG AS CODREG, ');
        qryTmp.SQL.Add('  CR.REG_DESREG AS DESREG, ');

        qryTmp.SQL.Add('  AUX_TROCO_ AS TROCO_ , ');
        qryTmp.SQL.Add('  AUX_ESTIMP AS ESTIMP , ');
        qryTmp.SQL.Add('  AUX_MUNIMP AS MUNIMP , ');
        qryTmp.SQL.Add('  AUX_FEDIMP AS FEDIMP , ');
        qryTmp.SQL.Add('  MAR_DESMAR AS DESMAR , ');
        qryTmp.SQL.Add('  ITE_CODFAB AS CODFAB , ');

        qryTmp.SQL.Add('  GER_DESACE AS DESACE,   ');
        qryTmp.SQL.Add('  GER_TOTFRE AS TOTFRE,   ');
        qryTmp.SQL.Add('  GER_TOTRET AS TOTRET,   ');
        qryTmp.SQL.Add('  GER_TOTIPI AS TOTIPI,   ');

        qryTmp.SQL.Add('  DET_CODDIV AS CODDIV,   ');
        qryTmp.SQL.Add('  DIV_NOMDIV AS NOMDIV,   ');

        qryTmp.SQL.Add('  GER_PESBRU AS PESBRU,   ');

        qryTmp.SQL.Add('  AUX_NUMGUI AS NUMGUI,   ');

        qryTmp.SQL.Add('  OP.OPE_NOMOPE AS NOMCXA, ');
        qryTmp.SQL.Add('  OP.OPE_CODOPE AS OPECXA, ');
        qryTmp.SQL.Add('  GER_CONPAG AS CONPAG, ');
        qryTmp.SQL.Add('  GER_CODCND AS CODCND, ');
        qryTmp.SQL.Add('  CND_DESCRI AS DESCND, ');
        qryTmp.SQL.Add('  CND_TIPCND AS TIPCND, ');

        If ConexaoBD.fCampoExiste('CLUFID', 'FID_DTABAI') Then
        begin

          qryTmp.SQL.Add('  @PTOVEN := COALESCE((SELECT CLU2.FID_QTDPTO FROM CLUFID CLU2 ');
          qryTmp.SQL.Add('  JOIN CADCLI CLI2 ON CLI2.CLI_CODCLI = CLU2.FID_CODCLI ');
          qryTmp.SQL.Add('  WHERE CLU2.FID_CODCLI = MOVGER.GER_CODCLI ');
          qryTmp.SQL.Add('  AND   CLU2.FID_CODEMP = MOVGER.GER_CODEMP ');
          qryTmp.SQL.Add('  AND   CLU2.FID_ESPDOC = MOVGER.GER_ESPDOC ');
          qryTmp.SQL.Add('  AND   CLU2.FID_NUMDOC = MOVGER.GER_NUMDOC ');
          qryTmp.SQL.Add('  AND   CLU2.FID_CREDEB = "C" ');
          qryTmp.SQL.Add('  AND   CLI2.CLI_CLUFID = "S"  ');
          qryTmp.SQL.Add('  ),0)- ');
          qryTmp.SQL.Add('  COALESCE((SELECT CLU2.FID_QTDPTO FROM CLUFID CLU2 ');
          qryTmp.SQL.Add('  JOIN CADCLI CLI2 ON CLI2.CLI_CODCLI = CLU2.FID_CODCLI ');
          qryTmp.SQL.Add('  WHERE CLU2.FID_CODCLI = MOVGER.GER_CODCLI ');
          qryTmp.SQL.Add('  AND   CLU2.FID_CODEMP = MOVGER.GER_CODEMP ');
          qryTmp.SQL.Add('  AND   CLU2.FID_ESPDOC = MOVGER.GER_ESPDOC ');
          qryTmp.SQL.Add('  AND   CLU2.FID_NUMDOC = MOVGER.GER_NUMDOC ');
          qryTmp.SQL.Add('  AND   CLU2.FID_CREDEB = "D" ');
          qryTmp.SQL.Add('  AND   CLI2.CLI_CLUFID = "S"  ');
          qryTmp.SQL.Add('  ),0) AS PTOVEN, ');

          qryTmp.SQL.Add('  @PTOANT := COALESCE((SELECT SUM(IF(CLU1.FID_CREDEB = "C", CLU1.FID_QTDPTO, -CLU1.FID_QTDPTO)) FROM CLUFID CLU1 ');
          qryTmp.SQL.Add('  JOIN CADCLI CLI2 ON CLI2.CLI_CODCLI = CLU1.FID_CODCLI ');
          qryTmp.SQL.Add('  WHERE CLU1.FID_CODCLI = MOVGER.GER_CODCLI ');
          qryTmp.SQL.Add('  AND   CLU1.FID_DTACAD <= MOVGER.GER_DTAENT ');
          qryTmp.SQL.Add('  AND   CLI2.CLI_CLUFID = "S"  ');
          qryTmp.SQL.Add('  AND   CLU1.FID_DTABAI IS NULL ');
          qryTmp.SQL.Add('  AND   CLU1.FID_HRABAI IS NULL ');
          qryTmp.SQL.Add('  AND CLU1.AUTOINCREM <> CF.AUTOINCREM ');
          qryTmp.SQL.Add('  ),0) AS PTOANT,  ');

          qryTmp.SQL.Add(' (@PTOVEN + @PTOANT) AS PTOSLD, ');

        end
        else
        begin

          qryTmp.SQL.Add('  IFNULL((SELECT ');
          qryTmp.SQL.Add('            SUM(IF(FID.FID_CREDEB = "C", FID.FID_QTDPTO, FID.FID_QTDPTO*-1)) ');
          qryTmp.SQL.Add('          FROM ');
          qryTmp.SQL.Add('            CLUFID FID ');
          qryTmp.SQL.Add('            JOIN CADCLI CLI ON CLI.CLI_CODCLI = FID.FID_CODCLI ');
          qryTmp.SQL.Add('          WHERE ');
          qryTmp.SQL.Add('            FID.FID_CODCLI = GER_CODCLI ');
          qryTmp.SQL.Add('            AND FID.FID_CODEMP = GER_CODEMP ');
          qryTmp.SQL.Add('            AND FID.FID_ESPDOC = GER_ESPDOC ');
          qryTmp.SQL.Add('            AND FID.FID_NUMDOC = GER_NUMDOC ');
          qryTmp.SQL.Add('            AND CLI.CLI_CLUFID = "S" ), 0) AS PTOVEN, ');
          qryTmp.SQL.Add('  IFNULL((SELECT ');
          qryTmp.SQL.Add('            SUM(IF(FID.FID_CREDEB = "C", FID.FID_QTDPTO, FID.FID_QTDPTO*-1)) ');
          qryTmp.SQL.Add('          FROM ');
          qryTmp.SQL.Add('            CLUFID FID ');
          qryTmp.SQL.Add('            JOIN CADCLI CLI ON CLI.CLI_CODCLI = FID.FID_CODCLI ');
          qryTmp.SQL.Add('          WHERE ');
          qryTmp.SQL.Add('            FID.FID_CODCLI = GER_CODCLI ');
          qryTmp.SQL.Add('            AND FID.FID_DTACAD <= GER_DTAENT ');
          qryTmp.SQL.Add('            AND CLI.CLI_CLUFID = "S" ');
          qryTmp.SQL.Add('            AND (NOT (FID.FID_CODEMP = GER_CODEMP ');
          qryTmp.SQL.Add('                      AND FID.FID_ESPDOC = GER_ESPDOC ');
          qryTmp.SQL.Add('                      AND FID.FID_NUMDOC = GER_NUMDOC ');
          qryTmp.SQL.Add('                      AND FID.FID_CODCLI = GER_CODCLI))), 0) AS PTOANT, ');

          qryTmp.SQL.Add('(SELECT                         ');
          qryTmp.SQL.Add('   SUM(                         ');
          qryTmp.SQL.Add('     IF(                        ');
          qryTmp.SQL.Add('       FID_CREDEB = "C",        ');
          qryTmp.SQL.Add('       FID_QTDPTO,              ');
          qryTmp.SQL.Add('       - FID_QTDPTO             ');
          qryTmp.SQL.Add('     )                          ');
          qryTmp.SQL.Add('   ) AS PTOSLD                  ');
          qryTmp.SQL.Add(' FROM                           ');
          qryTmp.SQL.Add('   CLUFID                       ');
          qryTmp.SQL.Add(' WHERE FID_CODCLI = DET_CODCLI  ');
          qryTmp.SQL.Add(' GROUP BY FID_CODCLI) AS PTOSLD, ');

        end;

        qryTmp.SQL.Add('  IF(MOVGER.GER_ENTFUT = "S", "F", IF(MOVGER.GER_ENTFAT = "S", "E", "R")) AS ENTRET, ');

        qryTmp.SQL.Add('  GER_OPEEXP AS OPEEXP, ');
        qryTmp.SQL.Add('  OE.OPE_NOMOPE AS NOMEXP, ');

        qryTmp.SQL.Add('  GER_SEPEXP AS OPESEP, ');
        qryTmp.SQL.Add('  OS.OPE_NOMOPE AS NOMSEP, ');
        qryTmp.SQL.Add('  IF(MOVDET.DET_NUM_PD <> "", CONCAT(MOVDET.DET_NUM_PD, " - ", MOVDET.DET_ESP_PD), "") AS NUMPED, ');
        qryTmp.SQL.Add('  AUXMOV.AUX_NOTPAU AS NOTPAU, ');
        qryTmp.SQL.Add('  DET_CODVEN, ');
        qryTmp.SQL.Add('  (SELECT CONCAT(OPE_CODOPE,"-",OPE_NOMOPE) FROM CADOPE WHERE OPE_CODOPE = DET_CODVEN) AS DET_NOMVEN ');

        qryTmp.SQL.Add('  ,  CAST((SELECT GROUP_CONCAT(MCU_NUMCUP SEPARATOR ", ")      ');
        qryTmp.SQL.Add('          FROM MOVCUP                                          ');
        qryTmp.SQL.Add('        WHERE MCU_NUMDOC = DET_NUMDOC                          ');
        qryTmp.SQL.Add('          AND MCU_ESPDOC = DET_ESPDOC                          ');
        qryTmp.SQL.Add('          AND MCU_CODEMP = DET_CODEMP) AS CHAR(255)) AS NUMCUP ');

        qryTmp.SQL.Add('  ,IF(IFNULL(ITE_MLTVEN,0) > 1, IFNULL(DET_QTDITE,0) / IFNULL(ITE_MLTVEN,0), 0) AS QTDEMB ');

        If fTabelaExiste('DETANT') Then
          qryTmp.SQL.Add(' ,P.DET_PERDES_NOV ')
        Else
          qryTmp.SQL.Add(' ,0.00 AS DET_PERDES_NOV ');

        If fCampoExiste('LOGNFE', 'NFE_VIANFE') Then
          qryTmp.SQL.Add(' ,(SELECT COALESCE(NFE_VIANFE,-1) FROM LOGNFE WHERE LOGNFE.NFE_ACESSO = CADFIS.FIS_ACESSO LIMIT 1) AS VIANFE ')
        Else
          qryTmp.SQL.Add(' ,-1 AS VIANFE ');

        qryTmp.SQL.Add('   ,(SELECT IF(SUM(IF(SQYDET.DET_IDEPRO = "NOR", 0, 1)) = 0, "N", "S") FROM MOVDET SQYDET WHERE SQYDET.DET_SEQGER = MOVDET.DET_SEQGER) AS TEMTIN ');

        If fCampoExiste('AUXMOV', 'AUX_OPCDOC') Then
          qryTmp.SQL.Add(' ,(SELECT AUXMOV.AUX_OPCDOC FROM AUXMOV WHERE AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM LIMIT 1) AS OPCDOC ')
        Else
          qryTmp.SQL.Add(' ,CAST("" AS CHAR(1)) AS OPCDOC ');

        qryTmp.SQL.Add('   ,FIS_HISTOR AS HISTOR     ');
        qryTmp.SQL.Add('   ,GER_CLAFIS AS CLAFIS     ');
        qryTmp.SQL.Add('   ,DET_PROMOC AS PROMOC     ');
        qryTmp.SQL.Add('   ,MD.DET_QTDPEC AS QTDPEC  ');
        qryTmp.SQL.Add('   ,MD.DET_COMPEC AS COMPEC  ');
        qryTmp.SQL.Add('   ,MD.DET_LARPEC AS LARPEC  ');
        qryTmp.SQL.Add('   ,MD.DET_ESPPEC AS ESPPEC  ');
        qryTmp.SQL.Add('   ,(SELECT CONCAT( CLI_NOMCTT, "-", ' + fFormataFoneSQL('CLI_CELCTT', '', False) + ' ) ');
        qryTmp.SQL.Add('       FROM CLICTT                                                         ');
        qryTmp.SQL.Add('      WHERE AUTOINCREM = AUX_CLICTT) AS AUTCTT                             ');
        qryTmp.SQL.Add('   ,IFNULL(CADAMZ.AMZ_DESCRI, "") AS DESAMZ                                ');

        qryTmp.SQL.Add('   ,   GER_OPLBRC AS OPLBRC ');
        qryTmp.SQL.Add('   ,OC.OPE_NOMOPE AS NMLBRC ');
        qryTmp.SQL.Add('   ,MOVGER.GER_CODFPG AS CODFPG ');
        qryTmp.SQL.Add('   ,VE.OPE_FONE01 AS FN1VEN ');
        qryTmp.SQL.Add('   ,VE.OPE_FONE02 AS FN2VEN ');
        qryTmp.SQL.Add('   ,VE.OPE_E_MAIL AS EMAVEN ');

        If fTabelaExiste('MOVREF') Then
        Begin
          qryTmp.SQL.Add('   ,(SELECT SUM(REF_CBSVAL) FROM MOVREF WHERE MOVREF.REF_SEQGER = MOVDET.AUTOINCREM) AS CBSVAL ');
          qryTmp.SQL.Add('   ,(SELECT SUM(REF_IBSUFV) FROM MOVREF WHERE MOVREF.REF_SEQGER = MOVDET.AUTOINCREM) AS IBSUFV ');
          qryTmp.SQL.Add('   ,(SELECT SUM(REF_IBSMNV) FROM MOVREF WHERE MOVREF.REF_SEQGER = MOVDET.AUTOINCREM) AS IBSMNV ');
        End;

        If fCampoExiste('CADRCXX', 'RCX_CODCAX') Then
          qryTmp.SQL.Add('   ,RC.RCX_CODCAX AS CODCAX ')
        else
          qryTmp.SQL.Add('   ,CAST("" AS CHAR(1)) AS CODCAX ');

        qryTmp.SQL.Add('FROM ');
        qryTmp.SQL.Add('  MOVDET ');
        qryTmp.SQL.Add('  LEFT JOIN CADDIV ON MOVDET.DET_CODDIV = CADDIV.DIV_CODDIV ');
        qryTmp.SQL.Add('  JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ');
        qryTmp.SQL.Add('  JOIN MOVGER ON MOVGER.AUTOINCREM = MOVDET.DET_SEQGER ');
        qryTmp.SQL.Add('  JOIN CADUNI ON DET_UNIDAD = UNI_CODUNI ');

        qryTmp.SQL.Add('  JOIN ITEGER ON ITE_CODITE = DET_CODITE AND ');
        qryTmp.SQL.Add('                 ITE_CODEMP = DET_CODEMP ');

        qryTmp.SQL.Add('  JOIN CADITE I ON I.ITE_CODITE = DET_CODITE ');
        qryTmp.SQL.Add('  LEFT JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR ');

        qryTmp.SQL.Add('  JOIN CADFIS ON FIS_NUMDOC = DET_NUMDOC AND ');
        qryTmp.SQL.Add('                 FIS_ESPDOC = DET_ESPDOC AND ');
        qryTmp.SQL.Add('                 FIS_CODEMP = DET_CODEMP AND ');
        qryTmp.SQL.Add('                 FIS_FORCLI = DET_CODCLI AND ');
        qryTmp.SQL.Add('                 FIS_TIP_FC = DET_TIP_FC AND ');
        qryTmp.SQL.Add('                 IFNULL(FIS_SERIE_, "") = IFNULL(DET_SERIE_, "") ');

        If ConexaoBD.fTabelaExiste('CADLOT') Then
        Begin
          qryTmp.SQL.Add('LEFT JOIN CADLOT ON DET_NUMLOT = LOT_NUMLOT AND ');
          qryTmp.SQL.Add('                    DET_CODITE = LOT_CODITE AND ');
          qryTmp.SQL.Add('                    DET_CODEMP = LOT_CODEMP     ');
        End;

        qryTmp.SQL.Add('  LEFT JOIN CADAMZ ON (CADAMZ.AMZ_CODAMZ = DET_NUMLOT AND CADAMZ.AMZ_CODEMP = DET_CODEMP) ');

        qryTmp.SQL.Add('  LEFT JOIN MOVOBS ON MOV_SEQGER = MOVGER.AUTOINCREM ');
        qryTmp.SQL.Add('  JOIN CADEMP ON EMP_CODEMP = DET_CODEMP ');
        qryTmp.SQL.Add('  JOIN CADCID CE ON CE.CID_CODCID = EMP_CODCID ');

        qryTmp.SQL.Add('  LEFT JOIN CADOPE VE ON VE.OPE_CODOPE = GER_CODVEN ');
        qryTmp.SQL.Add('  LEFT JOIN CADOPE DI ON DI.OPE_CODOPE = GER_CODDIG ');
        qryTmp.SQL.Add('  LEFT JOIN CADCLI    ON    CLI_CODCLI = GER_CODCLI ');
        qryTmp.SQL.Add('  LEFT JOIN CADCID CC ON CC.CID_CODCID = GER_CIDCON ');
        qryTmp.SQL.Add('  LEFT JOIN AUXMOV    ON    AUX_SEQGER = MOVGER.AUTOINCREM ');

        qryTmp.SQL.Add('  LEFT JOIN CADRCXX RC ');
        qryTmp.SQL.Add('    ON RC.AUTOINCREM = (SELECT RC2.AUTOINCREM ');
        qryTmp.SQL.Add('                          FROM CADRCXX RC2 ');
        qryTmp.SQL.Add('                         WHERE RC2.RCX_NUMDOC = DET_NUMDOC ');
        qryTmp.SQL.Add('                           AND RC2.RCX_ESPDOC = DET_ESPDOC ');
        qryTmp.SQL.Add('                           AND RC2.RCX_CODEMP = DET_CODEMP ');
        qryTmp.SQL.Add('                           AND RC2.RCX_CODCLI = DET_CODCLI ');
        qryTmp.SQL.Add('                         ORDER BY RCX_DTACAD DESC ');
        qryTmp.SQL.Add('                         LIMIT 1) ');

        qryTmp.SQL.Add('  LEFT JOIN CADOPE OP ON OP.OPE_CODOPE = RC.RCX_CODOPE ');
        qryTmp.SQL.Add('  LEFT JOIN CADOPE OE ON OE.OPE_CODOPE = GER_OPEEXP ');

        If (ConexaoBD.fCampoExiste('MOVGER', 'GER_SEPEXP')) Then
          qryTmp.SQL.Add('  LEFT JOIN CADOPE OS ON OS.OPE_CODOPE = GER_SEPEXP ');

        If (blnCodBar) Then
        Begin
          qryTmp.SQL.Add('  LEFT JOIN ITEBAR    ON    BAR_CODITE = MOVDET.DET_CODITE ');
          qryTmp.SQL.Add('                     AND    BAR_PRINCI = 1                 ');
        End;

        qryTmp.SQL.Add('  LEFT JOIN CADCND ON CND_CODIGO = GER_CODCND ');

        qryTmp.SQL.Add('  LEFT JOIN ENTCLI EE ON EE.AUTOINCREM = AUXMOV.AUX_ENTGER ');
        qryTmp.SQL.Add('  LEFT JOIN CADCID CE2 ON CE2.CID_CODCID = EE.ETC_CIDENT ');
        qryTmp.SQL.Add('  LEFT JOIN CADREG CR ON CR.REG_CODREG = EE.ETC_CODREG ');

        qryTmp.SQL.Add('  LEFT JOIN MOVMAD MD ON MD.DET_SEQGER = MOVDET.AUTOINCREM ');
        qryTmp.SQL.Add('  LEFT JOIN CLUFID CF ON ');
        qryTmp.SQL.Add('        CF.FID_CODEMP = MOVGER.GER_CODEMP AND ');
        qryTmp.SQL.Add('        CF.FID_ESPDOC = MOVGER.GER_ESPDOC AND ');
        qryTmp.SQL.Add('        CF.FID_NUMDOC = MOVGER.GER_NUMDOC AND ');
        qryTmp.SQL.Add('        CF.FID_CODCLI = MOVGER.GER_CODCLI ');
        If fTabelaExiste('DETANT') Then
          qryTmp.SQL.Add(' LEFT JOIN DETANT P ON MOVDET.AUTOINCREM = P.AUTOINCREM ');
        If (ConexaoBD.fCampoExiste('MOVGER', 'GER_OPLBRC')) Then
          qryTmp.SQL.Add(' LEFT JOIN CADOPE OC ON OC.OPE_CODOPE = GER_OPLBRC ');
        qryTmp.SQL.Add('WHERE ');
        qryTmp.SQL.Add('  IFNULL(DET_PROEMB,"N") <> "S" AND ');

        If blnDesignReport Then
        Begin
          qryTmp.SQL.Add('  FIS_ESPDOC = "NF" AND ');
          qryTmp.SQL.Add('  FIS_CODEMP = :CODEMP  ');
          qryTmp.SQL.Add('LIMIT 1 ');
        End
        Else
        Begin
          qryTmp.SQL.Add('  FIS_ACESSO = :ACESSO AND ');
          qryTmp.SQL.Add('  FIS_CODEMP = :CODEMP     ');

          If (blnCodBar) Then
            qryTmp.SQL.Add('GROUP BY NUMDOC, SERIE_, CODITE, UNITAR, DESITE ');

          strOrdIte := ConexaoBD.CarregarCFGSIS('ORDALF');

          strSQLOriginal := qryTmp.SQL.Text ;

          strSQL := AnsiReplaceStr(
                    AnsiReplaceStr(
                    AnsiReplaceStr(
                    AnsiReplaceStr(
                    AnsiReplaceStr(
                    AnsiReplaceStr(
                    AnsiReplaceStr(
                    AnsiReplaceStr(
                    AnsiReplaceStr(
                    AnsiReplaceStr(qryTmp.SQL.Text, 'MOVGER', 'NOTGER'),
                                                    'MOVDET', 'NOTDET'),
                                                    'AUXMOV', 'AUXNOT'),
                                                    'MOVOBS', 'NOTOBS'),
                                                    'MOVTRI', 'NOTTRI'),
                                                    'MOVREF', 'NOTREF'),
                                                    'AUX_NUMGUI', ' "" '),
                                                    'GER_SEPEXP', ' "" '),
                                                    'GER_OPLBRC', ' "" '),
                                                    'OS.OPE_NOMOPE', ' "" ');

          qryTmp.SQL.Add(' UNION ALL ');
          qryTmp.SQL.Add(strSQL);
          strSQLOriginal := qryTmp.SQL.Text ;

          If blnPDF_Banco {$IF not Defined(LINUX)} Or blnNfceCancelada {$IFEND} Then
          Begin
            strSQL := AnsiReplaceStr(
                      AnsiReplaceStr(
                      AnsiReplaceStr(
                      AnsiReplaceStr(
                      AnsiReplaceStr(
                      AnsiReplaceStr(strSQLOriginal, 'MOVGER', 'DEL_MOVGER'),
                                                     'MOVDET', 'DEL_MOVDET'),
                                                     'AUXMOV', 'DEL_AUXMOV'),
                                                     'MOVOBS', 'DEL_MOVOBS'),
                                                     'MOVTRI', 'DEL_MOVTRI'),
                                                     'MOVREF', 'DEL_MOVREF');

            strSQL := AnsiReplaceStr(
                      AnsiReplaceStr(
                      AnsiReplaceStr(
                      AnsiReplaceStr(
                      AnsiReplaceStr(
                      AnsiReplaceStr(strSQL, 'NOTGER', 'DEL_NOTGER'),
                                             'NOTDET', 'DEL_NOTDET'),
                                             'AUXNOT', 'DEL_AUXNOT'),
                                             'NOTOBS', 'DEL_NOTOBS'),
                                             'NOTTRI', 'DEL_NOTTRI'),
                                             'NOTREF', 'DEL_NOTREF');

            qryTmp.SQL.Add(' UNION ALL ');
            qryTmp.SQL.Add(strSQL);
          End;

          If (strOrdIte = 'A') Then      // ORDEM (A)LFABÉTICA
            qryTmp.SQL.Add('  ORDER BY 9, 15 ')
          Else If (strOrdIte = 'C') Then // ORDEM (C)ÓDIGO DO ITEM
            qryTmp.SQL.Add('  ORDER BY 8, 15 ')
          Else If (strOrdIte = 'U') Then // ORDEM (U)NIDADE + DESCRIÇÃO
            qryTmp.SQL.Add('  ORDER BY 10, 9, 15 ')
          Else If (strOrdIte = 'F') Then // ORDEM (F)ORNECEDOR DO ITEM
            qryTmp.SQL.Add('  ORDER BY 11, 15 ')
          Else If (strOrdIte = 'L') Then // ORDEM (L)OCALIZACAO FISICA
            qryTmp.SQL.Add('  ORDER BY 12, 15 ')
          Else If (strOrdIte = 'P') Then // ORDEM (P)ESO UNIDADE + UNIDADE + DESCRIÇÃO DO PRODUTO
            qryTmp.SQL.Add('  ORDER BY 13, 15 ')
                                         // ORDEM (I)NCLUSÃO
        End;
      End;

     {$IFDEF LINUX}
      qryTmp.SQL.Text := qryTmp.SQL.Text.Replace(':ACESSO', '"'+ strChaveAcesso+'"');
      qryTmp.SQL.Text := qryTmp.SQL.Text.Replace(':CODEMP', '"'+ strCodigoEmpresa+'"');
     {$ELSE}
      If not blnDesignReport Then
        qryTmp.ParamByName('ACESSO').AsString := strChaveAcesso;
      qryTmp.ParamByName('CODEMP').AsString := strCodigoEmpresa;
     {$ENDIF}

      for I := 1 to 5 do
      begin
        pLogImp('TImpressaoNFCe.Imprimir (qryTmp.Open) T' + IntToStr(I));
        qryTmp.Close;
        qryTmp.Open;

        if (not qryTmp.IsEmpty) and (qryTmp.FieldByName('DPROTO').AsDateTime > 0) then
          Break;

        if blnNfceDin then
          Break;

        Sleep(1000);
      end;

      If (not qryTmp.IsEmpty) Or blnNfceDin Then
      Begin
        If blnDesignReport Then
        Begin
          blnUsaSat        := (strModelo = 'SAT');
          strChaveAcesso   := qryTmp.FieldByName('ACESSO').AsString ;
          strCodigoEmpresa := qryTmp.FieldByName('CODEMP').AsString ;

          frxDesigner := TfrxDesigner.Create(nil);
          frxDesigner.Restrictions := [drDontDeletePage,
                                       drDontCreatePage,
                                       drDontChangePageOptions,
                                       drDontCreateReport,
                                       drDontEditVariables,
                                       drDontEditReportData,
                                       drDontShowRecentFiles,
                                       drDontEditReportScript,
                                       drDontEditInternalDatasets];
          frxDesigner.Standalone := True;
          frxDesigner.OnSaveReport := frxDesignerSaveReport;

        End;

        ConexaoBD.pCarregaModalidadesPagamento(qryTmp.FieldByName('VLRCON').AsFloat,
                                               qryTmp.FieldByName('NUMDOC').AsString,
                                               qryTmp.FieldByName('ESPDOC').AsString,
                                               qryTmp.FieldByName('CODEMP').AsString,
                                               qryTmp.FieldByName('CODCLI').AsString,
                                               qryTmp.FieldByName('SERIE_').AsString, strModalidades, strValores, strCarConPag, strParcelasCartao, strDescrCartao);

        strIdePro := '';
        If (qryTmp.FieldByName('TEMTIN').AsString = 'S') Then
          strIdePro := 'NÃO TROCAMOS TINTA DE MÁQUINA.';

        If (ConexaoBD.CarregarCFGSIS('UTINPS')='S') And (qryTmp.FieldByName('TIP_FC').AsString = 'C') Then
          fGanhouNetpoints(qryTmp.FieldByName('NUMDOC').AsString,
                           qryTmp.FieldByName('ESPDOC').AsString,
                           qryTmp.FieldByName('CODEMP').AsString,
                           qryTmp.FieldByName('CODCLI').AsString,
                           qryTmp.FieldByName('SERIE_').AsString,
                           intQtdNps)
          Else
            intQtdNps := 0;

        pNfeInfAdicDocumentosCreditoUsados( qryTmp.FieldByName('NUMDOC').AsString,
                                            qryTmp.FieldByName('ESPDOC').AsString,
                                            qryTmp.FieldByName('CODEMP').AsString,
                                            qryTmp.FieldByName('CODCLI').AsString,
                                            strDocumentosCreditoUsados);

        pNfeInfAdicSaldoCreditoDoCliente( qryTmp.FieldByName('CODEMP').AsString,
                                          qryTmp.FieldByName('CODCLI').AsString,
                                          strSaldoCreditoDoCliente);

        pQuantidadeDeSelos( qryTmp.FieldByName('NUMDOC').AsString,
                            qryTmp.FieldByName('ESPDOC').AsString,
                            qryTmp.FieldByName('CODEMP').AsString,
                            qryTmp.FieldByName('CODCLI').AsString,
                            intQtdSelos );

        pValorCashBack( qryTmp.FieldByName('NUMDOC').AsString,
                        qryTmp.FieldByName('ESPDOC').AsString,
                        qryTmp.FieldByName('CODEMP').AsString,
                        qryTmp.FieldByName('CODCLI').AsString,
                        fltCashBack );

        If blnUsaSat Then
        begin
         {$IF not Defined(LINUX)}
          If FModoTeste <> '' Then
            FResultadoTeste.Add('Documento SAT (CF-e): a rotina dinamica da NFC-e nao se aplica.')
          Else
         {$IFEND}
            pDanfeSat
        end
        else
        begin
          ConexaoBD.FLayoutDinamico := blnNfceDin;
          Try
            ConexaoBD.CarregarConfiguracao(strChaveAcesso, strCodigoEmpresa, 'NFCE', 4.00,
                                           qryTmp.FieldByName('HISTOR').AsString,
                                           qryTmp.FieldByName('CLAFIS').AsString);
          Finally
            ConexaoBD.FLayoutDinamico := False;
          End;

          if ConexaoBD.fDocumentoEmitidoSmartPOS(strChaveAcesso, qryTmp.FieldByName('OPCDOC').AsString) then
          begin
            if blnReimpressao then
              pDanfeNFCeDin(strPRSGCL)
            else if blnPDF_Apresentar then
              pDanfeNFCeDin(strPRSGCL)
            else if fEmptyStr(ConexaoBD.FConfiguracao.LayoutSmartPOS) then
              pDanfeNFCeDin(strPRSGCL)
            else
            begin
              // Smart POS (58 mm): sempre a rotina antiga
              blnNfceDin := False;
             {$IF not Defined(LINUX)}
              // teste do editor nunca imprime
              If FModoTeste <> '' Then
                FResultadoTeste.Add('Documento Smart POS (58 mm): a rotina dinamica da NFC-e nao se aplica.')
              Else
             {$IFEND}
                pDanfeNFCe58MM(strPRSGCL);
            end;
          end
          else
            pDanfeNFCeDin(strPRSGCL);
        end;

      End;

    Finally
     {$IF not Defined(LINUX)}
      FreeAndNil(lstFotoNova);
      FreeAndNil(objNfceDin);
      FreeAndNil(entNfceDin);
     {$IFEND}
      FreeAndNil(qryTmp);
      FreeAndNil(frxDesigner);
    End;

  Except
    On E : Exception do
    Begin
    {$IF Defined(LINUX)}
      Writeln('Erro [ImpressaoNFCe.Imprimir]: ' + E.Message);
    {$ELSE}
      pLogImp(E.Message);
      ShowErrorMsgTimeout(E.ClassName, 'Erro [ImpressaoNFCe.Imprimir]: ' + E.Message, 10000);
    {$IFEND}
    End;
  End;

End;

function TImpressaoNFCe.frxDanfeUserFunction(const MethodName: string;
  var Params: Variant): Variant;
begin
  Result := Null;
  If AnsiUpperCase(MethodName) = AnsiUpperCase('fNumeroDoItem') Then
  Begin
    Result := fNumeroDoItem;
  End
  Else If AnsiUpperCase(MethodName) = AnsiUpperCase('fArredondaUnit') Then
  Begin
    Result := fArredondaUnit(Params[0]);
  End;
end;

procedure TImpressaoNFCe.pConfigurarLogotipoDanfce;
var
{$IF Defined(LINUX)}
  imgLogotipo : FMX.Graphics.TBitmap;
{$ELSE}
  imgLogotipo : TPicture;
{$IFEND}
  vStreamLogotipo : TMemoryStream;
begin
  if Assigned(TfrxChild(frxDanfe.FindObject('ChdLogo'))) Then
    TfrxChild(frxDanfe.FindObject('ChdLogo')).Visible := False;
  if NaoEstaVazio(ConexaoBD.FConfiguracao.Logo) then
  begin
    if Assigned(frxDanfe.FindObject('rllImagem')) then
    begin
    {$IF Defined(LINUX)}
      imgLogotipo := FMX.Graphics.TBitmap.Create;
    {$ELSE}
      imgLogotipo := TPicture.Create;
    {$IFEND}
      vStreamLogotipo := TMemoryStream.Create;
      try
        ConverterBase64ParaImagem(ConexaoBD.FConfiguracao.Logo, imgLogotipo);
      {$IF Defined(LINUX)}
        imgLogotipo.SaveToStream(vStreamLogotipo);
      {$ELSE}
        imgLogotipo.Bitmap.SaveToStream(vStreamLogotipo);
      {$IFEND}
        vStreamLogotipo.position := 0;
      {$IF Defined(LINUX)}
        TfrxPictureView(frxDanfe.FindObject('rllImagem')).Picture.LoadFromStream(vStreamLogotipo);
      {$ELSE}
        TfrxPictureView(frxDanfe.FindObject('rllImagem')).LoadPictureFromStream(vStreamLogotipo);
      {$IFEND}
        TfrxChild(frxDanfe.FindObject('ChdLogo')).Visible := True;
      finally
        freeandnil(imgLogotipo);
        freeandnil(vStreamLogotipo);
      end;
    end;
  end;
end;

end.
