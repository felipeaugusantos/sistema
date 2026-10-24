unit untCadCtaPagarPrevisao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, Vcl.StdCtrls,
  Vcl.DBCtrls, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, EditFocus,
  Vcl.Mask, DBEditFocus, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  Vcl.Menus, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, untConstantes, untfuncoesSimples,
  cxCurrencyEdit, cxCalendar;

type

  TProcedureDataSet = reference to procedure (objDataSet: TDataSet);

  TfrmCadCtaPagarPrevisao = class(TfrmPaiConfirma)
    pnlGeral: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label15: TLabel;
    dbeNumDup: TDBEditFocus;
    dbeParcel: TDBEditFocus;
    dbeCodEmp: TDBEditFocus;
    dbeCodFor: TDBEditFocus;
    dbeSerie: TDBEditFocus;
    grdCtaPag: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    Panel1: TPanel;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    DBEditFocus1: TDBEditFocus;
    DBEditFocus3: TDBEditFocus;
    DBEditFocus4: TDBEditFocus;
    DBMemo1: TDBMemo;
    Label6: TLabel;
    grdCtaPagDTACAD: TcxGridDBColumn;
    grdCtaPagCOMPET: TcxGridDBColumn;
    grdCtaPagVENCTO: TcxGridDBColumn;
    grdCtaPagVRLORI: TcxGridDBColumn;
    grdCtaPagVRLDES: TcxGridDBColumn;
    grdCtaPaVRLJUR: TcxGridDBColumn;
    grdCtaPagVRLMUL: TcxGridDBColumn;
    grdCtaPagVLRTOT: TcxGridDBColumn;
    dtsTabela: TDataSource;
    btnAlterarVencimento: TBitBtnLocked;
    grdCtaPagAUTINC: TcxGridDBColumn;
    DBENOMFOR: TDBEditFocus;
    DBENOMEMP: TDBEditFocus;
    DBEditFocus6: TDBEditFocus;
    DBEditFocus7: TDBEditFocus;
    DBEditFocus8: TDBEditFocus;
    btnConverterPrevisaoEmCTP: TBitBtnLocked;
    Panel2: TPanel;
    grdCtaPagCONVERTER_DESPESA: TcxGridDBColumn;
    grdCtaPagCONVERTER_DATADECADASTRO: TcxGridDBColumn;
    lbParcela: TLabel;
    DBEditFocus2: TDBEditFocus;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAlterarVencimentoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConverterPrevisaoEmCTPClick(Sender: TObject);
    procedure grdCtaPagCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnConfirmaClick(Sender: TObject);
    procedure grdCtaPagCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdCtaPagVENCTOPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FstrCodFor,
    FstrDataCadastro: String;
    FstrAutoIncrem: String;
    FcurVlrTot: Currency;
    FblnMostraMensagem: Boolean;
    procedure fAfterOpen(DataSet: TDataSet);
    procedure pConverterDespesa(strAutoIncrem: String; blnAlteraDataCadastro: Boolean);
  public
    { Public declarations }
    function fCarregar: TfrmCadCtaPagarPrevisao;
    function fAutoIncrem: String;
    function fCodFor(strCodFor: String):  TfrmCadCtaPagarPrevisao; overload;
    function fCodFor: String; overload;
    function fDataCadastro(strDataCadastro: String):  TfrmCadCtaPagarPrevisao; overload;
    function fDataCadastro: String; overload;
    function fVlrTot(curVlrTot: Currency):  TfrmCadCtaPagarPrevisao;
    function fExecutar(objProc: TProcedureDataSet): TfrmCadCtaPagarPrevisao;
  end;

var
  frmCadCtaPagarPrevisao: TfrmCadCtaPagarPrevisao;

implementation

{$R *.dfm}

procedure TfrmCadCtaPagarPrevisao.btnConfirmaClick(Sender: TObject);
begin
  FblnMostraMensagem := False;
  If fEmptyStr(fAutoIncrem) Then
  Begin
    fMensagem('ATENÇÃO!','É necessário selecionar um registro!', ['&Ok']);
    ModalResult := mrCancel;
    Abort;
  End
  Else
    ModalResult := mrOK;
end;

procedure TfrmCadCtaPagarPrevisao.btnConverterPrevisaoEmCTPClick(Sender: TObject);
Var
  intRecNo: Integer;
  blnPodeAlterarDataCadastro,
  blnAlteraDataCadastro: Boolean;
