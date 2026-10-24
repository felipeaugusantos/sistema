unit untCfgModeloWPP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Uni, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGridCitel, cxGridLevel,
  cxGrid, UniClientDataSet, Clipbrd, ActiveX, Vcl.OleCtrls, EditFocus, strUtils,
  Vcl.DBCtrls, JPeg, MemoFocus, untRelCtrDebitosCliente,
  System.Generics.Collections,
  untTypesSistema, untFuncoesImagem, untImagemBase64,
  cxDataControllerConditionalFormattingRulesManagerDialog;

Type
  TCamDis = record
    strCamDis: String;
    strValDis: String;
End;

type
  TfrmCfgModeloWPP = class(TfrmPaiConfirma)
    pnlEditor: TPanel;
    pnlCamDis: TPanel;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBBandedTableViewCitel1: TcxGridDBBandedTableViewCitel;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxGrid1DBBandedTableViewCitel1Column1: TcxGridDBBandedColumn;
    cxStyle2: TcxStyle;
    pnlFundo: TPanel;
    mmoMensagem: TMemoFocus;
    pnlContagem: TPanel;
    dtsCamDis: TDataSource;
    pnlSuperior: TPanel;
    chkEnvDoc: TCheckBox;
    btnRegrasRelatorio: TBitBtnLocked;
    btnConfiguraEmailPedidoCompraPDF: TBitBtnLocked;
    pnlAnexo: TPanel;
    lblCaminhoImagem: TLabel;
    btnAnexarImagem: TBitBtnLocked;
    pnlTemplateID: TPanel;
    lblTemplateID: TLabel;
    edtTemplateID: TEditFocus;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxGrid1DBBandedTableViewCitel1CellDblClick(
      Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGrid1DBBandedTableViewCitel1KeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure mmoMensagemChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnRegrasRelatorioClick(Sender: TObject);
    procedure btnConfiguraEmailPedidoCompraPDFClick(Sender: TObject);
    procedure btnAnexarImagemClick(Sender: TObject);
  private

    qryModelo: TUniQuery;
    cdsCamDis: TUniClientDataSet;

    FLinkBoleto: Boolean;
    FstrEntSai: String;

    FRegrasRelatorio: String;

    FCaminhoImagem: String;
    FNomeArquivoBase64: String;
    FCarregouImagemBanco: Boolean;

    procedure pCarregaModelo;
    procedure pCarregaCamposDisponiveis;
    procedure pCriaClientCamposDisponiveis;
    function fGravar: Boolean;
    procedure pApagaModelo;
    procedure pGravaModelo;

    procedure CarregaCheckBoxRegras(var ARelCtrDebitosCliente: TfrmRelCtrDebitosCliente);
    function RetornaCheckboxSelecionado(ARelCtrDebitosCliente: TfrmRelCtrDebitosCliente): String;

    function fVerificaGrupoAPosVencimento( strGrupoGatilho : String ): Boolean;

    function CarregaDadosDeModeloPadrao(ACodigoModelo: String): String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    strSeqGer: String;
    strEspDoc: String;
    strCodGru: String;
    strCodGat: String;
    blnApiOficial: Boolean;
    property strEntSai: String read FstrEntSai write FstrEntSai;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConstantes;

procedure TfrmCfgModeloWPP.btnAnexarImagemClick(Sender: TObject);
var
  LExtensao: String;
begin
  inherited;

  FCaminhoImagem := fSelecionaArquivo('', 'Imagens|*.jpeg;*.jpg;*.png', [ofFileMustExist]);
  FCarregouImagemBanco := False;

  if not fEmptyStr(FCaminhoImagem) then
  begin
    LExtensao := ExtractFileExt(FCaminhoImagem);
    FNomeArquivoBase64 := Concat(IIF(((strCodGru = '033') and (strCodGat = '001')), 'FELIZ_ANIVERSARIO', 'ANEXO'),UpperCase(LExtensao));
    lblCaminhoImagem.Caption := FCaminhoImagem;
  end;
end;

procedure TfrmCfgModeloWPP.btnConfiguraEmailPedidoCompraPDFClick(
  Sender: TObject);
begin
  inherited;
  If Assigned(funCfgPedidoDeCompra) Then
     funCfgPedidoDeCompra('PDCWPP');
end;

procedure TfrmCfgModeloWPP.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrNone;

  If (fVerificaCampos) Then
  Begin
    if fGravar then
      ModalResult := mrOk;
  End;
end;

procedure TfrmCfgModeloWPP.btnRegrasRelatorioClick(Sender: TObject);
  Var
    LRelCtrDebitosCliente: TfrmRelCtrDebitosCliente;
begin
  If Not btnRegrasRelatorio.Visible Then
    Exit;

  pCriarFormularios(TfrmRelCtrDebitosCliente, LRelCtrDebitosCliente);
  Try
    CarregaCheckBoxRegras(LRelCtrDebitosCliente);
    LRelCtrDebitosCliente.ShowModal;

    If LRelCtrDebitosCliente.ModalResult = mrOk Then
      FRegrasRelatorio := RetornaCheckboxSelecionado(LRelCtrDebitosCliente);
  Finally
    FreeAndNil(LRelCtrDebitosCliente);
  End;
end;

procedure TfrmCfgModeloWPP.CarregaCheckBoxRegras(
  var ARelCtrDebitosCliente: TfrmRelCtrDebitosCliente);
begin
  If FRegrasRelatorio.IsEmpty Then
    Exit;

  ARelCtrDebitosCliente.chkContaCorrente.Checked := FRegrasRelatorio.Substring(0, 1) = 'S';
  ARelCtrDebitosCliente.chkProduto.Checked := FRegrasRelatorio.Substring(1, 1) = 'S';
  ARelCtrDebitosCliente.chkCheque.Checked := FRegrasRelatorio.Substring(2, 1) = 'S';
  ARelCtrDebitosCliente.chkObservacao.Checked := FRegrasRelatorio.Substring(3, 1) = 'S';
  ARelCtrDebitosCliente.chkJuros.Checked := FRegrasRelatorio.Substring(4, 1) = 'S';
  ARelCtrDebitosCliente.chkDocAg.Checked := FRegrasRelatorio.Substring(5, 1) = 'S';
  ARelCtrDebitosCliente.chkDtaVen.Checked := FRegrasRelatorio.Substring(6, 1) = 'S';
  ARelCtrDebitosCliente.chkAjuDta.Checked := FRegrasRelatorio.Substring(7, 1) = 'S';
  ARelCtrDebitosCliente.chkEndEre.Checked := FRegrasRelatorio.Substring(8, 1) = 'S';
  ARelCtrDebitosCliente.chkBancoDoBoleto.Checked := FRegrasRelatorio.Substring(9, 1) = 'S';
  ARelCtrDebitosCliente.chkNumPedFF.Checked := FRegrasRelatorio.Substring(10, 1) = 'S';
  ARelCtrDebitosCliente.chkCredito.Checked := FRegrasRelatorio.Substring(11, 1) = 'S';
end;

function TfrmCfgModeloWPP.CarregaDadosDeModeloPadrao(
  ACodigoModelo: String): String;
  Var
    LTexto: String;
begin
  Result := EmptyStr;

  LTexto := ' que vencerá em <<DIASVEN>> dia(s)';
  If ACodigoModelo.Equals('024') Then
    LTexto := ' que venceu em <<DIASVEN>> dia(s)';

  Result := Result + 'Esse é um aviso que existe uma cobrança ' + LTexto + '.';
  Result := Result + '<<csq>>Dados da Cobrança:<<csq>>';
  Result := Result + 'Duplicata: <<NROVEN>> <<csq>>Data Vencimento:<<DTAVEN>> <<csq>>Valor: <<VALDUP>>';
  If ACodigoModelo.Equals('023') Then
     Result := Result + '<<csq>><<QRCODE>><<csq>><<csq>>';
  Result := Result + '*** Caso a liquidação da duplicata já tenha sido efetuada, desconsidere esse aviso. ***';

  fMensagem('AVISO',
            'O modelo de e-mail carregado está com o texto padrão. ' + #13 +
                'Poderá ser alterado conforme sua necessidade, limitado aos campos disponíveis.',
            ['&Ok']);
end;

procedure TfrmCfgModeloWPP.cxGrid1DBBandedTableViewCitel1CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;

  mmoMensagem.Text := mmoMensagem.Text + cdsCamDis.FieldByName('VALCAM').AsString;
  pSetFocus(mmoMensagem);

  SendMessage(mmoMensagem.Handle, WM_VSCROLL, SB_BOTTOM, 0);
  SendMessage(mmoMensagem.Handle, WM_HSCROLL, SB_RIGHT, 0);
  mmoMensagem.SelStart := Length(mmoMensagem.Text);
end;

procedure TfrmCfgModeloWPP.cxGrid1DBBandedTableViewCitel1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
    SelectNext((ActiveControl), True, True);
end;

procedure TfrmCfgModeloWPP.FormActivate(Sender: TObject);
begin
  inherited;

  Self.WindowState := wsMaximized;
end;

procedure TfrmCfgModeloWPP.FormCreate(Sender: TObject);
begin
  inherited;
  FstrEntSai := 'S';
  qryModelo := fCriaQuery(Self);

  FLinkBoleto := VarToString(fCfgSis('LNKBOL')).Trim <> '';
  btnAnexarImagem.Visible := False;
  FCaminhoImagem := EmptyStr;
  FNomeArquivoBase64 := EmptyStr;
  FCarregouImagemBanco := False;
  lblCaminhoImagem.Caption := EmptyStr;
  blnApiOficial := False;
end;

procedure TfrmCfgModeloWPP.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryModelo);
  FreeAndNil(cdsCamDis);
