unit untVendaAssistida;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, dxGDIPlusClasses, EditFocus,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Uni, UniClientDataSet, UniDataSetProvider,
  dxLayoutContainer, cxGridViewLayoutContainer, cxGridLayoutView,
  cxGridDBLayoutView, cxGridCustomLayoutView, cxButtonEdit, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, Vcl.DBCGrids, cxContainer, cxImage,
  dxBarBuiltInMenu, cxPC, cxLabel, DBMemoFocus;

type
  TfrmVendaAssistida = class(TfrmPaiSimples)
    dtsProdutos: TDataSource;
    cxPageControl: TcxPageControl;
    tabLogin: TcxTabSheet;
    tabConsulta: TcxTabSheet;
    tabProdutos: TcxTabSheet;
    Image1: TImage;
    edtLogin: TEditFocus;
    edtNomOpe: TEditFocus;
    edtSenha: TEditFocus;
    btnLogin: TBitBtnLocked;
    BitBtnLocked3: TBitBtnLocked;
    pnlCodBarra: TPanel;
    Panel1: TPanel;
    Label11: TLabel;
    edtTotal: TEditFocus;
    dbGridProdutos: TDBCtrlGrid;
    lblProPreco: TLabel;
    lblProQtde: TLabel;
    dbeCodIte: TDBEditFocus;
    dbeSubsti: TDBEditFocus;
    DBEditFocus2: TDBEditFocus;
    Panel2: TPanel;
    btnGerarPedido: TBitBtnLocked;
    btnGerarOrcamento: TBitBtnLocked;
    btnListaVoltar: TBitBtnLocked;
    cxPageControlProd: TcxPageControl;
    tabProdBusca: TcxTabSheet;
    Label5: TLabel;
    edtBarras: TEditFocus;
    tabProdDados: TcxTabSheet;
    imgFotoProd: TImage;
    Label3: TLabel;
    Label6: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    pnlConsulta: TPanel;
    btnAdicionar: TBitBtnLocked;
    edtUnitar: TEditFocus;
    edtDesIte: TEditFocus;
    edtCodIte: TEditFocus;
    edtRefere: TEditFocus;
    edtCodMar: TEditFocus;
    edtSaldos: TEditFocus;
    edtMultip: TEditFocus;
    Panel3: TPanel;
    Label9: TLabel;
    edtQtdIte: TEditFocus;
    Panel4: TPanel;
    btnNovoOrcamento: TBitBtnLocked;
    btnProdutos: TBitBtnLocked;
    BitBtnLocked4: TBitBtnLocked;
    BitBtnLocked1: TBitBtnLocked;
    lblPromocao: TLabel;
    imgLixeira: TcxImage;
    Shape1: TShape;
    Panel5: TPanel;
    Label12: TLabel;
    Label8: TLabel;
    Label13: TLabel;
    edtCodBar: TEditFocus;
    DBMemoFocus1: TDBMemoFocus;
    lblVendedor: TcxLabel;
    lblSenha: TcxLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure btnProdutosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnGerarPedidoClick(Sender: TObject);
    procedure edtBarrasKeyPress(Sender: TObject; var Key: Char);
    procedure btnNovoOrcamentoClick(Sender: TObject);
    procedure BitBtnLocked4Click(Sender: TObject);
    procedure btnGerarOrcamentoClick(Sender: TObject);
    procedure btnListaVoltarClick(Sender: TObject);
    procedure imgLixeiraClick(Sender: TObject);
    procedure BitBtnLocked1Click(Sender: TObject);
    procedure dtsProdutosDataChange(Sender: TObject; Field: TField);
    procedure edtLoginKeyPress(Sender: TObject; var Key: Char);
    procedure edtQtdIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtLoginExit(Sender: TObject);
    procedure edtLoginKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtSenhaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lblVendedorClick(Sender: TObject);
    procedure lblSenhaClick(Sender: TObject);
    procedure btnLoginExit(Sender: TObject);
  private
    strPromocInt: String;
    qryConOpe: TUniQuery;
    qryCadIte: TUniQuery;
    cdsProdutos : TUniClientDataSet;
    strCliente  : String;
    strCodVenInt: String;
    strCodCndInt: String;
    strCodFpgInt: String;
    strConPagInt: String;
    strTabPreInt: String;
    intDecimal  : Integer;
    intDecQtde  : Integer;
    procedure pCarregaOperador;
    procedure pGeraPedido(strEspDocInt: String);
    procedure pCriaClientItens;
    procedure pLimpaTela;
    procedure pCalcular;
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses  untfuncoesSimples, untConstantes, StrUtils, Faturamento.Classes.TEmitirPedido, untLogGor,
      untPesqAux, untFuncoesImagem, untCadPro, untIFatReservaSaldo,
      untTFatReservaSaldo, untIFatEntregaFutura, untTFatEntregaFutura;

