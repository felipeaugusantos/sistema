unit untSeparacaoPedidoEstrutura;

interface

uses
  System.SysUtils, System.Classes, untZClient, Forms, frxClass, frxDBSet,
  cxProgressBar, Data.DB;

type
  TfrmSeparacaoPedidoEstrutura = class(TForm)
    frxReport: TfrxReport;
    frxRelatorio: TfrxDBDataset;
    function frxReportUserFunction(const MethodName: string;
      var Params: Variant): Variant;
  private
    cdsRelatorio : TZClient;
    function fGetSql(strNomArq : String) : String;
    function fCalculaSaldoDisponivel(cxProgressBar : TcxProgressBar) : Boolean;
    function fImpressaoSeparacaoPorSetor: Boolean;
    function fGetCamposImpressaoSeparacaoPorSetor: String;
    function fGetJoinImpressaoSeparacaoPorSetor: String;
  public
    class function fTemFR3 : Boolean;
    class procedure pImprime(strNomArq, strNumDoc, strEspDoc, strCodCli, strCodEmp : String);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses untFuncoesSimples, untGravando, untIFatReservaSaldo, untTFatReservaSaldo;

{$R *.dfm}

{ TfrmSeparacaoPedidoEstrutura }

class procedure TfrmSeparacaoPedidoEstrutura.pImprime(strNomArq, strNumDoc, strEspDoc, strCodCli, strCodEmp:String);
  var
    frmSeparacaoPedidoEstrutura: TfrmSeparacaoPedidoEstrutura;
begin
  Try
    pCriarFormularios(TfrmSeparacaoPedidoEstrutura, frmSeparacaoPedidoEstrutura);
    With frmSeparacaoPedidoEstrutura Do
    Begin
      cdsRelatorio := TZClient.Create(frmSeparacaoPedidoEstrutura, fGetSql(strNomArq) );
      cdsRelatorio.qryQuery.ParamByName('NUMDOC').AsString := strNumDoc;
      cdsRelatorio.qryQuery.ParamByName('ESPDOC').AsString := strEspDoc;
      cdsRelatorio.qryQuery.ParamByName('CODEMP').AsString := strCodEmp;
      cdsRelatorio.qryQuery.ParamByName('CODCLI').AsString := strCodCli;
      cdsRelatorio.fAbreClient(True, 'TfrmSeparacaoPedidoEstrutura.pImprime');

      if cdsRelatorio.IsEmpty Then
        Exit;

      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.fExecutarAcao := fCalculaSaldoDisponivel;
      frmGravando.lblGravando.Caption := 'Calculando saldos...';
      frmGravando.ShowModal;
      FreeAndNil(frmGravando);

      frxReport.LoadFromFile( ExtractFilePath(Application.ExeName) + 'separacao.fr3' );

      frxRelatorio.DataSet := cdsRelatorio;

      TfrxGroupHeader(frxReport.FindObject('grhSetor')).Visible     := fImpressaoSeparacaoPorSetor;
      TfrxGroupHeader(frxReport.FindObject('grfSetor')).Visible     := fImpressaoSeparacaoPorSetor;
      TfrxReportSummary(frxReport.FindObject('rpsSumario')).Visible := Not fImpressaoSeparacaoPorSetor;

      If Not fImpressaoSeparacaoPorSetor Then
        TfrxGroupHeader(frxReport.FindObject('grhSetor')).Condition := 'False';

      If FileExists( fCfgSis('PATLOG',varString) ) Then
        TfrxPictureView( frxReport.FindObject('imgLogo') ).Picture.LoadFromFile( fCfgSis('PATLOG',varString) );

      frxReport.AddFunction('function fFormataCEP(strCEP: String): String;');
      frxReport.AddFunction('function fTime(AForceTime: Boolean) : TDateTime');

      If frxReport.PrepareReport Then
        pPreviewReport('frmSeparacaoPedidoEstrutura', 'Separação de Pedido Estrutura', frxReport);

    End;
  Finally
    FreeAndNil(frmSeparacaoPedidoEstrutura);
  End;

end;

function TfrmSeparacaoPedidoEstrutura.fCalculaSaldoDisponivel(
  cxProgressBar: TcxProgressBar): Boolean;
begin
  Try
    With cdsRelatorio Do
    Begin
      cxProgressBar.Properties.Max := RecordCount;
      DisableControls;
      First;
      While Not Eof Do
      Begin
        Edit;
        FieldByName('SALGER').AsFloat := FieldByName('SALGER').AsFloat  - TSaldoReservado.New(
                                                                            TReservaParametros.New()
                                                                              .EmpresaItem(FieldByName('FDO_CODEMP').AsString)
                                                                              .CodigoItem(FieldByName('CODGER').AsString)
                                                                              .CodEmpresa(FieldByName('FDO_CODEMP').AsString)
                                                                            ).fGetQuantidade();

        FieldByName('SALDET').AsFloat := FieldByName('SALDET').AsFloat  - TSaldoReservado.New(
                                                                            TReservaParametros.New()
                                                                              .EmpresaItem(FieldByName('FDO_CODEMP').AsString)
                                                                              .CodigoItem(FieldByName('CODDET').AsString)
                                                                              .CodEmpresa(FieldByName('FDO_CODEMP').AsString)
                                                                            ).fGetQuantidade();

        Post;

        cxProgressBar.Position := RecNo;
        Next;

        If (RecNo Mod 5) = 0 Then
          Application.ProcessMessages;

      End;
    End;

    Result := True;
  Finally
    cdsRelatorio.First;
    cdsRelatorio.EnableControls;
  End;
