{***************************}
{* qryConGru -> CADGRU     *}
{* qryConFor -> CADFOR     *}
{* qryConMar -> CADMAR     *}
{************************JB*}
unit untDigGiroEstoque;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, Uni,
  EditFocus, Mask, MaskEditFocus, DateUtils, Menus, QColorLabel, Windows,
  AppEvnts, untFuncoesSimples, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, UniClientDataSet, cxEditRepositoryItems,
  CheckLst, cxContainer, cxGroupBox, cxRadioGroup, BitBtnLockedIncrem,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, untTypesSistema, frxClass,
  frxExportCSVTestabilidade, untMesesGiro, ComboBoxFocus, Datasnap.DBClient,
  untFuncoesPedidoSimples, cxGridCustomPopupMenu, cxGridPopupMenu, cxGridCitel,
  cxGridBandedTableView, cxGridDBBandedTableView, cxCheckBox, cxCurrencyEdit,
  untCalcGirFrame, untCalcGirMesesFrame, cxDataControllerConditionalFormattingRulesManagerDialog,
  dxBarBuiltInMenu, Winapi.Messages, untTEditFocusWithTConsultasArray;

type

  TRadioGroup = class(ExtCtrls.TRadioGroup)
  private
    FBlnMarcarRadioGroup: Boolean;
    FTextoCaption : String;
  protected
    procedure Paint; override;
  private
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
  public
    constructor Create(AOwner: TComponent); override;
    property BlnMarcarRadioGroup: Boolean read FBlnMarcarRadioGroup write FBlnMarcarRadioGroup;
  End;

  TfrmDigGiroEstoque = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    pnlFundo: TPanel;
    cxEditRepository1: TcxEditRepository;
    chkMarDes: TcxEditRepositoryCheckBoxItem;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    popOpSele: TPopupMenu;
    MarcarTodos1: TMenuItem;
    DesmarcarTodos1: TMenuItem;
    InverterSeleo1: TMenuItem;
    N1: TMenuItem;
    cxGridPopupMenu1: TcxGridPopupMenu;
    mmoHelp: TMemo;
    pnlFiltros: TPanel;
    cxGroupBox5: TcxGroupBox;
    lblLinGru: TLabel;
    lblCodFor: TLabel;
    lblCodMar: TLabel;
    lblRefere: TLabel;
    lblCodCmp: TLabel;
    lblPrdGru: TLabel;
    lblCodUni: TLabel;
    lblCodDep: TLabel;
    lblAcoObj: TLabel;
    lblTitDig: TLabel;
    edtDesPrdGru: TEditFocus;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    edtRefere: TEditFocus;
    edtCodCmp: TEditFocus;
    edtNomCmp: TEditFocus;
    edtPrdGru: TEditFocus;
    edtUnidade: TEditFocus;
    edtCodDep: TEditFocus;
    edtDesCodDep: TEditFocus;
    edtAcoObj: TEditFocus;
    rdgLocfis: TRadioGroup;
    rdgSaldos: TRadioGroup;
    edtCodDig: TEditFocus;
    edtNomDig: TEditFocus;
    cxGroupBox3: TcxGroupBox;
    lblOpSele: TLabel;
    cxGrid: TcxGrid;
    cxvEmpresas: TcxGridDBTableView;
    cxvEmpresasCODEMP: TcxGridDBColumn;
    cxvEmpresasDESCRI: TcxGridDBColumn;
    cxvEmpresasMARDES: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    pgcGiro: TPageControl;
    tbsCalSug: TTabSheet;
    tbsCalGir: TTabSheet;
    cxgApresentacao: TcxGroupBox;
    chkCarIte: TCheckBox;
    rdgOrdem: TRadioGroup;
    chkExiApli: TCheckBox;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    chkImpReq: TCheckBox;
    dtsEmpSel: TDataSource;
    cxvEmpresasEMPVIS: TcxGridDBColumn;
    chkSpoTra: TCheckBox;
    lblLocIni: TLabel;
    edtLocIni: TEditFocus;
    lblLocFin: TLabel;
    edtLocFin: TEditFocus;
    rdgSalEmpDes: TRadioGroup;
    lblLocIni2: TLabel;
    lblLocFin2: TLabel;
    lblGruCmp: TLabel;
    edtGruCmp: TEditFocus;
    edtDesGruCmp: TEditFocus;
    lblDesIte: TLabel;
    edtDesIte: TEditFocus;
    lblSitPro: TLabel;
    edtDesSitPro: TEditFocus;
    edtCodSit: TEditFocus;
    lblImpReq: TLabel;
    chkAnalisaITEFOR: TCheckBox;
    chkLimReq: TCheckBox;
    pnlDiasVendas: TPanel;
    Label1: TLabel;
    edtDias: TEditFocus;
    procedure edtDiasExit(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rdgOrdemClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxvEmpresasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskLinGruExit(Sender: TObject);
    procedure lblOpSeleClick(Sender: TObject);
    procedure MarcarTodos1Click(Sender: TObject);
    procedure DesmarcarTodos1Click(Sender: TObject);
    procedure InverterSeleo1Click(Sender: TObject);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtPrdGruExit(Sender: TObject);
    procedure edtPrdGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtUnidadeExit(Sender: TObject);
    procedure edtUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodForEnter(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure edtLocIniKeyPress(Sender: TObject; var Key: Char);
    procedure edtLocFinKeyPress(Sender: TObject; var Key: Char);
    procedure edtGruCmpExit(Sender: TObject);
    procedure edtGruCmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodSitExit(Sender: TObject);
    procedure edtCodSitKeyPress(Sender: TObject; var Key: Char);
    procedure chkImpReqClick(Sender: TObject);
  private
    { Private declarations }

    intQtdOrigens: Integer;

    cdsEmpSel: TUniClientDataSet;
    cdsEmpSubtraiTansf: TUniClientDataSet;

    qryConMar: TUniQuery;
    qryConGru: TUniQuery;
    qryConFor: TUniQuery;
    qryConOpe: TUniQuery;

    strForAnt,
    strPrF_AE: String;

    blnEmpVis,
    blnCadLoc,
    blnBloFil,
    blnCarregandoDados: Boolean;
    function fGetEmpSubtraiPedTransf: String;

    procedure pCarregaFornecedor;

    function fTrataCodCmp: String;
    function fContaSelecaoEmp: Integer;
    function fPegaDataBaseGiro: TDateTime;
    Function fRetEmpresasEmpGir: String;
    Function fRetEmpresasEmpCal: String;

    Procedure pOpcaoSelecao(strOpcao : Char);
    procedure pAtualizaDados;

    procedure pCriaFrameCalculoSugestao;
    procedure pCriaFrameCalculoMeses;

    Procedure pLimpaSelecao;

    Procedure pDestacaFiltrosImpRequisicao;
    function fGetIndex(cbxAbrEmp: TComboBoxFocus): Integer;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pCarregaDigitador;

  public
    { Public declarations }
    recOpcoesGiro: TRecOpcoesGiro;

    fraCalcGirFrame     : TfraCalcGirFrame;
    fraCalcGirMesesFrame: TfraCalcGirMesesFrame;

    nivEstoque: TNivelEstoque;

    strCodGru  : String;
    strCodFor  : String;
    strCodMar  : String;
    strPrdGru  : String;
    strGruCmp  : String;
    strSitPro  : String;
    strUnidade : String;
    strCodDep  : String;
    intDiaVen  : Integer;
    strAcoObj  : String;
    strRefere  : String;
    strDesIte  : String;
    dtaDataBaseGir: TDateTime;
    blnConfirma: Boolean;
    blnAllIte  : Boolean;
    blnAnalisaItefor: Boolean;
    blnArredSug: Boolean;  // Arredonda quantidade de sugestão
    blnConsMCom: Boolean;  // Considera múltiplo de compra
    blnEmbala  : Boolean;  // Converte para embalagem
    blnConsTLoj: Boolean;  // Considera todas as lojas somadas
    intOrdem   : Integer;  // Ordenação: 1-descricao e 2-marca+descricao
    blnConsEMin: Boolean;  // Considera estoque mínimo para sugestão
    blnConsEMax: Boolean;  // Considera estoque máximo para sugestão

    blnAteMax,
    blnPonPed  : Boolean;

    strCodDig  : String;
    strCodCmp  : String;   // Código do Comprador
    strPedMlj  : String;
    strEmpGir  : String;
    strEmpCal  : String;
    strCodTab: String;

    blnCarregandoPedido: Boolean;

    Function fCamposOk: Boolean;
    property strEmpSubtraiPedTransf : String read fGetEmpSubtraiPedTransf;


  end;

var
  frmDigGiroEstoque: TfrmDigGiroEstoque;

implementation

uses untPesqAux, untSalvaDadosGiro,
     untFuncoesConsulta,
     StrUtils, untConsultas, untConstantes, untNotificaAtivacaoTabPreFor;

{$R *.dfm}

{ TfrmCalculoGiro }

function TfrmDigGiroEstoque.fPegaDataBaseGiro: TDateTime;
  var
    intContador: Integer;
begin
  Result := 0;

  With fraCalcGirMesesFrame Do
  If Not blnSolBasGir Then
    Result := VS_Date
  Else
  Begin
    For intContador := 0 To lstBasGir.Items.Count -1 Do
    Begin
      If lstBasGir.Checked[intContador] Then
      Begin
        If FormatDateTime('mm/yyyy', VS_Date) = lstBasGir.Items[intContador] Then
          Result := VS_Date
        Else
          Result := EndOfTheMonth(StrToDate('01/' + lstBasGir.Items[intContador]));
      End;
    End;
  End;

end;

function TfrmDigGiroEstoque.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  var strCodCmp: String;
begin
  Result := True;

  With fraCalcGirFrame, fraCalcGirMesesFrame Do
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodCmp) Then
    Begin
      edtNomCmp.Text := '';
      strCodCmp := '';
      If Self.Visible And edtCodCmp.Visible Then
      Begin
        If fEmptyStr(edtCodCmp.Text) Then
          Result := False
        Else
        Begin
          strCodCmp := fTrataCodCmp;
          If strCodCmp <> '' Then
            edtNomCmp.Text := fRetNomVendRep(fTrataCodCmp);
          Result := Not fEmptyStr(edtNomCmp.Text);
        End;

        If Not Result Then
          pMensagemOk('Senha do comprador inválida!');

        If Result And ((Not fOperadorAtivo(strCodCmp)) Or (Not fVerificaAcessoSistema('frmMenuPedCom', strCodCmp))) Then
        Begin
          If Not fOperadorAtivo(strCodCmp) Then
            pMensagemOk('Comprador inativo!')
          Else
            pMensagemOk('Comprador sem acesso ao pedido de compra!');
          edtNomCmp.Text := '';
          Result := False;
        End;

      End;

    End

    Else If (Sender = edtCodDig) Then
    Begin

      If Self.Visible And edtCodDig.Visible Then
      begin
        If fEmptyStr(edtCodDig.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Digitador deve ser preeenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          pCarregaDigitador;
          If qryConOpe.FieldbyName('OPE_CODOPE').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse digitador não está cadastrado!', ['&O k']);
            Result := False;
          End;
        End;
        If Not Result Then
        begin
          edtCodDig.Text := '';
          edtNomDig.Text := '';
        end

      End;

    End

    Else If (Sender = mskLinGru) Then
    Begin
      pDesmarcaLista(mskLinGru, mskLinGru.ConsultasArray, '',6);
    End

    Else If (Sender = edtCodFor) Then
    Begin
      If fEmptyStr(edtCodFor.Text) Then
      Begin
        edtNomFor.Text := 'TODOS';
      End
      Else
      Begin
        pCarregaFornecedor;


        If (edtCodFor.Text <> '00000000') And  qryConFor.FieldByName('FOR_CODFOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Fornecedor não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else
          If edtCodFor.Text <> '00000000' Then
            pDesmarcaLista(edtCodFor, edtCodFor.ConsultasArray);
      End;

      If Result And (strPrF_AE = 'E') And blnBuscaPorChave Then
        Result := TfrmNotificaAtivacaoTabPreFor.fEscolheTabelaAUtilizar(edtCodFor.Text, strCodTab);
    End

    Else If (Sender = edtCodMar) Then
    Begin
      pDesmarcaLista(edtCodMar, edtCodMar.ConsultasArray);
    End

    Else If (Sender = edtCodDep) Then
    Begin
      pDesmarcaLista(edtCodDep, edtCodDep.ConsultasArray);
    End

    Else If (Sender = edtPrdGru) Then
    Begin
      pDesmarcaLista(edtPrdGru, edtPrdGru.ConsultasArray);
    End

    Else If (Sender = edtGruCmp) Then
    Begin
      pDesmarcaLista(edtGruCmp, edtGruCmp.ConsultasArray);
    End

    Else If (Sender = edtCodSit) Then
    Begin
      pDesmarcaLista(edtCodSit, edtCodSit.ConsultasArray);
    End

    Else If (Sender = edtFilGir) Then
    Begin
      If Pos(edtFilGir.Text,'CST') <= 0  Then
      Begin
        fMensagem('','O campo Relatório deve ser (C)com Giro, (S)em Giro ou (T)odos!',['&O K'],0);
        Result := False;
      End;
    End

    Else If (Sender = edtDiaPre) Then
    Begin

      If edtDiaPre.Enabled Then
      Begin
        If StrToIntDef(edtDiaPre.Text, -1) < 0 Then
        Begin
          pgcGiro.ActivePageIndex := 0;
          pMensagemOk('A quantidade de dias que serão considerados para a previsão dos pedidos de venda deve ser maior ou igual a zero!');
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtUnidade) Then
    Begin
      pDesmarcaLista(edtUnidade,edtUnidade.ConsultasArray);
    End

    Else If (Sender = edtLocIni) Then
    Begin
     edtLocFin.Enabled  := Not fEmptyStr(edtLocIni.Text);
     lblLocFin.Enabled  := Not fEmptyStr(edtLocIni.Text);
     lblLocFin2.Enabled := Not fEmptyStr(edtLocIni.Text);

     If Not edtLocFin.Enabled Then
       edtLocFin.Clear;
    End

    Else If (Sender = cbxAbrEmp) Then
    Begin
      If chkAgrEmp.Checked Then
      Begin

        If cdsEmpSel.Locate('CODEMP', LeftStr(cbxAbrEmp.Text, 3), []) Then
        Begin
          If Self.Visible Then
          begin
            If cdsEmpSel.FieldByName('MARDES').AsString <> 'S' Then
            Begin
              pgcGiro.ActivePageIndex := 0;

              pMensagemOK('A empresa para agrupar a quantidade sugerida não está selecionada para o giro!');
              Result := False;
            End;
          end;

        End;

      End;

    End

    Else If Sender = chkExiApli Then
    begin

      If blnBuscaPorChave Then
      Begin
        blnMudarFoco := False;
        pgcGiro.ActivePageIndex := 1;
      End;

    End

    Else If Sender = edtPerConGer Then
    Begin

      If edtPerConGer.Enabled Then
      Begin

        If fStrToFloat(edtPerConGer.Text) < 0 Then
          edtPerConGer.Text := '0,00';

      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmDigGiroEstoque.InverterSeleo1Click(Sender: TObject);
begin
  inherited;
  pOpcaoSelecao('I');
end;

procedure TfrmDigGiroEstoque.lblOpSeleClick(Sender: TObject);
  Var
    intQtdSel : Integer;
    curPos    : TPoint;
begin
  inherited;
  intQtdSel := fContaSelecaoEmp;

  MarcarTodos1.Enabled    := (intQtdSel < cdsEmpSel.RecordCount);
  DesmarcarTodos1.Enabled := (intQtdSel > 0);

  GetCursorPos(curPos);
  popOpSele.Popup(curPos.X + 2, curPos.Y + 2);
end;

procedure TfrmDigGiroEstoque.MarcarTodos1Click(Sender: TObject);
begin
  inherited;
  pOpcaoSelecao('S');
end;

procedure TfrmDigGiroEstoque.pCarregaFornecedor;
begin
  If Not (edtCodFor.Text = '00000000') Then
  Begin
    pPesquisaCadFor(Nil, qryConFor, edtCodFor.Text);
    With qryConFor Do
    Begin
      edtNomFor.Text := qryConFor.FieldByName('FOR_NOMFOR').AsString;
      chkAnalisaITEFOR.Enabled := Not fEmptyStr(edtCodFor.Text);
      If Not chkAnalisaITEFOR.Enabled Then
        chkAnalisaITEFOR.Checked := False;
    End;
  End;
end;

procedure TfrmDigGiroEstoque.pOpcaoSelecao(strOpcao: Char);
  var
    strBookMark : TBookmark;
begin
  // strOpcao
  // S - Marcar Todos
  // N - Desmarcar Todos
  // I - Inverter Seleção;

  With cdsEmpSel Do
  Begin
    try
      strBookMark := Bookmark;
      DisableControls;
      First;

      While Not Eof Do
      Begin
        Edit;
        Case strOpcao Of
          'S',
          'N' : FieldByName('MARDES').AsString := strOpcao;
          'I' : FieldByName('MARDES').AsString := IIF(FieldByName('MARDES').AsString = 'S', 'N', 'S');
        End;
        Post;
        Next;
      End;

    Finally
      EnableControls;
      cdsEmpSel.Bookmark := strBookMark;
    End;

  End;

end;

procedure TfrmDigGiroEstoque.mskLinGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinGru, edtDesGru, mskLinGru.ConsultasArray, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6);

end;

procedure TfrmDigGiroEstoque.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinGru, edtDesGru, qryConGru, Key, mskLinGru.ConsultasArray, False) Then
  Begin
    If fvalidaCampos(mskLinGru, True) Then
      self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmDigGiroEstoque.edtCodDepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDep, edtDesCodDep, edtCodDep.ConsultasArray, fRetNomDep, nil, 'do Departamento');