{$R *.dfm}

procedure TfrmVendaAssistida.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(dbeCodIte);
  pSetaCodite(edtCodIte);

  qryCadIte := fCriaQuery(Nil);
  cdsProdutos := TUniClientDataSet.Create(Self);
  pCriaClientItens;
  dtsProdutos.DataSet := cdsProdutos;
  qryConOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);
  pgcDados.TabWidth  := 1;
  pgcDados.TabHeight := 1;
  cxPageControl.HideTabs       := True;
  cxPageControl.ActivePage     := tabLogin;
  cxPageControlProd.HideTabs   := True;
  cxPageControlProd.ActivePage := tabProdBusca;
  lblPromocao.Visible := False;
  edtQtdIte.EditFormat := fMskDigitos(intDecQtde);

  If fCfgSis('TIPBAR', varString) = '2' Then
   edtCodbar.MaxLength := 43;
end;

procedure TfrmVendaAssistida.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryConOpe);
  FreeAndNil(qryCadIte);
  FreeAndNil(cdsProdutos);
end;

procedure TfrmVendaAssistida.FormShow(Sender: TObject);
begin
  inherited;
  intDecimal   := fCfgSis('DECUNI', varInteger);
  intDecQtde   := fCfgSis('DECQTD', varInteger);
  strCliente   := fCfgSis('VRACLI');
  strTabPreInt := fCfgSis('TABPAD');
  strCodCndInt := fCfgSis('VRACND');
  strCodFpgInt := fCfgSis('VRAFPG');
  strConPagInt := '01000';

  If fEmptyStr(strCliente) Then
  Begin
    fMensagem('','Favor configurar o "VENDA RAPIDA - Cliente para Venda Rápida" nas configurações do sistema!', ['&OK']);
    btnLogin.Enabled := False;
  End;

  If fEmptyStr(strCodCndInt) Then
  Begin
    fMensagem('','Favor configurar o "VENDA RAPIDA - Condição de Pagamento para Venda Rápida" nas configurações do sistema!', ['&OK']);
    btnLogin.Enabled := False;
  End;

  If fEmptyStr(strCodFpgInt) Then
  Begin
    fMensagem('','Favor configurar o "VENDA RAPIDA - Forma de Pagamento para Venda Rápida" nas configurações do sistema!', ['&OK']);
    btnLogin.Enabled := False;
  End;

  If fEmptyStr(strTabPreInt) Then
  Begin
    fMensagem('','Favor configurar o "Tabela de preço padrão" nas configurações do sistema!', ['&OK']);
    btnLogin.Enabled := False;
  End;
  pSetFocus(edtLogin);
end;

procedure TfrmVendaAssistida.pCarregaOperador;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADOPE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  OPE_CODOPE = :LOGOPE ';

  With qryConOpe Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('LOGOPE').AsString := edtLogin.Text;
    Open;

    edtNomOpe.Text := FieldByName('OPE_NOMOPE').AsString;
  End;
end;

procedure TfrmVendaAssistida.btnProdutosClick(Sender: TObject);
begin
  inherited;
  cxPageControl.ActivePage := tabProdutos;
