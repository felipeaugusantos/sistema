unit untPastaCompraConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, strUtils,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxGridBandedTableView,
  cxGridDBBandedTableView, EditFocus, cxCurrencyEdit, untTypesSistema,
  untFuncoesConsulta, untPastaCompra, untConstantes, untPanelCxPedidoCompra,
  untPnlDadosPedCompra, untImpressaoPedidoCompra, ComboBoxFocus, Vcl.Mask,
  MaskEditFocus;

type
  TfrmPastaCompraConsulta = class(TfrmPaiConfirma)
    Panel1: TPanel;
    cxgComprasLevel1: TcxGridLevel;
    cxgCompras: TcxGrid;
    cxvCompras: TcxGridDBBandedTableView;
    cxvComprasCODFOR: TcxGridDBBandedColumn;
    cxvComprasNOMFOR: TcxGridDBBandedColumn;
    cxvComprasVALCOM: TcxGridDBBandedColumn;
    cxvComprasVALNET: TcxGridDBBandedColumn;
    cxvComprasMEDFIL: TcxGridDBBandedColumn;
    cxvComprasFILMIN: TcxGridDBBandedColumn;
    cxvComprasSKURUP: TcxGridDBBandedColumn;
    cxvComprasSKUPED: TcxGridDBBandedColumn;
    Panel3: TPanel;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    Splitter1: TSplitter;
    btnAnaCompras: TBitBtnLocked;
    cxvComprasDIAEST: TcxGridDBBandedColumn;
    cxvComprasDIAPEN: TcxGridDBBandedColumn;
    cxvComprasRUPTUR: TcxGridDBBandedColumn;
    cxvComprasPEDCOM: TcxGridDBBandedColumn;
    cxvComprasQTDCOM: TcxGridDBBandedColumn;
    cxvComprasPREANT: TcxGridDBBandedColumn;
    cxvComprasLIMPED: TcxGridDBBandedColumn;
    cxvComprasPEDMES: TcxGridDBBandedColumn;
    cxvComprasPASLIM: TcxGridDBBandedColumn;
    Panel4: TPanel;
    Label3: TLabel;
    Shape1: TShape;
    Panel5: TPanel;
    Panel2: TPanel;
    cxgFiliais: TcxGrid;
    cxvFiliais: TcxGridDBTableView;
    cxvFiliaisSIGEMP: TcxGridDBColumn;
    cxvFiliaisCODEMP: TcxGridDBColumn;
    cxvFiliaisVALCOM: TcxGridDBColumn;
    cxvFiliaisNOMEMP: TcxGridDBColumn;
    cxgFiliaisLevel1: TcxGridLevel;
    lblResPadResumo: TLabel;
    btnPedComprasGerados: TBitBtnLocked;
    cmbAgrupador: TComboBoxFocus;
    Label2: TLabel;
    grbFiltros: TGroupBox;
    Label1: TLabel;
    Label14: TLabel;
    Label11: TLabel;
    edtCodCmp: TEditFocus;
    edtDesCmp: TEditFocus;
    edtCodDep: TEditFocus;
    edtDesCodDep: TEditFocus;
    edtMarca: TEditFocus;
    edtDesMarca: TEditFocus;
    Label4: TLabel;
    edtFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    cxvComprasAgrupamento: TcxGridDBBandedColumn;
    cxvComprasFORNEC: TcxGridDBBandedColumn;
    btnExibirTodos: TBitBtnLocked;
    cxvComprasDTAGER: TcxGridDBBandedColumn;
    cxvComprasCONTAT: TcxGridDBBandedColumn;
    cxvComprasVALMIN: TcxGridDBBandedColumn;
    cxvComprasLITRAG: TcxGridDBBandedColumn;
    cxvFiliaisVALMIN: TcxGridDBColumn;
    chkConsProdSobEnc: TCheckBox;
    Label8: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    lblEmpresas: TLabel;
    edtFilEmp: TEditFocus;
    edtDesFilEmp: TEditFocus;
    procedure edtCodCmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnAnaComprasClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lblResPadResumoClick(Sender: TObject);
    procedure cxvComprasCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnPedComprasGeradosClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure cxvComprasTcxGridDBDataControllerTcxDataSummaryDefaultGroupSummaryItems13GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
      var AText: string);
    procedure cxvComprasTcxGridDBDataControllerTcxDataSummaryDefaultGroupSummaryItems10GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
      var AText: string);
    procedure cmbAgrupadorChange(Sender: TObject);
    procedure btnExibirTodosClick(Sender: TObject);
    procedure cxvComprasCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtFilEmpKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    arrCodDep,
    arrLinFor,
    arrLinMar,
    arrComprador,
    arrLinGru: TConsultasArray;
    arrFilEmp: TConsultasArray;
    objPastaCompra: TPastaCompra;
    objImpressaoPedido: TImprimePedidoCompa;
    Function fCarregaDados: Boolean;

  public
    { Public declarations }
    blnRestaurar: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmPastaCompraConsulta: TfrmPastaCompraConsulta;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples,
  untConsultas,
  untPreOrcamentoEdicao,
  untSalvaConfiguracaoGrid, untFuncoesRel, untFuncoesRel2;