end;

procedure TfrmDigGiroEstoque.edtCodDepKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtDesCodDep, nil, key, edtCodDep.ConsultasArray, False) Then
  Begin
    if fValidaCampos(edtCodDep, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDigGiroEstoque.edtCodForEnter(Sender: TObject);
begin
  inherited;

  strForAnt := edtCodFor.Text;
end;

procedure TfrmDigGiroEstoque.edtCodForExit(Sender: TObject);
  Var
    intNivIndex: Integer;
begin
  inherited;

  pEdtCodSelectExit(edtCodFor, edtNomFor, edtCodFor.ConsultasArray, fRetNomFornecedor, Nil, 'do Fornecedor');


  If (Not SameText(strForAnt, edtCodFor.Text)) And (Not fEmptyStr(edtCodFor.Text)) Then
  With fraCalcGirMesesFrame Do
  Begin
    objNiveis.fCarregaNivelFornecedor(edtCodFor.Text, intNivIndex);
    cmbTipNiv.ItemIndex := intNivIndex;

    pAjustaDiaCom;
  End;

  strForAnt := edtCodFor.Text;
  chkAnalisaITEFOR.Enabled := not fEmptyStr(edtCodFor.Text);
  If Not chkAnalisaITEFOR.Enabled Then
    chkAnalisaITEFOR.Checked := False;

end;

procedure TfrmDigGiroEstoque.edtCodForKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, qryConFor, Key, edtCodFor.ConsultasArray, False) Then
  Begin
    If edtNomFor.Text <> '+1' Then
      edtCodFor.Text := qryConFor.FieldByName('FOR_CODFOR').AsString;
    If fValidaCampos(edtCodFor, True) Then
      Self.SelectNext(ActiveControl, True, True);

    pCarregaFornecedor;
  End;