end;

procedure TfrmVendaAssistida.imgLixeiraClick(Sender: TObject);
begin
  inherited;
  If not cdsProdutos.IsEmpty Then
  Begin
    cdsProdutos.Delete;
    pCalcular;
  End;
end;

procedure TfrmVendaAssistida.lblSenhaClick(Sender: TObject);
begin
  inherited;
  pSetFocus(edtSenha);
end;

procedure TfrmVendaAssistida.lblVendedorClick(Sender: TObject);
begin
  inherited;
  pSetFocus(edtLogin);
end;

procedure TfrmVendaAssistida.dtsProdutosDataChange(Sender: TObject;
  Field: TField);
var blnVisivel: Boolean;
begin
  inherited;
  blnVisivel := not cdsProdutos.IsEmpty;

  btnNovoOrcamento.Enabled  := blnVisivel;
  btnProdutos.Enabled       := blnVisivel;
  dbGridProdutos.Visible    := blnVisivel;
  btnGerarPedido.Enabled    := blnVisivel;
  btnGerarOrcamento.Enabled := blnVisivel;
end;

procedure TfrmVendaAssistida.btnGerarOrcamentoClick(Sender: TObject);
begin
  inherited;
  pGeraPedido('OR');
end;

procedure TfrmVendaAssistida.btnGerarPedidoClick(Sender: TObject);
begin
  inherited;
  pGeraPedido('PD');
end;

procedure TfrmVendaAssistida.btnListaVoltarClick(Sender: TObject);
begin
  inherited;
  cxPageControl.ActivePage := tabConsulta;
  cxPageControlProd.ActivePage := tabProdBusca;
  pSetFocus(edtBarras);
end;

procedure TfrmVendaAssistida.BitBtnLocked1Click(Sender: TObject);
begin
  inherited;
  pLimpaTela;
end;

procedure TfrmVendaAssistida.BitBtnLocked4Click(Sender: TObject);
begin
  inherited;
  If fMensagem('','Deseja finalizar o aplicativo?', ['&Sim', '&Não'], 2) = 2 Then
  Begin
    edtBarras.Clear;
    pSetFocus(edtBarras);
  End
  Else
    Close;
end;

procedure TfrmVendaAssistida.pCalcular;
var fltTotal: Double;
begin
  fltTotal := 0;
  With cdsProdutos do
  Begin
    First;
    While not eof do
    Begin
      fltTotal := fltTotal + (FieldByName('QTDITE').AsFloat * FieldByName('UNITAR').AsFloat);
      Next;
    End;
  End;

  edtTotal.Text := FormatFloat(fMskDigitos(2), fltTotal);
end;

procedure TfrmVendaAssistida.btnAdicionarClick(Sender: TObject);
var fltValor,
    fltMltVen: Double;
begin
  inherited;

  If fStrToFloat(edtQtdIte.Text) <= 0 Then
  Begin
    fMensagem('', 'Quantidade inválida!', ['&O k']);
    pSetFocus(edtQtdIte);
    Exit;
  End;

  If fStrToFloat(edtMultip.Text) > 0 Then
  Begin
    If fStrToFloat(edtQtdIte.Text) < fStrToFloat(edtMultip.Text) Then
    Begin
      fMensagem('','A quantidade deve ser igual ou múltiplo de: ' + edtMultip.Text, ['&OK']);
      edtQtdIte.Text := FormatFloat(fMskDigitos(intDecQtde), fStrToFloat(edtMultip.Text));
      pSetFocus(edtQtdIte);
      Exit;
    End;

    fltValor := fFormataFloatInterna(fStrToFloat(edtQtdIte.Text) / fStrToFloat(edtMultip.Text), 4);
    If (fltValor - Int(fltValor)) > 0 Then
    begin
      fMensagem('','A quantidade deve ser igual ou múltiplo de: ' + edtMultip.Text, ['&OK']);
      fltValor  := fStrToFloat(edtQtdIte.Text);
      fltMltVen := fStrToFloat(edtMultip.Text);
      fltValor  := Int( ( ( fltValor + fltMltVen ) / fltMltVen ) ) * fltMltVen;
      edtQtdIte.Text := FormatFloat(fMskDigitos(intDecQtde), fltValor);
      pSetFocus(edtQtdIte);
      Exit;
    end;
  End;

  With cdsProdutos Do
  Begin
    Append;
    FieldByName('CODITE').AsString := edtCodIte.Text;
    FieldByName('DESITE').AsString := edtDesIte.Text;
    FieldByName('QTDITE').AsFloat  := fStrToFloat(edtQtdIte.Text);
    FieldByName('UNITAR').AsFloat  := fStrToFloat(edtUnitar.Text);
    FieldByName('UNIORI').AsFloat  := fStrToFloat(edtUnitar.Text);
    Post;

    pCalcular;

    pLimpaTela;
  End;
