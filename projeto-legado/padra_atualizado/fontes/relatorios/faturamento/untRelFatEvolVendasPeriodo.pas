unit untRelFatEvolVendasPeriodo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, RLFilters, RLDraftFilter, Menus, StdCtrls,
  EditFocus, QColorLabel, Buttons, ExtCtrls, Mask, MaskEditFocus, DateUtils,
  StrUtils, RLReport, RLTypes, ComObj, untTypesSistema, frxDesgn, frxClass,
  frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  Uni, AppEvnts, UniDataSetProvider, DB, UniClientDataSet, MaskUtils,
  BitBtnLockedIncrem, ComboBoxFocus, Datasnap.Provider, frxExportCSVTestabilidade,
  Datasnap.DBClient;

type
  TfrmRelFatEvolVendasPeriodo = class(TfrmPaiRelatorio)
    Label1: TLabel;
    Label2: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    Label12: TLabel;
    edtCodVendedor: TEditFocus;
    edtDesVendedor: TEditFocus;
    Label3: TLabel;
    edtCodRepresentante: TEditFocus;
    edtDesRepresentante: TEditFocus;
    Label10: TLabel;
    edtFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    Label4: TLabel;
    edtCodCidade: TEditFocus;
    edtDesCidade: TEditFocus;
    Label9: TLabel;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    Label5: TLabel;
    gpbOpcao2: TGroupBox;
    lblOpcao2: TColorLabel;
    edtOpcao2: TEditFocus;
    edtEstado: TEditFocus;
    Label7: TLabel;
    Label8: TLabel;
    edtCodProduto: TEditFocus;
    edtDesProduto: TEditFocus;
    edtDesUnidade: TEditFocus;
    edtCodUnidade: TEditFocus;
    Label11: TLabel;
    svdExcel: TSaveDialog;
    gpbFiltro: TGroupBox;
    edtNumCli: TEditFocus;
    chkCurva: TCheckBox;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    gpbOpcao: TGroupBox;
    ColorLabel3: TColorLabel;
    ColorLabel2: TColorLabel;
    ColorLabel4: TColorLabel;
    ColorLabel5: TColorLabel;
    ColorLabel6: TColorLabel;
    ColorLabel7: TColorLabel;
    Label13: TLabel;
    edtOpcao: TEditFocus;
    gpbVendedor: TGroupBox;
    lblVendedor: TColorLabel;
    edtVendedor: TEditFocus;
    lstClaFis: TMemo;
    Label14: TLabel;
    edtCodMarca: TEditFocus;
    edtNomMarca: TEditFocus;
    ColorLabel9: TColorLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label15: TLabel;
    cdsRelatorio: TUniClientDataSet;
    cpvRelatorio: TUniDataSetProvider;
    gpbEmpresa: TGroupBox;
    ColorLabel10: TColorLabel;
    edtEmpFat: TEditFocus;
    ColorLabel11: TColorLabel;
    ColorLabel12: TColorLabel;
    ColorLabel13: TColorLabel;
    lbl1: TColorLabel;
    lbl2: TColorLabel;
    Label6: TLabel;
    edtCodAti: TEditFocus;
    edtDesAti: TEditFocus;
    ColorLabel8: TColorLabel;
    Label16: TLabel;
    edtCodRede: TEditFocus;
    edtDesRede: TEditFocus;
    ColorLabel14: TColorLabel;
    shpVen: TShape;
    shpRep: TShape;
    ColorLabel15: TColorLabel;
    lbl3: TLabel;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    gpbComCus: TGroupBox;
    cbbComCus: TComboBoxFocus;
    edtDepProd: TEditFocus;
    edtDepProdDes: TEditFocus;
    Label18: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRepresentanteExit(Sender: TObject);
    procedure edtCodRepresentanteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVendedorExit(Sender: TObject);
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCidadeExit(Sender: TObject);
    procedure edtCodCidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure edtCodUnidadeExit(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtCodProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtDestinoExit(Sender: TObject);
    procedure edtOpcaoChange(Sender: TObject);
    procedure chkCurvaClick(Sender: TObject);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarcaExit(Sender: TObject);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRedeExit(Sender: TObject);
    procedure edtCodRedeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiExit(Sender: TObject);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtDepProdExit(Sender: TObject);
    procedure edtDepProdKeyPress(Sender: TObject; var Key: Char);
  private
    blnLiberado: Boolean;
    strCodVen    : String;
    strCodRep: String;
    
    procedure pAtualizaClaFis;
    procedure pGeraExcelEvoVendas(intOpcao: Integer);
    procedure pVerdeVermelho(edtCodigo: TEditFocus; Shape: TShape);
    { Private declarations }
  public
    { Public declarations }

    arrLinhaGrupo: TConsultasArray;
    arrLinhaRepre: TConsultasArray;
    arrLinhaClien: TConsultasArray;
    arrLinhaVende: TConsultasArray;
    arrLinhaForne: TConsultasArray;
    arrLinhaMarca: TConsultasArray;
    arrLinhaCidad: TConsultasArray;
    arrProduto   : TConsultasArray;
    arrUnidade   : TConsultasArray;
    arrLinAti    : TConsultasArray;
    arrRede      : TConsultasArray;
    arrEmpresa   : TConsultasArray;
    arrDepart    : TConsultasArray;
    arrDepProd   : TConsultasArray;
    intLimCol    : Integer;

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
    
  end;

var
  frmRelFatEvolVendasPeriodo: TfrmRelFatEvolVendasPeriodo;

implementation

uses untQckFatEvolVendasPeriodo, untFuncoesFactory, untIFuncoes,
  untConstantes, untExcel, untClassPanelCx;


{$R *.dfm}

procedure TfrmRelFatEvolVendasPeriodo.FormShow(Sender: TObject);
begin
  blnLiberado := fVerificaAcessoSistema('REVOVE');

  strCodRep := '';
  strCodVen := '';

  pVerdeVermelho(edtCodVendedor, shpVen);
  pVerdeVermelho(edtCodRepresentante, shpRep);

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy', VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy', VS_Date);

  If Not fCfgSis('USATMQ', varBoolean) Then
  Begin
    lblOpcao2.Caption := '(Q)uantidade (V)alor';
  End;

  edtOpcaoChange(Sender);

  {***********************************}
  {* EXIBE O SHAPE Q IDENTIFICA SE O *}
  {* RELATÓRIO POSSUI CONSULTAS COM  *}
  {* MULTISELEÇÃO                    *}
  {***08/02/2008*******************ER*}
  shpMultSel.Visible := True;

  If Not fCfgSis('REPVEN', varBoolean) Then
  Begin
    edtVendedor.Text := '1';
    edtVendedor.Enabled := False;
  End;

  inherited;
end;

{**************************************}
{* ATUALIZA LIST DE CLASSIFICAÇÕES    *}
{***********************************AF*}
procedure TfrmRelFatEvolVendasPeriodo.pAtualizaClaFis;
  Var
    strClaFis: String;
Begin

  strClaFis := VS_strClaVen + VS_strClaDev;

  While Not fEmptyStr(strClaFis) Do
  Begin
    Application.ProcessMessages;

    lstClaFis.Lines.Add(LeftStr(strClaFis,4));

    strClaFis := RightStr(strClaFis, Length(strClaFis)-5 );
  End;

End;

procedure TfrmRelFatEvolVendasPeriodo.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtCodProduto);
  pAtualizaClaFis;

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  pCarregaComposicaoCusto(cbbComCus);
end;

procedure TfrmRelFatEvolVendasPeriodo.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinhaGrupo,edtDesGrupo,arrLinhaGrupo,fRetNomeLinhaGrupo,Nil,'da linha/grupo',6);
end;

procedure TfrmRelFatEvolVendasPeriodo.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrLinhaGrupo, False) Then
  Begin
    fvalidaCampos(mskLinhaGrupo,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatEvolVendasPeriodo.edtFornecedorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtFornecedor,edtDesFornecedor,
                    arrLinhaForne,fRetNomFornecedor,nil,'do Fornecedor');

end;

procedure TfrmRelFatEvolVendasPeriodo.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrLinhaForne, False) Then
  Begin
    fValidaCampos(edtFornecedor, False);
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatEvolVendasPeriodo.edtCodRedeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRede,edtDesRede,arrRede,nil,fRetNomeRedeLoja,'da rede');
end;

procedure TfrmRelFatEvolVendasPeriodo.edtCodRedeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {**********************************}
  {* NOVA CONSULTA DE REDE DE LOJAS *}
  {*******************************RV*}
  If fPesqRedeLojas(Self, edtCodRede, edtDesRede, Nil, Key, arrRede, False) Then
  Begin
    If fValidaCampos(edtCodRede, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatEvolVendasPeriodo.edtCodRepresentanteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRepresentante,edtDesRepresentante,arrLinhaRepre,fRetNomVendRep,nil,'do Representante');
end;

procedure TfrmRelFatEvolVendasPeriodo.edtCodRepresentanteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqOperador(Self, edtCodRepresentante, edtDesRepresentante, nil, Key, arrLinhaRepre, False) Then
  Begin
    If fValidaCampos(edtCodRepresentante, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatEvolVendasPeriodo.edtCodVendedorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodVendedor,edtDesVendedor,arrLinhaVende,fRetNomVendRep,nil,'do Vendedor');
end;

