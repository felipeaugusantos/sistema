unit untConsultaControleDeColeta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxGridBandedTableView,
  cxGridDBBandedTableView, cxCurrencyEdit, EditFocus, Vcl.Mask, MaskEditFocus,
  untTypesSistema, cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, untControleDeColeta, Vcl.DBCtrls,
  DBEditFocus;

type
  TfrmConsultaControleDeColeta = class(TfrmPai)
    Panel1: TPanel;
    cxgColetasLevel1: TcxGridLevel;
    cxgColetas: TcxGrid;
    cxvColetas: TcxGridDBBandedTableView;
    cxvColetasCON_NUMPED: TcxGridDBBandedColumn;
    cxvColetasColumn2: TcxGridDBBandedColumn;
    cxvColetasColumn3: TcxGridDBBandedColumn;
    cxvColetasColumn4: TcxGridDBBandedColumn;
    cxvColetasColumn5: TcxGridDBBandedColumn;
    cxvColetasColumn6: TcxGridDBBandedColumn;
    cxvColetasColumn7: TcxGridDBBandedColumn;
    cxvColetasColumn8: TcxGridDBBandedColumn;
    cxvColetasColumn9: TcxGridDBBandedColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxvColetasColumn10: TcxGridDBBandedColumn;
    cxvColetasColumn11: TcxGridDBBandedColumn;
    cxvColetasColumn12: TcxGridDBBandedColumn;
    cxvColetasColumn13: TcxGridDBBandedColumn;
    cxvColetasColumn14: TcxGridDBBandedColumn;
    cxvColetasColumn15: TcxGridDBBandedColumn;
    cxvColetasColumn16: TcxGridDBBandedColumn;
    cxvColetasColumn17: TcxGridDBBandedColumn;
    cxvColetasColumn18: TcxGridDBBandedColumn;
    cxvColetasColumn19: TcxGridDBBandedColumn;
    cxvColetasColumn20: TcxGridDBBandedColumn;
    cxvColetasColumn21: TcxGridDBBandedColumn;
    cxvColetasColumn22: TcxGridDBBandedColumn;
    cxvColetasColumn23: TcxGridDBBandedColumn;
    cxvColetasColumn24: TcxGridDBBandedColumn;
    cxvColetasColumn26: TcxGridDBBandedColumn;
    cxvColetasColumn27: TcxGridDBBandedColumn;
    Panel2: TPanel;
    rdgStatus: TRadioGroup;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    Label2: TLabel;
    edtCodFor: TEditFocus;
    edtDesFor: TEditFocus;
    Label3: TLabel;
    mskLinGru: TMaskEditFocus;
    edtLinGru: TEditFocus;
    lbl1: TLabel;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    Label1: TLabel;
    edtCodCli: TEditFocus;
    edtDesCli: TEditFocus;
    Label4: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    GroupBox1: TGroupBox;
    rdbEntregaCompra: TRadioButton;
    rdbEntregaVenda: TRadioButton;
    Label6: TLabel;
    btnCarregar: TBitBtnLocked;
    mskDtaFin: TcxDateEdit;
    shpMultSel: TShape;
    cxvColetasColumn25: TcxGridDBBandedColumn;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    dtsConsulta: TDataSource;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    btnEntregaPedVen: TBitBtnLocked;
    btnMarcar: TBitBtnLocked;
    btnCSV: TBitBtnLocked;
    btnBaixar: TBitBtnLocked;
    Label9: TLabel;
    mskDtaIni: TcxDateEdit;
    rdbUltimaAlteracao: TRadioButton;
    btnCancelaBaixa: TBitBtnLocked;
    rdgNaoFiltrar: TRadioButton;
    cxvColetasMarcad: TcxGridDBBandedColumn;
    dbeCodLoc: TDBEditFocus;
    DBEditFocus1: TDBEditFocus;
    DBEditFocus2: TDBEditFocus;
    cxvColetasColumn1: TcxGridDBBandedColumn;
    cxvColetasColumn28: TcxGridDBBandedColumn;
    cxvColetasColumn29: TcxGridDBBandedColumn;
    cxvColetasColumn30: TcxGridDBBandedColumn;
    cxvColetasColumn31: TcxGridDBBandedColumn;
    cxvColetasColumn32: TcxGridDBBandedColumn;
    cxvColetasColumn33: TcxGridDBBandedColumn;
    cxvColetasColumn34: TcxGridDBBandedColumn;
    cxvColetasQTDPENCOL: TcxGridDBBandedColumn;
    cxvColetasCON_QTDCOL: TcxGridDBBandedColumn;
    cxvColetasQTDDIS: TcxGridDBBandedColumn;
    cxvColetasMARCA: TcxGridDBBandedColumn;
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinGruExit(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnCarregarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMarcarClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure cxvColetasCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnEntregaPedVenClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxvColetasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCSVClick(Sender: TObject);
    procedure btnBaixarClick(Sender: TObject);
    procedure btnCancelaBaixaClick(Sender: TObject);
    procedure cxvColetasDataControllerFilterChanged(Sender: TObject);
  private
    { Private declarations }
    arrCodCli : TConsultasArray;
    arrCodFor : TConsultasArray;
    arrCodMar : TConsultasArray;
    arrLinGru : TConsultasArray;
    arrCodIte : TConsultasArray;
    arrCodEmp : TConsultasArray;

    objColeta: TControleDeColeta;

    Function fGetStatus: TStatusColeta;
    Function fGetTipoData: TDataEntrega;

    procedure pAtualizaTela;

    procedure pSalvaColeta;

    procedure OnGetContentFieldExportGridCSV(strField: String; var strConteudo: String);

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean):Boolean;override;
  end;