procedure TfrmPastaCompraConsulta.btnExibirTodosClick(Sender: TObject);
begin

  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(146, 6736, [],
                        [],
                        [],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmPastaCompraConsulta.btnAnaComprasClick(Sender: TObject);
  Var
    blnRestaurar,
    blnAlterouDados: Boolean;
begin
  inherited;

  If objPastaCompra.IsEmpty Then
    Exit;

  If Not objPastaCompra.fTravaPastaFornecedor(objPastaCompra.FieldByName('CODFOR').AsString) Then
    Exit;

  blnAlterouDados := False;

  Try

    Repeat
      pCriarFormularios(TfrmPreOrcamentoEdicao, frmPreOrcamentoEdicao);
      Try

        frmPreOrcamentoEdicao.strCodMar := edtMarca.Text;
        frmPreOrcamentoEdicao.strCodDep := edtCodDep.Text;

        case cmbAgrupador.ItemIndex of
          1:   frmPreOrcamentoEdicao.strCodMar := objPastaCompra.FieldByName('CAMAGRU').AsString;
          2:   frmPreOrcamentoEdicao.strCodDep := objPastaCompra.FieldByName('CAMAGRU').AsString;
        end;

        frmPreOrcamentoEdicao.strCodFor  := objPastaCompra.FieldByName('CODFOR').AsString;
        frmPreOrcamentoEdicao.strNomFor  := objPastaCompra.FieldByName('NOMFOR').AsString;
        frmPreOrcamentoEdicao.blnConsEnc := objPastaCompra.blnConsiderarProdSobEnc;
        frmPreOrcamentoEdicao.strLinGru  := fStrLocateLinGru(arrLinGru, 'C.ITE_CODGRU');
        frmPreOrcamentoEdicao.strFilEmp  := fStrLocateEmpresa(arrFilEmp,  'PRE_CODEMP');

        frmPreOrcamentoEdicao.lblAgrupador.Caption     := cmbAgrupador.Text;
        frmPreOrcamentoEdicao.lblComprador.Caption     := edtCodCmp.Text + '-' + edtDesCmp.Text;
        frmPreOrcamentoEdicao.lblMarca.Caption         := edtMarca.Text + '-' + edtDesMarca.Text;
        frmPreOrcamentoEdicao.lblFornecedor.Caption    := edtFornecedor.Text + '-' + edtDesFornecedor.Text;
        frmPreOrcamentoEdicao.lblDepartemento.Caption  := edtCodDep.Text +  '-' + edtDesCodDep.Text;
        frmPreOrcamentoEdicao.lblValDescSobEnc.Caption := IIF(chkConsProdSobEnc.Checked, 'Sim', 'Não');
        frmPreOrcamentoEdicao.lblValLinGru.Caption     := mskLinGru.Text + '-' + edtDesGru.Text;
        frmPreOrcamentoEdicao.lblValFilEmp.Caption     := edtFilEmp.Text + '-' + edtDesFilEmp.Text;

        frmPreOrcamentoEdicao.ShowModal;

        blnRestaurar := frmPreOrcamentoEdicao.blnRestaurar;

        blnAlterouDados := frmPreOrcamentoEdicao.blnAlterouDados;

     Finally
        pFreeAndNil(frmPreOrcamentoEdicao);
     End;

    Until Not blnRestaurar;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmPastaCompraConsulta.btnAnaComprasClick');
    End;

  End;

  objPastaCompra.pDestravaPastaFornecedor(objPastaCompra.FieldByName('CODFOR').AsString);

  If blnAlterouDados Then
    fCarregaDados;
end;

procedure TfrmPastaCompraConsulta.btnPedComprasGeradosClick(Sender: TObject);
  Var
    arrSel : TConsultasArray;
    chrKey: Char;

    objfrmPnl: TPanelCxPedCompra;
    strPD: String;
begin

  chrKey    := '/';


  Try
    objfrmPnl := TPanelCxPedCompra.Create(TfrmPnlDadosPedCompra);

    objfrmPnl.prcLista := objImpressaoPedido.pImprimePedido;
    objfrmPnl.FOnBeforeListaSelecaoAdd := objImpressaoPedido.pPodeAdicionarPedido;


    fPesqPedidoCompra(Self, nil, Nil, chrKey, arrSel, strPD, VS_strCodEmp, 0, False, objfrmPnl, STR_LITRO_GALAO)
  Finally
    FreeAndNil(objfrmPnl);
  End;

end;

procedure TfrmPastaCompraConsulta.cmbAgrupadorChange(Sender: TObject);
begin
  inherited;
  If Assigned(cxvCompras.DataController.DataSource) Then
    If Assigned(cxvCompras.DataController.DataSource.DataSet) Then
     If (Not cxvCompras.DataController.DataSource.DataSet.IsEmpty) Then
       fValidaCampos(edtCodDep);
end;

procedure TfrmPastaCompraConsulta.cxvComprasCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;

  btnAnaCompras.Click;
end;

procedure TfrmPastaCompraConsulta.cxvComprasCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvComprasPASLIM.Index]) = '1' Then
    ACanvas.Font.Color := clRed;