procedure TfrmRelFatEvolVendasPeriodo.edtCodVendedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqOperador(Self, edtCodVendedor, edtDesVendedor, nil, Key, arrLinhaVende, False) Then
  Begin
    If fValidaCampos(edtCodVendedor, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmRelFatEvolVendasPeriodo.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
  Var
    intIndex : Integer;
begin

  Result := True;

  If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
  Begin

    If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
      Result := False;

      If (Sender = mskDtaFin) Then
          Sender := mskDtaIni;
    End
    Else If (Sender = mskDtaFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
        Begin
          fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
          Result := False;
        End;
      End;

      If MonthsBetween(StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text)) > 12 Then
      Begin
        fMensagem('ATENÇÃO!','O período para consulta, não pode ser maior que 1 ano!',['&O K']);
        Result := False;
      End;

    End;

  End

  Else If (Sender = edtVendedor) Then
  Begin

    if fCfgSis('REPVEN', varBoolean) Then
    Begin
      If Pos(edtVendedor.Text,'12') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo opção de vendedor deve ser 1 ou 2!',['&O K']);
        Result := False;
      End;
    End;

  End

  {******************************}
  {* VALIDA VENDEDOR            *}
  {***************************LA*}
  Else If (Sender = edtCodVendedor) Then
  Begin
    If blnLiberado Then
    Begin
      strCodVen := edtCodVendedor.Text;
    End

    Else If Not fEmptyStr(edtCodVendedor.Text) Then
    Begin
      strCodVen := fRetCodVendedor(edtCodVendedor.Text);

      If Not fEmptyStr(strCodVen) Then
        edtDesVendedor.Text := fRetNomVendRep(strCodVen)
      Else
      Begin
        Result := False;
        fMensagem('','Vendedor não encontrado.', ['&O K']);
      End;

    End Else
    Begin
      edtDesVendedor.Text := 'TODOS';
      strCodVen := '';
    End;
  End
  {******************************}
  {* VALIDA REPRESENTANTE       *}
  {***************************LA*}
  Else If (Sender = edtCodRepresentante) Then
  Begin
    If blnLiberado Then
    Begin
      strCodRep := edtCodRepresentante.Text;
    End

    Else If Not fEmptyStr(edtCodRepresentante.Text) Then
    Begin
      strCodRep := fRetCodVendedor(edtCodRepresentante.Text);

      If Not fEmptyStr(strCodRep) Then
        edtDesRepresentante.Text := fRetNomVendRep(strCodRep)
      Else
      Begin
        Result := False;
        fMensagem('','Representante não encontrado.', ['&O K']);
      End;

    End Else
    Begin
      edtDesRepresentante.Text := 'TODOS';
      strCodRep := '';
    End;
  End
  {******************************}
  {* VALIDA FORNECEDOR          *}
  {***************************LA*}
  Else If (Sender = edtFornecedor) Then
  Begin
    pDesmarcaLista(edtFornecedor,arrLinhaForne);
  End
  {******************************}
  {* VALIDA MARCA               *}
  {***************************LA*}
  Else If (Sender = edtCodMarca) Then
  Begin
    pDesmarcaLista(edtCodMarca,arrLinhaMarca);
  End

  {******************************}
  {* VALIDA DEPARTAMENTO        *}
  {***************************MM*}
  Else If (Sender = edtCodDep) Then
  Begin
    pDesmarcaLista(edtCodDep, arrDepart);
  End

  {******************************}
  {* VALIDA DEPTO. PRODUTO      *}
  {***************************MM*}
  Else If (Sender = edtDepProd) Then
  Begin
    pDesmarcaLista(edtDepProd, arrDepProd);
  End

  {**********************}
  {* VALIDA LINHA GRUPO *}
  {*******************LA*}
  Else  If (Sender = mskLinhaGrupo) Then
  Begin
    pDesmarcaLista(mskLinhaGrupo,arrLinhaGrupo,'',6);
  End
  {******************************}
  {* VALIDA PRODUTO              *}
  {***************************LA*}
  Else If (Sender = edtCodProduto) Then
  Begin
    pDesmarcaLista(edtCodProduto,arrProduto);
  End
  {******************************}
  {* VALIDA UNIDADE             *}
  {***************************LA*}
  Else If (Sender = edtCodUnidade) Then
  Begin
    pDesmarcaLista(edtCodUnidade,arrUnidade,'',edtCodUnidade.MaxLength);
  End

  {****************}
  {* VALIDA OPÇÃO *}
  {*************AF*}
  Else If (Sender = edtOpcao) Then
  Begin

    If fEmptyStr(edtOpcao.Text) Then
    Begin
      fMensagem('','A Opção de quebra deve ser preenchido!',['&OK']);
      Result := False;
    End
    Else
    Begin

      If (StrToInt(edtOpcao.Text) > 15) Or
         (StrToInt(edtOpcao.Text) <= 0) Then
      Begin
        fMensagem('','A Opção de quebra deve ser um número entre 1 e 15!',['&OK']);
        Result := False;
      End;

    End;

  End

  {*****************}
  {* VALIDA OPÇÃO2 *}
  {**************AF*}
  Else If (Sender = edtOpcao2) Then
  Begin

    If fEmptyStr(edtOpcao2.Text) Then
    Begin
      fMensagem('','A Opção deve ser preenchido!',['&OK']);
      Result := False;
    End
    Else
    Begin

      If fCfgSis('USATMQ', varBoolean) Then
      Begin

        If Pos(edtOpcao2.Text,'L_Q_V_') <= 0 Then
        Begin
          fMensagem('','A Opção deve ser L, Q ou V!',['&OK']);
          Result := False;
        End;

      End
      Else
      Begin

        If Pos(edtOpcao2.Text,'Q_V_') <= 0 Then
        Begin
          fMensagem('','A Opção deve ser Q ou V!',['&OK']);
          Result := False;
        End;

      End;

    End;

  End
  Else If (Sender = edtDestino) Then
  Begin

    If fEmptyStr(edtDestino.Text) Then
    Begin
      fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (edtDestino.Text <> 'V') And
            (edtDestino.Text <> 'I') And
            (edtDestino.Text <> 'E') Then
    Begin
      Result := False;
    End;

  End

  Else If (Sender = edtEmpFat) Then
  Begin

    If Pos(edtEmpFat.Text,'FP') <= 0 Then
    Begin
      fMensagem('ATENÇÃO!','O campo (empresa do...) deve ser F ou P!',['&O K']);
      Result := False;
    End;

  End

  Else If (Sender = edtCodEmpresa) Then
  Begin
  
    If Not fEmptyStr(edtCodEmpresa.Text) Then
    Begin
      pDesmarcaLista(edtCodEmpresa, arrEmpresa, 'TMP_EMPRESA');
      If Length(arrEmpresa) > 0 Then
      Begin
        For intIndex := Low(arrEmpresa) To High(arrEmpresa) Do
        Begin
          If Pos(arrEmpresa[intIndex].strCodigo, strEmpAcessoUsuarioLogado) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a Empresa ' + arrEmpresa[intIndex].strCodigo + '!', ['&O k']);
            Result := False;
            Break;
          End;
        End;
      End
      Else If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
        Result := False;
      End;
    End
    Else
    Begin
      fMensagem('','O código da Empresa deve ser informado!',['&OK']);
      Result := False;
    End;

  End;  

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelFatEvolVendasPeriodo.edtCodAtiExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAti, edtDesAti, arrLinAti, Nil, fRetNomAtividade,'da atividade');
end;

procedure TfrmRelFatEvolVendasPeriodo.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE ATIVIDADES *}
  {****************************RV*}
  If fPesqAtividade(Self, edtCodAti, edtDesAti, Nil, Key, arrLinAti, False) Then
  Begin
    fValidaCampos(edtCodAti, False);
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatEvolVendasPeriodo.edtCodCidadeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCidade,edtDesCidade,arrLinhaCidad,fRetNomCidadeSemOpc,nil,'da Cidade');
end;

procedure TfrmRelFatEvolVendasPeriodo.edtCodProdutoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodProduto,edtDesProduto,arrProduto,nil,fRetNomProduto,'do Produto');
end;

procedure TfrmRelFatEvolVendasPeriodo.edtCodUnidadeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodUnidade,edtDesUnidade,arrUnidade,fRetNomUnidade,nil,'da Unidade',edtCodUnidade.MaxLength);
end;

procedure TfrmRelFatEvolVendasPeriodo.edtCodCidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, edtCodCidade, edtDesCidade, edtEstado, Nil, Key, arrLinhaCidad, False) Then
  Begin
    fValidaCampos(edtCodCidade, False);
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatEvolVendasPeriodo.edtCodClienteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCliente,edtDesCliente,arrLinhaClien,nil,fRetNomCliente,'do cliente');
  If Not fEmptyStr(edtCodCliente.Text) Then
  Begin
    edtCodRede.Enabled := False;
    edtCodRede.Clear;
    pEdtCodSelectExit(edtCodRede,edtDesRede,arrRede,nil,fRetNomeRedeLoja,'da rede');
    pSetFocus(edtCodVendedor);
  End Else
  Begin
    edtCodRede.Enabled := True;
    pSetFocus(edtCodRede);
  End;
end;

procedure TfrmRelFatEvolVendasPeriodo.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrLinhaClien, False) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatEvolVendasPeriodo.edtCodDepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDep,edtDesDep,arrDepart,fRetDescDepartamento,nil,'do Departamento');
end;

procedure TfrmRelFatEvolVendasPeriodo.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE DEPARTAMENTO *}
  {******************************MM*}
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrDepart, False) Then
  Begin
    fValidaCampos(edtCodDep, False);
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatEvolVendasPeriodo.btnImprimirClick(Sender: TObject);
  Var
    strSQL     : String;
    strGroupBy : String;
    strLinGru  : String;
    strLinRep  : String;
    strLinCli  : String;
    strLinVen  : String;
    strLinFor  : String;
    strLinMar  : String;
    strLinCid  : String;
    strLinPro  : String;
    strLinUni  : String;
    strLinAti  : String;
    strRede    : String;
    strEmpresa : String;
    strDepart  : String;
    strDepProd : String;
    strCusTmp  : String;
    strTotCus  : String;
    strSQLLitro: String;
    strSQLQuilo: String;
    intCont    : Integer;
    QryRelatorio : TUniQuery;

