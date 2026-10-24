unit untAltGlobalPromocoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.StdCtrls,
  Vcl.ExtCtrls, EditFocus, Vcl.Mask, MaskEditFocus, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, untTypesSistema,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  CurrencyEditFocus, Uni, System.StrUtils, cxProgressBar, cxCurrencyEdit,
  Vcl.CheckLst;

type
  TfrmAltGlobalPromocoes = class(TfrmPaiConfirma)
    Panel1: TPanel;
    Label9: TLabel;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    edtDesIte: TEditFocus;
    edtCodIte: TEditFocus;
    Label4: TLabel;
    Label11: TLabel;
    edtMarca: TEditFocus;
    edtDesMarca: TEditFocus;
    edtDesFornecedor: TEditFocus;
    edtFornecedor: TEditFocus;
    Label10: TLabel;
    lblDescricao: TLabel;
    edtDescriIni: TEditFocus;
    Label13: TLabel;
    edtDescriFin: TEditFocus;
    Label8: TLabel;
    edtRefere: TEditFocus;
    Label12: TLabel;
    edtCodUni: TEditFocus;
    rdgTipAlt: TRadioGroup;
    rdgPreDes: TRadioGroup;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtCodPro: TEditFocus;
    mskDtaIni: TcxDateEdit;
    mskDtaFim: TcxDateEdit;
    Bevel1: TBevel;
    Bevel2: TBevel;
    chkPreCus: TCheckBox;
    chkPreVen: TCheckBox;
    chkPerDes: TCheckBox;
    chkComInt: TCheckBox;
    chkComLoj: TCheckBox;
    edtPreCus: TCurrencyEditFocus;
    edtPreVen: TCurrencyEditFocus;
    edtPerDes: TCurrencyEditFocus;
    chkComDis: TCheckBox;
    edtComInt: TCurrencyEditFocus;
    edtComLoj: TCurrencyEditFocus;
    edtComDis: TCurrencyEditFocus;
    edtDesPro: TEditFocus;
    edtDesUni: TEditFocus;
    chkPromocao: TCheckBox;
    clbTabPre: TCheckListBox;
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUniExit(Sender: TObject);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProExit(Sender: TObject);
    procedure edtCodProKeyPress(Sender: TObject; var Key: Char);
    procedure chkPreCusClick(Sender: TObject);
    procedure chkPreVenClick(Sender: TObject);
    procedure chkPerDesClick(Sender: TObject);
    procedure chkComIntClick(Sender: TObject);
    procedure chkComLojClick(Sender: TObject);
    procedure chkComDisClick(Sender: TObject);
    procedure edtDescriIniExit(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure rdgTipAltClick(Sender: TObject);
    procedure clbTabPreClickCheck(Sender: TObject);
    procedure clbTabPreDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure clbTabPreExit(Sender: TObject);
    procedure clbTabPreEnter(Sender: TObject);
    procedure chkPromocaoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rdgPreDesClick(Sender: TObject);
  private
    { Private declarations }
    arrPromocao,
    arrLinhaGrupo,
    arrProdutos,
    arrMarca,
    arrFornecedor,
    arrUni: TConsultasArray;

    strPromocao,
    strLinhaGrupo,
    strProdutos,
    strMarca,
    strFornecedor,
    strUni: String;

    function fGetTabelasPrecoSelecionadas: String;

    procedure pInfoStatusGravacao(pgbStatus: TcxProgressBar; strInformacao: String; intMax: Integer = 0);
    procedure pStepStatusGravacao(pgbStatus: TcxProgressBar);

    function fGetWhere: String;
    procedure pSetaParametro(qryGen: TUniQuery);

    function fConfirma(pgbStatus: TcxProgressBar): Boolean;
  public
    { Public declarations }
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmAltGlobalPromocoes: TfrmAltGlobalPromocoes;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untFuncoesConsulta,
  untAltGlobalPromocoesItens, untAltGlobalPromocoesDao,
  untAltGlobalPromocoesIntf, untFactoryClass, untGravando;

procedure TfrmAltGlobalPromocoes.btnConfirmaClick(Sender: TObject);
  Var
    frmAguarde: TfrmGravando;
    blnConfirma: Boolean;
begin
  Try
    If Not fVerificaCampos Then
      Exit;

    If (Not edtPreCus.Enabled)   And
       (Not edtPreVen.Enabled)   And
       (Not edtPerDes.Enabled)   And
       (Not edtComInt.Enabled)   And
       (Not edtComLoj.Enabled)   And
       (Not edtComDis.Enabled)   And
       (Not chkPromocao.Checked) Then
    Begin
      fMensagem('','É necessário informar pelo menos um campo para a alteração!',['&OK']);
      Exit;
    End;

    If chkPromocao.Checked Then
    Begin
      If Pos('S', fGetTabelasPrecoSelecionadas) <= 0 Then
      Begin
        fMensagem('AVISO','Selecione ao menos uma tabela de preço para a promoção!', ['&O K']);
        pSetFocus(clbTabPre);
        Exit;
      End;
    End;

    pCriarFormularios(TfrmAltGlobalPromocoesItens, frmAltGlobalPromocoesItens);

    pCriarFormularios(TfrmGravando, frmAguarde);
    frmAguarde.fExecutarAcao := fConfirma;
    frmAguarde.ShowModal;
    blnConfirma := frmAguarde.blnConfirma;
    pFreeAndNil(frmAguarde);

    If blnConfirma Then
    Begin
      frmAltGlobalPromocoesItens.taTipAlt := IIF(rdgTipAlt.ItemIndex = 0, taFator, taValor);
      frmAltGlobalPromocoesItens.pExibeCamposGrid;
      frmAltGlobalPromocoesItens.ShowModal;
    End
    Else
      fMensagem('ATENÇÃO!', 'Não existem dados para serem alterados!', ['&Ok']);

    pFreeAndNil(frmAltGlobalPromocoesItens);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
end;

procedure TfrmAltGlobalPromocoes.btnSairClick(Sender: TObject);
begin
  //inherited;
  Close;
end;

procedure TfrmAltGlobalPromocoes.chkComDisClick(Sender: TObject);
begin
  inherited;
  edtComDis.Requerido := chkComDis.Checked;
  edtComDis.Enabled   := edtComDis.Requerido;
end;

procedure TfrmAltGlobalPromocoes.chkComIntClick(Sender: TObject);
begin
  inherited;
  edtComInt.Requerido := chkComInt.Checked;
  edtComInt.Enabled   := edtComInt.Requerido;
end;

procedure TfrmAltGlobalPromocoes.chkComLojClick(Sender: TObject);
begin
  inherited;
  edtComLoj.Requerido := chkComLoj.Checked;
  edtComLoj.Enabled   := edtComLoj.Requerido;
end;

procedure TfrmAltGlobalPromocoes.chkPerDesClick(Sender: TObject);
begin
  inherited;
  edtPerDes.Requerido := chkPerDes.Checked;
  edtPerDes.Enabled   := edtPerDes.Requerido;
end;

procedure TfrmAltGlobalPromocoes.chkPreCusClick(Sender: TObject);
begin
  inherited;
  edtPreCus.Requerido := chkPreCus.Checked;
  edtPreCus.Enabled   := edtPreCus.Requerido;
end;

procedure TfrmAltGlobalPromocoes.chkPreVenClick(Sender: TObject);
begin
  inherited;
  edtPreVen.Requerido := chkPreVen.Checked;
  edtPreVen.Enabled   := edtPreVen.Requerido;
end;

procedure TfrmAltGlobalPromocoes.chkPromocaoClick(Sender: TObject);
  Var
    intTabPre: Integer;
begin
  inherited;
  clbTabPre.Enabled := chkPromocao.Checked;

  If Not chkPromocao.Checked Then
  Begin
    For intTabPre := 1 To clbTabPre.Items.Count Do
      clbTabPre.Checked[intTabPre -1] := False;
  End;
end;

procedure TfrmAltGlobalPromocoes.clbTabPreClickCheck(Sender: TObject);
  Var
    intTab: Integer;
begin
  inherited;
  For intTab := 1 To clbTabPre.Items.Count Do
    If VS_strTabPrc[intTab] <> 'S' Then
      clbTabPre.Checked[Pred(intTab)] := False;
end;

procedure TfrmAltGlobalPromocoes.clbTabPreDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
  Var
    Flags: Longint;
begin
  With TCheckListBox(Control) Do
  Begin
    If VS_strTabPrc[Succ(Index)] <> 'S' Then
      Canvas.Font.Color  := clSilver;

    Canvas.FillRect(Rect);

    Flags := DrawTextBiDiModeFlags(DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX);

    If Not UseRightToLeftAlignment then
      Inc(Rect.Left, 2)
    Else
      Dec(Rect.Right, 2);

    DrawText(Canvas.Handle, pWideChar(Items[Index]), Length(Items[Index]), Rect, Flags);
  End;
end;

procedure TfrmAltGlobalPromocoes.clbTabPreEnter(Sender: TObject);
begin
  inherited;
  If chkPromocao.Checked Then
    TCheckListBox(Sender).Color := $008080FF;
end;

procedure TfrmAltGlobalPromocoes.clbTabPreExit(Sender: TObject);
begin
  If chkPromocao.Checked Then
  Begin
    If Pos('S', fGetTabelasPrecoSelecionadas) <= 0 Then
    Begin
      fMensagem('AVISO','Selecione ao menos uma tabela de preço para a promoção!', ['&O K']);
      pSetFocus(clbTabPre);
    End
    Else
      TCheckListBox(Sender).Color := clWindow;
  End;
end;

procedure TfrmAltGlobalPromocoes.edtCodIteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodIte,edtDesIte,arrProdutos,nil,fRetNomProduto,'do Produto');
end;

