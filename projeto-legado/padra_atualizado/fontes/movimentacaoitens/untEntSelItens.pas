unit untEntSelItens;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, Uni,
  Grids, DBGridCitel, DBGrids, Menus , EditFocus, AppEvnts{Qt,}, DB, StrUtils, UniClientDataSet,
  UniDataSetProvider, Mask, DBCtrls, BitBtnLockedIncrem, Datasnap.Provider,
  frxClass, frxExportCSVTestabilidade, Datasnap.DBClient;

type
  TfrmEntSelItens = class(TfrmPaiSimples)
    pnlTitulo: TPanel;
    dbgItens: TDBGridCitel;
    pnlDadosInformativos: TPanel;
    pnlBotoesSelecao: TPanel;
    Label6: TLabel;
    Label21: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    edtIteSel: TEditFocus;
    edtTotIte: TEditFocus;
    edtTotIpi: TEditFocus;
    edtTotGer: TEditFocus;
    Label1: TLabel;
    edtTotSub: TEditFocus;
    cdsItens: TUniClientDataSet;
    dtsItens: TDataSource;
    dspItens: TUniDataSetProvider;
    cdsTotais: TUniClientDataSet;
    Panel1: TPanel;
    Label3: TLabel;
    Label5: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    btnConfirma: TBitBtnLocked;
    btnMarca: TBitBtnLocked;
    btnDesmarca: TBitBtnLocked;
    btnIniBus: TBitBtnLocked;
    btnLocProx: TBitBtnLocked;
    btnSairSelecao: TBitBtnLocked;
    FlwPnlBotoesSelecao: TFlowPanel;
    Panel2: TPanel;
    lblMarca: TLabel;
    lblMarcaParc: TLabel;
    procedure btnSairSelecaoClick(Sender: TObject);
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgItensDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnMarcaClick(Sender: TObject);
    procedure btnDesmarcaClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsItensBeforeInsert(DataSet: TDataSet);
    procedure btnIniBusClick(Sender: TObject);
    procedure btnLocProxClick(Sender: TObject);
    procedure cdsItensBeforeEdit(DataSet: TDataSet);
  private
    { Private declarations }
    intRecNo : Integer;
    blnAbandono: Boolean;
    fltOciVlr  : Double;
    blnEnter   : Boolean;
    cdsCopia   : TUniClientDataSet;
    fltQtdIteI,
    fltUnitarI : Double;

    strValorFiltro : String;
    strCampoFiltro : String;

    procedure pCalculaTotal;
    procedure pAtualizaTemporaria;
    procedure pMarcaDuplicata(blnMarcar: Boolean);
    procedure pSelecionaDuplicata;
    procedure pAfterScroll(Dataset: TDataset);
    procedure pAfterPost(Dataset: TDataset);
    procedure pBeforePost(Dataset: TDataset);
    procedure pDeletaItensDesmarcados;
    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);
  public
    { Public declarations }
    blnConfirma: Boolean;
    strCodFor  : String;
    strOrdIte  : String;
    blnErro    : Boolean;
    blnDocOri  : Boolean;
    qryItePed  : TUniQuery;
    blnAltMai  : Boolean;

    procedure pCarregaTabela;
  end;


implementation

uses  untFuncoes, untfuncoesSimples, System.UITypes,
      untEntSelItensFindNext, untSelOrdItens, untPcmGer;

{$R *.dfm}

procedure TfrmEntSelItens.btnSairSelecaoClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmEntSelItens.pCarregaTabela;
  Var
    strSQL: String;
    qryGen: TUniQuery;
    intContador : Integer;
  Const
    arrCampos : Array [0..4] Of String = ('TOT_TOTITE','TOT_TOTGER','TOT_VALIPI','TOT_TOTSUB', 'ENT_IPIENT');
    arrExpres : Array [0..4] Of String = ('ENT_TOTITE','ENT_TOTGER','ENT_VALIPI','ENT_TOTSUB', 'ENT_IPIENT');
