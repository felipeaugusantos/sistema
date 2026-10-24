unit untImpressaoCCe;

interface

uses
{$IF Defined(LINUX)}
  Uni, NFe.Modulo,
  FMX.frxClass, FMX.frxDBSet, FMX.frxDesgn, FMX.frxExportPDF,
  FMX.frxBarcode, FMX.frxDelphiZXingQRCode, FMX.Graphics,
  FMX.Objects, FMX.Forms,
{$ELSE}
  Windows, Messages, Graphics,
  Controls, Forms, frxClass, ComCtrls, StdCtrls, ExtCtrls,
  {$IF Defined(UNIDAC)}
    UniClientDataSet, Uni, MySQLUniProvider, UniProvider,
  {$ELSE}
   ZConnection, ZDataset, ZDbcIntfs,
  {$IFEND}
  DBCtrls, MemDS, dialogs,
  {$IFDEF VER300}
    System.UITypes,
  {$ENDIF}
  untModulo, frxBarcode, frxDBSet, frxDelphiZXingQRCode, frxDesgn,
{$IFEND}
  untConexaoBD, untUtil, StrUtils, SysUtils, Variants, DB, Classes;

type
  TImpressaoCCe = class
  private
    ConexaoBD : TConexaoBD;
    frxDanfe: TfrxReport;
    frxDbDanfe: TfrxDBDataset;

    procedure pDanfeCCe(strCodigoEmpresa, strChaveAcesso, strImpressora : string; blnDesignReport: Boolean=False);
    function fInscricaoEstadualSubstitutoTributario: String;
    function fDocumentoEntregaFuturaClienteVaiRetirar: Boolean;

  public
    dtsConf: TDataSource;
    constructor Create();
    destructor Destroy; override;
    procedure Imprimir(strCodEmp, strAcesso, strImpressora: string; blnDesignReport: boolean=False);
  end;

Var
  qryTmpCab: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  qryTmpPar: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  qryTmpEnF: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};

implementation

uses
{$IF Defined(LINUX)}
{$ELSE}
  {$IF Defined(UNIDAC)} untModuloReplicacao, Vcl.Printers {$ELSE} untModuloReplicacaoZeos {$IFEND},
{$IFEND}
  untConfImpressora;

{ TImpressaoCCe }

constructor TImpressaoCCe.Create;
begin
  ConexaoBD := TConexaoBD.Create(frmModulo.Database);
end;

destructor TImpressaoCCe.Destroy;
begin
  ConexaoBD.Free();
end;

