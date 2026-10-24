unit untPnlDadosOU_TE;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, UniClientDataSet, Uni, StrUtils,
  cxProgressBar, BitBtnLockedIncrem, untFuncFat;

type
  TfrmPnlDadosOU_TE = class(TForm)
    pnl1: TPanel;
    btnGerarPDF: TBitBtnLocked;
    btnEnviarEmail: TBitBtnLocked;
    btnBaixaPedido: TBitBtnLocked;
    btnItensPend: TBitBtnLocked;
    btnImpSep: TBitBtnLocked;
    procedure btnEnviarEmailClick(Sender: TObject);
    procedure btnGerarPDFClick(Sender: TObject);
    procedure btnBaixaPedidoClick(Sender: TObject);
    procedure btnItensPendClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnImpSepClick(Sender: TObject);
  private
    { Private declarations }
    blnConfirma: Boolean;
    strCodOco: String;
    procedure pDesabilitaColunas;
    procedure pMostraItensPendentes;
    procedure pInfoStatusGravacao(strInformacao: String; pgbProgresso: TcxProgressBar);
    procedure pStepStatusGravacao(pgbProgresso: TcxProgressBar);

    function fGetOcorrencia: String;
    function fBaixaPedido(pgbStatus: TcxProgressBar = Nil): Boolean;
  public
    { Public declarations }
    cdsConsulta: TUniClientDataSet;
    constructor Create(AOwner: TComponent); reintroduce; virtual;
  end;

  TfrmPnlDadosOU_TEClass = Class Of TfrmPnlDadosOU_TE;

var
  frmPnlDadosOU_TE: TfrmPnlDadosOU_TE;

implementation

uses untFuncoesSimples, untFatGorEmail, untDigEmailPedOrc,
  untGeraPDFPedOrc, untReimpressao, untDigOcorrencia, untMostraItensPendentes,
  untGravando, untTypesSistema, untTEnvioEmail, untFuncoesRel, untFuncoesRel2;

{$R *.dfm}

{ TfrmPnlDadosOU_TE }

procedure TfrmPnlDadosOU_TE.btnBaixaPedidoClick(Sender: TObject);
begin
  inherited;

  If (Not btnBaixaPedido.Visible) Then
    Exit;

  If (cdsConsulta.IsEmpty) Then
    Exit;

  If (cdsConsulta.FieldByName('FGO_ESPDOC').AsString = 'OR')
    And (Not fVerificaAcessoSistema('BAIPDV', strLoginUsuarioLogado)) Then Begin
    fMensagem('ATENÇÃO!', 'Esse usuário não tem direitos para executar essa operação!', ['&Ok']);
    Exit;
  End;

  If (cdsConsulta.FieldByName('FGO_ESPDOC').AsString = 'PD')
    And (Not fVerificaAcessoSistema('BXPNFT', strLoginUsuarioLogado)) Then Begin
    fMensagem('ATENÇÃO!', 'Esse usuário não tem direitos para executar essa operação!', ['&Ok']);
    Exit;
  End;

  strCodOco := fGetOcorrencia;

  If fEmptyStr(strCodOco) Then
    Exit
  Else
  Begin
    Try
      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.fExecutarAcao := fBaixaPedido;
      frmGravando.ShowModal;
      pFreeAndNil(frmGravando);
    Except
      On E: Exception Do
      Begin
        pFreeAndNil(frmGravando);
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

procedure TfrmPnlDadosOU_TE.btnEnviarEmailClick(Sender: TObject);
  Var
    strArqHtml          : String;
    strTexto            : String;
    strAssunto          : String;
    strDestinatario     : String;
    strEmailDestinatario: String;
    strOrdem : String;
    strTipExp: String;
    opcComSemPreco: TImpressaoComSemPrecoOrPd;
    blnComMar: Boolean;
    blnLocFis: Boolean;
    strModo  : String;
    arrArquivos, arrDestinatarios : TStringArray;