begin

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;

  If fEmptyStr(strCodVen) And fEmptyStr(strCodRep) And (Not blnLiberado) Then
  Begin
    blnImprime := False;
    fMensagem('', 'Informe a senha para o Vendedor ou Representante!', ['&Ok']);
  End;

  If blnImprime Then
  Begin

    Case strToIntDef(edtOpcao.Text,0) Of
      1 : If fEmptyStr(edtCodRepresentante.Text) Or (Length(arrLinhaRepre) > 0) Then
            strGroupBy := ' CODREP, CODCLI '
          Else
            strGroupBy := ' CODCLI ';

      2 : If fEmptyStr(edtCodVendedor.Text) Or (Length(arrLinhaVende) > 0) Then
            strGroupBy := ' CODVEN, CODCLI '
          Else
            strGroupBy := ' CODCLI ';

      3 : If fEmptyStr(edtCodCidade.Text) Or (Length(arrLinhaCidad) > 0) Then
            strGroupBy := ' CODCID, CODCLI '
          Else
            strGroupBy := ' CODCLI ';

      4 : strGroupBy := ' CODCLI ';

      5 : strGroupBy := ' CODCLI ';

      6 : If fEmptyStr(edtFornecedor.Text) Or (Length(arrLinhaForne) > 0) Then
           strGroupBy := ' CODFOR, CODITE '
          Else
           strGroupBy := ' CODITE ';

      7 : If fEmptyStr(edtCodVendedor.Text) Or (Length(arrLinhaVende) > 0) Then
            strGroupBy := ' CODVEN, CODCID '
          Else
            strGroupBy := ' CODCID ';

      8 : strGroupBy := ' CODATI ';

      9 : strGroupBy := ' CODREP ';

      10 : strGroupBy := ' CODFOR ';

      11 : strGroupBy := ' CODGRU ';

      12 : strGroupBy := ' CODCID ';

      13 : strGroupBy := ' CODVEN ';

      14 : If fEmptyStr(edtCodVendedor.Text) Or (Length(arrLinhaVende) > 0) Then
             strGroupBy := ' CODVEN, CODITE '
           Else
             strGroupBy := ' CODITE ';

      15 : strGroupBy := ' CODMAR ';
    end;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE            ';
    strSQL := strSQL + '  DET_CODCLI AS CODCLI,        ';
    strSQL := strSQL + '  CLI_NOMCLI AS NOMCLI,        ';
    strSQL := strSQL + '  CLI_C_G_C_ AS C_G_C_,        ';
    strSQL := strSQL + '  CLI_FONE01 AS FONE01,        ';
    strSQL := strSQL + '  CONCAT(CLI_ENDERE,IF(CLI_ENDNUM <>"",CONCAT(", ",CLI_ENDNUM),"")) AS ENDERE, ';
    strSQL := strSQL + '  CLI_CODCID AS CODCID,        ';
    strSQL := strSQL + '  CLI_CODATI AS CODATI,        ';
    strSQL := strSQL + '  DET_CODVEN AS CODVEN,        ';
    strSQL := strSQL + '  DET_CODREP AS CODREP,        ';
    strSQL := strSQL + '  DET_FORITE AS CODFOR,        ';
    strSQL := strSQL + '  DET_CODITE AS CODITE,        ';
    strSQL := strSQL + '  ITE_DESITE AS DESITE,        ';
    strSQL := strSQL + '  ITE_CODGRU AS CODGRU,        ';
    strSQL := strSQL + '  CLI_STATUS AS CLISTA,        ';
    strSQL := strSQL + '  CID_NOMCID AS NOMCID,        ';
    strSQL := strSQL + '  CID_ESTADO AS ESTADO,        ';
    strSQL := strSQL + '  FOR_NOMFOR AS NOMFOR,        ';
    strSQL := strSQL + '  ATI_DESATI AS DESATI,        ';
    strSQL := strSQL + '  V.OPE_NOMOPE AS NOMVEN,      ';
    strSQL := strSQL + '  R.OPE_NOMOPE AS NOMREP,      ';
    strSQL := strSQL + '  0.00       AS MRGATU,        ';
    strSQL := strSQL + '  0.00       AS MRGANT,        ';
    strSQL := strSQL + '  ITE_CODMAR AS CODMAR,        ';
    strSQL := strSQL + '  MAR_DESMAR AS DESMAR,        ';
    strSQL := strSQL + '  SUM( IF(DET_DTAENT BETWEEN :DTAINI AND :DTAFIN, IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - IF(DET_DESESP < 0, -DET_DESESP, DET_DESESP)-DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF)), 0)) AS CMGATU, ';
    strSQL := strSQL + '  SUM( IF(DET_DTAENT BETWEEN :DTAIAN AND :DTAFAN, IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - IF(DET_DESESP < 0, -DET_DESESP, DET_DESESP)-DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF)), 0)) AS CMGANT, ';

    strCusTmp := ' IFNULL(' + fRetornaComposicao(cbbComCus.Items.Strings[cbbComCus.ItemIndex]) + ',0) ';
    strTotCus := ' IF(LEFT(DET_CLAFIS,1) < 5, -'+strCusTmp+ ',' +strCusTmp+')';
    {**************************************}
    {* DEFINE A QUEBRA DO RELATORIO       *}
    {***********************************AF*}
    Case StrToInt(edtOpcao.Text) Of
       1: strSQL := strSQL + ' CONCAT("REPRESENTANTE: ", IFNULL(DET_CODREP,""), "-", IFNULL(R.OPE_NOMOPE,"")) AS QUEBRA, ';
       2,
       7,
      14: strSQL := strSQL + ' CONCAT("VENDEDOR: ", IFNULL(DET_CODVEN,""), "-", IFNULL(V.OPE_NOMOPE,"")) AS QUEBRA, ';
       3: strSQL := strSQL + ' CONCAT("CIDADE: ", IFNULL(CLI_CODCID,""), "-", IFNULL(CID_NOMCID,"")) AS QUEBRA, ';
       4: strSQL := strSQL + ' CLI_NOMCLI AS QUEBRA, ';
       5: strSQL := strSQL + ' CLI_NOMCLI AS QUEBRA, ';
       6: strSQL := strSQL + ' CONCAT("FORNECEDOR: ", IFNULL(DET_FORITE,""), "-", IFNULL(FOR_NOMFOR,"")) AS QUEBRA, ';
       8: strSQL := strSQL + ' ATI_DESATI AS QUEBRA, ';
       9: strSQL := strSQL + ' CONCAT(IFNULL(DET_CODREP,""),"-",IFNULL(R.OPE_NOMOPE,"")) AS QUEBRA, ';
      10: strSQL := strSQL + ' CONCAT(IFNULL(DET_FORITE,""),"-",IFNULL(FOR_NOMFOR,"")) AS QUEBRA, ';
      11: strSQL := strSQL + ' CONCAT(IFNULL(ITE_CODGRU,""),"-",IFNULL(GRU_DESGRU,"")) AS QUEBRA, ';
      12: strSQL := strSQL + ' CONCAT(IFNULL(CLI_CODCID,""),"-",IFNULL(CID_NOMCID,"")) AS QUEBRA, ';
      13: strSQL := strSQL + ' CONCAT(IFNULL(DET_CODVEN,""),"-",IFNULL(V.OPE_NOMOPE,"")) AS QUEBRA, ';
      15: strSQL := strSQL + ' CONCAT(IFNULL(MAR_CODMAR,""),"-",IFNULL(MAR_DESMAR,"")) AS QUEBRA, ';
    End;

    {**************************************}
    {* LITRAGEM                           *}
    {***********************************PZ*}
    If edtOpcao2.Text = 'L' Then
    Begin
      strSQLLitro := ' IF(IF(TRIM(IFNULL(UNI_KILLIT,""))="","L",UNI_KILLIT) = "L", ((' + fStrRelFatorLit + ') * DET_QTDITE) * IF(LEFT(DET_CLAFIS,1) < 5, -1, 1), 0) ';
      strSQLQuilo := ' IF(IF(TRIM(IFNULL(UNI_KILLIT,""))="","L",UNI_KILLIT) = "K", ((UNI_PESLIT / :LITGAL) * DET_QTDITE) * IF(LEFT(DET_CLAFIS,1) < 5, -1, 1), 0) ';
      strSQL := strSQL + '  SUM(IF(DET_DTAENT BETWEEN :DTAINI AND :DTAFIN, '+strSQLLitro+'+'+strSQLQuilo+', 0)) AS VENATU, ';
      strSQL := strSQL + '  SUM(IF(DET_DTAENT BETWEEN :DTAIAN AND :DTAFAN, '+strSQLLitro+'+'+strSQLQuilo+', 0)) AS VENANT, ';
    End

    {**************************************}
    {* UNITARIO                           *}
    {***********************************PZ*}
    Else If edtOpcao2.Text = 'Q' Then
    Begin
      strSQL := strSQL + '  SUM( IF(DET_DTAENT BETWEEN :DTAINI AND :DTAFIN, IF(LEFT(DET_CLAFIS,1) < 5, -DET_QTDITE, DET_QTDITE), 0)) AS VENATU, ';
      strSQL := strSQL + '  SUM( IF(DET_DTAENT BETWEEN :DTAIAN AND :DTAFAN, IF(LEFT(DET_CLAFIS,1) < 5, -DET_QTDITE, DET_QTDITE), 0)) AS VENANT, ';
    End

    {**************************************}
    {* VALOR                              *}
    {***********************************PZ*}
    Else If edtOpcao2.Text = 'V' Then
    Begin
      strSQL := strSQL + '  SUM( IF(DET_DTAENT BETWEEN :DTAINI AND :DTAFIN, IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - IF(DET_DESESP < 0, -DET_DESESP, DET_DESESP)-DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF)), 0)) AS VENATU, ';
      strSQL := strSQL + '  SUM( IF(DET_DTAENT BETWEEN :DTAIAN AND :DTAFAN, IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - IF(DET_DESESP < 0, -DET_DESESP, DET_DESESP)-DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF)), 0)) AS VENANT, ';
    End;

    strSQL := strSQL + '  SUM( IF(DET_DTAENT BETWEEN :DTAINI AND :DTAFIN, IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - IF(DET_DESESP < 0, -DET_DESESP, DET_DESESP)-DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF)), 0)) AS VENATUPORVALOR, ';
    strSQL := strSQL + '  SUM( IF(DET_DTAENT BETWEEN :DTAIAN AND :DTAFAN, IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - IF(DET_DESESP < 0, -DET_DESESP, DET_DESESP)-DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF)), 0)) AS VENANTPORVALOR, ';

    strSQL := strSQL + '  SUM( IF(DET_DTAENT BETWEEN :DTAINI AND :DTAFIN, IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), '+strTotCus+', '+strTotCus+'), 0)) AS CUSATU, ';
    strSQL := strSQL + '  SUM( IF(DET_DTAENT BETWEEN :DTAIAN AND :DTAFAN, IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), '+strTotCus+', '+strTotCus+'), 0)) AS CUSANT ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVGER ';
    strSQL := strSQL + '  JOIN MOVDET ON MOVDET.DET_SEQGER = MOVGER.AUTOINCREM ';
    strSQL := strSQL + '  INNER JOIN CADCLI ON DET_CODCLI = CLI_CODCLI ';
    strSQL := strSQL + '  INNER JOIN CADCID ON CID_CODCID = CLI_CODCID ';
    strSQL := strSQL + '  INNER JOIN CADITE ON ITE_CODITE = DET_CODITE ';
    strSQL := strSQL + '  INNER JOIN MOVTRI ON MOVDET.AUTOINCREM = MOVTRI.DET_SEQGER ';
    strSQL := strSQL + '  LEFT  JOIN CADUNI ON DET_UNIDAD = UNI_CODUNI ';
    strSQL := strSQL + '  LEFT  JOIN CADFOR ON FOR_CODFOR = DET_FORITE ';
    strSQL := strSQL + '  LEFT  JOIN CADATI ON ATI_CODATI = CLI_CODATI ';
    strSQL := strSQL + '  LEFT  JOIN CADOPE V ON V.OPE_CODOPE = DET_CODVEN ';
    strSQL := strSQL + '  LEFT  JOIN CADOPE R ON R.OPE_CODOPE = DET_CODREP ';
    strSQL := strSQL + '  LEFT  JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR ';
    strSQL := strSQL + '  INNER JOIN CADGRU ON GRU_CODGRU = ITE_CODGRU ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  DET_PROEMB <> "S" AND ';
    strSQL := strSQL + '  DET_TIP_FC = "C" AND ';
    If Not fEmptyStr(fRetSomenteNumeros(VS_strCliFil)) Then
      strSQL := strSQL + '  DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
    strSQL := strSQL + cnsFiltroFFDVTR;
    strSQL := strSQL + '  ((LOCATE(DET_CLAFIS, :CLAVEN) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0)';

    If fCfgSis('ENTBRF', varBoolean) Then
      strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) AND '
    Else
      strSQL := strSQL + ') AND ';

    strSQL := strSQL + '  ((DET_DTAENT BETWEEN :DTAINI AND :DTAFIN) OR ';
    strSQL := strSQL + '   (DET_DTAENT BETWEEN :DTAIAN AND :DTAFAN)) ';

    If edtEmpFat.Text = 'F' Then
      strSQL := strSQL + fStrLocate(edtCodEmpresa, arrEmpresa, 'DET_CODEMP', 'CODEMP')
    Else
      strSQL := strSQL + fStrLocate(edtCodEmpresa, arrEmpresa, 'MOVTRI.DET_EMPORI', 'CODEMP');

    If Not fEmptyStr(mskLinhaGrupo.Text) Then
    Begin
      If Length(arrLinhaGrupo) > 1 Then
        strSQL := strSQL + '  AND LOCATE(ITE_CODGRU,:CODGRU) > 0 '
      Else
      Begin
        If RightStr(mskLinhaGrupo.Text,3) = '000' Then
          strSQL := strSQL + '  AND LEFT(ITE_CODGRU,3) = LEFT(:CODGRU,3) '
        Else
          strSQL := strSQL + '  AND ITE_CODGRU = :CODGRU ';
      End;
    End;

    strSQL := strSQL + fStrLocate(edtCodCliente,arrLinhaClien,'DET_CODCLI','CODCLI');
    strSQL := strSQL + fStrLocate(edtCodVendedor,arrLinhaVende,'DET_CODVEN','CODVEN');
    strSQL := strSQL + fStrLocate(edtCodRepresentante,arrLinhaRepre,'DET_CODREP','CODREP');
    strSQL := strSQL + fStrLocate(edtFornecedor,arrLinhaForne,'DET_FORITE','CODFOR');
    strSQL := strSQL + fStrLocate(edtCodMarca,arrLinhaMarca,'ITE_CODMAR','CODMAR');
    strSQL := strSQL + fStrLocate(edtCodAti,arrLinAti,'CLI_CODATI','CODATI');
    strSQL := strSQL + fStrLocate(edtCodDep,arrDepart,'V.OPE_CODDEP','CODDEP');
    strSQL := strSQL + fStrLocate(edtCodCidade,arrLinhaCidad,'CLI_CODCID','CODCID');
    strSQL := strSQL + fStrLocate(edtCodProduto,arrProduto,'DET_CODITE','CODITE');
    strSQL := strSQL + fStrLocate(edtCodUnidade,arrUnidade,'DET_UNIDAD','CODUNI');
    strSQL := strSQL + fStrLocate(edtDepProd,arrDepProd,'ITE_CODDEP','PRODEP');

    {****************************}
    {* FILTRO REDE DE LOJAS     *}
    {*************************DP*}
    strSQL := strSQL + fStrSQLOr(edtCodRede,arrRede,'CLI_CODRED','CODRED');

    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + strGroupBy;

    If Not fEmptyStr(edtEstado.Text) Then
    Begin
      strSQL := strSQL + 'HAVING ';
      strSQL := strSQL + '  ESTADO  = :ESTADO ';
    End;

    strSQL := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL, strSQL);

    {*****************************************}
    {* VERIFICA O VENDEDOR QUE ESTARA USANDO *}
    {**************************************LU*}
    If edtVendedor.Text = '2' Then
      strSQL := AnsiReplaceStr(strSQL,'DET_CODVEN','DET_CODVE2');

    QryRelatorio := fCriaQuery;

    With QryRelatorio Do
    Begin

      strSQL := 'SELECT SQL_NO_CACHE ' +
                '  CODCLI, ' +
                '  NOMCLI, ' +
                '  C_G_C_, ' +
                '  FONE01, ' +
                '  ENDERE, ' +
                '  CODCID, ' +
                '  CODVEN, ' +
                '  CODREP, ' +
                '  CODFOR, ' +
                '  CODITE, ' +
                '  DESITE, ' +
                '  CODGRU, ' +
                '  NOMCID, ' +
                '  ESTADO, ' +
                '  NOMVEN, ' +
                '  NOMREP, ' +
                '  NOMFOR, ' +
                '  DESATI, ' +
                '  QUEBRA, ' +
                '  MRGATU, ' +
                '  MRGANT, ' +
                '  CMGATU, ' +
                '  CMGANT, ' +
                '  0.00 AS EVOMRG,   ' +
                '  0.00 AS PERMRG,   ' +
                '  SUM(CUSATU) AS CUSATU, ' +
                '  SUM(CUSANT) AS CUSANT, ' +
                '  SUM(VENATU) AS VENATU, ' +
                '  SUM(VENANT) AS VENANT, ' +
                '  SUM(VENATUPORVALOR) AS VENATUPORVALOR, ' +
                '  SUM(VENANTPORVALOR) AS VENANTPORVALOR, ' +
                '  IF(SUM(VENANT) <> 0,  IF(SUM(VENATU) > SUM(VENANT), ((SUM(VENATU)/SUM(VENANT))-1)*100, 0), IF(SUM(VENATU) < 0, 0, 100))  AS EVOVEN, ' +
                '  IF(SUM(VENATU) <> 0,  IF(SUM(VENATU) < SUM(VENANT), ((SUM(VENATU)/SUM(VENANT))-1)*100, 0), IF(SUM(VENANT) < 0, 0, -100)) AS PERVEN  ' +
                'FROM ( ' + strSQL + ' ) AS TMP GROUP BY ' + strGroupBy;

      If (StrToIntDef(edtOpcao.Text, 0) <> 4) And (StrToIntDef(edtOpcao.Text, 0) <> 5) And (StrToIntDef(edtOpcao.Text, 0) <> 13) Then
      Begin
        strSQL := strSQL + 'ORDER BY ';
        strSQL := strSQL + '  QUEBRA ';
        If (StrToIntDef(edtOpcao.Text, 0) = 7) Then
          strSQL := strSQL + ', NOMCID ';
        If (StrToIntDef(edtOpcao.Text, 0) = 14) Then
          strSQL := strSQL + ', DESITE ';
      End
      Else If StrToIntDef(edtOpcao.Text,0) = 13 then
      Begin
        strSQL := strSQL + 'ORDER BY ';
        strSQL := strSQL + '  VENATU DESC';
      End;

      {***********************************************}
      {* SE USA COMO CURVA ABC, ORDENA PELO VR TOTAL *}
      {* DE FORMA DESCRESCENTE E LIMITA A QUANTIDADE *}
      {* DE REGISTROS EXIBIDOS DE ACORDO COM O N DI- *}
      {* GITADO NO CAMPO Nº DE CLIENTES              *}
      {********************************************ER*}
      If chkCurva.Checked Then
        strSQL := strSQL + ' ORDER BY VENATU DESC LIMIT ' + edtNumCli.Text;

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
      ParamByName('DTAIAN').AsDate := IncYear(StrToDate(mskDtaIni.Text), -1);
      ParamByName('DTAFAN').AsDate := IncYear(StrToDate(mskDtaFin.Text), -1);
      ParamByName('CLAVEN').AsString := VS_strClaVen;
      ParamByName('CLADEV').AsString := VS_strClaDev;

      If edtOpcao2.Text = 'L' Then
      Begin
        If Params.FindParam('LITGAL') <> Nil Then
        Begin
          If SameText(fCfgSis('LITGAL'), 'L') Then
            ParamByName('LITGAL').AsFloat := 1
          Else
            ParamByName('LITGAL').AsFloat := FLT_LITRO_GALAO;
        End;
      End;
      
      pSetaParam(edtCodEmpresa.Text,arrEmpresa, strEmpresa,'CODEMP', QryRelatorio);
      pSetaParam(mskLinhaGrupo.Text,arrLinhaGrupo,strLinGru,'CODGRU', QryRelatorio);
      pSetaParam(edtCodCliente.Text,arrLinhaClien,strLinCli,'CODCLI',QryRelatorio);
      pSetaParam(strCodVen,arrLinhaVende,strLinVen,'CODVEN', QryRelatorio);
      pSetaParam(strCodRep,arrLinhaRepre,strLinRep,'CODREP',QryRelatorio);
      pSetaParam(edtFornecedor.Text,arrLinhaForne,strLinFor,'CODFOR', QryRelatorio);
      pSetaParam(edtCodMarca.Text,arrLinhaMarca,strLinMar,'CODMAR', QryRelatorio);
      pSetaParam(edtCodAti.Text,arrLinAti,strLinAti,'CODATI',QryRelatorio);
      pSetaParam(edtCodDep.Text,arrDepart,strDepart,'CODDEP',QryRelatorio);
      pSetaParam(edtCodCidade.Text,arrLinhaCidad,strLinCid,'CODCID',QryRelatorio);
      pSetaParam(edtCodProduto.Text,arrProduto,strLinPro,'CODITE',QryRelatorio);
      pSetaParam(edtCodUnidade.Text,arrUnidade,strLinUni,'CODUNI',QryRelatorio);
      pSetaParam(edtDepProd.Text,arrDepProd,strDepProd,'PRODEP',QryRelatorio);
      {*****************}
      {* REDE DE LOJAS *}
      {**************DP*}
      pSetaParamOR(edtCodRede,arrRede,'CODRED',QryRelatorio);

      If Not fEmptyStr(edtEstado.Text) Then
        ParamByName('ESTADO').AsString := edtEstado.Text;

      Open;


      For intCont := 1 To FieldCount Do
      Begin
        Fields.FieldByNumber(intCont).Required := False;
        Fields.FieldByNumber(intCont).ReadOnly := False;
      End;

      cpvRelatorio.DataSet := QryRelatorio;

      cdsRelatorio.Close;
      cdsRelatorio.SetProvider(cpvRelatorio);
      cdsRelatorio.Open;

      pSetaClient(cdsRelatorio);

      {**********************}
      {*ATUALIZA AS MARGENS *}
      {********************PZ}
      While Not cdsRelatorio.Eof Do
      Begin
        cdsRelatorio.Edit;
        cdsRelatorio.FieldByName('MRGATU').AsFloat := fFormataFloat(fCalculaPrecoVenda(2,
                                                                         cdsRelatorio.FieldByName('CUSATU').AsFloat,
                                                                         cdsRelatorio.FieldByName('VENATUPORVALOR').AsFloat,
                                                                         0,
                                                                         0,
                                                                         0,
                                                                         0,
                                                                         0), 2);

        cdsRelatorio.FieldByName('MRGANT').AsFloat := fFormataFloat(fCalculaPrecoVenda(2,
                                                                         cdsRelatorio.FieldByName('CUSANT').AsFloat,
                                                                         cdsRelatorio.FieldByName('VENANTPORVALOR').AsFloat,
                                                                         0,
                                                                         0,
                                                                         0,
                                                                         0,
                                                                         0), 2);


        IF(cdsRelatorio.FieldByName('MRGANT').AsFloat <> 0) Then
        Begin
          IF( cdsRelatorio.FieldByName('MRGATU').AsFloat > cdsRelatorio.FieldByName('MRGANT').AsFloat ) And (cdsRelatorio.FieldByName('MRGATU').AsFloat <> 0) Then
            cdsRelatorio.FieldByName('EVOMRG').AsFloat := ((cdsRelatorio.FieldByName('MRGATU').AsFloat/cdsRelatorio.FieldByName('MRGANT').AsFloat)-1) * 100
          Else
          Begin
            If (cdsRelatorio.FieldByName('VENANTPORVALOR').AsFloat < 0) And (cdsRelatorio.FieldByName('VENATUPORVALOR').AsFloat = 0) Then
              cdsRelatorio.FieldByName('EVOMRG').AsFloat := 100
            Else
              cdsRelatorio.FieldByName('EVOMRG').AsFloat := 0;
          End;
        End
        Else
        Begin
          If (cdsRelatorio.FieldByName('VENATUPORVALOR').AsFloat < 0) And (cdsRelatorio.FieldByName('VENANTPORVALOR').AsFloat = 0) Then
            cdsRelatorio.FieldByName('EVOMRG').AsFloat := 0
          Else
            cdsRelatorio.FieldByName('EVOMRG').AsFloat := 100;
        End;

        If (cdsRelatorio.FieldByName('MRGATU').AsFloat <> 0) Then
        Begin
          IF( cdsRelatorio.FieldByName('MRGATU').AsFloat < cdsRelatorio.FieldByName('MRGANT').AsFloat ) And (cdsRelatorio.FieldByName('MRGANT').AsFloat <> 0) Then
             cdsRelatorio.FieldByName('PERMRG').AsFloat := ((cdsRelatorio.FieldByName('MRGATU').AsFloat/cdsRelatorio.FieldByName('MRGANT').AsFloat)-1) * 100
          Else
          Begin
            If (cdsRelatorio.FieldByName('VENATUPORVALOR').AsFloat < 0) And (cdsRelatorio.FieldByName('VENANTPORVALOR').AsFloat = 0) Then
              cdsRelatorio.FieldByName('EVOMRG').AsFloat := -100
            Else
              cdsRelatorio.FieldByName('PERMRG').AsFloat := 0;
          End;
        End
        Else
        Begin
          If (cdsRelatorio.FieldByName('VENANTPORVALOR').AsFloat < 0) And (cdsRelatorio.FieldByName('VENATUPORVALOR').AsFloat = 0) Then
            cdsRelatorio.FieldByName('PERMRG').AsFloat := 0
          Else
            cdsRelatorio.FieldByName('PERMRG').AsFloat := -100
        End;

        cdsRelatorio.Post;
        cdsRelatorio.Next;
      End;

      cdsRelatorio.First;

      If Not cdsRelatorio.IsEmpty Then
      Begin

        If (edtDestino.Text = 'E') Then
        Begin
          pGeraExcelEvoVendas(StrToInt(edtOpcao.Text));
          cdsRelatorio.Close;
          btnImprimir.Enabled := True;
          pnlInfo.Caption := '';
          Exit;
        End;

        Try
          pCriarFormularios(TfrmQckFatEvolVendasPeriodo,frmQckFatEvolVendasPeriodo);
          frmQckFatEvolVendasPeriodo.cdsRel.Data := cdsRelatorio.Data;
          If strTipImp = 'M' Then
            frmQckFatEvolVendasPeriodo.qckPagina.DefaultFilter := rldFiltro
          Else
            frmQckFatEvolVendasPeriodo.qckPagina.DefaultFilter := Nil;

          {**************************}
          {* CABECALHO DO RELATORIO *}
          {***********************AF*}
          frmQckFatEvolVendasPeriodo.strNomCliente       := fStrTitulo(edtCodCliente.Text,edtDesCliente,arrLinhaClien,strLinCli,'CLIENTE');
          frmQckFatEvolVendasPeriodo.strNomVendedor      := fStrTitulo(strCodVen,edtDesVendedor,arrLinhaVende,strLinVen,'VENDEDOR');
          frmQckFatEvolVendasPeriodo.strRepresentante    := fStrTitulo(strCodRep,edtDesRepresentante,arrLinhaRepre,strLinRep,'REPRESENTANTE');
          frmQckFatEvolVendasPeriodo.strFornecedor       := fStrTitulo(edtFornecedor.Text,edtDesFornecedor,arrLinhaForne,strLinFor,'FORNECEDOR');
          frmQckFatEvolVendasPeriodo.strMarca            := fStrTitulo(edtCodMarca.Text,edtNomMarca,arrLinhaMarca,strLinMar,'MARCA',True);
          frmQckFatEvolVendasPeriodo.strAtividade        := fStrTitulo(edtCodAti.Text,edtDesAti,arrLinAti,strLinAti,'ATIVIDADE',True);
          frmQckFatEvolVendasPeriodo.strDepartamento     := fStrTitulo(edtCodDep.Text,edtDesDep,arrDepart,strDepart,'DEPARTAMENTO');
          frmQckFatEvolVendasPeriodo.strDepProd          := fStrTitulo(edtDepProd.Text,edtDepProdDes,arrDepProd,strDepProd,'DEPTO. PRODUTO');
          frmQckFatEvolVendasPeriodo.strCidade           := fStrTitulo(edtCodCidade.Text,edtDesCidade,arrLinhaCidad,strLinCid,'CIDADE',True);
          frmQckFatEvolVendasPeriodo.strNomProduto       := fStrTitulo(edtCodProduto.Text,edtDesProduto,arrProduto,strLinPro,'PRODUTO');
          frmQckFatEvolVendasPeriodo.strNomUnidade       := fStrTitulo(edtCodUnidade.Text,edtDesUnidade,arrUnidade,strLinUni,'UNIDADE',True);
          frmQckFatEvolVendasPeriodo.strLinhaGrupo       := fStrTitulo(mskLinhaGrupo.Text,edtDesGrupo,arrLinhaGrupo,strLinGru,'LINHA/GRUPO',True);
          frmQckFatEvolVendasPeriodo.rllRedeLoja.Caption := fStrTitulo(edtCodRede.Text,edtDesRede,arrRede,strRede,'REDE DE LOJAS',True);
          frmQckFatEvolVendasPeriodo.strOrdem            := 'PERÍODO: ' +  FormatDateTime('DD/MM/YYYY',StrToDate(mskDtaIni.Text)) + '  A  ' + FormatDateTime('DD/MM/YYYY',strToDate(mskDtaFin.Text));
          frmQckFatEvolVendasPeriodo.rllEmpresa.Caption  := fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmpresa, strEmpresa, 'EMPRESA', True);
          frmQckFatEvolVendasPeriodo.rllEmpresa.Caption  := frmQckFatEvolVendasPeriodo.rllEmpresa.Caption + IfThen(edtEmpFat.Text='P', ' (Pedido)', ' (Faturamento)');
          frmQckFatEvolVendasPeriodo.rllCusto.Caption    := 'COMPOSIÇÃO DE CUSTO: ' + cbbComCus.Text;

          Case StrToInt(edtOpcao.Text) Of
             1: frmQckFatEvolVendasPeriodo.strNomRelatorio := 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR REPRESENTANTE/CLIENTE';
             2: frmQckFatEvolVendasPeriodo.strNomRelatorio := 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR VENDEDOR/CLIENTE';
             3: frmQckFatEvolVendasPeriodo.strNomRelatorio := 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR CIDADE/CLIENTE';
             4: frmQckFatEvolVendasPeriodo.strNomRelatorio := 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR CLIENTE';
             5: frmQckFatEvolVendasPeriodo.strNomRelatorio := 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR CLIENTE 2';
             6: frmQckFatEvolVendasPeriodo.strNomRelatorio := 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR FORNECEDOR/PRODUTO';
             7: frmQckFatEvolVendasPeriodo.strNomRelatorio := 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR VENDEDOR/CIDADE';
             8: frmQckFatEvolVendasPeriodo.strNomRelatorio := 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR ATIVIDADE';
             9: frmQckFatEvolVendasPeriodo.strNomRelatorio := 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR REPRESENTANTE';
            10: frmQckFatEvolVendasPeriodo.strNomRelatorio := 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR FORNECEDOR';
            11: frmQckFatEvolVendasPeriodo.strNomRelatorio := 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR LINHA/GRUPO';
            12: frmQckFatEvolVendasPeriodo.strNomRelatorio := 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR CIDADE';
            13: frmQckFatEvolVendasPeriodo.strNomRelatorio := 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR VENDEDOR';
            14: frmQckFatEvolVendasPeriodo.strNomRelatorio := 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR VENDEDOR/PRODUTO';
            15: frmQckFatEvolVendasPeriodo.strNomRelatorio := 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR MARCA';
          End;

          {*****************************************************************}
          {*CONTROLA A EXIBIÇÃO DE ALGUNS CAMPOS CONFORME A OPÇÃO INFORMADA*}
          {***************************************************************PZ}
          frmQckFatEvolVendasPeriodo.rllCliente.Caption      := 'CLIENTE';

          If (StrToIntDef(edtOpcao.Text,0) = 4) Or (StrToIntDef(edtOpcao.Text,0) = 5) Then
          Begin
            frmQckFatEvolVendasPeriodo.rlbTituloGrupo.Visible  := False;
            frmQckFatEvolVendasPeriodo.rlbResumoGrupo.Visible  := False;
            frmQckFatEvolVendasPeriodo.rdbCodCli.Visible       := True;
            frmQckFatEvolVendasPeriodo.rdbLinGru.Visible       := False;
            frmQckFatEvolVendasPeriodo.rdbCodIte.Visible       := False;
            frmQckFatEvolVendasPeriodo.rdbCodCid.Visible       := False;

            If (StrToIntDef(edtOpcao.Text,0) = 5) Then
            Begin
              frmQckFatEvolVendasPeriodo.rllVendedor.Visible   := True;
              frmQckFatEvolVendasPeriodo.rdbVendedor.Visible   := True;
            End;
          End
          Else If (StrToIntDef(edtOpcao.Text,0) = 6) Or (StrToIntDef(edtOpcao.Text,0) = 14) Then
          Begin
            frmQckFatEvolVendasPeriodo.rllCliente.Caption      := 'PRODUTO';
            frmQckFatEvolVendasPeriodo.rlbTituloGrupo.Visible  := True;
            frmQckFatEvolVendasPeriodo.rlbResumoGrupo.Visible  := True;
            frmQckFatEvolVendasPeriodo.rdbCodCli.Visible       := False;
            frmQckFatEvolVendasPeriodo.rdbCodCid.Visible       := False;
            frmQckFatEvolVendasPeriodo.rdbCodIte.Visible       := True;
            frmQckFatEvolVendasPeriodo.rdbCodIte.Left          := 1;
          End
          Else If(StrToIntDef(edtOpcao.Text,0) = 7) Then
          Begin
            frmQckFatEvolVendasPeriodo.rllCliente.Caption      := 'CIDADE';
            frmQckFatEvolVendasPeriodo.rlbTituloGrupo.Visible  := True;
            frmQckFatEvolVendasPeriodo.rlbResumoGrupo.Visible  := True;
            frmQckFatEvolVendasPeriodo.rdbCodCli.Visible       := False;
            frmQckFatEvolVendasPeriodo.rdbCodIte.Visible       := False;
            frmQckFatEvolVendasPeriodo.rdbCodCid.Visible       := True;
            frmQckFatEvolVendasPeriodo.rdbCodCid.Left          := 1;
          End
          Else If StrToInt(edtOpcao.Text) In [8..13,15] Then
          Begin

            Case StrToInt(edtOpcao.Text) Of
              8:  frmQckFatEvolVendasPeriodo.rllCliente.Caption := 'ATIVIDADE';
              9:  frmQckFatEvolVendasPeriodo.rllCliente.Caption := 'REPRESENTANTE';
              10: frmQckFatEvolVendasPeriodo.rllCliente.Caption := 'FORNECEDOR';
              11: frmQckFatEvolVendasPeriodo.rllCliente.Caption := 'LINHA/GRUPO';
              12: frmQckFatEvolVendasPeriodo.rllCliente.Caption := 'CIDADE';
              13: frmQckFatEvolVendasPeriodo.rllCliente.Caption := 'VENDEDOR';
              15: frmQckFatEvolVendasPeriodo.rllCliente.Caption := 'MARCA';
            End;
            frmQckFatEvolVendasPeriodo.rlbTituloGrupo.Visible  := False;

            frmQckFatEvolVendasPeriodo.rlbResumoGrupo.Visible  := False;
            frmQckFatEvolVendasPeriodo.rdbCodCli.Visible       := False;
            frmQckFatEvolVendasPeriodo.rdbCodIte.Visible       := False;
            frmQckFatEvolVendasPeriodo.rdbCodCid.Visible       := False;
            frmQckFatEvolVendasPeriodo.rdbLinGru.Visible       := True;

            frmQckFatEvolVendasPeriodo.rdbTotalVendaAnt.Top := frmQckFatEvolVendasPeriodo.rdbCodCli.Top;
            frmQckFatEvolVendasPeriodo.rdbTotalVenda.Top := frmQckFatEvolVendasPeriodo.rdbCodCli.Top;
            frmQckFatEvolVendasPeriodo.rdbEvoVen.Top := frmQckFatEvolVendasPeriodo.rdbCodCli.Top;
            frmQckFatEvolVendasPeriodo.rdbPerVen.Top := frmQckFatEvolVendasPeriodo.rdbCodCli.Top;
            frmQckFatEvolVendasPeriodo.rdbMrgAnt.Top := frmQckFatEvolVendasPeriodo.rdbCodCli.Top;
            frmQckFatEvolVendasPeriodo.rdbMrgAtu.Top := frmQckFatEvolVendasPeriodo.rdbCodCli.Top;
            frmQckFatEvolVendasPeriodo.rdbEvoMrg.Top := frmQckFatEvolVendasPeriodo.rdbCodCli.Top;
            frmQckFatEvolVendasPeriodo.rdbPerMrg.Top := frmQckFatEvolVendasPeriodo.rdbCodCli.Top;
            frmQckFatEvolVendasPeriodo.rlbDetalheGrupo.Height := frmQckFatEvolVendasPeriodo.rdbPerMrg.Height + 2;
          End
          Else
          Begin
            frmQckFatEvolVendasPeriodo.rlbTituloGrupo.Visible  := True;
            frmQckFatEvolVendasPeriodo.rlbResumoGrupo.Visible  := True;
            frmQckFatEvolVendasPeriodo.rdbCodCli.Visible       := True;
            frmQckFatEvolVendasPeriodo.rdbCodIte.Visible       := False;
            frmQckFatEvolVendasPeriodo.rdbCodCid.Visible       := False;
          End;

          frmQckFatEvolVendasPeriodo.intTipQuebra := StrToIntDef(edtOpcao.Text,0);
          
          frxRelatorio.DataSet := QryRelatorio;

          If edtDestino.Text = 'V' Then
            frmQckFatEvolVendasPeriodo.qckPagina.PreviewModal
          Else
            frmQckFatEvolVendasPeriodo.qckPagina.Print;

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '[TfrmRelFatEvolVendasPeriodo.btnImprimirClick]');
          End;
        End;

        pFreeAndNil(frmQckFatEvolVendasPeriodo);

      End
      Else
        pTabelaVazia;

      cdsRelatorio.Close;
    End;
  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';

