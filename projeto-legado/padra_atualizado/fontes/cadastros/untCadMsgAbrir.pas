unit untCadMsgAbrir;

interface

uses
  Windows, Classes, Controls, untPaiEdit, Menus, StdCtrls, Buttons, ExtCtrls,
  Mask, DBCtrls, DB, untCadMsg, AppEvnts, DBMemoFocus, BitBtnLockedIncrem,
  UniClientDataSet, frxClass, frxExportCSVTestabilidade, Uni, untFuncoesSimples;

type
  TfrmCadMsgAbrir = class(TfrmPaiEdit)
    pnlTitulo: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    Label3: TLabel;
    dbmMsg: TDBMemoFocus;
    lblDesEmp: TLabel;
    edtCodEmp: TEdit;
    edtDesEmp: TEdit;
    btnOk: TBitBtnLocked;
    btnNegar: TBitBtnLocked;
    btnDebitos: TBitBtnLocked;
    btnTravasMinimas: TBitBtnLocked;
    btnResFin: TBitBtnLocked;
    btnVendasPorCliente: TBitBtnLocked;
    btnVendasSisAnterior: TBitBtnLocked;
    btnConCre: TBitBtnLocked;
    btnInfCob: TBitBtnLocked;
    btnHistoricoCobranca: TBitBtnLocked;
    btnCadCli: TBitBtnLocked;
    btnVisMar: TBitBtnLocked;
    btnEstoqueLojas: TBitBtnLocked;
    memMsg: TMemo;
    btnCadPro: TBitBtnLocked;
    btnImgCliente: TBitBtnLocked;
    btnEnvMensagem: TBitBtnLocked;
    pnlMensagens: TPanel;
    pnlShapeQtdMsgPen: TPanel;
    shpQtdMsg: TShape;
    lblQtdMsg: TLabel;
    btnMensagens: TBitBtnLocked;
    btnProdPreMin: TBitBtnLocked;
    procedure btnDebitosClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnResFinClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnNegarClick(Sender: TObject);
    procedure btnTravasMinimasClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnVendasPorClienteClick(Sender: TObject);
    procedure btnVendasSisAnteriorClick(Sender: TObject);
    procedure btnConCreClick(Sender: TObject);
    procedure btnInfCobClick(Sender: TObject);
    procedure btnHistoricoCobrancaClick(Sender: TObject);
    procedure btnCadCliClick(Sender: TObject);
    procedure btnVisMarClick(Sender: TObject);
    procedure btnEstoqueLojasClick(Sender: TObject);
    procedure btnCadProClick(Sender: TObject);
    procedure btnImgClienteClick(Sender: TObject);
    procedure btnMensagensClick(Sender: TObject);
    procedure btnEnvMensagemClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnProdPreMinClick(Sender: TObject);
  private
    { Private declarations }
    strEmpDes  : String;
    strNumLib  : String;
    strSenLib  : String;
    strCodDig  : String;
    strCodCli  : String;
    strNumTag  : String;
    blnPrzMed  : Boolean;
    strXmlCdsF4: string;
    strCodPro: String;

    function fValidaSenha: Boolean;

    Function fRetEmpresasDestino(strAutInc: String): String;
    procedure pEmpresaSolicitante(blnVisible : Boolean);

    procedure pGravaLogSolicitacaoNegada(strMsgNeg: String);
    procedure pVendasPorCliente(strCodCli:String; strNomCli:String='');
    procedure pVendasSistemaAnterior(strCodCli:String);
    procedure pMostraConsultaCredito;
    function fGetXmlCdsF4: string;
    procedure pAjustarLigacaoDataSet;
    function fVerificaAcessoEspecificoCadProduto: Boolean;
    procedure pChamaTelaCadastroProduto;
    procedure pHabilitaScrollMemo(var AMemo: TMemo);
    procedure pSetarVisibilidadeQtdMsgNaoLida(const intQtdMsg : Integer);
    procedure pAtualizarBotaoMensagens(Sender : TObject);
  protected
    function TimerBotaoMsg : TNewTimer;
    procedure RemoveTimerBotaoMsg;
  public
    { Public declarations }
    strMsgLib  : String;
    frmMsg: TfrmCadMsg;
  end;

//var
//  frmCadMsgAbrir: TfrmCadMsgAbrir;

implementation

uses SysUtils, Forms, Dialogs, StrUtils, untFuncFat, untFuncoes, untLogVar, untResFinanceiro,
  untConstantes, untFatMostraTravaMinimaHelper, untRelFatVendasCliente, untFatConsVendasAntigas,
  untMostraDadosCobranca, untInfCobranca, untCadClientes, untFatMostraMargemNovo, untCadProdutos,
  untFatMostraEstoqueEmp, untFuncoesRel, untFuncoesRel2, untGravando, untHerancaItem,
  untImagens, untFuncoesImagem, untTypesSistema, untCadMsgEnv, Graphics, untFatTravaProdPreco;

