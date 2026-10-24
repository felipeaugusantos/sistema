unit untFrameFiltrosCatPromocao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  ComboBoxFocus, Vcl.Mask, MaskEditFocus, EditFocus, Vcl.ExtCtrls,
  untTypesSistema, Promocao.Classes.CatalogoPromocao, Vcl.ComCtrls;

type
  TframeFiltrosCatPromocao = class(TFrame)
    pnlFiltrosProdutos: TPanel;
    pnlFiltrosPromocao: TPanel;
    grpProdutos: TGroupBox;
    lblDepartamento: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    lblDescricao: TLabel;
    lbl2: TLabel;
    Label58: TLabel;
    lblDesCon: TLabel;
    lblTabPreco: TLabel;
    Label59: TLabel;
    shpLiberadoDesconto: TShape;
    shpLiberadoTabSProm: TShape;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    edtCodDepPrm: TEditFocus;
    mskLinGruPrm: TMaskEditFocus;
    edtDesGruPrm: TEditFocus;
    edtDesDepPrm: TEditFocus;
    edtCodMarPrm: TEditFocus;
    edtDesMarPrm: TEditFocus;
    edtDescri: TEditFocus;
    edtCodItePrm: TEditFocus;
    edtDesItePrm: TEditFocus;
    cmbComSaldo: TComboBoxFocus;
    edtDesconto: TEditFocus;
    chkCatalogoComPreco: TCheckBox;
    cbTabPreco: TComboBoxFocus;
    edtCodForPrm: TEditFocus;
    edtNomForPrm: TEditFocus;
    chkPrecoImposto: TCheckBox;
    mskDtaSemVendaIni: TMaskEditFocus;
    mskDtaSemVendaFin: TMaskEditFocus;
    edtNroDiasSemVenda: TEditFocus;
    edtCodEmpPrm: TEditFocus;
    edtDesEmpPrm: TEditFocus;
    grpPromocao: TGroupBox;
    lbl4: TLabel;
    Label2: TLabel;
    lblTabPrecoPromocinal: TLabel;
    shpLiberadoTabCProm: TShape;
    chkSomenteEmPromocao: TCheckBox;
    mskDataVigencia: TMaskEditFocus;
    edtCodPro: TEditFocus;
    edtDesPro: TEditFocus;
    cbTabPrecoProm: TComboBoxFocus;
    procedure edtCodItePrmKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodItePrmExit(Sender: TObject);
    procedure mskLinGruPrmKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinGruPrmExit(Sender: TObject);
    procedure edtCodMarPrmExit(Sender: TObject);
    procedure edtCodMarPrmKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepPrmExit(Sender: TObject);
    procedure edtCodDepPrmKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForPrmKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForPrmExit(Sender: TObject);
    procedure edtCodEmpPrmExit(Sender: TObject);
    procedure edtCodEmpPrmKeyPress(Sender: TObject; var Key: Char);
    procedure cbTabPrecoSelect(Sender: TObject);
    procedure edtCodProExit(Sender: TObject);
    procedure edtCodProKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FobjCatProm: TCatalogoPromocao;

    arrCodItePrm,
    arrLinGruPrm,
    arrCodMarPrm,
    arrCodDepPrm,
    arrCodForPrm,
    arrCodEmpPrm,
    arrPromocao: TConsultasArray;

    FParentForm: TForm;
    strDtaVigAnt: String;
    strEmpConsVendFatur: String;

    procedure pSetSpinTabelaSistemaVA(const blnLiberado: Boolean);
    procedure pSetSpinDescontoSistemaVA(const blnLiberado: Boolean);
    procedure pCarregaTabPreco;
    procedure pSugereTabPrecoDefault;
    procedure pCarregaTabPrecoProm;
    procedure pSugereTabPrecoPromoDefault;


    function fVerificaPodeAlterarVigencia: Boolean;
  protected
    function  fVerificaSubObjeto(objObjeto: TWinControl): Boolean;
  public
    { Public declarations }
    strCodCli: String;
    strCndPag: String;
    blnFiltrosProm: Boolean;

    procedure pInicializaFiltros;
    procedure pSetParamObjCatProm(objProm: TCatalogoPromocao);
    procedure pLimparFiltros;
    procedure pHabilitarDesabilitar(const blnHabilitar: Boolean);

    function  fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean = False): Boolean;
    function  fFiltraDadosUltVnd: Boolean;
    function  fFiltraDadosUltVndEmp: Boolean;

    function  fVerificaCampos: Boolean;

    property ParentForm: TForm     read FParentForm write FParentForm;
    property objCatProm: TCatalogoPromocao read FobjCatProm write FobjCatProm;
  end;