end;

procedure TfrmVendaAssistida.pLimpaTela;
Begin
   edtBarras.Clear;
   edtCodIte.Clear;
   edtDesIte.Clear;
   edtRefere.Clear;
   edtCodMar.Clear;
   edtMultip.Clear;
   edtUnitar.Clear;
   edtSaldos.Clear;
   edtQtdIte.Clear;
   imgFotoProd.Picture := nil;
   strPromocInt := 'N';
   lblPromocao.Visible := False;
   cxPageControl.ActivePage := tabConsulta;
   cxPageControlProd.ActivePage := tabProdBusca;
   pSetFocus(edtBarras);
End;

procedure TfrmVendaAssistida.btnLoginClick(Sender: TObject);
Var strSQL    : String;
    qryGenOpe : TUniQuery;
begin
  inherited;
  If fEmptyStr(edtLogin.Text) Then
  Begin
    fMensagem('', 'Informe o Código do Vendedor!', ['&O k']);
    pSetFocus(edtLogin);
    edtSenha.Clear;
    edtNomOpe.Clear;
    Exit;
  End;

  If (Pos(VS_strCodEmp, fRetEmpLoginUsuario(edtLogin.Text)) <= 0) Then
  Begin
    fMensagem('', 'Vendedor sem permissão de acesso a essa Empresa!', ['&O k']);
    pSetFocus(edtLogin);
    blnMudarFoco := False;
    Exit;
  End;

  {* CARACTERE FORA DE STR_CHAR_SENHA E CRIPTOGRAFADO PELO fCrypt COMO 'A' *}
  If Not fSenhaPermitida(edtSenha.Text) Then
  Begin
    fMensagem('', 'Login ou Senha incorretos! Verifique.', ['&O k']);
    pSetFocus(edtLogin);
    blnMudarFoco := False;
    Exit;
  End;

  qryGenOpe := fCriaQuery(Self);

  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  OPE_STATUS ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADOPE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  OPE_CODOPE = :LOGOPE AND ';
    strSQL := strSQL + '  BINARY OPE_SENOPE = :SENOPE ';

    With qryGenOpe Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('LOGOPE').AsString := edtLogin.Text;
      ParamByName('SENOPE').AsString := fCrypt(edtSenha.Text);
      Open;

      If Not IsEmpty Then
      Begin
        If (FieldByName('OPE_STATUS').AsString = 'A') Then
        Begin
          strCodVenInt := edtLogin.Text;
          cxPageControl.ActivePage := tabConsulta;
          cxPageControlProd.ActivePage := tabProdBusca;
          pSetFocus(edtBarras);
        End
        Else
        Begin
          fMensagem('', 'Usuário Inativo - Sem permissão de acesso ao Sistema!', ['&O k']);
          pSetFocus(edtLogin);
          blnMudarFoco := False;
          Exit;
        End;
      End
      Else
      Begin
        fMensagem('', 'Login ou Senha incorretos! Verifique.', ['&O k']);
        pSetFocus(edtLogin);
        blnMudarFoco := False;
        Exit;
      End;

    End;
  Finally
    FreeAndNil(qryGenOpe);
  End;