end;

function TfrmSeparacaoPedidoEstrutura.fGetCamposImpressaoSeparacaoPorSetor: String;
begin
  Result := ' , ';
  if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
    Result := Result  + 'IF(IFNULL(FDO_NUMLOT, "") = "", LS2.LSE_DESCRI, LS1.LSE_DESCRI) AS SETOR_ '
  else
  If fCfgSis('GRUSEP', varString) = 'S' Then
    Result := Result  + ' LSE_DESCRI AS SETOR_ '
  Else
    Result := Result  + ' F.ITE_LOCFIS AS SETOR_ ';
end;

function TfrmSeparacaoPedidoEstrutura.fGetJoinImpressaoSeparacaoPorSetor: String;
begin
  Result := '';
  if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
  begin
    Result := Result + ' LEFT JOIN CADLOT LT ON LT.LOT_CODITE = FDO_CODITE AND LT.LOT_CODEMP = FDO_CODEMP AND LT.LOT_NUMLOT = FDO_NUMLOT ';
    Result := Result + ' LEFT JOIN CADLOC CL1 ON CL1.LOC_CODLOC = LT.LOT_LOCFIS AND CL1.LOC_CODEMP = LT.LOT_CODEMP ';
    Result := Result + ' LEFT JOIN CADLOC CL2 ON CL2.LOC_CODLOC = F.ITE_LOCFIS AND CL2.LOC_CODEMP = F.ITE_CODEMP ';
    Result := Result + ' LEFT JOIN CADLSE LS1 ON LS1.LSE_CODIGO = CL1.LOC_CODLSE ';
    Result := Result + ' LEFT JOIN CADLSE LS2 ON LS2.LSE_CODIGO = CL2.LOC_CODLSE ';
  end
  else
  if (fCfgSis('GRUSEP', varString) = 'S') Then
    Result := Result + ' LEFT  JOIN CADLSE ON LSE_CODIGO = F.ITE_CODLSE ';
end;

