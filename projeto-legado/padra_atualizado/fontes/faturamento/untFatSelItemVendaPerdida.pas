unit untFatSelItemVendaPerdida;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, UniClientDataSet, DB, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, Generics.Collections, Uni, untFuncFatTypes,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmFatSelItemVendaPerdida = class(TfrmPai)
    grdItensLevel1: TcxGridLevel;
    grdItensTableView1: TcxGridDBTableViewCitel;
    grdItens: TcxGridCitel;
    dtsDados: TDataSource;
    grdItensTableViewCODITE: TcxGridDBColumn;
    grdItensTableViewDESITE: TcxGridDBColumn;
    grdItensTableViewQTDITE: TcxGridDBColumn;
    grdItensTableViewSIGUNI: TcxGridDBColumn;
    grdItensTableViewUNITAR: TcxGridDBColumn;
    grdItensTableViewTOTITE: TcxGridDBColumn;
    grdItensTableViewNOMMOT: TcxGridDBColumn;
    btnConfirma: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnObservacoes: TBitBtnLocked;
    grdItensTableViewMARDES: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdItensTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdItensTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdItensTableView1DblClick(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnObservacoesClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdItensTableView1KeyPress(Sender: TObject; var Key: Char);
  private
    FItens: TObjectList<TItemVendasPerdidas>;
    function fCriaClientItens: TUniClientDataSet;
    procedure pInsereItens;
    procedure pMarcaIndividual();
    procedure pMarcaTodos(blnStatus: Boolean);
    procedure pMarca(blnStatus: Boolean; strCodMot, strDesMot, strObserv, strCodCon: String; fltVlrCon: Double);
    procedure pAfterScroll(DataSet: TDataSet);
  public
    blnExisteDocumento: Boolean;
    blnExisteOcorrencia: Boolean;
    cdsDados: TUniClientDataSet;
    cdsVenda: TUniClientDataSet;

    property oblItens: TObjectList<TItemVendasPerdidas> read FItens;
  end;

var
  frmFatSelItemVendaPerdida: TfrmFatSelItemVendaPerdida;

implementation

{$R *.dfm}

uses untFuncoesSimples, untDigMotivoVendaPerdida, untObservacao,
  untVendasPerdidas, untTypesSistema, untConsultas;

procedure TfrmFatSelItemVendaPerdida.btnConfirmaClick(Sender: TObject);
Var
  objItem: TItemVendasPerdidas;
   strMsg: String;

  function fMarcouTodos: boolean;
  begin
    With cdsDados Do
    begin
      DisableControls;
      Filtered := False;
      Filter := 'MARDES = ''D''';
      Filtered := True;
      Result := IsEmpty;
      EnableControls;
    end;
  end;

begin
  inherited;
  With cdsDados Do
  Begin
    if fMarcouTodos and blnExisteDocumento then
      strMsg := 'Todos os itens foram selecionados.'+#13+
                'A venda perdida será efetuada juntamente com a ' +
                IIF(blnExisteOcorrencia, 'baixa', 'exclusão') +' do documento.'+#13+
                'Deseja confirmar esta operação?'
    else
      strMsg := 'Os produtos selecionados serão incluídos em vendas perdidas e removidos da tela de principal de vendas. Confirma esta operação?';

    DisableControls;
    Filter := 'MARDES = ''M''';
    Filtered := True;
    Try
      if IsEmpty Then
      Begin
        fMensagem('', 'Nenhum item foi selecionado!', ['&Ok']);
        Exit;
      End;

      if fMensagem('Confirmação',strMsg, ['&Sim', '&Não']) = 1 Then
      Begin
        FItens.Clear;

        First;
        While Not Eof Do
        Begin
          objItem := TItemVendasPerdidas.Create();
          objItem.strAutoIncrem := FieldByName('AUTOINCREM').AsString;
          objItem.strCodIte     := FieldByName('CODITE').AsString;
          objItem.strDesIte     := FieldByName('DESITE').AsString;
          objItem.fltQtdIte     := FieldByName('QTDITE').AsFloat;
          objItem.fltUniOri     := FieldByName('UNIORI').AsFloat;
          objItem.fltUnitar     := FieldByName('UNITAR').AsFloat;
          objItem.fltTotIte     := FieldByName('TOTITE').AsFloat;
          objItem.strCodMot     := FieldByName('CODMOT').AsString;
          objItem.strObserv     := FieldByName('OBSERV').AsString;
          objItem.strIteNov     := FieldByName('ITENOV').AsString;
          objItem.strCodCon     := FieldByName('CODCON').AsString;
          ObjItem.fltVlrCon     := FieldByName('VLRCON').AsFloat;
          objItem.strNumCmp     := FieldByName('NUMCMP').AsString;
          objItem.intNItCmp     := FieldByName('NITCMP').AsInteger;
          objItem.dtaDtaCmp     := FieldByName('DTACMP').AsDateTime;

          FItens.Add(objItem);

          Next;
        End;

        ModalResult := mrOk;
      End;
    Finally
      Filtered := False;
      Filter := '';
      EnableControls;
    End;
  End;
end;

procedure TfrmFatSelItemVendaPerdida.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcaTodos(False);
end;

procedure TfrmFatSelItemVendaPerdida.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcaTodos(True);
end;

procedure TfrmFatSelItemVendaPerdida.btnObservacoesClick(Sender: TObject);
begin
  inherited;
  pCriarFormularios(TfrmObservacao, frmObservacao);
  Try
    frmObservacao.blnUtilizarConfirmacao := True;
    frmObservacao.Caption := 'Inclusão do item em vendas perdidas';
    frmObservacao.lblMensagem.Caption := 'Observações';
    frmObservacao.memObs.Texto := cdsDados.FieldByName('OBSERV').AsString;
    frmObservacao.ShowModal;

    If frmObservacao.blnConfirmou Then
    Begin
      cdsDados.Edit;
      cdsDados.FieldByName('OBSERV').AsString := frmObservacao.memObs.Texto;
      cdsDados.Post;
    End;
  Finally
    FreeAndNil(frmObservacao);
  End;
end;

function TfrmFatSelItemVendaPerdida.fCriaClientItens: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Self);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'AUTOINCREM';
    DataType := ftString;
    Size     := 20;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODITE';
    DataType := ftString;
    Size     := fTamCodIte;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DESITE';
    DataType := ftString;
    Size     := 70;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'QTDITE';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'SIGUNI';
    DataType := ftString;
    Size     := 4;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'UNIORI';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'UNITAR';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'TOTITE';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODMOT';
    DataType := ftString;
    Size     := 5;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'NOMMOT';
    DataType := ftString;
    Size     := 46;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'OBSERV';
    DataType := ftMemo;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITENOV';
    DataType := ftString;
    Size     := 1;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'MARDES';
    DataType := ftString;
    Size     := 1;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODCON';
    DataType := ftString;
    Size     := 5;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'VLRCON';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'NUMCMP';
    DataType := ftString;
    Size     := 15;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'NITCMP';
    DataType := ftInteger;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DTACMP';
    DataType := ftDateTime;
  End;

  Result.CreateDataSet;
