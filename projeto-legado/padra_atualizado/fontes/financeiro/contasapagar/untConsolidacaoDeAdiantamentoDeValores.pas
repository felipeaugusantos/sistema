unit untConsolidacaoDeAdiantamentoDeValores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxCurrencyEdit,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridBandedTableView,
  cxGridDBBandedTableView, cxClasses, cxGridCustomView, cxGrid, EditFocus,
  Vcl.DBCtrls, untZClient, Uni, Generics.Collections, Math,
  cxDataControllerConditionalFormattingRulesManagerDialog, untTypesSistema;

type

  TfrmConsolidacaoDeAdiantamentoDeValores = class(TfrmPai)
    grpDadosNE: TGroupBox;
    lblDocumento: TLabel;
    lblEspecie: TLabel;
    lblSerie: TLabel;
    lblEmpresa: TLabel;
    lblForNot: TLabel;
    edtDocumento: TEditFocus;
    edtEspecie: TEditFocus;
    edtSerie: TEditFocus;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtForNot: TEditFocus;
    edtDesForNot: TEditFocus;
    pnlContainer: TPanel;
    pnlContainerDuplicatas: TPanel;
    cxDuplicatas: TcxGrid;
    cxDupView: TcxGridDBBandedTableView;
    cxColDuplicata: TcxGridDBBandedColumn;
    cxColSerie: TcxGridDBBandedColumn;
    cxColEmpresa: TcxGridDBBandedColumn;
    cxColDtaCad: TcxGridDBBandedColumn;
    cxColDtaVen: TcxGridDBBandedColumn;
    cxColCheque: TcxGridDBBandedColumn;
    cxColBoleto: TcxGridDBBandedColumn;
    cxColValDuplicata: TcxGridDBBandedColumn;
    cxDupLvl: TcxGridLevel;
    Panel3: TPanel;
    Panel4: TPanel;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    Panel8: TPanel;
    lblTotSelDuplicatas: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    pnlAdiantamentos: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Splitter1: TSplitter;
    dtsDuplicatas: TDataSource;
    dtsAdiantamentos: TDataSource;
    DBText5: TDBText;
    DBText6: TDBText;
    DBText7: TDBText;
    DBText8: TDBText;
    cxAdiantamentos: TcxGrid;
    cxAdtView: TcxGridDBBandedTableView;
    cxColAdtDuplicata: TcxGridDBBandedColumn;
    cxColAdtSerie: TcxGridDBBandedColumn;
    cxColAdtEmpresa: TcxGridDBBandedColumn;
    cxColAdtDtaCad: TcxGridDBBandedColumn;
    cxColAdtDtaVen: TcxGridDBBandedColumn;
    cxColAdtCheque: TcxGridDBBandedColumn;
    cxColAdtBoleto: TcxGridDBBandedColumn;
    cxColAdtValDup: TcxGridDBBandedColumn;
    cxAdtLvl: TcxGridLevel;
    cxColMarcado: TcxGridDBBandedColumn;
    btnConfirma: TBitBtnLocked;
    cxColDupMarcado: TcxGridDBBandedColumn;
    btnMarcarAdiantamento: TBitBtnLocked;
    btnMarcarDuplicatas: TBitBtnLocked;
    Label1: TLabel;
    lblTotSelAdiantamentos: TLabel;
    lblValTotSelDuplicatas: TLabel;
    lblValTotSelAdiantamentos: TLabel;
    procedure edtForNotKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnMarcarAdiantamentoClick(Sender: TObject);
    procedure cxAdtViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure pAjustaUltimaParcela(fltValDup, fltValOri: Double; Autoincrem: string);
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure btnMarcarDuplicatasClick(Sender: TObject);
    procedure cxDupViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxAdtViewDataControllerFilterChanged(Sender: TObject);

  protected
   function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  private
    cdsDuplicatas,
    cdsAdiantamentos: TZClient;
    blnDuplicata: Boolean;
    FCfgEmpresaPagamentoAntecipado: TCfgEmpresaPagamentoAntecipado;
    blnExisteForGen: Boolean;
    strFiltro: String;
    FMenorDataPossivel: TDate;
    FDataConsolidacao: TDateTime;
    procedure pDefineMenorDataPossivel;
    procedure pHabilitaPainel;
    function fCarregaAdiantamentos: boolean;
    function fCarregaDuplicatas: boolean;
    function fValidaHabitacaoDoPainel: Boolean;
    function fCompletaComZeros(strValue: string): string;
    function fDuplicataExiste(): Boolean;
    procedure pCriaCDSDuplicatas;
    function fCarregaFORGEN: String;

    procedure pCriaCDSAdiantamentos;
    function fGetSQLDuplicatas: string;
    function fGetSQLAdiantamentos: string;
    procedure OnAfterScrollAdiantamentos(DataSet: TDataSet);
    procedure pMarcaItemAdiantamento;
    procedure pMarcaItemDuplicata;
    procedure pProcessa;
    Function fRecalculaPagamentosAntecipados(fltRestoAdiantamento: Double): Boolean;

    procedure pProcessaBaixaTotal;
    procedure pMarcaAntecipacaoDuplicata;
    procedure pProcessaBaixaParcial(fltVAlPag: Double);
    procedure pGravaPagamentosAntecipados;
    procedure pDeletaParcelaAntecipacao(strAutoincrem: String);
    procedure pFecharCDS;
    { Private declarations }
  public
    fltTotalMarcado: Double;
    fltTotalMarDupl: Double;
    fltQtdMarcado: Integer;
    fltQtdMarDupl: Integer;
    { Public declarations }
  end;

var
  frmConsolidacaoDeAdiantamentoDeValores: TfrmConsolidacaoDeAdiantamentoDeValores;

implementation

{$R *.dfm}

uses untConsultas, untFuncoesSimples, untEntPagtoAntecipado,
  untMsgPagtoAntecipado, untEspelhoNota, untDuplicatas, untCadPag,
  untTCadPagRepository, untTCadPag, untLogCtp, untFuncoesConsulta,
  untDigDataMsk;

{ TfrmConsolidacaoDeAdiantamentoDeValores }

procedure TfrmConsolidacaoDeAdiantamentoDeValores.FormCreate(Sender: TObject);
begin
  inherited;
  fltTotalMarcado := 0;
  fltTotalMarDupl := 0;
  fltQtdMarcado   := 0;
  fltQtdMarDupl   := 0;

  FCfgEmpresaPagamentoAntecipado := tcepaEmpresaLogada;
  case fCfgSis('REGANT', varInteger) of
    2: FCfgEmpresaPagamentoAntecipado := tcepaTodas;
    3: FCfgEmpresaPagamentoAntecipado := tcepaCNJRaizEmpresaLogada;
  end;

  blnExisteForGen := fExisteFornecedoresGenericos;
end;

procedure TfrmConsolidacaoDeAdiantamentoDeValores.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If Not Assigned(cdsAdiantamentos) Then
    Exit;
  If (cdsAdiantamentos.IsEmpty) Then
    Exit;

  inherited;
  case key of
  VK_SPACE: begin
              If Not (cdsAdiantamentos.IsEmpty) Then
                pMarcaItemAdiantamento;
            end;

  VK_F5: Begin
           If (Not (cdsDuplicatas.IsEmpty)) Then
             pMarcaItemDuplicata;
         End;

  VK_F10: btnConfirma.Click;

  VK_ESCAPE: btnSair.Click;
  end;