function TImpressaoCCe.fDocumentoEntregaFuturaClienteVaiRetirar: Boolean;
begin

  Try
    qryTmpEnF := fCriaQuery(nil);

    Try

      qryTmpEnF.SQL.Clear;
      qryTmpEnF.SQL.Add(' SELECT COUNT(*) AS CNT ');
      qryTmpEnF.SQL.Add('   FROM MOVDET D ');
      qryTmpEnF.SQL.Add('   JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
      qryTmpEnF.SQL.Add('  WHERE DET_NUMDOC = :NUMDOC ');
      qryTmpEnF.SQL.Add('    AND DET_ESPDOC = :ESPDOC ');
      qryTmpEnF.SQL.Add('    AND DET_CODEMP = :CODEMP ');
      qryTmpEnF.SQL.Add('    AND DET_CODCLI = :CODCLI ');
      qryTmpEnF.SQL.Add('    AND DET_SERIE_ = :SERIE_ ');
      qryTmpEnF.SQL.Add('    AND DET_TIP_FC = "C" ');
      qryTmpEnF.SQL.Add('    AND DET_ORIDOC = "V" ');
      qryTmpEnF.SQL.Add('    AND DET_ENTFUT = "S" ');
      qryTmpEnF.SQL.Add('    AND DET_CLIBUS = "S" ');

      qryTmpEnF.ParamByName('NUMDOC').AsString := qryTmpCab.FieldByName('FIS_NUMDOC').AsString;
      qryTmpEnF.ParamByName('ESPDOC').AsString := qryTmpCab.FieldByName('FIS_ESPDOC').AsString;
      qryTmpEnF.ParamByName('CODEMP').AsString := qryTmpCab.FieldByName('FIS_CODEMP').AsString;
      qryTmpEnF.ParamByName('CODCLI').AsString := qryTmpCab.FieldByName('FIS_FORCLI').AsString;
      qryTmpEnF.ParamByName('SERIE_').AsString := qryTmpCab.FieldByName('FIS_SERIE_').AsString;

      qryTmpEnF.Open;

    Finally
      FreeAndNil(qryTmpEnF);
    End;

  Except
    On E : Exception do
    Begin
    {$IF Defined(LINUX)}
      Writeln('Erro [ImpressaoCCe.fDocumentoEntregaFuturaClienteVaiRetirar]: ' + E.Message);
    {$ELSE}
      ShowErrorMsgTimeout(E.ClassName, 'Erro [ImpressaoCCe.fDocumentoEntregaFuturaClienteVaiRetirar]: ' + E.Message, 10000);
    {$IFEND}
    End;
  End;

  Result := (qryTmpEnF.FieldByName('CNT').AsInteger > 0);

end;

function TImpressaoCCe.fInscricaoEstadualSubstitutoTributario: String;
 Var
   strLisUFNaoEnviaIE: String;
begin
  Result := qryTmpCab.FieldByName('EMP_INSSUB').AsString;

  If (qryTmpCab.FieldByName('AUX_VENPRE').AsString = 'S') Then
  Begin
    strLisUFNaoEnviaIE := ConexaoBD.CarregarCFGSIS('SUTBNF'); //Não envia no arquivio a IE do Substituto Tributario

    If (Pos(qryTmpCab.FieldByName('EMP_ESTADO').AsString, strLisUFNaoEnviaIE) > 0) Then
      Result := ''
    Else If (Not fEmptyStr(Result)) And (fDocumentoEntregaFuturaClienteVaiRetirar) Then
      Result := '';

  End;

end;

procedure TImpressaoCCe.Imprimir(strCodEmp, strAcesso, strImpressora: string; blnDesignReport: boolean=False);
begin

  Try
    qryTmpCab := fCriaQuery(nil);

    qryTmpPar := fCriaQuery(nil);

    Try

      qryTmpCab.SQL.Clear;

      qryTmpCab.SQL.Add('SELECT ');
      qryTmpCab.SQL.Add('  N.FIS_ACESSO, ');
      qryTmpCab.SQL.Add('  N.FIS_PROTOC, ');
      qryTmpCab.SQL.Add('  N.FIS_HISTOR, ');
      qryTmpCab.SQL.Add('  N.FIS_CLFSC1, ');
      qryTmpCab.SQL.Add('  N.FIS_SERIE_, ');
      qryTmpCab.SQL.Add('  N.FIS_DTADOC, ');
      qryTmpCab.SQL.Add('  N.FIS_NUMDOC, ');
      qryTmpCab.SQL.Add('  N.FIS_ESPDOC, ');
      qryTmpCab.SQL.Add('  N.FIS_CODEMP, ');
      qryTmpCab.SQL.Add('  A.AUX_VENPRE, ');
      qryTmpCab.SQL.Add('  E.EMP_NOMEMP, ');
      qryTmpCab.SQL.Add('  E.EMP_NOMFAN, ');
      qryTmpCab.SQL.Add('  E.EMP_ENDERE, ');
      qryTmpCab.SQL.Add('  E.EMP_ENDNUM, ');
      qryTmpCab.SQL.Add('  E.EMP_BAIRRO, ');
      qryTmpCab.SQL.Add('  E.EMP_I_E_S_, ');
      qryTmpCab.SQL.Add('  S.EMP_INSSUB, ');
      qryTmpCab.SQL.Add('  E.EMP_C_G_C_, ');
      qryTmpCab.SQL.Add('  F.CID_NOMCID EMP_CIDADE, ');
      qryTmpCab.SQL.Add('  F.CID_ESTADO EMP_ESTADO, ');
      qryTmpCab.SQL.Add('  E.EMP_C_E_P_, ');
      qryTmpCab.SQL.Add('  E.EMP_FONE01, ');
      qryTmpCab.SQL.Add('  N.FIS_FORCLI, ');
      qryTmpCab.SQL.Add('  IF(N.FIS_TIP_FC="C", C.CLI_NOMCLI, R.FOR_NOMFOR) AS CLI_NOMCLI, ');
      qryTmpCab.SQL.Add('  IF(N.FIS_TIP_FC="C", C.CLI_C_G_C_, R.FOR_C_G_C_) AS CLI_C_G_C_, ');
      qryTmpCab.SQL.Add('  IF(N.FIS_TIP_FC="C", C.CLI_I_E_S_, R.FOR_I_E_S_) AS CLI_I_E_S_, ');
      qryTmpCab.SQL.Add('  IF(N.FIS_TIP_FC="C", C.CLI_ENDERE, R.FOR_ENDERE) AS CLI_ENDERE, ');
      qryTmpCab.SQL.Add('  IF(N.FIS_TIP_FC="C", C.CLI_ENDNUM, R.FOR_ENDNUM) AS CLI_ENDNUM, ');
      qryTmpCab.SQL.Add('  IF(N.FIS_TIP_FC="C", C.CLI_BAIRRO, R.FOR_BAIRRO) AS CLI_BAIRRO, ');
      qryTmpCab.SQL.Add('  IF(N.FIS_TIP_FC="C", D.CID_NOMCID, P.CID_NOMCID) AS CLI_CIDADE, ');
      qryTmpCab.SQL.Add('  IF(N.FIS_TIP_FC="C", D.CID_ESTADO, P.CID_ESTADO) AS CLI_ESTADO, ');
      qryTmpCab.SQL.Add('  IF(N.FIS_TIP_FC="C", C.CLI_C_E_P_, R.FOR_C_E_P_) AS CLI_C_E_P_, ');
      qryTmpCab.SQL.Add('  IF(N.FIS_TIP_FC="C", C.CLI_FONE01, R.FOR_FONE01) AS CLI_FONE01, ');
      qryTmpCab.SQL.Add('  O.CCN_PROTOC, ');
      qryTmpCab.SQL.Add('  O.CCN_DTAENV, ');
      qryTmpCab.SQL.Add('  O.CCN_DESCOR ');
      qryTmpCab.SQL.Add('FROM CADFIS N ');
      qryTmpCab.SQL.Add('  LEFT JOIN MOVGER M ON M.GER_NUMDOC = N.FIS_NUMDOC AND ');
      qryTmpCab.SQL.Add('                        M.GER_ESPDOC = N.FIS_ESPDOC AND ');
      qryTmpCab.SQL.Add('                        M.GER_SERIE_ = N.FIS_SERIE_ AND ');
      qryTmpCab.SQL.Add('                        M.GER_CODEMP = N.FIS_CODEMP AND ');
      qryTmpCab.SQL.Add('                        M.GER_TIP_FC = N.FIS_TIP_FC AND ');
      qryTmpCab.SQL.Add('                        IF(N.FIS_TIP_FC="C", M.GER_CODCLI, M.GER_CODFOR) = N.FIS_FORCLI ');
      qryTmpCab.SQL.Add('  LEFT JOIN AUXMOV A ON A.AUX_SEQGER = M.AUTOINCREM ');
      qryTmpCab.SQL.Add('  LEFT JOIN CADCLI C ON C.CLI_CODCLI = N.FIS_FORCLI ');
      qryTmpCab.SQL.Add('  LEFT JOIN CADCID D ON D.CID_CODCID = C.CLI_CODCID ');
      qryTmpCab.SQL.Add('  LEFT JOIN CADFOR R ON R.FOR_CODFOR = N.FIS_FORCLI ');
      qryTmpCab.SQL.Add('  LEFT JOIN CADCID P ON P.CID_CODCID = R.FOR_CODCID ');
      qryTmpCab.SQL.Add('  JOIN CADEMP E ON E.EMP_CODEMP = N.FIS_CODEMP ');
      qryTmpCab.SQL.Add('  LEFT JOIN EMPISB S ON S.EMP_CODEMP = E.EMP_CODEMP AND S.EMP_ESTADO = D.CID_ESTADO ');
      qryTmpCab.SQL.Add('  JOIN CADCID F ON F.CID_CODCID = E.EMP_CODCID ');
      qryTmpCab.SQL.Add('  JOIN CC_NFE O ON O.CCN_SEQGER = N.AUTOINCREM ');
      qryTmpCab.SQL.Add('WHERE N.FIS_CODEMP = :CODEMP ');
      qryTmpCab.SQL.Add('  AND N.FIS_ACESSO = :ACESSO ');

      qryTmpCab.ParamByName('CODEMP').AsString := strCodEmp;
      qryTmpCab.ParamByName('ACESSO').AsString := strAcesso;

      qryTmpCab.Open;

      qryTmpPar.SQL.Clear;
      qryTmpPar.SQL.Add('SELECT ');
      qryTmpPar.SQL.Add('  O.CCN_PROTOC, ');
      qryTmpPar.SQL.Add('  O.CCN_DTAENV, ');
      qryTmpPar.SQL.Add('  O.CCN_CODCOR, ');
      qryTmpPar.SQL.Add('  O.CCN_NOMCOR, ');
      qryTmpPar.SQL.Add('  O.CCN_DESCOR ');
      qryTmpPar.SQL.Add('FROM CC_NFE O ');
      qryTmpPar.SQL.Add('  JOIN CADFIS N ON N.AUTOINCREM = O.CCN_SEQGER ');
      qryTmpPar.SQL.Add('WHERE N.FIS_CODEMP = :CODEMP ');
      qryTmpPar.SQL.Add('  AND N.FIS_ACESSO = :ACESSO ');
      qryTmpPar.SQL.Add('ORDER BY ');
      qryTmpPar.SQL.Add('  O.CCN_DTAENV, ');
      qryTmpPar.SQL.Add('  O.CCN_CODCOR ');

      qryTmpPar.ParamByName('CODEMP').AsString := strCodEmp;
      qryTmpPar.ParamByName('ACESSO').AsString := strAcesso;

      qryTmpPar.Open;

      If not qryTmpPar.IsEmpty Then
      Begin

        pDanfeCCe(strCodEmp, '', strImpressora, blnDesignReport);

      End;

    Finally
      FreeAndNil(qryTmpCab);
      FreeAndNil(qryTmpPar);
    End;

  Except
    On E : Exception do
    Begin
    {$IF Defined(LINUX)}
      Writeln('Erro [ImpressaoCCe.Imprimir]: ' + E.Message);
    {$ELSE}
      ShowErrorMsgTimeout(E.ClassName, 'Erro [ImpressaoCCe.Imprimir]: ' + E.Message, 10000);
    {$IFEND}
    End;
  End;
end;


procedure TImpressaoCCe.pDanfeCCe(strCodigoEmpresa, strChaveAcesso,
  strImpressora: string; blnDesignReport: Boolean);
  Var
    strNomImp: String;
    strEmpEndereco: String;
    strOcorrenciaMensagem: String;
    LStreamDanfe: TStringStream;
Begin
  frxDbDanfe := TfrxDBDataset.Create(nil);
  frxDanfe := TfrxReport.Create(nil);

  Try

    frxDbDanfe.UserName := 'frxNFce';
    frxDbDanfe.DataSet := qryTmpPar;

    ConexaoBD.CarregarConfiguracao(strChaveAcesso, strCodigoEmpresa, 'CCE', 4.00);

    LStreamDanfe := fStringToStreamDanfe(ConexaoBD.FConfiguracao.LayoutRetrato);
    frxDanfe.LoadFromStream(LStreamDanfe);
    LStreamDanfe.Free;

    strEmpEndereco := qryTmpCab.FieldByName('EMP_ENDERE').AsString + ', ' +
      qryTmpCab.FieldByName('EMP_ENDNUM').AsString + #13 +
      qryTmpCab.FieldByName('EMP_BAIRRO').AsString + #13 +
      qryTmpCab.FieldByName('EMP_CIDADE').AsString + '/' +
      qryTmpCab.FieldByName('EMP_ESTADO').AsString + #13 +
      'CEP: ' + fFormataCEP(qryTmpCab.FieldByName('EMP_C_E_P_').AsString) + #13 +
      'Telefone: ' + fFormataFone(qryTmpCab.FieldByName('EMP_FONE01').AsString);

    frxDanfe.Script.Variables['FIS_ENTSAI'] := '1';
    frxDanfe.Script.Variables['FIS_ACESSO'] := qryTmpCab.FieldByName('FIS_ACESSO').AsString;
    frxDanfe.Script.Variables['FIS_PROTOC'] := qryTmpCab.FieldByName('FIS_PROTOC').AsString;
    frxDanfe.Script.Variables['FIS_HISTOR'] := qryTmpCab.FieldByName('FIS_HISTOR').AsString;
    frxDanfe.Script.Variables['FIS_CLFSC1'] := qryTmpCab.FieldByName('FIS_CLFSC1').AsString;
    frxDanfe.Script.Variables['FIS_SERIE_'] := qryTmpCab.FieldByName('FIS_SERIE_').AsString;
    frxDanfe.Script.Variables['FIS_DTADOC'] := qryTmpCab.FieldByName('FIS_DTADOC').AsString;
    frxDanfe.Script.Variables['FIS_NUMDOC'] := qryTmpCab.FieldByName('FIS_NUMDOC').AsString;
    frxDanfe.Script.Variables['EMP_NOMEMP'] := qryTmpCab.FieldByName('EMP_NOMEMP').AsString;
    frxDanfe.Script.Variables['EMP_ENDERE'] := strEmpEndereco;
    frxDanfe.Script.Variables['EMP_C_G_C_'] := fFormataCpfCgc(qryTmpCab.FieldByName('EMP_C_G_C_').AsString);
    frxDanfe.Script.Variables['EMP_I_E_S_'] := qryTmpCab.FieldByName('EMP_I_E_S_').AsString;
    frxDanfe.Script.Variables['EMP_IESUBS'] := fInscricaoEstadualSubstitutoTributario;
    frxDanfe.Script.Variables['CLI_NOMCLI'] := qryTmpCab.FieldByName('CLI_NOMCLI').AsString;
    frxDanfe.Script.Variables['CLI_C_G_C_'] := fFormataCpfCgc(qryTmpCab.FieldByName('CLI_C_G_C_').AsString);
    frxDanfe.Script.Variables['CLI_I_E_S_'] := qryTmpCab.FieldByName('CLI_I_E_S_').AsString;
    frxDanfe.Script.Variables['CLI_ENDERE'] := qryTmpCab.FieldByName('CLI_ENDERE').AsString;
    frxDanfe.Script.Variables['CLI_ENDNUM'] := qryTmpCab.FieldByName('CLI_ENDNUM').AsString;
    frxDanfe.Script.Variables['CLI_BAIRRO'] := qryTmpCab.FieldByName('CLI_BAIRRO').AsString;
    frxDanfe.Script.Variables['CLI_CIDADE'] := qryTmpCab.FieldByName('CLI_CIDADE').AsString;
    frxDanfe.Script.Variables['CLI_ESTADO'] := qryTmpCab.FieldByName('CLI_ESTADO').AsString;
    frxDanfe.Script.Variables['CLI_C_E_P_'] := qryTmpCab.FieldByName('CLI_C_E_P_').AsString;
    frxDanfe.Script.Variables['CLI_FONE01'] := fFormataFone(qryTmpCab.FieldByName('CLI_FONE01').AsString);

    ConexaoBD.CarregarImagemBase64(qryTmpCab.FieldByName('FIS_CODEMP').AsString, 4.00, (frxDanfe.FindObject('ImgLogo') as TfrxPictureView).Picture, tpLogo, 'CCE');

    strOcorrenciaMensagem := '';

    While not qryTmpPar.Eof do
    Begin
      strOcorrenciaMensagem := strOcorrenciaMensagem +
        qryTmpPar.FieldByName('CCN_CODCOR').AsString + '-' +
        qryTmpPar.FieldByName('CCN_NOMCOR').AsString + ': ' +
        qryTmpPar.FieldByName('CCN_DESCOR').AsString + #13;
      qryTmpPar.Next;
    End;

    frxDanfe.Script.Variables['CCN_PROTOC'] := qryTmpPar.FieldByName('CCN_PROTOC').AsString;
    frxDanfe.Script.Variables['CCN_DTAENV'] := qryTmpPar.FieldByName('CCN_DTAENV').AsString;
    frxDanfe.Script.Variables['CCN_DESCOR'] := strOcorrenciaMensagem;

    If not blnDesignReport Then
    Begin

      If fEmptyStr(strImpressora) Then
      Begin
        strNomImp := fArqIniLocal(0, 'CCE', 'IMPRESSORA', '', ConexaoBD.CarregarCFGSIS('PTNFCE') + '\opcoes_nfce.ini');
        If fArqIniLocal(0, 'GERAL', 'SPOOL_IMPRESSAO_CITEL', 'S', fPathOpcoesIni) <> 'N' Then
          If ConexaoBD.CarregarCFGSIS('SPOIMP') = 'S' then
            strNomImp := fArqIniLocal(0, 'CCE', 'PONTO_IMPRESSAO', '', ConexaoBD.CarregarCFGSIS('PTNFCE') + '\opcoes_nfce.ini');
      End
      Else
        strNomImp := strImpressora;

      frxDanfe.PrintOptions.Printer    := AnsiReplaceStr(strNomImp, '\\' + fRetNomeRede + '\', '');
      frxDanfe.PrintOptions.ShowDialog := False;

      If (frxDanfe.PrepareReport) Then
        pPrintReport('NFeImpressao', 'CC-e ' + strChaveAcesso, strNomImp, frxDanfe);
    End
    Else
      frxDanfe.DesignReport;

  Finally
    FreeAndNil(frxDanfe);
    FreeAndNil(frxDbDanfe);
  End;

end;

end.
