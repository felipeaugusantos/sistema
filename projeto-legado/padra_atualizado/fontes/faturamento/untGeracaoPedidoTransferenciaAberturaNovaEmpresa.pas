unit untGeracaoPedidoTransferenciaAberturaNovaEmpresa;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Grids, DBGridCitel, DBGrids, Mask,
  untFuncoesSimples, Uni, MaskEditFocus, EditFocus,
  ComCtrls, Buttons, ExtCtrls, DB, Menus, AppEvnts, strUtils, MemoFocus,
  UniClientDataSet, UniDataSetProvider, cxControls, cxContainer, cxEdit, cxProgressBar,
  BitBtnLockedIncrem, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, frxClass, frxExportCSVTestabilidade,
  dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  Faturamento.Classes.TEmitirPedido, Vcl.Samples.Spin, ComboBoxFocus, System.Generics.Collections, cxButtons;

type
  TfrmGeracaoPedidoTransferenciaAberturaNovaEmpresa = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    pnlBotoesBaixa: TPanel;
    Label20: TLabel;
    edtNomEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnSairAgrup: TBitBtnLocked;
    pnl2: TPanel;
    mmoLogImp: TMemo;
    pnl4: TPanel;
    pnlProgressoGeral: TPanel;
    lblProgressoGeral: TLabel;
    pgbProgressoGeral: TcxProgressBar;
    spnQuantidadeItens: TSpinEdit;
    Label1: TLabel;
    cmbFiltroSaldo: TComboBoxFocus;
    Label2: TLabel;
    Label3: TLabel;
    cmbPrecoUtilizado: TComboBoxFocus;
    Label4: TLabel;
    edtFatorPreco: TEditFocus;
    Label5: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    FileOpenDialog: TFileOpenDialog;
    pnlArquivo: TPanel;
    Label6: TLabel;
    btnOpenDirectory: TcxButton;
    edtNomArq: TEditFocus; 
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairAgrupClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure spnQuantidadeItensKeyPress(Sender: TObject; var Key: Char);
    procedure spnQuantidadeItensExit(Sender: TObject);
    procedure spnQuantidadeItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure edtNomArqExit(Sender: TObject);
    procedure btnOpenDirectoryClick(Sender: TObject);
  private
    { Private declarations }
    qryCadFor : TUniQuery;
    FDicProd  : TDictionary<String,Double>;
    procedure pRegistrarProgresso(strTexto: String; lblInformacao: TLabel;
      pgbProgresso: TCxProgressBar; intInicio, intAtual, intFinal: Integer);
    procedure pRegistraLogImp(strTexto: String);
    procedure pGerarPedidosTransferencia;
    function fIniciarPedidoTransferencia(var objEmitirPedido: TEmitirPedido): Boolean;
    function fGerarPedidoTransferencia(var objEmitirPedido: TEmitirPedido): Boolean;
    procedure pAdicionarProdutoParaTransferencia(qryProduto: TUniQuery; fltQuantidade: Double;
      var objEmitirPedido: TEmitirPedido);
    function fGetSQLProdutos: String;
    procedure pCalculaTotGerProdutoSelecionado(var objEmitirPedido: TEmitirPedido);
    procedure pCarregarProdutosDoArquivo;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

uses untPesqAux, untConsultas, untFuncoes, untPai, untTypesSistema,
  untCadConfRelatorios, untCtrAgrupDupRecibo, untCadRec, untDuplicatas, untFuncFat, untConstantes;

{$R *.dfm}

{ TfrmGeracaoPedidoTransferenciaAberturaNovaEmpresa }

