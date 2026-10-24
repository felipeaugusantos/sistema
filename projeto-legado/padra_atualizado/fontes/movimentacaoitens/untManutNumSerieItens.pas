unit untManutNumSerieItens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untZClient, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, untPesqItem, EditFocus, Uni,
  untFuncoesSimples, untTypesSistema, System.UITypes, untFuncoesConsulta, untPai,
  cxTextEdit;

type
  TfrmManutNumSerieItens = class(TfrmPai)
    cxGridItensDBTableViewItens: TcxGridDBTableView;
    cxGridItensLevel1: TcxGridLevel;
    cxGridItens: TcxGrid;
    pnlConsulta: TPanel;
    cxGridItensDBTableViewItensSER_NUMSER: TcxGridDBColumn;
    cxGridItensDBTableViewItensSER_NNVSER: TcxGridDBColumn;
    pnlLegenda: TPanel;
    shpRed: TShape;
    lblLegNaoPodeEditar: TLabel;
    edtDesIte: TEditFocus;
    lblItem: TLabel;
    btnPesquisarNumeros: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    edtCodIte: TEditFocus;
    cxGridItensDBTableViewItensEDITAR: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure cxGridItensDBTableViewItensFocusedRecordChanged(
      Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridItensDBTableViewItensCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisarNumerosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private
    cdsItens: TZClient;
    qryConPro,
    qryUpdate: TUniQuery;
    stlNumerosUsados: TStringList;
    FStrOldNum: String;
    function fGetSQLItens: String;
    function fGetSQLUpdate: String;
    procedure pAbrirConsulta;
    procedure pConfirmar;
    procedure pBeforePostItens(DataSet: TDataSet);
    procedure pAfterPostItens(DataSet: TDataSet);
    procedure pBeforeEditItens(DataSet: TDataSet);
    function fItemUSASER: Boolean;
    function fExisteNumSerie(AStrCodIte, AStrNumNovo: String): Boolean;
    procedure pLimparTela;
  protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean) : Boolean; Override;

  public
    { Public declarations }
  end;

var
  frmManutNumSerieItens: TfrmManutNumSerieItens;

implementation

{$R *.dfm}

procedure TfrmManutNumSerieItens.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  pConfirmar;
end;

procedure TfrmManutNumSerieItens.btnPesquisarNumerosClick(Sender: TObject);
begin
  inherited;
  pAbrirConsulta;
end;

procedure TfrmManutNumSerieItens.cxGridItensDBTableViewItensCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridItensDBTableViewItensEDITAR.Index]) = 'N' Then
    ACanvas.Brush.Color := shpRed.Brush.Color;
end;

procedure TfrmManutNumSerieItens.cxGridItensDBTableViewItensFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  inherited;
  If Assigned(AFocusedRecord) Then
    cxGridItensDBTableViewItensSER_NNVSER.Options.Editing := VarToStr(Sender.DataController.Values[AFocusedRecord.RecordIndex, cxGridItensDBTableViewItensEDITAR.Index]) = 'S';
end;

procedure TfrmManutNumSerieItens.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, qryConPro, Key, arrSel, True, Nil, 'Consulta de Itens', '1','',
                 0, False, False, 0, cdrCodIte, '', False, '','',True,False,True,'',False,False,False,False,False,False,False,False,'',-1,
                 False, '', True, '', '', '', '', '', '', True, False, False, Nil, Nil, '', '', '', '', '', '', '', '', False, False, True, False, True) then
    Begin
      If (fValidaCampos(edtCodIte, True)) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmManutNumSerieItens.FormCreate(Sender: TObject);
begin
  inherited;
  cdsItens := TZClient.Create(Self, fGetSQLItens);
  cdsItens.BeforePost := pBeforePostItens;
  cdsItens.AfterPost := pAfterPostItens;
  cdsItens.BeforeEdit := pBeforeEditItens;

  cxGridItensDBTableViewItens.DataController.DataSource := cdsItens.dtsSource;
  qryConPro := fCriaQuery(Self);
  qryUpdate := fCriaQuery(Self);
  qryUpdate.SQL.Add(fGetSQLUpdate);

  stlNumerosUsados := TStringList.Create;
