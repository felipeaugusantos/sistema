unit untExpArqRemBtgPactual_240p;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Buttons, ExtCtrls, EditFocus, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFrameDirectoryEditFocus;

type
  TfrmExpArqRemBtgPactual_240p = class(TfrmPai)
    pnlFundo: TPanel;
    lblPathRem: TLabel;
    lblNomArq: TLabel;
    pnlTopo: TPanel;
    edtNomArquivo: TEditFocus;
    edtCodPor: TEditFocus;
    edtDesPor: TEditFocus;
    Label1: TLabel;
    btnGerar: TBitBtnLocked;
    fraPathRemessa: TfraDirectoryEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private

    qryConsultaGen : TUniQuery;
    qryCadPor      : TUniQuery;

    qryRemessa : TUniQuery;
    strNomEmp  : String;
    strCartei  : String;
    //strPerJur  : String;
    strPerMul  : String;
    fltPerJur  : Double;
    fltPerMul  : Double;
    strTpMulta : String;
    strTpJuros : String;

    function fValidacoesParaExportacao: Boolean;
    function fCriarQueryRemessa: TUniQuery;
    function fGetSqlRemessa: String;
    function RetornaCodigoMulta: String;
    function fRetEmpresa: String;
    procedure pVerificaTipoMultaEJuros;

    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemBtgPactual_240p: TfrmExpArqRemBtgPactual_240p;

implementation

uses untFuncoes, untfuncoesSimples, untFuncAutBan, DB, untTypesSistema, untConsultas,
     untConstantes, untLogCtr;

{$R *.dfm}

function TfrmExpArqRemBtgPactual_240p.fRetEmpresa: String;
  Var
    intCount  : Integer;
    arrResult : Array Of String;
    qryCadEmp : TUniQuery;

Begin

  qryCadEmp := fCriaQuery(Self);

  qryCadEmp.Close;
  qryCadEmp.SQL.Clear;
  qryCadEmp.SQL.Add('SELECT * FROM CADEMP');
  qryCadEmp.SQL.Add('ORDER BY EMP_CODEMP ');
  qryCadEmp.Open;
  qryCadEmp.First;

  SetLength(arrResult, qryCadEmp.RecordCount);
  intCount := 0;

  While Not qryCadEmp.Eof Do
  Begin
    arrResult[intCount] := fStrZero(qryCadEmp.FieldByName('EMP_CODEMP').AsString, 3) + ' - ' + qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
    qryCadEmp.Next;
    Inc(intCount);
  End;

  intCount := 1;

  If Length(arrResult) > 1 Then
    intCount := fGetMenu('Selecione a Empresa', arrResult, 0);


  Result   := LeftStr(arrResult[intCount -1], 3);

  FreeAndnil(qryCadEmp);
end;

procedure TfrmExpArqRemBtgPactual_240p.FormShow(Sender: TObject);
begin
  inherited;
  
  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'PATHREM',''));
  edtNomArquivo.Text  := fStrZero(fGetBancoProxNum('CONFIG208-' + IntToStr(intCartei)), 7) +
                         '.TXT';
  pSetFocus(edtCodPor);

end;

function TfrmExpArqRemBtgPactual_240p.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodPor) Then
    Begin
      If Not fEmptyStr(edtCodPor.Text) Then
      Begin
        edtDesPor.Text := fRetNomPortador(edtCodPor.Text);

        If Not CarregaPortador(edtCodPor.Text) Then
           Result := False
        Else
        If fEmptyStr(edtDesPor.Text) Then
        Begin
          fMensagem('', 'Portador não cadastrado!', ['&Ok']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmExpArqRemBtgPactual_240p.fValidacoesParaExportacao: Boolean;
  Var
    blnRemLoc   : Boolean;
    strNovCodEmp: String;
begin
  Result := True;

  If Not fVerificaCampos Then
  Begin
    Result := False;
    Exit;
  End;

  If fMensagem('','Confirma geração do arquivo de remessa?',['&Sim','&Não']) = 2 Then
  Begin
    Result := False;
    Exit;
  End;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fraPathRemessa.edtDirectory.text);

  If Not DirectoryExists(fraPathRemessa.edtDirectory.text) Then
  Begin
    fMensagem('Path:', 'Diretório inválido p\ exportação.', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Result := False;
    Exit;
  End;

  {***************************************************
   * VERIFICA SE EXISTE A CONFIGURACAO PARA A GERA-  *
   * CAO DE REMESSA PARA TODAS AS EMPRESAS OU SOMEN- *
   * TE PARA A EMPRESA ATUAL(LOCAL)                  *
   ***********************************************ED*}
  blnRemLoc  := Not( fGetBancoConfig(0, 'CONFIG208', 'RELOCAL', '') = 'N' );

  strNovCodEmp := VS_strCodEmp;
  If Not( blnRemLoc ) Then
    strNovCodEmp := fRetEmpresa;  //Abre bloco para escolher a empresa
  strNomEmp := fRetNomeEmpresa(strNovCodEmp);

  If Not fEmptyStr(fCfgSis('NOMCED')) Then
    strNomEmp := fCfgSis('NOMCED');

  If fEmptyStr( strNomEmp ) Then
  Begin
    fMensagem('','Erro ao localizar o nome da empresa responsável pela remessa!',['&Sim','&Não']);
    Result := False;
    Exit;
  End;

end;

{0 - Sem Multa}
{1 - Valor Fixo}
{2 - Percentual}
function TfrmExpArqRemBtgPactual_240p.RetornaCodigoMulta: String;
begin
  Result := StrToIntDef(fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'TPMULTA', ''),2).ToString;

  If Not MatchStr(Result,['0','1','2'])Then
    Result := '2';
