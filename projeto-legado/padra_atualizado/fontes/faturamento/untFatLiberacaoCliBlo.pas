unit untFatLiberacaoCliBlo;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  EditFocus, Menus, StrUtils, AppEvnts,
  Windows, BitBtnLockedIncrem, UniClientDataSet, frxClass,
  frxExportCSVTestabilidade, untTypesSistema, untPanelCxItem, untPanelCxBanner,
  untPnlDadosItem, untPnlBanner, untConsultas, untFatMostraMargemNovo, untTLock;

type
  TfrmFatLiberacaoCliBlo = class(TfrmPaiSimples)
    Panel1: TPanel;
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    pnlNumLib: TPanel;
    lblSenha: TLabel;
    edtSenLib: TEditFocus;
    Label1: TLabel;
    edtNumLib: TEditFocus;
    Panel2: TPanel;
    mmoInfLib: TMemo;
    Label2: TLabel;
    btnDebitos: TBitBtnLocked;
    btnResFin: TBitBtnLocked;
    btnTravasMinimas: TBitBtnLocked;
    btnInfCobr: TBitBtnLocked;
    btnVisMar: TBitBtnLocked;
    procedure btnCancelaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnDebitosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnResFinClick(Sender: TObject);
    procedure btnTravasMinimasClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnInfCobrClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnVisMarClick(Sender: TObject);
  private
    { Private declarations }
    strXmlCdsF4 : String;
    objLock: TLock;
    Function fValidaSenha: Boolean;
    function fPermiteAbrirMsg: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    intAcesso: Integer;
  end;


implementation

uses untFuncoes, untfuncoesSimples, untFuncFat, untResFinanceiro,
     untLogVar,untFatMostraTravaMinimaHelper, untInfCobranca, untCadClientes;

{$R *.dfm}

procedure TfrmFatLiberacaoCliBlo.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

Function TfrmFatLiberacaoCliBlo.fValidaSenha: Boolean;
  Var
    strTag  : String;
    strMultiplicador: String;
    strTagCodificada: String;
    strSenCli: String;
    strImagemIndex: Integer;
    blnTemDireito: Boolean;
    blnPrzMed: Boolean;
Begin
  Result := True;

  Try
    strMultiplicador := LeftStr(edtNumLib.Text, cnstIntTamIniCodLib);
    strMultiplicador := RightStr(strMultiplicador, cnstIntTamFatorMult);
    strTagCodificada := RightStr(edtNumLib.Text, Length(edtNumLib.Text) - cnstIntTamIniCodLib);

    If StrToInt(strMultiplicador) > 0 Then
      strTag := IntToStr(StrToInt(strTagCodificada) div StrToInt(strMultiplicador))
    Else
      strTag := strTagCodificada;

    blnPrzMed := (strTag = '10257');

    {*******************************************}
    {* DIREITO DE ACESSO                       *}
    {****************************************AC*}
    strImagemIndex := fRetImagemIndexMenu(StrToInt(strTag), blnTemDireito);
  Except
    fMensagem('','Número de liberação inválido!', ['&O k']);
    Result := FALSE;
    Exit;
  End;

  If intAcesso <> strImagemIndex Then
  Begin
    fMensagem('','Essa opção não é permitida para esse tipo de Liberação !', ['&O k']);
    Result := FALSE;
    Exit;
  End;

  If Not blnTemDireito Then
  Begin
    fMensagem('','Operador sem direito de acesso para essa opção!', ['&O k']);
    Result := FALSE;
    Exit;
  End;

  If Not fPermiteAbrirMsg Then
  Begin
    Result := False;
    Exit;
  End;

  //Validação se possui prazo médio para liberação
  If blnPrzMed Then
  Begin
    If Not fOperadorLogadoPodeLiberarTravaPrzMed(EdtNumLib.Text) Then
    Begin
      fMensagem('','Prazo médio do operador foi excedido!', ['&O k']);
      Result := False;
      Exit;
    End;
  End;
  
  strSenCli := fRetornaSenCli(StrToInt(LeftStr(edtNumLib.Text, cnstIntTamIniCodLib)));

  edtSenLib.Text := strSenCli + fCriptografaOperador(strLoginUsuarioLogado, strSenCli);

  btnTravasMinimas.Visible := TMostraTravaMinimaHelper.fExibeTravaMinima
    And (Not blnPrzMed);
  btnDebitos.Visible := (strTag = '10002') Or (strTag = '10008');
  btnInfCobr.Visible := btnDebitos.Visible;

  If Not fVerificaAcessoSistema('ACEF7_', strLoginUsuarioLogado) Then
    btnResFin.Visible := False
  Else
    btnResFin.Visible := (strTag = '10002') Or (strTag = '10008');