implementation

{$R *.dfm}

uses
  untFuncoesConsulta, untFuncoesSimples, untConsultas, untLiberacao;

{ TfraFiltrosCatPromocao }

procedure TframeFiltrosCatPromocao.cbTabPrecoSelect(Sender: TObject);
begin
  fValidaCampos(cbTabPreco, True);
end;

procedure TframeFiltrosCatPromocao.edtCodDepPrmExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodDepPrm, edtDesDepPrm, arrCodDepPrm, fRetDescDepartamento, nil, 'do departamento');
end;

procedure TframeFiltrosCatPromocao.edtCodDepPrmKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqDepartamento(FParentForm, edtCodDepPrm, edtDesDepPrm, Nil, Key, arrCodDepPrm, False) Then
  Begin
    If fValidaCampos(edtCodDepPrm, True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TframeFiltrosCatPromocao.edtCodEmpPrmExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodEmpPrm, edtDesEmpPrm, arrCodEmpPrm, Nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TframeFiltrosCatPromocao.edtCodEmpPrmKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqEmpresa(conEmpSimples, FParentForm, edtCodEmpPrm, edtDesEmpPrm, Nil, Key, arrCodEmpPrm, False, True) Then
  Begin
    If fValidaCampos(edtCodEmpPrm) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TframeFiltrosCatPromocao.edtCodForPrmExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodForPrm, edtNomForPrm, arrCodForPrm, fRetNomFornecedor, nil, 'do Fornecedor');
end;

procedure TframeFiltrosCatPromocao.edtCodForPrmKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqFornecedor(conForSimples, FParentForm, edtCodForPrm, Nil, Nil, Key, arrCodForPrm, False) Then
  Begin
    If fValidaCampos(edtCodForPrm, True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TframeFiltrosCatPromocao.edtCodItePrmExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodItePrm, edtDesItePrm, arrCodItePrm, Nil, fRetNomProduto, 'do produto');
end;

procedure TframeFiltrosCatPromocao.edtCodItePrmKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqItem(conIteSimples, FParentForm, edtCodItePrm, edtDesItePrm, Nil, Key, arrCodItePrm, False, nil, 'Consulta de Itens', '1') then
  Begin
    If fValidaCampos(edtCodItePrm, True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TframeFiltrosCatPromocao.edtCodMarPrmExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodMarPrm, edtDesMarPrm, arrCodMarPrm, fRetNomeMarca, Nil, 'da Marca');
end;

procedure TframeFiltrosCatPromocao.edtCodMarPrmKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqMarcas(FParentForm, edtCodMarPrm, edtDesMarPrm, Nil, Key, arrCodMarPrm, False) Then
  Begin
    If fValidaCampos(edtCodMarPrm, True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TframeFiltrosCatPromocao.edtCodProExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodPro, edtDesPro, arrPromocao, nil, fRetDescPromocao, 'da Promoção');
end;

procedure TframeFiltrosCatPromocao.edtCodProKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqPromocoes(FParentForm, edtCodPro, edtDesPro, nil, Key, arrPromocao, False) Then
  Begin
    If fValidaCampos(edtCodPro,False) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

function TframeFiltrosCatPromocao.fFiltraDadosUltVnd: Boolean;
begin
  Result := (StrToIntDef(edtNroDiasSemVenda.Text, 0) > 0) Or
            ((StrToDateDef(mskDtaSemVendaIni.Text, 0) > 0) And
             (StrToDateDef(mskDtaSemVendaFin.Text, 0) > 0));
end;

function TframeFiltrosCatPromocao.fFiltraDadosUltVndEmp: Boolean;
begin
  Result := Not(fEmptyStr(edtCodEmpPrm.Text));
end;