procedure TfrmAltGlobalPromocoes.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Not fEmptyStr(mskLinhaGrupo.Text) Then
  Begin
    Key := #0;
    Exit;
  End;

  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrProdutos, False, nil, 'Consulta de Produtos', '1') Then
  Begin
    fValidaCampos(edtCodIte,False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltGlobalPromocoes.edtCodProExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPro,edtDesPro,arrPromocao,nil,fRetDescPromocao,'da Promoção');
end;

procedure TfrmAltGlobalPromocoes.edtCodProKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqPromocoes(Self, edtCodPro, edtDesPro, Nil, Key, arrPromocao, False) Then
  Begin
    fValidaCampos(edtCodPro, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltGlobalPromocoes.edtDescriIniExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtDescriIni.Text) Then
  Begin
    edtDescriFin.Clear;
    edtDescriFin.Enabled := False;
    pSetFocus(edtRefere);
  End
  Else
  Begin
    edtDescriFin.Enabled := True;
    pSetFocus(edtDescriFin);
  End;
end;

procedure TfrmAltGlobalPromocoes.edtFornecedorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtFornecedor,edtDesFornecedor,arrFornecedor,fRetNomFornecedor,nil,'do Fornecedor');
end;

procedure TfrmAltGlobalPromocoes.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrFornecedor, False) Then
  Begin
    fValidaCampos(edtFornecedor, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltGlobalPromocoes.edtMarcaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtMarca,edtDesMarca,arrMarca,fRetNomMarca,nil,'da Marca');
