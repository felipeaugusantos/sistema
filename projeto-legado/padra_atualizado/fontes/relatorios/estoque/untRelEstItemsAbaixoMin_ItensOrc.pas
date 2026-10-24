unit untRelEstItemsAbaixoMin_ItensOrc;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, Datasnap.DBClient, UniClientDataSet,
  Datasnap.Provider, UniDataSetProvider, MemDS, DBAccess, Uni, Vcl.ComCtrls,
  Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem,dxCore,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxCurrencyEdit,
  cxTextEdit, Vcl.DBCtrls, DBMemoFocus, cxContainer, cxProgressBar, untCfgGrid, 
  untFatMostraEstoqueEmp, untFatMostraProdSimilar, cxCheckBox, StrUtils;

type
  TTipoSaldoCDGrid = (salNaoLimitadoGrid, salPrecentualGrid, salDiasGrid);

  TfrmRelEstItemsAbaixoMin_ItensOrc = class(TfrmPai)
    pnlHeader: TPanel;
    lblEmpresa: TLabel;
    Panel1: TPanel;
    lblTitTotPes: TLabel;
    lblTitTotNec: TLabel;
    lblTotNec: TLabel;
    lblTotPes: TLabel;
    pnlTail: TPanel;
    Label2: TLabel;
    prbProgesso: TcxProgressBar;
    qryConsulta: TUniQuery;
    dspConsulta: TUniDataSetProvider;
    cdsConsulta: TUniClientDataSet;
    cdsConsultaSUM_PESTOT: TAggregateField;
    cdsConsultaSUM_NECTOT: TAggregateField;
    dtsConsulta: TDataSource;
    cxGrid: TcxGrid;
    cxGridView: TcxGridDBTableView;
    cxColCODITE: TcxGridDBColumn;
    cxColDESITE: TcxGridDBColumn;
    cxColSIGUNI: TcxGridDBColumn;
    cxColSALDCD: TcxGridDBColumn;
    cxColSALDOS: TcxGridDBColumn;
    cxColSALMLG: TcxGridDBColumn;
    cxColESTMIN: TcxGridDBColumn;
    cxColESTMAX: TcxGridDBColumn;
    cxColPESUNT: TcxGridDBColumn;
    cxColEMBALA: TcxGridDBColumn;
    cxColQTDPEN: TcxGridDBColumn;
    cxColNECCOM: TcxGridDBColumn;
    cxColPONEXP: TcxGridDBColumn;
    cxColNUMLOT: TcxGridDBColumn;
    cxColDESMAR: TcxGridDBColumn;
    cxColFORREF: TcxGridDBColumn;
    cxColQTDVEN: TcxGridDBColumn;
    cxColENTFUT: TcxGridDBColumn;
    cxColTEPEND: TcxGridDBColumn;
    cxColQSAI01: TcxGridDBColumn;
    cxColQSAI02: TcxGridDBColumn;
    cxColQSAI03: TcxGridDBColumn;
    cxColQSAI04: TcxGridDBColumn;
    cxColQSAI05: TcxGridDBColumn;
    cxColQSAI06: TcxGridDBColumn;
    cxColQSAI07: TcxGridDBColumn;
    cxColQSAI08: TcxGridDBColumn;
    cxColQSAI09: TcxGridDBColumn;
    cxColQSAI10: TcxGridDBColumn;
    cxColQSAI11: TcxGridDBColumn;
    cxColQSAI12: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    cxColTEMLOT: TcxGridDBColumn;
    cxColCodGru: TcxGridDBColumn;
    cxColCodFor: TcxGridDBColumn;
    cxColMARDES: TcxGridDBColumn;
    cxColLinDes: TcxGridDBColumn;
    cxColCODEMP: TcxGridDBColumn;
    cxColNECORI: TcxGridDBColumn;
    cxColMLTCOM: TcxGridDBColumn;
    pnlAplicacao: TPanel;
    pnlAplica: TPanel;
    mmoAplica: TDBMemoFocus;
    cxColREALCD: TcxGridDBColumn;
    cxcolESTMINCD: TcxGridDBColumn;
    cxcolQTDPEN_GAR: TcxGridDBColumn;
    cxColMEDIA_CD: TcxGridDBColumn;
    cxGridSALFIS: TcxGridDBColumn;
    cxColGIRITE: TcxGridDBColumn;
    cxColLOCFIS: TcxGridDBColumn;
    cxColLOCSUP: TcxGridDBColumn;
    cxcolCODFAB: TcxGridDBColumn;
    cxColNIVGIR: TcxGridDBColumn;
    lblTitPesoBruto: TLabel;
    lblTotPesoBruto: TLabel;
    cdsConsultaSUM_PESTIT: TAggregateField;    
    cxColEXCLUIR: TcxGridDBColumn;
    Panel2: TPanel;
    Label1: TLabel;
    lblQtdReg: TLabel;
    btnGravar: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    btnMarcarDesmarcarExclusao: TBitBtnLocked;
    btnMostraEstoque: TBitBtnLocked;
    btnSimilares: TBitBtnLocked;
    BitBtnLocked1: TBitBtnLocked;
    BitBtnLocked2: TBitBtnLocked;
    cxColFISEMP: TcxGridDBColumn;
    cxColSUPEMP: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsConsultaAfterOpen(DataSet: TDataSet);
    procedure pMarcaDesmarcaExclusao;
    procedure cdsConsultaAfterPost(DataSet: TDataSet);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure cdsConsultaBeforePost(DataSet: TDataSet);
    procedure cdsConsultaAfterDelete(DataSet: TDataSet);
    procedure cxGridViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridViewKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure cxGridViewEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure cxColNECCOMPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnMostraEstoqueClick(Sender: TObject);
    procedure btnSimilaresClick(Sender: TObject);
    procedure BitBtnLocked1Click(Sender: TObject);
    procedure BitBtnLocked2Click(Sender: TObject);
    procedure btnMarcarDesmarcarExclusaoClick(Sender: TObject);
    procedure cxGridViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsConsultaBeforeEdit(DataSet: TDataSet);
    procedure cdsConsultaAfterCancel(DataSet: TDataSet);
  private
    FtipSaldoCD: TTipoSaldoCDGrid;
    cdsSaldos: TUniClientDataSet;
    FstrAliquota: String;
    objCfgGri: TCfgGrid;

    { Private declarations }
    blnMArcaDesmarItem,
    blnMarcaTodos: Boolean;
    blnMarcandoTodos: Boolean;

    FNecComAnterior: Double;
    FMarDesAnterior: String;

    procedure pCalculaRodape;
    procedure LocalizaLote( var Key: Char);
    function fValidouQuantidadeNecessidadeCompra: Boolean;

    procedure pAjustaTipoSaldoCD;

    procedure pMostraEstoqueLojas;

    Function fLocalizaItem(arrCampo: Array Of String): Boolean;
    procedure pHabilitaCampos;
    Function fValidaNeccomSaldis: Boolean;
    procedure PreencherStrComCaracter(var str: String; qtdeCaracter: Integer; caracter: String);
    procedure pDeletarSelecionado;
  public
    FblnMinMaxSeg: Boolean;
    FstrFieldMaxMinSeg: String;
    ArrCamposCfg: TArrCamposCfg;
    ArrCampoBloqueado:  TArrCamposCfg;
    { Public declarations }
    strSQLGen : String;
    strCodEmpCD  : String;
    blnConfirma : Boolean;
    objGeraOr: Pointer;
    blnCalcVendaPorDia: Boolean;
    blnApenasSaldoCDMenorSaldoEmp: Boolean;
    blnNECORIVisible: Boolean;
    strEmpCD: String;
    strEspDoc: String;
    procedure pApagarSemSaldoCD;
    procedure pCarregaArrCampos;
    procedure pApagarSelecionadosParaExclusao;

    procedure pSetaTipoSaldoCD(tipSaldoCD: TTipoSaldoCDGrid; strAliquota: String);

  protected
    procedure pAddListaQuery;
  end;