end;

procedure TfrmConsolidacaoDeAdiantamentoDeValores.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtDocumento)
end;

procedure TfrmConsolidacaoDeAdiantamentoDeValores.btnConfirmaClick(
  Sender: TObject);
begin
  inherited;
  If (fltQtdMarcado = 0) Or (fltQtdMarDupl = 0) Then
    Exit;
  pProcessa;
end;

procedure TfrmConsolidacaoDeAdiantamentoDeValores.btnMarcarAdiantamentoClick(
  Sender: TObject);
begin
  inherited;
  pMarcaItemAdiantamento;
end;

procedure TfrmConsolidacaoDeAdiantamentoDeValores.btnMarcarDuplicatasClick(
  Sender: TObject);
begin
  inherited;
  pMarcaItemDuplicata;
end;

procedure TfrmConsolidacaoDeAdiantamentoDeValores.cxAdtViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxColMarcado.Index] = 1 Then
    ACanvas.Brush.Color := clAqua;
end;

procedure TfrmConsolidacaoDeAdiantamentoDeValores.cxAdtViewDataControllerFilterChanged(
  Sender: TObject);
  var
  I: Integer;
  S: string;
begin
  inherited;

  If cxAdtView.ViewData.FilterRow.Focused then
  begin
    for I := 0 to cxAdtView.ColumnCount - 1 do
    begin
      S := VarToStr(cxAdtView.ViewData.FilterRow.Values[I]);
      if (Length(S)> 0) and (S[1] <> '%') then
        cxAdtView.ViewData.FilterRow.Values[I] := '%' + S;
    end;
  end;
  strFiltro := cxAdtView.DataController.Filter.FilterText;
end;

procedure TfrmConsolidacaoDeAdiantamentoDeValores.cxDupViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxColDupMarcado.Index] = 1 Then
    ACanvas.Brush.Color := clAqua;
end;

procedure TfrmConsolidacaoDeAdiantamentoDeValores.edtCodEmpresaExit(
  Sender: TObject);
  var
   arrLinEmp: TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrLinEmp, Nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfrmConsolidacaoDeAdiantamentoDeValores.edtCodEmpresaKeyPress(
  Sender: TObject; var Key: Char);
  var
   arrLinEmp: TConsultasArray;