end;

procedure TfrmCfgModeloWPP.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_RETURN) And ((ActiveControl) = mmoMensagem) Then
  Begin
    blnMudarFoco := False;
  End
  Else
    inherited;
end;

procedure TfrmCfgModeloWPP.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaModelo;
  pCarregaCamposDisponiveis;

  If (Pos(strEspDoc, 'PD_OR_AN_FF_RC_') > 0) or (strCodGru = '027') Then
    chkEnvDoc.Visible := True
  Else
    chkEnvDoc.Visible := False;

  btnRegrasRelatorio.Visible := strEspDoc = 'AD';

  pnlSuperior.Visible := chkEnvDoc.Visible or blnApiOficial;

  if strCodGru = '033' then
  begin
    pnlSuperior.Visible := True;
    btnAnexarImagem.Visible := True;
    btnConfiguraEmailPedidoCompraPDF.Visible := False;
    chkEnvDoc.Visible := False;
  end;

  pSetFocus(mmoMensagem);

  mmoMensagem.OnChange(mmoMensagem);

  btnConfiguraEmailPedidoCompraPDF.Visible := strCodGru.Equals('024');

  pnlTemplateID.Visible := blnApiOficial;
end;

function TfrmCfgModeloWPP.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mmoMensagem) Then
    Begin
      If (fEmptyStr(mmoMensagem.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A mensagem deve ser preenchida!', ['&OK']);
        Result := False;
      End;
    End;

    If (Not Result) Then
      pSetFocus(Sender);
  End;

end;

procedure TfrmCfgModeloWPP.mmoMensagemChange(Sender: TObject);
begin
  inherited;
  pnlContagem.Caption := 'A mensagem terá ' + Length(mmoMensagem.Text).ToString + ' caracteres aproximadamente';
end;

procedure TfrmCfgModeloWPP.pApagaModelo;
Var
  strSQL: String;
begin

  Try

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM MODWPP WHERE MOD_SEQGER = :SEQGER ';

    qryModelo.Close;
    qryModelo.SQL.Clear;
    qryModelo.SQL.Add(strSQL);
    qryModelo.ParamByName('SEQGER').AsString := strSeqGer;
    qryModelo.ExecSQL;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmCfgModeloWPP.pApagaModelo]');
  End;

end;


procedure TfrmCfgModeloWPP.pCarregaCamposDisponiveis;
Const
  ANIVERSARIO_CLIENTE = '<<NOMCLI>>_<<PRICLI>>_<<NOMLOJ>>';
Var
  intContador: Integer;
  intLin,
  intCol: Integer;
  arrVar : Array of Array of String;
begin
  pCriaClientCamposDisponiveis;


  If FstrEntSai = 'S' Then
    For intLin := Low(arrVarEma) To High(arrVarEma) Do
      For intCol := Low(arrVarEma[intLin]) To High(arrVarEma[intLin]) Do
      Begin
          SetLength(arrVar, intLin + 1);
          SetLength(arrVar[intLin], intCol + 1);
          arrVar[intLin][intCol] := arrVarEma[intLin][intCol];
      End;
  If FstrEntSai = 'E' Then
    For intLin := Low(arrVarEmE) To High(arrVarEmE) Do
      For intCol := Low(arrVarEmE[intLin]) To High(arrVarEmE[intLin]) Do
      Begin
          SetLength(arrVar, intLin + 1);
          SetLength(arrVar[intLin], intCol + 1);
          arrVar[intLin][intCol] := arrVarEmE[intLin][intCol];
      End;

  For intContador := 0 To Length(arrVar) -1 Do
  Begin
    If Pos(arrVar[intContador][0], '<<TABDUPPX>>_<<TABDUP>>') > 0 Then
      Continue;

    if (MatchStr(arrVar[intContador][0], ['<<NOMCLI>>', '<<PRICLI>>', '<<CIDCLI>>'])) and
       (MatchStr(Concat(strCodGru, strCodGat), ['031002'])) then
      Continue;

    if (arrVar[intContador][0] = '<<QRCODE>>') and fVerificaGrupoAPosVencimento( Concat(strCodGru, strCodGat) ) then
      Continue;

    If (arrVar[intContador][2] = 'TODAS') Or (Pos(strEspDoc, arrVar[intContador][2]) > 0) Then
    Begin
      If arrVar[intContador][0] = '<<LNKBOL>>' Then
      Begin
        If Not FLinkBoleto Then
          Continue;
      End;

      If (strEspDoc = 'PX') or (strEspDoc = 'CL') or (strCodGru = '027') Then
      Begin
        If arrVar[intContador][0] = '<<NUMEOS>>' Then
          Continue;
      End;

      If strEspDoc = 'TE' Then
      Begin
        If (Pos(fCfgSis('OPCROM', varString), '1_5_') > 0) and (Pos(arrVar[intContador][0], '<<DOCVEN>>_<<EMPVEN>>_<<NROVEN>>_<<ESPVEN>>_') > 0) then
          Continue
        Else If (Pos(fCfgSis('OPCROM', varString), '1_5_') <= 0) and (Pos(arrVar[intContador][0], '<<PEDVEN>>_') > 0) then
          Continue;
      End;

      If (strCodGru = '033') and (strCodGat = '001') Then
      Begin
        If (Pos(arrVar[intContador][0], ANIVERSARIO_CLIENTE) <= 0) Then
          Continue;
      End;

      If strCodGru.Equals('009') Then
      Begin
        If arrVar[intContador][0] = '<<DIASVEN>>' Then
        Begin
          If Not MatchStr(fCampoTabela('WPP_CODIGO', 'WPPSAI', ['AUTOINCREM'], [strSeqGer]), ['023', '024']) Then
            Continue;
        End;
      End;

      If (strEspDoc = 'BO') and (MatchStr(arrVar[intContador][0], ['<<CGCEMP>>', '<<CGCCLI>>', '<<SERIE_>>', '<<ACESSO>>', '<<HOREMI>>', '<<ENDEMP>>', '<<ENDCLI>>'])) Then
        Continue;

      cdsCamDis.Insert;
      cdsCamDis.FieldByName('CAMDIS').AsString := arrVar[intContador][1];
      cdsCamDis.FieldByName('VALCAM').AsString := arrVar[intContador][0];
      cdsCamDis.Post;
    End;
  End;

  cdsCamDis.Open;
  dtsCamDis.DataSet := cdsCamDis;
end;

procedure TfrmCfgModeloWPP.pCarregaModelo;
  Var
    strSQL: String;
begin
  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  MOD_MODELO AS MODELO,  ';
    strSQL := strSQL + '  MOD_ENVDOC AS ENVDOC,  ';
    strSQL := strSQL + '  MOD_IMAB64 AS IMAB64,  ';
    strSQL := strSQL + '  MOD_NOMARQ AS NOMARQ,  ';
    strSQL := strSQL + '  MOD_REGREL, ';
    strSQL := strSQL + '  MOD_TEMPID ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  MODWPP ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  MOD_SEQGER = :SEQGER ';

    qryModelo.Close;
    qryModelo.SQL.Clear;
    qryModelo.SQL.Add(strSQL);
    qryModelo.ParamByName('SEQGER').AsString := strSeqGer;
    qryModelo.Open;

    If (Not qryModelo.IsEmpty)Then
    Begin
      mmoMensagem.Text := AnsiReplaceStr(qryModelo.FieldByName('MODELO').Value, STRING_QUEBRA, STRING_ENTER);
      chkEnvDoc.Checked := qryModelo.FieldByName('ENVDOC').AsString = 'S';
      FRegrasRelatorio := qryModelo.FieldByName('MOD_REGREL').AsString;
      FCaminhoImagem := qryModelo.FieldByName('IMAB64').AsString;
      FNomeArquivoBase64 := qryModelo.FieldByName('NOMARQ').AsString;
      edtTemplateID.Text := qryModelo.FieldByName('MOD_TEMPID').AsString;

      If not fEmptyStr(FCaminhoImagem) Then
        FCarregouImagemBanco := True;

      Exit;
    End;

     If Not strEspDoc.Equals('AC') Then
      Exit;

    If MatchStr(fCampoTabela('WPP_CODIGO', 'WPPSAI', ['AUTOINCREM'], [strSeqGer]), ['023', '024']) Then
      mmoMensagem.Text := CarregaDadosDeModeloPadrao(fCampoTabela('WPP_CODIGO', 'WPPSAI', ['AUTOINCREM'], [strSeqGer])).Replace(STRING_QUEBRA, STRING_ENTER);
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmCfgModeloWPP.pCarregaModelo]');
  End;

