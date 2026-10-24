unit untImpressaoCTe;

interface

uses
{$IF Defined(LINUX)}
  Uni,
  FMX.frxClass, FMX.frxDBSet, FMX.frxDesgn, FMX.frxExportPDF,
  FMX.frxBarcode, FMX.frxDelphiZXingQRCode, FMX.Graphics,
  FMX.Objects, FMX.Forms, NFe.Modulo,
{$ELSE}
  Windows, Messages,Graphics,
  Controls, Forms, frxClass, ComCtrls, StdCtrls, ExtCtrls,
  {$IF Defined(UNIDAC)}
    UniClientDataSet, Uni, MySQLUniProvider, UniProvider,
  {$ELSE}
   ZConnection, ZDataset, ZDbcIntfs,
  {$IFEND}
  DBCtrls, MemDS, Dialogs,
  {$IFDEF VER300}
    System.UITypes,
  {$ENDIF}
  untModulo, frxBarcode, frxDBSet, frxDelphiZXingQRCode, frxDesgn,
{$IFEND}
   StrUtils, SysUtils, Variants, Classes, DB, untConexaoBD, untUtil;

type
  TImpressaoCTe = class
  private
    ConexaoBD : TConexaoBD;
    frxDanfe: TfrxReport;
    frxDbDanfe: TfrxDBDataset;

    procedure pDanfeCTe(strCodigoEmpresa, strNumeroConhecimento, strImpressora : string; blnDesignReport: Boolean=False);
  public
    dtsConf: TDataSource;
    constructor Create();
    destructor Destroy; override;
    procedure Imprimir(strCodEmp, strNumCte, strImpressora: string; blnDesignReport: boolean=False);
  end;

Var
  qryTmpCab: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};

implementation

uses
{$IF Defined(LINUX)}
{$ELSE}
  {$IF Defined(UNIDAC)} untModuloReplicacao, Vcl.Printers {$ELSE} untModuloReplicacaoZeos {$IFEND},
{$IFEND}
  untConfImpressora;

{ TImpressaoCTe }

constructor TImpressaoCTe.Create;
begin
  ConexaoBD := TConexaoBD.Create(frmModulo.Database);
end;

destructor TImpressaoCTe.Destroy;
begin
  ConexaoBD.Free();
end;