implementation

uses untFuncoesSimples, untRelGeraOR, untConsultas, Math, untTypesSistema,
     untSalvaConfiguracaoGrid, untFuncoes, untTLog;

{$R *.dfm}

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.pSetaTipoSaldoCD(tipSaldoCD: TTipoSaldoCDGrid; strAliquota: String);
Begin
  FtipSaldoCD  := tipSaldoCD;
  FstrAliquota := strAliquota;
End;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.pAjustaTipoSaldoCD;
begin
  cxColSALDCD.Visible := FtipSaldoCD <> salNaoLimitadoGrid;

  Case FtipSaldoCD Of
    salPrecentualGrid: cxColSALDCD.Caption := FstrAliquota + '% Saldo CD';
    salDiasGrid:       cxColSALDCD.Caption := 'Saldo Limitado CD';
  End;
end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.FormShow(Sender: TObject);
begin
  inherited;

  Try
    TSalvaConfiguracaoGrid.pCarregaConfiguracoesGrid(cxGridView, Self.Name);
    cxColEXCLUIR.Index := 0;
  Except
    { Foi inserido o except vazio porque não foi possivel indentificar
      o motivo de não gravar corretamente,
      dessa forma o usuario ira reclamar pq não grava }
  End;

  pHabilitaCampos;
end;

function TfrmRelEstItemsAbaixoMin_ItensOrc.fValidouQuantidadeNecessidadeCompra: Boolean;
Var
  intRecNo : Integer;
  strMsg: String;