var
  frmConsultaControleDeColeta: TfrmConsultaControleDeColeta;

implementation

{$R *.dfm}

Uses
  untConsultas,
  untExportaGridCSV,
  untFuncoesSimples,
  untFuncoesConsulta,
  untAlteraControleDeColeta,
  untAlteraEntregaPedidoVenda, untSalvaConfiguracaoGrid;

Function TfrmConsultaControleDeColeta.fGetStatus: TStatusColeta;
Begin
  Case rdgStatus.ItemIndex Of
    0:   Result := stcAbertos;
    1:   Result := stcBaixados;
    Else Result := stcTodos;
  End;
End;

Function TfrmConsultaControleDeColeta.fGetTipoData: TDataEntrega;
Begin
  If rdbEntregaCompra.Checked Then
    Result := denDataEntregaCompra

  Else If rdbEntregaVenda.Checked Then
    Result := denDataEntreaVenda

  Else If rdbUltimaAlteracao.Checked Then
    Result := denDataAlteracao

  Else Result := denSemData;

End;

procedure TfrmConsultaControleDeColeta.btnCancelaBaixaClick(Sender: TObject);
begin
  inherited;

  If fPergunta('Confirma o cancelamento da baixa dos registros marcados?') And
     objColeta.fBaixaColeta(False) Then
  Begin
    If rdgStatus.ItemIndex <> 2 Then
      btnCarregar.Click;

    pMensagemOk('Operação realizada com sucesso!');
  End;

end;

procedure TfrmConsultaControleDeColeta.pSalvaColeta;
Begin
  If objColeta.State = dsEdit Then
  Begin
    objColeta.FieldByName('CON_ULTALT').AsDateTime := VS_Date;
    objColeta.FieldByName('CON_HORALT').AsDateTime := fTime();

    If frmAlteraControleDeColeta.pnlColeta.Visible Then
    Begin
      objColeta.FieldByName('ULTQTDCOL').AsFloat := objColeta.fGetUltimaQuantidadeColetada;
      If objColeta.FieldByName('ULTQTDCOL').AsFloat = 0 Then
        objColeta.FieldByName('ULTQTDCOL').Clear;

      objColeta.FieldByName('QTDCOL').AsFloat := objColeta.cdsBaixaColeta.fRetSoma('TOTCOL');
    End;

    objColeta.Post;
  End;

  If objColeta.fCopiaMarcados Then
  If objColeta.fSalva Then
    btnDesmarcaTodos.Click;
End;

procedure TfrmConsultaControleDeColeta.btnAlterarClick(Sender: TObject);
begin
  inherited;


  If objColeta.IsEmpty Then
    Exit;

  If objColeta.FieldByName('CON_BAIXAD').AsString = 'S' Then
  Begin
    pMensagemOk('Esse registro já está baixado!');
    Exit;
  End;

  Try
    objColeta.pPosicionaPrimeiroMarcado;

    pCriarFormularios(TfrmAlteraControleDeColeta, frmAlteraControleDeColeta);
    frmAlteraControleDeColeta.objColeta := objColeta;
    frmAlteraControleDeColeta.dtsConsulta.DataSet := objColeta;

    objColeta.Edit;

    If frmAlteraControleDeColeta.ShowModal = mrOk Then
    Begin
      pSalvaColeta;
    End Else
    Begin
      objColeta.Cancel;
    End;

    pFreeAndNil(frmAlteraControleDeColeta);
  Except
    On E: Exception Do
    Begin
      If objColeta.State = dsEdit Then
        objColeta.Cancel;

      pMensagensErro(E.Message, 'TfrmConsultaControleDeColeta.btnAlterarClick');
    End;
  End;
end;

procedure TfrmConsultaControleDeColeta.btnBaixarClick(Sender: TObject);
begin
  inherited;

  If fPergunta('Confirma a baixa dos registros marcados?') And
     objColeta.fBaixaColeta(True) Then
  Begin
    If rdgStatus.ItemIndex <> 2 Then
      btnCarregar.Click;

    pMensagemOk('Registros baixados com sucesso!');
  End;