end;

procedure TfrmDigGiroEstoque.edtCodMarExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMar, edtDesMar, edtCodMar.ConsultasArray, fRetNomMarca, nil, 'da Marca');
end;

procedure TfrmDigGiroEstoque.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, edtCodMar.ConsultasArray, False) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmDigGiroEstoque.edtCodSitExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodSit, edtDesSitPro, edtCodSit.ConsultasArray, fRetNomSituacaoProduto, Nil, 'da Situação do Produto');
end;

procedure TfrmDigGiroEstoque.edtCodSitKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqSituacaoProduto(Self, edtCodSit, edtDesSitPro, Nil, Key, edtCodSit.ConsultasArray, False) Then
  Begin
    If fValidaCampos(edtCodSit, True) Then
    Begin
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmDigGiroEstoque.edtDiasExit(Sender: TObject);
begin
  inherited;
  If edtDias.Text = '' Then
    edtDias.Text := '0'
  Else If StrToInt(edtDias.Text) < 0 Then
    edtDias.Text := '0';
end;

procedure TfrmDigGiroEstoque.edtGruCmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtGruCmp, edtDesGruCmp, edtGruCmp.ConsultasArray, Nil, fRetDescGrupoCompra, 'do Grupo de Compra');
end;

procedure TfrmDigGiroEstoque.edtGruCmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {************************************}
  {* NOVA CONSULTA DE GRUPO DE COMPRA *}
  {*********************************RV*}
  If fPesqGrupoCompra(Self, edtGruCmp, edtDesGruCmp, Nil, Key, edtGruCmp.ConsultasArray, False) Then
  Begin
    If fValidaCampos(edtGruCmp, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmDigGiroEstoque.edtLocFinKeyPress(Sender: TObject; var Key: Char);
  Var
    arrLocFin: TConsultasArray;
begin
  inherited;

  If blnCadLoc And fPesqLocFisica(Self, edtLocIni, Nil, Nil, Key, arrLocFin) And
     fValidaCampos(edtLocIni, True) Then
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmDigGiroEstoque.edtLocIniKeyPress(Sender: TObject; var Key: Char);
  Var
    arrLocIni: TConsultasArray;
begin
  inherited;

  If blnCadLoc And fPesqLocFisica(Self, edtLocIni, Nil, Nil, Key, arrLocIni) And
     fValidaCampos(edtLocIni, True) Then
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmDigGiroEstoque.edtPrdGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtPrdGru, edtDesPrdGru, edtPrdGru.ConsultasArray, fRetNomeGrupoProduto, nil, 'do Grupo de Produto');
end;