begin

  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ENT_NUMPED, ';
    strSQL := strSQL + '  ENT_CODEMP, ';
    strSQL := strSQL + '  ENT_CODITE, ';
    strSQL := strSQL + '  ENT_CODFAB, ';
    strSQL := strSQL + '  ENT_CODGRU, ';
    strSQL := strSQL + '  ENT_DESITE, ';
    strSQL := strSQL + '  ENT_REFERE, ';
    strSQL := strSQL + '  ENT_CODUNI, ';
    strSQL := strSQL + '  ENT_CODFOR, ';
    strSQL := strSQL + '  ENT_DTABAL, ';
    strSQL := strSQL + '  ENT_QTDITE, ';
    strSQL := strSQL + '  ENT_UNITAR, ';
    strSQL := strSQL + '  ENT_TOTSUB, ';
    strSQL := strSQL + '  ENT_VALIPI, ';
    strSQL := strSQL + '  ENT_VALICM, ';
    strSQL := strSQL + '  ENT_TOTITE, ';
    strSQL := strSQL + '  ENT_TOTGER, ';
    strSQL := strSQL + '  ENT_IPIENT, ';
    strSQL := strSQL + '  ENT_PERIPI, ';
    strSQL := strSQL + '  ENT_ICMENT, ';
    strSQL := strSQL + '  ENT_SUBFED, ';
    strSQL := strSQL + '  ENT_PERSUB, ';
    strSQL := strSQL + '  "M" AS ENT_MARDES, ';
    strSQL := strSQL + '  ENT_NUMSEL, ';
    strSQL := strSQL + '  ENT_SEQPCD, ';
    strSQL := strSQL + '  ENT_NUMLOT, ';
    strSQL := strSQL + '  ENT_EMBALA, ';
    strSQL := strSQL + '  AUTOINCREM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  TMP_ENTMER ';

    qryGen := fCriaQuery(Self);

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
    End;

    pSetaClient(qryGen);

    dspItens.DataSet := qryGen;
    cdsItens.Close;
    cdsItens.SetProvider(dspItens);

    qryGen.Open;
    pSetaClient(qryGen);

    cdsItens.Open;
    pSetaClient(cdsItens);

    TFloatField(cdsItens.FieldByName('ENT_TOTITE')).DisplayFormat := '#,##0.00';
    TFloatField(cdsItens.FieldByName('ENT_TOTGER')).DisplayFormat := '#,##0.00';
    TFloatField(cdsItens.FieldByName('ENT_TOTSUB')).DisplayFormat := '#,##0.00';
    TFloatField(cdsItens.FieldByName('ENT_VALIPI')).DisplayFormat := '#,##0.00';
    TFloatField(cdsItens.FieldByName('ENT_QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DEQTEM', varInteger));
    TFloatField(cdsItens.FieldByName('ENT_UNITAR')).DisplayFormat := '#,##0.00';

    {***************************************}
    {* CRIA OS AGGREGATES                  *}
    {************************************AF*}
    For intContador := 0 To 4 Do
    Begin

      With TAggregateField.Create(Self) Do
      Begin
        Name          := arrCampos[intContador];
        FieldName     := arrCampos[intContador];
        DataSet       := cdsTotais;
        Expression    := 'SUM(' + arrExpres[intContador] + ')';
        DisplayFormat := '#,##0.00';
        Active        := True;
      End;

    End;

    With TAggregateField.Create(Self) Do
    Begin
      Name          := 'TOT_NUMSEL';
      FieldName     := 'TOT_NUMSEL';
      DataSet       := cdsTotais;
      Expression    := 'MAX(ENT_NUMSEL)';
      Active        := True;
    End;

    pCalculaTotal;

  Finally
    FreeAndNil(qryGen);
  End;

end;

