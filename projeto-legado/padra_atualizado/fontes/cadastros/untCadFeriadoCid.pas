unit untCadFeriadoCid;

interface

uses
  Windows, Classes, Controls, untPai, AppEvnts, Menus, StdCtrls, Buttons,
  BitBtnLockedIncrem, ExtCtrls, EditFocus, Mask, MaskEditFocus, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  UniClientDataSet, cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Uni, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmCadFeriadoCid = class(TfrmPai)
    pnlCadastro: TPanel;
    pnlGrid: TPanel;
    mskDtaFer: TMaskEditFocus;
    edtDescri: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    btnAdicionar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    cxgFeriados: TcxGrid;
    cxgFeriadosView: TcxGridDBTableView;
    cxgFeriadosLevel1: TcxGridLevel;
    dtsFerCid: TDataSource;
    cdsFerCid: TUniClientDataSet;
    cdsFerCidDTAFER: TDateField;
    cdsFerCidDESCRI: TStringField;
    cxgFeriadosViewDTAFER: TcxGridDBColumn;
    cxgFeriadosViewDESCRI: TcxGridDBColumn;
    btnConfirma: TBitBtnLocked;
    cdsFerCidAUTOINCREM: TStringField;
    pnlLegend: TPanel;
    Label3: TLabel;
    cdsFerCidSEQFER: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure cxgFeriadosViewCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure cxgFeriadosViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FCodCid: String;
    FEditando: Boolean;
    blnEditou: Boolean;
    qryFerCid: TUniQuery;
    procedure pApagarRegistroAtual;
    procedure pSetaEditando(blnEditando: Boolean);
    procedure pCarregaDadosEditar;
    procedure pLimpaEdits;
    function fValidaDataCadastrada: Boolean;
    function fRetSeqFer: Integer;    
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    procedure pSetaCidade(strCodCid: String);
  end;


implementation

uses SysUtils, Forms, untFuncoesSimples;

{$R *.dfm}

{ TfrmCadFeriadoCid }

procedure TfrmCadFeriadoCid.pApagarRegistroAtual;
begin
  If fMensagem('ATENÇÃO', 'Deseja realmente apagar registro selecionado?', ['&Sim', '&Não']) = 1 Then
  Begin
    cdsFerCid.Delete;

    If (cdsFerCid.IsEmpty) Then
      pLimpaEdits;

    blnEditou := True;
  End;
end;

procedure TfrmCadFeriadoCid.btnAdicionarClick(Sender: TObject);
Var
  intSeqFer: Integer;
begin
  inherited;
  If fVerificaCampos Then
  Begin
    intSeqFer := fRetSeqFer;

    If FEditando Then
      cdsFerCid.Edit
    Else
    Begin
      cdsFerCid.Append;
      cdsFerCidAUTOINCREM.AsString := '';
      cdsFerCidSEQFER.AsInteger    := intSeqFer ;
    End;

    cdsFerCidDTAFER.AsDateTime := StrToDate(mskDtaFer.Text);
    cdsFerCidDESCRI.AsString   := edtDescri.Text;
    cdsFerCid.Post;

    pSetaEditando(False);
    pLimpaEdits;

    blnEditou := True;
  End;
end;

procedure TfrmCadFeriadoCid.btnCancelarClick(Sender: TObject);
begin
  inherited;
  pLimpaEdits;
  pSetaEditando(False);
end;

procedure TfrmCadFeriadoCid.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If Not blnEditou Then
    Close
  Else
  Begin
    With qryFerCid Do
    Begin
      Close;
      SQL.Text := 'DELETE FROM FERCID WHERE FCI_CODCID = :CODCID';
      ParamByName('CODCID').AsString := FCodCid;
      ExecSQL;

      SQL.Text := 'SELECT * FROM FERCID WHERE FALSE';
      Open;

      cdsFerCid.First;
      While not cdsFerCid.Eof Do
      Begin
        Insert;
        FieldByName('AUTOINCREM').AsString := cdsFerCidAUTOINCREM.AsString;

        If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
          FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FERCID', VS_strCodEmp);

        FieldByName('FCI_CODCID').AsString   := FCodCid;
        FieldByName('FCI_DTAFER').AsDateTime := cdsFerCidDTAFER.AsDateTime;
        FieldByName('FCI_DESCRI').AsString   := cdsFerCidDESCRI.AsString;

        Post;

        cdsFerCid.Next;
      End;
    End;

    {******************************************************************}
    {* SETA FALSE PARA NÃO PERGUNTAR SE DESEJA IGNORAR DADOS EDITADOS *}
    {***************************************************************AL*}
    blnEditou := False;
    Close;
  End;
end;

procedure TfrmCadFeriadoCid.cxgFeriadosViewCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pCarregaDadosEditar;
end;

procedure TfrmCadFeriadoCid.cxgFeriadosViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_Return: pCarregaDadosEditar;
    VK_Delete: pApagarRegistroAtual;
    VK_ESCAPE: pLimpaEdits;
  End;
end;