end;

procedure TfrmManutNumSerieItens.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(stlNumerosUsados);
end;

procedure TfrmManutNumSerieItens.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10: btnConfirma.Click;
  End;
end;

procedure TfrmManutNumSerieItens.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodIte);
end;

function TfrmManutNumSerieItens.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If (Sender = edtCodIte) And (blnBuscaPorChave) Then
    Begin
      If Not fEmptyStr(edtCodIte.Text) Then
      Begin
        edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
        If fEmptyStr(edtDesIte.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
          Result := False;
        End
        Else
        If Not fItemUSASER Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está configurado em seu cadastro para ter controle por número de série!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Preencha o código do item para prosseguir!', ['&Ok']);
        Result := False;
      End;

    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmManutNumSerieItens.fItemUSASER: Boolean;
begin
  Result := fCampoTabela('ITE_USASER', 'ITEGER', ['ITE_CODITE','ITE_CODEMP'], [edtCodIte.Text, VS_StrCodEmp]) = 'S';
end;

function TfrmManutNumSerieItens.fExisteNumSerie(AStrCodIte, AStrNumNovo: String): Boolean;
var
  qryAux: TUniQuery;
begin
  qryAUx := fCriaQuery;

  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT                             ');
    qryAux.SQL.Add('  AUTOINCREM                        ');
    qryAux.SQL.Add(' FROM                               ');
    qryAux.SQL.Add('  PROSER                            ');
    qryAux.SQL.Add(' WHERE TRUE                         ');
    qryAux.SQL.Add('   AND SER_NUMSER = :SERNNV         ');
    qryAux.SQL.Add('   AND SER_CODITE = :CODITE         ');
    qryAux.SQL.Add('   AND SER_CODEMP = :CODEMP         ');

    qryAux.ParamByName('SERNNV').AsString := AStrNumNovo;
    qryAux.ParamByName('CODITE').AsString := AstrCodIte;
    qryAux.ParamByName('CODEMP').AsString := VS_StrCodEmp;

    qryAux.Open;

    Result := (Not qryAux.IsEmpty) Or (stlNumerosUsados.IndexOf(AStrNumNovo) > -1);
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmManutNumSerieItens.fGetSQLItens: String;
begin
  Result := '';
  Result := Result + ' SELECT                                              ';
  Result := Result + '   CAST("" AS CHAR(30)) AS SER_NNVSER,               ';
  Result := Result + '   PRS.AUTOINCREM,                                   ';
  Result := Result + '   PRS.SER_CODITE,                                   ';
  Result := Result + '   PRS.SER_NUMSER,                                   ';
  Result := Result + '   IF((SELECT COUNT(1) AS QTD FROM NSEDOR NSE         ';
  Result := Result + '       INNER JOIN FATDOR FDO ON FDO.AUTOINCREM = NSE.NSE_SEQFDO    ';
  Result := Result + '       WHERE NSE.NSE_NUMSER = PRS.SER_NUMSER AND FDO.FDO_CODITE = PRS.SER_CODITE AND FDO_JAFATU = FALSE AND IFNULL(FDO.FDO_EMPITE,FDO.FDO_CODEMP) = PRS.SER_CODEMP) > 0,  "N", "S") AS EDITAR  ';
  Result := Result + ' FROM                                                ';
  Result := Result + '   PROSER PRS                                        ';
  Result := Result + ' WHERE TRUE                                          ';
  Result := Result + '   AND PRS.SER_CODEMP = :CODEMP                      ';
  Result := Result + '   AND PRS.SER_CODITE = :CODITE                      ';
 end;

function TfrmManutNumSerieItens.fGetSQLUpdate: String;
begin
  Result := '';
  Result := Result + 'UPDATE                    ';
  Result := Result + ' PROSER                   ';
  Result := Result + 'SET                       ';
  Result := Result + ' SER_NUMSER = :NUMSER     ';
  Result := Result + 'WHERE                     ';
  Result := Result + ' AUTOINCREM = :AUTINC     ';
end;

procedure TfrmManutNumSerieItens.pAbrirConsulta;
begin
  If fEmptyStr(edtCodIte.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'Informe um item para prosseguir!', ['&Ok']);
    pSetFocus(edtCodIte);
    Exit;
  End;

  stlNumerosUsados.Clear;

  cdsItens.qryQuery.Close;
  cdsItens.qryQuery.ParamByName('CODEMP').AsString := VS_StrCodEmp;
  cdsItens.qryQuery.ParamByName('CODITE').AsString := edtCodIte.Text;
  cdsItens.fAbreClient(True, 'TfrmManutNumSerieItens.pAbrirConsulta');

  btnConfirma.Enabled := Not cdsItens.isEmpty;

  If cdsItens.isEmpty Then
  Begin
    pMensagemOk('Item sem número de série cadastrado!');
    pSetFocus(edtCodIte);
  End;
end;

procedure TfrmManutNumSerieItens.pAfterPostItens(DataSet: TDataSet);
begin
  If Not fEmptyStr(DataSet.FieldByName('SER_NNVSER').AsString) Then
    stlNumerosUsados.Add(DataSet.FieldByName('SER_NNVSER').AsString);

  FStrOldNum := '';
end;

procedure TfrmManutNumSerieItens.pBeforeEditItens(DataSet: TDataSet);
begin
  FStrOldNum := DataSet.FieldByName('SER_NNVSER').AsString;
end;

procedure TfrmManutNumSerieItens.pBeforePostItens(DataSet: TDataSet);
begin
  If fEmptyStr(DataSet.FieldByName('SER_NNVSER').AsString) Then
  Begin
    fMensagem('ATENÇÃO!', 'Foi informado um número de série em branco. Será mantido o número de série atual ao confirmar!', ['&Ok']);
  End;
  If DataSet.FieldByName('SER_NUMSER').AsString = DataSet.FieldByName('SER_NNVSER').AsString Then
  Begin
    fMensagem('ATENÇÃO!', 'Informe um número de série diferente do atual!', ['&Ok']);
    DataSet.FieldByName('SER_NNVSER').Clear;
    Exit;
  End;

  If stlNumerosUsados.IndexOf(FStrOldNum) > -1 Then
    stlNumerosUsados.Delete(stlNumerosUsados.IndexOf(FStrOldNum));

  If fExisteNumSerie(DataSet.FieldByName('SER_CODITE').AsString, DataSet.FieldByName('SER_NNVSER').AsString) Then
  Begin
    fMensagem('ATENÇÃO!', 'Já existe um número de série cadastrado para este item!', ['&Ok']);
    DataSet.FieldByName('SER_NNVSER').Clear;
    Exit;
  End;
end;

procedure TFrmManutNumSerieItens.pConfirmar;
begin
  If fMensagem('', 'Confirma a atualização dos números de série?', ['&Sim', '&Não']) = 2 Then
    Exit;

  Try
    Try
      cdsItens.DisableControls;
      cdsItens.First;
      fStartTransaction;
      While Not cdsItens.Eof Do
      Begin
        If Not fEmptyStr(cdsItens.FieldByName('SER_NNVSER').AsString) Then
        Begin
          qryUpdate.ParamByName('NUMSER').AsString := cdsItens.FieldByName('SER_NNVSER').AsString;
          qryUpdate.ParamByName('AUTINC').AsString := cdsItens.FieldByName('AUTOINCREM').AsString;
          qryUpdate.ExecSQL;
        End;

        cdsItens.Next;
      End;

      fCommit;
      pMensagemOk('Números de série atualizados com sucesso!');
    Except
      On E:Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, 'TFrmManutNumSerieItens.pConfirmar');
      End;
    End;
  Finally
    cdsItens.EnableControls;
    pLimparTela;
  End;
end;

procedure TFrmManutNumSerieItens.pLimparTela;
begin
  edtCodIte.Clear;
  edtDesIte.Clear;

  pSetFocus(edtCodIte);

  cdsItens.Close;
end;
end.