procedure TfrmEntSelItens.pCalculaTotal;
begin

  cdsTotais.Data := cdsItens.Data;
  cdsTotais.Filtered := True;

  edtIteSel.Text := IntToStr(cdsTotais.RecordCount);

  If Not cdsTotais.IsEmpty Then
  Begin
    edtTotIte.Text := FormatFloat('#,##0.00', fDoubleAggregate(cdsTotais, 'TOT_TOTITE'));
    edtTotSub.Text := FormatFloat('#,##0.00', fDoubleAggregate(cdsTotais, 'TOT_TOTSUB'));
    edtTotIpi.Text := FormatFloat('#,##0.00', fDoubleAggregate(cdsTotais, 'TOT_VALIPI'));
    edtTotGer.Text := FormatFloat('#,##0.00', fDoubleAggregate(cdsTotais, 'TOT_TOTGER'));
  End
  Else
  Begin
    edtTotIte.Text := '0,00';
    edtTotSub.Text := '0,00';
    edtTotIpi.Text := '0,00';
    edtTotGer.Text := '0,00';
  End;

end;

procedure TfrmEntSelItens.dbgItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  With cdsItens Do
  Begin
    {*****************************************}
    {* CASO A TABELA ESTEJA FECHADA, SAI     *}
    {**************************************LU*}
    If Not Active Then
      Exit;

    If FieldByName('ENT_MARDES').AsString = 'M' Then
    Begin
      dbgItens.Canvas.Font.Color := clBlue;

      If dbgItens.Canvas.Brush.Color = clHighLight Then
        dbgItens.Canvas.Font.Color := clHighlightText;
    End;

  End;

  dbgItens.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmEntSelItens.pMarcaDuplicata(blnMarcar: Boolean);
begin

  With cdsItens Do
  Begin
    If Not Active Then
      Exit;

    Edit;

    If blnMarcar Then
    Begin
      FieldByName('ENT_MARDES').AsString := 'M';

      If TAggregateField(cdsTotais.FieldByName('TOT_NUMSEL')).Value = null Then
        FieldByName('ENT_NUMSEL').AsInteger:= 1
      Else
        FieldByName('ENT_NUMSEL').AsInteger:= TAggregateField(cdsTotais.FieldByName('TOT_NUMSEL')).Value + 1;
    End
    Else
    Begin
      FieldByName('ENT_MARDES').AsString := 'D';
      FieldByName('ENT_NUMSEL').AsInteger := MaxInt;
    End;

    Post;
  End;

  pCalculaTotal;

end;

procedure TfrmEntSelItens.pSelecionaDuplicata;
  Var
    intRecNo: Integer;
begin

  cdsItens.IndexFieldNames := 'ENT_NUMSEL;ENT_NUMPED;ENT_SEQPCD';
  intRecNo := cdsItens.RecNo;

  If cdsItens.FieldByName('ENT_MARDES').AsString <> 'M' Then
    pMarcaDuplicata(True)
  Else
    pMarcaDuplicata(False);

  cdsItens.RecNo := intRecNo;

end;

procedure TfrmEntSelItens.dbgItensDblClick(Sender: TObject);
begin
  inherited;
  pSelecionaDuplicata;
end;

procedure TfrmEntSelItens.btnMarcaClick(Sender: TObject);
begin
  If (Not cdsItens.Active) Or (cdsItens.IsEmpty) Then
    Exit;

  Try
    cdsItens.DisableControls;
    cdsItens.IndexFieldNames := '';
    
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      pMarcaDuplicata(True);
      cdsItens.Next;
    End;
  Finally
    cdsItens.IndexFieldNames := 'ENT_NUMSEL;ENT_NUMPED;ENT_SEQPCD';
    cdsItens.EnableControls;
  End;

end;

procedure TfrmEntSelItens.btnDesmarcaClick(Sender: TObject);
begin
  If (Not cdsItens.Active) Or (cdsItens.IsEmpty) Then
    Exit;

  Try
    cdsItens.DisableControls;
    cdsItens.IndexFieldNames := '';

    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      pMarcaDuplicata(False);
      cdsItens.Next;
    End;
  Finally
    //cdsItens.IndexFieldNames := 'ENT_NUMSEL;ENT_NUMPED;ENT_SEQPCD';
    cdsItens.EnableControls;
  End;

end;