begin
  inherited;
  opcComSemPreco := impSemPrecoGeral;
  blnComMar := False;
  blnLocFis := False;

  strAssunto := '';
  strDestinatario      := cdsConsulta.FieldByName('CLI_NOMCLI').AsString;
  strEmailDestinatario := cdsConsulta.FieldByName('CLI_EMAIL_').AsString;

  Try
    pCriarFormularios(TfrmDigEmailPedOrc, frmDigEmailPedOrc);
    frmDigEmailPedOrc.strEspDoc := cdsConsulta.FieldByName('FGO_ESPDOC').AsString;
    frmDigEmailPedOrc.pnlEmpCab.Visible := False;
    frmDigEmailPedOrc.edtEmail.Text   := strEmailDestinatario;
    frmDigEmailPedOrc.edtContato.Text := strDestinatario;
    blnConfirma := (frmDigEmailPedOrc.ShowModal = mrOk);

    If (blnConfirma) Then
    Begin
      strDestinatario      := frmDigEmailPedOrc.edtContato.Text;
      strEmailDestinatario := frmDigEmailPedOrc.edtEmail.Text;
      opcComSemPreco       := frmDigEmailPedOrc.opcComSemPreco;
      blnComMar            := frmDigEmailPedOrc.chkMarca.Checked;
      blnLocFis            := frmDigEmailPedOrc.chkLocFis.Checked;
      strTipExp            := frmDigEmailPedOrc.strTipExp;
      strOrdem             := frmDigEmailPedOrc.edtOrdem.Text;
      strModo              := frmDigEmailPedOrc.edtModo.Text;
    End;
  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      pMensagensErro(E.Message, '[]');
    End;
  End;
  pFreeAndNil(frmDigEmailPedOrc);

  If (Not blnConfirma) Then
    Exit;

  {*******************************************}
  {* RETORNA A VARIAVEL strNomeArquivo       *}
  {****************************************AC*}
  Try
    pCriarFormularios(TfrmFatGorEmail, frmFatGorEmail);
    strArqHtml := frmFatGorEmail.fGeraEmail(cdsConsulta.FieldByName('FGO_NUMDOC').AsString,
                                            cdsConsulta.FieldByName('FGO_ESPDOC').AsString,
                                            opcComSemPreco,
                                            blnComMar,
                                            strTipExp,
                                            strModo,
                                            strOrdem,
                                            cdsConsulta.FieldByName('FGO_CODEMP').AsString,
                                            blnLocFis,
                                            'R',
                                            cdsConsulta.FieldByName('FGO_CODCLI').AsString);
  Finally
    pDestroiModulo(frmFatGorEmail);
  End;

  If (Not fEmptyStr(strArqHtml)) Then
  Begin

    {************************************************}
    {* AQUI É GERADO O EMAIL E EXPORTADO EM PDF     *}
    {*********************************************AC*}
    If (cdsConsulta.FieldByName('FGO_ESPDOC').AsString = 'PD') Then
    Begin
      strAssunto := 'Pedido Nº: ';
      strTexto := 'Segue em anexo Pedido.';
    End
    Else
    Begin
      strAssunto := 'Orçamento Nº: ';
      strTexto := 'Segue em anexo Orçamento.';
    End;

    If strTipExp = 'P' Then
    Begin
      strTexto := strTexto + #13#10 + #13#10;
      strTexto := strTexto + 'Caso não possua o programa Acrobat Reader para visualizar o arquivo anexo, ';
      strTexto := strTexto + 'acesse o link e faça o download: <a href="https://www.adobe.com">www.adobe.com</a>';
    End;

    strAssunto := fRetNomeEmpresa + ' - ' + strAssunto + cdsConsulta.FieldByName('FGO_NUMDOC').AsString;

    pCriarArrayAnexosEDestinatarios(strArqHtml, strEmailDestinatario, arrDestinatarios, arrArquivos);

    TEnvioEmail.EnviarEmail(Self, strLoginUsuarioLogado, strAssunto, arrDestinatarios, [], [], TEnvioEmail.ContruirArrayMensagem(strTexto), arrArquivos);

    SetForegroundWindow(Handle);
  End
  Else
    fMensagem('ATENÇÃO!', 'Não foi possível exportar o arquivo PDF !', ['&Ok']);
end;

procedure TfrmPnlDadosOU_TE.btnGerarPDFClick(Sender: TObject);
Var
  strArquivo: String;
  strOrdem  : String;
  blnComMar : Boolean;
  blnLocFis : Boolean;
  opcComSemPreco: TImpressaoComSemPrecoOrPd;
  strModo   : String;