function TfrmGeracaoPedidoTransferenciaAberturaNovaEmpresa.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodEmp) Then
    Begin
      edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
      If edtCodEmp.Text = VS_strCodEmp Then
      Begin
        Result := fMensagem('Atenção','Foi informado como empresa de destino a empresa logada. Essa operação normalmente é '+
                                      'utilizada para gerar o pedido e posteriormente emitir uma nota fiscal para mudança de endereço.' + #13#10 +
                                      'Deseja realmente continuar?',['&Sim', '&Não'], 2) = 1;
      End
      Else If (fEmptyStr(edtCodEmp.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o código da empresa de destino!', ['&Ok']);
        Result := False;
      End
      Else If (fEmptyStr(edtNomEmp.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Nenhuma empresa encontrada com esse código!', ['&Ok']);
        Result := False;
      End
      Else If fEmptyStr(fRetornaClienteFilial(edtCodEmp.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa não possui cliente filial definido no seu cadastro!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtCodFor) Then
    Begin
      If (not fEmptyStr(edtCodFor.Text)) Then
      Begin
        pPesquisaCadFor(qryCadFor, qryCadFor, edtCodFor.Text);

        If qryCadFor.FieldByName('FOR_CODFOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO', 'Esse fornecedor não está cadastrado!', ['&Ok']);
          Result := False;
        End
        else
          edtNomFor.Text  := qryCadFor.FieldByName('FOR_NOMFOR').AsString;
      end
      else
        edtNomFor.Clear;
    End

    Else If (Sender = cmbPrecoUtilizado) Then
    Begin
      If cmbPrecoUtilizado.ItemIndex = -1 Then
      Begin
        fMensagem('ATENÇÃO!', 'Selecione o preço utilizado para a transferência!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtFatorPreco) Then
    Begin
      If fStrToFloat(edtFatorPreco.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O fator sobre o preço deve ser maior que zero!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmGeracaoPedidoTransferenciaAberturaNovaEmpresa.pAdicionarProdutoParaTransferencia(
  qryProduto: TUniQuery; fltQuantidade: Double; var objEmitirPedido: TEmitirPedido);
Var
  dadosItem: TDadosProduto;
begin
  FillChar(dadosItem, SizeOf(dadosItem), #0);

  dadosItem.dtaDtaPed := VS_Date;
  dadosItem.strNumLot := qryProduto.FieldByName('NUMLOT').AsString;
  dadosItem.strCodIte := qryProduto.FieldByName('CODITE').AsString;
  dadosItem.strIdePro := 'NOR';
  dadosItem.strDesIte := qryProduto.FieldByName('DESITE').AsString;
  dadosItem.fltQtdIte := fltQuantidade;
  dadosItem.strEntRet := 'E';
  dadosItem.strMd5Key := '';
  dadosItem.strPromoc := 'N';
  dadosItem.blnBxSbIt := False;
  dadosItem.strCodDiv := '';
  dadosItem.strTabIte := objEmitirPedido.objFatVenda.strTabPre;
  dadosItem.strEmpIte := VS_strCodEmp;

  If qryProduto.FieldByName('PRE_TE').AsFloat > 0 Then
  Begin
    dadosItem.fltUnitar := qryProduto.FieldByName('PRE_TE').AsFloat * fStrToFloat(edtFatorPreco.Text);
    dadosItem.fltUniOri := qryProduto.FieldByName('PRE_TE').AsFloat * fStrToFloat(edtFatorPreco.Text);
  End
  Else
  Begin
    dadosItem.fltUnitar := qryProduto.FieldByName('PRECUS').AsFloat * fStrToFloat(edtFatorPreco.Text);
    dadosItem.fltUniOri := qryProduto.FieldByName('PRECUS').AsFloat * fStrToFloat(edtFatorPreco.Text);
  End;

  If dadosItem.fltUnitar <= 0 Then
  Begin
    pRegistraLogImp('Não foi possível adicionar o produto [' +
      dadosItem.strCodIte + '] no Pedido de transferência: o produto não '+
        'possui preço de custo informado no seu cadastro.');
    Exit;
  End;

  If Not objEmitirPedido.fInserirProduto(dadosItem) Then
  Begin
    pRegistraLogImp('Não foi possível adicionar o produto [' +
      dadosItem.strCodIte + '] no Pedido de transferência');
    Exit;
  End;

  Try
    pCalculaTotGerProdutoSelecionado(objEmitirPedido);
  Except
    On E: Exception Do
    Begin
      If Not cdsVenda.IsEmpty Then cdsVenda.Delete;//Remove o item com erro
      pRegistraLogImp('Ocorreu um erro ao adicionar o produto [' +
        dadosItem.strCodIte + '] no Pedido de transferência: ' + E.Message);
    End;
  End;
end;

procedure TfrmGeracaoPedidoTransferenciaAberturaNovaEmpresa.pCalculaTotGerProdutoSelecionado(
  var objEmitirPedido: TEmitirPedido);
begin
  objEmitirPedido.objFatVenda.pPreencheMatrizFechamento('AUTOINCREM = ' + cdsVenda.FieldByName('AUTOINCREM').AsString);
  objEmitirPedido.objFatVenda.pCalculaTotGer(True);
end;

procedure TfrmGeracaoPedidoTransferenciaAberturaNovaEmpresa.pCarregarProdutosDoArquivo;
Var
  LFile: TStringList;
  LProd: TArray<String>;
  LLine: String;
begin
  FDicProd.Clear;
  If fEmptyStr(edtNomArq.Text) Then
    Exit;
  If Not FileExists(edtNomArq.Text) Then
    Raise EFileNotFoundException.Create('Arquivo não encontrado!'#13#10+edtNomArq.Text);
  LFile := TStringList.Create();
  Try
    LFile.LoadFromFile(edtNomArq.Text);
    For LLine In LFile Do
    Begin
      LProd := LLine.Split([';']);
      FDicProd.AddOrSetValue(LProd[0],LProd[1].Trim.Replace('.', ',').ToDouble);
    End;
  Finally
    LFile.Free;
  End;
end;

procedure TfrmGeracaoPedidoTransferenciaAberturaNovaEmpresa.pRegistraLogImp(strTexto: String);
begin
  If Not fEmptyStr(strTexto) Then
    mmoLogImp.Lines.Add(FormatDateTime('hh:mm:ss', fTime()) + ' - ' + strTexto);
end;

procedure TfrmGeracaoPedidoTransferenciaAberturaNovaEmpresa.pRegistrarProgresso(strTexto: String;
  lblInformacao: TLabel; pgbProgresso: TCxProgressBar; intInicio, intAtual, intFinal: Integer);
begin
  pgbProgresso.properties.Max := intFinal;
  pgbProgresso.properties.Min := intInicio;
  pgbProgresso.Position := intAtual;
  lblInformacao.Caption := Format('%s %d / %d',  [strTexto ,intAtual, intFinal]);
  Application.ProcessMessages;
end;

procedure TfrmGeracaoPedidoTransferenciaAberturaNovaEmpresa.spnQuantidadeItensExit(
  Sender: TObject);
begin
  inherited;
  spnQuantidadeItens.Value := StrToIntDef(spnQuantidadeItens.Text, 250);
end;

procedure TfrmGeracaoPedidoTransferenciaAberturaNovaEmpresa.spnQuantidadeItensKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
    SelectNext(spnQuantidadeItens, True, True);
end;

procedure TfrmGeracaoPedidoTransferenciaAberturaNovaEmpresa.spnQuantidadeItensKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If Key = '-' Then
    Key := #0;
end;

procedure TfrmGeracaoPedidoTransferenciaAberturaNovaEmpresa.pGerarPedidosTransferencia;
  Var
    qryProdutos: TUniQuery;
    fltQuantidade: Double;
    objEmitirPedido: TEmitirPedido;
begin
  qryProdutos := fCriaQuery();
  Try
    pRegistrarProgresso('Aguarde, carregando produtos para transferência ...',
      lblProgressoGeral, pgbProgressoGeral, 0, 0, 0);

    qryProdutos.SQL.Text := fGetSQLProdutos;
    qryProdutos.Open;

    pCarregarProdutosDoArquivo;

    pRegistrarProgresso('Aguarde, iniciando geração de pedidos de transferência ...', lblProgressoGeral,
      pgbProgressoGeral, 0, qryProdutos.RecNo, qryProdutos.RecordCount);

    If Not fIniciarPedidoTransferencia(objEmitirPedido) Then
    Begin
      pRegistraLogImp('Não foi possível iniciar a geração de pedidos de transferência');
      Exit;
    End;

    If qryProdutos.IsEmpty Then
    Begin
      pMensagemOk('Não há produtos para geração de pedidos!');
      Exit;
    End;

    qryProdutos.First;

    While Not qryProdutos.Eof Do
    Begin
      pRegistrarProgresso('Aguarde, processando produtos ...', lblProgressoGeral,
        pgbProgressoGeral, 0, qryProdutos.RecNo, qryProdutos.RecordCount);

      If fEmptyStr(edtNomArq.Text) Then
      Begin
        Case cmbFiltroSaldo.ItemIndex Of
          0: fltQuantidade := qryProdutos.FieldByName('SALDOS').AsFloat;
          1: fltQuantidade := fRetornaSaldoDisponivel(qryProdutos.FieldByName('CODITE').AsString,
                                                      False, True, qryProdutos.FieldByName('NUMLOT').AsString,
                                                      True, VS_strCodEmp);
          Else fltQuantidade := 0;
        end;
      End
      Else If Not FDicProd.TryGetValue(qryProdutos.FieldByName('CODITE').AsString, fltQuantidade) Then
        fltQuantidade := 0;

      If fltQuantidade > 0 Then
        pAdicionarProdutoParaTransferencia(qryProdutos, fltQuantidade, objEmitirPedido);

      If (Not cdsVenda.IsEmpty) And
         ((cdsVenda.RecordCount >= spnQuantidadeItens.Value) Or (qryProdutos.RecordCount = qryProdutos.RecNo)) Then
      Begin
        Try
          pRegistrarProgresso('Aguarde, gerando novo pedido de transferência ...', lblProgressoGeral,
            pgbProgressoGeral, 0, qryProdutos.RecNo, qryProdutos.RecordCount);

          If Not fGerarPedidoTransferencia(objEmitirPedido) Then
            pRegistraLogImp('Não foi possível gerar um novo pedido de transferência')
          Else
            pRegistraLogImp('Novo pedido de transferência foi criado ' +
              objEmitirPedido.objFatVenda.strNumDoc + '-PD');
        Finally
          cdsVenda.EmptyDataSet;
        End;
      End;

      qryProdutos.Next;
    End;

    qryProdutos.Close;

    pMensagemOk('Processamento dos produtos foi concluído!');
    pRegistrarProgresso('...', lblProgressoGeral, pgbProgressoGeral, 0, 0, 0);

  Finally
    If Assigned(qryProdutos) Then
      FreeAndNil(qryProdutos);

    If Assigned(objEmitirPedido) Then
      FreeAndNil(objEmitirPedido);
  End;
end;

procedure TfrmGeracaoPedidoTransferenciaAberturaNovaEmpresa.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then Exit;
  Try
    mmoLogImp.Clear;
    Self.Enabled := False;
    btnConfirma.Enabled := False;
    pGerarPedidosTransferencia;
  Finally
    Self.Enabled := True;
    btnConfirma.Enabled := True;
  End;
end;

procedure TfrmGeracaoPedidoTransferenciaAberturaNovaEmpresa.btnOpenDirectoryClick(Sender: TObject);
begin
  inherited;
  If FileOpenDialog.Execute Then
    edtNomArq.Text := FileOpenDialog.FileName;
  pSetFocus(edtNomArq);
end;

procedure TfrmGeracaoPedidoTransferenciaAberturaNovaEmpresa.btnSairAgrupClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmGeracaoPedidoTransferenciaAberturaNovaEmpresa.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGeracaoPedidoTransferenciaAberturaNovaEmpresa.edtCodForKeyPress(
  Sender: TObject; var Key: Char);
Var
   arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec, False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGeracaoPedidoTransferenciaAberturaNovaEmpresa.edtNomArqExit(Sender: TObject);
begin
  inherited;
  edtCodFor.Enabled := fEmptyStr(edtNomArq.Text);
  cmbFiltroSaldo.Enabled := fEmptyStr(edtNomArq.Text);

  If fEmptyStr(edtNomArq.Text) Then
    Exit;

  edtCodFor.Text := '';
  edtNomFor.Text := '';

  If Not FileExists(edtNomArq.Text) Then
  Begin
    pMensagemOk('Arquivo não encontrado!'#13#10+edtNomArq.Text);
    pSetFocus(edtNomArq);
    edtNomArq.Clear;
  End;
end;

function TfrmGeracaoPedidoTransferenciaAberturaNovaEmpresa.fGerarPedidoTransferencia(
  var objEmitirPedido: TEmitirPedido): Boolean;
begin
  objEmitirPedido.objFatVenda.strEspDoc := 'PD';
  Result := objEmitirPedido.fCalcularTotais And objEmitirPedido.fGravarPedido;
end;

function TfrmGeracaoPedidoTransferenciaAberturaNovaEmpresa.fGetSQLProdutos: String;
begin
  Result :=
      ' SELECT SQL_NO_CACHE ' +
      '   C.ITE_CODITE AS CODITE, ' +
      '   L.LOT_NUMLOT AS NUMLOT, ' +
      '   C.ITE_DESITE AS DESITE, ' +
      '   I.ITE_PRECUS AS PRECUS, ' +
      '   I.ITE_' + TPrecosParaTransferencia(cmbPrecoUtilizado.Items.Objects[
        cmbPrecoUtilizado.ItemIndex]).GetCampo + ' AS PRE_TE, ' +
      '   COALESCE(L.LOT_SALDOS, I.ITE_SALDOS) AS SALDOS ' +
      ' FROM ' +
      '   CADITE C ' +
      '   INNER JOIN ITEGER I ' +
      '     ON C.ITE_CODITE = I.ITE_CODITE ' +
      '   LEFT JOIN CADLOT L ' +
      '     ON L.LOT_CODITE = I.ITE_CODITE ' +
      '     AND L.LOT_CODEMP = I.ITE_CODEMP ' +
      ' WHERE I.ITE_CODEMP = ' + VS_strCodEmp.QuotedString;

  If fEmptyStr(edtNomArq.Text) Then
  Begin
    If not fEmptyStr(edtCodFor.Text) then
      Result := Result + ' AND C.ITE_CODFOR = ' + QuotedStr(edtCodFor.Text);

    Case cmbFiltroSaldo.ItemIndex Of
      0: Result := Result + ' AND COALESCE(L.LOT_SALDOS, I.ITE_SALDOS) > 0 ';
      1: Result := Result + ' AND (' + fSQLSaldoDisponivel('I', True) + ') > 0 ';
    End;
  End;

  Result := Result + ' ORDER BY C.ITE_DESITE ';
end;

function TfrmGeracaoPedidoTransferenciaAberturaNovaEmpresa.fIniciarPedidoTransferencia(
  var objEmitirPedido: TEmitirPedido): Boolean;
  Var
    dadosPedido: TDadosPedido;
begin
  objEmitirPedido := TEmitirPedido.Create(Nil);
  objEmitirPedido.blnModoRobo := False;

  objEmitirPedido.mmoInformacao := nil;
  objEmitirPedido.lblInformacao := nil;
  objEmitirPedido.pgbProgresso  := nil;
  
  FillChar(dadosPedido, SizeOf(dadosPedido), #0);

  dadosPedido.blnSfaPag := False;
  dadosPedido.strEmpLogSfa := VS_strCodEmp;
  dadosPedido.strCodCli := fRetornaClienteFilial(edtCodEmp.Text);
  dadosPedido.strCodVen := strLoginUsuarioLogado;
  dadosPedido.strCodDig := strLoginUsuarioLogado;
  dadosPedido.strConPag := '01000';
  dadosPedido.strCodCnd := fRetCodCndAVista;
  dadosPedido.strCodFpg := '001';
  dadosPedido.fltDesEsp := 0.00;
  dadosPedido.strMen001 := STR_MSG_PEDIDO_NOVA_LOJA;
  dadosPedido.strMen002 := '';
  dadosPedido.strMenExp := STR_MSG_PEDIDO_NOVA_LOJA;
  dadosPedido.strTipPed := 'A';
  dadosPedido.strCodDiv := '';
  dadosPedido.strTipOpe := 'V';
  dadosPedido.strTipFre := '1';
  dadosPedido.strTabPre := Pos('S', VS_strTabVen).ToString;
  dadosPedido.strTipFin := 'P';
  dadosPedido.strEntFat := 'S';
  dadosPedido.strNumPok := '';
  dadosPedido.fltValFre := 0.00;
  dadosPedido.strCodTra := '';
  dadosPedido.dtaHorImp := 0;
  dadosPedido.dtaDtaTra := 0;
  dadosPedido.dtaHorTra := 0;
  dadosPedido.strCodRot := '';
  dadosPedido.dtaPreVis := VS_Date;
  dadosPedido.dtaGraPed := VS_Date;
  dadosPedido.dtaDtaOri := VS_Date;
  dadosPedido.dtaHorPed := fTime();
  dadosPedido.strEspDoc := 'PD';
  dadosPedido.strAutEnt := '';
  dadosPedido.strCodTpA := '';
  dadosPedido.strEnvLib := 'S';
  dadosPedido.strEmp_CD := '';
  dadosPedido.blnEnt_CD := False;
  dadosPedido.blnGravarDavPv := False;

  Result := objEmitirPedido.fIniciarPedido(dadosPedido);

  If Result Then
  Begin
    objEmitirPedido.objFatVenda.strEmp_TE      := VS_strCodEmp;
    objEmitirPedido.objFatVenda.blnImprimeDocs := False;
    objEmitirPedido.objFatVenda.blnImprimeSep  := False;
  End;
end;

procedure TfrmGeracaoPedidoTransferenciaAberturaNovaEmpresa.FormCreate(
  Sender: TObject);
  var
    ePrecoTransferencia: TPrecosParaTransferencia;
begin
  inherited;
  FDicProd := TDictionary<String,Double>.Create;

  cmbPrecoUtilizado.Items.Clear;

  for ePrecoTransferencia := low(TPrecosParaTransferencia) to high(TPrecosParaTransferencia) do
    if ePrecoTransferencia.PodeUtilizar(VS_strTabVen) then
      cmbPrecoUtilizado.AddItem(ePrecoTransferencia.GetDescricao, TObject(ePrecoTransferencia));

  cmbPrecoUtilizado.ItemIndex := 0;
  qryCadFor := fCriaQuery(Self);
end;

procedure TfrmGeracaoPedidoTransferenciaAberturaNovaEmpresa.FormDestroy(
  Sender: TObject);
begin
  inherited;
  FreeAndNil(FDicProd);
  FreeAndNil(qryCadFor);
end;

procedure TfrmGeracaoPedidoTransferenciaAberturaNovaEmpresa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
Var
  strSenha: String;
begin
  inherited;
  If Key = VK_F10 Then
    btnConfirma.Click;
  If (Key = VK_F2) And (Shift = [ssShift, ssCtrl]) And (Not pnlArquivo.Visible) Then
    pnlArquivo.Visible := ffrmSenha(strSenha, 'Selecionar Arquivo') And strSenha.Equals(SEN_PROCOD);
end;

end.