procedure TfrmEntSelItens.btnIniBusClick(Sender: TObject);
begin
  inherited;

  If cdsItens.IsEmpty Then
    Exit;

  Try
    pCriarFormularios(TfrmEntSelItensFindNext, frmEntSelItensFindNext);

    frmEntSelItensFindNext.ShowModal;

    If (Not fEmptyStr(frmEntSelItensFindNext.strValorFiltro)) Then
    Begin
      strValorFiltro := frmEntSelItensFindNext.strValorFiltro;
      strCampoFiltro := frmEntSelItensFindNext.strCampoFiltro;
      cdsItens.FindFirst;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmEntSelItens.btnIniBusClick]');
    End;
  End;

  pFreeAndNil(frmEntSelItensFindNext);

  pSetFocus(Self);
  
end;

procedure TfrmEntSelItens.btnLocProxClick(Sender: TObject);
begin
  inherited;

  If (Not cdsItens.IsEmpty) And (Not fEmptyStr(strCampoFiltro)) Then
    cdsItens.FindNext;
  
end;

procedure TfrmEntSelItens.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgItens);
  pCarregaTabela;

  blnAltMai := fCfgSis('ALTMAI', varBoolean);

  If Not blnAltMai Then
  Begin
    cdsCopia      := TUniClientDataSet.Create(Self);
    cdsCopia.Data := cdsItens.Data;
  End;

  cdsItens.AfterScroll    := pAfterScroll;
  cdsItens.BeforePost     := pBeforePost;

  cdsItens.AfterPost      := pAfterPost;
  cdsItens.OnFilterRecord := pFilterRecord;

  If blnDocOri Then
  Begin
    lblMarcaParc.Visible := False;
  End;

  blnAbandono := False;
end;

procedure TfrmEntSelItens.dbgItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of

    VK_Escape : Begin
                  blnAbandono := True;
                  If cdsItens.State <> dsEdit Then
                    btnSairSelecao.Click
                  Else
                  Begin
                    If Not blnDocOri Then
                    Begin
                      dbgItens.Columns[7].ReadOnly := True;
                      dbgItens.Columns[8].ReadOnly := True;
                      dbgItens.Options := dbgItens.Options - [dgEditing];
                    End;
                  End;
                End;

    VK_Return : Begin
                  blnAbandono := False;
                  If cdsItens.State <> dsEdit Then
                    pSelecionaDuplicata
                  Else
                  Begin
                    If Not blnDocOri Then
                    Begin
                      blnErro := False;
                      blnEnter:= True;
                      dbgItens.Columns[7].ReadOnly := True;
                      dbgItens.Columns[8].ReadOnly := True;
                      dbgItens.Options := dbgItens.Options - [dgEditing];
                      cdsItens.Post;
                      blnEnter := False;

                      If Not blnErro Then
                      Begin
                        If dbgItens.SelectedField = cdsItens.FieldByName('ENT_QTDITE') Then
                        Begin
                          dbgItens.Options := dbgItens.Options + [dgEditing];
                          dbgItens.Columns[7].ReadOnly := False;
                          dbgItens.Columns[8].ReadOnly := False;
                          dbgItens.SelectedField := cdsItens.FieldByName('ENT_UNITAR');
                          cdsItens.Edit;
                        End;
                      End;
                    End;

                  End;

                End;

    VK_F10    : Begin
                  blnAbandono := False;
                  btnConfirma.Click;
                End;
    VK_F9     : btnMarca.Click;
    VK_F8     : btnDesmarca.Click;
    VK_F5     : btnIniBus.Click;
    VK_F6     : btnLocProx.Click;
  End;

end;

procedure TfrmEntSelItens.pAfterScroll(Dataset: TDataset);
begin
  intRecNo := Dataset.RecNo;
end;

procedure TfrmEntSelItens.pAfterPost(Dataset: TDataset);
Begin
//  If Assigned(cdsCopia) Then
//    cdsCopia.Data := cdsItens.Data;
End;

procedure TfrmEntSelItens.pBeforePost(Dataset: TDataset);
  Var
    fltQtdNov,
    fltQtdOri: Double;