procedure TfrmDigGiroEstoque.edtPrdGruKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqGrupoProduto(Self, edtPrdGru, edtDesPrdGru, Nil, Key, edtPrdGru.ConsultasArray, False) Then
  Begin
    If fValidaCampos(edtPrdGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmDigGiroEstoque.edtUnidadeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtUnidade,nil,edtUnidade.ConsultasArray,fRetNomUnidade,Nil,'da Unidade');
end;

procedure TfrmDigGiroEstoque.edtUnidadeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqUnidade(Self, edtUnidade, nil, nil, nil, Key, edtUnidade.ConsultasArray, False) Then
  Begin
    If fvalidaCampos(edtUnidade, True) Then
      self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDigGiroEstoque.pCriaFrameCalculoSugestao;
Begin
  fraCalcGirFrame          := TfraCalcGirFrame.Create(Self);
  fraCalcGirFrame.Parent   := tbsCalSug;
  fraCalcGirFrame.Top      := 2;
  fraCalcGirFrame.Left     := 7;
  fraCalcGirFrame.TabOrder := 0;

  fraCalcGirFrame.pCarregaEmpresas;

  cdsEmpSel := fraCalcGirFrame.cdsEmpSel;
  cdsEmpSubtraiTansf := fraCalcGirFrame.cdsEmpSubtraiTansf;

  dtsEmpSel.DataSet := fraCalcGirFrame.cdsEmpSel;

  fraCalcGirFrame.chkPrevisao.Checked := True;
  fraCalcGirFrame.chkDecSalExt.Visible := fCfgSis('ESTEXT', varBoolean);
  If Not fraCalcGirFrame.chkDecSalExt.Visible Then
    fraCalcGirFrame.chkDecSalExt.Checked := False;
  fraCalcGirFrame.chkFalta.Checked    := True;
  fraCalcGirFrame.chkAguarda.Checked  := True;