procedure TImpressaoCTe.Imprimir(strCodEmp, strNumCte, strImpressora: string; blnDesignReport: boolean=False);
begin

  Try
    qryTmpCab := fCriaQuery(nil);

    Try

      qryTmpCab.SQL.Clear;
      qryTmpCab.SQL.Add('SELECT ');
      qryTmpCab.SQL.Add('  T.CTE_NUMCTE, ');
      qryTmpCab.SQL.Add('  T.CTE_SERIE_, ');
      qryTmpCab.SQL.Add('  T.CTE_CODMOD, ');
      qryTmpCab.SQL.Add('  T.CTE_ACESSO, ');
      qryTmpCab.SQL.Add('  T.CTE_PROTOC, ');
      qryTmpCab.SQL.Add('  T.CTE_DTAHOR, ');
      qryTmpCab.SQL.Add('  T.CTE_CFOP__, ');
      qryTmpCab.SQL.Add('  T.CTE_NATOPE, ');
      qryTmpCab.SQL.Add('  E.EMP_NOMEMP, ');
      qryTmpCab.SQL.Add('  E.EMP_NOMFAN, ');
      qryTmpCab.SQL.Add('  E.EMP_ENDERE, ');
      qryTmpCab.SQL.Add('  E.EMP_ENDNUM, ');
      qryTmpCab.SQL.Add('  E.EMP_BAIRRO, ');
      qryTmpCab.SQL.Add('  E.EMP_I_E_S_, ');
      qryTmpCab.SQL.Add('  E.EMP_C_G_C_, ');
      qryTmpCab.SQL.Add('  E.EMP_FONE01, ');
      qryTmpCab.SQL.Add('  E.EMP_C_E_P_, ');
      qryTmpCab.SQL.Add('  G.CID_NOMCID EMP_CIDADE, ');
      qryTmpCab.SQL.Add('  G.CID_ESTADO EMP_ESTADO, ');
      qryTmpCab.SQL.Add('  H.IBG_NOMPAI EMP_PAIS__, ');
      qryTmpCab.SQL.Add('  C.CLI_NOMCLI, ');
      qryTmpCab.SQL.Add('  C.CLI_C_G_C_, ');
      qryTmpCab.SQL.Add('  C.CLI_I_E_S_, ');
      qryTmpCab.SQL.Add('  C.CLI_ENDERE, ');
      qryTmpCab.SQL.Add('  C.CLI_ENDNUM, ');
      qryTmpCab.SQL.Add('  C.CLI_BAIRRO, ');
      qryTmpCab.SQL.Add('  C.CLI_FONE01, ');
      qryTmpCab.SQL.Add('  C.CLI_C_E_P_, ');
      qryTmpCab.SQL.Add('  D.CID_NOMCID CLI_CIDADE, ');
      qryTmpCab.SQL.Add('  D.CID_ESTADO CLI_ESTADO, ');
      qryTmpCab.SQL.Add('  B.IBG_NOMPAI CLI_PAIS__, ');
      qryTmpCab.SQL.Add('  F.FIS_ACESSO, ');
      qryTmpCab.SQL.Add('  F.FIS_SERIE_, ');
      qryTmpCab.SQL.Add('  F.FIS_NUMDOC, ');
      qryTmpCab.SQL.Add('  M.GER_DTAENT, ');
      qryTmpCab.SQL.Add('  M.GER_HORENT, ');
      qryTmpCab.SQL.Add('  M.GER_VLRCON, ');
      qryTmpCab.SQL.Add('  M.GER_PESBRU, ');
      qryTmpCab.SQL.Add('  T.CTE_VLRFRE, ');
      qryTmpCab.SQL.Add('  T.CTE_RNTRC_, ');
      qryTmpCab.SQL.Add('  T.CTE_PROPRE, ');
      qryTmpCab.SQL.Add('  M.GER_ESPDOC, ');
      qryTmpCab.SQL.Add('  M.GER_CODEMP ');
      qryTmpCab.SQL.Add('FROM MOVCTE T ');
      qryTmpCab.SQL.Add('  LEFT JOIN MOVGER M on M.AUTOINCREM = T.CTE_SEQGER ');
      qryTmpCab.SQL.Add('  LEFT JOIN CADFIS F ON F.FIS_NUMDOC = M.GER_NUMDOC ');
      qryTmpCab.SQL.Add('                    AND F.FIS_ESPDOC = M.GER_ESPDOC ');
      qryTmpCab.SQL.Add('                    AND F.FIS_SERIE_ = M.GER_SERIE_ ');
      qryTmpCab.SQL.Add('                    AND F.FIS_CODEMP = M.GER_CODEMP ');
      qryTmpCab.SQL.Add('                    AND F.FIS_TIP_FC = M.GER_TIP_FC ');
      qryTmpCab.SQL.Add('                    AND IF(F.FIS_TIP_FC="C", M.GER_CODCLI, M.GER_CODFOR) = F.FIS_FORCLI ');
      qryTmpCab.SQL.Add('  LEFT JOIN CADEMP E ON E.EMP_CODEMP = T.CTE_CODEMP ');
      qryTmpCab.SQL.Add('  LEFT JOIN CADCID G ON G.CID_CODCID = E.EMP_CODCID ');
      qryTmpCab.SQL.Add('  LEFT JOIN IBG_CADPAI H ON H.IBG_CODPAI = G.CID_CODPAI ');
      qryTmpCab.SQL.Add('  LEFT JOIN CADCLI C ON C.CLI_CODCLI = F.FIS_FORCLI ');
      qryTmpCab.SQL.Add('  LEFT JOIN CADCID D ON D.CID_CODCID = C.CLI_CODCID ');
      qryTmpCab.SQL.Add('  LEFT JOIN IBG_CADPAI B ON B.IBG_CODPAI = D.CID_CODPAI ');
      qryTmpCab.SQL.Add('WHERE T.CTE_CODEMP = :CODEMP ');
      qryTmpCab.SQL.Add('  AND T.CTE_NUMCTE = :NUMCTE ');
      qryTmpCab.ParamByName('CODEMP').AsString := strCodEmp;
      qryTmpCab.ParamByName('NUMCTE').AsString := strNumCte;
      qryTmpCab.Open;

      If not qryTmpCab.IsEmpty Then
      Begin
        pDanfeCTe(strCodEmp, strNumCte, strImpressora, blnDesignReport);
      End;

    Finally
      FreeAndNil(qryTmpCab);
    End;

  Except
    On E : Exception do
    Begin
    {$IF Defined(LINUX)}
      Writeln('Erro [ImpressaoCTe.Imprimir]: ' + E.Message);
    {$ELSE}
      ShowErrorMsgTimeout(E.ClassName, 'Erro [ImpressaoCTe.Imprimir]: ' + E.Message, 10000);
    {$IFEND}
    End;
  End;