begin
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrLinEmp, True, True) Then
  Begin
    fValidaCampos(edtCodEmpresa, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsolidacaoDeAdiantamentoDeValores.edtForNotKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrForNot : TConsultasArray;
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtForNot, edtDesForNot, nil, Key, arrForNot) Then
  Begin
    If fValidaCampos(edtForNot, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmConsolidacaoDeAdiantamentoDeValores.fValidaCampos(
  Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  blnMudarFoco := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodEmpresa) Then
    Begin
      If fEmptyStr(edtCodEmpresa.Text) and (FCfgEmpresaPagamentoAntecipado in ([tcepaEmpresaLogada, tcepaCNJRaizEmpresaLogada])) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código da empresa deve ser informado!', ['&O k']);
        Result := False;
      End
      else
      If Not fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);
        If fEmptyStr(edtDesEmpresa.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Código da empresa não encontrado!', ['&O K']);
          Result := False;
        End
      End;
    End
    Else If (Sender = edtForNot) Then
    Begin
      blnDuplicata := False;
      If fEmptyStr(edtForNot.Text) Then
      Begin
        fMensagem('', 'Informe o código do Fornecedor!', ['&O K']);
        Result := False;
      End
      Else If Not fEmptyStr(edtForNot.Text) Then
      Begin
        edtDesForNot.Text := fRetNomFornecedor(edtForNot.Text);
        If fEmptyStr(edtDesForNot.Text) Then
        Begin
          fMensagem('','Fornecedor não encontrado!', ['&O K']);
          Result := False;
        End;
      End;
      If Result and fValidaHabitacaoDoPainel Then
        pHabilitaPainel
      else
        pFecharCDS;
    End;
  end;
End;

function TfrmConsolidacaoDeAdiantamentoDeValores.fValidaHabitacaoDoPainel: Boolean;
var strMensagem: String;
begin
  Result:= True;
  If (Not fDocumentoExiste(fCompletaComZeros(edtDocumento.Text),
                          edtEspecie.Text,
                          edtSerie.Text,
                          edtForNot.Text,
                          edtCodEmpresa.Text)) And (Not fDuplicataExiste) Then
  Begin
    Result := False;
    If fEmptyStr(edtForNot.Text) Then
    Begin
      strMensagem := 'Informe o Fornecedor do Documento';
      pSetFocus(edtForNot);
    End;
    If fEmptyStr(edtCodEmpresa.Text) and (FCfgEmpresaPagamentoAntecipado in ([tcepaEmpresaLogada, tcepaCNJRaizEmpresaLogada])) Then
    Begin
      strMensagem := strMensagem + IIf(strMensagem <>  '' , #$A#$D, '') + 'Informe a Empresa do Documento';
      pSetFocus(edtCodEmpresa);
    End;
    {
    If fEmptyStr(edtSerie.Text) Then
    Begin
      strMensagem := strMensagem + IIf(strMensagem <>  '' , #$A#$D, '') + 'Informe a Série do Documento';
      pSetFocus(edtSerie);
    End;
    If fEmptyStr(edtEspecie.Text) Then
    Begin
      strMensagem := strMensagem + IIf(strMensagem <>  '' , #$A#$D, '') + 'Informe a Espécie do Documento';
      pSetFocus(edtEspecie);
    End;

    If fEmptyStr(edtDocumento.Text) Then
    Begin
      strMensagem := strMensagem + IIf(strMensagem <>  '' , #$A#$D, '') + 'Informe o Número do Documento';
      pSetFocus(edtDocumento);
    End;
    }
    If fEmptyStr(strMensagem) And (Not fEmptyStr(edtDocumento.Text)) Then
      strMensagem := 'Documento informado não existe.';

    If fEmptyStr(strMensagem) And (Not blnDuplicata) Then
      strMensagem := 'Não existem duplicatas para esse fornecedor';

    If Not fEmptyStr(strMensagem) Then
      fMensagem('Atenção', strMensagem, ['&O K']);
    blnMudarFoco := False;
  End;
end;

procedure TfrmConsolidacaoDeAdiantamentoDeValores.OnAfterScrollAdiantamentos(
  DataSet: TDataSet);
begin
{}
end;

procedure TfrmConsolidacaoDeAdiantamentoDeValores.pHabilitaPainel;
begin
  If fCarregaDuplicatas and fCarregaAdiantamentos Then
  Begin
    If cdsAdiantamentos.IsEmpty Then
    Begin
      fMensagem('Aviso', 'Não existem adiantamentos para esse fornecedor', ['O&K']);
      edtDocumento.Text := '';
      edtSerie.Text := '';
      edtCodEmpresa.Text := '';
      edtDesEmpresa.Text := '';
      edtForNot.Text := '';
      edtDesForNot.Text := '';
      pSetFocus(edtDocumento);
    End
    Else
    begin
      pnlContainer.Enabled := True;
      fltTotalMarcado := 0;
      fltTotalMarDupl := 0;
      fltQtdMarcado   := 0;
      fltQtdMarDupl   := 0;
      pSetFocus(btnMarcarDuplicatas);
    End;
  End;
end;

procedure TfrmConsolidacaoDeAdiantamentoDeValores.pMarcaAntecipacaoDuplicata;
  var
    qryUpdate: TUniQuery;
begin
  qryUpdate := fCriaQuery;
  Try
    qryUpdate.SQL.Add('UPDATE CADPAG SET CTP_PAGANT = "S"');
    qryUpdate.SQL.Add('WHERE AUTOINCREM = ' + fQuotedStr(cdsDuplicatas.FieldByName('AUTOINC').AsString));
    qryUpdate.ExecSQL;
  Finally
    FreeAndNil(qryUpdate);
  End;
end;

procedure TfrmConsolidacaoDeAdiantamentoDeValores.pMarcaItemAdiantamento;
begin
  If Not Assigned(cdsAdiantamentos) Then
    Exit;
  If (cdsAdiantamentos.IsEmpty) Then
    Exit;
  If cdsAdiantamentos.FieldByName('MARCADO').AsInteger = 0 Then
  Begin
    If fltQtdMarcado = 24 Then
      pMensagemOk('É permitido selecionar até 24 parcelas!')
    Else If fltTotalMarDupl = 0 Then
      pMensagemOk('Selecione primeiro as duplicatas!')
    Else
    Begin
      cdsAdiantamentos.Edit;
      cdsAdiantamentos.FieldByName('MARCADO').AsInteger := 1;
      cdsAdiantamentos.Post;
      fltTotalMarcado := fltTotalMarcado + cdsAdiantamentos.FieldByName('VALDUP').AsFloat;
      Inc(fltQtdMarcado);
    End;
  End
  Else
  Begin
    cdsAdiantamentos.Edit;
    cdsAdiantamentos.FieldByName('MARCADO').AsInteger := 0;
    cdsAdiantamentos.Post;
    fltTotalMarcado := fltTotalMarcado - cdsAdiantamentos.FieldByName('VALDUP').AsFloat;
    Dec(fltQtdMarcado);
  End;
  lblValTotSelAdiantamentos.Caption := FormatFloat('#,##0.00', fltTotalMarcado);
  btnConfirma.Enabled := ((fltQtdMarcado > 0) And (fltQtdMarDupl > 0));
end;

procedure TfrmConsolidacaoDeAdiantamentoDeValores.pMarcaItemDuplicata;
begin
  If Not Assigned(cdsDuplicatas) Then
    Exit;
  If (cdsDuplicatas.IsEmpty) Then
    Exit;

  If cdsDuplicatas.FieldByName('MARCADO').AsInteger = 0 Then
  Begin
    cdsDuplicatas.Edit;
    cdsDuplicatas.FieldByName('MARCADO').AsInteger := 1;
    cdsDuplicatas.Post;
    fltTotalMarDupl := fltTotalMarDupl + cdsDuplicatas.FieldByName('VALDUP').AsFloat;
    Inc(fltQtdMarDupl);
  End
  Else
  Begin
    cdsDuplicatas.Edit;
    cdsDuplicatas.FieldByName('MARCADO').AsInteger := 0;
    cdsDuplicatas.Post;
    fltTotalMarDupl := fltTotalMarDupl - cdsDuplicatas.FieldByName('VALDUP').AsFloat;
    Dec(fltQtdMarDupl);
  End;
  lblValTotSelDuplicatas.Caption := FormatFloat('#,##0.00', fltTotalMarDupl);
  btnConfirma.Enabled := ((fltQtdMarcado > 0) And (fltQtdMarDupl > 0));
end;

procedure TfrmConsolidacaoDeAdiantamentoDeValores.pProcessa;
  var
    fltAdiantamentos: Double;
    fltDuplicata: Double;
    strParcela: string;
    function fRetSubtracao(Val1, Val2: Double): Double;
    Begin
      Result := (RoundTo(Val1, -4) - RoundTo(Val2, -4));
    End;
begin

  fltAdiantamentos := 0;
  fltDuplicata := 0;
  cdsDuplicatas.Filtered := False;
  cdsDuplicatas.Filter := 'MARCADO = 1';
  cdsDuplicatas.Filtered := True;
  cdsDuplicatas.First;

  cdsAdiantamentos.Filtered := False;
  cdsAdiantamentos.Filter := 'MARCADO = 1';
  cdsAdiantamentos.Filtered := True;
  pDefineMenorDataPossivel;

  FDataConsolidacao := fNow;
  If not TfrmDigDataMsk.fDigDataMskVal(FDataConsolidacao, '', 'Data da Consolidação:', FMenorDataPossivel) then
  begin
    pMensagemOk('A Data da Consolidação precisa ser definida!');
    Exit;
  end;

  Try
    Try
      strParcela := cdsDuplicatas.FieldByName('PARCEL').AsString;
      cdsAdiantamentos.First;
      fStartTransaction;
      While not cdsAdiantamentos.Eof Do
      begin
        // Sobrou Adiantamento em aberto
        If cdsDuplicatas.Eof And (fltAdiantamentos > 0) And (fltDuplicata = 0) And (cdsAdiantamentos.RecNo = cdsAdiantamentos.RecordCount) Then
        Begin
          fRecalculaPagamentosAntecipados(fltAdiantamentos);
          cdsAdiantamentos.Next;
        End
        Else
        Begin
          fltAdiantamentos := cdsAdiantamentos.FieldByName('VALDUP').AsFloat;
          While not cdsDuplicatas.Eof Do
          Begin
            fltDuplicata := cdsDuplicatas.FieldByName('VALDUP').AsFloat;
            If fltDuplicata <= fltAdiantamentos Then
            Begin
              pProcessaBaixaTotal;
                pGravaPagamentosAntecipados;
                cdsDuplicatas.Next;
                fltAdiantamentos :=  fltAdiantamentos - fltDuplicata;
                fltDuplicata := 0;
            End
            Else If fltDuplicata > fltAdiantamentos Then
            Begin
              While Not(cdsAdiantamentos.Eof) do
              Begin
                If (fltAdiantamentos >= fltDuplicata) Then
                  break;
                cdsAdiantamentos.Next;
                If Not cdsAdiantamentos.Eof Then
                Begin
                  fltAdiantamentos := fltAdiantamentos + cdsAdiantamentos.FieldByName('VALDUP').AsFloat;
                End;
              End;
              If fltDuplicata <= fltAdiantamentos Then
              Begin
                pProcessaBaixaTotal;
                  pGravaPagamentosAntecipados;
                  cdsDuplicatas.Next;
                  fltAdiantamentos :=  fRetSubtracao(fltAdiantamentos, fltDuplicata);
                  fltDuplicata := 0;
              End
              Else If fltDuplicata > fltAdiantamentos Then
              Begin
                pProcessaBaixaParcial(fltAdiantamentos);
                pGravaPagamentosAntecipados;
                fltAdiantamentos :=  fltAdiantamentos - fltDuplicata;
              End;
            End;
            If (Not cdsAdiantamentos.Eof) And (fltAdiantamentos <= 0) Then
            Begin
              cdsAdiantamentos.Next;
              fltAdiantamentos := cdsAdiantamentos.FieldByName('VALDUP').AsFloat;
            end
            Else If fltAdiantamentos <= 0 Then
              Break;
           End;
        End;
      End;

      cdsAdiantamentos.First;
      While not cdsAdiantamentos.Eof Do
      begin
        pDeletaParcelaAntecipacao(cdsAdiantamentos.FieldByName('AUTOINC').AsString);
        cdsAdiantamentos.Next;
      End;
      fCommit;
      fMensagem('', 'Baixas realizadas com sucesso!', ['&O K']);
      edtDocumento.Text  := '';
      edtSerie.Text      := '';
      edtCodEmpresa.Text := '';
      edtDesEmpresa.Text := '';
      edtForNot.Text     := '';
      edtDesForNot.Text  := '';
      lblValTotSelAdiantamentos.Caption := '0,00';
      lblValTotSelDuplicatas.Caption    := '0,00';
      cdsDuplicatas.Close;
      cdsAdiantamentos.Close;
      pSetFocus(edtDocumento);
    Except
      On E:Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmConsolidacaoDeAdiantamentoDeValores.pProcessa]');
        fRollBack;
      End;
    End;
  Finally
    cdsAdiantamentos.Filtered := False;
    cdsDuplicatas.Filtered    := False;
    btnConfirma.Enabled       := False;
  End;
End;


Function TfrmConsolidacaoDeAdiantamentoDeValores.fRecalculaPagamentosAntecipados(fltRestoAdiantamento: Double): Boolean;

  function fSQLMaxParcelaPagtoAntecipado: String;
    Var
      strSQL: String;
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT MAX(CTP_PARCEL) AS PARCEL FROM CADPAG ';
    strSQL := strSQL + ' WHERE CTP_NUMDUP = :DUPORI AND IFNULL(CTP_SERIE_, "") = :SERORI AND CTP_CODEMP = :CODEMP AND CTP_CODFOR = :CODFOR';
    Result := strSQL;
  End;

  Var
    qryCadNew: TUniQuery;
    qryCadPag: TUniQuery;
    qryParcel: TUniQuery;
    intContador: Integer;
    intLetraAlfa: Integer;
    strParcel: string;
Begin

  Result := True;
  If (RoundTo(fltRestoAdiantamento, -2) = 0) then
    Exit;

  qryCadPag := fCriaQuery(Nil);
  qryCadNew := fCriaQuery(Nil);
  qryParcel := fCriaQuery(Nil);

  Try
    qryCadNew.SQL.Text := 'SELECT * FROM CADPAG WHERE FALSE';

    With qryCadPag, SQL Do
    Begin
      qryCadPag.SQL.Add('SELECT * FROM CADPAG ');
      qryCadPag.SQL.Add('WHERE AUTOINCREM = "' + cdsAdiantamentos.FieldByName('AUTOINC').AsString + '"');
      qryCadPag.SQL.Add('ORDER BY CTP_VALPAG DESC ');

      qryCadPag.Open;

      qryCadNew.Close;
      qryCadNew.Open;
      qryCadNew.Insert;

      For intContador := 0 To qryCadNew.Fields.Count - 1 Do
        qryCadNew.Fields[intContador].Value := qryCadPag.Fields[intContador].Value;

      qryCadNew.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADPAG', VS_strCodEmp);

      qryParcel.Close;
      qryParcel.Sql.Clear;
      qryParcel.Sql.Add(fSQLMaxParcelaPagtoAntecipado);
      qryParcel.ParamByName('DUPORI').AsString := qryCadPag.FieldByName('CTP_NUMDUP').AsString;
      qryParcel.ParamByName('SERORI').AsString := qryCadPag.FieldByName('CTP_SERIE_').AsString;
      qryParcel.ParamByName('CODEMP').AsString := qryCadPag.FieldByName('CTP_CODEMP').AsString;
      qryParcel.ParamByName('CODFOR').AsString := qryCadPag.FieldByName('CTP_CODFOR').AsString;
      qryParcel.Open;

      If qryParcel.IsEmpty Or fEmptyStr(qryParcel.FieldByName('PARCEL').AsString) Then
        intLetraAlfa := fGetPosLetraAlfa(qryCadPag.FieldByName('CTP_PARCEL').AsString)
      Else
        intLetraAlfa := fGetPosLetraAlfa(qryParcel.FieldByName('PARCEL').AsString[1]);

      fInc(intLetraAlfa);
      strParcel := fGetLetraAlfa(intLetraAlfa);

      qryCadNew.FieldByName('CTP_PARCEL').AsString := strParcel;

      qryCadNew.FieldByName('CTP_VALPAG').AsFloat  := fltRestoAdiantamento;
      qryCadNew.FieldByName('CTP_VALORI').AsFloat  := fltRestoAdiantamento;
      qryCadNew.FieldByName('CTP_VALDES').AsFloat  := 0;
      qryCadNew.FieldByName('CTP_VALJUR').AsFloat  := 0;
      qryCadNew.Post;

      Edit;

      qryCadPag.FieldByName('CTP_VALORI').AsFloat := FieldByName('CTP_VALORI').AsFloat - fltRestoAdiantamento;
      qryCadPag.FieldByName('CTP_VALPAG').AsFloat := FieldByName('CTP_VALPAG').AsFloat - fltRestoAdiantamento;
      qryCadPag.Post;
    End;
  Finally
    FreeAndNil(qryCadPag);
    FreeAndNil(qryCadNew);
    FreeAndNil(qryParcel);
  End;
End;


procedure TfrmConsolidacaoDeAdiantamentoDeValores.pProcessaBaixaParcial(fltVAlPag: Double);
  var
    objRep: TCadPagRepository;
    objPag: TCadPag;
begin
  pBaixaParcial('frmConsolidacaoDeAdiantamentoDeValores',
                        'Uso de antecipação',
                        cdsDuplicatas.FieldByName('NUMDUP').AsString,
                        cdsDuplicatas.FieldByName('PARCEL').AsString,
                        cdsDuplicatas.FieldByName('CODEMP').AsString,
                        cdsDuplicatas.FieldByName('CODFOR').AsString,
                        cdsDuplicatas.FieldByName('SERIE_').AsString,
                        FDataConsolidacao,
                        fltVAlPag,
                        cdsAdiantamentos.FieldByName('PORBAI').AsString,
                        cdsAdiantamentos.FieldByName('HISBAI').AsString,
                        cdsDuplicatas.FieldByName('HIST01').AsString,
                        cdsAdiantamentos.FieldByName('DOCBAI').AsString,
                        cdsAdiantamentos.FieldByName('CTABAI').AsString,
                        cdsAdiantamentos.FieldByName('OPEBAI').AsString,
                        cdsAdiantamentos.FieldByName('NUMDOC').AsString,
                        cdsAdiantamentos.FieldByName('TIPDES').AsString,
                        cdsAdiantamentos.FieldByName('SEQCON').AsInteger,
                        cdsAdiantamentos.FieldByName('RESCAI').AsInteger,
                        cdsAdiantamentos.FieldByName('RCXCON').AsInteger,
                        cdsAdiantamentos.FieldByName('SEQRCH').AsInteger,
                        cdsAdiantamentos.FieldByName('DINHEI').AsFloat,
                        cdsAdiantamentos.FieldByName('CHQAVI').AsFloat,
                        cdsAdiantamentos.FieldByName('ORDPAG').AsFloat,
                        cdsAdiantamentos.FieldByName('REPCHQ').AsFloat,
                        0,
                        0,
                        True);
  pMarcaAntecipacaoDuplicata;
  objRep := TCadPagRepository.Create;
  Try
    objPag := objRep.fRetDuplicata(cdsDuplicatas.FieldByName('AUTOINC').AsString);

    If Assigned(objPag) Then
      pGravaLogCtp(objPag, 'Baixa Parcial por antecipação', 'TfrmConsolidacaoDeAdiantamentoDeValores');
  Finally
    FreeAndNil(objRep);
  End;

end;

procedure TfrmConsolidacaoDeAdiantamentoDeValores.pProcessaBaixaTotal;
  var
    objRep: TCadPagRepository;
    objPag: TCadPag;

begin
  pBaixaTotal(cdsDuplicatas.FieldByName('NUMDUP').AsString,
              cdsDuplicatas.FieldByName('PARCEL').AsString,
              cdsDuplicatas.FieldByName('CODEMP').AsString,
              cdsDuplicatas.FieldByName('CODFOR').AsString,
              cdsDuplicatas.FieldByName('SERIE_').AsString,
              cdsDuplicatas.FieldByName('VALDUP').AsFloat,
              cdsDuplicatas.FieldByName('VALDUP').AsFloat,
              FDataConsolidacao,
              cdsAdiantamentos.FieldByName('PORBAI').AsString,
              cdsAdiantamentos.FieldByName('HISBAI').AsString,
              cdsDuplicatas.FieldByName('HIST01').AsString,
              cdsAdiantamentos.FieldByName('DOCBAI').AsString,
              cdsAdiantamentos.FieldByName('CTABAI').AsString,
              cdsAdiantamentos.FieldByName('OPEBAI').AsString,
              cdsAdiantamentos.FieldByName('NUMDOC').AsString,
              cdsAdiantamentos.FieldByName('TIPDES').AsString,
              cdsAdiantamentos.FieldByName('SEQCON').AsInteger,
              cdsAdiantamentos.FieldByName('VENDOR').AsFloat,
              cdsAdiantamentos.FieldByName('RESCAI').AsInteger,
              cdsAdiantamentos.FieldByName('RCXCON').AsInteger,
              cdsAdiantamentos.FieldByName('SEQRCH').AsInteger,
              cdsDuplicatas.FieldByName('VALDUP').AsFloat,
              0,
              0,
              0);
  pMarcaAntecipacaoDuplicata;
  objRep := TCadPagRepository.Create;
  Try
    objPag := objRep.fRetDuplicata(cdsDuplicatas.FieldByName('AUTOINC').AsString);

    If Assigned(objPag) Then
      pGravaLogCtp(objPag, 'Baixa Total por antecipação', 'TfrmConsolidacaoDeAdiantamentoDeValores');
  Finally
    FreeAndNil(objRep);
  End;

end;


function TfrmConsolidacaoDeAdiantamentoDeValores.fCarregaAdiantamentos: boolean;
begin
  Result := True;
  pCriaCDSAdiantamentos;
end;

function TfrmConsolidacaoDeAdiantamentoDeValores.fCarregaDuplicatas: boolean;
begin
  Result := True;
  pCriaCDSDuplicatas;
end;

function TfrmConsolidacaoDeAdiantamentoDeValores.fCompletaComZeros(
  strValue: string): string;
begin
  If Not fEmptyStr(edtEspecie.Text) Then
    Result := fStrZero(edtDocumento.Text, 12)
  Else
    Result := strValue;
end;

function TfrmConsolidacaoDeAdiantamentoDeValores.fDuplicataExiste: Boolean;
var
  qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery();
  Try
    qryConsulta.SQL.text := fGetSQLDuplicatas;
    qryConsulta.Open;
    Result := (Not (qryConsulta.IsEmpty));
    blnDuplicata := Result;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TfrmConsolidacaoDeAdiantamentoDeValores.pAjustaUltimaParcela(fltValDup, fltValOri: Double; Autoincrem: string);
  var
    qryUpdate: TUniQuery;
begin
  qryUpdate := fCriaQuery;
  Try
    qryUpdate.sql.Add('UPDATE CADPAG SET ');
    qryUpdate.sql.Add('       CTP_VALDUP = :VALDUP,');
    qryUpdate.sql.Add('       CTP_VALORI = :VALORI');
    qryUpdate.sql.Add(' WHERE AUTOINCREM = :AUTOINCREM');
    qryUpdate.ParamByName('VALDUP').AsFloat := fltValDup;
    qryUpdate.ParamByName('VALORI').AsFloat := fltValDup;
    qryUpdate.ParamByName('AUTOINCREM').AsString := Autoincrem;

    qryUpdate.ExecSQL;
  Finally
    FreeAndNil(qryUpdate);
  End;

end;

procedure TfrmConsolidacaoDeAdiantamentoDeValores.pCriaCDSAdiantamentos;
begin
  If Assigned(cdsAdiantamentos) Then
    FreeAndNil(cdsAdiantamentos);
  cdsAdiantamentos := TZClient.Create(Self, fGetSQLAdiantamentos);
  cdsAdiantamentos.fAbreClient(True,'[TfrmConsolidacaoDeAdiantamentoDeValores.pCriaCDSAdiantamentos]');
  cdsAdiantamentos.AfterScroll := OnAfterScrollAdiantamentos;
  dtsAdiantamentos.DataSet := cdsAdiantamentos;

end;

procedure TfrmConsolidacaoDeAdiantamentoDeValores.pCriaCDSDuplicatas;
begin
  If Assigned(cdsDuplicatas) Then
    FreeAndNil(cdsDuplicatas);
  cdsDuplicatas := TZClient.Create(Self, fGetSQLDuplicatas);
  cdsDuplicatas.fAbreClient(True,'[TfrmConsolidacaoDeAdiantamentoDeValores.pCriaCDSDuplicatas]');
  dtsDuplicatas.DataSet := cdsDuplicatas;
end;

function TfrmConsolidacaoDeAdiantamentoDeValores.fCarregaFORGEN: String;
var qryConsulta: TUniQuery;
begin
  result := '';
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT DISTINCT GEN_CODFOR ');
    qryConsulta.SQL.Add('  FROM FORGEN ');
    case FCfgEmpresaPagamentoAntecipado of
      tcepaEmpresaLogada:       qryConsulta.SQL.Add('    WHERE GEN_CODEMP = ' + fQuotedStr(edtCodEmpresa.Text));
      tcepaTodas: ;
      tcepaCNJRaizEmpresaLogada: Begin
                                   qryConsulta.SQL.Add('    WHERE GEN_CODEMP IN (SELECT EMP_CODEMP  ');
                                   qryConsulta.SQL.Add('                         FROM CADEMP ');
                                   qryConsulta.SQL.Add('                        WHERE SUBSTR(EMP_C_G_C_, 1, 8) = (SELECT SUBSTR(EMP_C_G_C_, 1, 8) FROM CADEMP WHERE EMP_CODEMP = ' + fQuotedStr(edtCodEmpresa.Text)+ '))');
                                 end;
    End;

    qryConsulta.Open;
    If qryConsulta.IsEmpty Then
      Exit;

    while not qryConsulta.Eof do
    Begin
      Result := Result + IIf(Result = '', '', ',') + '"' +  qryConsulta.FieldByName('GEN_CODFOR').AsString + '"';
      qryConsulta.Next;
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;


function TfrmConsolidacaoDeAdiantamentoDeValores.fGetSQLAdiantamentos: string;
var
  lListaFornGEN_CODFOR: string;
begin
  lListaFornGEN_CODFOR := fCarregaFORGEN;
  Result := '';
  Result := Result + 'SELECT ' + IIF(blnExisteForGen, ' DISTINCT *', '*') + ' FROM (';

  Result := Result + 'SELECT 0 AS MARCADO, ';
  Result := Result + '       CADPAG.AUTOINCREM AS AUTOINC, ';
  Result := Result + '       CONCAT(CTP_NUMDUP, "-", CTP_PARCEL) AS DUPLIC, ';
  Result := Result + '       CTP_PARCEL AS CTP_PARCEL, ';
  Result := Result + '       CTP_SEQBAI AS CTP_SEQBAI, ';
  Result := Result + '       CTP_CODFOR AS CODFOR, ';
  Result := Result + '       CTP_SERIE_ AS SERIE_, ';
  Result := Result + '       CTP_CODEMP AS CODEMP, ';
  Result := Result + '       CTP_DTACAD AS DTACAD, ';
  Result := Result + '       CTP_DTAVEN AS DTAVEN, ';
  Result := Result + '       CTP_USACHQ AS USACHQ, ';
  Result := Result + '       CTP_VEIOBO AS VEIOBO, ';
  Result := Result + '       CTP_DTABAI AS DTABAI, ';
  Result := Result + '       CTP_DTAPAG AS DTAPAG, ';
  Result := Result + '       CTP_PORBAI AS PORBAI, ';
  Result := Result + '       CTP_HISBAI AS HISBAI, ';
  Result := Result + '       CTP_HIST01 AS HIST01, ';
  Result := Result + '       CTP_HIST02 AS HIST02, ';
  Result := Result + '       CTP_DOCBAI AS DOCBAI, ';
  Result := Result + '       CTP_CTABAI AS CTABAI, ';
  Result := Result + '       CTP_OPEBAI AS OPEBAI, ';
  Result := Result + '       CTP_NUMDOC AS NUMDOC, ';
  Result := Result + '       CTP_TIPDES AS TIPDES, ';
  Result := Result + '       CTP_SEQCON AS SEQCON, ';
  Result := Result + '       CTP_VALJUR AS VALJUR, ';
  Result := Result + '       CTP_VENDOR AS VENDOR, ';
  Result := Result + '       CTP_RESCAI AS RESCAI, ';
  Result := Result + '       CTP_RCXCON AS RCXCON, ';
  Result := Result + '       CTP_SEQRCH AS SEQRCH, ';
  Result := Result + '       CTP_DINHEI AS DINHEI, ';
  Result := Result + '       CTP_CHQAVI AS CHQAVI, ';
  Result := Result + '       CTP_ORDPAG AS ORDPAG, ';
  Result := Result + '       CTP_REPCHQ AS REPCHQ, ';

  Result := Result + '       (CTP_VALPAG - IFNULL(CTP_VALJUR, 0) + IFNULL(CTP_VALDES, 0)) AS VALDUP, ';
  Result := Result + '       CONCAT(LEFT(CTP_CODCTA, 2), ".", RIGHT(LEFT(CTP_CODCTA, 4), 2), ".", RIGHT(CTP_CODCTA, 3), " - " , CTA_DESCTA) AS CODCTA, ';
  Result := Result + '       CONCAT(CTP_PORBAI, " - ", POR_NOMPOR)  AS CODPOR, ';
  Result := Result + '       CONCAT(CTP_CODEVE, " - ", EVE_DESEVE)  AS CODEVE, ';
  Result := Result + '       CAST(CONCAT(IFNULL(CTP_HIST01,""), " ", IFNULL(CTP_HIST02, "")) AS CHAR(255)) AS HISTOR ';
  Result := Result + '  FROM CADPAG ';
  Result := Result + ' INNER JOIN CADCTA ON CTA_CODCTA = CTP_CODCTA ';
  Result := Result + '  LEFT JOIN CADPOR ON POR_CODPOR = CTP_PORBAI ';
  Result := Result + '  LEFT JOIN CADEVE ON EVE_CODEVE = CTP_CODEVE ';
  Result := Result + '  LEFT JOIN PGOGER P ON P.PGO_SEQPAG = CADPAG.AUTOINCREM ';
  Result := Result + '  LEFT JOIN CADFOR F ON F.FOR_CODFOR = CADPAG.CTP_CODFOR ';
  Result := Result + ' WHERE TRUE ';
  Result := Result + '    AND  PGO_SEQPAG IS NULL AND  (((F.FOR_CGCCPF = 1 AND SUBSTR(F.FOR_C_G_C_, 1 ,8) IN ';
  Result := Result + '                                                              (SELECT SUBSTR(FB.FOR_C_G_C_, 1, 8) ';
  Result := Result + '                                                                 FROM CADFOR FB WHERE FB.FOR_CODFOR = ' + fQuotedStr(edtForNot.Text) + ')) ';
  Result := Result + '                                                      OR (F.FOR_CGCCPF = 2  AND CTP_CODFOR = ' + fQuotedStr(edtForNot.Text) + ')) ';
  If lListaFornGEN_CODFOR <> '' Then
    Result := Result + '   OR (FOR_CODFOR IN (' + lListaFornGEN_CODFOR + '))';
  Result := Result + ')';
  case FCfgEmpresaPagamentoAntecipado of
    tcepaEmpresaLogada:   Result := Result + '    AND CTP_CODEMP = ' + fQuotedStr(edtCodEmpresa.Text)+ ' ';
    tcepaTodas: ;
    tcepaCNJRaizEmpresaLogada: Begin
                                 Result := Result + '    AND CTP_CODEMP IN (SELECT EMP_CODEMP  ';
                                 Result := Result + '                         FROM CADEMP ';
                                 Result := Result + '                        WHERE SUBSTR(EMP_C_G_C_, 1, 8) = (SELECT SUBSTR(EMP_C_G_C_, 1, 8) FROM CADEMP WHERE EMP_CODEMP = ' + fQuotedStr(edtCodEmpresa.Text)+ '))';
    end;
  end;
  Result := Result + '    AND CTP_PAGANT = "S" ';
  Result := Result + '    AND CTP_DTAPAG IS NOT NULL ';
  Result := Result + '    AND IFNULL(CTP_USOFIS, "N") = "N" ';

  Result := Result + ' AND ((IFNULL((SELECT SUM(PRE_VALUTI) FROM PREPGA  A    WHERE A.AUTOINCPAG = P.AUTOINCREM),0)) = 0) ';

  If blnExisteForGen Then
  Begin
    Result := Result + 'UNION ALL ';
    If blnExisteForGen Then
      Result := Result + ' SELECT ';
    Result := Result + '       0 AS MARCADO, ';
    Result := Result + '       C.AUTOINCREM AS AUTOINC, ';
    Result := Result + '       CONCAT(CTP_NUMDUP, "-", CTP_PARCEL) AS DUPLIC, ';
    Result := Result + '       CTP_PARCEL AS CTP_PARCEL, ';
    Result := Result + '       CTP_SEQBAI AS CTP_SEQBAI, ';
    Result := Result + '       CTP_CODFOR AS CODFOR, ';
    Result := Result + '       CTP_SERIE_ AS SERIE_, ';
    Result := Result + '       CTP_CODEMP AS CODEMP, ';
    Result := Result + '       CTP_DTACAD AS DTACAD, ';
    Result := Result + '       CTP_DTAVEN AS DTAVEN, ';
    Result := Result + '       CTP_USACHQ AS USACHQ, ';
    Result := Result + '       CTP_VEIOBO AS VEIOBO, ';
    Result := Result + '       CTP_DTABAI AS DTABAI, ';
    Result := Result + '       CTP_DTAPAG AS DTAPAG, ';
    Result := Result + '       CTP_PORBAI AS PORBAI, ';
    Result := Result + '       CTP_HISBAI AS HISBAI, ';
    Result := Result + '       CTP_HIST01 AS HIST01, ';
    Result := Result + '       CTP_HIST02 AS HIST02, ';
    Result := Result + '       CTP_DOCBAI AS DOCBAI, ';
    Result := Result + '       CTP_CTABAI AS CTABAI, ';
    Result := Result + '       CTP_OPEBAI AS OPEBAI, ';
    Result := Result + '       CTP_NUMDOC AS NUMDOC, ';
    Result := Result + '       CTP_TIPDES AS TIPDES, ';
    Result := Result + '       CTP_SEQCON AS SEQCON, ';
    Result := Result + '       CTP_VALJUR AS VALJUR, ';
    Result := Result + '       CTP_VENDOR AS VENDOR, ';
    Result := Result + '       CTP_RESCAI AS RESCAI, ';
    Result := Result + '       CTP_RCXCON AS RCXCON, ';
    Result := Result + '       CTP_SEQRCH AS SEQRCH, ';
    Result := Result + '       CTP_DINHEI AS DINHEI, ';
    Result := Result + '       CTP_CHQAVI AS CHQAVI, ';
    Result := Result + '       CTP_ORDPAG AS ORDPAG, ';
    Result := Result + '       CTP_REPCHQ AS REPCHQ, ';

    Result := Result + '       (CTP_VALPAG - IFNULL(CTP_VALJUR, 0) + IFNULL(CTP_VALDES, 0)) AS VALDUP, ';
    Result := Result + '       CONCAT(LEFT(CTP_CODCTA, 2), ".", RIGHT(LEFT(CTP_CODCTA, 4), 2), ".", RIGHT(CTP_CODCTA, 3), " - " , CTA_DESCTA) AS CODCTA, ';
    Result := Result + '       CONCAT(CTP_PORBAI, " - ", POR_NOMPOR)  AS CODPOR, ';
    Result := Result + '       CONCAT(CTP_CODEVE, " - ", EVE_DESEVE)  AS CODEVE, ';
    Result := Result + '       CAST(CONCAT(IFNULL(CTP_HIST01,""), " ", IFNULL(CTP_HIST02, "")) AS CHAR(255)) AS HISTOR ';
    Result := Result + ' FROM FORGEN FG ';
    Result := Result + ' INNER JOIN CADFOR F ON F.FOR_CODFOR = FG.GEN_CODFOR ';
    Result := Result + ' INNER JOIN CADPAG C ON C.CTP_CODFOR = F.FOR_CODFOR ';
    Result := Result + ' INNER JOIN CADCTA ON CTA_CODCTA = CTP_CODCTA ';
    Result := Result + '  LEFT JOIN CADPOR ON POR_CODPOR = CTP_PORBAI ';
    Result := Result + '  LEFT JOIN CADEVE ON EVE_CODEVE = CTP_CODEVE ';
    Result := Result + '  LEFT JOIN PGOGER P ON P.PGO_SEQPAG = C.AUTOINCREM ';
    Result := Result + ' WHERE TRUE ';
    Result := Result + '    AND  PGO_SEQPAG IS NULL ';
   { Result := Result + '    AND  ((F.FOR_CGCCPF = 1 AND SUBSTR(F.FOR_C_G_C_, 1 ,8) IN ';
    Result := Result + '                                                              (SELECT SUBSTR(FB.FOR_C_G_C_, 1, 8) ';
    Result := Result + '                                                                 FROM CADFOR FB WHERE FB.FOR_CODFOR = ' + fQuotedStr(edtForNot.Text) + ')) ';
    Result := Result + '                                                      OR (F.FOR_CGCCPF = 2  AND CTP_CODFOR = ' + fQuotedStr(edtForNot.Text) + ')) ';   }
    If Not fEmptyStr(edtCodEmpresa.Text) Then
     Result := Result + '    AND CTP_CODEMP = ' + fQuotedStr(edtCodEmpresa.Text);
    Result := Result + '    AND CTP_PAGANT = "S" ';
    Result := Result + '    AND CTP_DTAPAG IS NOT NULL ';
    Result := Result + '    AND IFNULL(CTP_USOFIS, "N") = "N" ';

    Result := Result + ' AND ((IFNULL((SELECT SUM(PRE_VALUTI) FROM PREPGA  A    WHERE A.AUTOINCPAG = P.AUTOINCREM),0)) = 0) ';
  End;
  Result := Result + ' ) ADIANTAMENTOS ';
end;

function TfrmConsolidacaoDeAdiantamentoDeValores.fGetSQLDuplicatas: string;
begin
  Result := '';
  Result := Result + ' SELECT 0 AS MARCADO, ';
  Result := Result + '       CADPAG.AUTOINCREM AS AUTOINC,';
  Result := Result + '       MOVGER.AUTOINCREM AS SEQGER, ';
  Result := Result + '       MOVGER.GER_CONPAG AS CONPAG, ';
  Result := Result + '       MOVGER.GER_DTAENT AS DTAENT, ';
  Result := Result + '       MOVGER.GER_DTADOC AS DTADOC, ';
  Result := Result + '       MOVGER.GER_VLRCON AS VLRCON, ';
  Result := Result + '       MOVGER.GER_TOTPRO AS TOTPRO, ';
  Result := Result + '       CTP_CODFOR AS CODFOR, ';
  Result := Result + '       CTP_NUMDUP AS NUMDUP,' ;
  Result := Result + '       CONCAT(CTP_NUMDUP, "-", CTP_PARCEL) AS DUPLIC, ';
  Result := Result + '       CTP_PARCEL AS PARCEL, ';
  Result := Result + '       CTP_SERIE_ AS SERIE_, ';
  Result := Result + '       CTP_CODEMP AS CODEMP, ';
  Result := Result + '       CTP_DTACAD AS DTACAD, ';
  Result := Result + '       CTP_DTAVEN AS DTAVEN, ';
  Result := Result + '       CTP_USACHQ AS USACHQ, ';
  Result := Result + '       CTP_VEIOBO AS VEIOBO, ';
  Result := Result + '       CTP_HIST01 AS HIST01, ';
  Result := Result + '       (CTP_VALDUP + IFNULL(CTP_JURSUJ,0) + IFNULL(CTP_MULSUJ,0) + IFNULL(CTP_VENDOR,0) + IFNULL(CTP_OUTENT,0)) - IFNULL(CTP_DESSUJ,0) AS VALDUP, ';
  Result := Result + '       CTP_VALDUP AS VALPAG, ';
  Result := Result + '       CONCAT(LEFT(CTP_CODCTA, 2), ".", RIGHT(LEFT(CTP_CODCTA, 4), 2), ".", RIGHT(CTP_CODCTA, 3), " - " , CTA_DESCTA) AS CODCTA,';
  Result := Result + '       CONCAT(CTP_PORBAI, " - ", POR_NOMPOR)  AS CODPOR, ';
  Result := Result + '       CONCAT(CTP_CODEVE, " - ", EVE_DESEVE)  AS CODEVE, ';
  Result := Result + '       CAST(CONCAT(IFNULL(CTP_HIST01,""), " ", IFNULL(CTP_HIST02, "")) AS CHAR(255)) AS HISTOR, ';
  Result := Result + '       @CTPCAD :=DATE_SUB(CTP_DTACAD, INTERVAL 1 DAY) AS CTPCAD, ';
  Result := Result + '       @FECFIN := IFNULL((SELECT MAX(FEC_DTAREF) ';
  Result := Result + '                     FROM FECFIN ';
  Result := Result + '                    WHERE FEC_CODEMP = CTP_CODEMP), 0) AS FECFIN, ';
  Result := Result + '        CAST(DATE_ADD(IF(@CTPCAD > @FECFIN, @CTPCAD, @FECFIN), INTERVAL 1 DAY) AS DATE) AS DTAMIN ';
  Result := Result + ' FROM CADPAG ';
  Result := Result + 'INNER JOIN CADCTA ON CTA_CODCTA = CTP_CODCTA ';
  Result := Result + ' LEFT JOIN CADPOR ON POR_CODPOR = CTP_PORBAI ';
  Result := Result + ' LEFT JOIN MOVGER ON GER_NUMDOC = CTP_NUMDUP ';
  Result := Result + '                 AND GER_CODEMP = CTP_CODEMP ';
  Result := Result + '                 AND GER_SERIE_ = CTP_SERIE_ ';
  Result := Result + '                 AND GER_CODFOR = CTP_CODFOR ';
  Result := Result + '                 AND GER_DTADOC = CTP_DTACAD ';

  Result := Result + ' LEFT JOIN CADEVE ON EVE_CODEVE = CTP_CODEVE ';
  Result := Result + 'WHERE TRUE';
  case FCfgEmpresaPagamentoAntecipado of
    tcepaEmpresaLogada:   Result := Result + '    AND CTP_CODEMP = ' + fQuotedStr(edtCodEmpresa.Text)+ ' ';
    tcepaTodas: ;
    tcepaCNJRaizEmpresaLogada: Begin
                                 Result := Result + '    AND CTP_CODEMP IN (SELECT EMP_CODEMP  ';
                                 Result := Result + '                         FROM CADEMP ';
                                 Result := Result + '                        WHERE SUBSTR(EMP_C_G_C_, 1, 8) = (SELECT SUBSTR(EMP_C_G_C_, 1, 8) FROM CADEMP WHERE EMP_CODEMP = ' + fQuotedStr(edtCodEmpresa.Text)+ '))';
    end;
  end;
  Result := Result + '  AND CTP_CODFOR = ' + fQuotedStr(edtForNot.Text) ;
  If Not fEmptyStr(edtSerie.Text) Then
    Result := Result + ' AND CTP_SERIE_ = ' + fQuotedStr(edtSerie.Text) ;
  If Not fEmptyStr(edtDocumento.Text) Then
    Result := Result + ' AND CTP_NUMDUP = ' + fQuotedStr(fCompletaComZeros(edtDocumento.Text)) ;
  Result := Result + '  AND IFNULL(CTP_DTAPAG, "") = ""';
  Result := Result + '  AND CTP_PAGANT <> "S" ';
  Result := Result + '  ORDER BY CTP_PARCEL ';
end;

procedure TfrmConsolidacaoDeAdiantamentoDeValores.pGravaPagamentosAntecipados;
  var
    qryPgoGer: TUniQuery;
begin
  qryPgoGer := fCriaQuery;
  Try
    Try

      qryPgoGer.SQL.Clear;
      qryPgoGer.SQL.Add(' INSERT INTO PGOGER(AUTOINCREM, PGO_SEQGER, PGO_SEQPAG, PGO_FORORI, PGO_EMPORI, PGO_SEQORI, PGO_PARORI, PGO_DUPORI, PGO_SERORI, PGO_HIST01, PGO_HIST02) VALUES ');
      qryPgoGer.SQL.Add(' (:AUTOINCREM, :PGO_SEQGER, :PGO_SEQPAG, :PGO_FORORI, :PGO_EMPORI, :PGO_SEQORI, :PGO_PARORI, :PGO_DUPORI, :PGO_SERORI, :PGO_HIST01, :PGO_HIST02)                     ');
      qryPgoGer.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('PGOGER', VS_strCodEmp);
      If Not fEmptyStr(cdsDuplicatas.FieldByName('SEQGER').AsString) Then
        qryPgoGer.ParamByName('PGO_SEQGER').AsString := cdsDuplicatas.FieldByName('SEQGER').AsString;
      qryPgoGer.ParamByName('PGO_SEQPAG').AsString := cdsDuplicatas.FieldByName('AUTOINC').AsString;

      qryPgoGer.ParamByName('PGO_DUPORI').AsString := copy(cdsAdiantamentos.FieldByName('DUPLIC').AsString,0,12);
      qryPgoGer.ParamByName('PGO_SERORI').AsString := cdsAdiantamentos.FieldByName('SERIE_').AsString;
      qryPgoGer.ParamByName('PGO_FORORI').AsString := cdsAdiantamentos.FieldByName('CODFOR').AsString;
      qryPgoGer.ParamByName('PGO_EMPORI').AsString := cdsAdiantamentos.FieldByName('CODEMP').AsString;
      qryPgoGer.ParamByName('PGO_SEQORI').AsString := cdsAdiantamentos.FieldByName('CTP_SEQBAI').AsString;
      qryPgoGer.ParamByName('PGO_PARORI').AsString := cdsAdiantamentos.FieldByName('CTP_PARCEL').AsString;
      qryPgoGer.ParamByName('PGO_HIST01').AsString := cdsAdiantamentos.FieldByName('HIST01').AsString;
      qryPgoGer.ParamByName('PGO_HIST02').AsString := cdsAdiantamentos.FieldByName('HIST02').AsString;

      qryPgoGer.ExecSQL;
    Finally
      FreeAndNil(qryPgoGer);
    End;
  Except
    On E: Exception Do
      raise;
  End;
end;

procedure TfrmConsolidacaoDeAdiantamentoDeValores.pDefineMenorDataPossivel;
begin
  FMenorDataPossivel := 0;
  cdsDuplicatas.First;
  while not cdsDuplicatas.Eof Do
  Begin
    If FMenorDataPossivel < cdsDuplicatas.FieldByname('DTAMIN').AsDateTime then
      FMenorDataPossivel := cdsDuplicatas.FieldByname('DTAMIN').AsDateTime;
    cdsDuplicatas.Next
  End;
  cdsDuplicatas.First;
end;

procedure TfrmConsolidacaoDeAdiantamentoDeValores.pDeletaParcelaAntecipacao(strAutoincrem: String);
  var
    qryDel: TUniQuery;
begin
  qryDel := fCriaQuery;
  Try
    Try
      qryDel.Close;
      qryDel.Sql.Clear;
      qryDel.Sql.Add(' SELECT * FROM CADPAG WHERE AUTOINCREM = :AUTINC ');

      qryDel.ParambyName('AUTINC').AsString := strAutoincrem;
      qryDel.Open;

      If (Not qryDel.IsEmpty) Then
      Begin
        fApagaDuplicataContasPagar(qryDel, 'frmConsolidacaoDeAdiantamentoDeValores', '');
      End;
    Finally
      FreeAndNil(qryDel);
    End;
  Except
    Raise;
  End;
end;


procedure TfrmConsolidacaoDeAdiantamentoDeValores.pFecharCDS;
begin
  If Not assigned(cdsAdiantamentos) Then
    Exit;
  cdsAdiantamentos.Close;
  cdsDuplicatas.Close;

end;

end.