End;

procedure TfrmDigGiroEstoque.pDestacaFiltrosImpRequisicao;
begin
  rdgLocfis.BlnMarcarRadioGroup    := True;
  rdgSaldos.BlnMarcarRadioGroup    := True;
  rdgSalEmpDes.BlnMarcarRadioGroup := True;

  lblImpReq.Visible     := True;
  lblCodCmp.Font.Color  := clBlue;
  lblLinGru.Font.Color  := clBlue;
  lblCodFor.Font.Color  := clBlue;
  lblCodMar.Font.Color  := clBlue;
  lblPrdGru.Font.Color  := clBlue;
  lblGruCmp.Font.Color  := clBlue;
  lblCodDep.Font.Color  := clBlue;
  lblDesIte.Font.Color  := clBlue;
  lblRefere.Font.Color  := clBlue;
  lblAcoObj.Font.Color  := clBlue;
  lblCodUni.Font.Color  := clBlue;
  lblLocIni.Font.Color  := clBlue;
  lblLocFin.Font.Color  := clBlue;
  lblLocIni2.Font.Color := clBlue;
  lblLocFin2.Font.Color := clBlue;
end;

procedure TfrmDigGiroEstoque.pCriaFrameCalculoMeses;
Begin
  fraCalcGirMesesFrame          := TfraCalcGirMesesFrame.Create(Self);
  fraCalcGirMesesFrame.frmPai   := Self;
  fraCalcGirMesesFrame.Parent   := tbsCalGir;
  fraCalcGirMesesFrame.Top      := 2;
  fraCalcGirMesesFrame.Left     := 7;
  fraCalcGirMesesFrame.TabOrder := 0;

  fraCalcGirMesesFrame.pInicializaDados;
End;

procedure TfrmDigGiroEstoque.FormCreate(Sender: TObject);
begin
  pCriaFrameCalculoSugestao;
  pCriaFrameCalculoMeses;

  inherited;

  edtCodDig.Visible   := False;

  blnCarregandoDados  := False;
  blnCarregandoPedido := False;
  blnConfirma         := False;

  qryConGru := fCriaQuery(Self);
  qryConFor := fCriaQuery(Self);
  qryConMar := fCriaQuery(Self);
  qryConOpe := fCriaQuery(Self);

  blnBloFil := fCfgSis('BLOFIL', VarBoolean);
  blnCadLoc := fCfgSis('CADLOC', varBoolean);
end;

procedure TfrmDigGiroEstoque.btnCancelaClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDigGiroEstoque.btnConfirmaDadosClick(Sender: TObject);
begin
  If fCamposOk Then
    Close;
end;

Function TfrmDigGiroEstoque.fCamposOk: Boolean;
begin
  With fraCalcGirMesesFrame Do
  Begin

    Result := False;

    If Not objNiveis.fValidaDados Then
      Exit;

    If fContaSelecaoEmp = 0 Then
    Begin

      If recOpcoesGiro.opcChamada = chaSpoolTransferencia Then
        fMensagem('','Selecione uma empresa Destino!',['&OK'])
      Else
        fMensagem('','Selecione uma empresa!',['&OK']);

      pSetFocus(cxGrid);
      Exit;
    End;

    If recOpcoesGiro.opcChamada = chaSpoolTransferencia Then
    Begin

      If intQtdOrigens = 0 Then
      Begin
        fMensagem('','Selecione uma empresa Origem!',['&OK']);
        pSetFocus(cxGrid);
       Exit;
      End;

      If (fContaSelecaoEmp = 1) And (intQtdOrigens = 1) Then
      Begin

        If cdsEmpSel.Locate('MARDES', 'S', []) And (cdsEmpSel.FieldByName('EMPVIS').AsString = 'S') Then
        Begin
          fMensagem('','Empresa Origem e Destino iguais!',['&OK']);
          pSetFocus(cxGrid);
          Exit;
        End;

      End;

    End;

    If fraCalcGirFrame.chkConsRequisicao.Checked and chkImpReq.Checked Then
    Begin
      fMensagem('','Para importar a requisição de compra é preciso desmarcar "Considerar Requisição Em Aberto para Sugestão"!',['&O K']);
      Exit;
    End;

    If blnSolBasGir And (fContaSelecaoBaseGiro = 0) Then
    Begin
      fMensagem('','Você deve selecionar um mês de Base para Cálculo do Giro!',['&O K']);
      pSetFocus(lstBasGir);

      If lstBasGir.Items.Count > 0 Then
        lstBasGir.Selected[0] := True;

      Exit;
    End;

    If recOpcoesGiro.strNomFrm = 'frmGerarOrcamentoCompraAuto' Then
    begin
      If Not fraCalcGirFrame.chkAgrEmp.Checked Then
      Begin
        pMensagemOk('Agrupar quantidade sugerida na empresa deve estar marcado!');
        Exit
      End;
    End;


    If fVerificaCampos Then
    Begin
      If chkInfMes.Checked Then
      Begin
        If Not cdsMeses.fValidaMeses(fRetNroMeses) Then
        Begin
          pMensagemOk('Selecione os meses desejados para o giro!');

          If Self.Showing Then
            lblSelMesClick(lblSelMes);
          Exit;
        End;
      End;

      pAtualizaDados;

      Result := True;
    End;

  End;