end;

procedure TfrmAltGlobalPromocoes.edtMarcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltGlobalPromocoes.edtCodUniExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodUni, edtDesUni, arrUni, fRetNomUnidade, nil, 'da Unidade');
end;

procedure TfrmAltGlobalPromocoes.edtCodUniKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqUnidade(Self, edtCodUni, edtDesUni, Nil, Nil, Key, arrUni, False) Then
  Begin
    If fValidaCampos(edtCodUni, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmAltGlobalPromocoes.fConfirma(pgbStatus: TcxProgressBar): Boolean;
  Var
    objAltGlobalPro: IAltGlobalPromocoes;
begin
  pInfoStatusGravacao(pgbStatus, 'Aguarde, Carregando dados para alteração...', 1);
  Application.ProcessMessages;

  objAltGlobalPro := Factory.Create('AltGlobalPromocoes') As IAltGlobalPromocoes;
  objAltGlobalPro.strCodPro := edtCodPro.Text;
  objAltGlobalPro.tpTipPro  := IIF(rdgPreDes.ItemIndex = 0, tpPreco, tpPerDesconto);
  objAltGlobalPro.dtaValIni := mskDtaIni.Date;
  objAltGlobalPro.dtaValFim := mskDtaFim.Date;
  objAltGlobalPro.strLinGru := mskLinhaGrupo.Text;
  objAltGlobalPro.strCodIte := edtCodIte.Text;
  objAltGlobalPro.strCodMar := edtMarca.Text;
  objAltGlobalPro.strCodFor := edtFornecedor.Text;
  objAltGlobalPro.strDesIni := edtDescriIni.Text;
  objAltGlobalPro.strDesFim := edtDescriFin.Text;
  objAltGlobalPro.strRefere := edtRefere.Text;
  objAltGlobalPro.strCodUni := edtCodUni.Text;
  objAltGlobalPro.taTipAlt  := IIF(rdgTipAlt.ItemIndex = 0, taFator, taValor);
  objAltGlobalPro.blnPreCus := chkPreCus.Checked;
  objAltGlobalPro.blnPreVen := chkPreVen.Checked;
  objAltGlobalPro.blnPerDes := chkPerDes.Checked;
  objAltGlobalPro.blnComInt := chkComInt.Checked;
  objAltGlobalPro.blnComLoj := chkComLoj.Checked;
  objAltGlobalPro.blnComDis := chkComDis.Checked;
  objAltGlobalPro.fltPreCus := edtPreCus.Value;
  objAltGlobalPro.fltPreVen := edtPreVen.Value;
  objAltGlobalPro.fltPerDes := edtPerDes.Value;
  objAltGlobalPro.fltComInt := edtComInt.Value;
  objAltGlobalPro.fltComLoj := edtComLoj.Value;
  objAltGlobalPro.fltComDis := edtComDis.Value;
  objAltGlobalPro.strTabPre := fGetTabelasPrecoSelecionadas;

  frmAltGlobalPromocoesItens.cdsItePro := fCriaClientDatset(TAltGlobalPromocoesDao.fFindByPromocoes(objAltGlobalPro, fGetWhere, pSetaParametro));

  pStepStatusGravacao(pgbStatus);
  Application.ProcessMessages;

  Result := frmAltGlobalPromocoesItens.cdsItePro.RecordCount > 0;
end;

function TfrmAltGlobalPromocoes.fGetTabelasPrecoSelecionadas: String;
  Var
    intTabPre: Integer;
begin
  Result := '';
  For intTabPre := 1 To clbTabPre.Items.Count Do
    Result := Result + IIF(clbTabPre.Checked[intTabPre -1], 'S', 'N');
end;

function TfrmAltGlobalPromocoes.fGetWhere: String;
  Var
    strSQLLinGru: String;
    intCnt: Integer;
begin
  Result := '';

  Result := Result + fStrLocate(edtCodPro,arrPromocao, 'PRO_CODPRO', 'CODPRO');

  If (Not fEmptyStr(edtMarca.Text)) Then
    Result := Result + fStrLocate(edtMarca,arrMarca,'ITE_CODMAR','CODMAR');

  If Not fEmptyStr(edtFornecedor.Text) Then
    Result := Result + fStrLocate(edtFornecedor,arrFornecedor,'ITE_CODFOR','CODFOR');

  strSQLLinGru := '';

  If Not fEmptyStr(mskLinhaGrupo.Text) Then
  Begin
    If Length(arrLinhaGrupo) > 1 Then
    Begin
      For intCnt := Low(arrLinhaGrupo) To High(arrLinhaGrupo) Do
      Begin
        If Not fEmptyStr(arrLinhaGrupo[intCnt].strCodigo) Then
        Begin
          If Not fEmptyStr(strSQLLinGru) Then
            strSQLLinGru := strSQLLinGru + ' OR ';

          If RightStr(arrLinhaGrupo[intCnt].strCodigo,3) = '000' Then
            strSQLLinGru := strSQLLinGru + '(LEFT(ITE_CODGRU,3) = ' + QuotedStr(LeftStr(arrLinhaGrupo[intCnt].strCodigo,3)) + ')'
          Else
            strSQLLinGru := strSQLLinGru + '(ITE_CODGRU = ' + QuotedStr(arrLinhaGrupo[intCnt].strCodigo) + ')';
        End;
      End;

      If Not fEmptyStr(strSQLLinGru) Then
        Result := Result + ' AND (' + strSQLLinGru + ') ';
    End
    Else
    Begin
      If RightStr(mskLinhaGrupo.Text,3) = '000' Then
        Result := Result + '  AND LEFT(ITE_CODGRU,3) = LEFT(:CODGRU,3) '
      Else
        Result := Result + '  AND ITE_CODGRU = :CODGRU ';
    End;
  End;

  If Not fEmptyStr(edtCodIte.Text) Then
    Result := Result + fStrLocate(edtCodIte,arrProdutos,'ITE_CODITE','CODITE');

  If Not fEmptyStr(edtCodUni.Text) Then
    Result := Result + fStrLocate(edtCodUni, arrUni, 'ITE_CODUNI', 'CODUNI');
end;

procedure TfrmAltGlobalPromocoes.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtCodIte);
  rdgPreDes.OnClick(rdgPreDes);