end;

procedure TfrmCfgModeloWPP.pCriaClientCamposDisponiveis;
begin

  cdsCamDis := TUniClientDataSet.Create(Self);
  {***********************************}
  {* DEFINIÇÃO DOS CAMPOS            *}
  {********************************PZ*}
  cdsCamDis.FieldDefs.Add('CAMDIS', ftString, 050);
  cdsCamDis.FieldDefs.Add('VALCAM', ftString, 050);

  cdsCamDis.CreateDataSet;
end;

procedure TfrmCfgModeloWPP.pGravaModelo;
Var
  strSQL   : String;
  strAutInc: String;
begin
  strSQL := '';
  strSQL := strSQL + 'INSERT INTO ';
  strSQL := strSQL + '  MODWPP(AUTOINCREM,  ';
  strSQL := strSQL + '         MOD_SEQGER,  ';
  strSQL := strSQL + '         MOD_MODELO,  ';
  strSQL := strSQL + '         MOD_ENVDOC,  ';
  strSQL := strSQL + '         MOD_IMAB64,  ';
  strSQL := strSQL + '         MOD_NOMARQ,  ';
  strSQL := strSQL + '         MOD_REGREL,  ';
  strSQL := strSQL + '         MOD_TEMPID)  ';
  strSQL := strSQL + '  VALUES(:AUTINC,     ';
  strSQL := strSQL + '         :SEQGER,     ';
  strSQL := strSQL + '         :MODELO,     ';
  strSQL := strSQL + '         :ENVDOC,     ';
  strSQL := strSQL + '         :IMAB64,     ';
  strSQL := strSQL + '         :NOMARQ,     ';
  strSQL := strSQL + '         :REGREL,     ';
  strSQL := strSQL + '         :TEMPID)  ';

  qryModelo.Close;
  qryModelo.SQL.Clear;
  qryModelo.SQL.Add(strSQL);

  strAutInc := fRetAutoIncrem('MODWPP', VS_strCodEmp);

  qryModelo.ParamByName('AUTINC').AsString := strAutInc;
  qryModelo.ParamByName('SEQGER').AsString := strSeqGer;
  qryModelo.ParamByName('MODELO').Value    := AnsiReplaceStr(mmoMensagem.Text, STRING_ENTER, STRING_QUEBRA);
  qryModelo.ParamByName('ENVDOC').AsString := IIF(chkEnvDoc.Visible And chkEnvDoc.Checked, 'S', 'N');

  If fEmptyStr(FCaminhoImagem) Then
  Begin
    qryModelo.ParamByName('IMAB64').Value := Null;
    qryModelo.ParamByName('NOMARQ').Value := Null;
  End
  Else If FCarregouImagemBanco Then
  Begin
    qryModelo.ParamByName('IMAB64').AsString := FCaminhoImagem;
    qryModelo.ParamByName('NOMARQ').AsString := FNomeArquivoBase64;
  End
  Else
  Begin
    qryModelo.ParamByName('IMAB64').AsString := fBase64FromFile(FCaminhoImagem);
    qryModelo.ParamByName('NOMARQ').AsString := FNomeArquivoBase64;
  End;

  qryModelo.ParamByName('REGREL').Value    := Null;
  If Not FRegrasRelatorio.IsEmpty Then
    qryModelo.ParamByName('REGREL').AsString := FRegrasRelatorio;

  qryModelo.ParamByName('TEMPID').AsString := edtTemplateID.Text;

  qryModelo.ExecSQL;