end;

procedure TfrmDigGiroEstoque.pAtualizaDados;
Begin
  With fraCalcGirMesesFrame Do
  Begin

    Case rdgOpcGir.ItemIndex Of
      0:   recOpcoesGiro.intMesGir := 3;
      1:   recOpcoesGiro.intMesGir := 6;
      Else recOpcoesGiro.intMesGir := 12;
    End;

    dtaDataBaseGir := fPegaDataBaseGiro;

    If chkInfMes.Checked Then
    Begin
      strMeses := cdsMeses.fRetMeses;

      recOpcoesGiro.intMesMos := recOpcoesGiro.intMesGir;
      recOpcoesGiro.blnInfMes := recOpcoesGiro.blnInfMes;
    End Else
    Begin

      If fCfgSis('MESGIR', varInteger) = 1 Then
        recOpcoesGiro.intMesMos := 12
      Else
        recOpcoesGiro.intMesMos := recOpcoesGiro.intMesGir;

      strMeses := cdsMeses.fRetMesesNormais(recOpcoesGiro.intMesMos, dtaDataBaseGir);
    End;

    With recOpcoesGiro, recNivEst Do
    Begin
      Case cmbTipNiv.ItemIndex Of
        1:   nivEstoque := nivGiro;
        2:   nivEstoque := nivCriticidade;
        3:   nivEstoque := nivAmbos;
        4:   nivEstoque := nivGiroFornecedor;
        Else nivEstoque := nivNenhum;
      End;

      objNiveis.pRetNiveis(recNivEst);

      intDiaComGer  := StrToInt(edtDiaComGer_.Text);
      fltPerConGer  := fStrToFloat(edtPerConGer.Text);
    End;

    With fraCalcGirFrame Do
    Begin
      strCodGru := mskLinGru.Text;
      strCodFor := edtCodFor.Text;
      strCodMar := edtCodMar.Text;
      strPrdGru := edtPrdGru.Text;
      strGruCmp := edtGruCmp.Text;
      strSitPro := edtCodSit.Text;
      strUnidade:= edtUnidade.Text;
      strRefere := edtRefere.Text;
      strDesIte := edtDesIte.Text;
      strCodDep := edtCodDep.Text;
      strAcoObj := edtAcoObj.Text;
      intDiaVen := strToInt(edtDias.Text);
      strCodCmp := fTrataCodCmp;
      blnAllIte := chkExibItens.Checked;
      blnArredSug := chkArredQtdeSugest.Checked;
      blnConsMCom := chkMultCompra.Checked;
      blnEmbala   := False;
      If fraCalcGirMesesFrame.chkEmbala.Visible Then
        blnEmbala   := fraCalcGirMesesFrame.chkEmbala.Checked;
      blnConsTLoj := (fContaSelecaoEmp > 1);
      blnConsEMin := chkEstMin.Checked;
      blnConsEMax := chkEstMax.Checked;

      blnAteMax   := chkAteMax.Checked;
      blnPonPed   := chkPonPed.Checked;
      blnAnalisaITEFOR := chkAnalisaITEFOR.Checked;

    End;
    blnConfirma := True;

    strEmpGir   := fRetEmpresasEmpGir;
    strEmpCal   := fRetEmpresasEmpCal;

    pAjustaDiaCom;
  End;
end;

Function TfrmDigGiroEstoque.fRetEmpresasEmpGir: String;
Begin
  Result := '';

  With cdsEmpSel Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin

      If FieldByName('MARDES').AsString = 'S' Then
        Result := Result + QuotedStr(FieldByName('CODEMP').AsString) + ','

      Else If cxvEmpresasEMPVIS.Visible And (FieldByName('EMPVIS').AsString = 'S') Then
        Result := Result + QuotedStr(FieldByName('CODEMP').AsString) + ',';

      Next;
    End;
    EnableControls;
  End;

  Delete(Result, Length(Result), 1);
End;

Function TfrmDigGiroEstoque.fRetEmpresasEmpCal: String;
Begin
  Result := '';

  With cdsEmpSel Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin

      If FieldByName('MARDES').AsString = 'S' Then
        Result := Result + QuotedStr(FieldByName('CODEMP').AsString) + ',';

      Next;
    End;
    EnableControls;
  End;

  Delete(Result, Length(Result), 1);
End;


procedure TfrmDigGiroEstoque.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: Close;
  End;
end;

procedure TfrmDigGiroEstoque.rdgOrdemClick(Sender: TObject);
begin
  inherited;
  intOrdem := rdgOrdem.ItemIndex;
end;

Procedure TfrmDigGiroEstoque.pLimpaSelecao;
Begin
  With cdsEmpSel Do
  Begin
    try
      DisableControls;
      First;

      While Not Eof Do
      Begin
        Edit;
        FieldByName('MARDES').AsString := 'N';
        FieldByName('EMPVIS').AsString := 'N';
        Post;
        Next;
      End;

    Finally
      EnableControls;
    End;

  End;

End;

procedure TfrmDigGiroEstoque.FormShow(Sender: TObject);
  Var
    intIndexTipNiv: Integer;
    objSalvaGiroFixo: TSalvaInterfaceGiro;