end;

procedure TfrmPastaCompraConsulta.cxvComprasTcxGridDBDataControllerTcxDataSummaryDefaultGroupSummaryItems10GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: string);
begin
  inherited;
  If Pos('MAX=', Uppercase(AText)) > 0 Then
    AText :=  AnsiReplaceStr(AText, 'MAX=', '');
end;

procedure TfrmPastaCompraConsulta.cxvComprasTcxGridDBDataControllerTcxDataSummaryDefaultGroupSummaryItems13GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: string);
begin
  inherited;
  If AValue = 0 Then
    AText := '';
  If Pos('MIN=', Uppercase(AText)) > 0 Then
    AText :=  AnsiReplaceStr(AText, 'MIN=', '');


end;

procedure TfrmPastaCompraConsulta.edtCodCmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  if fPesqOperador(Self,
                   edtCodCmp,
                   edtDesCmp,
                   Nil,
                   Key,
                   arrComprador,
                   False, {blnConSim}
                   False, // blnAtivos: Boolean = False;                   {* Somente Operadores Ativos                   *}
                   False, // blnGerentes: Boolean = False;                 {* Somente Operadores Gerentes                 *}
                   False, // blnMecanicos: Boolean = False;                {* Somente Operadores Mecânicos                *}
                   False, // blnVenRepre: Boolean = False;                 {* Somente Vendedor Interno/Representante Externo *}
                   True) Then //blnCompradores
  Begin
    If fValidaCampos(edtCodCmp, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmPastaCompraConsulta.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtDesCodDep, nil, key, arrCodDep, True) Then
  Begin
    if fValidaCampos(edtCodDep, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmPastaCompraConsulta.edtFilEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtFilEmp, edtDesFilEmp, Nil, Key, arrFilEmp, False) Then
  Begin
    If fValidaCampos(edtFilEmp, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmPastaCompraConsulta.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrLinFor, True) Then
  Begin
    If fValidaCampos(edtFornecedor, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmPastaCompraConsulta.edtMarcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrLinMar, True) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmPastaCompraConsulta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If Not blnRestaurar Then
  Begin
    TSalvaConfiguracaoGrid.pSalvaConfiguracoesGrid(cxvFiliais, Self.Name + 'Filiais');
    TSalvaConfiguracaoGrid.pSalvaConfiguracoesGrid(cxvCompras, Self.Name + 'Compras');
  End;

end;

procedure TfrmPastaCompraConsulta.FormCreate(Sender: TObject);
begin
  inherited;

  blnRestaurar := False;

  objPastaCompra := TPastaCompra.Create(Self);
  objImpressaoPedido := TImprimePedidoCompa.Create;

end;

procedure TfrmPastaCompraConsulta.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objImpressaoPedido);
  inherited;
end;

procedure TfrmPastaCompraConsulta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F9 : btnAnaCompras.Click;
    VK_F8 : btnPedComprasGerados.Click;
    VK_F7 : btnExibirTodos.Click;

  End;
end;

procedure TfrmPastaCompraConsulta.FormShow(Sender: TObject);
begin
  inherited;

  TSalvaConfiguracaoGrid.pCarregaConfiguracoesGrid(cxvFiliais, Self.Name + 'Filiais');
  TSalvaConfiguracaoGrid.pCarregaConfiguracoesGrid(cxvCompras, Self.Name + 'Compras');

  chkConsProdSobEnc.Checked := fCfgSis('SUGENC', varBoolean);
end;

Function TfrmPastaCompraConsulta.fCarregaDados: Boolean;
  Var
    strLisCmp: String;
    strFilEmp: String;