end;

function TfrmExpArqRemBtgPactual_240p.fCriarQueryRemessa: TUniQuery;
begin
  Result := Nil;

  Try
    Result:= fCriaQuery(Self);
    Result.Close;
    Result.SQL.Clear;
    Result.SQL.Add(fGetSqlRemessa);
    Result.ParamByName('CODBCO').AsString := '208';

    If (Not fEmptyStr(edtCodPor.Text)) Then
      Result.ParamByName('CODPOR').AsString := edtCodPor.Text;

    if (fCfgSis('CONREM', varString) = 'C') THEN
      Result.ParamByName('CARTEI').AsString := strCartei;

    Result.Open;
  Except
  On E: Exception Do
   Begin
     pMensagensErro(E.Message, '[TfrmExpArqRemBtgPactual_240p.fCriarQueryRemessa]');
   End;
  End;

end;

function TfrmExpArqRemBtgPactual_240p.fGetSqlRemessa: String;
  Var
    strSQL : String;
begin

    strSQL := '';
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  B.*, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, ';
    strSQL := strSQL + '  R.AUTOINCREM AS AUTOINCREM, ';
    strSQL := strSQL + '  R.CTR_DTAREC AS CTR_DTAREC, ';
    strSQL := strSQL + '  G.GER_DTADOC, ';
    strSQL := strSQL + '  G.GER_NUMDOC, ';
    strSQL := strSQL + '  G.GER_SERIE_, ';
    strSQL := strSQL + '  L.NFE_ACESSO, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IF(IFNULL(C.CLI_ENDERE, "") = "", IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM)), C.CLI_ENDERE), C.CLI_ENDCOB) AS ENDERE, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM)), "")  AS COMPLEMENTO, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IFNULL(C.CLI_ENDNUM, ""), " ") AS NUMERO, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_BAIRRO, C.CLI_BAICOB) AS BAIRRO, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_C_E_P_, C.CLI_CEPCOB) AS C_E_P_, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                  '(SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS CIDADE, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                  '(SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS ESTADO  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCBI B ';
    strSQL := strSQL + '  JOIN CADCLI C ON CLI_CODCLI = CBI_CODCLI              ';
    strSQL := strSQL + '  JOIN CADREC R ON CTR_NUMDUP = CBI_NUMDUP AND          ';
    strSQL := strSQL + '                   CTR_PARCEL = CBI_PARCEL AND          ';
    strSQL := strSQL + '                   CTR_ESPDOC = CBI_ESPDOC AND          ';
    strSQL := strSQL + '                   CTR_CODEMP = CBI_CODEMP AND          ';
    strSQL := strSQL + '                   CTR_CODCLI = CBI_CODCLI              ';
    strSQL := strSQL + '  LEFT JOIN LOGNFE L ON L.NFE_NUMDOC = B.CBI_NUMDUP AND ';
    strSQL := strSQL + '                        L.NFE_ESPDOC = B.CBI_ESPDOC AND ';
    strSQL := strSQL + '                        L.NFE_CODEMP = B.CBI_CODEMP AND ';
    strSQL := strSQL + '                        L.NFE_CODCLI = B.CBI_CODCLI AND ';
    strSQL := strSQL + '                        L.NFE_TIP_FC = "C"              ';
    strSQL := strSQL + '  LEFT JOIN CTRCNF F ON F.CTR_DOCCNF = R.CTR_NUMDUP AND ';
    strSQL := strSQL + '                        F.CTR_ESPCNF = R.CTR_ESPDOC AND ';
    strSQL := strSQL + '                        F.CTR_EMPCNF = R.CTR_CODEMP AND ';
    strSQL := strSQL + '                        F.CTR_CODCLI = R.CTR_CODCLI     ';
    strSQL := strSQL + '  LEFT JOIN MOVGER G ON G.GER_NUMDOC = R.CTR_NUMDUP AND ';
    strSQL := strSQL + '                        G.GER_ESPDOC = R.CTR_ESPDOC AND ';
    strSQL := strSQL + '                        G.GER_CODEMP = R.CTR_CODEMP AND ';
    strSQL := strSQL + '                        G.GER_CODCLI = R.CTR_CODCLI     ';
    strSQL := strSQL + '  WHERE                                                 ';
    strSQL := strSQL + '    CBI_CODBCO = :CODBCO AND                            ';
    strSQL := strSQL + '    R.CTR_DTAREC IS NULL                                ';

    if (fCfgSis('CONREM', varString) = 'C') THEN
       strSQL := strSQL + '  AND CBI_CARTEI = :CARTEI ';

    If (Not fEmptyStr(edtCodPor.Text)) Then
      strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR '
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + ' AND (IFNULL(CBI_CODPOR, "") = "" ';
      strSQL := strSQL + ' OR LOCATE(CBI_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    End;

    Result := strSQL;

End;

Procedure TfrmExpArqRemBtgPactual_240p.pVerificaTipoMultaEJuros();
Begin

  //Tratativas para juros de acordo com o tipo escolhido
  If strTpJuros = '3' Then
  Begin
     //strPerJur := '0,00';
     fltPerJur := 0;
  End;

  //Tratativas para multas de acordo com o tipo escolhido
  If strTpMulta = '0' Then
  Begin
     strPerMul := '0';
     fltPerMul := 0;
  End;

End;

procedure TfrmExpArqRemBtgPactual_240p.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;
    strCodBco   : String;
    strNomBco   : String;
    strDtaRem   : String;
    strDtaVen   : String;
    strDtaMor   : String;
    strDtaEmi   : String;
    strKeyDup   : String;
    strCgcEmp   : String;
    strCgcCli   : String;
    strCodCar   : String;
    strCodCarRem: String;
    strCpfCgc   : String;
    strCodRem   : String;
    strInstru1  : String;
    strInstru2  : String;
    strDiaPro   : String;
    strCep      : String;
    strIdeBco   : String;

    strHeader   : String;
    strHeLote   : String;
    strTransacao: String;
    strTrailler : String;
    strTrLote   : String;

    intCodSeq   : Integer;
    fltValAtr   : Double;
    txtTexto    : TextFile;
    strNovCodEmp: String;

    strAutoIncremRem: String;

    AstrEndereco    : String;

    fltValMulta    : Double;
    strValMulta    : String;
    strDiaMora     : String;
    strOcorr       : string;

    strCfgValMulta : String;

    strNota        : string;
    strMensagem    : string;
    strResp        : string;
    strCodConv     : string;
    strNumCta      : string;
    strDigCta      : string;
    strCodAge      : string;
    strDigAge      : string;

    strDigAgCt     : string;
    strHorRem      : String;
    strCodOco      : String;
    strNosNum      : String;
    strTipoDoc     : String;
    strTipoCad     : String;
    strCodProt     : String;

    // Mensagens
    strObs001      : String;
    strObs002      : String;
    strObs003      : String;
    strObs004      : String;

    fltValDup      : Double;
    strEspDoc      : String;
    strProAce      : String;

    strDtaJur   : String;
    strDtaMul   : String;
    dtaDtaMul   : TDateTime;
    strNumDup   : String;

    strUsaSac   : String;
    strBenefi   : String;
    strCnpjBen  : String;

    fltTotRem   : Double;

begin
  inherited;

  If Not fValidacoesParaExportacao Then
     Exit;

  strCodBco    := '208';
  strNomBco    := 'BANCO BTG PACTUAL S.A.';
  strNomEmp    := fRetNomeEmpresa(VS_strCodEmp);
  strIdeBco    := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'IDENTBC', '');
  strCodConv   := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'CODCONV', '');

  strNumCta    := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'NUMCTAC', '');
  strDigCta    := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'DIGCTAC', '');

  strCodAge    := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'CODAGEN', '');
  strDigAge    := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'DIGAGEN', '');
  strDigAgCt   := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'DIGAGCT', '');

  strCodCar    := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'CODCART', '');
  strCodCarRem := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'CODCARR', '');
  strInstru1   := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'INSTRU1', '');
  strDiaPro    := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'DIAPROT', '');

  strTipoDoc   := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'TIPODOC', '');
  strTipoCad   := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'TIPOCAD', '');
  strEspDoc    := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'ESPDOC_', '');
  strProAce    := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'PROACEI', '');
  strPerMul    := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'PERMULT', '');

  strTpMulta   := RetornaCodigoMulta();

  strTpJuros     := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'TPJUROS', '0');
  strCfgValMulta := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'PERMULT', '0');
  strDiaMora     := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'DIAMORA', '0');
  strResp        := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'RESPONS', 'E');
  strOcorr       := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'CODOCOR', '01');
  //strPerJur      := fGetBancoConfig(0, 'CONFIG208', 'JUROSDI', '');
  strCodProt     := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'CODPROT', '');

  strUsaSac      := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'SACAVAL', '');
  strBenefi      := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'NOMEBEN', '');
  strCnpjBen     := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'CNPJBEN', '');

  strObs001      := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'OBSERV1', '');
  strObs002      := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'OBSERV2', '');
  strObs003      := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'OBSERV3', '');
  strObs004      := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'OBSERV4', '');

  strDtaRem    := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yyyy',VS_Date);
  strHorRem    := FormatDateTime('HH', fTime()) + FormatDateTime('NN', fTime()) + FormatDateTime('SS', fTime());

  fltPerMul := fStrToFloat(strPerMul);

  strCnpjBen := fTiraCaracEspeciaisPonto(strCnpjBen);

  Try
    qryConsultaGen := fCriaQuery(qryConsultaGen);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + ' EMP_C_G_C_  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    qryConsultaGen.Close;
    qryConsultaGen.SQL.Clear;
    qryConsultaGen.SQL.Add(strSQL);
    qryConsultaGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryConsultaGen.Open;
    strCgcEmp := qryConsultaGen.FieldByName('EMP_C_G_C_').AsString;

    qryConsultaGen.Close;
  Finally
    FreeAndNil(qryConsultaGen);
  End;

  Try
    strCartei  := 'CONFIG208-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
    qryRemessa := fCriarQueryRemessa;

    If Not qryRemessa.IsEmpty Then
    Begin
      strCodRem    := fStrZero(fAtuCodSeq('CONFIG208-' + IntToStr(intCartei),'PROXNUM'), 6);
      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      Rewrite(txtTexto);

      {*********************}
      {* HEADER DO ARQUIVO *}
      {*********************}
      //intCodSeq := 1;
      strHeader := '';

      strHeader := fPadR   ('208'              , 003) +       //001 - 003  - Código do Banco na Compensação
                   fPadR   ('0000'             , 004) +       //004 - 007  - Lote de Serviço
                   fPadR   ('0'                , 001) +       //008 - 008  - Tipo de Registro
                   fPadL   (' '                , 009) +       //009 - 017  - Uso Exclusivo FEBRABAN / CNAB
                   fPadR   ('2'                , 001) +       //018 - 018  - Tipo de Inscrição da Empresa
                   fPadR   (strCgcEmp          , 014) +       //019 - 032  - Número de Inscrição da Empresa
                   fPadR   (strCodConv         , 020, ' ') +  //033 - 052  - Código do Convênio no Banco
                   fPadL   (strCodAge          , 005, '0') +  //053 - 057  - Agência Mantenedora da Conta
                   fPadL   (strDigAge          , 001) +       //058 - 058  - Dígito Verificador da Agência
                   fPadL   (strNumCta          , 012, '0') +  //059 - 070  - Número da Conta Corrente
                   fPadR   (strDigCta          , 001) +       //071 - 071  - Dígito Verificador da Conta
                   fPadR   (strDigAgCt         , 001) +       //072 - 072  - Dígito Verificador da Ag/Conta
                   fPadR   (strNomEmp          , 030) +       //073 - 102  - Nome da Empresa
                   fPadR   (strNomBco          , 030) +       //103 - 132  - Nome do Banco
                   fPadL   (' '                , 010) +       //133 - 142  - Uso Exclusivo FEBRABAN / CNAB
                   fPadR   ('1'                , 001) +       //143 - 143  - Código Remessa / Retorno
                   fPadR   (strDtaRem          , 008) +       //144 - 151  - Data de Geração do Arquivo
                   fPadR   (strHorRem          , 006) +       //152 - 157  - Hora de Geração do Arquivo
                   fPadR   (strCodRem          , 006, '0') +  //158 - 163  - Número Seqüencial do Arquivo
                   fPadR   ('103'              , 003) +       //164 - 166  - No da Versão do Layout do Arquivo
                   fStrZero('0'                , 005) +       //167 - 171  - Densidade de Gravação do Arquivo
                   fPadR   (' '                , 020) +       //172 - 191  - Para Uso Reservado do Banco
                   fPadR   (' '                , 020) +       //192 - 211  - Para Uso Reservado da Empresa
                   fPadR   (' '                , 029);        //212 - 240  - Uso Exclusivo FEBRABAN / CNAB

      {**************************************}
      {* ESCREVE O HEADER DO ARQUIVO NO TXT *}
      {**************************************}
      Writeln(txtTexto,untFuncAutban.fRetirarCaracteresEspeciais(strHeader));


      {******************}
      {* HEADER DO LOTE *}
      {***************JU*}
      strHeLote := '';
      strHeLote := fPadR   ('208'              , 003) +      //001 - 003   Código do Banco na Compensação
                   fPadR   ('0001'             , 004) +      //004 - 007   Lote de Serviço
                   fPadR   ('1'                , 001) +      //008 - 008   Tipo de Registro
                   fPadR   ('R'                , 001) +      //009 - 009   Tipo de Operação
                   fPadR   ('01'               , 002) +      //010 - 011   Tipo de Serviço
                   fPadR   (' '                , 002) +      //012 - 013   Uso Exclusivo FEBRABAN/CNAB
                   fPadR   ('060'              , 003) +      //014 - 016   Nº da Versão do Layout do Lote
                   fPadR   (' '                , 001) +      //017 - 017   Uso Exclusivo FEBRABAN/CNAB
                   fStrZero('2'                , 001) +      //018 - 018   Tipo de Inscrição da Empresa
                   fStrZero(strCgcEmp          , 015) +      //019 - 033   Nº de Inscrição da Empresa
                   fPadR   (strCodConv         , 020) +      //034 - 053   Código do Convênio no Banco
                   fStrZero(strCodAge          , 005) +      //054 - 058   Agência Mantenedora da Conta
                   fPadR   (strDigAge          , 001) +      //059 - 059   Dígito Verificador da Conta
                   fStrZero(strNumCta          , 012) +      //060 - 071   Número da Conta Corrente
                   fPadR   (strDigCta          , 001) +      //072 - 072   Dígito Verificador da Conta
                   fPadR   (strDigAgCt         , 001) +      //073 - 073   Dígito Verificador da Ag/Conta
                   fPadR   (strNomEmp          , 030) +      //074 - 103   Nome da Empresa
                   fPadR   (strObs001          , 040) +      //104 - 143   Mensagem 1
                   fPadR   (strObs002          , 040) +      //144 - 183   Mensagem 2
                   fPadR   (strCodRem          , 008, '0') + //184 - 191 - Número Remessa/Retorno
                   fPadR   (strDtaRem          , 008) +      //192 - 199 - Data de Gravação Remessa/Retorno
                   fPadR   ('00000000'         , 008) +      //200 - 207 - Data do Crédito
                   fPadR   (' '                , 033);       //208 - 240 - Uso Exclusivo FEBRABAN/CNAB

      {***********************************}
      {* ESCREVE O HEADER DO LOTE NO TXT *}
      {***********************************}
      Writeln(txtTexto,untFuncAutban.fRetirarCaracteresEspeciais(strHeLote));

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, strCodBco, 'CONFIG208-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strCodRem), strAutoIncremRem);

      {********************************************}
      {* INICIA REGISTROS DE TRANSAÇÃO DO ARQUIVO *}
      {********************************************}
      strTransacao := '';
      intCodSeq    := 0;

      fltTotRem    := 0;

      While Not qryRemessa.Eof Do
      Begin
        Inc(intCodSeq);
        Application.ProcessMessages;

        //fltValAtr := fFormataFloat((qryRemessa.FieldByName('CBI_VALDUP').AsFloat *
        //                            qryRemessa.FieldByName('CBI_PORCEN').AsFloat) / 100, 2);

        strCpfCgc := IIF(qryRemessa.FieldByName('CBI_CGCCPF').AsInteger = 1, '2', '1');

        strCodOco := qryRemessa.FieldByName('CBI_CODOCO').AsString;
        If fEmptyStr(strCodOco) Then
           strCodOco := '01';

        strInstru1 := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'INSTRU1', '');
        strInstru2 := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'INSTRU2', '');

        strDtaVen := FormatDateTime('dd',qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime) +
                     FormatDateTime('mm',qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime) +
                     FormatDateTime('yyyy',qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime);

        strDtaMor := FormatDateTime('ddmmyy',qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime+1);

        strDtaEmi := FormatDateTime('dd',qryRemessa.FieldByName('CBI_DTACAD').AsDateTime) +
                     FormatDateTime('mm',qryRemessa.FieldByName('CBI_DTACAD').AsDateTime) +
                     FormatDateTime('yyyy',qryRemessa.FieldByName('CBI_DTACAD').AsDateTime);

        if not TEspecieParaArquivoRemessa.New.fValidaEspecie(qryRemessa.FieldByName('CBI_ESPDOC').AsString) then
        begin
          fRollBack;
          CloseFile(txtTexto);
          If FileExists(fraPathRemessa.edtDirectory.text + edtNomArquivo.Text) Then
            DeleteFile(fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
          Exit;
        end;

        strKeyDup := fPadR(qryRemessa.FieldByName('CBI_NUMDUP').AsString, 12) +
                     fPadR(qryRemessa.FieldByName('CBI_PARCEL').AsString, 03) +
                     fPadR(qryRemessa.FieldByName('CBI_ESPDOC').AsString, 02) +
                     fPadR(qryRemessa.FieldByName('CBI_CODEMP').AsString, 03);

        strNumDup := RightStr(qryRemessa.FieldByName('CBI_NUMDUP').AsString +
                              qryRemessa.FieldByName('CBI_PARCEL').AsString +
                              qryRemessa.FieldByName('CBI_ESPDOC').AsString, 15);


        strNosNum := qryRemessa.FieldByName('CBI_NOSNUM').AsString;

        AstrEndereco := RetornaEnderecoENumeroCom40Caracteres(qryRemessa.FieldByName('ENDERE').AsString, qryRemessa.FieldByName('NUMERO').AsString);

        strCgcEmp := Trim(strCgcEmp);
        strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
        strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
        strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

        strCgcCli := Trim(qryRemessa.FieldByName('CBI_C_G_C_').AsString);
        strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
        strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
        strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

        strCep := Trim(qryRemessa.FieldByName('C_E_P_').AsString);
        strCep := AnsiReplaceStr(strCep, '-', '');

        fltValDup := qryRemessa.FieldByName('CBI_VALDUP').AsFloat;

        dtaDtaMul := qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime;
        dtaDtaMul := dtaDtaMul + StrToInt(strDiaMora);

        If strPerMul = '0' Then
           strDtaMul :=  '0'
        Else
           strDtaMul := FormatDateTime(  'dd',dtaDtaMul) +
                        FormatDateTime(  'mm',dtaDtaMul) +
                        FormatDateTime('yyyy',dtaDtaMul);

        //strPerJur := qryRemessa.FieldByName('CBI_PORCEN').AsFloat;

        //If fEmptyStr(strPerJur) Then
        //strPerJur := '0,00';

        fltPerJur := IIF(strTpJuros <> '2',  qryRemessa.FieldByName('CBI_PORCEN').AsFloat,
                                            (qryRemessa.FieldByName('CBI_PORCEN').AsFloat*30) );

        //If strPerJur <> '0,00' Then
        If (fltPerJur > 0) Then
        begin
           strDtaJur := FormatDateTime('dd',dtaDtaMul) +
                        FormatDateTime('mm',dtaDtaMul) +
                        FormatDateTime('yyyy',dtaDtaMul);
        end;

        pVerificaTipoMultaEJuros();

        //************************//
        //SEGMENTO P              //
        //************************//
        strTransacao := '';
        strTransacao := fPadR      ('208'                                , 03, ' ') + //001 - 003
                        fPadR      ('0001'                               , 04, ' ') + //004 - 007
                        fPadL      ('3'                                  , 01, ' ') + //008 - 008
                        fStrZero   (IntToStr(intCodSeq)                       , 05) + //009 - 013
                        fPadL      ('P'                                  , 01, ' ') + //014 - 014
                        fPadL      (' '                                  , 01, ' ') + //015 - 015
                        fPadL      (strCodOco                            , 02, ' ') + //016 - 017 - Código de Movimento Remessa
                        fStrZero   (strCodAge                                 , 05) + //018 - 022
                        fPadR      (strDigAge                            , 01, ' ') + //023 - 023
                        fStrZero   (strNumCta                                , 12)  + //024 - 035
                        fPadR      (strDigCta                            , 01     ) + //036 - 036
                        fPadR      (strDigAgCt                           , 01, ' ') + //037 - 037 - Dígito Verificador da Ag/Conta
                        fPadR      (strNosNum                            , 20)      + //038 - 057 - Identificação do Título no Banco
                        fPadR      (strCodCar                            , 01)      + //058 - 058 - Código da Carteira
                        fPadR      (strTipoDoc                           , 01)      + //059 - 059 - Forma de Cadastr. do Título no Banco -> '1' = Com Cadastramento (Cobrança Registrada);
                        fPadR      (strTipoCad                           , 01)      + //060 - 060 - Tipo Documento;
                        fPadR      (IIF(strResp = 'B', '1', '2')         , 01, ' ') + //061 - 061 - Emissao do Boleto -> '1' = Banco Emite; '2' = Cliente Emite;
                        fPadR      (IIF(strResp = 'B', '1', '2')         , 01, ' ') + //062 - 062 - Identificação da Distribuição
                        fPadL      (strNumDup                            , 15, '0') + //063 - 077  Número do Documento de Cobrança
                        fPadR      (strDtaVen                            , 08, ' ') + //078 - 085  Data de Vencimento do Título
                        fValNumForm(fltValDup                            , 15     ) + //086 - 100  Valor Nominal do Título
                        fPadR      ('0'                                  , 05, '0') + //101 - 105  Agência Encarregada da Cobrança
                        fPadR      (' '                                  , 01, ' ') + //106 - 106  Dígito Verificador da Agência
                        fPadR      (strEspDoc                            , 02, ' ') + //107 - 108  Espécie do Título
                        fPadR      (IIF(strProAce = 'S', 'A', 'N')       , 01, ' ') + //109 - 109  Identific. de Título Aceito/Não Aceito
                        fPadR      (strDtaEmi                            , 08, ' ') + //110 - 117  Data da Emissão do Título
                        fPadR      (strTpJuros                           , 01, ' ') + //118 - 118  Código do Juros de Mora
                        fPadR      (IIF(fltPerJur > 0,strDtaJur,'00000000') , 08, ' ') + //119 - 126  Data do Juros de Mora
                        fValNumForm(fltPerJur                            , 15     ) + //127 - 141  Juros de Mora por Dia/Taxa
                        fPadR      ('0'                                  , 01, ' ') + //142 - 142  Código do Desconto 1
                        fPadR      ('00000000'                           , 08, ' ') + //143 - 150  Data do Desconto 1
                        fPadR      ('0'                                  , 15, '0') + //151 - 165  Valor/Percentual a ser Concedido
                        fPadR      ('0'                                  , 15, '0') + //166 - 180  Valor do IOF a ser Recolhido
                        fPadR      ('0'                                  , 15, '0') + //181 - 195  Valor do Abatimento
                        fPadR      (strKeyDup                            , 25, ' ') + //196 - 220  Identificação do Título na Empresa
                        fPadR      (strCodProt                           , 01, ' ') + //221 - 221  Código para Protesto
                        fPadL      (strDiaPro                            , 02, '0') + //222 - 223  Número de Dias para Protesto
                        fPadR      ('0'                                  , 01, ' ') + //224 - 224  Código para Baixa/Devolução
                        fPadR      (' '                                  , 03, ' ') + //225 - 227  Número de Dias para Baixa/Devolução
                        fStrZero   ('9'                                  , 02     ) + //228 - 229  Código da Moeda
                        fStrZero   ('0'                                  , 10     ) + //230 - 239  Nº do Contrato da Operação de Créd.
                        fPadR      (' '                                  , 01, ' ');  //240 - 240  Uso livre banco/empresa ou autorização de pagamento parcial

        {******************************************}
        {* ESCREVE O REGISTRO DE TRANSACAO NO TXT *}
        {******************************************}
        Writeln(txtTexto,untFuncAutban.fRetirarCaracteresEspeciais(strTransacao));

        //************************//
        //SEGMENTO Q              //
        //************************//
        Inc(intCodSeq);
        strTransacao := '';
        strTransacao := fPadR   ('208'                                                           , 03, '0') + //001 - 007 - Código do Banco na Compensação
                        fPadL   ('0001'                                                          , 4, ' ')  + //008 - 008 - Lote de Serviço
                        fPadL   ('3'                                                             , 01, ' ') + //008 - 008 - Tipo de Registro
                        fStrZero(IntToStr(intCodSeq)                                             , 05)      + //009 - 013 - Nº Sequencial do Registro no Lote
                        fPadL   ('Q'                                                             , 01, ' ') + //014 - 014 - Cód. Segmento do Registro Detalhe
                        fPadL   (' '                                                             , 01, ' ') + //015 - 015 - Uso Exclusivo FEBRABAN/CNAB
                        fPadL   (strCodOco                                                       , 02, ' ') + //016 - 017 - Código de Movimento Remessa
                        fPadR   (IIF(Length(Trim(strCgcCli)) > 11, '2', '1')                     , 01)      + //018 - 019 - Tipo de Inscrição
                        fPadL   (strCgcCli                                                       , 15, '0') + //020 - 033 - Número de Inscrição
                        fPadR   (RetiraQuebraLinha(qryRemessa.FieldByName('CLI_NOMCLI').AsString), 40, ' ') + //034 - 073 - Nome
                        fPadR   (RetiraQuebraLinha(AstrEndereco)                                 , 40, ' ') + //074 - 113 - Endereço
                        fPadR   (RetiraQuebraLinha(qryRemessa.FieldByName('BAIRRO').AsString)    , 15, ' ') + //114 - 128 - Bairro
                        fPadR   (LeftStr(qryRemessa.FieldByName('C_E_P_').AsString               , 5),  05) + //129 - 133 - CEP
                        fPadR   (RightStr(qryRemessa.FieldByName('C_E_P_').AsString              , 3),  03) + //134 - 136 - Sufixo do CEP
                        fPadR   (RetiraQuebraLinha(qryRemessa.FieldByName('CIDADE').AsString)    , 15, ' ') + //137 - 151 - Cidade
                        fPadR   (qryRemessa.FieldByName('ESTADO').AsString                       , 02, ' ') + //152 - 153 - Unidade da Federação
                        fPadL   (IIF(strUsaSac='S',IIF(Length(strCgcEmp) > 11,'2','1'),'0')      , 01)      + //154 - 154 - Tipo de Inscrição
                        fPadL   (IIF(strUsaSac='S',strCnpjBen, '0')                              , 15, '0') + //155 - 169 - Número de Inscrição
                        fPadR   (IIF(strUsaSac='S',strBenefi,' ')                                , 40, ' ') + //170 - 209 - Nome do Sacador/Avalista
                        fPadL   ('0'                                                             , 03, '0') + //210 - 212 - Cód. Bco. Corresp. na Compensação
                        fPadL   (' '                                                             , 20, ' ') + //213 - 232 - Nosso Nº no Banco Correspondente
                        fPadR   (' '                                                             , 08, ' ') ; //233 - 240 - Uso Exclusivo FEBRABAN/CNAB

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************JU*}
          Writeln(txtTexto,untFuncAutban.fRetirarCaracteresEspeciais(strTransacao));

          {************************}
          {* TRANSAÇÃO SEGMENTO R *}
          {************************}
          Inc(intCodSeq);
          strTransacao := '';
          strTransacao := fPadR      ('208'                                , 03, ' ') + //001 - 003 - Código do Banco na Compensação
                          fPadR      ('0001'                               , 04, ' ') + //004 - 007 - Lote de Serviço
                          fPadL      ('3'                                  , 01, ' ') + //008 - 008 - Tipo de Registro
                          fStrZero   (IntToStr(intCodSeq)                       , 05) + //009 - 013 - Nº Sequencial do Registro no Lote
                          fPadL      ('R'                                  , 01, ' ') + //014 - 014 - Cód. Segmento do Registro Detalhe
                          fPadR      (' '                                  , 01, ' ') + //015 - 015 - Uso Exclusivo FEBRABAN/CNAB
                          fPadL      (strCodOco                            , 02, ' ') + //016 - 017 - Código de Movimento Remessa
                          fPadR      ('0'                                  , 01, '0') + //018 - 018 - Código do Desconto 2
                          fPadL      ('0'                                  , 08, '0') + //019 - 026 - Data do Desconto 2
                          fPadL      ('0'                                  , 15, '0') + //027 - 041 - Valor/Percentual a ser Concedido
                          fPadR      ('0'                                  , 01, '0') + //042 - 042 - Código do Desconto 3
                          fPadL      ('0'                                  , 08, '0') + //043 - 050 - Data do Desconto 3
                          fPadL      ('0'                                  , 15, '0') + //051 - 065 - Valor/Percentual a Ser Concedido
                          fPadL      (IIF(strPerMul <> '0',strTpMulta,'0') , 01, ' ') + //066 - 066 - Código da Multa
                          fPadR      (IIF(strPerMul <> '0', strDtaMul,
                                                            '00000000')    , 08, '0') + //067 - 074 - Data da Multa
                          fValNumForm(fltPerMul                            , 15     ) + //075 - 089 - Valor/Percentual a Ser Aplicado
                          fPadL      (' '                                  , 10, ' ') + //090 - 099 - Informação ao Pagador
                          fPadR      (strObs001                            , 40, ' ') + //100 - 139 - Mensagem 3
                          fPadR      (strObs002                            , 40, ' ') + //140 - 179 - Mensagem 4
                          fPadR      (' '                                  , 20, ' ') + //180 - 199 - Uso Exclusivo FEBRABAN/CNAB
                          fPadR      ('0'                                  , 08, '0') + //200 - 207 - Cód. Ocor. do Pagador
                          fPadR      ('0'                                  , 03, '0') + //208 - 210 - Cód. do Banco na Conta do Débito
                          fPadR      ('0'                                  , 05, '0') + //211 - 215 - Código da Agência do Débito
                          fPadR      ('0'                                  , 01, '0') + //216 - 216 - Dígito Verificador da Agência
                          fPadR      ('0'                                  , 12, '0') + //217 - 228 - Conta Corrente para Débito
                          fPadR      ('0'                                  , 01, '0') + //229 - 229 - Dígito Verificador da Conta
                          fPadR      ('0'                                  , 01, '0') + //230 - 230 - Dígito Verificador Ag/Conta
                          fPadR      ('0'                                  , 01, '0') + //231 - 231 - Aviso para Débito Automático
                          fPadR      (' '                                  , 09, ' ') ; //232 - 240 - Uso Exclusivo FEBRABAN/CNAB

        {******************************}
        {* ESCREVE A TRANSACAO NO TXT *}
        {***************************JU*}
        Writeln(txtTexto,untFuncAutban.fRetirarCaracteresEspeciais(strTransacao));

        fltTotRem := fltTotRem + QryRemessa.FieldByName('CBI_VALDUP').AsFloat;

        {*****************************}
        {* GRAVAÇÃO DA TABELA REMDET *}
        {**** DETALHES DA REMESSA ****}
        {*****************************}
        pGravaRemDet(strAutoIncremRem,
                     QryRemessa.FieldByName('AUTOINCREM').AsString,
                     QryRemessa.FieldByName('CBI_NOSNUM').AsString,
                     0,
                     QryRemessa.FieldByName('CBI_VALDUP').AsFloat,
                     QryRemessa.FieldByName('CTR_DTAREC').AsDateTime,
                     QryRemessa.FieldByName('CBI_DTAVEN').AsDateTime,
                     VS_Date,
                     strLoginUsuarioLogado,
                     '');

        {****************}
        {* GRAVA LOGCTR *}
        {*************JS*}
        untLogCtr.GravaLogCtr(qryRemessa.FieldByName('AUTOINCREM').AsString, 'EXPORTAÇÃO DE ARQUIVO DE REMESSA - ' + strCodBco, Self.Name);

        qryRemessa.Next;
      End;

      {********************}
      {* TRAILLER DO LOTE *}
      {********************}
      strTrLote := '';
      strTrLote := '208'                  +              //001 - 003 - Código do Banco na Compensação
                   fPadR('0001', 04, ' ') +              //004 - 007 - Lote de Serviço
                   fPadR('5'   , 01, ' ') +              //008 - 008 - Tipo de Registro
                   fPadR(' '   , 09, ' ') +              //009 - 017 - Uso Exclusivo FEBRABAN/CNAB
                   fPadL(IntToStr(intCodSeq+2), 06, '0')+//018 - 023 - Quantidade de Registros no Lote
                   fPadL(IntToStr(intCodSeq), 06, '0')+  //024 - 029 - Quantidade de Títulos em Cobrança
                   fValNumForm(fltTotRem         , 17)+  //030 - 046 - Valor Total dosTítulos em Carteiras
                   fPadL('0'   , 06, '0') +              //047 - 052 - (Totalização da Cobrança Vinculada)  - Quantidade de Títulos em Cobrança
                   fPadL('0'   , 17, '0') +              //053 - 069 - (Totalização da Cobrança Vinculada)  - Valor Total dosTítulos em Carteiras
                   fPadL('0'   , 06, '0') +              //070 - 075 - (Totalização da Cobrança Caucionada) - Quantidade de Títulos em Cobrança
                   fPadL('0'   , 17, '0') +              //076 - 092 - (Totalização da Cobrança Caucionada) - Quantidade de Títulos em Carteiras
                   fPadL('0'   , 06, '0') +              //093 - 098 - (Totalização da Cobrança Descontada) - Quantidade de Títulos em Cobrança
                   fPadL('0'   , 17, '0') +              //099 - 115 - (Totalização da Cobrança Descontada) - Valor Total dos Títulos em Carteiras
                   fPadL(' '   ,  8, ' ') +              //116 - 123 - Número do Aviso de Lançamento
                   fPadL(' '   ,117, ' ');               //124 - 240 - Uso Exclusivo FEBRABAN/CNAB
      {******************************}
      {* ESCREVE O TRAILLER DO LOTE *}
      {******************************}
      Writeln(txtTexto,untFuncAutban.fRetirarCaracteresEspeciais(strTrLote));

      {***********************}
      {* TRAILLER DO ARQUIVO *}
      {***********************}
      intCodSeq   := intCodSeq + 3;
      strTrailler := '';
      strTrailler := '208'                     + //001 - 003 - Código do Banco na Compensação
                     fPadL    ('9999', 4, ' ') + //004 - 007 - Lote de Serviço
                     fPadR    ('9',    1, ' ') + //008 - 008 - Tipo de Registro
                     fPadR    (' ',    9, ' ') + //009 - 017 - Uso Exclusivo FEBRABAN/CNAB
                     fStrZero (1,           6) + //018 - 023 - Quantidade de Lotes do Arquivo
                     fStrZero (intCodSeq, 006) + //024 - 029 - Quantidade de Registros do Arquivo
                     fPadL    ('0',    6, '0') + //030 - 035 - Qtde de Contas p/ Conc. (Lotes)
                     fPadR    (' ',  205, ' ');  //036 - 240 - Uso Exclusivo FEBRABAN/CNAB

      {*****************************}
      {* ESCREVE O TRAILLER NO TXT *}
      {*****************************}
      Writeln(txtTexto,strTrailler);

      CloseFile(txtTexto);

      pBackupCnfBco;

      fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
                   'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.text + edtNomArquivo.Text, ['&O K']);

      pDeletaCadCbi(strCodBco, strCartei, edtCodPor.Text);

    End
    Else
      fMensagem('','Nenhum registro foi encontrado para gerar o arquivo!',['&O K']);

    FreeAndNil(qryRemessa);
  Except
		On E: Exception Do
		Begin

		  fRollBack;
      CloseFile(txtTexto);
      DeleteFile(fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);

      FreeAndNil(qryRemessa);
      FreeAndNil(qryConsultaGen);
      Raise Exception.Create('Ocorreu um erro ao gerar o arquivo de remessa do banco ' + strCodBco + '-' + strNomBco + #13 +
                             'Erro gerado: ' + E.Message);
		End;
  End;

end;

procedure TfrmExpArqRemBtgPactual_240p.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemBtgPactual_240p.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples,
                     Self,
                     edtCodPor,
                     TEditFocus(edtDesPor),
                     nil,
                     Key,
                     arrSel,
                     True,
                     'Consulta de Portadores',
                     '',
                     False,
                     False,
                     '',
                     False,
                     True) then
    Begin
      if fValidaCampos(edtCodPor) then
        Self.SelectNext((Sender As TWinControl), True, True);
    End;
  End;
end;

procedure TfrmExpArqRemBtgPactual_240p.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemBtgPactual_240p.FormCreate(Sender: TObject);
begin
  inherited;
     qryCadPor := fCriaQuery(Self);
end;

end.