begin
  inherited;

  blnEmpVis := fCfgSis('EMPVIS', varBoolean);
  chkAnalisaITEFOR.Enabled := False;
  chkAnalisaITEFOR.Checked := False;

  rdgSalEmpDes.Visible := recOpcoesGiro.opcChamada = chaSpoolTransferencia;
  rdgSaldos.Visible    := recOpcoesGiro.opcChamada <> chaSpoolTransferencia;

  If recOpcoesGiro.opcChamada = chaSpoolTransferencia Then
  Begin
    cxvEmpresasMARDES.Caption := 'Destino';
    cxvEmpresasEMPVIS.Caption := 'Origem';

    If Assigned(recOpcoesGiro.objSalInt) Then
      recOpcoesGiro.objSalInt.blnEmpVis := True;

    blnEmpVis := True;

    pLimpaSelecao;

    lblOpSele.Visible := False;

    fraCalcGirFrame.cdsEmpSel.BeforePost := Nil;
  End;

  fraCalcGirMesesFrame.rdgTipMed.Enabled := fraCalcGirMesesFrame.rdgOpcGir.ItemIndex <> 0;

  fraCalcGirFrame.chkEndere.Visible := (recOpcoesGiro.opcChamada = chaSpoolTransferencia);

  If Not fraCalcGirMesesFrame.rdgTipMed.Enabled Then
    fraCalcGirMesesFrame.rdgTipMed.ItemIndex := 0;

  cxvEmpresasEMPVIS.Visible := blnEmpVis And (strPedMlj = 'S');

  pgcGiro.ActivePageIndex := 0;

  If recOpcoesGiro.opcChamada = chaSpoolTransferencia Then
  Begin
    lblCodCmp.Visible := False;
    edtCodCmp.Visible := False;
    edtNomCmp.Visible := False;

    lblTitDig.Visible := False;
    edtCodDig.Visible := False;
    edtNomDig.Visible := False;
    fraCalcGirFrame.rdgTipCalVenPer.Visible := False;

    pSetFocus(mskLinGru);
  End Else
  Begin

    If fCfgSis('DIGCOT', varBoolean) Then
    Begin
      edtCodCmp.PasswordChar := #0;
      edtCodCmp.MaxLength    := 3;
      edtCodCmp.TamCampo     := 3;
      edtCodCmp.CompZeros    := True;
      lblTitDig.Visible := True;
      edtCodDig.Visible := True;
      edtNomDig.Visible := True;
    End
    Else
    Begin
      lblTitDig.Visible := False;
      edtCodDig.Visible := False;
      edtNomDig.Visible := False;
      edtNomCmp.Width := 248;
    End;

    pSetFocus(edtCodCmp);
  End;

  blnAnalisaITEFOR := chkAnalisaItefor.Checked;
  strPrF_AE := fCfgSis('PRF_AE', varString);

  With fraCalcGirFrame Do
  If strPedMlj = 'N' Then
  Begin
    grbPedMlj.Visible := False;
  End Else
  Begin
    mmoHelp.Visible := False;
  End;



  With fraCalcGirMesesFrame Do
  If blnCarregandoPedido Then
  Begin
    edtFilGir.Text := 'T';
    edtFilGir.Enabled := False;
  End;

  blnCarregandoDados := True;

  fraCalcGirMesesFrame.blnCarregandoDados := True;


  If Assigned(recOpcoesGiro.objSalInt) Then
  Begin
    recOpcoesGiro.objSalInt.blnExibiItens := False;

    recOpcoesGiro.objSalInt.fCarregaDados(recOpcoesGiro.strValKey, Self, recOpcoesGiro.strNomFrm,
                                          IfThen(fEmptyStr(recOpcoesGiro.strValKey), strLoginUsuarioLogado, ''),
                                          False, //blnRecuperandoPedido
                                          fCfgSis('GIRINF', VarBoolean) {blnCarregaTela});

    If fEmptyStr(recOpcoesGiro.strValKey) And blnBloFil Then
    Begin
      objSalvaGiroFixo := TSalvaInterfaceGiro.Create(Nil);

      objSalvaGiroFixo.fCarregaDados(VS_strCodEmp, Self, 'frmConfiguraDadosGiro', '',
                                     False, {blnRecuperandoPedido}
                                     True   {blnCarregaTela});

      If objSalvaGiroFixo.blnEncontrouGiro Then
      Begin
        fraCalcGirFrame.gpbCalculoSugestao.Enabled := False;
        fraCalcGirMesesFrame.gpbCalcGir.Enabled    := False;
      End;

      FreeAndNil(objSalvaGiroFixo);
    End;

  End;

  If recOpcoesGiro.strNomFrm = 'frmGerarOrcamentoCompraAuto' Then
  begin
    fraCalcGirFrame.chkAgrEmp.Checked := True;
    fraCalcGirFrame.grbPedMlj.Visible := True;
    fraCalcGirFrame.cbxAbrEmp.ItemIndex := fGetIndex(fraCalcGirFrame.cbxAbrEmp);
    fraCalcGirFrame.chkAgrEmp.Enabled := False;
    fraCalcGirFrame.cbxAbrEmp.Enabled := False;
  End;

  With fraCalcGirMesesFrame Do
  Begin
    If fContaSelecaoBaseGiro = 0 Then
      lstBasGir.Checked[0] := True;

    If (Not fEmptyStr(edtCodFor.Text)) And objNiveis.fCarregaNivelFornecedor(edtCodFor.Text, intIndexTipNiv, False) Then
      cmbTipNiv.ItemIndex := intIndexTipNiv;
  End;

  edtCodCmp.Clear;
  edtNomCmp.Clear;

  edtCodDig.Clear;
  edtNomDig.Clear;

  blnCarregandoDados := False;
  fraCalcGirMesesFrame.blnCarregandoDados := False;

  cxvEmpresas.NavigatorButtons.First.Click;

  If Not cxvEmpresasEMPVIS.Visible Then
  Begin
    cdsEmpSel.First;

    While Not cdsEmpSel.Eof Do
    Begin
      If cdsEmpSel.FieldByName('MARDES').AsString <> 'S' Then
      Begin
        cdsEmpSel.Edit;
        cdsEmpSel.FieldByName('EMPVIS').AsString := 'N';
        cdsEmpSel.Post;
      End;

      cdsEmpSel.Next;
    End;

    cdsEmpSel.First;
  End;

  With fraCalcGirFrame Do
  If Not grbPedMlj.Visible Then
  Begin
    chkAgrEmp.Checked := False;
  End;

  If SameText(recOpcoesGiro.strNomFrm, 'frmGerarOrcamentoCompraAuto') Then
  With fraCalcGirMesesFrame Do
  Begin
    chkExibItens.Checked    := False;
    chkExibItens.Visible    := False;
    cxgApresentacao.Visible := False;
  End;

  chkSpoTra.Visible := (recOpcoesGiro.opcChamada In [chaPedido]) And (recOpcoesGiro.strPedMlj = 'S') And cxvEmpresasEMPVIS.Visible;
  chkImpReq.Visible := (Not recOpcoesGiro.blnCotacao) And (recOpcoesGiro.opcChamada In [chaPedido]);
  chkLimReq.Visible := (Not recOpcoesGiro.blnCotacao) And (recOpcoesGiro.opcChamada In [chaPedido]);
  pnlDiasVendas.Visible := recOpcoesGiro.blnCotacao;

  If Not chkSpoTra.Visible Then
    chkSpoTra.Checked := False;

  If chkImpReq.Visible then
  Begin
   pDestacaFiltrosImpRequisicao;
  End;

  If recOpcoesGiro.opcChamada = chaSpoolTransferencia Then
  Begin

    With fraCalcGirMesesFrame Do
    Begin
      chkExibItens.Checked    := False;
      chkExibItens.Visible    := True;
      cxgApresentacao.Visible := False;

      chkEmbala.Checked       := False;
      chkEmbala.Visible       := False;

      pnlRodape.Visible       := True;
      grbOpcGir.Visible       := True;
      edtFilGir.Text          := 'C';

      fValidaCampos(edtLocIni, True);
    End;

  End Else
  Begin
    lblLocIni.Visible  := False;
    lblLocIni2.Visible := False;
    edtLocIni.Visible  := False;

    lblLocFin.Visible  := False;
    lblLocFin2.Visible := False;
    edtLocFin.Visible  := False;
  End;

  fraCalcGirMesesFrame.pAjustaDiaCom;
  If Not fEmptyStr(edtCodFor.Text) Then
    chkAnalisaITEFOR.Enabled := True;

  fraCalcGirFrame.pAjustachkPedPenTransferencia;

  fraCalcGirFrame.chkMultCompraClick(Nil);