end;

procedure TfrmFatSelItemVendaPerdida.FormCreate(Sender: TObject);
begin
  inherited;
  blnExisteDocumento := false;
  blnExisteOcorrencia := False;
  cdsDados := fCriaClientItens;
  cdsDados.AfterScroll := pAfterScroll;

  Self.cdsVenda := TUniClientDataSet.Create(Self);

  FItens := TObjectList<TItemVendasPerdidas>.Create(False);
end;

procedure TfrmFatSelItemVendaPerdida.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FItens);
end;

procedure TfrmFatSelItemVendaPerdida.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F5: If btnMarcarTodos.Enabled And btnMarcarTodos.Visible Then btnMarcarTodos.Click;
    VK_F6: If btnDesmarcarTodos.Enabled And btnDesmarcarTodos.Visible Then btnDesmarcarTodos.Click;
    VK_F9: If btnObservacoes.Enabled And btnObservacoes.Visible Then btnObservacoes.Click;
    VK_F10: If btnConfirma.Enabled And btnConfirma.Visible Then btnConfirma.Click;
    VK_ESCAPE: pEscapePressed;
  End;
end;

procedure TfrmFatSelItemVendaPerdida.FormShow(Sender: TObject);
begin
  inherited;
  pInsereItens;

  TFloatField(cdsDados.FieldByName('QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  TFloatField(cdsDados.FieldByName('UNITAR')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  TFloatField(cdsDados.FieldByName('TOTITE')).DisplayFormat := fMskDigitos(2);

  dtsDados.DataSet := cdsDados;
end;

procedure TfrmFatSelItemVendaPerdida.grdItensTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdItensTableViewMARDES.Index]) = 'M' Then
  Begin
    If AViewInfo.Selected Then
      ACanvas.Font.Color := clLime
    Else
      ACanvas.Font.Color := clBlue;
  End;