begin
  blnComMar := False;
  blnLocFis := False;
  opcComSemPreco := impSemPrecoGeral;
  inherited;

  If Not fLayoutAtivoPdfPedidoOrcamento(cdsConsulta.FieldByName('FGO_NUMDOC').AsString,
                                        cdsConsulta.FieldByName('FGO_ESPDOC').AsString,
                                        VS_strCodEmp) Then
  Begin
    fMensagem('ATENÇÃO', 'Não há Layout Disponível para gerar PDF!', ['&O k']);
    Exit;
  End
  Else
  Begin
    Try
      pCriarFormularios(TfrmGeraPDFPedOrc, frmGeraPDFPedOrc);
      frmGeraPDFPedOrc.pnlEmpCab.Visible := False;
      frmGeraPDFPedOrc.strEspDoc := cdsConsulta.FieldByName('FGO_ESPDOC').AsString;
      blnConfirma := (frmGeraPDFPedOrc.ShowModal = mrOk);

      If (blnConfirma) Then
      Begin
        strOrdem  := frmGeraPDFPedOrc.edtOrdem.Text;
        blnComMar := frmGeraPDFPedOrc.chkMarca.Checked;
        blnLocFis := frmGeraPDFPedOrc.chkLocFis.Checked;
        opcComSemPreco := frmGeraPDFPedOrc.opcComSemPreco;
        strModo   := frmGeraPDFPedOrc.edtModo.Text;
      End;

    Except
      On E: Exception Do
      Begin
        blnConfirma := False;
        pMensagensErro(E.Message, '[]');
      End;
    End;
    pFreeAndNil(frmGeraPDFPedOrc);

    If (Not blnConfirma) Then
      Exit;
  End;

  Try
    pCriarFormularios(TfrmFatGorEmail, frmFatGorEmail);

    strArquivo := frmFatGorEmail.fGeraEmail(cdsConsulta.FieldByName('FGO_NUMDOC').AsString,
                                            cdsConsulta.FieldByName('FGO_ESPDOC').AsString,
                                            opcComSemPreco,
                                            blnComMar,
                                            'P',
                                            strModo,
                                            strOrdem,
                                            cdsConsulta.FieldByName('FGO_CODEMP').AsString,
                                            blnLocFis,
                                            'R',
                                            cdsConsulta.FieldByName('FGO_CODCLI').AsString);
  Finally
    pDestroiModulo(frmFatGorEmail);
  End;

  If (Not fEmptyStr(strArquivo)) Then
    pExecArquivo(strArquivo, Handle);
end;

procedure TfrmPnlDadosOU_TE.btnImpSepClick(Sender: TObject);
  Var
    objImpSep: TReimpressao;
    blnImpSep: Boolean;
begin
  inherited;

  If Not btnImpSep.Visible Then
    Exit;

  With cdsConsulta Do
  Begin

    If IsEmpty Then
      Exit;

    blnImpSep := (VS_strTipExp = '2') Or (fCfgSis('SEPEXP') = 'E');

    objImpSep := TReimpressao.Create(FieldByName('FGO_NUMDOC').AsString,  //strNumDoc
                                     FieldByName('FGO_ESPDOC').AsString,  //strEspDoc
                                     0,                                   //dtaDtaIni
                                     0,                                   //dtaDtaFin
                                     FieldByName('FGO_CODCLI').AsString,  //strCodCli
                                     FieldByName('FGO_CODEMP').AsString,  //strCodEmp
                                     FieldByName('FGO_CODVEN').AsString,  //strCodVen
                                     VS_strTipExp = '2',                  //blnFaturamento
                                     '',                                  //strTip_Fc
                                     blnImpSep,                           //blnPergSep
                                     False,                               //blnFatVenda
                                     False,                               //blnCancelamento
                                     '',                                  //strEspSel
                                     '',                                  //strSerie
                                     False,                               //blnFiltrarNE
                                     0,                                   //intFilCla
                                     False,                               //blnExiDocsCanc
                                     '');                                 //strOriDoc

    objImpSep.blnExpedicao := True;

    objImpSep.fImprimeSeparacao('', False, False, False, (VS_strTipExp <> '2'), False);

    FreeAndNil(objImpSep);

  End;
end;

procedure TfrmPnlDadosOU_TE.btnItensPendClick(Sender: TObject);
begin
  If (Not btnItensPend.Enabled) Or (Not btnItensPend.Visible) Then
    Exit;

  If (cdsConsulta.IsEmpty) Then
    Exit;

  pMostraItensPendentes;

end;

constructor TfrmPnlDadosOU_TE.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