end;

{*****************************************}
{* RETORNA QUANTIDADE DE REGISTROS SELEC *}
{**************************************AF*}
function TfrmDigGiroEstoque.fContaSelecaoEmp: Integer;
  Var
    strBookMark : TBookmark;
Begin

  Try
    Result := 0;
    cdsEmpSel.DisableControls;
    strBookMark := cdsEmpSel.Bookmark;
    cdsEmpSel.First;

    intQtdOrigens := 0;

    While Not cdsEmpSel.Eof Do
    Begin

      If cdsEmpSel.FieldByName('MARDES').AsString = 'S' Then
        Inc(Result);

      If cdsEmpSel.FieldByName('EMPVIS').AsString = 'S' Then
        Inc(intQtdOrigens);

      cdsEmpSel.Next;
    End;

  Finally
    cdsEmpSel.Bookmark := strBookMark;
    cdsEmpSel.EnableControls;
  End;

End;

function TfrmDigGiroEstoque.fGetEmpSubtraiPedTransf: String;
begin
  Result := fraCalcGirFrame.fRetEmpSel;
end;

function TfrmDigGiroEstoque.fGetIndex(cbxAbrEmp: TComboBoxFocus): Integer;
var i: integer;
begin
  Result := 0;
  For i := 0 To cbxAbrEmp.Items.Count -1 do
  begin
    If Copy(cbxAbrEmp.Items[i], 1, 3) = VS_StrCodEmp Then
      Exit(i);
  End;

end;

procedure TfrmDigGiroEstoque.chkImpReqClick(Sender: TObject);
begin
  inherited;

  If fraCalcGirFrame.chkConsRequisicao.Checked and chkImpReq.Checked Then
  Begin
    fMensagem('','Para importar a requisição de compra é preciso desmarcar "Considerar Requisição Em Aberto para Sugestão"!',['&O K']);
    chkImpReq.Checked := False;
  End;
  chkLimReq.Enabled := chkImpReq.Checked;
  If Not chkLimReq.Enabled Then
    chkLimReq.Checked := False;

end;

procedure TfrmDigGiroEstoque.cxvEmpresasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Return: SelectNext(ActiveControl,True,True);
    VK_Escape: btnSair.Click;
  End;

end;

procedure TfrmDigGiroEstoque.DesmarcarTodos1Click(Sender: TObject);
begin
  inherited;
  pOpcaoSelecao('N');
end;


function TfrmDigGiroEstoque.fTrataCodCmp: String;
begin
  If edtCodDig.Visible Then
    Exit(edtCodCmp.Text)
  Else Exit(fRetCodVendedor(edtCodCmp.Text));
end;

procedure TfrmDigGiroEstoque.pCarregaDigitador;
begin
  strCodDig := '';
  pPesquisaCadOpe(qryConOpe, qryConOpe, edtCodDig.Text, True);
  With qryConOpe Do
  Begin
    strCodDig      := FieldByName('OPE_CODOPE').AsString;
    edtNomDig.Text := FieldByName('OPE_NOMOPE').AsString;
  End;
end;

{ TRadioGroup }

constructor TRadioGroup.Create(AOwner: TComponent);
begin
  inherited;
  FBlnMarcarRadioGroup := False;
end;

procedure TRadioGroup.Paint;
begin
  inherited;
  Self.Canvas.Font        := Self.Font;
  Self.Canvas.Font.Color  := clBlue;
  Self.Canvas.Brush.Color := $00FFE4D5;
  Self.Brush.Color := $00FFE4D5;
end;

procedure TRadioGroup.WMPaint(var Message: TWMPaint);
begin
  inherited;
  If FBlnMarcarRadioGroup And (Self.Font.Color <> clBlue) Then
  Begin
    If Self.Caption <> '' Then
    Begin
      FTextoCaption := Self.Caption;
      Self.Caption := '';
    End;
    Self.Canvas.TextOut(7,-1, FTextoCaption);
  End;
end;

end.