function TframeFiltrosCatPromocao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtCodItePrm) Then
    pDesmarcaLista(edtCodItePrm, arrCoditePrm)
  Else If (Sender = mskLinGruPrm) Then
    pDesmarcaLista(mskLinGruPrm, arrLinGruPrm)
  Else If (Sender = edtCodMarPrm) Then
    pDesmarcaLista(edtCodMarPrm, arrCodMarPrm)
  Else If (Sender = edtCodDepPrm) Then
    pDesmarcaLista(edtCodDepPrm, arrCodDepPrm)
  Else If (Sender = edtCodForPrm) Then
    pDesmarcaLista(edtCodForPrm, arrCodForPrm)
  Else If (Sender = edtCodPro) Then
    pDesmarcaLista(edtCodPro, arrPromocao)

  Else If (Sender = edtDesconto) Then
  Begin
    If fEmptyStr(edtDesconto.Text) Then
    Begin
      edtDesconto.Text := '0,00';
    End
    Else If (fStrToFloat(edtDesconto.Text) < 0) Then
    Begin
      pMensagemOk('O valor do desconto não pode ser negativo!');
      Result := False;
    End;
  End

  Else If (Sender = cbTabPreco) Then
  Begin
    If cbTabPreco.Enabled Then
    Begin
      If fEmptyStr(cbTabPreco.Text) Then
      Begin
        pMensagemOk('Escolha uma Tabela de Preços!');
        Result := False;
      End
      Else If Pos(cbTabPreco.Text, '1234567') <= 0 Then
      Begin
        pMensagemOk('Tabela de Preços incorreta!');
        Result := False;
      End
      Else If Not fSistemaUsaEssaTabelaPreco(cbTabPreco.Text) Then
      Begin
        pMensagemOk('Sistema não está configurado para utilizar a tabela de preço: '+ cbTabPreco.Text +'. Verifique a configuração "CFG_TABPRC - '+ fRetNomCfg('TABPRC') +'"');
        Result := False;
      End;
    End;
  End

  Else If (Sender = cbTabPrecoProm) Then
  Begin
    If cbTabPrecoProm.Enabled Then
    Begin
      If fEmptyStr(cbTabPrecoProm.Text) Then
      Begin
        pMensagemOk('Escolha uma Tabela de Preços!');
        Result := False;
      End
      Else If Pos(cbTabPrecoProm.Text, '1234567') <= 0 Then
      Begin
        pMensagemOk('Tabela de Preços incorreta!');
        Result := False;
      End
      Else If Not fSistemaUsaEssaTabelaPreco(cbTabPrecoProm.Text) Then
      Begin
        pMensagemOk('Sistema não está configurado para utilizar a tabela de preço: '+ cbTabPrecoProm.Text +'. Verifique a configuração "CFG_TABPRC - '+ fRetNomCfg('TABPRC') +'"');
        Result := False;
      End;
    End;
  End

  Else If (Sender = mskDtaSemVendaIni) Then
  Begin
     If (Not(fEmptyStr(fTiraCaracEspeciais(mskDtaSemVendaIni.Text)))) And
        (Not fValidaDataStr(mskDtaSemVendaIni.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Data Inválida!', ['&OK']);
      Result := False;
    End

    Else If ((StrToDateDef(mskDtaSemVendaIni.Text, 0)) > (StrToDateDef(mskDtaSemVendaFin.Text, 0))) And
             (StrToDateDef(mskDtaSemVendaFin.Text, 0) <> 0) Then
    Begin
      pMensagemOk('A data final do período sem venda não pode ser menor que a data inicial!');
      Result := False;
    End;
  End

  Else If (Sender = mskDtaSemVendaFin) Then
  Begin

    If (Not(fEmptyStr(fTiraCaracEspeciais(mskDtaSemVendaFin.Text)))) And
       (Not fValidaDataStr(mskDtaSemVendaFin.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Data Inválida!', ['&OK']);
      Result := False;
    End

    Else If ((StrToDateDef(mskDtaSemVendaIni.Text, 0)) > (StrToDateDef(mskDtaSemVendaFin.Text, 0))) And
             (StrToDateDef(mskDtaSemVendaFin.Text, 0) <> 0) Then
    Begin
      pMensagemOk('A data final do período sem venda não pode ser menor que a data inicial!');
      Result := False;
    End;
  End

  Else If (Sender = edtNroDiasSemVenda) Then
  Begin
    If (Not fEmptyStr(edtNroDiasSemVenda.Text)) And
       (StrToIntDef(edtNroDiasSemVenda.Text, 0) <= 0) And
       (StrToDateDef(mskDtaSemVendaIni.Text, 0) = 0) Then
    Begin
      pMensagemOk('Número de dias precisa ser maior de zero.');
      Result := False;
    End
    Else
    If StrToIntDef(edtNroDiasSemVenda.Text, 0) > 999 Then
    Begin
      pMensagemOk('Número de dias precisa ser menor de 999.');
      Result := False;
    End;
  End

  Else If (Sender = edtCodEmpPrm) Then
  Begin
    pDesmarcaLista(edtCodEmpPrm, arrCodEmpPrm);
    If (Not fEmptyStr(edtCodEmpPrm.Text)) Then
    Begin
      If fEmptyStr(strEmpConsVendFatur) Then
        strEmpConsVendFatur := fRetEmpConsVendFatur(strLoginUsuarioLogado);

      If (Pos(edtCodEmpPrm.Text, strEmpConsVendFatur) <= 0) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
        Exit;
      End;

      If (StrToIntDef(edtNroDiasSemVenda.Text, 0)  <= 0) And
         ((StrToDateDef(mskDtaSemVendaIni.Text, 0) <= 0) And
          (StrToDateDef(mskDtaSemVendaFin.Text, 0) <= 0)) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Informe um "período sem vendas" ou "quantidade de dias sem venda" para prosseguir!', ['&O k']);
        Exit;
      End
    End;
  End

  Else If (Sender = mskDataVigencia) Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(mskDataVigencia.Text)) Then
    Begin
      mskDataVigencia.Text := DateToStr(VS_Date);
      strDtaVigAnt := mskDataVigencia.Text;
    End
    Else Begin
      If (StrToDateDef(mskDataVigencia.Text, 0) < VS_Date) Then
      Begin
        pMensagemOk('A data de vigência da promoção não pode ser menor que a data atual!');
        Result := False;
      End
      Else If (strDtaVigAnt <> mskDataVigencia.Text)Then
      Begin
        Result := fVerificaPodeAlterarVigencia;
        If Not Result Then
        Begin
          mskDataVigencia.Text := strDtaVigAnt;
        End;
      End;
      strDtaVigAnt := mskDataVigencia.Text;
    End;
  End

  Else If (Sender = cbTabPrecoProm) Then
  Begin
    If cbTabPrecoProm.Enabled Then
    Begin
      If fEmptyStr(cbTabPrecoProm.Text) Then
      Begin
        pMensagemOk('Escolha uma Tabela de Preços!');
        Result := False;
      End
      Else If Pos(cbTabPrecoProm.Text, '1234567') <= 0 Then
      Begin
        pMensagemOk('Tabela de Preços incorreta!');
        Result := False;
      End
      Else If Not fSistemaUsaEssaTabelaPreco(cbTabPrecoProm.Text) Then
      Begin
        pMensagemOk('Sistema não está configurado para utilizar a tabela de preço: '+ cbTabPrecoProm.Text +'. Verifique a configuração "CFG_TABPRC - '+ fRetNomCfg('TABPRC') +'"');
        Result := False;
      End;
    End;
  End

  Else If (Sender = mskDataVigencia) Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(mskDataVigencia.Text)) Then
    Begin
      mskDataVigencia.Text := DateToStr(VS_Date);
      strDtaVigAnt := mskDataVigencia.Text;
    End
    Else Begin
      If (StrToDateDef(mskDataVigencia.Text, 0) < VS_Date) Then
      Begin
        pMensagemOk('A data de vigência da promoção não pode ser menor que a data atual!');
        Result := False;
      End
      Else If (strDtaVigAnt <> mskDataVigencia.Text)Then
      Begin
        Result := fVerificaPodeAlterarVigencia;
        If Not Result Then
        Begin
          mskDataVigencia.Text := strDtaVigAnt;
        End;
      End;
      strDtaVigAnt := mskDataVigencia.Text;
    End;
  End;


  If Not (Result) Then
    pSetFocus(Sender);
end;

function TframeFiltrosCatPromocao.fVerificaPodeAlterarVigencia: Boolean;
var
  objLiberacao : TLiberacao;
begin
  objLiberacao := TLiberacao.Create;
  Try
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Permissão para alterar o campo "Data vigência" na geração de Catálogo de Promoções.');
    objLiberacao.objMsgLibera.pAddTexto('');
    objLiberacao.objMsgLibera.pAddTexto('Data alterada para: ' + mskDataVigencia.Text);
    objLiberacao.objMsgLibera.pAddTexto('Cliente: ' + strCodCli + ' - ' + fRetNomCliente(strCodCli));

    objLiberacao.strDirAce := 'CRMPDT';
    objLiberacao.strMsgSen := 'Permissão para alterar o campo "Data vigência" na geração de Catálogo de Promoções.';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;
  Finally
    FreeAndNil(objLiberacao);
  end;
end;

procedure TframeFiltrosCatPromocao.mskLinGruPrmExit(Sender: TObject);
begin
  pEdtCodSelectExit(mskLinGruPrm, edtDesGruPrm, arrLinGruPrm, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6);
end;

procedure TframeFiltrosCatPromocao.mskLinGruPrmKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqGrupo(FParentForm, mskLinGruPrm, edtDesGruPrm, nil, Key, arrLinGruPrm, False) Then
  Begin
    If fValidaCampos(mskLinGruPrm, True) Then
      SelectNext(FParentForm.ActiveControl, True, True);
  End;
end;

procedure TframeFiltrosCatPromocao.pCarregaTabPreco;
var
  intCont: Integer;
begin
  cbTabPreco.Items.Clear;

  For intCont := 1 To Length(VS_strTabPrc) Do
  Begin
    If VS_strTabPrc[intCont] = 'S' Then
      cbTabPreco.Items.Add(IntToStr(intCont));
  End;
end;

procedure TframeFiltrosCatPromocao.pCarregaTabPrecoProm;
Var
  intCont: Integer;
begin
  cbTabPrecoProm.Items.Clear;

  For intCont := 1 To Length(VS_strTabPrc) Do
  Begin
    If VS_strTabPrc[intCont] = 'S' Then
      cbTabPrecoProm.Items.Add(IntToStr(intCont));
  End;
End;

procedure TframeFiltrosCatPromocao.pHabilitarDesabilitar(
  const blnHabilitar: Boolean);
var
  intCnt: Integer;
begin
  For intCnt := 0 To grpProdutos.ControlCount-1 Do
  Begin
    grpProdutos.Controls[intCnt].Enabled := blnHabilitar;
  End;

  For intCnt := 0 To grpPromocao.ControlCount-1 Do
  Begin
    grpPromocao.Controls[intCnt].Enabled := blnHabilitar;
  End;
end;

procedure TframeFiltrosCatPromocao.pInicializaFiltros;
begin
  If Not fVerificaAcessoSistema('CRMPTB') Then
  Begin
    pSetSpinTabelaSistemaVA(False);
    cbTabPreco.Enabled := False;
  End
  Else
    pSetSpinTabelaSistemaVA(True);

  If Not fVerificaAcessoSistema('CRMPDC') Then
  Begin
    edtDesconto.Enabled := False;
    pSetSpinDescontoSistemaVA(False);
    If Not(VS_strTRADES = '2') Then
    Begin
      edtDesconto.Visible := False;
      lblDesCon.Visible := False;
    End;
  End
  Else
    pSetSpinDescontoSistemaVA(True);

  If Not blnFiltrosProm Then
  Begin
    pnlFiltrosPromocao.Visible := False;
  End;

  strDtaVigAnt := '';
  strEmpConsVendFatur := fRetEmpConsVendFatur(strLoginUsuarioLogado);

  pCarregaTabPreco;
  pCarregaTabPrecoProm;
  pLimparFiltros;
end;

procedure TframeFiltrosCatPromocao.pLimparFiltros;
begin
  edtCodItePrm.Clear;
  edtDesItePrm.Clear;
  mskLinGruPrm.Clear;
  edtDesGruPrm.Clear;
  edtCodMarPrm.Clear;
  edtDesMarPrm.Clear;
  edtCodDepPrm.Clear;
  edtDesDepPrm.Clear;
  edtDescri.Clear;
  edtCodForPrm.Clear;
  edtNomForPrm.Clear;

  cmbComSaldo.ItemIndex := 2;
  edtDesconto.Text := '0,00';

  pSugereTabPrecoDefault;
  chkPrecoImposto.Checked := False;

  edtCodEmpPrm.Clear;
  edtDesEmpPrm.Clear;

  edtCodPro.Clear;
  edtDesPro.Clear;

  chkSomenteEmPromocao.Checked := IIF(Not blnFiltrosProm, False, True);

  mskDataVigencia.Text := DateToStr(VS_Date);
  strDtaVigAnt := mskDataVigencia.Text;

  pSugereTabPrecoPromoDefault;

end;

procedure TframeFiltrosCatPromocao.pSetParamObjCatProm(objProm: TCatalogoPromocao);
begin
  If Not Assigned(objProm) Then
    Exit;

  FobjCatProm := objProm;

  FobjCatProm.pLimpar;
  Try
    FobjCatProm.strNomDirArq := ExtractFilePath(Application.ExeName);
    {Filtros Produto}
    FobjCatProm.blnUsaTabPreco := cbTabPreco.Enabled;
    FobjCatProm.strTabPreco := cbTabPreco.Text;
    FobjCatProm.blnUsaTabPrecoProm := False;
    FobjCatProm.strTabPrecoProm := '1';
    FobjCatProm.blnFiltraDadosUltVnd := fFiltraDadosUltVnd;
    FobjCatProm.blnFiltraDadosUltVndEmp := fFiltraDadosUltVndEmp;
    FobjCatProm.intNroDiasSemVenda := StrToIntDef(edtNroDiasSemVenda.Text,0);
    FobjCatProm.dtaSemVendaFin := StrToDateTimeDef(mskDtaSemVendaFin.Text, 0);
    FobjCatProm.dtaSemVendaIni := StrToDateTimeDef(mskDtaSemVendaIni.Text, 0);
    FobjCatProm.blnSomenteEmPromocao := False;
    FobjCatProm.strCodIte := edtCodItePrm.Text;
    FobjCatProm.arrProduto:= arrCodItePrm;
    FobjCatProm.strLinGru := mskLinGruPrm.Text;
    FobjCatProm.arrGrupo  := arrLinGruPrm;
    FobjCatProm.strCodMar := edtCodMarPrm.Text;
    FobjCatProm.arrMarca  := arrCodMarPrm;
    FobjCatProm.strCodDep := edtCodDepPrm.Text;
    FobjCatProm.arrDepartamento := arrCodDepPrm;
    FobjCatProm.strCodFor := edtCodForPrm.Text;
    FobjCatProm.arrFornec := arrCodForPrm;
    FobjCatProm.strEmpVnd := edtCodEmpPrm.Text;
    FobjCatProm.arrEmpVnd := arrCodEmpPrm;
    FobjCatProm.intIndexTipSaldo := cmbComSaldo.ItemIndex;
    FobjCatProm.strDescri := edtDescri.Text;
    FobjCatProm.fltValorDesc := fStrToFloat(edtDesconto.Text);
    FobjCatProm.blnPrecoImposto := chkPrecoImposto.Checked;
    {Filtros Promoção}
    FobjCatProm.dtaVigencia := strToDateDef(mskDataVigencia.Text, VS_Date);
    FobjCatProm.strCndPag := strCndPag;
    FobjCatProm.blnUsaTabPrecoProm := cbTabPrecoProm.Enabled;
    FobjCatProm.strTabPrecoProm := cbTabPrecoProm.Text;
    FobjCatProm.blnSomenteEmPromocao := (chkSomenteEmPromocao.Checked);
    FobjCatProm.arrPromocao := arrPromocao;
    FobjCatProm.strCodPromocao := edtCodPro.Text;

    FobjCatProm.blnCatalogoComPreco := chkCatalogoComPreco.Checked;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfraFiltrosCatPromocao.pSetParamObjCatProm]');
    End;
  End;
end;

procedure TframeFiltrosCatPromocao.pSetSpinDescontoSistemaVA(
  const blnLiberado: Boolean);
begin
  If blnLiberado Then
  Begin
    shpLiberadoDesconto.Brush.Color := clGreen;
  End
  Else
  Begin
    shpLiberadoDesconto.Brush.Color := clRed;
  End;
end;

procedure TframeFiltrosCatPromocao.pSetSpinTabelaSistemaVA(
  const blnLiberado: Boolean);
begin
  If blnLiberado Then
  Begin
    shpLiberadoTabSProm.Brush.Color := clGreen;
    shpLiberadoTabCProm.Brush.Color := clGreen;
  End
  Else
  Begin
    shpLiberadoTabSProm.Brush.Color := clRed;
    shpLiberadoTabCProm.Brush.Color := clRed;
  End;
end;

procedure TframeFiltrosCatPromocao.pSugereTabPrecoDefault;
  Var
    strTabSuj: String;
begin
  If fCfgSis('TBPSUG', varString) = '0' Then
  Begin
    strTabSuj := fRetTabPrecoCliente(strCodCli);

    If fEmptyStr(strTabSuj) Then
      strTabSuj := fCfgSis('TBPRPD');

    cbTabPreco.Text := strTabSuj
  End
  Else
  Begin
    cbTabPreco.Text := fCfgSis('TBPSUG', varString);
  End;
end;

procedure TframeFiltrosCatPromocao.pSugereTabPrecoPromoDefault;
var
  strTabSuj: String;
begin
  If fCfgSis('TBPSUG', varString) = '0' Then
  Begin
    strTabSuj := fRetTabPrecoCliente(strCodCli);

    If fEmptyStr(strTabSuj) Then
      strTabSuj := fCfgSis('TBPRPD');

    cbTabPrecoProm.Text := strTabSuj
  End
  Else
  Begin
    cbTabPrecoProm.Text := fCfgSis('TBPSUG', varString);
  End;
end;

function TframeFiltrosCatPromocao.fVerificaCampos: Boolean;
begin
  Result := fVerificaSubObjeto(Self);
end;

function TframeFiltrosCatPromocao.fVerificaSubObjeto(objObjeto: TWinControl): Boolean;
  Var
    intContador: Integer;
Begin
  Result := True;

  For intContador := 0 To objObjeto.ComponentCount -1 Do
  Begin
    //Condição para evitar erro quando a função fVerificaCampos é chamada em algum form
    //e na função fValidaCampos deste form tem a destruição de um componente de tela.
    If intContador = objObjeto.ComponentCount Then
      Break;

    {**********************************}
    {* SE O COMPONETE FOR UM PANEL,   *}
    {* UM SCROLLBOX OU TABSHEET       *}
    {*******************************AF*}

    If (objObjeto.Components[intContador] Is TPanel) Or
       (objObjeto.Components[intContador] Is TScrollBox) Or
       (objObjeto.Components[intContador] Is TGroupBox) Or
       (objObjeto.Components[intContador] Is TFrame) Or
       (objObjeto.Components[intContador] Is TTabSheet) Then
    Begin
      If (objObjeto.Components[intContador] Is TPanel)     Or
         (objObjeto.Components[intContador] Is TTabSheet) Then
      Begin
        {*******************************************}
        {* CASO NÃO QUERIA VALIDA UM TABSHEET, USE *}
        {* O VALOR -1 EM SEU TAG                   *}
        {****************************************MV*}
        If (objObjeto.Components[intContador].Tag = -1) Then
        Begin
          Exit;
        End;
      End;

      Result := fVerificaSubObjeto((objObjeto.Components[intContador] As TWinControl));

      If Not Result Then
        Exit;
    End

    Else
    Begin
      {**************************************}
      {* SE A TAG DO COMPONENTES = 99 ENTÃO *}
      {***********************************AF*}
      If (objObjeto.Components[intcontador].Tag = 99) And (objObjeto.Components[intContador] Is TWinControl) Then
      Begin
        Try
          Result := fValidaCampos((objObjeto.Components[intContador] As TWinControl), False);
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message,'[TfraFiltrosCatPromocao.fVerificaSubObjeto]');
            pGravarErro(True, E.Message + ' - ' + Self.Name + '.' + (objObjeto.Components[intContador] As TWinControl).Name);
            Result := False;
          End;
        End;
      End;

      If Not Result Then
        Exit;
    End;
  End;

end;

end.