Begin
  cxvCompras.DataController.DataSource := Nil;
  cxvFiliais.DataController.DataSource := Nil;

  strLisCmp := fArrCodigosToLista(edtCodCmp.Text, arrComprador);
  strFilEmp := fArrCodigosToLista(edtFilEmp.Text, arrFilEmp);

  case cmbAgrupador.ItemIndex of
   0:   objPastaCompra.TipoAgrupamento := taFornecedor;
   1:   objPastaCompra.TipoAgrupamento := taFornecedorMarca;
   2:   objPastaCompra.TipoAgrupamento := taFornecedorDepartamento;
  end;

  objPastaCompra.blnConsiderarProdSobEnc := chkConsProdSobEnc.Checked;

  Result := objPastaCompra.fCarregaDados(strLisCmp);

  SetLength(arrComprador, 0);
  //SetLength(arrFilEmp, 0);

  cxvCompras.DataController.DataSource := objPastaCompra.dtsSource;
  cxvFiliais.DataController.DataSource := objPastaCompra.objResumoEmpresa.dtsSource;

 
  cxvCompras.NavigatorButtons.First.Click;
End;

function TfrmPastaCompraConsulta.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = edtCodCmp) Then
    Begin

      If Not fEmptyStr(edtCodCmp.Text) Then
      Begin

        If Length(arrComprador) = 0 Then
        Begin
          edtDesCmp.Text := fRetNomeOperador(edtCodCmp.Text);

          If fEmptyStr(edtDesCmp.Text) Then
          Begin
            pMensagemOk('Comprador não encontrado!');
            Result := False;
          End;

          If Result Then
          Begin
            SetLength(arrComprador, 1);
            arrComprador[0].strCodigo := edtCodCmp.Text;
          End;
        End;

      End
      Else
        edtDesCmp.Text := 'TODOS';
    End
    Else If Sender = edtMarca Then
    Begin
      pEdtCodSelectExit(edtMarca, edtDesMarca ,arrLinMar, fRetNomMarca, nil, 'da Marca');
      objPastaCompra.strFiltroMarca:= edtMarca.Text;

    End
    Else If Sender = edtFornecedor Then
    begin
      pEdtCodSelectExit(edtFornecedor, edtDesFornecedor, arrLinFor, fRetNomFornecedor, Nil, 'do Fornecedor');
      objPastaCompra.strFiltroFornecedor := edtFornecedor.Text;
    End
    Else If Sender = edtCodDep Then
    begin
      pEdtCodSelectExit(edtCodDep, edtDesCodDep, arrCodDep, fRetNomDep, nil, 'do Departamento');
      objPastaCompra.strFiltroDepartamento := edtCodDep.Text;

      If Result And blnBuscaPorChave Then
      Begin
        Case cmbAgrupador.ItemIndex of
          0: Begin
              cxvComprasFORNEC.GroupIndex := -1;
              cxvCompras.Bands[1].Width := 0;
            End;
          1,
          2:Begin
              cxvComprasFORNEC.GroupIndex := 0;
              cxvCompras.Bands[1].Width := 100;
            End;
        End;

        Case cmbAgrupador.ItemIndex of
          1:  cxvComprasAgrupamento.Caption := 'Marca';
          2:  cxvComprasAgrupamento.Caption := 'Departamento';
        End;
      End;
    End
    Else If Sender = mskLinGru Then
    Begin
      pEdtCodSelectExit(mskLinGru, edtDesGru, arrLinGru, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6);
      objPastaCompra.arrFiltroLinhaGrupo := arrLinGru;
    End

    Else If Sender = edtFilEmp Then
    Begin
      pEdtCodSelectExit(edtFilEmp, edtDesFilEmp, arrFilEmp, fRetNomeEmpresa, Nil, 'da Empresa', 3);
      objPastaCompra.arrFiltroFilEmpresa := arrFilEmp;

      fCarregaDados;
    End;

  End;
End;

procedure TfrmPastaCompraConsulta.lblResPadResumoClick(Sender: TObject);
begin
  inherited;

  Try

    If fPergunta('A tela será fechada e reaberta, deseja prosseguir?') Then
    Begin
      TSalvaConfiguracaoGrid.pApagaConfiguracoes(Self.Name + 'Filiais');
      TSalvaConfiguracaoGrid.pApagaConfiguracoes(Self.Name + 'Compras');

      blnRestaurar := True;
      Close;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmPastaCompraConsulta.lblResPadResumoClick]');
    End;
  End

end;

procedure TfrmPastaCompraConsulta.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskLinGru, edtDesGru, Nil, Key, arrLinGru, False) Then
  Begin
    If fValidaCampos(mskLinGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

end.