end;

procedure TfrmFatSelItemVendaPerdida.grdItensTableView1DblClick(
  Sender: TObject);
begin
  inherited;
  pMarcaIndividual;
end;

procedure TfrmFatSelItemVendaPerdida.grdItensTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
    pMarcaIndividual;
end;

procedure TfrmFatSelItemVendaPerdida.grdItensTableView1KeyPress(Sender: TObject; var Key: Char);
  Var
    arrMotivo: TConsultasArray;
    qryMotVpd: TUniQuery;
begin
  inherited;
  If fEntraCons(Key) And grdItensTableViewNOMMOT.Focused Then
  Begin
    qryMotVpd := fCriaQuery(nil);

    If fPesqMotVendasPerdidas(Self, nil, nil, qryMotVpd, Key, arrMotivo) Then
    Begin
      pMarca(True, qryMotVpd.FieldByName('MOT_CODMOT').AsString,
                   qryMotVpd.FieldByName('MOT_DESMOT').AsString, '', '', 0);
    End;

    FreeAndNil(qryMotVpd);
  End;
end;

procedure TfrmFatSelItemVendaPerdida.pAfterScroll(DataSet: TDataSet);
begin
  btnObservacoes.Enabled := (cdsDados.FieldByName('MARDES').AsString = 'M');
end;

procedure TfrmFatSelItemVendaPerdida.pInsereItens;
begin
  With Self.cdsVenda Do
  Begin
    First;
    While Not Eof Do
    Begin
      cdsDados.Append;
      cdsDados.FieldByName('AUTOINCREM').AsString := FieldByName('AUTOINCREM').AsString;
      cdsDados.FieldByName('CODITE').AsString     := FieldByName('ITE_CODITE').AsString;
      cdsDados.FieldByName('DESITE').AsString     := FieldByName('ITE_DESITE').AsString;
      cdsDados.FieldByName('QTDITE').AsFloat      := FieldByName('ITE_QTDITE').AsFloat;
      cdsDados.FieldByName('SIGUNI').AsString     := FieldByName('ITE_SIGUNI').AsString;
      cdsDados.FieldByName('UNIORI').AsFloat      := FieldByName('ITE_UNIORI').AsFloat;
      cdsDados.FieldByName('UNITAR').AsFloat      := FieldByName('ITE_UNITAR').AsFloat;
      cdsDados.FieldByName('TOTITE').AsFloat      := FieldByName('ITE_TOTITE').AsFloat;
      cdsDados.FieldByName('ITENOV').AsString     := FieldByName('ITE_ITENOV').AsString;
      cdsDados.FieldByName('NUMCMP').AsString     := FieldByName('ITE_NUMCMP').AsString;
      cdsDados.FieldByName('NITCMP').AsInteger    := FieldByName('ITE_NITCMP').AsInteger;
      cdsDados.FieldByName('DTACMP').AsDateTime   := FieldByName('ITE_DTACMP').AsDateTime;
      cdsDados.FieldByName('MARDES').AsString     := 'D';
      cdsDados.Post;

      Next;
    End;
  End;