{$R *.dfm}

{ TfrmCadMsgAbrir }

procedure TfrmCadMsgAbrir.btnCadCliClick(Sender: TObject);
begin

  inherited;

  Try
    pCriarFormularios(TfrmCadClientes, frmCadClientes);
    frmCadClientes.strCodClienteIniciarCadastro := fRetornaClienteDaLiberacao(strNumLib);
    frmCadClientes.ShowModal;
  Finally
    pFreeAndNil(frmCadClientes);
  End;

end;

procedure TfrmCadMsgAbrir.btnCadProClick(Sender: TObject);
var
  frmHerancaItem: TfrmHerancaItem;
  qryGenIte: TUniQuery;
begin
  inherited;

  if not btnCadPro.Visible then
    Exit;

  if not fVerificaAcessoEspecificoCadProduto then
    Exit;

  pCriarFormularios(TfrmHerancaItem, frmHerancaItem);
  qryGenIte := fCriaQuery;

  try
    frmHerancaItem.qryGenIte := qryGenIte;
    frmHerancaItem.ShowModal;

    if not frmHerancaItem.blnConfirma then
      Exit;

    strCodPro := qryGenIte.FieldByName('ITE_CODITE').AsString;

    TfrmGravando.fExecutarModal(pChamaTelaCadastroProduto, 'Aguarde, Carregando cadastro do produto '+strCodPro+'', '');
  finally
    FreeAndNil(qryGenIte);
    pFreeAndNil(frmHerancaItem);
  end;
end;

procedure TfrmCadMsgAbrir.btnConCreClick(Sender: TObject);
begin
  inherited;
  If (btnConCre.Visible) Then
    pMostraConsultaCredito;
end;

procedure TfrmCadMsgAbrir.btnDebitosClick(Sender: TObject);
begin
  inherited;
  If btnDebitos.Visible Then
    pDebitosCliente(strLoginUsuarioLogado, strCodDig, strCodCli);
end;

procedure TfrmCadMsgAbrir.btnEnvMensagemClick(Sender: TObject);
var
  frmCadMsgEnv: TfrmCadMsgEnv;
begin
  inherited;

  pCriarFormularios(TfrmCadMsgEnv, frmCadMsgEnv);

  try
    frmCadMsgEnv.strOpeResp := DBEdit5.Text;
    frmCadMsgEnv.ShowModal;
  finally
    pFreeAndNil(frmCadMsgEnv);
  end;
end;

procedure TfrmCadMsgAbrir.btnEstoqueLojasClick(Sender: TObject);
var
  fltCodProd: Double;
  strCodProd, strDescProd: String;
  frmFatMostraEstoqueEmp: TfrmFatMostraEstoqueEmp;
begin
  inherited;
  if btnEstoqueLojas.Visible then
  begin
    fltCodProd := 0;

    if fDigitaValor(fltCodProd, 'Código do produto', '#0') then
    begin
      if fltCodProd > 0 then
      begin
        strCodProd := FormatFloat('00000', fltCodProd);
        strDescProd := fRetNomProduto(strCodProd);

        if not fEmptyStr(strDescProd) then
        begin
          pCriarFormularios(TfrmFatMostraEstoqueEmp, frmFatMostraEstoqueEmp);

          try
            frmFatMostraEstoqueEmp.blnFaturamento := False;
            frmFatMostraEstoqueEmp.strCodIte    := strCodProd;
            frmFatMostraEstoqueEmp.fltQtdIte    := 0.0;
            frmFatMostraEstoqueEmp.strTabPre    := '';
            frmFatMostraEstoqueEmp.blnPedCorte  := False;
            frmFatMostraEstoqueEmp.edtItem.Text := strCodProd + ' - ' + strDescProd;
            frmFatMostraEstoqueEmp.pnlSelecEmpresa.Visible := False;//blnPedEmp;
            frmFatMostraEstoqueEmp.ShowModal;
          finally
            FreeAndNil(frmFatMostraEstoqueEmp);
          end;
        end
        else
          fMensagem('ATENÇÃO!', 'O produto de código ' + strCodProd + ' não existe!', ['&O k']);
      end;
    end;
  end;
end;

procedure TfrmCadMsgAbrir.btnHistoricoCobrancaClick(Sender: TObject);
begin
  inherited;
  If btnHistoricoCobranca.Visible = True Then
  Begin
      If Assigned(prcExecutaRelatorio) Then
      begin
        prcExecutaRelatorio(67, 5147, [],
                            ['CODCLI'],
                            [strCodCli],
                            Sender,
                            nil,
                            False);
      End;
  End;

end;

procedure TfrmCadMsgAbrir.btnImgClienteClick(Sender: TObject);
  var
    frmImagem: TfrmImagens;

begin
  pCriarFormularios(TfrmImagens, frmImagem);

  Try
    frmImagem.pAbrirImagens(tiCliente, strCodcli, True);
  Finally
    pFreeAndNil(frmImagem);
  End;