begin
  inherited;

  //Desmarca Linha
  If qryTabela.FieldByName('AUTOINCREM').AsString = fAutoIncrem Then
  Begin
    qryTabela.Edit;
    qryTabela.FieldByName('CONVERTER_DESPESA').AsString := '0';
    qryTabela.FieldByName('CONVERTER_DATADECADASTRO').AsString := '0';
    qryTabela.Post;
    FstrAutoIncrem := '';
    Exit;
  End;

  //Somente uma linha pode ser selecionada
  intRecNo := qryTabela.recNo;
  qryTabela.DisableControls;
  Try
    qryTabela.Filtered := False;
    qryTabela.Filter := 'CONVERTER_DESPESA = 1';
    qryTabela.Filtered := True;

    If (Not qryTabela.isEmpty) Then
    Begin
      If (fMensagem('',
                    'Somente é possível selecionar 1 registro!' + #13#10+
                    'Gostaria de alterar para esse registro? ',
                    ['&Sim', '&Não']) = 2) Then
        Exit;
    End;
  Finally
    qryTabela.Filtered := False;
    qryTabela.Filter := '';
    qryTabela.recNo := intRecNo;
    qryTabela.EnableControls;
  End;


  //Marca a linha
  If (FcurVlrTot <>  qryTabela.FieldByName('VLRTOT').AsCurrency) And
   ( fMensagem('',
    'O valor da Previsão escolhida é diferente do vr.contábil que está sendo inclúido. ' +
      'Deseja continuar e já alterar o lançamento no Contas a Pagar ?',
    ['&Sim', '&Não']) = 2) Then
    Exit;

  If (fMensagem('',
     'Esta operação irá converter o registro escolhido do Contas a Pagar de Previsão em ' +
     'Despesa conforme o documento que está sendo incluído no Livro Fiscal, com ' +
     'vencimento em ' + qryTabela.FieldByName('CTP_DTAVEN').DisplayText + '.' + #13 +
     'Deseja efetivar a operação ?',
    ['&Sim', '&Não']) = 2) Then
    Exit;

  blnPodeAlterarDataCadastro := (StrToDateTime(fDataCadastro) <> StrToDateTime(qryTabela.FieldByName('CTP_DTACAD').DisplayText));
  blnPodeAlterarDataCadastro := blnPodeAlterarDataCadastro And (StrToDateTime(fDataCadastro) <= StrToDateTime(qryTabela.FieldByName('CTP_DTAVEN').DisplayText));

  If blnPodeAlterarDataCadastro And (fMensagem('',
     'Gostaria de atualizar a data de cadastro ' + qryTabela.FieldByName('CTP_DTACAD').DisplayText +
     ' do registro escolhido ' + #13 + ' para do documento vinculado '+fDataCadastro+' ? ',
    ['&Sim', '&Não']) = 1) Then
    blnAlteraDataCadastro := True
  Else
    blnAlteraDataCadastro := False;

   pConverterDespesa(qryTabela.FieldByName('AUTOINCREM').AsString, blnAlteraDataCadastro);
end;

procedure TfrmCadCtaPagarPrevisao.btnAlterarVencimentoClick(Sender: TObject);
begin
  inherited;
  grdCtaPagVENCTO.Options.Editing := Not grdCtaPagVENCTO.Options.Editing;
  cxGrid1.Repaint;
end;

function TfrmCadCtaPagarPrevisao.fCodFor: String;
begin
  Result := FstrCodFor;
end;

function TfrmCadCtaPagarPrevisao.fDataCadastro(
  strDataCadastro: String): TfrmCadCtaPagarPrevisao;
begin
  Result := Self;
  FstrDataCadastro := strDataCadastro;
end;

function TfrmCadCtaPagarPrevisao.fDataCadastro: String;
begin
  Result := FstrDataCadastro;
end;


procedure TfrmCadCtaPagarPrevisao.fAfterOpen(DataSet: TDataSet);
Var
  objField: TField;
begin
  For objField In DataSet.Fields Do
    case objField.DataType of
      ftCurrency,
      ftFloat,
      ftBCD,
      ftFMTBcd: TFloatField(objField).DisplayFormat := '#,###0.00';
    end;
end;

function TfrmCadCtaPagarPrevisao.fAutoIncrem: String;
begin
  Result := FstrAutoIncrem;
end;

function TfrmCadCtaPagarPrevisao.fCarregar: TfrmCadCtaPagarPrevisao;
begin
  Result := Self;
  qryTabela := fCriarQuery('SELECT CADPAG.*, ' +
    ' IFNULL(CTP_VALDUP,0)  + IFNULL(CTP_JURSUJ,0) + IFNULL(CTP_MULSUJ,0) - IFNULL(CTP_DESSUJ,0) + IFNULL(CTP_VENDOR,0) + IFNULL(CTP_OUTENT,0)  AS VLRTOT,' +
    ' EMP_NOMEMP, ' +
    ' FOR_NOMFOR, ' +
    ' POR_NOMPOR, ' +
    ' EVE_DESEVE, ' +
    ' CTA_DESCTA, ' +
    ' 0 CONVERTER_DESPESA, ' +
    ' 0 CONVERTER_DATADECADASTRO ' +
    'FROM CADPAG  ' +
    'LEFT JOIN CADEMP ON EMP_CODEMP = CTP_CODEMP ' +
    'LEFT JOIN CADFOR ON FOR_CODFOR = CTP_CODFOR ' +
    'LEFT JOIN CADPOR ON POR_CODPOR = CTP_CODPOR ' +
    'LEFT JOIN CADEVE ON EVE_CODEVE = CTP_CODEVE ' +
    'LEFT JOIN CADCTA ON CTA_CODCTA = CTP_CODCTA ' +

    'WHERE CTP_PREVIS = "S" ' +
    'AND  CTP_DTAPAG IS NULL ' +
    'AND CTP_CODFOR = ' + FstrCodFor.QuotedString, Self);
  qryTabela.CachedUpdates := true;
  qryTabela.Open;

  dtsTabela.DataSet := qryTabela;
  qryTabela.AfterOpen := fAfterOpen;

  TDateField(qryTabela.FieldByName('CTP_DTAVEN')).DisplayFormat := 'dd/mm/yyyy';
  TDateField(qryTabela.FieldByName('CTP_DTACAD')).DisplayFormat := 'dd/mm/yyyy';
  TCurrencyField(qryTabela.FieldByName('VLRTOT')).DisplayFormat := '#,##0.00';
  qryTabela.FieldByName('CONVERTER_DESPESA').ReadOnly := False;
  qryTabela.FieldByName('CONVERTER_DATADECADASTRO').ReadOnly := False;