end;

function TfrmCfgModeloWPP.fGravar: Boolean;
begin
  Result := False;

  if (blnApiOficial) and
     (StrToIntDef(edtTemplateID.Text, 0) <= 0) then
  begin
    fMensagem('ATENÇÃO!', 'O campo Template ID deve ser preechido!', ['&OK']);
    pSetFocus(edtTemplateID);
    Exit;
  end;

  Try
    fStartTransaction;

    pApagaModelo;
    pGravaModelo;

    fCommit;

    Result := True;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(e.Message, '[TfrmCfgModeloWPP.fGravar]');
    End;
  End;
end;

function TfrmCfgModeloWPP.RetornaCheckboxSelecionado(
  ARelCtrDebitosCliente: TfrmRelCtrDebitosCliente): String;
begin
  Result := Concat(fBoleanoToStrSN(ARelCtrDebitosCliente.chkContaCorrente.Checked),
                   fBoleanoToStrSN(ARelCtrDebitosCliente.chkProduto.Checked),
                   fBoleanoToStrSN(ARelCtrDebitosCliente.chkCheque.Checked),
                   fBoleanoToStrSN(ARelCtrDebitosCliente.chkObservacao.Checked),
                   fBoleanoToStrSN(ARelCtrDebitosCliente.chkJuros.Checked),
                   fBoleanoToStrSN(ARelCtrDebitosCliente.chkDocAg.Checked),
                   fBoleanoToStrSN(ARelCtrDebitosCliente.chkDtaVen.Checked),
                   fBoleanoToStrSN(ARelCtrDebitosCliente.chkAjuDta.Checked),
                   fBoleanoToStrSN(ARelCtrDebitosCliente.chkEndEre.Checked),
                   fBoleanoToStrSN(ARelCtrDebitosCliente.chkBancoDoBoleto.Checked),
                   fBoleanoToStrSN(ARelCtrDebitosCliente.chkNumPedFF.Checked),
                   fBoleanoToStrSN(ARelCtrDebitosCliente.chkCredito.Checked));
end;

Function TfrmCfgModeloWPP.fVerificaGrupoAPosVencimento( strGrupoGatilho : String ): Boolean;
Begin
  Result := False;

  If MatchStr(strGrupoGatilho,  ['009008',
                                 '009009',
                                 '009002',
                                 '009010',
                                 '009003',
                                 '009011',
                                 '009012',
                                 '009013',
                                 '009014',
                                 '009015',
                                 '009022',
                                 '009024']) Then
  Begin
    Result := True;
  End;

End;

end.