end;

procedure TfrmVendaAssistida.btnLoginExit(Sender: TObject);
begin
  inherited;
  lblVendedor.Visible := False;
  lblSenha.Visible    := False;

  If length(edtLogin.Text) = 0 Then
    lblVendedor.Visible := True;

  If Length(edtSenha.Text) = 0 Then
    lblSenha.Visible := True;
end;

procedure TfrmVendaAssistida.btnNovoOrcamentoClick(Sender: TObject);
begin
  inherited;
  If fMensagem('', 'Existe produtos no carrinho' + #13 +
                   'Deseja continuar?', ['&Sim', '&Não'], 2) = 1 Then
  Begin
    cxPageControl.ActivePage := tabConsulta;
    cdsProdutos.EmptyDataSet;
    pLimpaTela;
  End
  Else
  Begin
    edtBarras.Clear;
    pSetFocus(edtBarras);
  End;
end;

procedure TfrmVendaAssistida.edtBarrasKeyPress(Sender: TObject;
  var Key: Char);
var
  fltSaldos,
  fltSalRes: Double;

  fltPreCus: Double;
  fltPreVen: Double;
  fltComVar: Double;
  fltComAta: Double;
  fltComDis: Double;
  fltQtdDis: Double;
  fltDesF07: Double;
  blnParticiona: Boolean;
  blnPromo: Boolean;
  strComPro: String;
  strCodPro: String;