begin

  If (cdsItens.FieldByName('ENT_QTDITE').AsFloat <= 0) Or
     ( Not blnAltMai And
     ( Not fVerificaQuantidadeAMaior(cdsItens.FieldByName('ENT_CODITE').AsString,
                                    cdsItens.FieldByName('ENT_QTDITE').AsFloat,
                                    fltQtdIteI,
                                    cdsCopia,
                                    qryItePed,
                                    fltQtdOri,
                                    fltQtdNov))) Then
  Begin
    blnErro := True;

    If cdsItens.FieldByName('ENT_QTDITE').AsFloat <= 0 Then
      fMensagem('ATENÇÃO!', 'O valor da Quantidade deve ser maior que 0 (zero)!', ['&O k'])
    Else
      fMensagem('ATENÇÃO!', 'A quantidade total do item deve ser menor ou igual a ' + FormatFloat('#0.00', fltQtdOri) + '!', ['&O k']);

    If blnEnter Then
    Begin
      dbgItens.Options := dbgItens.Options + [dgEditing];
      dbgItens.Columns[7].ReadOnly := False;
      dbgItens.Columns[8].ReadOnly := False;
      cdsItens.Edit;
      cdsItens.FieldByName('ENT_QTDITE').AsFloat := fltQtdIteI;
      dbgItens.SelectedField := cdsItens.FieldByName('ENT_QTDITE');
      dbgItens.SelectedField.FocusControl;
    End
    Else
    Begin
      cdsItens.FieldByName('ENT_QTDITE').AsFloat := fltQtdIteI;
      dbgItens.Options := dbgItens.Options - [dgEditing];
      dbgItens.Columns[7].ReadOnly := True;
      dbgItens.Columns[8].ReadOnly := True;
    End;
    Exit;
  End;

  If (cdsItens.FieldByName('ENT_UNITAR').AsFloat <= 0) Or
     (Not fVerificaVariacaoPreco(qryItePed,
                                 cdsItens.FieldByName('ENT_CODITE').AsString,
                                 cdsItens.FieldByName('ENT_UNITAR').AsFloat,
                                 fltOciVlr)) Then
  Begin
    blnErro := True;

    If (cdsItens.FieldByName('ENT_UNITAR').AsFloat <= 0) Then
      fMensagem('ATENÇÃO!', 'O Valor Unitário deve ser maior que 0 (zero)!', ['&O k']);

    If blnEnter Then
    Begin
      dbgItens.Options := dbgItens.Options + [dgEditing];
      dbgItens.Columns[7].ReadOnly := False;
      dbgItens.Columns[8].ReadOnly := False;
      cdsItens.Edit;
      cdsItens.FieldByName('ENT_UNITAR').AsFloat := fltUnitarI;
      dbgItens.SelectedField := cdsItens.FieldByName('ENT_UNITAR');
      dbgItens.SelectedField.FocusControl;
    End
    Else
    Begin
      cdsItens.FieldByName('ENT_UNITAR').AsFloat := fltUnitarI;
      dbgItens.Options := dbgItens.Options - [dgEditing];
      dbgItens.Columns[7].ReadOnly := True;
      dbgItens.Columns[8].ReadOnly := True;
    End;
    Exit;
  End;

  With Dataset Do
  Begin
    FieldByName('ENT_TOTITE').AsFloat := (FieldByName('ENT_QTDITE').AsFloat * FieldByName('ENT_UNITAR').AsFloat);
    FieldByName('ENT_TOTSUB').AsFloat := (FieldByName('ENT_TOTITE').AsFloat * FieldByName('ENT_PERSUB').AsFloat) /100;
    FieldByName('ENT_VALIPI').AsFloat := (FieldByName('ENT_TOTITE').AsFloat * FieldByName('ENT_PERIPI').AsFloat) /100;
    FieldByName('ENT_VALICM').AsFloat := (FieldByName('ENT_TOTITE').AsFloat * FieldByName('ENT_ICMENT').AsFloat) /100;
    FieldByName('ENT_TOTGER').AsFloat := (FieldByName('ENT_TOTITE').AsFloat + FieldByName('ENT_TOTSUB').AsFloat + FieldByName('ENT_VALIPI').AsFloat);

    dbgItens.Options := dbgItens.Options - [dgEditing];
  End;