function TfrmPnlDadosOU_TE.fBaixaPedido(pgbStatus: TcxProgressBar): Boolean;
begin
  fStartTransaction;

  Try
    pInfoStatusGravacao('Aguarde... Baixando ' + IfThen((cdsConsulta.FieldByName('FGO_ESPDOC').AsString = 'PD'),'pedido','orçamento'), pgbStatus);
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := 3;
    pStepStatusGravacao(pgbStatus);

    pBaixaPedido(cdsConsulta.FieldByName('FGO_NUMDOC').AsString,
                 cdsConsulta.FieldByName('FGO_ESPDOC').AsString,
                 cdsConsulta.FieldByName('FGO_CODEMP').AsString,
                 strCodOco);

    pStepStatusGravacao(pgbStatus);

    fCommit;

    pStepStatusGravacao(pgbStatus);

    //edtFiltro1Change(edtFiltro1);

    Result := True;

    If cdsConsulta.FieldByName('FGO_ESPDOC').AsString = 'PD' Then
      fMensagem('', 'Pedido baixado com sucesso!', ['&Ok'])
    Else
      fMensagem('', 'Orçamento baixado com sucesso!', ['&Ok']);

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, '[Baixar Pedidos]');
    End;
  End;
End;

function TfrmPnlDadosOU_TE.fGetOcorrencia: String;
begin
  Try
    Result := '';
    pCriarFormularios(TfrmDigOcorrencia, frmDigOcorrencia);
    frmDigOcorrencia.ShowModal;
    If (frmDigOcorrencia.ModalResult = mrOk) Then
      Result := frmDigOcorrencia.strCodOco
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
  pFreeAndNil(frmDigOcorrencia);
end;

procedure TfrmPnlDadosOU_TE.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_F7:  btnImpSep.Click;
    VK_F8:  btnGerarPDF.Click;
    VK_F9:  btnEnviarEmail.Click;
    VK_F10: btnBaixaPedido.Click;
    VK_F11: btnItensPend.Click;
  End;

  Case Key Of
    VK_F7,
    VK_F8,
    VK_F9,
    VK_F10,
    VK_F11: Key := 0;
  End;

end;

procedure TfrmPnlDadosOU_TE.FormShow(Sender: TObject);
begin
  pDesabilitaColunas;
end;

procedure TfrmPnlDadosOU_TE.pDesabilitaColunas;
begin
  If cdsConsulta.Active Then
  Begin
    cdsConsulta.FieldByName('CLI_EMAIL_').Visible := False;

    If (cdsConsulta.FieldByName('FGO_ULTPED').AsString = '1') Then
    Begin
      cdsConsulta.FieldByName('FGO_NUMDOC').Visible := False;
      cdsConsulta.FieldByName('FGO_NOMCON').Visible := False;
      cdsConsulta.FieldByName('CLI_NOMCLI').Visible := False;
      cdsConsulta.FieldByName('FGO_CODVEN').Visible := False;
      cdsConsulta.FieldByName('FGO_DTAENT').Visible := False;
      cdsConsulta.FieldByName('TRA_NOMTRA').Visible := False;
      cdsConsulta.FieldByName('CID_NOMCID').Visible := False;
      cdsConsulta.FieldByName('FGO_PEDSIT').Visible := False;
    End;

    {******************************}
    {* VERIFICA SE O CAMPO EXISTE *}
    {***************************DP*}
    If (cdsConsulta.FindField('FGO_LIBERA') <> Nil) Then
      If (cdsConsulta.FieldByName('FGO_ESPDOC').AsString <> 'PD') Then
        cdsConsulta.FieldByName('FGO_LIBERA').Visible := False;

    If (cdsConsulta.FieldByName('FGO_ESPDOC').AsString = 'OR') Then
      btnBaixaPedido.Caption := '[F10] Baixar Orçamentos que não serão entregues';

    btnBaixaPedido.Visible := (cdsConsulta.FieldByName('FGO_ESPDOC').AsString = 'PD');
    btnItensPend.Visible := btnBaixaPedido.Visible;
  End;
end;

procedure TfrmPnlDadosOU_TE.pInfoStatusGravacao(strInformacao: String;
  pgbProgresso: TcxProgressBar);