end;

procedure TfrmRelFatEvolVendasPeriodo.edtCodProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodProduto, edtDesProduto, nil, Key, arrProduto, False, nil, 'Consulta de Itens', '1') Then  
  Begin
    fvalidaCampos(edtCodProduto,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatEvolVendasPeriodo.edtCodUnidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqUnidade(Self, edtCodUnidade, edtDesUnidade, nil, nil, Key, arrUnidade, False) Then
  Begin
    fvalidaCampos(edtCodUnidade,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

{*******************************************}
{* GERAR RELATÓRIO EM PLANILHA EXCEL       *}
{****************************************RL*}
procedure TfrmRelFatEvolVendasPeriodo.pGeraExcelEvoVendas(intOpcao: Integer);
  Var
    objExcel    : TExcel;
    intCol      : Integer;
    strGrupo    : String;
    arrTotalParc: Array Of Double;
    arrTotal    : Array Of Double;
    fltMrgAnt,
    fltMrgAtu   : Double;
begin
  {****************************************************************}
  {* CRIA UM OBJETO DO TIPO "EXCEL" E TORNA A APLICAÇÃO INVISÍVEL *}
  {*************************************************************RL*}
  objExcel := TExcel.fCriarExcel(Self);

  If Not objExcel.CriarArquivo Then
  Begin
    FreeAndNil(objExcel);
    Exit;
  End;

  Try
    Try

      With objExcel Do
      Begin
        LinhaAtual := 01;

        {********************************}
        {* EMPRESA PADRAO DO SISTEMA    *}
        {*****************************RL*}
        Escrever(ProximaLinha, 01, fRetNomeEmpresaSelec(VS_strCodEmp));

        {*******************************************}
        {* TITULO DO RELATORIO                     *}
        {****************************************RL*}
        Case intOpcao Of
          01: Escrever(ProximaLinha, 01, 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR REPRESENTANTE'    );
          02: Escrever(ProximaLinha, 01, 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR VENDEDOR'         );
          03: Escrever(ProximaLinha, 01, 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR CIDADE'           );
          04: Escrever(ProximaLinha, 01, 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR CLIENTE'          );
          05: Escrever(ProximaLinha, 01, 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR CLIENTE 2'        );
          06: Escrever(ProximaLinha, 01, 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR FORNECEDOR'       );
          07: Escrever(ProximaLinha, 01, 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR VENDEDOR/CIDADE'  );
          08: Escrever(ProximaLinha, 01, 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR ATIVIDADE'        );
          09: Escrever(ProximaLinha, 01, 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR REPRESENTANTE'    );
          10: Escrever(ProximaLinha, 01, 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR FORNECEDOR'       );
          11: Escrever(ProximaLinha, 01, 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR LINHA/GRUPO'      );
          12: Escrever(ProximaLinha, 01, 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR CIDADE'           );
          13: Escrever(ProximaLinha, 01, 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR VENDEDOR'         );
          14: Escrever(ProximaLinha, 01, 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR VENDEDOR/PRODUTO' );
          15: Escrever(ProximaLinha, 01, 'RELATÓRIO DE EVOLUÇÃO DE VENDAS POR MARCA'            );
        End;

        ProximaLinha;

        {*******************************************}
        {* OUTROS DADOS DO RELATÓRIO               *}
        {****************************************RL*}
        If fEmptyStr(edtCodCliente.Text) Then
          Escrever(ProximaLinha, 01, 'CLIENTE: TODOS')
        Else
          Escrever(ProximaLinha, 01, 'CLIENTE: '  + edtCodCliente.Text + '-' + edtDesCliente.Text);

        If fEmptyStr(edtCodRede.Text) Then
          Escrever(ProximaLinha, 01, 'REDE DE LOJAS: TODAS')
        Else
          Escrever(ProximaLinha, 01, 'REDE DE LOJAS: '  + edtCodRede.Text + '-' + edtDesRede.Text);

        If fEmptyStr(edtCodVendedor.Text) Then
          Escrever(ProximaLinha, 01, 'VENDEDOR: TODOS')
        Else
          Escrever(ProximaLinha, 01, 'VENDEDOR: ' + edtCodVendedor.Text + '-' + edtDesVendedor.Text);

        If fEmptyStr(edtCodRepresentante.Text) Then
          Escrever(ProximaLinha, 01, 'REPRESENTANTE: TODOS')
        Else
          Escrever(ProximaLinha, 01, 'REPRESENTANTE: ' + edtCodRepresentante.Text + '-' + edtDesRepresentante.Text);

        If fEmptyStr(edtFornecedor.Text) Then
          Escrever(ProximaLinha, 01, 'FORNECEDOR: TODOS')
        Else
          Escrever(ProximaLinha, 01, 'FORNECEDOR: ' + edtFornecedor.Text + '-' + edtDesFornecedor.Text);

        If fEmptyStr(edtCodMarca.Text) Then
          Escrever(ProximaLinha, 01, 'MARCA: TODAS')
        Else
          Escrever(ProximaLinha, 01, 'MARCA: ' + edtCodMarca.Text + '-' + edtNomMarca.Text);

        If fEmptyStr(edtCodAti.Text) Then
          Escrever(ProximaLinha, 01, 'ATIVIDADE: TODAS')
        Else
          Escrever(ProximaLinha, 01, 'ATIVIDADE: ' + edtCodAti.Text + '-' + edtDesAti.Text);

        If fEmptyStr(edtCodDep.Text) Then
          Escrever(ProximaLinha, 01, 'DEPARTAMENTO: TODOS')
        Else
          Escrever(ProximaLinha, 01, 'DEPARTAMENTO: ' + edtCodDep.Text + '-' + edtDesDep.Text);

        If fEmptyStr(edtDepProd.Text) Then
          Escrever(ProximaLinha, 01, 'DEPTO. PRODUTO: TODOS')
        Else
          Escrever(ProximaLinha, 01, 'DEPTO. PRODUTO: ' + edtDepProd.Text + '-' + edtDepProdDes.Text);

        If fEmptyStr(edtCodCidade.Text) Then
          Escrever(ProximaLinha, 01, 'CIDADE: TODAS')
        Else
          Escrever(ProximaLinha, 01, 'CIDADE: ' + edtCodCidade.Text + '-' + edtDesCidade.Text);

        If fEmptyStr(edtCodProduto.Text) Then
          Escrever(ProximaLinha, 01, 'PRODUTO: TODOS')
        Else
          Escrever(ProximaLinha, 01, edtCodProduto.Text + ' - ' + edtDesProduto.Text);

        If fEmptyStr(edtCodUnidade.Text) Then
          Escrever(ProximaLinha, 01, 'UNIDADE: TODAS')
        Else
          Escrever(ProximaLinha, 01, edtCodUnidade.Text + ' - ' + edtDesUnidade.Text);

        If fEmptyStr(mskLinhaGrupo.Text) Then
          Escrever(ProximaLinha, 01, 'LINHA/GRUPO: TODAS')
        Else
          Escrever(ProximaLinha, 01, 'LINHA/GRUPO: ' + mskLinhaGrupo.Text + '-' + edtDesGrupo.Text);

        Escrever(ProximaLinha, 01, 'COMPOSIÇÃO DE CUSTO: ' + cbbComCus.Text);
        Escrever(ProximaLinha, 01, 'PERÍODO: ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text);

        {********************************}
        {* MESCLA AS COLUNAS            *}
        {*****************************RL*}
        Mesclar('A1','I1');
        Mesclar('A2','I2');
        Mesclar('A3','I3');
        Mesclar('A4','I4');
        Mesclar('A5','I5');
        Mesclar('A6','I6');
        Mesclar('A7','I7');
        Mesclar('A8','I8');
        Mesclar('A9','I9');
        Mesclar('A10','I10');
        Mesclar('A11','I11');
        Mesclar('A12','I12');
        Mesclar('A13','I13');
        Mesclar('A14','I14');
        Mesclar('A15','I15');
        Mesclar('A16','I16');
        Mesclar('A17','I17');        
        Mesclar('A18','I18');

        {**************************************************}
        {* COLOCA EM NEGRITO E ALINHA AO CENTRO DA CELULA *}
        {***********************************************RL*}
        Alinhamento('A1','I18', Centro);
        Negrito('A1','I18', True);

        {*************************************}
        {* COLORE O FUNDO DA CELULA P/ CINZA *}
        {**********************************RL*}
        CorFundo('A2','I3', Cinza);
        CorFundo('A19','I19', Cinza);

        {********************************}
        {* INSERE BORDAS NA CELULA      *}
        {*****************************RL*}
        Bordas('A2','I3');
        Bordas('A4','I19');

        intCol := 9;
        ProximaLinha;

        Negrito('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), True);

        {*********************************************}
        {* CABEÇALHO DA COLUNA 01 E DA ÚLTIMA COLUNA *}
        {******************************************RL*}
        Escrever(LinhaAtual, 01, 'CLIENTE');

        Case intOpcao Of
          6 : Escrever(LinhaAtual, 01, 'PRODUTO');
          7 : Escrever(LinhaAtual, 01, 'CIDADE');
          8 : Escrever(LinhaAtual, 01, 'ATIVIDADE');
          9 : Escrever(LinhaAtual, 01, 'REPRESENTANTE');
          10: Escrever(LinhaAtual, 01, 'FORNECEDOR');
          11: Escrever(LinhaAtual, 01, 'LINHA/GRUPO');
          12: Escrever(LinhaAtual, 01, 'CIDADE');
          13: Escrever(LinhaAtual, 01, 'VENDEDOR');
          14: Escrever(LinhaAtual, 01, 'PRODUTO');
          15: Escrever(LinhaAtual, 01, 'MARCA');
        End;

        {*********************************************}
        {* COLUNA DO TÍTULO                          *}
        {******************************************PZ*}
        Escrever(LinhaAtual, 2, 'VENDAS ANTERIOR');
        Escrever(LinhaAtual, 3, 'VENDAS ATUAL');
        Escrever(LinhaAtual, 4, '% EVOLUÇÃO');
        Escrever(LinhaAtual, 5, '% PERDA');
        Escrever(LinhaAtual, 6, 'MARGEM ANTERIOR');
        Escrever(LinhaAtual, 7, 'MARGEM ATUAL');
        Escrever(LinhaAtual, 8, '% EVOLUÇÃO');
        Escrever(LinhaAtual, 9, '% PERDA');

        {***********************************************************}
        {* CRIA VETORES DINÂMICOS PARA TOTALIZAÇÃO PARCIAL E GERAL *}
        {********************************************************RL*}
        SetLength(arrTotalParc,10);
        SetLength(arrTotal,10);

        {*******************************************}
        {* GERAR OS DADOS NA PLANILHA              *}
        {****************************************RL*}
        With cdsRelatorio Do
        Begin
          First;
          ProximaLinha;

          If (intOpcao <= 3) Or (intOpcao in [6,7,14]) Then
          Begin
            ProximaLinha;
            strGrupo := FieldByName('QUEBRA').AsString;
            Escrever(LinhaAtual, 01, FieldByName('QUEBRA').AsString);
          End;

          If (intOpcao <= 3) Or (intOpcao in [6,7]) Then
            Negrito('A' + IntToStr(LinhaAtual),'A' + IntToStr(LinhaAtual), True);

          ProximaLinha;

          While (Not Eof) Do
          Begin

            Case intOpcao Of
              6    : Escrever(LinhaAtual, 01, FieldByName('CODGRU').AsString + '.' +
                                              FieldByName('CODITE').AsString + '-' +
                                              FieldByName('DESITE').AsString);
              7    : Escrever(LinhaAtual, 01, FieldByName('CODCID').AsString + '-' +
                                              FieldByName('NOMCID').AsString + '-' +
                                              FieldByName('ESTADO').AsString);
              8    : Escrever(LinhaAtual, 01, FieldByName('DESATI').AsString);
              9    : Escrever(LinhaAtual, 01, FieldByName('QUEBRA').AsString);
              10   : Escrever(LinhaAtual, 01, FieldByName('QUEBRA').AsString);
              11   : Escrever(LinhaAtual, 01, FieldByName('QUEBRA').AsString);
              12   : Escrever(LinhaAtual, 01, FieldByName('QUEBRA').AsString);
              13   : Escrever(LinhaAtual, 01, FieldByName('QUEBRA').AsString);
              14   : Escrever(LinhaAtual, 01, FieldByName('CODGRU').AsString + '.' +
                                              FieldByName('CODITE').AsString + '-' +
                                              FieldByName('DESITE').AsString);
              15   : Escrever(LinhaAtual, 01, FieldByName('QUEBRA').AsString);
              Else   Escrever(LinhaAtual, 01, FieldByName('CODCLI').AsString + '-' +
                                              FieldByName('NOMCLI').AsString);
            End;

            {********************************}
            {* ESCREVE OS DADOS NAS LINHAS * }
            {******************************PZ}
            Escrever(LinhaAtual, 2, FloatToStrF(FieldByName('VENANT').AsFloat, ffFixed, 12, 2));
            Escrever(LinhaAtual, 3, FloatToStrF(FieldByName('VENATU').AsFloat, ffFixed, 12, 2));
            Escrever(LinhaAtual, 4, FloatToStrF(FieldByName('EVOVEN').AsFloat, ffFixed, 12, 2));
            Escrever(LinhaAtual, 5, FloatToStrF(FieldByName('PERVEN').AsFloat, ffFixed, 12, 2));
            Escrever(LinhaAtual, 6, FloatToStrF(FieldByName('MRGANT').AsFloat, ffFixed, 12, 2));
            Escrever(LinhaAtual, 7, FloatToStrF(FieldByName('MRGATU').AsFloat, ffFixed, 12, 2));
            Escrever(LinhaAtual, 8, FloatToStrF(FieldByName('EVOMRG').AsFloat, ffFixed, 12, 2));
            Escrever(LinhaAtual, 9, FloatToStrF(FieldByName('PERMRG').AsFloat, ffFixed, 12, 2));

            {*********************************}
            {* TOTALIZA OS VALORES PARCIAIS * }
            {*******************************PZ}
            arrTotalParc[0] := arrTotalParc[0] + FieldByName('VENANT').AsFloat;
            arrTotalParc[1] := arrTotalParc[1] + FieldByName('VENATU').AsFloat;

            arrTotalParc[2] := arrTotalParc[2] + FieldByName('VENANTPORVALOR').AsFloat;
            arrTotalParc[3] := arrTotalParc[3] + FieldByName('VENATUPORVALOR').AsFloat;

            arrTotalParc[8] := arrTotalParc[8] + FieldByName('CUSANT').AsFloat;
            arrTotalParc[9] := arrTotalParc[9] + FieldByName('CUSATU').AsFloat;

            Next;

            {**********************************************}
            {* AGRUPAMENTO POR (REPRESENTANTE, VENDEDOR,  *}
            {* OU CIDADE). QUANDO MUDAR O NOME DO AGRUP., *}
            {* EXECUTA OS PROCEDIMENTOS ABAIXO            *}
            {*******************************************RL*}
            If ((strGrupo <> FieldByName('QUEBRA').AsString) Or (Eof))  Then
            Begin

              If (intOpcao <= 3) Or (intOpcao in [6,7,14]) Then
              Begin
                ProximaLinha;

                {*******************************************************}
                {* CONFIGURA LINHA / COLUNAS PARA TOTALIZAÇÃO PARCIAL  *}
                {*****************************************************PZ}
                Bordas('A'+ IntToStr(LinhaAtual) , 'I' + IntToStr(LinhaAtual));
                Alinhamento('A'+ IntToStr(LinhaAtual) , 'I' + IntToStr(LinhaAtual), Direita);
                Negrito('A'+ IntToStr(LinhaAtual) , 'I' + IntToStr(LinhaAtual), True);
                Escrever(LinhaAtual, 01, 'TOTAL ');

                {*******************************************}
                {* ESCREVE T0TALIZAÇÃO PARCIAL NA LINHA    *}
                {****************************************PZ*}
                Escrever(LinhaAtual, 2, FloatToStrF(arrTotalParc[0], ffFixed, 12, 2));
                Escrever(LinhaAtual, 3, FloatToStrF(arrTotalParc[1], ffFixed, 12, 2));

                {***************************}
                {*HOUVE EVOLUÇÃO NAS VENDAS*}
                {************************PZ*}
                If arrTotalParc[0] <> 0 Then
                Begin
                  If arrTotalParc[1] > arrTotalParc[0] Then
                    arrTotalParc[5] := ((arrTotalParc[1]/arrTotalParc[0])-1)*100
                  Else
                    arrTotalParc[5] := 0;
                End
                Else
                  arrTotalParc[5] := 100;

                {************************}
                {*HOUVE PERDA NAS VENDAS*}
                {*********************PZ*}
                If arrTotalParc[0] <> 0 Then
                Begin
                  If arrTotalParc[1] < arrTotalParc[0] Then
                    arrTotalParc[4] := ((arrTotalParc[1]/arrTotalParc[0])-1) * 100
                  Else
                    arrTotalParc[4] := 0;
                End
                Else
                  arrTotalParc[4] := -100;

                Escrever(LinhaAtual, 4, FloatToStrF(arrTotalParc[5], ffFixed, 12, 2));
                Escrever(LinhaAtual, 5, FloatToStrF(arrTotalParc[4], ffFixed, 12, 2));

                fltMrgAnt := fCalculaPrecoVenda(2,
                                                arrTotalParc[8],
                                                arrTotalParc[2],
                                                0,
                                                0,
                                                0,
                                                0,
                                                0);

                fltMrgAtu := fCalculaPrecoVenda(2,
                                                arrTotalParc[9],
                                                arrTotalParc[3],
                                                0,
                                                0,
                                                0,
                                                0,
                                                0);

                Escrever(LinhaAtual, 6, FloatToStrF(fltMrgAnt, ffFixed, 12, 2));
                Escrever(LinhaAtual, 7, FloatToStrF(fltMrgAtu, ffFixed, 12, 2));

                {****************************}
                {*HOUVE EVOLUÇÃO NAS MARGENS*}
                {*************************PZ*}
                If fltMrgAtu > fltMrgAnt Then
                Begin
                  If fltMrgAnt <> 0 Then
                    arrTotalParc[6] := ((fltMrgAtu / fltMrgAnt)-1) * 100
                  Else
                    arrTotalParc[6] := 100;
                End
                Else
                  arrTotalParc[6] := 0;

                {*************************}
                {*HOUVE PERDA NAS MARGENS*}
                {**********************PZ*}
                If fltMrgAtu < fltMrgAnt Then
                Begin
                  If fltMrgAnt <> 0 Then
                    arrTotalParc[7] := ((fltMrgAtu / fltMrgAnt)-1) * 100
                  Else
                    arrTotalParc[7] := -100;
                End
                Else
                  arrTotalParc[7] := 0;

                Escrever(LinhaAtual, 8, FloatToStrF(arrTotalParc[6], ffFixed, 12, 2));
                Escrever(LinhaAtual, 9, FloatToStrF(arrTotalParc[7], ffFixed, 12, 2));
              End;

              {*******************************************}
              {* TOTALIZANDO OS VALORES GERAL            *}
              {****************************************PZ*}
              arrTotal[0] := arrTotal[0] + arrTotalParc[0];
              arrTotal[1] := arrTotal[1] + arrTotalParc[1];

              arrTotal[2] := arrTotal[2] + arrTotalParc[2];;
              arrTotal[3] := arrTotal[3] + arrTotalParc[3];;

              arrTotal[8] := arrTotal[8] + arrTotalParc[8];
              arrTotal[9] := arrTotal[9] + arrTotalParc[9];

              {*****************************************************}
              {* INCLUINDO ZERO NO TOTAL PARCIAL PARA NÃO ACUMULAR *}
              {**************************************************PZ*}
              arrTotalParc[0] := 0;
              arrTotalParc[1] := 0;
              arrTotalParc[2] := 0;
              arrTotalParc[3] := 0;
              arrTotalParc[4] := 0;
              arrTotalParc[5] := 0;
              arrTotalParc[6] := 0;
              arrTotalParc[7] := 0;
              arrTotalParc[8] := 0;
              arrTotalParc[9] := 0;

              {********************************************************}
              {* CONFIGURA LINHA / COLUNA PARA O PRÓXIMO AGRUPAMENTO  *}
              {*****************************************************RL*}
              If Not Eof Then
              Begin

                If (intOpcao <= 3) Or (intOpcao in [6,7,14]) Then
                Begin
                  ProximaLinha;
                  ProximaLinha;
                  strGrupo := FieldByName('QUEBRA').AsString;
                  Escrever(LinhaAtual, 01, FieldByName('QUEBRA').AsString);
                  Negrito('A' + IntToStr(LinhaAtual),'A' + IntToStr(LinhaAtual), True);
                End;

                ProximaLinha;
              End;

              {****************************************************}
              {* ALINHA AS CÉLULAS DA LINHA E CONTORNA AS CÉLULAS *}
              {*************************************************RL*}
              Bordas('A'+ IntToStr(LinhaAtual) , 'I' + IntToStr(intCol + 2));
              Alinhamento('B'+ IntToStr(LinhaAtual) , 'I' + IntToStr(intCol + 2), Direita);
            End
            Else
            Begin
              ProximaLinha;

              {****************************************************}
              {* ALINHA AS CÉLULAS DA LINHA E CONTORNA AS CÉLULAS *}
              {*************************************************RL*}
              Bordas('A'+ IntToStr(LinhaAtual) , 'I' + IntToStr(intCol + 2));
              Alinhamento('B'+ IntToStr(LinhaAtual) , 'I' + IntToStr(intCol + 2), Direita);
            End;

          End;

          ProximaLinha;

          {*****************************************************}
          {* CONFIGURA LINHA / COLUNAS PARA TOTALIZAÇÃO GERAL  *}
          {**************************************************RL*}
          Bordas('A'+ IntToStr(LinhaAtual) , 'I' + IntToStr(LinhaAtual));
          Alinhamento('A'+ IntToStr(LinhaAtual) , 'I' + IntToStr(LinhaAtual), Direita);
          Negrito('A'+ IntToStr(LinhaAtual) , 'I' + IntToStr(LinhaAtual), True);
          Escrever(LinhaAtual, 01, 'TOTAL GERAL');

          {********************************}
          {* ESCREVE TOTALIZAÇÃO GERAL    *}
          {*****************************PZ*}
          Escrever(LinhaAtual, 2, FloatToStrF(arrTotal[0], ffFixed, 12, 2));
          Escrever(LinhaAtual, 3, FloatToStrF(arrTotal[1], ffFixed, 12, 2));

          {***************************}
          {*HOUVE EVOLUÇÃO NAS VENDAS*}
          {************************PZ*}
          If arrTotal[0] <> 0 Then
          Begin
            If arrTotal[1] > arrTotal[0] Then
              arrTotal[5] := ((arrTotal[1]/arrTotal[0])-1)*100
            Else
              arrTotal[5] := 0;
          End
          Else
            arrTotal[5] := 100;

          {************************}
          {*HOUVE PERDA NAS VENDAS*}
          {*********************PZ*}
          If arrTotal[0] <> 0 Then
          Begin
            If arrTotal[1] < arrTotal[0] Then
              arrTotal[4] := ((arrTotal[1]/arrTotal[0])-1) * 100
            Else
              arrTotal[4] := 0;
          End
          Else
            arrTotal[4] := -100;

          Escrever(LinhaAtual, 4, FloatToStrF(arrTotal[5], ffFixed, 12, 2));
          Escrever(LinhaAtual, 5, FloatToStrF(arrTotal[4], ffFixed, 12, 2));

          fltMrgAnt := fCalculaPrecoVenda(2,
                                          arrTotal[8],
                                          arrTotal[2],
                                          0,
                                          0,
                                          0,
                                          0,
                                          0);

          fltMrgAtu := fCalculaPrecoVenda(2,
                                          arrTotal[9],
                                          arrTotal[3],
                                          0,
                                          0,
                                          0,
                                          0,
                                          0);

          Escrever(LinhaAtual, 6, FloatToStrF(fltMrgAnt, ffFixed, 12, 2));
          Escrever(LinhaAtual, 7, FloatToStrF(fltMrgAtu, ffFixed, 12, 2));

          {****************************}
          {*HOUVE EVOLUÇÃO NAS MARGENS*}
          {*************************PZ*}
          If fltMrgAtu > fltMrgAnt Then
          Begin
            If fltMrgAnt <> 0 Then
              arrTotal[6] := ((fltMrgAtu / fltMrgAnt)-1) * 100
            Else
              arrTotal[6] := 100;
          End
          Else
            arrTotal[6] := 0;

          {*************************}
          {*HOUVE PERDA NAS MARGENS*}
          {**********************PZ*}
          If fltMrgAtu < fltMrgAnt Then
          Begin
            If fltMrgAnt <> 0 Then
              arrTotal[7] := ((fltMrgAtu / fltMrgAnt)-1) * 100
            Else
              arrTotal[7] := -100;
          End
          Else
            arrTotal[7] := 0;

          Escrever(LinhaAtual, 8, FloatToStrF(arrTotal[6], ffFixed, 12, 2));
          Escrever(LinhaAtual, 9, FloatToStrF(arrTotal[7], ffFixed, 12, 2));

        End;

          CongelarPaines('A20');
          AutoAjuste;
          SalvarArquivo;
          FecharArquivo;

          fMensagem('', 'Arquivo gerado com sucesso!', ['&Ok']);
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmRelFatEvolVendasPeriodo.pGeraExcelEvoVendas]');
    End;
  Finally
    FreeAndNil(objExcel);
  End;
end;

procedure TfrmRelFatEvolVendasPeriodo.pVerdeVermelho(edtCodigo: TEditFocus;
  Shape: TShape);
begin
  If (Not blnLiberado) Then
  Begin
    edtCodigo.MaxLength := 10;
    edtCodigo.TamCampo  := 10;
    edtCodigo.CompZeros := False;
    edtCodigo.PasswordChar := '*';
    edtCodigo.TipoTexto := ttAlfanumerico;
    Shape.Brush.Color  := clRed;
  End
  Else
  Begin
    Shape.Brush.Color  := clGreen;
  End;
end;

procedure TfrmRelFatEvolVendasPeriodo.edtDepProdExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtDepProd,edtDepProdDes,arrDepProd,fRetDescDepartamento,nil,'do Depto. do Produto');
end;

procedure TfrmRelFatEvolVendasPeriodo.edtDepProdKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtDepProd, edtDepProdDes, Nil, Key, arrDepProd, False) Then
  Begin
    fValidaCampos(edtDepProd, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatEvolVendasPeriodo.edtDestinoExit(Sender: TObject);
begin
  //inherited;
end;

procedure TfrmRelFatEvolVendasPeriodo.edtOpcaoChange(Sender: TObject);
begin
  inherited;
  if (StrToIntDef(edtOpcao.Text,0) = 4) Or (StrToIntDef(edtOpcao.Text,0) = 5) Then
  Begin
    gpbFiltro.Enabled := True;
    chkCurva.Enabled  := True;
    edtNumCli.Enabled := True;

    chkCurva.Checked := True;
    chkCurvaClick(Sender);
  End
  Else Begin
    gpbFiltro.Enabled := False;
    chkCurva.Enabled  := False;
    edtNumCli.Enabled := False;
    edtNumCli.Clear;

    chkCurva.Checked := False;
    chkCurvaClick(Sender);
  end;
end;

procedure TfrmRelFatEvolVendasPeriodo.chkCurvaClick(Sender: TObject);
begin
  inherited;
  If chkCurva.Checked Then
  Begin
    edtNumCli.Enabled := True;
    edtNumCli.Text    := '9999';
  End
  Else
    edtNumCli.Enabled := False;
end;

procedure TfrmRelFatEvolVendasPeriodo.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmpresa, fRetNomeEmpresa, nil, 'da empresa');
end;

procedure TfrmRelFatEvolVendasPeriodo.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmpresa, False, True) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatEvolVendasPeriodo.edtCodMarcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtCodMarca, edtNomMarca, Nil, Key, arrLinhaMarca, False) Then
  Begin
    If fValidaCampos(edtCodMarca, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatEvolVendasPeriodo.edtCodMarcaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMarca,edtNomMarca,
                    arrLinhaMarca,fRetNomMarca,nil,'da Marca');

end;

end.