end;

procedure TfrmAltGlobalPromocoes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10   : btnConfirma.Click;
    VK_ESCAPE: btnSair.Click;
  End;
end;

function TfrmAltGlobalPromocoes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodPro) Then
      pDesmarcaLista(edtCodPro,arrPromocao)
    Else If (Sender = mskDtaIni) Then
    Begin
      If Not mskDtaIni.ValidateEdit(False) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data inicial inválida!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = mskDtaFim) Then
    Begin
      If Not mskDtaFim.ValidateEdit(False) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final inválida!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = mskLinhaGrupo) Then
    Begin
      If fEmptyStr(mskLinhaGrupo.Text) Then
        edtCodIte.Enabled := True
      Else
        edtCodIte.Enabled := False;

      pDesmarcaLista(mskLinhaGrupo,arrLinhaGrupo,'',6);
    End
    Else If (Sender = edtCodIte) Then
      pDesmarcaLista(edtCodIte,arrProdutos)
    Else If (Sender = edtMarca) Then
      pDesmarcaLista(edtMarca,arrMarca)
    Else If (Sender = edtFornecedor) Then
      pDesmarcaLista(edtFornecedor,arrFornecedor)
    Else If (Sender = edtCodUni) Then
      pDesmarcaLista(edtCodUni,arrUni)
    Else If (Sender = edtPreCus) And edtPreCus.Enabled Then
    Begin
      If edtPreCus.Value <= 0 Then
      Begin
        fMensagem('','O Campo Preço Custo deve ser maior que zero!',['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = edtPreVen) And edtPreVen.Enabled Then
    Begin
      If edtPreVen.Value <= 0 Then
      Begin
        fMensagem('','O Campo Preço Venda deve ser maior que zero!',['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = edtPerDes) And edtPerDes.Enabled Then
    Begin
      If edtPerDes.Value <= 0 Then
      Begin
        fMensagem('','O Campo % Desconto deve ser maior que zero!',['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = edtComInt) And edtComInt.Enabled Then
    Begin
      If edtComInt.Value <= 0 Then
      Begin
        fMensagem('','O Campo % Comissão Vend. Interno deve ser maior que zero!',['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = edtComLoj) And edtComLoj.Enabled Then
    Begin
      If edtComLoj.Value <= 0 Then
      Begin
        fMensagem('','O Campo % Comissão Vend. Externo Loja deve ser maior que zero!',['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = edtComDis) And edtComDis.Enabled Then
    Begin
      If edtComDis.Value <= 0 Then
      Begin
        fMensagem('','O Campo % Comissão Vend. Externo Distribuição deve ser maior que zero!',['&OK']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmAltGlobalPromocoes.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinhaGrupo,edtDesGrupo,arrLinhaGrupo,fRetNomeLinhaGrupo,Nil,'da linha/grupo',6);
end;

procedure TfrmAltGlobalPromocoes.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrLinhaGrupo, False) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltGlobalPromocoes.pInfoStatusGravacao(pgbStatus: TcxProgressBar;
  strInformacao: String; intMax: Integer);
begin
  If Assigned(pgbStatus) And (GetParentForm(pgbStatus).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := strInformacao;
    If intMax > 0 Then
    Begin
      pgbStatus.Properties.Max := intMax;
      pgbStatus.Position := 0;
    End;
    Application.ProcessMessages;
  End;
end;

procedure TfrmAltGlobalPromocoes.pSetaParametro(qryGen: TUniQuery);
begin
  If (Not fEmptyStr(edtCodPro.Text)) Then
    pSetaParam(edtCodPro.Text,arrPromocao,strPromocao,'CODPRO', qryGen);

  If (Not fEmptyStr(edtMarca.Text)) Then
    pSetaParam(edtMarca.Text,arrMarca,strMarca,'CODMAR', qryGen);

  If Not fEmptyStr(edtFornecedor.Text) Then
    pSetaParam(edtFornecedor.Text,arrFornecedor,strFornecedor,'CODFOR', qryGen);

  pSetaParam(mskLinhaGrupo.Text,arrLinhaGrupo,strLinhaGrupo,'CODGRU', qryGen);

  If Not fEmptyStr(edtCodIte.Text) Then
    pSetaParam(edtCodIte.Text,arrProdutos,strProdutos,'CODITE', qryGen);

  If Not fEmptyStr(edtCodUni.Text) Then
    pSetaParam(edtCodUni.Text,arrUni,strUni,'CODUNI', qryGen);
end;

procedure TfrmAltGlobalPromocoes.pStepStatusGravacao(pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

procedure TfrmAltGlobalPromocoes.rdgPreDesClick(Sender: TObject);
begin
  inherited;

  chkPreVen.Enabled := rdgPreDes.ItemIndex = 0;
  chkPerDes.Enabled := rdgPreDes.ItemIndex = 1;

  If (Not chkPreVen.Enabled) Then
  Begin
    chkPreVen.Checked := False;
    edtPreVen.Clear;
  End;

  If (Not chkPerDes.Enabled) Then
  Begin
    chkPerDes.Checked := False;
    edtPerDes.Clear;
  End;
end;

procedure TfrmAltGlobalPromocoes.rdgTipAltClick(Sender: TObject);
begin
  inherited;

  If rdgTipAlt.ItemIndex = 0 Then
  Begin
    edtPreCus.Properties.DecimalPlaces := 6;
    edtPreVen.Properties.DecimalPlaces := 6;
    edtPerDes.Properties.DecimalPlaces := 6;
    edtComInt.Properties.DecimalPlaces := 6;
    edtComLoj.Properties.DecimalPlaces := 6;
    edtComDis.Properties.DecimalPlaces := 6;
  End
  Else
  Begin
    edtPreCus.Properties.DecimalPlaces := 2;
    edtPreVen.Properties.DecimalPlaces := 2;
    edtPerDes.Properties.DecimalPlaces := 2;
    edtComInt.Properties.DecimalPlaces := 2;
    edtComLoj.Properties.DecimalPlaces := 2;
    edtComDis.Properties.DecimalPlaces := 2;
  End;
end;

end.