end;

procedure TfrmFatSelItemVendaPerdida.pMarca(blnStatus: Boolean; strCodMot, strDesMot, strObserv, strCodCon: String; fltVlrCon: Double);
begin
  If blnStatus Then
  Begin
    cdsDados.Edit;
    cdsDados.FieldByName('CODMOT').AsString := strCodMot;
    cdsDados.FieldByName('NOMMOT').AsString := strCodMot + '-' + strDesMot;
    cdsDados.FieldByName('OBSERV').AsString := strObserv;
    cdsDados.FieldByName('CODCON').AsString := strCodCon;
    cdsDados.FieldByName('VLRCON').AsFloat  := fltVlrCon;

    cdsDados.FieldByName('MARDES').AsString := 'M';
    cdsDados.Post;
  End
  Else
  Begin
    cdsDados.Edit;
    cdsDados.FieldByName('CODMOT').Clear;
    cdsDados.FieldByName('NOMMOT').Clear;
    cdsDados.FieldByName('OBSERV').Clear;
    cdsDados.FieldByName('CODCON').Clear;
    cdsDados.FieldByName('VLRCON').Clear;

    cdsDados.FieldByName('MARDES').AsString     := 'D';
    cdsDados.Post;
  End;
end;

procedure TfrmFatSelItemVendaPerdida.pMarcaIndividual;
begin
  if (cdsDados.FieldByName('MARDES').AsString = 'D') Then
  Begin
    pCriarFormularios(TfrmDigMotivoVendaPerdida, frmDigMotivoVendaPerdida);
    Try
      If frmDigMotivoVendaPerdida.ShowModal = mrOk Then
      Begin
        pMarca(True,
               frmDigMotivoVendaPerdida.strCodMot,
               frmDigMotivoVendaPerdida.strDesMot,
               frmDigMotivoVendaPerdida.strObservacoes,
               frmDigMotivoVendaPerdida.strCodCon,
               frmDigMotivoVendaPerdida.fltVlrCon);
      End;
    Finally
      FreeAndNil(frmDigMotivoVendaPerdida);
    End;
  End
  Else
    pMarca(False, '', '', '', '', 0);

  grdItensTableView1.NavigatorButtons.Next.Click;
end;

procedure TfrmFatSelItemVendaPerdida.pMarcaTodos(blnStatus: Boolean);
var
  strCodCon,
  strCodMot,
  strDesMot,
  strObserv: String;
  intRowNum: Integer;
  fltVlrCon: Double;
begin
  if blnStatus Then
  Begin
    pCriarFormularios(TfrmDigMotivoVendaPerdida, frmDigMotivoVendaPerdida);
    Try
      If frmDigMotivoVendaPerdida.ShowModal = mrOk Then
      Begin
        strCodMot := frmDigMotivoVendaPerdida.strCodMot;
        strDesMot := frmDigMotivoVendaPerdida.strDesMot;
        strObserv := frmDigMotivoVendaPerdida.strObservacoes;
        strCodCon := frmDigMotivoVendaPerdida.strCodCon;
        fltVlrCon := frmDigMotivoVendaPerdida.fltVlrCon;
      End
      Else
        Exit;
    Finally
      FreeAndNil(frmDigMotivoVendaPerdida);
    End;
  End
  Else
  Begin
    strCodMot := '';
    strDesMot := '';
    strObserv := '';
    strCodCon := '';
    fltVlrCon := 0;
  End;

  With cdsDados Do
  Begin
    intRowNum := RecNo;
    DisableControls;
    Try
      First;
      While Not Eof Do
      Begin
        if (cdsDados.FieldByName('MARDES').AsString = 'M') Xor blnStatus Then
          pMarca(blnStatus, strCodMot, strDesMot, strObserv, strCodCon, fltVlrCon);

        Next;
      End;
    Finally
      RecNo := intRowNum;
      EnableControls;
    End;
  End;
end;

end.