End;

function TfrmFatLiberacaoCliBlo.fPermiteAbrirMsg: Boolean;
  Var
    strChave : String;
Begin
  objLock.pDestravarTodos;

  If (Not fEmptyStr(edtNumLib.Text)) Then
  Begin
    strChave := 'MENSAGEM_LIBERACAO_' + edtNumLib.Text;

    Result := objLock.fLock_Unlock(strChave, True, False);

    If Not Result Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa liberação está sendo analisada por outra estação: ' + Chr(13) +
                fGetHostLock(strChave), ['&OK']);
    End;
  End
  Else
    Result := True;
end;

function TfrmFatLiberacaoCliBlo.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strInfLog: String;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumLib) Then
    Begin
      If fEmptyStr(edtNumLib.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O número de liberação deve ser preenchido!', ['&O k']);
        Result := False;
      End

      Else
      Begin
        Result := fValidaSenha;

        If Result Then
        Begin
          fObtemInfoLog(edtNumLib.Text,strInfLog);
          mmoInfLib.Text := strInfLog;
        End Else
        Begin
          mmoInfLib.Clear;
          edtSenLib.Clear;
        End;

      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatLiberacaoCliBlo.FormShow(Sender: TObject);
begin
  inherited;

  Caption :=IIF(intAcesso = 3,'Senha de Liberação Preços','Senha de Liberação Geral');

  objLock := TLock.Create;
  lblSenha.Caption :=  Caption + ':';
  btnTravasMinimas.Visible := False;
end;

procedure TfrmFatLiberacaoCliBlo.btnDebitosClick(Sender: TObject);
  Var
    strCodCli: String;
begin
  inherited;
  If btnDebitos.Visible Then
  Begin
    strCodCli := fRetornaClienteDaLiberacao(edtNumLib.Text);
    If fEmptyStr(fRetNomCliente(strCodCli)) Then
      strCodCli := '';
    pDebitosCliente(strLoginUsuarioLogado, strLoginUsuarioLogado, strCodCli);
  End;
end;

procedure TfrmFatLiberacaoCliBlo.btnInfCobrClick(Sender: TObject);
  Var
    strCodCli: String;
    frmInfCobranca : TfrmInfCobranca;
begin
  If Not btnInfCobr.Visible Then
    Exit;

  If (Not fEmptyStr(edtNumLib.Text)) Then
  Begin
    Try
      strCodCli := fRetornaClienteDaLiberacao(edtNumLib.Text);

      If fEmptyStr(fRetNomCliente(strCodCli)) Then
        strCodCli := '';

      pCriarFormularios(TfrmInfCobranca, frmInfCobranca);
      frmInfCobranca.edtCodCli.Text := strCodCli;
      frmInfCobranca.edtNomCli.Text := fRetNomCliente(strCodCli);
      frmInfCobranca.ShowModal;

    Finally
      pFreeAndNil(frmInfCobranca);
    End;
  End;
end;

procedure TfrmFatLiberacaoCliBlo.btnResFinClick(Sender: TObject);
  Var
    strCodCli: String;
begin
  If btnResFin.Visible Then
  Begin
    Try
      pCriarFormularios(TfrmResFinanceiro,frmResFinanceiro);
      strCodCli := fRetornaClienteDaLiberacao(edtNumLib.Text);
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

procedure TfrmFatLiberacaoCliBlo.btnTravasMinimasClick(Sender: TObject);
  Var
    cdsTmp: TUniClientDataSet;
    StringStream: TStringStream;
    strXmlCds: String;
begin
  inherited;

  If btnTravasMinimas.Visible Then
  Begin
    strXmlCds := fRetornaXmlClientTravasMinimas(edtNumLib.Text);

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

procedure TfrmFatLiberacaoCliBlo.btnVisMarClick(Sender: TObject);
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

        frmMosMar.cdsItens := cdsTmp;
        frmMosMar.ShowModal;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TfrmFatLiberacaoCliBlo.btnVisMarClick]');
        End;
      End;
      pFreeAndNil(frmMosMar);

      FreeAndNil(StringStream);
      FreeAndNil(cdsTmp);
    End;
  End;
end;

procedure TfrmFatLiberacaoCliBlo.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtNumLib);
end;

procedure TfrmFatLiberacaoCliBlo.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objLock);
end;

procedure TfrmFatLiberacaoCliBlo.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F4:
    Begin
      If (Shift = [ssAlt]) Then
        btnVisMar.Click;
      Key := 0;
    End;
    vk_F5: btnDebitos.Click;
    vk_F6: btnTravasMinimas.Click;
    vk_F7: btnResFin.Click;
    VK_F12: btnInfCobr.Click;
  End;
end;

end.

