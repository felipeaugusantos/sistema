unit untFatorPrecoCadastro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
  DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Uni, UniDataSetProvider,
  UniClientDataSet, ComCtrls, BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, Datasnap.Provider,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient,
  frxClass, frxExportCSVTestabilidade, cxCheckBox	;

type
  TfrmFatorPrecoCadastro = class(TfrmPaiConfirma)
    cxGridTableView: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxGrid: TcxGrid;
    cxGridNumFat: TcxGridDBColumn;
    cxGridValFat: TcxGridDBColumn;
    dtsFatPre: TDataSource;
    cdsFatPre: TUniClientDataSet;
    dtpFatPre: TUniDataSetProvider;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    prgProgresso: TProgressBar;
    btnMarDes: TBitBtnLocked;
    cxGridTableViewColumn1: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cdsFatPreBeforePost(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure cxGridTableViewDblClick(Sender: TObject);
    procedure cxGridTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnMarDesClick(Sender: TObject);
  private
    { Private declarations }
    qryFatPre: TUniQuery;
    blnAbortou: Boolean;
    blnCarregando: Boolean;
    blnAlterandoRegistros: Boolean;
    
    procedure pAbreCadastro;
    procedure pLimparCadInt;

    function fMarcado(strValor: String; var intIndex: Integer): Boolean;
    procedure pMarcaDesmarca(strValor, marcaDesmarca:String);
    procedure pMarcaDesmarcaTodas(marcaDesmarca:String);
    procedure pGridRefresh;

  public
    { Public declarations }

    stlListSelecao : TStringList;
  end;


implementation

{$R *.dfm}

Uses
   untFuncoesSimples, untFatorPreco;


procedure TfrmFatorPrecoCadastro.btnMarDesClick(Sender: TObject);
  var
    blnMarcar: Boolean;
begin
  If blnAlterandoRegistros Then
    Exit;
  inherited;

  blnMarcar := stlListSelecao.Count = 0;

  pMarcaDesmarcaTodas(IIF(blnMarcar, 'M', 'D'));
  pGridRefresh;
end;

procedure TfrmFatorPrecoCadastro.cdsFatPreBeforePost(DataSet: TDataSet);
var intIndex: integer;
begin
  inherited;

  With DataSet Do
  Begin
    If blnCarregando Then
      Exit;

    If fMarcado(FieldByName('FAT_NUMFAT').AsString, intIndex) Then
    Begin
      If FieldByName('FAT_ATIVO_').AsString = 'N' Then
        stlListSelecao.Delete(intIndex);

      If FieldByName('FAT_VALFAT').AsFloat = 0 Then
      Begin
        Cancel;
        pMensagemOk('Informe um valor maior que zero para a Tabela de Preço ' + FieldByName('FAT_NUMFAT').AsString + '!');
        pMarcaDesmarca(FieldByName('FAT_NUMFAT').AsString, 'D');
        pGridRefresh;
        blnAbortou := True;
        Abort;
      End;



    end;
  End;
end;

procedure TfrmFatorPrecoCadastro.cxGridTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  var intIndex: integer;
begin
  If blnAlterandoRegistros Then
    Exit;

  inherited;

  If fMarcado(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridNumFat.Index]), intIndex) Then
  Begin
    ACanvas.Brush.Color := clAqua;
  End;
end;

procedure TfrmFatorPrecoCadastro.cxGridTableViewDblClick(Sender: TObject);
  var
    blnMarcar: Boolean;
    intIndex: integer;
begin
  If blnAlterandoRegistros Then
    Exit;

  inherited;

  blnMarcar := (not fMarcado(cdsFatPre.FieldByName('FAT_NUMFAT').AsString, intIndex));

  pMarcaDesmarca(cdsFatPre.FieldByName('FAT_NUMFAT').AsString, IIF(blnMarcar, 'M', 'D'));
  pGridRefresh;

end;

function TfrmFatorPrecoCadastro.fMarcado(strValor: String; var intIndex: Integer): Boolean;
Begin
  Result := stlListSelecao.Find(strValor, intIndex);
end;

procedure TfrmFatorPrecoCadastro.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(cxGrid);
end;

procedure TfrmFatorPrecoCadastro.FormClose(Sender: TObject;
  var Action: TCloseAction);
   Var
     objFatPre: TFatorPreco;
begin
  inherited;

  Try
    cxGridTableView.DataController.DataSet.DisableControls;
    blnAlterandoRegistros := True;
    With cdsFatPre Do
    If ModalResult = mrOk Then
    Begin
      cxGridTableView.DataController.DataSet.DisableControls;
      //Verifica se nenhuma tabela foi selecionada aborta e informa usuario
      if (stlListSelecao.Count = 0) then
      begin
        pMensagemOk('Nenhuma tabela selecionada!');
        Action := caNone;
        Exit;
      end;

      If state in [dsEdit] Then
        Post;

      If blnAbortou Then
      Begin
        Action := caNone;
        blnAbortou := False;
        Exit;
      End;

      btnConfirma.Enabled := False;
      btnMarDes.Enabled := False;

      If (Not fPergunta('Confirma a alteração dos preços?')) Then
      Begin
        Action := caNone;
        btnConfirma.Enabled := True;
        btnMarDes.Enabled := True;
        Exit;
      End;

      btnSair.Enabled := False;

      // VALIDA OS CAMPOS
      First;
      While Not Eof Do
      Begin
        Edit;
        Post;
        Next;
      End;

      If ChangeCount > 0 Then
        ApplyUpdates(0);

      objFatPre := TFatorPreco.Create;

      If objFatPre.fAlteraPrecos(prgProgresso, stlListSelecao) Then
        pMensagemOk('Preços alterados com sucesso!')
      Else
        Action := caNone;

      FreeAndNil(objFatPre);
      pLimparCadInt;

      If Assigned(stlListSelecao) Then
      Begin
        stlListSelecao.Clear;
        If not (Action = caNone) Then
          FreeAndNil(stlListSelecao);
      End;

      btnConfirma.Enabled := True;
      btnMarDes.Enabled   := True;
      btnSair.Enabled     := True;
    End;
  Finally
    cxGridTableView.DataController.DataSet.EnableControls;
    blnAlterandoRegistros := False;
  End;