end;

procedure TfrmConsultaControleDeColeta.btnCarregarClick(Sender: TObject);
  Var
    dtaDatIni,
    dtaDatFin: TDate;
begin
  inherited;

  If fEmptyDate(mskDtaIni.Text) Then
    dtaDatIni := 0
  Else
    dtaDatIni := StrToDate(mskDtaIni.Text);

  If fEmptyDate(mskDtaFin.Text) Then
    dtaDatFin := 0
  Else
    dtaDatFin := StrToDate(mskDtaFin.Text);

  If objColeta.fCarregaDados(edtCodEmp.Text,
                             edtCodFor.Text,
                             mskLinGru.Text,
                             edtCodMar.Text,
                             edtCodCli.Text,
                             edtCodIte.Text,
                             arrCodEmp,
                             arrLinGru,
                             arrCodFor,
                             arrCodMar,
                             arrCodCli,
                             arrCodIte,
                             fGetTipoData,
                             dtaDatIni,
                             dtaDatFin,
                             fGetStatus) Then
    cxvColetas.DataController.DataSource := objColeta.dtsSource;

  cxvColetas.NavigatorButtons.First.Click;
end;

procedure TfrmConsultaControleDeColeta.btnCSVClick(Sender: TObject);
  Var
    objExportaCSV: TExportaGridCSV;
begin
  inherited;
  Try

    objExportaCSV := TExportaGridCSV.Create(Self, cxvColetas);

    objExportaCSV.OnGetContentFieldExportGridCSV := OnGetContentFieldExportGridCSV;

    cxvColetas.DataController.DataSource.DataSet.Filtered:= False;
    cxvColetas.DataController.DataSource.DataSet.Filter:= Concat('MARCAD = ', QuotedStr('S'));
    cxvColetas.DataController.DataSource.DataSet.Filtered:= True;

    If cxvColetas.DataController.DataSource.DataSet.IsEmpty Then
    Begin
      cxvColetas.DataController.DataSource.DataSet.Filtered:= False;
      pMensagemOk('Nenhum item marcado!');
      Exit;
    End;
    objExportaCSV.fExporta;

  Finally
    cxvColetas.DataController.DataSource.DataSet.Filtered:= False;
    FreeAndNil(objExportaCSV);
  End;

end;

procedure TfrmConsultaControleDeColeta.pAtualizaTela;
Begin
  cxvColetasCON_NUMPED.Width := cxvColetasCON_NUMPED.Width + 1;
  cxvColetasCON_NUMPED.Width := cxvColetasCON_NUMPED.Width - 1;
End;

procedure TfrmConsultaControleDeColeta.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  objColeta.pMarcaTodos(False);
  pAtualizaTela;
end;

procedure TfrmConsultaControleDeColeta.btnEntregaPedVenClick(Sender: TObject);
begin
  inherited;

  If objColeta.IsEmpty Then
    Exit;

  If fEmptyStr(objColeta.FieldByName('PEDVEN').AsString) Then
  Begin
    pMensagemOk('Essa requisição não possui pedido de venda!');
    Exit;
  End;

  Try
    pCriarFormularios(TfrmAlteraEntregaPedidoVenda, frmAlteraEntregaPedidoVenda);
    frmAlteraEntregaPedidoVenda.dbeENTVEN.DataBinding.DataSource := objColeta.dtsSource;

    objColeta.Edit;
    If frmAlteraEntregaPedidoVenda.ShowModal = mrOk Then
    Begin
      If fEmptyDate(frmAlteraEntregaPedidoVenda.dbeENTVEN.Text) Then
        objColeta.FieldByName('CON_PREFAT').Clear;

      objColeta.Post;
      objColeta.fSalvaDataEntregaPedidoVenda;
    End

    Else objColeta.Cancel;

    pFreeAndNil(frmAlteraEntregaPedidoVenda);
  Except
    On E: Exception Do
    Begin
      If objColeta.State = dsEdit Then
        objColeta.Cancel;
      pMensagensErro(E.Message, 'TfrmConsultaControleDeColeta.btnEntregaPedVenClick');
    End;
  End;

end;

procedure TfrmConsultaControleDeColeta.btnMarcarClick(Sender: TObject);
begin
  inherited;

  objColeta.pMarcaDesmarcaRegistro;
  pAtualizaTela;
end;

procedure TfrmConsultaControleDeColeta.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;

  objColeta.pMarcaTodos(True);
  pAtualizaTela;
end;

procedure TfrmConsultaControleDeColeta.cxvColetasCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvColetasMarcad.Index]) = 'S' Then
  begin
    ACanvas.Font.Color  := clBlack;

    If AViewInfo.Selected Then
      ACanvas.Brush.Color := $0000E1E1
    Else
      ACanvas.Brush.Color := clYellow;
  end