function TfrmSeparacaoPedidoEstrutura.fGetSql(strNomArq : String): String;
begin
  Result := '';

  Result := Result + ' SELECT SQL_NO_CACHE                                   ';
  Result := Result + '        FDO_NUMDOC,                                    ';
  Result := Result + '        FDO_ESPDOC,                                    ';
  Result := Result + '        FDO_CODEMP,                                    ';
  Result := Result + '        CND_DESCRI,                                    ';
  Result := Result + '        CLI_CODCLI,                                    ';
  Result := Result + '        CLI_NOMCLI,                                    ';
  Result := Result + '        CLI_ENDERE,                                    ';
  Result := Result + '        CLI_ENDNUM,                                    ';
  Result := Result + '        CLI_BAIRRO,                                    ';
  Result := Result + '        CLI_ENDCOM,                                    ';
  Result := Result + '        CLI_C_E_P_,                                    ';
  Result := Result + '        CID_NOMCID,                                    ';
  Result := Result + '        CID_ESTADO,                                    ';
  Result := Result + '        CLI_MARCA_,                                    ';
  Result := Result + '        FGO_CODTRA,                                    ';
  Result := Result + '        TRA_NOMTRA,                                    ';

  Result := Result + '        FGO_MEN001,                                    ';
  Result := Result + '        FGO_MEN002,                                    ';
  Result := Result + '        FGO_MEN003,                                    ';
  Result := Result + '        FGO_MEN004,                                    ';
  Result := Result + '        FGO_MEN005,                                    ';
  Result := Result + '        FGO_MENEXP,                                    ';
  Result := Result + '        FGO_MENEX2,                                    ';
  Result := Result + '        FGO_MENEX3,                                    ';
  Result := Result + '        FGO_MENEX4,                                    ';

  Result := Result + '      IFNULL( M.AUTOINCREM, CONCAT("FATDOR",D.AUTOINCREM)) AS AUTOINCREM, ';
  Result := Result + fSQLBarDoc('FDO') + ' AS BARDOC,                        ';

  Result := Result + '      FGO_DTENTR,                                      ';
  Result := Result + '      FDO_QTDITE - IFNULL(FDO_QTDBAI,0) AS QTDGER,     ';
  Result := Result + '      I.ITE_CODITE AS CODGER,                          ';
  Result := Result + '      I.ITE_CODFAB AS FABGER,                          ';
  Result := Result + '      I.ITE_DESITE AS DESGER,                          ';
  Result := Result + '      F.ITE_LOCFIS AS LOCGER,                          ';
  Result := Result + '      F.ITE_LOCSEP AS LOCSEP,                          ';
  Result := Result + '      F.ITE_SALDOS AS SALGER,                          ';
  Result := Result + '      U.UNI_DESUNI AS DEUGER,                          ';
  Result := Result + '      U.UNI_SIGUNI AS SGUGER,                          ';

  Result := Result + '     (FDO_QTDITE - IFNULL(FDO_QTDBAI,0)) * DMT_QTDITE AS QTDDET, ';
  Result := Result + '     I2.ITE_CODITE AS CODDET,                          ';
  Result := Result + '     I2.ITE_CODFAB AS FABDET,                          ';
  Result := Result + '     I2.ITE_DESITE AS DESDET,                          ';
  Result := Result + '     F2.ITE_LOCFIS AS LOCDET,                          ';
  Result := Result + '     F2.ITE_SALDOS AS SALDET,                          ';
  Result := Result + '      U.UNI_DESUNI AS DEUDET,                          ';
  Result := Result + '      U.UNI_SIGUNI AS SGUDET                           ';

  if fImpressaoSeparacaoPorSetor Then
    Result := Result + fGetCamposImpressaoSeparacaoPorSetor;

  Result := Result + ' FROM ' + strNomArq + ' D ';
  Result := Result + ' INNER JOIN FATGOR G ON G.AUTOINCREM = FDO_SEQGER      ';
  Result := Result + ' INNER JOIN CADCLI C ON C.CLI_CODCLI = FDO_CODCLI      ';
  Result := Result + ' INNER JOIN CADCID E ON E.CID_CODCID = CLI_CODCID      ';
  Result := Result + ' INNER JOIN CADTRA T ON T.TRA_CODTRA = FGO_CODTRA      ';
  Result := Result + ' LEFT  JOIN CADCND A ON CND_CODIGO = FGO_CODCND        ';
  Result := Result + ' INNER JOIN CADITE I ON I.ITE_CODITE = FDO_CODITE      ';
  Result := Result + ' LEFT  JOIN CADUNI U ON U.UNI_CODUNI = I.ITE_CODUNI    ';
  Result := Result + ' INNER JOIN ITEGER F ON F.ITE_CODITE = FDO_CODITE      ';
  Result := Result + '                    AND F.ITE_CODEMP = FDO_CODEMP      ';

  Result := Result + ' LEFT  JOIN GERMAT M ON M.GMT_CODITE = FDO_CODITE      ';
  Result := Result + ' LEFT  JOIN DETMAT H ON H.DMT_SEQGER = M.AUTOINCREM    ';

  Result := Result + ' LEFT  JOIN CADITE I2 ON I2.ITE_CODITE = DMT_ITESUB    ';
  Result := Result + ' LEFT  JOIN ITEGER F2 ON F2.ITE_CODITE = I2.ITE_CODITE ';
  Result := Result + '                     AND F2.ITE_CODEMP = FDO_CODEMP    ';
  Result := Result + ' LEFT  JOIN CADUNI U2 ON U2.UNI_CODUNI = I2.ITE_CODUNI    ';

  if fImpressaoSeparacaoPorSetor then
    Result := Result + fGetJoinImpressaoSeparacaoPorSetor;

  Result := Result + ' WHERE FDO_NUMDOC = :NUMDOC                            ';
  Result := Result + '   AND FDO_ESPDOC = :ESPDOC                            ';
  Result := Result + '   AND FDO_CODEMP = :CODEMP                            ';
  Result := Result + '   AND FDO_CODCLI = :CODCLI                            ';
  Result := Result + '   AND FDO_QTDITE - IFNULL(FDO_QTDBAI,0) > 0           ';
  if fImpressaoSeparacaoPorSetor Then
    Result := Result + ' ORDER BY SETOR_, FABGER, LOCGER, AUTOINCREM, FABDET'
  Else
    Result := Result + ' ORDER BY LOCGER, FABGER, AUTOINCREM, FABDET '
end;

class function TfrmSeparacaoPedidoEstrutura.fTemFR3: Boolean;
begin
  Result := FileExists( ExtractFilePath(Application.ExeName) + 'separacao.fr3' );
end;

function TfrmSeparacaoPedidoEstrutura.fImpressaoSeparacaoPorSetor: Boolean;
begin
  Result := fCfgSis('EXPSET', varBoolean) And
            fCfgSis('SEPSET', varBoolean) And
//            (Not fCfgSis('SEPGER', VarBoolean)) And
            (Pos(VS_strTipExp, '2_3_4_') > 0);
end;


function TfrmSeparacaoPedidoEstrutura.frxReportUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If MethodName = 'FFORMATACEP' Then
    Result := fFormataCEP(Params[0])
  Else If (SameText(MethodName, 'fTime')) Then
    Result := fTime(Params[0]);
end;

end.