end;

procedure TfrmFatorPrecoCadastro.pLimparCadInt;
Var
  qryConsulta: TUniQuery;
Begin
  qryConsulta := fCriaQuery(Self);
  Try
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('DELETE FROM CADINT WHERE INT_NOMFRM LIKE "frmAltPrecoIndividual"');
    qryConsulta.ExecSQL;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, 'TfrmFatorPrecoCadastro.pLimparCadInt');
  End;
End;

procedure TfrmFatorPrecoCadastro.FormCreate(Sender: TObject);
begin
  inherited;

  stlListSelecao := TStringList.Create;
  stlListSelecao.Duplicates := dupIgnore;
  stlListSelecao.Sorted := True;
  stlListSelecao.Clear;

  blnAbortou := False;
  blnAlterandoRegistros := False;
  qryFatPre := fCriaQuery(Self);
  dtpFatPre.DataSet := qryFatPre;

  pAbreCadastro;
end;

procedure TfrmFatorPrecoCadastro.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
    blnMarcar: Boolean;
    intIndex: integer;
begin
  inherited;

  Case Key Of
    VK_SPACE:
    begin
      If blnAlterandoRegistros Then
        Exit;

      blnMarcar := (not fMarcado(cdsFatPre.FieldByName('FAT_NUMFAT').AsString, intIndex));

      pMarcaDesmarca(cdsFatPre.FieldByName('FAT_NUMFAT').AsString, IIF(blnMarcar, 'M', 'D'));
      pGridRefresh;
    end;

    VK_F9:
    begin
      If blnAlterandoRegistros Then
        Exit;

      blnMarcar := stlListSelecao.Count = 0;

      pMarcaDesmarcaTodas(IIF(blnMarcar, 'M', 'D'));
      pGridRefresh;
    end;

    VK_F10: btnConfirma.Click;
  End;
end;

procedure TfrmFatorPrecoCadastro.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If Key = '-' Then
    Key := #0;
end;

procedure TfrmFatorPrecoCadastro.pAbreCadastro;
  Const
    MAXFATOR = 6;
  Var
    intIndice: Integer;
Begin
  With cdsFatPre Do
  Begin
    blnCarregando := True;

    qryFatPre.SQL.Text := 'SELECT * FROM FATPRE WHERE FAT_CODEMP = :CODEMP';
    qryFatPre.ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    IndexFieldNames := 'FAT_NUMFAT';

    FieldByName('FAT_NUMFAT').Alignment := taCenter;
    TFloatField(FieldByName('FAT_VALFAT')).DisplayFormat := '#,##0.0000';

    For intIndice := 2 To Succ(MAXFATOR) Do
      If Not Locate('FAT_NUMFAT', intIndice, []) Then
      Begin
        Insert;
        FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('FATPRE', VS_strCodEmp);
        FieldByName('FAT_NUMFAT').AsInteger := intIndice;
        FieldByName('FAT_CODEMP').AsString  := VS_strCodEmp;
        FieldByName('FAT_VALFAT').AsFloat   := 0;
        Post;
      End;

    If ChangeCount > 0 Then
      ApplyUpdates(0);

    First;

    FieldByName('FAT_VALFAT').FocusControl;

    blnCarregando := False;

  End;

End;

procedure TfrmFatorPrecoCadastro.pGridRefresh;
begin
  cxGridNumFat.Width := cxGridNumFat.Width + 1;
  cxGridNumFat.Width := cxGridNumFat.Width - 1;
end;

procedure TfrmFatorPrecoCadastro.pMarcaDesmarca(strValor,
  marcaDesmarca: String);
  Var
    i: integer;
begin
  if marcaDesmarca = 'M' then
  Begin
    If cdsFatPre.FieldByName('FAT_ATIVO_').AsString = 'S' Then
      stlListSelecao.Add(strValor)
    Else
      pMensagemOk('Só é possivel marcar tabelas que estiverem ativas!');
  End
  else
  begin
    for i:= 0 to stlListSelecao.count -1 do
      if strValor = stlListSelecao[i] then
      begin
        stlListSelecao.Delete(i);
        Break;
      end;
  end;
end;

procedure TfrmFatorPrecoCadastro.pMarcaDesmarcaTodas(marcaDesmarca: String);
  Var
    cdsClone : TUniClientDataSet;
begin
  try
    if marcaDesmarca = 'M' then
    begin
      cdsClone := TUniClientDataSet.Create(Self);

      pCloneDataSet(cdsClone, cdsFatPre);
      cdsClone.Filtered := False;

      cdsClone.First;
      while (not cdsClone.Eof) do
      begin
        If cdsClone.FieldByName('FAT_ATIVO_').AsString = 'S' Then
          stlListSelecao.Add(cdsClone.FieldByName('FAT_NUMFAT').AsString);

        cdsClone.Next;
      end;
    end
    else
    begin
      stlListSelecao.Clear;
    end;
  finally
    if Assigned(cdsClone) then
      FreeAndNil(cdsClone);
  end;
end;

end.