end;

procedure TfrmCadMsgAbrir.btnInfCobClick(Sender: TObject);
  Var
    frmInfCobranca : TfrmInfCobranca;
begin
  inherited;

  If (strCodCli <> '') Then
  Begin

    Try

      pCriarFormularios(TfrmInfCobranca, frmInfCobranca);
      frmInfCobranca.edtCodCli.Text := strCodCli;
      frmInfCobranca.edtNomCli.Text := fRetNomCliente(strCodCli);
      frmInfCobranca.blnFiltraCli := True;
      frmInfCobranca.ShowModal;

    Finally
      pFreeAndNil(frmInfCobranca);
    End;

  End;

end;

procedure TfrmCadMsgAbrir.btnMensagensClick(Sender: TObject);
var
  frmCadMsg: TfrmCadMsg;
begin
  inherited;

  pCriarFormularios(TfrmCadMsg, frmCadMsg);

  try
    frmCadMsg.ShowModal;
  finally
    pFreeAndNil(frmCadMsg);
  end;
end;

procedure TfrmCadMsgAbrir.btnNegarClick(Sender: TObject);
begin
  inherited;
  If fMensagem('','Deseja realmente negar esta solicitação?', ['','']) = 1 Then
  Begin
    While (fEmptyStr(strMsgLib)) Do
    Begin
      InputQuery(frmMsg.cdsConsulta.FieldByName('MSG_TITULO').AsString,
                'Digite uma justificativa com até 100 caracteres:', strMsgLib);

      If fEmptyStr(strMsgLib) And (fMensagem('', 'Justificativa não foi informada. ' +
                                                 'Deseja negar esta solicitação sem informar a justificativa?', ['','']) = 1) Then
      Begin
        If fCfgSis('OBGJNL', varBoolean) Then
          fMensagem('ATENÇÃO!', 'É obrigatório informar uma justificativa de Negação!', ['&O k'])
        Else
          Break;
      End;

      pGravaLogSolicitacaoNegada(strMsgLib);
    End;
    Close;
    ModalResult := mrOk;
  End;
end;