end;


procedure TImpressaoCTe.pDanfeCTe(strCodigoEmpresa, strNumeroConhecimento,
  strImpressora: string; blnDesignReport: Boolean);
  Var
    strNomImp: String;
    strEmpEndereco: String;
    LStreamDanfe: TStringStream;
Begin
  frxDbDanfe := TfrxDBDataset.Create(nil);
  frxDanfe := TfrxReport.Create(nil);
  Try
    frxDbDanfe.UserName := 'frxNFce';
    frxDbDanfe.DataSet := qryTmpCab;

    ConexaoBD.CarregarConfiguracao('', strCodigoEmpresa, 'CTE', 4.00);

    LStreamDanfe := fStringToStreamDanfe(ConexaoBD.FConfiguracao.LayoutRetrato);
    frxDanfe.LoadFromStream(LStreamDanfe);
    LStreamDanfe.Free;

    frxDanfe.Script.Variables['CTE_NUMCTE'] := qryTmpCab.FieldByName('CTE_NUMCTE').AsString;
    frxDanfe.Script.Variables['CTE_SERIE_'] := qryTmpCab.FieldByName('CTE_SERIE_').AsString;

    ConexaoBD.CarregarImagemBase64(qryTmpCab.FieldByName('GER_CODEMP').AsString, 4.00, (frxDanfe.FindObject('ImgLogo') as TfrxPictureView).Picture, tpLogo, 'CTE');

    strEmpEndereco := qryTmpCab.FieldByName('EMP_ENDERE').AsString + ', ' +
      qryTmpCab.FieldByName('EMP_ENDNUM').AsString + #13 +
      qryTmpCab.FieldByName('EMP_BAIRRO').AsString + #13 +
      qryTmpCab.FieldByName('EMP_CIDADE').AsString + '/' +
      qryTmpCab.FieldByName('EMP_ESTADO').AsString + #13 +
      'CEP: ' + fFormataCEP(qryTmpCab.FieldByName('EMP_C_E_P_').AsString) + #13 +
      'Telefone: ' + fFormataFone(qryTmpCab.FieldByName('EMP_FONE01').AsString);

    frxDanfe.Script.Variables['EMP_NOMEMP'] := qryTmpCab.FieldByName('EMP_NOMEMP').AsString;
    frxDanfe.Script.Variables['EMP_ENDERE'] := strEmpEndereco;
    frxDanfe.Script.Variables['EMP_C_G_C_'] := fFormataCpfCgc(qryTmpCab.FieldByName('EMP_C_G_C_').AsString);
    frxDanfe.Script.Variables['EMP_I_E_S_'] := qryTmpCab.FieldByName('EMP_I_E_S_').AsString;

    frxDanfe.Script.Variables['NUMCTE'] := qryTmpCab.FieldByName('CTE_NUMCTE').AsString;
    frxDanfe.Script.Variables['SERIE_'] := qryTmpCab.FieldByName('CTE_SERIE_').AsString;
    frxDanfe.Script.Variables['MODELO'] := qryTmpCab.FieldByName('CTE_CODMOD').AsString;
    frxDanfe.Script.Variables['DTAHOR'] := qryTmpCab.FieldByName('GER_DTAENT').AsString + ' ' +
      qryTmpCab.FieldByName('GER_HORENT').AsString;
    frxDanfe.Script.Variables['ACESSO'] := qryTmpCab.FieldByName('FIS_ACESSO').AsString;
    frxDanfe.Script.Variables['ACEBAR'] := qryTmpCab.FieldByName('FIS_ACESSO').AsString;
    frxDanfe.Script.Variables['NATOPE'] := qryTmpCab.FieldByName('CTE_CFOP__').AsString + ' - ' +
      qryTmpCab.FieldByName('CTE_NATOPE').AsString;
    frxDanfe.Script.Variables['PROTOC'] := qryTmpCab.FieldByName('CTE_PROTOC').AsString + ' ' +
      qryTmpCab.FieldByName('CTE_DTAHOR').AsString;
    frxDanfe.Script.Variables['INICIO'] := qryTmpCab.FieldByName('EMP_CIDADE').AsString + '/' +
      qryTmpCab.FieldByName('EMP_ESTADO').AsString;
    frxDanfe.Script.Variables['TERMIN'] := qryTmpCab.FieldByName('CLI_CIDADE').AsString + '/' +
      qryTmpCab.FieldByName('CLI_ESTADO').AsString;

    frxDanfe.Script.Variables['NOMREM'] := qryTmpCab.FieldByName('EMP_NOMEMP').AsString;
    frxDanfe.Script.Variables['ENDREM'] := qryTmpCab.FieldByName('EMP_ENDERE').AsString + ', ' +
      qryTmpCab.FieldByName('EMP_ENDNUM').AsString + ' - ' +
      qryTmpCab.FieldByName('EMP_BAIRRO').AsString;
    frxDanfe.Script.Variables['CIDREM'] := qryTmpCab.FieldByName('EMP_CIDADE').AsString;
    frxDanfe.Script.Variables['UF_REM'] := qryTmpCab.FieldByName('EMP_ESTADO').AsString;
    frxDanfe.Script.Variables['CEPREM'] := fFormataCEP(qryTmpCab.FieldByName('EMP_C_E_P_').AsString);
    frxDanfe.Script.Variables['PAIREM'] := qryTmpCab.FieldByName('EMP_PAIS__').AsString;
    frxDanfe.Script.Variables['FONREM'] := qryTmpCab.FieldByName('EMP_FONE01').AsString;
    frxDanfe.Script.Variables['CGCREM'] := fFormataCpfCgc(qryTmpCab.FieldByName('EMP_C_G_C_').AsString);
    frxDanfe.Script.Variables['IE_REM'] := qryTmpCab.FieldByName('EMP_I_E_S_').AsString;

    frxDanfe.Script.Variables['NOMTOM'] := qryTmpCab.FieldByName('EMP_NOMEMP').AsString;
    frxDanfe.Script.Variables['ENDTOM'] := qryTmpCab.FieldByName('EMP_ENDERE').AsString + ', ' +
      qryTmpCab.FieldByName('EMP_ENDNUM').AsString + ' - ' +
      qryTmpCab.FieldByName('EMP_BAIRRO').AsString;
    frxDanfe.Script.Variables['CIDTOM'] := qryTmpCab.FieldByName('EMP_CIDADE').AsString;
    frxDanfe.Script.Variables['UF_TOM'] := qryTmpCab.FieldByName('EMP_ESTADO').AsString;
    frxDanfe.Script.Variables['CEPTOM'] := fFormataCEP(qryTmpCab.FieldByName('EMP_C_E_P_').AsString);
    frxDanfe.Script.Variables['PAITOM'] := qryTmpCab.FieldByName('EMP_PAIS__').AsString;
    frxDanfe.Script.Variables['FONTOM'] := qryTmpCab.FieldByName('EMP_FONE01').AsString;
    frxDanfe.Script.Variables['CGCTOM'] := fFormataCpfCgc(qryTmpCab.FieldByName('EMP_C_G_C_').AsString);
    frxDanfe.Script.Variables['IE_TOM'] := qryTmpCab.FieldByName('EMP_I_E_S_').AsString;

    frxDanfe.Script.Variables['NOMDES'] := qryTmpCab.FieldByName('CLI_NOMCLI').AsString;
    frxDanfe.Script.Variables['ENDDES'] := qryTmpCab.FieldByName('CLI_ENDERE').AsString + ', ' +
      qryTmpCab.FieldByName('CLI_ENDNUM').AsString + ' - ' +
      qryTmpCab.FieldByName('CLI_BAIRRO').AsString;
    frxDanfe.Script.Variables['CIDDES'] := qryTmpCab.FieldByName('CLI_CIDADE').AsString;
    frxDanfe.Script.Variables['UF_DES'] := qryTmpCab.FieldByName('CLI_ESTADO').AsString;
    frxDanfe.Script.Variables['CEPDES'] := fFormataCEP(qryTmpCab.FieldByName('CLI_C_E_P_').AsString);
    frxDanfe.Script.Variables['PAIDES'] := qryTmpCab.FieldByName('CLI_PAIS__').AsString;
    frxDanfe.Script.Variables['FONDES'] := qryTmpCab.FieldByName('CLI_FONE01').AsString;
    frxDanfe.Script.Variables['CGCDES'] := fFormataCpfCgc(qryTmpCab.FieldByName('CLI_C_G_C_').AsString);
    frxDanfe.Script.Variables['IE_DES'] := qryTmpCab.FieldByName('CLI_I_E_S_').AsString;

    frxDanfe.Script.Variables['PROPRE'] := qryTmpCab.FieldByName('CTE_PROPRE').AsString;
    frxDanfe.Script.Variables['VLRCON'] := FormatFloat('#,##0.00', qryTmpCab.FieldByName('GER_VLRCON').AsFloat);
    frxDanfe.Script.Variables['PESBRU'] := FormatFloat('#0.00', qryTmpCab.FieldByName('GER_PESBRU').AsFloat);
    frxDanfe.Script.Variables['PESO__'] := FormatFloat('#0.00', qryTmpCab.FieldByName('GER_PESBRU').AsFloat);
    frxDanfe.Script.Variables['VLRFRE'] := FormatFloat('#,##0.00', qryTmpCab.FieldByName('CTE_VLRFRE').AsFloat);
    frxDanfe.Script.Variables['VLRREC'] := FormatFloat('#,##0.00', qryTmpCab.FieldByName('CTE_VLRFRE').AsFloat);

    If qryTmpCab.FieldByName('GER_ESPDOC').AsString = 'NF' Then
      frxDanfe.Script.Variables['ESPDOC'] := 'NFE'
    Else
      frxDanfe.Script.Variables['ESPDOC'] := qryTmpCab.FieldByName('GER_ESPDOC').AsString;

    frxDanfe.Script.Variables['FIS_ACESSO'] := qryTmpCab.FieldByName('FIS_ACESSO').AsString;
    frxDanfe.Script.Variables['NUMDOC'] := qryTmpCab.FieldByName('FIS_SERIE_').AsString + ' / ' +
      qryTmpCab.FieldByName('FIS_NUMDOC').AsString;

    frxDanfe.Script.Variables['RNTRC_'] := qryTmpCab.FieldByName('CTE_RNTRC_').AsString;

    If blnDesignReport Then
    Begin
      frxDanfe.DesignReport;
      Exit;
    End;

    If fEmptyStr(strImpressora) Then
    Begin
      strNomImp := fArqIniLocal(0, 'CTE', 'IMPRESSORA', '', ConexaoBD.CarregarCFGSIS('PTNFCE') + '\opcoes_nfce.ini');
      If fArqIniLocal(0, 'GERAL', 'SPOOL_IMPRESSAO_CITEL', 'S', fPathOpcoesIni) <> 'N' Then
        If ConexaoBD.CarregarCFGSIS('SPOIMP') = 'S' then
          strNomImp := fArqIniLocal(0, 'CTE', 'PONTO_IMPRESSAO', '', ConexaoBD.CarregarCFGSIS('PTNFCE') + '\opcoes_nfce.ini');
    End
    Else
      strNomImp := strImpressora;

    frxDanfe.PrintOptions.Printer    := AnsiReplaceStr(strNomImp, '\\' + fRetNomeRede + '\', '');
    frxDanfe.PrintOptions.ShowDialog := False;

    If (frxDanfe.PrepareReport) Then
      pPrintReport('NFeImpressao', 'CT-e ' + strNumeroConhecimento, strNomImp, frxDanfe);

    If Assigned(ConexaoBD) Then
    Begin
      ConexaoBD.pSalvarDFePDF(frxDanfe, qryTmpCab.FieldByName('CTE_ACESSO').AsString);
    End;
  Finally
    FreeAndNil(frxDanfe);
    FreeAndNil(frxDbDanfe);
  End;
end;

end.