end;

procedure TfrmEntSelItens.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of

    VK_Space : Begin
                 {***************************************************}
                 {* IF COMENTADO A PEDIDO DO RONALDO DIA 10/05/2012 *}
                 {* PARA CLIENTE TINTOCAR                           *}
                 {************************************************AF*}
//                 If Not blnDocOri Then
//                 Begin
                   Key := 0;
                   dbgItens.Options := dbgItens.Options + [dgEditing];
                   dbgItens.Columns[7].ReadOnly := False;
                   dbgItens.Columns[8].ReadOnly := False;
                   cdsItens.Edit;
                   dbgItens.SelectedField := cdsItens.FieldByName('ENT_QTDITE');
                   dbgItens.SelectedField.FocusControl;
//                 End;
               End;
  End;

end;

procedure TfrmEntSelItens.FormCreate(Sender: TObject);
begin
  inherited;

  fltQtdIteI := 0;
  fltUnitarI := 0;

  blnConfirma := False;
  strOrdIte := '';

  qryItePed := Nil;
  fltOciVlr := fCfgSis('OCIVLR', VarDouble);
end;

procedure TfrmEntSelItens.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  If blnAbandono Then
  Begin
    If fMensagem('AVISO', 'Abandonar seleção?', ['', '']) = 2 Then
    Begin
      Action := caNone;
      Exit;
    End;
  End;

  inherited;

  If Not blnConfirma Then
    pDeletaTabelaEntradaMercadorias;

  qryItePed.Filtered := False;
  qryItePed.Filter   := '';
end;

procedure TfrmEntSelItens.btnConfirmaClick(Sender: TObject);
  Var
    frmSelOrdItens: TfrmSelOrdItens;