procedure TfrmCadMsgAbrir.btnOkClick(Sender: TObject);
begin
  inherited;
  If (Self.Tag = 0) Then
  Begin
    ModalResult := mrOk;
  End
  Else
  Begin
    If fValidaSenha Then
    Begin
      If (fRetornaSenCli(StrToInt(LeftStr(strNumLib, cnstIntTamIniCodLib))) <> LeftStr(strSenLib, 7)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Senha de liberação não confere!', ['&O k']);
        Exit;
      End
      Else
      Begin
        If (fMensagem('', 'Confirma a Liberação?', ['&Sim', '&Não']) = 2) Then
          Exit;

        if fCfgSis('JUSLIB', varBoolean) then
        begin
          While (fEmptyStr(strMsgLib)) Do
          Begin
            InputQuery(frmMsg.cdsConsulta.FieldByName('MSG_TITULO').AsString,
                      'Digite uma justificativa com até 100 caracteres:', strMsgLib);

            If fEmptyStr(strMsgLib) And (fMensagem('', 'Justificativa não foi informada. ' +
                                                       'Deseja liberar esta solicitação sem informar a justificativa?', ['','']) = 1) Then
            Begin
              Break;
            End;

          End;
        end;

        pUpdateLogVar(strNumLib, strLoginUsuarioLogado, False, strEmpDes, frmMsg.cdsConsulta.fieldByName('MSG_HORENV').asDateTime);
      End;
      ModalResult := mrOk;
    End;
  End;
end;

procedure TfrmCadMsgAbrir.btnProdPreMinClick(Sender: TObject);
var
  frmFatTravaProdPreco: TfrmFatTravaProdPreco;
begin
  inherited;

  If Not btnProdPreMin.Visible Then
    Exit;

  If fEmptyStr(strNumLib) Then
    Exit;

  pCriarFormularios(TfrmFatTravaProdPreco, frmFatTravaProdPreco);

  try
    frmFatTravaProdPreco.NumLib := strNumLib;
    frmFatTravaProdPreco.ShowModal;

    if frmFatTravaProdPreco.Confirmou then
      btnOk.Click;
  finally
    pFreeAndNil(frmFatTravaProdPreco);
  end;
end;

procedure TfrmCadMsgAbrir.btnResFinClick(Sender: TObject);
  Var
    strCodCli: String;
begin
  If btnResFin.Visible Then
  Begin
    Try
      pCriarFormularios(TfrmResFinanceiro,frmResFinanceiro);

      strCodCli := fRetornaClienteDaLiberacao(strNumLib);

      If fEmptyStr(fRetNomCliente(strCodCli)) Then
        strCodCli := '';

      If Not fEmptyStr(strCodCli) Then
        frmResFinanceiro.strCodCli := strCodCli;
        
      frmResFinanceiro.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
    pFreeAndNil(frmResFinanceiro);
  End;
end;

procedure TfrmCadMsgAbrir.btnTravasMinimasClick(Sender: TObject);
  Var
    cdsTmp: TUniClientDataSet;
    StringStream: TStringStream;
    strXmlCds: String;
begin
  inherited;

  If btnTravasMinimas.Visible Then
  Begin
    strXmlCds := fRetornaXmlClientTravasMinimas(strNumLib);

    If Not fEmptyStr(strXmlCds) Then
    Begin
      StringStream := TStringStream.Create(AnsiReplaceStr(strXmlCds, '''', '"'));

      Try
        cdsTmp := TUniClientDataSet.Create(Self);
        cdsTmp.LoadFromStream(StringStream);
      Except
        // Cria os fields caso exista algum erro no código do XML
      End;

      TMostraTravaMinimaHelper.pExibeDados(cdsTmp, Nil);
      FreeAndNil(StringStream);
      FreeAndNil(cdsTmp);
    End;
  End;
end;

procedure TfrmCadMsgAbrir.btnVendasPorClienteClick(Sender: TObject);
begin
  inherited;
  If btnVendasPorCliente.Visible Then
    pVendasPorCliente(fRetornaClienteDaLiberacao(strNumLib));
end;

procedure TfrmCadMsgAbrir.btnVendasSisAnteriorClick(Sender: TObject);
begin
  inherited;
  If btnVendasSisAnterior.Visible Then
    pVendasSistemaAnterior(fRetornaClienteDaLiberacao(strNumLib));
end;

function TfrmCadMsgAbrir.fGetXmlCdsF4: string;
var
  QryTemporaria: TUniQuery;
begin
  QryTemporaria := fCriaQuery;
  try
    QryTemporaria.SQL.Text :=
      'SELECT AUX_INFOF4 ' + sLineBreak +
      '  FROM AUXVAR ' + sLineBreak +
      '  JOIN LOGVAR ' + sLineBreak +
      '    ON LOGVAR.AUTOINCREM = AUXVAR.AUX_SEQVAR ' + sLineBreak +
      ' WHERE LOGVAR.LOG_NROLIB = :NROLIB';
    QryTemporaria.ParamByName('NROLIB').AsString := strNumLib;
    QryTemporaria.Open;
    result := QryTemporaria.FieldByName('AUX_INFOF4').AsString;
    QryTemporaria.Close;
  finally
    FreeAndNil(QryTemporaria);
  end;
end;

procedure TfrmCadMsgAbrir.btnVisMarClick(Sender: TObject);
  Var
    cdsTmp : TUniClientDataSet;
    StringStream : TStringStream;
    frmMosMar : TfrmFatMostraMargemNovo;
begin
  inherited;
  If (btnVisMar.Visible) And (btnVisMar.Enabled) Then
  Begin
    If Not fVerificaAcessoSistema('MRGLU', strLoginUsuarioLogado) Then
    Begin
      fMensagem('','Operador não possui direito de acesso para "Visualizar Margem de Lucro"!', ['&OK']);
      Exit;
    End;

    If Not fEmptyStr(strXmlCdsF4) Then
    Begin
      StringStream := TStringStream.Create(AnsiReplaceStr(strXmlCdsF4, '''', '"'));

      Try
        cdsTmp := TUniClientDataSet.Create(Self);
        cdsTmp.LoadFromStream(StringStream);
      Except
        // Cria os fields caso exista algum erro no código do XML
      End;

      Try
        frmMosMar := TfrmFatMostraMargemNovo.Create(Self,
                                                    Nil,
                                                    Nil,
                                                    strLoginUsuarioLogado,
                                                    False,
                                                    0,
                                                    False,
                                                    False,
                                                    Nil
                                                    );
        frmMosMar.blnVisualizarPorMensagem := True;
        frmMosMar.cdsItens := cdsTmp;
        frmMosMar.ShowModal;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TfrmCadMsgAbrir.btnVisMarClick]');
        End;
      End;
      pFreeAndNil(frmMosMar);
      FreeAndNil(StringStream);
      FreeAndNil(cdsTmp);
    End;
  End;
end;

procedure TfrmCadMsgAbrir.FormCreate(Sender: TObject);
begin
  inherited;
  pEmpresaSolicitante(False);

  strEmpDes := '';
  blnPrzMed := False;
  strNumTag := '';
end;

procedure TfrmCadMsgAbrir.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F2: btnCadPro.Click;
    VK_F3: btnEstoqueLojas.Click;
    VK_F4:
    begin
      if Shift = [ssAlt] then
      begin
        btnVisMar.Click;
        key := 0;
      end
      else
        btnCadCli.Click;
    end;
    VK_F5:
    Begin
      If (Shift = [ssAlt]) Then
      Begin
        If (btnImgCliente.Visible) Then
          btnImgCliente.Click;
        key := 0;
      End
      Else
        btnDebitos.Click;
    End;
    VK_F6:
      begin
        If (Shift = [ssAlt]) then
        begin
          if (btnMensagens.Visible) then
            btnMensagens.Click;
          key := 0;
        end
        else
          btnTravasMinimas.Click;
      end;
    VK_F7:
      begin
        if (Shift = [ssAlt]) then
        begin
          If (btnEnvMensagem.Visible) then
            btnEnvMensagem.Click;
          key := 0;
        end
        else
          btnResFin.Click;
      end;
    VK_F8:
      Begin
        If (Shift = [ssAlt]) Then
        Begin
          If (btnProdPreMin.Visible) Then
            btnProdPreMin.Click;
          key := 0;
        End
        Else
          btnVendasPorCliente.Click;
      End;
    VK_F9: btnVendasSisAnterior.Click;
    VK_F10: btnHistoricoCobranca.Click;
    VK_F11: btnConCre.Click;
    VK_F12: btnInfCob.Click;
  End;
end;

Function TfrmCadMsgAbrir.fRetEmpresasDestino(strAutInc: String): String;
Begin
  // RETORNANDO A EMPRESA FÍSICA
  Result := LeftStr(strAutInc, 3);
End;

procedure TfrmCadMsgAbrir.FormShow(Sender: TObject);
  Var
    blnLibera,
    blnRequis: Boolean;
    blnTravaMin: Boolean;
    strValor, strMsgLib, strJustif: String;
    strDirAce: String;
Begin
  inherited;

  pAjustarLigacaoDataSet;

  blnRequis := False;
  blnLibera := (frmMsg.dtsConsulta.DataSet.FindField('MSG_LIBERA') <> Nil) And
               (frmMsg.dtsConsulta.DataSet.FieldByName('MSG_LIBERA').AsString = 'S');

  if (Assigned(frmMsg.dtsConsulta.DataSet.FindField('MSG_TITULO'))) then
    blnRequis := frmMsg.dtsConsulta.DataSet.FieldByName('MSG_TITULO').AsString = MSG_ASSUNTO_REQUISICAO_ATENDIDA;

  strNumLib := frmMsg.dtsConsulta.DataSet.FieldByName('MSG_NUMLIB').AsString;

  strEmpDes := fRetEmpresasDestino(frmMsg.dtsConsulta.DataSet.FindField('AUTOINCREM').AsString);

  blnTravaMin := Not fEmptyStr(fRetornaXmlClientTravasMinimas(strNumLib));

  If blnLibera Or blnRequis Then
  Begin
    dbmMsg.Font.Name := 'Courier New';
    dbmMsg.Font.Size := 8;
  End;

  {Req: 99322}
  dbmMsg.ReadOnly  := True;

  If blnLibera Then
  Begin
    Self.Tag         := 1;
    btnOk.Caption    := 'Liberar';
    btnNegar.Visible := True;
    If Not fVerificaAcessoSistema('ACEF7_', strLoginUsuarioLogado) Then
      btnResFin.Visible := False
    Else
      btnResFin.Visible := True;

    strCodCli := fRetornaClienteDaLiberacao(strNumLib);

    edtCodEmp.Text:=frmMsg.dtsConsulta.DataSet.FieldByName('MSG_EMPENV').AsString;
    edtDesEmp.Text:=fRetNomeEmpresaSelec(edtCodEmp.Text);
    pEmpresaSolicitante(True);

    btnDebitos.Visible := Not fEmptyStr(strCodCli);
    btnConCre.Visible  := (Not fEmptyStr(strCodCli)) And fVerificaAcessoSistema('CONCRE', strLoginUsuarioLogado);
    btnInfCob.Visible  := Not fEmptyStr(strCodCli);
    btnVendasPorCliente.Visible   := (Not fEmptyStr(strCodCli)) And fVerificaAcessoSistema('VENCLF', strLoginUsuarioLogado);
    btnVendasSisAnterior.Visible  := (Not fEmptyStr(strCodCli)) And fCfgSis('SISANT', varBoolean);
    btnHistoricoCobranca.Visible  := Not fEmptyStr(strCodCli);
    btnCadCli.Visible             := fVerificaAcessoSistema('frmCadClientes', strLoginUsuarioLogado);
    btnEstoqueLojas.Visible := fVerificaAcessoSistema('CPELOJ', strLoginUsuarioLogado);
    btnProdPreMin.Visible := fCampoTabela('COUNT(*)','TPMGER',['GER_NUMLIB'],[strNumLib]) > 0;

    strValor := Copy(strNumLib, 4, 2);

    If (StrToInt(strValor) > 0) Then
    Begin
      strNumTag := IntToStr(StrToInt(RightStr(strNumLib, Length(strNumLib) - 5)) Div StrToInt(strValor));
    End
    Else
      strNumTag := RightStr(strNumLib, Length(strNumLib) - 5);

    blnPrzMed := (strNumTag = '10257');
  End;

  btnOk.Align      := alLeft;
  btnNegar.Align   := alLeft;
  btnResFin.Align  := alLeft;
  btnDebitos.Align := alLeft;
  btnConCre.Align  := alLeft;
  btnVendasPorCliente.Align := alLeft;
  btnVendasSisAnterior.Align := alLeft;
  btnHistoricoCobranca.Align := alLeft;
  btnSair.Align    := alNone;
  btnTravasMinimas.Visible := TMostraTravaMinimaHelper.fExibeTravaMinima And
                              blnTravaMin And (Not blnPrzMed);

  strMsgLib := fRetornaXmlClientTravasMinimas(strNumLib, 'AUX_INFLIB');
  strMsgLib := AnsiReplaceStr(strMsgLib, STRING_QUEBRA, #13#10);

  btnCadPro.Visible := fVerificaAcessoSistema('frmCadProdutos', strLoginUsuarioLogado);

  if fEmptyStr(strMsgLib) then
  begin
    memMsg.Visible := False;
    dbmMsg.Visible := True;
    dbmMsg.Align := alClient;
  end
  else
  begin
    strDirAce := fRetornaXmlClientTravasMinimas(strNumLib, 'LOG_CODLIB');

    If fDestinatarioSemDireitoAcessoInformacao(strDirAce, strLoginUsuarioLogado) Then
      strMsgLib := fTagMsgOcultaToMsgCoringa(strMsgLib, omlMsgParaQuemReceb)
    Else
      strMsgLib := fLimpaTagMsgOculta(strMsgLib, omlMsgParaQuemReceb);

    strJustif := fCampoTabela('LOG_JUSTIF', 'LOGVAR', ['LOG_NROLIB'], [strNumLib]);

    dbmMsg.Visible := False;
    memMsg.Visible := True;
    memMsg.Align := alClient;
    memMsg.Lines.Clear;
    memMsg.Lines.DefaultEncoding := TEncoding.UTF8;

    If (Not fEmptyStr(strJustif)) And (Pos(strJustif, strMsgLib) <= 0) Then
    Begin
      memMsg.Lines.Add(strJustif);
      memMsg.Lines.Add('');
    End;

    memMsg.WordWrap := False;
    memMsg.Lines.Add(strMsgLib);

    pHabilitaScrollMemo(memMsg);
    memMsg.WordWrap := True;
  end;

  strXmlCdsF4 := fGetXmlCdsF4;
  btnVisMar.Visible := Not fEmptyStr(strXmlCdsF4);
  btnImgCliente.Visible := (fCfgSis('TRAREM', varInteger) = 2) And (fCfgSis('HABREM', varBoolean));
  TimerBotaoMsg.Enabled := True;
  pAtualizarBotaoMensagens(Self);
end;

function TfrmCadMsgAbrir.fValidaSenha: Boolean;
  Var
    strSenCli     : String;
    blnTemDireito : Boolean;
Begin
  Result        := True;
  blnTemDireito := false;

  {*******************************************}
  {* DIREITO DE ACESSO                       *}
  {****************************************AC*}
  fRetImagemIndexMenu(StrToInt(strNumTag), blnTemDireito);

  {*******************************************}
  {* DIREITO DE ACESSO                       *}
  {****************************************AC*}
  If Not blnTemDireito Then
  Begin
    fMensagem('','Operador sem direito de acesso para essa opção!', ['&O k']);
    Result := FALSE;
    Exit;
  End;

  {*******************************************}
  {* VERIFICACAO SE É TRAVA DE PRAZO MEDIO   *}
  {****************************************FS*}
  If blnPrzMed Then
  Begin
    If Not fOperadorLogadoPodeLiberarTravaPrzMed(strNumLib) Then
    Begin
      fMensagem('','Prazo médio do operador foi excedido!', ['&O k']);
      Result := False;
      Exit;
    End;
  End;

  strSenCli := fRetornaSenCli(StrToInt(LeftStr(strNumLib, cnstIntTamIniCodLib)));

  strSenLib := strSenCli + fCriptografaOperador(strLoginUsuarioLogado, strSenCli);
end;

function TfrmCadMsgAbrir.fVerificaAcessoEspecificoCadProduto: Boolean;
var
  strDireitos: String;
begin
  Result := False;

  if not fVerificaDirEspecificos(strDireitos, strLoginUsuarioLogado, 'frmCadProdutos') then
  begin
    fMensagem('ATENÇÃO!', 'Usuário sem acesso aos direitos específicos!', ['&Ok']);
    Exit;
  end;

  if Pos('I', strDireitos) <= 0 then
  begin
    fMensagem('ATENÇÃO!', 'Usuário sem acesso para incluir produto!', ['&Ok']);
    Exit;
  end;

  if Pos('A', strDireitos) <= 0 then
  begin
    fMensagem('ATENÇÃO!', 'Usuário sem acesso para alterar produto!', ['&Ok']);
    Exit;
  end;

  if Pos('E', strDireitos) <= 0 then
  begin
    fMensagem('ATENÇÃO!', 'Usuário sem acesso para excluir produto!', ['&Ok']);
    Exit;
  end;

  Result := True;
end;

procedure TfrmCadMsgAbrir.pAjustarLigacaoDataSet;
begin
  DBEdit1.DataSource := frmMsg.dtsConsulta;
  DBEdit2.DataSource := frmMsg.dtsConsulta;
  DBEdit3.DataSource := frmMsg.dtsConsulta;
  DBEdit4.DataSource := frmMsg.dtsConsulta;
  DBEdit5.DataSource := frmMsg.dtsConsulta;
  dbmMsg.DataSource  := frmMsg.dtsConsulta;
end;

procedure TfrmCadMsgAbrir.pChamaTelaCadastroProduto;
var
  frmCadProdutos: TfrmCadProdutos;
begin
  pCriarFormularios(TfrmCadProdutos, frmCadProdutos);

  try
    frmCadProdutos.strCodIteParaCarregar := strCodPro;
    frmCadProdutos.ShowModal;
  finally
    pFreeAndNil(frmCadProdutos);
  end;
end;

procedure TfrmCadMsgAbrir.pEmpresaSolicitante(blnVisible: Boolean);
begin
  lblDesEmp.Visible := blnVisible;
  edtCodEmp.Visible := blnVisible;
  edtDesEmp.Visible := blnVisible;
end;

procedure TfrmCadMsgAbrir.pGravaLogSolicitacaoNegada(strMsgNeg: String);
  Var
    qryGen   : TUniQuery;
    strAutInc: String;
Begin
  Try
    qryGen := fCriaQuery;

    With qryGen, SQL Do
    Begin
      Close;
      Clear;

      Add('INSERT INTO     ');
      Add('  MSGNEG (      ');
      Add('    AUTOINCREM, ');
      Add('    NEG_CODEMP, ');
      Add('    NEG_CODCLI, ');

      Add('    NEG_OPEENV, ');
      Add('    NEG_DTAENV, ');
      Add('    NEG_HORENV, ');
      Add('    NEG_MSGENV, ');

      Add('    NEG_OPENEG, ');
      Add('    NEG_DTANEG, ');
      Add('    NEG_HORNEG, ');
      Add('    NEG_MSGNEG, ');
      Add('    NEG_TITULO, ');
      Add('    NEG_CODLIB) ');
      Add('  VALUES (      ');
      Add('    :AUTINC,    ');
      Add('    :CODEMP,    ');
      Add('    :CODCLI,    ');

      Add('    :OPEENV,    ');
      Add('    :DTAENV,    ');
      Add('    :HORENV,    ');
      Add('    :MSGENV,    ');

      Add('    :OPENEG,    ');
      Add('    :DTANEG,    ');
      Add('    :HORNEG,    ');
      Add('    :MSGNEG,    ');
      Add('    :TITULO,    ');
      Add('    :CODLIB)    ');

      strAutInc := fRetAutoIncrem('MSGNEG',VS_strCodEmp);

      ParamByName('AUTINC').AsString   := strAutInc;
      ParamByName('CODEMP').AsString   := VS_strCodEmp;
      ParamByName('CODCLI').AsString   := strCodCli;

      ParamByName('OPEENV').AsString   := frmMsg.dtsConsulta.DataSet.FieldByName('MSG_OPEENV').AsString;
      ParamByName('DTAENV').AsDateTime := frmMsg.dtsConsulta.DataSet.FieldByName('MSG_DTAENV').AsDateTime;
      ParamByName('HORENV').AsDateTime := frmMsg.dtsConsulta.DataSet.FieldByName('MSG_HORENV').AsDateTime;
      ParamByName('MSGENV').AsString   := frmMsg.dtsConsulta.DataSet.FieldByName('MSG_MENSAG').AsString;

      ParamByName('OPENEG').AsString   := strLoginUsuarioLogado;
      ParamByName('DTANEG').AsDateTime := VS_Date;
      ParamByName('HORNEG').AsDateTime := fTime();
      ParamByName('MSGNEG').AsString   := strMsgNeg;
      ParamByName('TITULO').AsString   := frmMsg.dtsConsulta.DataSet.FieldByName('MSG_TITULO').AsString;
      ParamByName('CODLIB').AsString   := fCampoTabela('LOG_CODLIB', 'LOGVAR', ['LOG_NROLIB'], [frmMsg.dtsConsulta.DataSet.FieldByName('MSG_NUMLIB').AsString]);

      ExecSQL;
    End;

  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadMsgAbrir.pHabilitaScrollMemo(var AMemo: TMemo);
var
  intCont: Integer;
begin
  Canvas.Font.Assign(AMemo.Font);

  for intCont := 0 to Pred(AMemo.Lines.Count) do
  begin
    if (Canvas.TextWidth(AMemo.Lines[intCont])) > AMemo.ClientWidth then
    begin
      AMemo.ScrollBars := ssBoth;
      Exit;
    end;
  end;
end;

procedure TfrmCadMsgAbrir.pVendasPorCliente(strCodCli, strNomCli: String);
begin
  If Not fVerificaAcessoSistema('VENCLF') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso em Vendas por Clientes!', ['&O k']);
    Exit;
  End Else If fEmptyStr(strCodCli) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário digitar um cliente.', ['&Ok']);
    Exit;
  End
  Else If (fEmptyStr(fRetNomCliente(strCodCli))) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário digitar um cliente válido!', ['&Ok']);
    Exit;
  End;

  Try
    If fEmptyStr(strNomCli) Then
      strNomCli := fRetNomCliente(strCodCli);

    pCriarFormularios(TfrmRelFatVendasCliente,frmRelFatVendasCliente);
    Try
      frmRelFatVendasCliente.blnFaturamento         := True;
      frmRelFatVendasCliente.blnSenha               := False;
      frmRelFatVendasCliente.blnVeioDoTelemarketing := false;
      frmRelFatVendasCliente.blnVeioDoTablet        := false;
      frmRelFatVendasCliente.edtCodCliente.Text     := strCodCli;
      frmRelFatVendasCliente.edtDesCliente.Text     := strNomCli;
      frmRelFatVendasCliente.blnSomenteVendas       := True;
      frmRelFatVendasCliente.blnVeioTelaVendas      := True;
      frmRelFatVendasCliente.blnMosCom              := True;
      frmRelFatVendasCliente.blnCliCons := fClienteConsumidor(strNomCli, False, True);

      frmRelFatVendasCliente.ShowModal;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[pVendasPorCliente]');
      End;
    End;
  Finally
    pFreeAndNil(frmRelFatVendasCliente);
  End;
end;

procedure TfrmCadMsgAbrir.pVendasSistemaAnterior(strCodCli: String);
begin
  If Not fCfgSis('SISANT', varBoolean) Then
  Begin
    Exit;
  End Else If fEmptyStr(strCodCli) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário digitar um cliente.', ['&Ok']);
    Exit;
  End
  Else If (fEmptyStr(fRetNomCliente(strCodCli))) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário digitar um cliente válido!', ['&Ok']);
    Exit;
  End;

  pCriarFormularios(TfrmFatConsVendasAntigas, frmFatConsVendasAntigas);
  Try
    frmFatConsVendasAntigas.edtCodCliente.Text := strCodCli;
    frmFatConsVendasAntigas.ShowModal;
  Finally
    FreeAndNil(frmFatConsVendasAntigas);
  End;
end;

procedure TfrmCadMsgAbrir.pMostraConsultaCredito;
begin

  Try

    pCriarFormularios(TfrmMostraDadosCobranca, frmMostraDadosCobranca);
    frmMostraDadosCobranca.strCodCli := strCodCli;
    frmMostraDadosCobranca.ShowModal;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[frmCadMsgAbrir.pMostraConsultaCredito]');
  End;

  pFreeAndNil(frmMostraDadosCobranca);

end;

procedure TfrmCadMsgAbrir.FormDestroy(Sender: TObject);
begin
  RemoveTimerBotaoMsg;
  inherited;
end;

procedure TfrmCadMsgAbrir.pSetarVisibilidadeQtdMsgNaoLida(
  const intQtdMsg: Integer);
begin
  If (intQtdMsg > 99) Then
    lblQtdMsg.Caption := '+99'
  Else
    lblQtdMsg.Caption := IntToStr(intQtdMsg);
  pnlShapeQtdMsgPen.Visible := (intQtdMsg > 0);
  If (pnlShapeQtdMsgPen.Visible) Then
  Begin
    btnMensagens.Font.Color := clBlue;
    btnMensagens.Font.Style := [fsBold];
  End
  Else
  Begin
    btnMensagens.Font.Color := clBlack;
    btnMensagens.Font.Style := [];
  End;
end;

procedure TfrmCadMsgAbrir.pAtualizarBotaoMensagens(Sender: TObject);
begin
  pSetarVisibilidadeQtdMsgNaoLida(TfrmCadMsg.fGetQtdMensagensNaoLidas);
end;

function TfrmCadMsgAbrir.TimerBotaoMsg: TNewTimer;
begin
  if not TNewTimer.Has(Self.Name + '.tmrBotaoMsg') then
  begin
    Result := TNewTimer.Get(Self.Name + '.tmrBotaoMsg');
    Result.Interval := fCfgSis('ATBTMS', varInteger) * 1000;
    Result.Enabled  := True;
    Result.OnTimer  := pAtualizarBotaoMensagens;
  end
  else
    Result := TNewTimer.Get(Self.Name + '.tmrBotaoMsg');
end;

procedure TfrmCadMsgAbrir.RemoveTimerBotaoMsg;
begin
  TNewTimer.Del(Self.Name + '.tmrBotaoMsg');
end;

end.