begin
  inherited;
  If Key = Char(13) Then
  Begin
    If (not fEmptyStr(edtBarras.Text)) And (Length(edtBarras.text) >= 13)  Then
    Begin
      pPesquisaCadIte(Nil, qryCadIte, edtBarras.Text, '', True);

      With qryCadIte do
      Begin
        If not qryCadIte.IsEmpty Then
        Begin
          If (FieldByName('ITE_PREVE'+strTabPreInt).AsFloat <= 0) Then
          Begin
            fMensagem('', 'Esse produto está com o preço de venda zerado!' + #13#10 + 'Favor corrigir.', ['&Ok']);
            Exit;
          End;

          edtCodBar.Text := edtBarras.Text;
          edtCodIte.Text := FieldByName('ITE_CODITE').AsString;
          edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
          edtCodMar.Text := FieldByName('MAR_DESMAR').AsString;
          edtRefere.Text := FieldByName('ITE_REFERE').AsString;
          edtMultip.Text := FormatFloat(fMskDigitos(intDecQtde),
                                        IIF((FieldByName('ITE_MLTVEN').AsFloat > 0),FieldByName('ITE_MLTVEN').AsFloat,1));
          strPromocInt := 'N';
          If fRetornaPrecosPromocao(FieldByName('ITE_CODITE').AsString,
                                    '',
                                    VS_Date,
                                    1,
                                    0,
                                    0,
                                    0,
                                    fltPreCus,
                                    fltPreVen,
                                    fltComVar,
                                    fltComAta,
                                    fltComDis,
                                    fltQtdDis,
                                    fltDesF07,
                                    strComPro,
                                    strCodPro,
                                    blnParticiona,
                                    blnPromo,
                                    strTabPreInt,
                                    strCodCndInt) Then
          Begin
            If Not blnParticiona Then
            Begin
             strPromocInt := 'S';
             lblPromocao.Visible := True;
            End;
          End;

          If strPromocInt = 'N' Then
            fltPreVen := FieldByName('ITE_PREVE'+strTabPreInt).AsFloat;

          edtUnitar.Text := FormatFloat(fMskDigitos(intDecimal), fltPreVen);

          fltSaldos  := FieldByName('ITE_SALDOS').AsFloat;
          fltSalRes := TSaldoReservado.New(
                         TReservaParametros.New()
                           .EmpresaItem(VS_strCodEmp)
                           .CodigoItem(FieldByName('ITE_CODITE').AsString)
                           .CodEmpresa(VS_strCodEmp)
                         ).fGetQuantidade();

          If fUsaQtdPendenteEntregaFutura Then
            fltSaldos := fltSaldos + TEntregaFutura.New(
                                       TParamEF.New()
                                         .CodIte(FieldByName('ITE_CODITE').AsString)
                                         .CodEmp(VS_strCodEmp)
                                         .Faturamento(True)
                                       ).Total();

          edtSaldos.Text := FormatFloat(fMskDigitos(intDecQtde), fltSaldos - fltSalRes);

          If FieldByName('ITE_MLTVEN').AsFloat > 0 Then
            edtQtdIte.Text := FormatFloat(fMskDigitos(intDecQtde), FieldByName('ITE_MLTVEN').AsFloat)
          Else
            edtQtdIte.Text := FormatFloat(fMskDigitos(intDecQtde), 1);

          fCarregaImagemProduto(FieldByName('ITE_CODITE').AsString, imgFotoProd.Picture);
          cxPageControlProd.ActivePage := tabProdDados;
          pSetFocus(edtQtdIte);
        End
        Else
        Begin
          fMensagem('','Código inexistente!', ['&OK']);
          edtBarras.Clear;
          pSetFocus(edtBarras);
        End;
      End;
    End
    Else
      pSetFocus(edtBarras);
  End;
end;

procedure TfrmVendaAssistida.edtLoginExit(Sender: TObject);
begin
  inherited;
  lblVendedor.Visible := False;
  lblSenha.Visible    := False;

  If length(edtLogin.Text) = 0 Then
    lblVendedor.Visible := True;

  If Length(edtSenha.Text) = 0 Then
    lblSenha.Visible := True;

end;

procedure TfrmVendaAssistida.edtLoginKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If (Key = Char(13)) Then
    If fEmptyStr(edtLogin.Text) then
    Begin
      edtNomOpe.Clear;
      edtSenha.Clear;
    End
    Else
      pCarregaOperador;
end;

procedure TfrmVendaAssistida.edtLoginKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Length(edtLogin.Text) = 0 Then
  Begin
    edtNomOpe.Clear;
    edtSenha.Clear;
    lblVendedor.Visible := True
  End
  Else
    lblVendedor.Visible := False;
end;

procedure TfrmVendaAssistida.edtQtdIteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If (key = Char(13)) Then
  Begin
    If fEmptyStr(edtQtdIte.text) or (edtQtdIte.text = '0,00') or (Length(edtQtdIte.text) >= 13) Then
      edtQtdIte.text := edtMultip.Text;

    pSetFocus(edtQtdIte);
  End;

end;

procedure TfrmVendaAssistida.edtSenhaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Length(edtSenha.Text) = 0 Then
    lblSenha.Visible := True
  Else
    lblSenha.Visible := False;
end;

procedure TfrmVendaAssistida.pCriaClientItens;
Begin
  With cdsProdutos.FieldDefs.AddFieldDef Do Begin
    Name := 'CODITE';
    DataType := ftString;
    Size := fTamCodIte;
  End;

  With cdsProdutos.FieldDefs.AddFieldDef Do Begin
    Name := 'DESITE';
    DataType := ftString;
    Size := 57;
  End;

  With cdsProdutos.FieldDefs.AddFieldDef Do Begin
    Name := 'QTDITE';
    DataType := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;

  With cdsProdutos.FieldDefs.AddFieldDef Do Begin
    Name := 'UNITAR';
    DataType := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;

  With cdsProdutos.FieldDefs.AddFieldDef Do Begin
    Name := 'UNIORI';
    DataType := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;

  cdsProdutos.CreateDataSet;

  TFloatField(cdsProdutos.FieldByName('QTDITE')).DisplayFormat := fMskDigitos(intDecQtde);
  TFloatField(cdsProdutos.FieldByName('UNITAR')).DisplayFormat := fMskDigitos(intDecimal);
End;

procedure TfrmVendaAssistida.pGeraPedido(strEspDocInt: String);
Var
  Result: Boolean;
  strNumDoc   : String;
  dadosItem: TDadosProduto;
  dadosPedido : TDadosPedido;
  objEmitirPedido : TEmitirPedido;

Begin
  If cdsProdutos.IsEmpty then
    exit;

  btnGerarPedido.Enabled    := False;
  btnGerarOrcamento.Enabled := False;

  Try
    objEmitirPedido := TEmitirPedido.Create(Self);

    With dadosPedido Do
    Begin
      strCodCli := strCliente;
      strCodVen := strCodVenInt;
      strCodDig := strLoginUsuarioLogado;
      strConPag := strConPagInt;
      strCodCnd := strCodCndInt;
      strCodFpg := strCodFpgInt;
      fltDesEsp := 0;
      strNumPok := '';
      strMen001 := '';
      strMen002 := '';
      strMenExp := '';
      strTipPed := 'B';
      strTipOpe := 'V';
      strTabPre := strTabPreInt;
      strTipFin := 'P';
      strEntFat := '';
      strNumPok := '';
      dtaGraPed := VS_Date;
      dtaDtaOri := VS_Date;
      dtaHorPed := fRetHoraServidor;
      dtaPreVis := VS_Date;
      fltDesOpeGor := 0;
      dadosPedido.strCodTra := '';
      dadosPedido.intQtdTra := 0;
      dadosPedido.strEspTra := '';
      dadosPedido.fltValFre := 0;
      dadosPedido.strTipFre := '';
      dtaHorImp := 0;
      dtaDtaTra := 0;
      dtaHorTra := 0;
      strAutEnt := '';
      dadosPedido.strEspDoc := strEspDocInt;
      strEmp_CD := '';
      blnEnt_CD := False;
      strTipOpe := 'V';
      blnPedRemGar := False;
    End;

    Result := objEmitirPedido.fIniciarPedido(dadosPedido);

    If Result Then
    Begin
      cdsProdutos.DisableControls;
      cdsProdutos.First;

      While (Not cdsProdutos.Eof) And Result Do
      Begin

        With dadosItem Do
        Begin
          strNumLot := '';
          strCodIte := cdsProdutos.FieldByName('CODITE').AsString;
          strIdePro := 'NOR';
          strBrinde := 'N';
          strDesIte := cdsProdutos.FieldByName('DESITE').AsString;
          fltQtdIte := cdsProdutos.FieldByName('QTDITE').AsFloat;
          fltUnitar := cdsProdutos.FieldByName('UNITAR').AsFloat;
          fltUniOri := cdsProdutos.FieldByName('UNIORI').AsFloat;
          strTabIte := strTabPreInt;
          strEmpIte := '';
          strEntRet := 'R';
          blnBxSbIt := False;
          dadosItem.strPromoc := strPromocInt;

          FillChar(recForTin, SizeOf(recForTin), #0);
          FillChar(recInfAut, SizeOf(recInfAut), #0);
          recInfAut.fltVolume := 0;
        End;

        Result := Result And objEmitirPedido.fInserirProduto(dadosItem);

        cdsProdutos.next;
      end;

      objEmitirPedido.fSetImprimeDocs(false);

      If Result Then
        Result := objEmitirPedido.fCalcularTotais And
                  objEmitirPedido.fValidarPedido  And
                  objEmitirPedido.fGravarPedido;
    end;

    cdsProdutos.EnableControls;

    If Result Then
    begin
      strNumDoc := objEmitirPedido.fGetNumDoc;

      fMensagem('','Documento'+#13+
                    strEspDocInt+' - '+strNumDoc+#13+
                   'Gerado com sucesso.',['&OK']);
    end;

  Finally

    If Assigned(objEmitirPedido) Then
      FreeAndNil(objEmitirPedido);

    btnGerarPedido.Enabled    := True;
    btnGerarOrcamento.Enabled := True;
    cxPageControl.ActivePage := tabConsulta;
    cdsProdutos.EmptyDataSet;
    pLimpaTela;
  End;
end;

end.