end;

function TfrmCadCtaPagarPrevisao.fCodFor(
  strCodFor: String): TfrmCadCtaPagarPrevisao;
begin
  Result := Self;
  FstrCodFor := strCodFor;
end;

procedure TfrmCadCtaPagarPrevisao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  If FblnMostraMensagem Then
  Begin
    If fEmptyStr(fAutoIncrem) Then
    Begin
      If (fMensagem('', 'Deseja sair ?', ['&Sim', '&Não']) = 1) Then
        modalResult := mrOk;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'Há registro selecionado, utilize o botão confirmar', ['&O k']);
      modalResult := mrCancel;
    End;
  End;

  If modalResult <> mrOk Then
  Begin
    FblnMostraMensagem := True;
    Action := canone;
  End
  Else
    inherited;
end;

procedure TfrmCadCtaPagarPrevisao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F3: btnAlterarVencimento.Click;
    VK_F4: btnConverterPrevisaoEmCTP.Click;
    VK_F10: btnConfirma.Click;
  End;
end;

procedure TfrmCadCtaPagarPrevisao.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_ESCAPE: btnSair.Click;
  End;
end;

procedure TfrmCadCtaPagarPrevisao.FormShow(Sender: TObject);
begin
  inherited;
  FCarregar;
  FblnMostraMensagem:= True;
end;

function TfrmCadCtaPagarPrevisao.fVlrTot(
  curVlrTot: Currency): TfrmCadCtaPagarPrevisao;
begin
  Result := Self;
  FcurVlrTot := curVlrTot;
end;

procedure TfrmCadCtaPagarPrevisao.grdCtaPagCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  btnConverterPrevisaoEmCTP.Click;
end;

procedure TfrmCadCtaPagarPrevisao.grdCtaPagCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdCtaPagCONVERTER_DESPESA.Index]) = '1' Then
  Begin
    If (Not AViewInfo.Selected) Then
      ACanvas.Font.Color := clBlue
    Else
      ACanvas.Font.Color := clLime;
  End;
end;

procedure TfrmCadCtaPagarPrevisao.grdCtaPagVENCTOPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  If Error Then
    pMensagemOk('Data Invalida');

  If (StrToDateDef(DisplayValue,0) < fNow) Then
  Begin
    fMensagem('ATENÇÃO!', 'A data vencimento não pode ser anterior a hoje', ['&O k']);
    DisplayValue := DateToStr(fNow);
    Error := False;
  End;
end;

procedure TfrmCadCtaPagarPrevisao.pConverterDespesa(strAutoIncrem: String;
  blnAlteraDataCadastro: Boolean);
Var
  intRecno: Integer;
begin
  inherited;
  intRecNo := qryTabela.RecNo;
  qryTabela.DisableControls;
  qryTabela.First;
  while Not qryTabela.Eof Do
  Begin
    qryTabela.Edit;
    qryTabela.FieldByName('CONVERTER_DESPESA').AsString := '0';
    qryTabela.FieldByName('CONVERTER_DATADECADASTRO').AsString := '0';

    If qryTabela.FieldByName('AUTOINCREM').AsString = strAutoIncrem Then
    Begin
      qryTabela.FieldByName('CONVERTER_DESPESA').AsString := '1';
      FstrAutoIncrem := qryTabela.FieldByName('AUTOINCREM').AsString;

      If blnAlteradataCadastro Then
        qryTabela.FieldByName('CONVERTER_DATADECADASTRO').AsString := '1';
    End;

    qryTabela.Post;
    qryTabela.Next;
  End;
  qryTabela.RecNo := intRecNo;
  qryTabela.EnableControls;
end;

function TfrmCadCtaPagarPrevisao.fExecutar(
  objProc: TProcedureDataSet): TfrmCadCtaPagarPrevisao;
begin
  Result := Self;
  If ShowModal = mrOk Then
    objProc(qryTabela);
end;

end.