begin
  inherited;

  If (cdsTotais.RecordCount <= 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar pelo menos um Item!', ['&O k']);
    Exit;
  End;

  pCalculaTotal;
  pAtualizaTemporaria;

  If blnAltMai And (Not fVerificaVariacaoQuantidadeFinal(cdsItens, qryItePed, cdsCopia)) Then
  Begin
    Exit;
  End;

  Try

    pCriarFormularios(TfrmSelOrdItens, frmSelOrdItens);

    If frmSelOrdItens.ShowModal = mrok Then
    Begin

      Case frmSelOrdItens.rdgOrdem.ItemIndex Of
        0 : strOrdIte := ' ENT_DESITE ';
        1 : strOrdIte := ' ENT_NUMSEL, ENT_NUMPED, ENT_SEQPCD '
      End;

      pDeletaItensDesmarcados;
      strCodFor   := cdsItens.FieldByName('ENT_CODFOR').AsString;
      blnConfirma := True;
      Close;

    End;

  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      pMensagensErro(E.Message, '[frmEntSelItens.btnConfirmaClick]');
    End;
  End;

  pFreeAndNil(frmSelOrdItens);

end;

procedure TfrmEntSelItens.pAtualizaTemporaria;
Var
  strSQL : String;
  qryUpd : TUniQuery;
Begin

  Try

    Try

      cdsItens.DisableControls;

      qryUpd := fCriaQuery(Self);

      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + '  TMP_ENTMER ';
      strSQL := strSQL + 'SET ';
      strSQL := strSQL + '  ENT_QTDITE = :QTDITE, ';
      strSQL := strSQL + '  ENT_UNITAR = :UNITAR, ';
      strSQL := strSQL + '  ENT_BASICM = :BASICM, ';
      strSQL := strSQL + '  ENT_BASIPI = :BASIPI, ';
      strSQL := strSQL + '  ENT_TOTSUB = :TOTSUB, ';
      strSQL := strSQL + '  ENT_VALIPI = :VALIPI, ';
      strSQL := strSQL + '  ENT_VALICM = :VALICM, ';
      strSQL := strSQL + '  ENT_TOTITE = :TOTITE, ';
      strSQL := strSQL + '  ENT_TOTGER = :TOTGER, ';
      strSQL := strSQL + '  ENT_MARDES = :MARDES, ';
      strSQL := strSQL + '  ENT_NUMSEL = :NUMSEL ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  ENT_NUMPED = :NUMPED AND ';
      strSQL := strSQL + '  ENT_CODITE = :CODITE AND ';
      strSQL := strSQL + '  ENT_CODGRU = :CODGRU AND ';
      strSQL := strSQL + '  ENT_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  AUTOINCREM = :AUTINC ';

      With qryUpd Do
      Begin

        cdsItens.First;

        While Not cdsItens.Eof Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          {*****************************************}
          {* DADOS QUE SERÃO ALTERADOS             *}
          {**************************************LU*}
          ParamByName('QTDITE').AsFloat   := cdsItens.fieldbyname('ENT_QTDITE').AsFloat;
          ParamByName('UNITAR').AsFloat   := cdsItens.fieldbyname('ENT_UNITAR').AsFloat;
          ParamByName('BASICM').AsFloat   := cdsItens.fieldbyname('ENT_TOTITE').AsFloat;
          ParamByName('BASIPI').AsFloat   := cdsItens.fieldbyname('ENT_TOTITE').AsFloat;
          ParamByName('TOTSUB').AsFloat   := cdsItens.fieldbyname('ENT_TOTSUB').AsFloat;
          ParamByName('VALIPI').AsFloat   := cdsItens.fieldbyname('ENT_VALIPI').AsFloat;
          ParamByName('VALICM').AsFloat   := cdsItens.fieldbyname('ENT_VALICM').AsFloat;
          ParamByName('TOTITE').AsFloat   := cdsItens.fieldbyname('ENT_TOTITE').AsFloat;
          ParamByName('TOTGER').AsFloat   := cdsItens.fieldbyname('ENT_TOTGER').AsFloat;
          ParamByName('MARDES').AsString  := cdsItens.fieldbyname('ENT_MARDES').AsString;
          ParamByName('NUMSEL').AsInteger := cdsItens.fieldbyname('ENT_NUMSEL').AsInteger;

          {*****************************************}
          {* DADOS DO FILTRO                       *}
          {**************************************LU*}
          ParamByName('NUMPED').AsString  := cdsItens.fieldbyname('ENT_NUMPED').AsString;
          ParamByName('CODITE').AsString  := cdsItens.fieldbyname('ENT_CODITE').AsString;
          ParamByName('CODGRU').AsString  := cdsItens.fieldbyname('ENT_CODGRU').AsString;
          ParamByName('CODEMP').AsString  := cdsItens.fieldbyname('ENT_CODEMP').AsString;
          ParamByName('AUTINC').AsInteger := cdsItens.fieldbyname('AUTOINCREM').AsInteger;
          ExecSQL;

          cdsItens.Next;
        End;

      End;

    Finally
      cdsItens.EnableControls;
      FreeAndNil(qryUpd);
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pAtualizaTemporaria]');
    End;
  End;

End;

procedure TfrmEntSelItens.cdsItensBeforeEdit(DataSet: TDataSet);
begin
  inherited;

  With DataSet Do
  Begin
    fltQtdIteI := fieldbyname('ENT_QTDITE').AsFloat;
    fltUnitarI := fieldbyname('ENT_UNITAR').AsFloat;
  End;

end;

procedure TfrmEntSelItens.cdsItensBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  Abort;
  dbgItens.Options := dbgItens.Options - [dgEditing];
  blnEnter := False;
end;

procedure TfrmEntSelItens.pDeletaItensDesmarcados;
  Var
    strSQL: String;
    qryGenMer: TUniQuery;
begin
  Try

    qryGenMer := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  TMP_ENTMER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ENT_MARDES <> "M" ';

    With qryGenMer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;

  Finally
    FreeAndNil(qryGenMer);
  End;

end;

procedure TfrmEntSelItens.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := (Pos(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) > 0);
end;

end.