end;

procedure TfrmConsultaControleDeColeta.cxvColetasDataControllerFilterChanged(
  Sender: TObject);
  var
  I: Integer;
  S: string;
begin
  inherited;

  If cxvColetas.ViewData.FilterRow.Focused then
  begin
    for I := 0 to cxvColetas.ColumnCount - 1 do
    begin
      S := VarToStr(cxvColetas.ViewData.FilterRow.Values[I]);
      if (Length(S)> 0) and (S[1] <> '%') then
        cxvColetas.ViewData.FilterRow.Values[I] := '%' + S;
    end;
  end;
//  strFiltro := cxvColetas.DataController.Filter.FilterText;

end;

procedure TfrmConsultaControleDeColeta.cxvColetasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: btnSair.Click;
  End;

end;

procedure TfrmConsultaControleDeColeta.edtCodCliExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodCLi, edtDesCli, arrCodCli, Nil, fRetNomCliente, 'do cliente');
end;

procedure TfrmConsultaControleDeColeta.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, nil, Key, arrCodCli, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmConsultaControleDeColeta.edtCodEmpExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodEmp, edtDesEmp, arrCodEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');

end;

procedure TfrmConsultaControleDeColeta.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrCodEmp, False) Then
  Begin
    If fValidaCampos(edtCodEmp, False) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmConsultaControleDeColeta.edtCodForExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodFor, edtDesFor, arrCodFor, fRetNomFornecedor, Nil, 'do fornecedor');
end;

procedure TfrmConsultaControleDeColeta.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtDesFor, Nil, Key, arrCodFor, False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmConsultaControleDeColeta.edtCodIteExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodIte, edtDesIte, arrCodIte, Nil, fRetNomProduto, 'do produto');
end;

procedure TfrmConsultaControleDeColeta.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, Nil, Key, arrCodite, False, nil, 'Consulta de Itens', '1') then
  Begin
    If fValidaCampos(edtCodIte, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmConsultaControleDeColeta.edtCodMarExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodMar, edtDesMar, arrCodMar, fRetNomeMarca, Nil, 'da marca');

end;

procedure TfrmConsultaControleDeColeta.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrCodMar, False) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmConsultaControleDeColeta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If Not fPergunta('Deseja abandonar a tarefa?') Then
    Action := caNone;
  TSalvaConfiguracaoGrid.pSalvaConfiguracoesGrid(cxvColetas, Self.Name);
end;

procedure TfrmConsultaControleDeColeta.FormCreate(Sender: TObject);
begin
  inherited;

  objColeta := TControleDeColeta.Create(Self);

  dtsConsulta.DataSet := objColeta;
  TSalvaConfiguracaoGrid.pCarregaConfiguracoesGrid(cxvColetas, Self.Name);
end;

procedure TfrmConsultaControleDeColeta.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F2:  btnAlterar.Click;
    VK_F3:  btnEntregaPedVen.Click;
    VK_F5:  btnMarcar.Click;
    VK_F6:  btnMarcaTodos.Click;
    VK_F7:  btnDesmarcaTodos.Click;
    VK_F8:  btnCSV.Click;
    VK_F10: btnBaixar.Click;
    VK_F11: btnCancelaBaixa.Click;
  End;

end;

procedure TfrmConsultaControleDeColeta.mskLinGruExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(mskLinGru, edtLinGru, arrLinGru, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6);
end;

procedure TfrmConsultaControleDeColeta.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinGru, edtLinGru, Nil, Key, arrLinGru, False) Then
  Begin
    If fValidaCampos(mskLinGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmConsultaControleDeColeta.OnGetContentFieldExportGridCSV(strField: String; var strConteudo: String);
begin
  If strField = 'PEDVEN' Then
    strConteudo := Copy(strConteudo, 1, 12);
end;

function TfrmConsultaControleDeColeta.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin

    If Sender = mskDtaIni Then
    Begin

      If Not fEmptyDate(mskDtaIni.Text) Then
      Begin
        mskDtaIni.Text := FormatDateTime('dd/mm/yyyy', StrToDateDef(mskDtaIni.Text,0));
      End;

    End

    Else If Sender = mskDtaFin Then
    Begin

      If fEmptyDate(mskDtaFin.Text) Then
      Begin

        If (fGetTipoData <> denSemData) And (Not fEmptyDate(mskDtaIni.Text)) Then
        Begin
          Result := False;
          pMensagemOk('Informe a data final!');
        End;

      End
      Else
      Begin
        mskDtaFin.Text := FormatDateTime('dd/mm/yyyy', StrToDateDef(mskDtaFin.Text,0));
      End;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);

end;


end.