begin
  inherited;

  Result := True;

  intRecNo := cdsConsulta.RecNo;
  cdsConsulta.DisableControls;
  strMsg := '';
  Try
    cdsConsulta.First;
    While (Not cdsConsulta.Eof) Do
    Begin
      If (cdsConsulta.FieldByName('MARDES').AsString = 'M') Then
      Begin
        If (Frac(cdsConsulta.FieldByName('NECCOM').AsFloat) <> 0) And
           fItemNaoFracionavel('VN', cdsConsulta.FieldByName('UNIDAD').AsString) Then
        Begin
          pIncrementaListaStr(cdsConsulta.FieldByName('CODITE').AsString+'-'+
                              cdsConsulta.FieldByName('SIGUNI').AsString+'-'+
                              FormatFloat('#,##0.00', cdsConsulta.FieldByName('NECCOM').AsFloat), strMsg);
        End;
      End;
      cdsConsulta.Next;
    End;
  Finally
    cdsConsulta.RecNo := intRecNo;
    cdsConsulta.EnableControls;
    If Not fEmptyStr(strMsg) Then
    Begin
      Result := False;
      pMensagemOk('Os seguintes itens são de unidades que não permitem valores fracionados: '+#10#13+strMsg);
    End;
  End;
end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.LocalizaLote( var Key: Char);
  var
    qryNumLot : TUniQuery;
    arrSel: TConsultasArray;
begin
  qryNumLot := fCriaQuery;
  Try
    If fPesqLoteItens(Self,
                      Nil,
                      Nil,
                      2,
                      qryNumLot,
                      Key,
                      arrSel,
                      True,
                      cdsConsulta.FieldByName('CODITE').AsString,
                      iif(fEmptyStr(strCodEmpCD), cdsConsulta.FieldByName('CODEMP').AsString, strCodEmpCD),
                      False,
                      True) Then
    Begin
      Key := #0;

      // Encerra o editor inline da grid ANTES de manipular o cds
      If cxGridView.Controller.IsEditing Then
        cxGridView.Controller.EditingController.HideEdit(True);
      If cdsConsulta.State <> dsEdit Then
        cdsConsulta.Edit;

      cdsConsulta.FieldByName('NUMLOT').AsString := qryNumLot.FieldByName('LOT_NUMLOT').AsString;
      cdsConsulta.Post;
    End;
  Finally
    FreeAndNil(qryNumLot);
  End;
end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.btnSairClick(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.btnSimilaresClick(Sender: TObject);
  Var
    strCodFab,
    strCodIte,
    strAutIncSim: String;
    blnEnterSim: Boolean;

begin
  inherited;

  If Not btnSimilares.Visible Then
    Exit;

  If Not fLocalizaItem(['CODITE', 'DESITE', 'CODSIM']) Then
    Exit;

  If Not fVerificaAcessoSistema('CPSIMI', strLoginUsuarioLogado) Then
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok'])
  Else
  Begin
    If Not(TfrmFatMostraProdSimilar.fMostraSimilar(cdsConsulta.FieldByName('CODSIM').AsString,
                                               cdsConsulta.FieldByName('CODITE').AsString,
                                               cdsConsulta.FieldByName('DESITE').AsString,
                                               IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')),
                                               blnEnterSim,
                                               strAutIncSim,
                                               strCodFab,
                                               strCodIte,
                                               True,
                                               False,
                                               False,
                                               False,
                                               '',
                                               '',
                                               0)) Then
      fMensagem('', 'Não há itens similares!', ['&O k']);



  End;
end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.pAddListaQuery;
begin
  With cdsConsulta Do
  Begin
    If FieldByName('MARDES').AsString = 'M' Then
    Begin
      If State <> dsEdit Then
        Edit;

      FieldByName('MARDES').AsString := 'D';
      Post;
    End
    Else
    Begin
      If FieldByName('UNITAR').AsFloat = 0 Then
      Begin
        pMensagemOk('Valor unitário do item igual a zero, não poderá entrar no pedido!');
        Exit;
      End;

      If State <> dsEdit Then
        Edit;

      FieldByName('MARDES').AsString := 'M';
      Post;
    End;
   	cxColNECCOM.FocusWithSelection;
  End;
End;


Function TfrmRelEstItemsAbaixoMin_ItensOrc.fValidaNeccomSaldis: Boolean;
var
  strConfig: string;
  intPosicao: Integer;
  frmLog: TfrmLog;
  tamDescItem: Integer;
  tamCodigoItem: Integer;
  codigoItem, descricaoItem:String;
  cabMensagem, colCodProduto, colDescProduto, linha: String;
begin
  tamDescItem := 105;
  tamCodigoItem := 19;
  Result := True;
  try
    pCriarFormularios(TfrmLog, frmLog);
    frmLog.Caption := 'Atenção.';
    strConfig := fCfgSis(IIF(strEspDoc = 'PD', 'SLDPED', 'SLD_OP'));
    intPosicao := cdsConsulta.RecNo;

    cdsConsulta.First;

    frmLog.pAddLinha('* Nec.Compra maior que Saldo Dispon. CD! Favor verificar os itens abaixo.');

    frmLog.pAddLinha(' ');
    colCodProduto := '* COD. PRODUTO';
    PreencherStrComCaracter(colCodProduto,tamCodigoItem,' ');

    colDescProduto := 'NOME PRODUTO';
    PreencherStrComCaracter(colDescProduto,tamDescItem,' ');

    cabMensagem := colCodProduto+colDescProduto+'SALDO DISPONIVEL';
    frmLog.pAddLinha(cabMensagem);
    linha := '';
    PreencherStrComCaracter(linha,Length(cabMensagem),'-');

    frmLog.pAddLinha(linha);
    While Not cdsConsulta.Eof do
    Begin
      If (AnsiMatchStr(strConfig, ['T', 'A'])) And (cdsConsulta.FieldByName('MARDES').AsString = 'M') And (cdsConsulta.FieldByName('NECCOM').AsFloat > cdsConsulta.FieldByName('REALCD').AsFloat) Then
      Begin
        Result := False;

        codigoItem   := cdsConsulta.FieldByName('CODITE').AsString;
        PreencherStrComCaracter(codigoItem, tamCodigoItem-2,' ');

        descricaoItem:= cdsConsulta.FieldByName('DESITE').AsString;
        PreencherStrComCaracter(descricaoItem, tamDescItem,' ');

        frmLog.pAddLinha('* '+codigoItem+descricaoItem+cdsConsulta.FieldByName('REALCD').AsString);
      End;
      cdsConsulta.Next;
    End;

    if not Result then
      frmLog.ShowModal;

    If (Not Result) And (strConfig = 'A') Then
      Result := fMensagem('','Deseja continuar mesmo assim?',  ['&Sim', '&Não']) = 1;

    If Result Then
      cdsConsulta.RecNo := intPosicao;
  finally
    FreeAndNil(frmLog);
  end
end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.btnGravarClick(
  Sender: TObject);
  Var
    stlLisEmp: TStringList;
    intContador: Integer;
begin
  inherited;

  If (Not fValidouQuantidadeNecessidadeCompra) Then
  Begin
    Exit;
  End;

  If (cdsConsulta.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não há nenhum produto, portanto o orçamento não será gerado!', ['&Ok']);
    Exit;
  End;

  cdsConsulta.DisableControls;

  If Not fValidaNeccomSaldis Then
  Begin
    cdsConsulta.EnableControls;
    Exit;
  End;

  If Not TRelGeraOR(objGeraOr).fChecaItensComLote(cdsConsulta) Then
  Begin
    cdsConsulta.EnableControls;
//    pSetFocus(dbgConsulta);
//    dbgConsulta.Columns[13].Field.FocusControl;
    Exit;
  End;

  cdsConsulta.Filter := 'MARDES = ' + QuotedStr('M');
  cdsConsulta.Filtered := True;

  If cdsConsulta.IsEmpty Then
  Begin
    If fMensagem('','Nenhum item foi selecionado, portanto, o orçamento não será gerado!' + #13#10 + 'Deseja continuar?',  ['&Sim', '&Não']) = 1 Then
    Begin
      blnConfirma := True;
      close;
    End
    Else
    Begin
      cdsConsulta.Filtered := False;
      cdsConsulta.EnableControls;
      Exit;
    End;
  End
  Else
  Begin
    blnConfirma := True;

    cxGrid.Enabled := False;
    pnlBotoes.Enabled   := False;
    btnGravar.Enabled   := False;
    pnlTail.Visible     := True;

    If fEmptyStr(TRelGeraOR(objGeraOr).strEmpresas) Then
    Begin

      If Not TRelGeraOR(objGeraOr).blnQuebraPorGrupoUnidade Then
        TRelGeraOR(objGeraOr).pIncluiPedido(cdsConsulta, '', '', True)
      Else
        TRelGeraOR(objGeraOr).pIncluiPedidoPorGrupoUnidade(cdsConsulta, '', True);

    End Else
    Begin

      stlLisEmp := TStringList.Create;

      stlLisEmp.CommaText := TRelGeraOR(objGeraOr).strEmpresas;

      For intContador := 0 To stlLisEmp.Count -1 Do
      Begin

        If Not TRelGeraOR(objGeraOr).blnQuebraPorGrupoUnidade Then
          TRelGeraOR(objGeraOr).pIncluiPedido(cdsConsulta, '', stlLisEmp[intContador], True)
        Else
          TRelGeraOR(objGeraOr).pIncluiPedidoPorGrupoUnidade(cdsConsulta, stlLisEmp[intContador], True);

      End;

      FreeAndNil(stlLisEmp);

    End;

    pnlTail.Visible     := False;
    btnGravar.Enabled   := True;
    pnlBotoes.Enabled   := True;
    cxGrid.Enabled := True;

    close;
  End;
end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.btnMarcaTodosClick(
  Sender: TObject);
Var
  intRecNo : Integer;
  blnTemZerado,
  blnTemValorUnitarioZerado: Boolean;
  strFilter: string;
begin
  inherited;
  blnMArcaDesmarItem := True;
  blnTemZerado := False;
  blnTemValorUnitarioZerado := False;
  blnMarcaTodos := TRUE;

  intRecNo := cdsConsulta.RecNo;
  cdsConsulta.DisableControls;
  cdsConsulta.AfterPost := nil;
  strFilter := UpperCase(cxGridView.DataController.Filter.FilterText);
  blnMarcandoTodos := True;
  Try
    cdsConsulta.Filtered := False;
    cdsConsulta.Filter := strFilter + IIf(Not fEmptyStr(strFilter),  ' AND ', '' ) + ' MARDES = ' + QuotedStr('D');
    cdsConsulta.Filtered := True;

    If (Not cdsConsulta.IsEmpty) Then
    Begin
      cdsConsulta.First;
      While (Not cdsConsulta.eof) Do
      Begin
         if RoundTo(cdsConsulta.FieldByName('NECCOM').AsFloat, -2) = 0 Then
        Begin
          blnTemZerado := True;
          cdsConsulta.Next;
        End
        Else If cdsConsulta.FieldByName('UNITAR').AsFloat = 0 Then
        Begin
          blnTemValorUnitarioZerado := True;
          cdsConsulta.Next;
        End
        Else
        begin
          cdsConsulta.Edit;
          cdsConsulta.FieldbyName('MARDES').AsString := 'M';
          cdsConsulta.Post;
        End;

      End;

      If blnTemZerado Then
        pMensagemOk('Há itens com a necessidade de compra zerada que não foram marcados!');

      If blnTemValorUnitarioZerado Then
        pMensagemOk('Há itens com o valor unitário zerado que não foram marcados!');

    End;

  Finally
    blnMarcandoTodos := False;
    blnMArcaDesmarItem := False;
    cdsConsulta.Filtered := False;
    cdsConsulta.Filter := '';
    cdsConsulta.EnableControls;
    cdsConsulta.RecNo := intRecNo;
    cdsConsulta.AfterPost := cdsConsultaAfterPost;

    fValidouQuantidadeNecessidadeCompra;

    pCalculaRodape;
  End;
end;

Function TfrmRelEstItemsAbaixoMin_ItensOrc.fLocalizaItem(arrCampo: Array Of String): Boolean;
  Var
    intContador: Integer;
Begin
  Result := True;

  For intContador := Low(arrCampo) To High(arrCampo) Do
    If Not Assigned(cdsConsulta.FindField(arrCampo[intContador])) Then
    Begin
      Result := False;
      Exit;
    End;
End;


procedure TfrmRelEstItemsAbaixoMin_ItensOrc.pMarcaDesmarcaExclusao;
begin
  cdsConsulta.Edit;
  cdsConsulta.FieldByName('EXCLUIR').AsString := IIf(cdsConsulta.FieldByName('EXCLUIR').AsString = 'S', 'N', 'S');
  cdsConsulta.Post;
end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.pMostraEstoqueLojas;
  Var
    frmFatMostraEstoqueEmp : TfrmFatMostraEstoqueEmp;
begin
  Try

    If Not fLocalizaItem(['CODITE', 'DESITE']) Then
      Exit;

    pCriarFormularios(TfrmFatMostraEstoqueEmp, frmFatMostraEstoqueEmp);

    frmFatMostraEstoqueEmp.blnFaturamento := False;
    frmFatMostraEstoqueEmp.strCodIte      := cdsConsulta.FieldByName('CODITE').AsString;
    frmFatMostraEstoqueEmp.strTabPre      := IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD'));
    frmFatMostraEstoqueEmp.edtItem.Text   := cdsConsulta.FieldByName('CODITE').AsString + ' - ' +
                                             cdsConsulta.FieldByName('DESITE').AsString;
    frmFatMostraEstoqueEmp.blnEstrutura   := fItemEstrutura(cdsConsulta.FieldByName('CODITE').AsString);
    frmFatMostraEstoqueEmp.showModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[pMostraEstoqueLojas]');
  End;

  pFreeAndNil(frmFatMostraEstoqueEmp);
end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.PreencherStrComCaracter(
  var str: String; qtdeCaracter: Integer; caracter: String);
var
  i:Integer;
  tamanhoAtual: Integer;
begin
  tamanhoAtual := Length(str);

  for i := 1 to (qtdeCaracter-tamanhoAtual) do
    str := str + caracter;
end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.btnMostraEstoqueClick(
  Sender: TObject);
begin
  inherited;
  If VS_blnTemFil Then
  Begin
    if (not fVerificaAcessoSistema('PVISPF')) then
    begin
      fMensagem('ATENÇÃO','Operador não possui acesso para visualizar informações de saldo de produtos no faturamento.',['&OK']);
      Exit;
    end;

    If Not fVerificaAcessoSistema('CPELOJ', strLoginUsuarioLogado) Then
      fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok'])
    Else
      pMostraEstoqueLojas;
  End;
end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.btnDesmarcaTodosClick(
  Sender: TObject);
Var
  intRecNo: Integer;
    strFilter: string;
begin
  inherited;
  blnMArcaDesmarItem := True;

  blnMarcaTodos := False;
  cdsConsulta.AfterPost := nil;
  intRecNo := cdsConsulta.RecNo;
  cdsConsulta.DisableControls;
  strFilter := UpperCase(cxGridView.DataController.Filter.FilterText);
  Try
    cdsConsulta.Filtered := False;
    cdsConsulta.Filter := strFilter + IIf(Not fEmptyStr(strFilter),  ' AND ', '' ) + ' MARDES = ' + QuotedStr('M');
    cdsConsulta.Filtered := True;
    While Not cdsConsulta.IsEmpty Do
    Begin
      cdsConsulta.Edit;
      cdsConsulta.FieldByName('MARDES').AsString := 'D';
      cdsConsulta.Post;
    End;
  Finally
    cdsConsulta.Filtered := False;
    cdsConsulta.Filter := '';
    cdsConsulta.EnableControls;
    cdsConsulta.RecNo := intRecNo;
    cdsConsulta.AfterPost := cdsConsultaAfterPost;

    pCalculaRodape;
    blnMArcaDesmarItem := FAlse;

  End;
end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.BitBtnLocked1Click(Sender: TObject);
var arrColunasWidth: TColunasWidth;
    i: integer;
begin
  inherited;
  SetLength(arrColunasWidth, cxGridView.ColumnCount);
  for i := 0 To cxGridView.ColumnCount -1 do
  Begin
    arrColunasWidth[i] := cxGridView.Columns[i].Width;
  End;


  objCfgGri := TCfgGrid.Create(Self, cxGridView, 'Relatorio de Itens Abaixo do Minimo - Orcamento', arrColunasWidth, strLoginUsuarioLogado, True, False, ArrCampoBloqueado);
  Try
    objCfgGri.pConfiguraColunas;
    pCarregaArrCampos;
    pHabilitaCampos;
  Finally
    FreeAndNil(objCfgGri);
  End;
end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.BitBtnLocked2Click(Sender: TObject);
begin
  inherited;
  cxgridView.ApplyBestFit();
end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.btnMarcarDesmarcarExclusaoClick(Sender: TObject);
Var
  intRecNo: Integer;
  strFilter: string;
begin
  inherited;

  cdsConsulta.AfterPost := nil;
  intRecNo := cdsConsulta.RecNo;
  cdsConsulta.DisableControls;
  strFilter := UpperCase(cxGridView.DataController.Filter.FilterText);
  Try

    If strFilter <> '' Then
    Begin
      cdsConsulta.Filtered := False;
      cdsConsulta.Filter := strFilter;
      cdsConsulta.Filtered := True;
    End;

    cdsConsulta.First;
    While Not cdsConsulta.Eof Do
    Begin
      cdsConsulta.Edit;
      cdsConsulta.FieldByName('EXCLUIR').AsString := IIf(Pos('DESMARCAR',UpperCase(btnMarcarDesmarcarExclusao.Caption)) > 0, 'N', 'S');
      cdsConsulta.Post;
      cdsConsulta.Next;
    End;

    If strFilter <> '' Then
    Begin
      cdsConsulta.Filtered := False;
      cdsConsulta.Filter := '';
      cdsConsulta.Filtered := True;
    End;

    btnMarcarDesmarcarExclusao.Caption := '[ F11 ] - ' + IIf(Pos('DESMARCAR',UpperCase(btnMarcarDesmarcarExclusao.Caption)) > 0, 'Marcar', 'Desmarcar') + '  todos p/ Exclusão';
  Finally
    cdsConsulta.EnableControls;
    cdsConsulta.RecNo := intRecNo;
    cdsConsulta.AfterPost := cdsConsultaAfterPost;
    pCalculaRodape;
  End;

end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.FormCreate(Sender: TObject);
begin
  inherited;
  blnNECORIVisible := False;
  strEmpCD := '';
  strEspDoc := '';
  blnMarcandoTodos := False;
  cxGridView.DataController.DataSource := dtsConsulta;
  If fCfgSis('EXIAPL', varBoolean) Then
  Begin
    mmoAplica.DataSource := dtsConsulta;
    pnlAplicacao.Visible := True;
  end;
  cdsSaldos := TUniClientDataSet.Create(Nil);

end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
//  Var
//    fltNecAnt: Double;
begin

  Case Key Of
    VK_F5    : pApagarSelecionadosParaExclusao;
    VK_F8    : pApagarSemSaldoCD;
    VK_F6    : btnDesmarcaTodos.Click;
    VK_F7    : btnMarcaTodos.Click;
    VK_F10   : Begin
                 btnGravar.Click;
                 Key := 0;
               End;
    VK_F11    : btnMarcarDesmarcarExclusao.Click;
    VK_RETURN: Begin

                 If cdsConsulta.Active Then
                 Begin

                   If cdsConsulta.State = dsEdit Then
                   Begin

                     cdsConsulta.Post;
                     pCalculaRodape;

                     If (cxColNECCOM.Focused) Then
                     Begin

                       If (cdsConsulta.FieldByName('TEMLOT').AsString = 'S') And
                          (cdsConsulta.FieldByName('NUMLOT').AsString = '') And
                          (cdsConsulta.FieldByName('NECCOM').AsFloat > 0) Then
                         cxColNUMLOT.FocusWithSelection
                       Else
                         cxGridView.Navigator.Buttons.Next.Click;

                     End

                     Else If (cxColNUMLOT.Focused) Then
                     Begin
                       cxColNECCOM.FocusWithSelection;
                       cdsConsulta.Next;
                     End;

                   End Else
                   Begin
                     cxColNECCOM.FocusWithSelection;
                     cdsConsulta.Edit;
                   End;

                 End;
               End;

    VK_F9   :  pMarcaDesmarcaExclusao;
    VK_SPACE:  Begin
                 blnMArcaDesmarItem := True;
                 Try
                   pAddListaQuery;
                 Finally
                   blnMArcaDesmarItem := False;
                 End;
                 Key := 0;
               End;
    Else
      inherited;
  End;

end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.pApagarSemSaldoCD;
begin
  cdsConsulta.DisableControls;
  Try
    Try
      cdsConsulta.Filtered := False;
      cdsConsulta.Filter   := 'SALDCD < 0 OR SALDCD < NECCOM';
      cdsConsulta.Filtered := True;
      If cdsConsulta.IsEmpty Then
        Exit;
      While (Not cdsConsulta.IsEmpty) Do
      Begin
        cdsConsulta.Delete;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmRelEstItemsAbaixoMin_ItensOrc.pApagarSemSaldoCD]');
    End;

  Finally
    cdsConsulta.Filtered := False;
    cdsConsulta.Filter := '';
    cdsConsulta.EnableControls;
    lblQtdReg.Caption := 'Qtd.Reg: ' + IntToStr(cdsConsulta.RecordCount);
    FlwBotoes.Refresh;
  End;
end;

(*
procedure TfrmRelEstItemsAbaixoMin_ItensOrc.pAcertaSaldoDisponivel;
  Var
    blnLimit: Boolean;
Begin
  With cdsConsulta Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      Edit;

      If Not TRelGeraOR(objGeraOr).blnAutoma Then
        FieldByName('NECCOM').AsFloat :=
          TRelGeraOR(objGeraOr).fRetQuantidade(cdsConsulta,
                                               TRelGeraOR(objGeraOr).tpTipoMultiplo,
                                               TRelGeraOR(objGeraOr).blnLimSal,
                                               blnLimit);
      Post;
      Next;
    End;
    EnableControls;
  End;
End;
*)

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.cdsConsultaAfterCancel(
  DataSet: TDataSet);
begin
  inherited;

  FNecComAnterior := 0;
  FMarDesAnterior := '';
end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.cdsConsultaAfterDelete(
  DataSet: TDataSet);
begin
  inherited;

  pCalculaRodape;
end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.cdsConsultaAfterOpen(
  DataSet: TDataSet);
begin
  inherited;
  pSetaClient(DataSet);
//  pAcertaSaldoDisponivel;
end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.cdsConsultaAfterPost(
  DataSet: TDataSet);
begin
  inherited;
  If (Not blnMArcaDesmarItem) And (FblnMinMaxSeg Or (FtipSaldoCD in [salPrecentualGrid, salDiasGrid])) Then
    cdsSaldos.Data := cdsConsulta.Data;

  FNecComAnterior := 0;
  FMarDesAnterior := '';

  pCalculaRodape;
end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  // Só altera Options.Editing quando o editor inline da coluna NÃO está ativo
  If (cxGridView.Controller.EditingController.Edit = nil) Or
     (cxGridView.Controller.FocusedColumn <> cxColNUMLOT) Then
    cxColNUMLOT.Options.Editing := DataSet.FieldByName('TEMLOT').AsString = 'S';
end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.cdsConsultaBeforeEdit(
  DataSet: TDataSet);
begin
  inherited;

  FNecComAnterior := DataSet.FieldByName('NECCOM').AsFloat;
  FMarDesAnterior := DataSet.FieldByName('MARDES').AsString;
end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.cdsConsultaBeforePost(
  DataSet: TDataSet);
begin
  inherited;

  With DataSet Do
  Begin
    If FieldByName('NECCOM').AsFloat < 0 Then
    Begin
      FieldByName('NECCOM').AsFloat := 0;
    End
    Else
    Begin
      FieldByName('NECCOM').AsFloat := RoundTo(FieldByName('NECCOM').AsFloat, -2);

      If (Not blnMarcandoTodos) And (FieldByName('MARDES').AsString = 'M') Then
      Begin
        If (Frac(cdsConsulta.FieldByName('NECCOM').AsFloat) <> 0) And
           fItemNaoFracionavel('VN', cdsConsulta.FieldByName('UNIDAD').AsString) Then
        Begin
          pMensagemOk('Não é permitido informar valor fracionado para esse item!');
        End;
      End;
    End;

    If RoundTo(FieldByName('NECCOM').AsFloat, -2) = 0 Then
      FieldByName('MARDES').AsString := 'D';

    If FieldByName('MARDES').AsString = 'M' Then
    Begin
      FieldByName('PESTOT').AsFloat := (FieldByName('NECCOM').AsFloat * FieldByName('PESUNT').AsFloat);
      FieldByName('NECTOT').AsFloat := FieldByName('NECCOM').AsFloat;
      FieldByName('PESTIT').AsFloat := (FieldByName('NECCOM').AsFloat * FieldByName('PESOIT').AsFloat);
    End Else
    Begin
      FieldByName('PESTOT').AsFloat := 0;
      FieldByName('NECTOT').AsFloat := 0;
      FieldByName('PESTIT').AsFloat := 0;
    End;

    If (Not fEmptyStr(FieldByName('NUMLOT').AsString)) And
       (Not fExisteLote(FieldByName('NUMLOT').AsString,
                        FieldByName('CODITE').AsString,
                        strCodEmpCD,
                        True)) Then
    Begin
      pMensagemOk('Lote ' + FieldByName('NUMLOT').AsString + ' não encontrado ou inativo para o item ' + FieldByName('CODITE').AsString + '!');
      Abort;
    End;

    // Defesa em profundidade: bloqueia caminhos alternativos de Post
    If (FieldByName('MARDES').AsString = 'M') And
       (FieldByName('NECCOM').AsFloat > 0) And
       (Not blnMarcandoTodos) And
       ((FMarDesAnterior <> 'M') Or
        (RoundTo(FieldByName('NECCOM').AsFloat, -2) > RoundTo(FNecComAnterior, -2))) Then
    Begin
      If FblnMinMaxSeg And (FieldByName(FstrFieldMaxMinSeg).AsFloat > 0) And
         ((FieldByName('REALCD').AsFloat - FieldByName('NECCOM').AsFloat) < FieldByName(FstrFieldMaxMinSeg).AsFloat) Then
      Begin
        pMensagemOk('Quantidade deixará o saldo do CD abaixo do Mínimo.');
        Abort;
      End;

      If (FtipSaldoCD in [salPrecentualGrid, salDiasGrid]) And
         (FieldByName('NECCOM').AsFloat > FieldByName('SALDCD').AsFloat) Then
      Begin
        pMensagemOk('Quantidade excede o disponível no CD.');
        Abort;
      End;
    End;
  End;
end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.pCalculaRodape;
Begin
  lblTotPes.Caption := FormatFloat('#,##0.000', fDoubleAggregate(cdsConsulta, 'SUM_PESTOT'));
  lblTotNec.Caption := FormatFloat('#,##0.00',  fDoubleAggregate(cdsConsulta, 'SUM_NECTOT'));
  lblTotPesoBruto.Caption := FormatFloat('#,##0.00',  fDoubleAggregate(cdsConsulta, 'SUM_PESTIT'));
End;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.pCarregaArrCampos;
var
  i : integer;
begin
  SetLength(ArrCamposCfg, 0);
  If Assigned(Self) Then
  begin

    for i := 0 to Self.cxGridView.ColumnCount -1 do
    Begin
      if Self.cxGridView.Columns[i] is TcxGridDBColumn then
      begin
        SetLength(ArrCamposCfg, Length(ArrCamposCfg) + 1);
        ArrCamposCfg[i].ComponentName := TcxGridDBColumn(Self.cxGridView.Columns[i]).Name;
        ArrCamposCfg[i].Visible       := TcxGridDBColumn(Self.cxGridView.Columns[i]).Visible;
        ArrCamposCfg[i].Width         := TcxGridDBColumn(Self.cxGridView.Columns[i]).Width;
      End;
    End;
  End;
end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.pDeletarSelecionado;
begin
  If cdsConsulta.State in dsEditModes Then
    cdsConsulta.Post;

  If cdsConsulta.IsEmpty Then
    Exit;

  If cxGridView.Controller.SelectedRowCount <> 1 then
    Exit;

  If fMensagem('','Deseja excluir o produto ' + cdsConsulta.FieldByName('CODITE').AsString +
                  '-' +cdsConsulta.FieldByName('DESITE').AsString + '?',  ['&Sim', '&Não']) = 1 Then
  Begin
    Try
      Try
        cdsConsulta.Delete;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TfrmRelEstItemsAbaixoMin_ItensOrc.pDeletarSelecionado]');
      End;
    Finally
      FlwBotoes.Refresh;
    End;
  End;
end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.pHabilitaCampos;
var i: integer;
  Columns: TArray<TcxGridDBColumn>;
  Column: TcxGridDBColumn;
  SortIndex: Integer;

  arrColunasWidth: TColunasWidth;

  procedure pPreparaGridGiro(strField: String; Coluna: TcxGridDBColumn);
  Begin
    If Assigned(cdsConsulta.FindField(strField)) Then
    Begin
      Coluna.Visible := True;
      Coluna.Caption := TRelGeraOR(objGeraOr).objListaMesesVenda[i].MesAno;
      TFloatField(cdsConsulta.Fieldbyname(strField)).DisplayFormat := '#,##0.000';
    End;
  End;
begin
  TFloatField(cdsConsulta.Fieldbyname('NECCOM')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.Fieldbyname('PESUNT')).DisplayFormat := '#,##0.000';

  If Assigned(cdsConsulta.FindField('REALCD')) Then
    TFloatField(cdsConsulta.Fieldbyname('REALCD')).DisplayFormat := '#,##0.00'
  Else
    cxcolREALCD.Visible := False;
  TFloatField(cdsConsulta.Fieldbyname('SALDCD')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.Fieldbyname('SALDOS')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.Fieldbyname('SALMLG')).DisplayFormat := '#,##0.000';
  TFloatField(cdsConsulta.Fieldbyname('QTDPEN')).DisplayFormat := '#,##0.00';

  If Assigned(cdsConsulta.FindField('QTDPEN_GAR')) Then
    TFloatField(cdsConsulta.Fieldbyname('QTDPEN_GAR')).DisplayFormat := '#,##0.00'
  Else
    cxcolQTDPEN_GAR.Visible := False;

  TFloatField(cdsConsulta.Fieldbyname('ESTMIN')).DisplayFormat := '#,##0.000';
  TFloatField(cdsConsulta.Fieldbyname('ESTMAX')).DisplayFormat := '#,##0.000';

  If Assigned(cdsConsulta.FindField('ENTFUT')) Then
    TFloatField(cdsConsulta.Fieldbyname('ENTFUT')).DisplayFormat := '#,##0.000'
  Else
    cxColENTFUT.Visible := False;

  If Assigned(cdsConsulta.FindField('TEPEND')) Then
    TFloatField(cdsConsulta.Fieldbyname('TEPEND')).DisplayFormat := '#,##0.000'
  Else
    cxColTEPEND.Visible := False;

  If (TRelGeraOR(objGeraOr).blnQtdVen) Then
  Begin
    TFloatField(cdsConsulta.Fieldbyname('QTDVEN')).DisplayFormat := '#,##0.000';
    cxColQTDVEN.Visible := True;
  End
  Else
    cxColQTDVEN.Visible := False;

  If (Assigned(cdsConsulta)) And (cdsConsulta.Active) Then
    lblQtdReg.Caption := 'Qtd.Reg: ' + IntToStr(cdsConsulta.RecordCount);

  cxColQSAI01.Visible := False;
  cxColQSAI02.Visible := False;
  cxColQSAI03.Visible := False;
  cxColQSAI04.Visible := False;
  cxColQSAI05.Visible := False;
  cxColQSAI06.Visible := False;
  cxColQSAI07.Visible := False;
  cxColQSAI08.Visible := False;
  cxColQSAI09.Visible := False;
  cxColQSAI10.Visible := False;
  cxColQSAI11.Visible := False;
  cxColQSAI12.Visible := False;

  If Not blnCalcVendaPorDia Then
  Begin
    For i := 0 To Length(TRelGeraOR(objGeraOr).objListaMesesVenda) -1 do
    begin
      case i of
        0 : pPreparaGridGiro('QSAI01', cxColQSAI01);
        1 : pPreparaGridGiro('QSAI02', cxColQSAI02);
        2 : pPreparaGridGiro('QSAI03', cxColQSAI03);
        3 : pPreparaGridGiro('QSAI04', cxColQSAI04);
        4 : pPreparaGridGiro('QSAI05', cxColQSAI05);
        5 : pPreparaGridGiro('QSAI06', cxColQSAI06);
        6 : pPreparaGridGiro('QSAI07', cxColQSAI07);
        7 : pPreparaGridGiro('QSAI08', cxColQSAI08);
        8 : pPreparaGridGiro('QSAI09', cxColQSAI09);
        9 : pPreparaGridGiro('QSAI10', cxColQSAI10);
        10: pPreparaGridGiro('QSAI11', cxColQSAI11);
        11: pPreparaGridGiro('QSAI12', cxColQSAI12);
      End;
    End;
  End;

  cxColCodGru.GroupIndex := -1;
  cxColCodFor.GroupIndex := -1;
  cxColLinDes.GroupIndex := -1;

  If TRelGeraOR(objGeraOr).strQuebra <> '' Then
  Begin
    If TRelGeraOR(objGeraOr).strQuebra = 'CODGRU' Then
    begin
      cxColLinDes.GroupIndex := 0;
      cxColCodGru.GroupIndex := 1;
    End
    Else If TRelGeraOR(objGeraOr).strQuebra = 'CODFOR' Then
      cxColCodFor.GroupIndex := 0;

    cdsConsulta.First;
    cxGridView.ViewData.Expand(True);
  End;

  cxGridView.DataController.ClearSorting(false);
  case TRelGeraOR(objGeraOr).tipOrdem of
    toDescricao: Columns := [cxColDESITE, cxColCODITE, cxColCODEMP];
    toGrupo: Columns := [cxColLinDes, cxColCodGru,cxColDESITE, cxColCODITE, cxColCODEMP];
    toFornecedor: Columns := [cxColCodFor,cxColDESITE, cxColCODITE, cxColCODEMP];
    toMarca: Columns :=[cxColDESMAR,cxColDESITE, cxColCODITE, cxColCODEMP];
    toLocalizacao: Columns := [cxColLOCFIS,cxColDESITE, cxColCODITE, cxColCODEMP];
    toGrupoUnidade: Columns := [cxColSIGUNI,cxColLOCFIS,cxColLOCSUP, cxColDESITE, cxColCODITE, cxColCODEMP];
    toUnidade: Columns := [cxColSIGUNI,cxColDESITE, cxColCODITE, cxColCODEMP];
  End;
  SortIndex := 0;
  for Column in Columns do
  begin
    Column.SortIndex := SortIndex;
    Column.SortOrder := TdxSortOrder.soAscending;
    Inc(SortIndex);
  end;


  cxColMEDIA_CD.Visible := Assigned(cdsConsulta.FindField('MEDIA_CD'));

  If fEmptyStr(strCodEmpCD) Then
  Begin
     strCodEmpCD := VS_strCodEmp;
  End;

  pAjustaTipoSaldoCD;
  If (FblnMinMaxSeg) Or (FtipSaldoCD in [salPrecentualGrid, salDiasGrid]) Then
    cdsSaldos.Data := cdsConsulta.Data;


  cxColNECORI.Visible := blnNECORIVisible;


  SetLength(arrColunasWidth, cxGridView.ColumnCount);
  for i := 0 To cxGridView.ColumnCount -1 do
  Begin
    arrColunasWidth[i] := cxGridView.Columns[i].Width;
  End;

  TCfgGrid.pCorrigeVisibilidades(Self, cxGridView, 'Relatorio de Itens Abaixo do Minimo - Orcamento', arrColunasWidth, strLoginUsuarioLogado, True, False, ArrCampoBloqueado);
end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.cxColNECCOMPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  fltTotal, fltDigitado: Double;
begin
  inherited;

  If VarIsNull(DisplayValue) Or (VarToStr(DisplayValue) = '') Then
    Exit;

  fltDigitado := StrToFloatDef(VarToStr(DisplayValue), 0);
  If fltDigitado <= 0 then
    Exit;

  If (Not VarIsNull(FNecComAnterior)) And (RoundTo(fltDigitado,-2) <= RoundTo(Double(FNecComAnterior),-2)) Then
    Exit;

  If Not blnMArcaDesmarItem Then
  Begin
    If FblnMinMaxSeg Or (FtipSaldoCD in [salPrecentualGrid, salDiasGrid]) Then
    Begin
      cdsSaldos.Filtered := False;
      cdsSaldos.Filter := 'CODITE = ' + QuotedStr(cdsConsulta.FieldByName('CODITE').AsString) + ' AND CODEMP <> ' + QuotedStr(cdsConsulta.FieldByName('CODEMP').AsString);
      cdsSaldos.Filtered := True;

      fltTotal := 0;

      If Not cdsSaldos.IsEmpty Then
      Begin

        While not cdsSaldos.Eof Do
        Begin
          If cdsSaldos.FieldByName('NECCOM').AsFloat > 0 Then
            fltTotal := fltTotal + cdsSaldos.FieldByName('NECCOM').AsFloat;
          cdsSaldos.Next;
        End;
      End;

      fltTotal := fltTotal + fltDigitado;

      If (FblnMinMaxSeg And ((cdsConsulta.FieldByName('REALCD').AsFloat - fltTotal)  < cdsConsulta.FieldByName(FstrFieldMaxMinSeg).AsFloat)) Then
      Begin
        If cdsConsulta.FieldByName(FstrFieldMaxMinSeg).AsFloat > 0 Then
        Begin
          DisplayValue := FNecComAnterior;

          pMensagemOk('Quantidade deixará o saldo do CD abaixo do Mínimo.');
          Exit;
        End;
      End
      Else If (FtipSaldoCD in [salPrecentualGrid, salDiasGrid]) And ((fltTotal > cdsConsulta.FieldByName('SALDCD').AsFloat)) Then
      Begin
        DisplayValue := FNecComAnterior;

        pMensagemOk('Quantidade excede o disponível no CD.');
        Exit;
      End;
    End;
  End
end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.cxGridViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If (AViewInfo.Item =  cxColNUMLOT) And
     (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxColTEMLOT.Index] = 'S') Then
  begin
    ACanvas.Font.Color := clWindowText;
    ACanvas.Brush.Color := clYellow;
  End
  Else If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxColMARDES.Index] = 'M') Then
    Begin
      ACanvas.Brush.Color := clAqua;
      ACanvas.Font.Color := clWindowText;
    End;