begin
  If Assigned(pgbProgresso) And (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strInformacao;
    Application.ProcessMessages;
  End;
end;

procedure TfrmPnlDadosOU_TE.pStepStatusGravacao(pgbProgresso: TcxProgressBar);
begin
  If Assigned(pgbProgresso) Then
  Begin
    pgbProgresso.Position := pgbProgresso.Position + 1;
    Application.ProcessMessages;
  End;
end;

procedure TfrmPnlDadosOU_TE.pMostraItensPendentes;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);

  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  FDO_CODITE AS PCD_CODITE, ');
  qryAux.SQL.Add('  FDO_DESCRI AS PCD_DESITE, ');
  qryAux.SQL.Add('  UNI_SIGUNI AS UNI_SIGUNI, ');
  qryAux.SQL.Add('  FORMAT(FDO_QTDITE, ' + fCfgSis('DEQTPC') + ')  AS PCD_QTDITE, ');
  qryAux.SQL.Add('  FORMAT(FDO_QTDBAI, ' + fCfgSis('DEQTPC') + ')  AS PCD_QTDBAI, ');
  qryAux.SQL.Add('  FORMAT(IF(FDO_QTDBAI > FDO_QTDITE, 0, FDO_QTDITE - FDO_QTDBAI), 2) AS PCD_QTDRES, ');
  qryAux.SQL.Add('  CONCAT(FDO_CODMAR,"-", MAR_DESMAR) AS MAR_DESMAR,  ');

  qryAux.SQL.Add('  CAST("" AS CHAR(1)) AS DOCENT, ');
  qryAux.SQL.Add('  FDO_QTDBAI  AS PCD_QTDBAI_NO_FORMAT, ');
  qryAux.SQL.Add('  IF(FDO_QTDBAI > FDO_QTDITE, 0, FDO_QTDITE - FDO_QTDBAI) AS PCD_QTDRES_NO_FORMAT, ');


  If fCfgSis('TABPRF', VarBoolean) Then
    qryAux.SQL.Add(' IF(F.ITE_CODITE IS NULL, C.ITE_CODFAB, F.ITE_CODFAB) AS ITE_CODFAB ')
  Else
    qryAux.SQL.Add(' CAST(IFNULL((SELECT GROUP_CONCAT(DISTINCT F.ITE_CODITF ORDER BY F.ITE_CODITF SEPARATOR ", ") FROM ITEFOR F WHERE F.ITE_CODITE = C.ITE_CODITE AND F.ITE_CODFOR = C.ITE_CODFOR AND IFNULL(F.ITE_CODITF, "") <> ""), C.ITE_CODFAB) AS CHAR(50)) AS ITE_CODFAB ');

  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  FATDOR ');
  qryAux.SQL.Add('  JOIN CADITE C ON C.ITE_CODITE = FDO_CODITE ');
  qryAux.SQL.Add('  JOIN CADUNI ON UNI_CODUNI = C.ITE_CODUNI ');
  qryAux.SQL.Add('  LEFT JOIN CADMAR ON MAR_CODMAR = FDO_CODMAR ');

  If fCfgSis('TABPRF', VarBoolean) Then
  Begin
    qryAux.SQL.Add('  LEFT JOIN ITEFOR F ON F.ITE_CODITE = C.ITE_CODITE AND ');
    qryAux.SQL.Add('                        F.ITE_CODFOR = C.ITE_CODFOR AND ');
    qryAux.SQL.Add('                        (SELECT COUNT(*) FROM TABPRE      ');
    qryAux.SQL.Add('                         WHERE F.ITE_CODTAB = TAB_CODTAB AND TAB_ATICMP = "S") > 0 ');
  End;

  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  FDO_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  FDO_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  FDO_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  IF(FDO_QTDBAI > FDO_QTDITE, 0, FDO_QTDITE - FDO_QTDBAI) > 0 ');
  qryAux.SQL.Add('ORDER BY ');
  qryAux.SQL.Add('  FDO_DESCRI ');

  qryAux.ParamByName('NUMDOC').AsString := cdsConsulta.FieldByName('FGO_NUMDOC').AsString;
  qryAux.ParamByName('ESPDOC').AsString := cdsConsulta.FieldByName('FGO_ESPDOC').AsString;
  qryAux.ParamByName('CODEMP').AsString := cdsConsulta.FieldByName('FGO_CODEMP').AsString;

  qryAux.Open;

  Try
    pCriarFormularios(TfrmMostraItensPendentes, frmMostraItensPendentes);
    frmMostraItensPendentes.dtsPedido.DataSet := qryAux;
    frmMostraItensPendentes.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[]');
  End;

  pFreeAndNil(frmMostraItensPendentes);
  qryAux.Close;
  FreeAndNil(qryAux);
end;

end.