procedure TfrmCadFeriadoCid.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  CanClose := True;

  If blnEditou Then
  Begin
    If fMensagem('ATENÇÃO', 'Deseja descartar edição?', ['&Sim', '&Não'], 2) = 2 Then
      CanClose := False;
  End;
end;

procedure TfrmCadFeriadoCid.FormCreate(Sender: TObject);
begin
  inherited;

  qryFerCid := fCriaQuery;
  cdsFerCid.CreateDataSet;
  cdsFerCid.Open;

  pSetaEditando(False);
  
  blnEditou := False;
end;

procedure TfrmCadFeriadoCid.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryFerCid);
  fLock_Unlock('FERCID'+ FCodCid, False);

  inherited;
end;

procedure TfrmCadFeriadoCid.FormShow(Sender: TObject);
Var
  intSeqFer: Integer;
begin
  inherited;
  fLock_Unlock('FERCID' + FCodCid, True, False);

  intSeqFer := 0;

  With qryFerCid, SQL Do
  Begin
    Close;
    Clear;

    Add('SELECT');
    Add('  *');
    Add('FROM');
    Add('  FERCID');
    Add('WHERE');
    Add('  FCI_CODCID = :CODCID');
    Add('ORDER BY');
    Add('  FCI_DTAFER');

    ParamByName('CODCID').AsString := FCodCid;
    Open;

    While Not Eof Do
    Begin
      Inc(intSeqFer);

      cdsFerCid.Append;
      cdsFerCidDTAFER.AsDateTime := FieldByName('FCI_DTAFER').AsDateTime;
      cdsFerCidDESCRI.AsString   := FieldByName('FCI_DESCRI').AsString;
      cdsFerCid.FieldByName('SEQFER').AsInteger  := intSeqFer;
      cdsFerCid.Post;
      Next;
    End;
  End;
end;

function TfrmCadFeriadoCid.fRetSeqFer: Integer;
Var
  cdsFerTmp: TUniClientDataSet;
begin

  Try

    cdsFerTmp := TUniClientDataSet.Create(Self);

    If (cdsFerCid.IsEmpty) Then
      Result := 1
    Else
    Begin
      cdsFerTmp.Data := cdsFerCid.Data;
      cdsFerTmp.Open;
      cdsFerTmp.IndexFieldNames := 'SEQFER';
      cdsFerTmp.Last;

      Result := cdsFerTmp.FieldByName('SEQFER').AsInteger + 1;
    end;

  Finally
    FreeAndNil(cdsFerTmp);
  End;

end;

function TfrmCadFeriadoCid.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  Var
    strMensagem: String;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If Sender = mskDtaFer Then
    Begin
      If (fEmptyDate(mskDtaFer.Text) And (Not cdsFerCid.IsEmpty)) Then
      Begin
        pSetFocus(cxgFeriados);
        blnMudarFoco := False;
      End
      Else If StrToDateDef(mskDtaFer.Text, 0) = 0 Then
        strMensagem := 'Data do feriado inválida, favor digitar novamente!'
      Else
      Begin
        //If Not FEditando Then
        //Begin
          If fValidaDataCadastrada Then
            strMensagem := 'Data do feriado já está cadastrada para essa cidade!';
        //End;
      End;
    End

    Else If Sender = edtDescri Then
    Begin
      If fEmptyStr(edtDescri.Text) Then
        strMensagem := 'Campo Descrição precisa ser preenchido!';
    End;
  End;

  If Not fEmptyStr(strMensagem) Then
  Begin
    Result := False;
    fMensagem('ATENÇÃO', strMensagem, ['&O k']);
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

function TfrmCadFeriadoCid.fValidaDataCadastrada: Boolean;
Var
  intSeqFer: Integer;
  intPosAtu: Integer;
begin
  With cdsFerCid Do
  Begin
    intSeqFer := FieldByName('SEQFER').AsInteger;
    intPosAtu := RecNo;
    First;

    If (FEditando) Then
      Result := Locate('DTAFER', mskDtaFer.Text, []) And (FieldByName('SEQFER').AsInteger <> intSeqFer)
    Else
      Result := Locate('DTAFER', mskDtaFer.Text, []);

    RecNo := intPosAtu;
  End;
end;

procedure TfrmCadFeriadoCid.pCarregaDadosEditar;
begin
  If cdsFerCid.IsEmpty Then
    Exit;
    
  mskDtaFer.Text := FormatDateTime('dd/mm/yyyy', cdsFerCidDTAFER.AsDateTime);
  edtDescri.Text := cdsFerCiddescri.AsString;
  pSetFocus(mskDtaFer);

  pSetaEditando(True);
end;

procedure TfrmCadFeriadoCid.pLimpaEdits;
begin
  mskDtaFer.Clear;
  edtDescri.Clear;
  pSetFocus(mskDtaFer);
end;

procedure TfrmCadFeriadoCid.pSetaCidade(strCodCid: String);
begin
  FCodCid := strCodCid;
end;

procedure TfrmCadFeriadoCid.pSetaEditando(blnEditando: Boolean);
begin
  FEditando := blnEditando;

  btnAdicionar.Caption := IIF(FEditando, '&Salvar', '&Adicionar');
end;

end.