end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.cxGridViewEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin
  inherited;
  If (cxColNUMLOT.Focused) And fEntraCons(Key) And (cdsConsulta.FieldByName('TEMLOT').AsString = 'S') Then
    LocalizaLote(Key);
end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.cxGridViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_DELETE: pDeletarSelecionado;
  end;
end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.cxGridViewKeyPress(Sender: TObject; var Key: Char);
begin
  If (cxColNUMLOT.Focused) And fEntraCons(Key) And (cdsConsulta.FieldByName('TEMLOT').AsString = 'S') Then
  Begin
    LocalizaLote(Key);
  End;
end;

procedure TfrmRelEstItemsAbaixoMin_ItensOrc.FormDestroy(Sender: TObject);
begin
  TSalvaConfiguracaoGrid.pSalvaConfiguracoesGrid(cxGridView, Self.Name);
  FreeAndNil(cdsSaldos);
  inherited;
end;


procedure TfrmRelEstItemsAbaixoMin_ItensOrc.pApagarSelecionadosParaExclusao;
begin
  If cdsConsulta.State in dsEditModes Then
    cdsConsulta.Post;

  If fMensagem('','Tem certeza que deseja excluir os produtos marcados para exclusão?',  ['&Sim', '&Não']) = 1 Then
  Begin
    cdsConsulta.DisableControls;
    Try
      Try
        cdsConsulta.Filtered := False;
        cdsConsulta.Filter   := 'EXCLUIR = ' + QuotedStr('S');
        cdsConsulta.Filtered := True;
        If cdsConsulta.IsEmpty Then
          Exit;
        While (Not cdsConsulta.IsEmpty) Do
        Begin
          cdsConsulta.Delete;
        End;
        btnMarcarDesmarcarExclusao.Caption := '[ F11 ] - Marcar todos p/ Exclusão';
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TfrmRelEstItemsAbaixoMin_ItensOrc.pApagarSelecionadosParaExclusao]');
      End;
    Finally
      cdsConsulta.Filtered := False;
      cdsConsulta.Filter := '';
      cdsConsulta.EnableControls;
      lblQtdReg.Caption := 'Qtd.Reg: ' + IntToStr(cdsConsulta.RecordCount);
      FlwBotoes.Refresh;
    End;
  End;
end;

end.
