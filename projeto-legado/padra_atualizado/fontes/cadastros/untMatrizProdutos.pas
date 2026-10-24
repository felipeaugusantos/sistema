unit untMatrizProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, UniClientDataSet, Uni, Vcl.DBCtrls,
  cxGridBandedTableView, cxGridDBBandedTableView, cxProgressBar;

type
  TfrmMatrizProdutos = class(TfrmPai)
    grdMatriz: TcxGridCitel;
    dsMatriz: TDataSource;
    MAT_CODGRU: TcxGridDBBandedColumn;
    MAT_DESGRU: TcxGridDBBandedColumn;
    MAT_DESF01: TcxGridDBBandedColumn;
    MAT_DESF02: TcxGridDBBandedColumn;
    MAT_DESF03: TcxGridDBBandedColumn;
    MAT_DESF04: TcxGridDBBandedColumn;
    MAT_DESF05: TcxGridDBBandedColumn;
    MAT_DESF06: TcxGridDBBandedColumn;
    MAT_DESF07: TcxGridDBBandedColumn;
    MAT_MARBR1: TcxGridDBBandedColumn;
    MAT_MARBR2: TcxGridDBBandedColumn;
    MAT_MARBR3: TcxGridDBBandedColumn;
    MAT_MARBR4: TcxGridDBBandedColumn;
    MAT_MARBR5: TcxGridDBBandedColumn;
    MAT_MARBR6: TcxGridDBBandedColumn;
    MAT_MARBR7: TcxGridDBBandedColumn;
    MAT_COMTB1: TcxGridDBBandedColumn;
    MAT_COMTB2: TcxGridDBBandedColumn;
    MAT_COMTB3: TcxGridDBBandedColumn;
    MAT_COMTB4: TcxGridDBBandedColumn;
    MAT_COMTB5: TcxGridDBBandedColumn;
    MAT_COMTB6: TcxGridDBBandedColumn;
    MAT_COMTB7: TcxGridDBBandedColumn;
    MAT_COMVAR: TcxGridDBBandedColumn;
    MAT_COMATA: TcxGridDBBandedColumn;
    MAT_COMDIS: TcxGridDBBandedColumn;
    MAT_COMDIG: TcxGridDBBandedColumn;
    MAT_DESMAX: TcxGridDBBandedColumn;
    MAT_DESMSU: TcxGridDBBandedColumn;
    MAT_DESMGE: TcxGridDBBandedColumn;
    MAT_MARMIN: TcxGridDBBandedColumn;
    MAT_MARMSG: TcxGridDBBandedColumn;
    MAT_MARMGE: TcxGridDBBandedColumn;
    grdMatrizLv: TcxGridLevel;
    grdMatrizTv: TcxGridDBBandedTableViewCitel;
    grdMatrizDBBandedTableViewCitel1: TcxGridDBBandedTableViewCitel;
    btnCopiar: TBitBtnLocked;
    MAT_COMVAR1: TcxGridDBBandedColumn;
    MAT_COMVAR2: TcxGridDBBandedColumn;
    MAT_COMVAR3: TcxGridDBBandedColumn;
    MAT_COMVAR4: TcxGridDBBandedColumn;
    MAT_COMVAR5: TcxGridDBBandedColumn;
    MAT_COMVAR6: TcxGridDBBandedColumn;
    MAT_COMVAR7: TcxGridDBBandedColumn;
    MAT_COMATA1: TcxGridDBBandedColumn;
    MAT_COMATA2: TcxGridDBBandedColumn;
    MAT_COMATA3: TcxGridDBBandedColumn;
    MAT_COMATA4: TcxGridDBBandedColumn;
    MAT_COMATA5: TcxGridDBBandedColumn;
    MAT_COMATA6: TcxGridDBBandedColumn;
    MAT_COMATA7: TcxGridDBBandedColumn;
    MAT_COMDIS1: TcxGridDBBandedColumn;
    MAT_COMDIS2: TcxGridDBBandedColumn;
    MAT_COMDIS3: TcxGridDBBandedColumn;
    MAT_COMDIS4: TcxGridDBBandedColumn;
    MAT_COMDIS5: TcxGridDBBandedColumn;
    MAT_COMDIS6: TcxGridDBBandedColumn;
    MAT_COMDIS7: TcxGridDBBandedColumn;
    MAT_COMDIG1: TcxGridDBBandedColumn;
    MAT_COMDIG2: TcxGridDBBandedColumn;
    MAT_COMDIG3: TcxGridDBBandedColumn;
    MAT_COMDIG4: TcxGridDBBandedColumn;
    MAT_COMDIG5: TcxGridDBBandedColumn;
    MAT_COMDIG6: TcxGridDBBandedColumn;
    MAT_COMDIG7: TcxGridDBBandedColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCopiarClick(Sender: TObject);
    procedure grdMatrizTvKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdMatrizTvEditValueChanged(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem);
  private
    { Private declarations }
    FCdsMatriz: TUniClientDataSet;
    FQryGravar: TUniQuery;
    blnSalvouComEnter : Boolean;

    procedure BeforePost(DataSet: TDataSet);
    procedure AfterPost(DataSet: TDataSet);
    function fCopiaColuna(pgbProgresso: TcxProgressBar): Boolean;

    function ShowCOMTB(Idx: Integer): Boolean;
    procedure pValidaDescontoMaximoOperador(Dataset : TDataset);
    procedure pValidaMargemMinimaOperador(Dataset : TDataset);
    function fTeclaPermiteSalvarDados(const Key: Word): Boolean;
    procedure pAbreConsulta;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  StrUtils, untFuncoesSimples, untGravando;

procedure TfrmMatrizProdutos.AfterPost(DataSet: TDataSet);
var
  LFieldOrigin: TField;
  LFieldDestination: TField;
begin
  FQryGravar.Close;
  FQryGravar.ParamByName('AUTOINCREM').AsString := FCdsMatriz.FieldByName('AUTOINCREM').AsString;
  FQryGravar.Open;

  FQryGravar.Edit;
  for LFieldOrigin in FQryGravar.Fields do
  begin
    LFieldDestination := FCdsMatriz.FieldByName(LFieldOrigin.FieldName);
    if Assigned(LFieldDestination) then
      LFieldOrigin.Value := LFieldDestination.Value;
  end;
  FQryGravar.Post;

end;

procedure TfrmMatrizProdutos.BeforePost(DataSet: TDataSet);
begin
  if FCdsMatriz.FieldByName('AUTOINCREM').IsNull then
    FCdsMatriz.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PROMAT', VS_strCodEmp);

  if FCdsMatriz.FieldByName('MAT_CODGRU').IsNull then
    FCdsMatriz.FieldByName('MAT_CODGRU').AsString := FCdsMatriz.FieldByName('GRU_CODGRU').AsString;

  pValidaDescontoMaximoOperador(Dataset);
  pValidaMargemMinimaOperador(Dataset);
end;

procedure TfrmMatrizProdutos.btnCopiarClick(Sender: TObject);
var
  LfrmGravando: TfrmGravando;
begin
  inherited;
  TfrmGravando.fExecuta(fCopiaColuna, LfrmGravando, 'Aguarde... Copiando coluna!');
end;

procedure TfrmMatrizProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  FQryGravar := fCriaQuery;
  FQryGravar.SQL.ADD('SELECT * FROM PROMAT WHERE AUTOINCREM = :AUTOINCREM');
end;

procedure TfrmMatrizProdutos.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FCdsMatriz);
  FreeAndNil(FQryGravar);
end;

procedure TfrmMatrizProdutos.FormShow(Sender: TObject);
var
  intTabPre: Integer;
  strPCMPRO: String;
  blnUSADIG: Boolean;
begin
  inherited;
  fExecutarModal(pAbreConsulta, 'Por favor, aguarde...', '');

  for intTabPre := 1 to Length(VS_strTabPrc) do
  begin
    grdMatrizTv.GetColumnByFieldName('MAT_DESF0'+intTabPre.ToString).Visible := (VS_strTabPrc[intTabPre] = 'S');
    grdMatrizTv.GetColumnByFieldName('MAT_MARBR'+intTabPre.ToString).Visible := (VS_strTabPrc[intTabPre] = 'S');
    grdMatrizTv.GetColumnByFieldName('MAT_COMTB'+intTabPre.ToString).Visible := ShowCOMTB(intTabPre);
  End;

  grdMatrizTv.GetColumnByFieldName('MAT_COMDIG').Visible := fCfgSis('USADIG', varBoolean);
  grdMatrizTv.GetColumnByFieldName('MAT_DESMAX').Visible := not fCfgSis('ITETBP', VarBoolean);
  grdMatrizTv.GetColumnByFieldName('MAT_DESMSU').Visible := not fCfgSis('ITETBP', VarBoolean);
  grdMatrizTv.GetColumnByFieldName('MAT_DESMGE').Visible := not fCfgSis('ITETBP', VarBoolean);

  for intTabPre := 1 to 7 do
  begin
    TFloatField(FCdsMatriz.FieldByName('MAT_DESF0'+intTabPre.ToString)).DisplayFormat := '#,##0.00';
    TFloatField(FCdsMatriz.FieldByName('MAT_MARBR'+intTabPre.ToString)).DisplayFormat := '#,##0.00';
    TFloatField(FCdsMatriz.FieldByName('MAT_COMTB'+intTabPre.ToString)).DisplayFormat := '#,##0.00';
  End;

  strPCMPRO := fCfgSis('PCMPRO');
  blnUSADIG := fCfgSis('USADIG', varBoolean);


  If (strPCMPRO = '1') Or (strPCMPRO = '3') Then
  Begin
    MAT_COMVAR1.Position.Band.Visible := False;
    MAT_COMVAR2.Position.Band.Visible := False;
    MAT_COMVAR3.Position.Band.Visible := False;
    MAT_COMVAR4.Position.Band.Visible := False;
    MAT_COMVAR5.Position.Band.Visible := False;
    MAT_COMVAR6.Position.Band.Visible := False;
    MAT_COMVAR7.Position.Band.Visible := False;
  End
  Else If (strPCMPRO = '2') Then
  Begin
    MAT_COMVAR.Visible  := False;
    MAT_COMATA.Visible  := False;
    MAT_COMDIS.Visible  := False;
    MAT_COMDIG.Visible  := False;

    MAT_COMVAR1.Position.Band.Visible := (VS_strTabPrc[1] = 'S');
    MAT_COMVAR2.Position.Band.Visible := (VS_strTabPrc[2] = 'S');
    MAT_COMVAR3.Position.Band.Visible := (VS_strTabPrc[3] = 'S');
    MAT_COMVAR4.Position.Band.Visible := (VS_strTabPrc[4] = 'S');
    MAT_COMVAR5.Position.Band.Visible := (VS_strTabPrc[5] = 'S');
    MAT_COMVAR6.Position.Band.Visible := (VS_strTabPrc[6] = 'S');
    MAT_COMVAR7.Position.Band.Visible := (VS_strTabPrc[7] = 'S');

    MAT_COMDIG1.Visible := blnUSADIG;
    MAT_COMDIG2.Visible := blnUSADIG;
    MAT_COMDIG3.Visible := blnUSADIG;
    MAT_COMDIG4.Visible := blnUSADIG;
    MAT_COMDIG5.Visible := blnUSADIG;
    MAT_COMDIG6.Visible := blnUSADIG;
    MAT_COMDIG7.Visible := blnUSADIG;
  End;

  TFloatField(FCdsMatriz.FieldByName('MAT_COMVAR')).DisplayFormat  := '#,##0.00';
  TFloatField(FCdsMatriz.FieldByName('MAT_COMVAR2')).DisplayFormat := '#,##0.00';
  TFloatField(FCdsMatriz.FieldByName('MAT_COMVAR3')).DisplayFormat := '#,##0.00';
  TFloatField(FCdsMatriz.FieldByName('MAT_COMVAR4')).DisplayFormat := '#,##0.00';
  TFloatField(FCdsMatriz.FieldByName('MAT_COMVAR5')).DisplayFormat := '#,##0.00';
  TFloatField(FCdsMatriz.FieldByName('MAT_COMVAR6')).DisplayFormat := '#,##0.00';
  TFloatField(FCdsMatriz.FieldByName('MAT_COMVAR7')).DisplayFormat := '#,##0.00';

  TFloatField(FCdsMatriz.FieldByName('MAT_COMATA')).DisplayFormat  := '#,##0.00';
  TFloatField(FCdsMatriz.FieldByName('MAT_COMATA2')).DisplayFormat := '#,##0.00';
  TFloatField(FCdsMatriz.FieldByName('MAT_COMATA3')).DisplayFormat := '#,##0.00';
  TFloatField(FCdsMatriz.FieldByName('MAT_COMATA4')).DisplayFormat := '#,##0.00';
  TFloatField(FCdsMatriz.FieldByName('MAT_COMATA5')).DisplayFormat := '#,##0.00';
  TFloatField(FCdsMatriz.FieldByName('MAT_COMATA6')).DisplayFormat := '#,##0.00';
  TFloatField(FCdsMatriz.FieldByName('MAT_COMATA7')).DisplayFormat := '#,##0.00';

  TFloatField(FCdsMatriz.FieldByName('MAT_COMDIS')).DisplayFormat  := '#,##0.00';
  TFloatField(FCdsMatriz.FieldByName('MAT_COMDIS2')).DisplayFormat := '#,##0.00';
  TFloatField(FCdsMatriz.FieldByName('MAT_COMDIS3')).DisplayFormat := '#,##0.00';
  TFloatField(FCdsMatriz.FieldByName('MAT_COMDIS4')).DisplayFormat := '#,##0.00';
  TFloatField(FCdsMatriz.FieldByName('MAT_COMDIS5')).DisplayFormat := '#,##0.00';
  TFloatField(FCdsMatriz.FieldByName('MAT_COMDIS6')).DisplayFormat := '#,##0.00';
  TFloatField(FCdsMatriz.FieldByName('MAT_COMDIS7')).DisplayFormat := '#,##0.00';

  TFloatField(FCdsMatriz.FieldByName('MAT_COMDIG')).DisplayFormat  := '#,##0.00';
  TFloatField(FCdsMatriz.FieldByName('MAT_COMDIG2')).DisplayFormat := '#,##0.00';
  TFloatField(FCdsMatriz.FieldByName('MAT_COMDIG3')).DisplayFormat := '#,##0.00';
  TFloatField(FCdsMatriz.FieldByName('MAT_COMDIG4')).DisplayFormat := '#,##0.00';
  TFloatField(FCdsMatriz.FieldByName('MAT_COMDIG5')).DisplayFormat := '#,##0.00';
  TFloatField(FCdsMatriz.FieldByName('MAT_COMDIG6')).DisplayFormat := '#,##0.00';
  TFloatField(FCdsMatriz.FieldByName('MAT_COMDIG7')).DisplayFormat := '#,##0.00';

  TFloatField(FCdsMatriz.FieldByName('MAT_DESMAX')).DisplayFormat  := '#,##0.00';
  TFloatField(FCdsMatriz.FieldByName('MAT_DESMGE')).DisplayFormat  := '#,##0.00';
  TFloatField(FCdsMatriz.FieldByName('MAT_DESMSU')).DisplayFormat  := '#,##0.00';
  TFloatField(FCdsMatriz.FieldByName('MAT_MARMIN')).DisplayFormat  := '#,##0.00';
  TFloatField(FCdsMatriz.FieldByName('MAT_MARMSG')).DisplayFormat  := '#,##0.00';
  TFloatField(FCdsMatriz.FieldByName('MAT_MARMGE')).DisplayFormat  := '#,##0.00';
end;

function TfrmMatrizProdutos.fTeclaPermiteSalvarDados(const Key: Word): Boolean;
begin
  Result := False;

  If (Key = VK_Return) Then
    Exit(True);

  If (Key = VK_DOWN) Then
    Exit(True);

  If (Key = VK_UP) Then
    Exit(True);
end;

procedure TfrmMatrizProdutos.grdMatrizTvEditValueChanged(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
begin
  inherited;
  If Not blnSalvouComEnter Then
  Begin
    Try
      If FCdsMatriz.State = dsEdit Then
      Begin
        FCdsMatriz.Post;
        FCdsMatriz.DisableControls;
      End;
    Finally
      If FCdsMatriz.ControlsDisabled Then
        FCdsMatriz.EnableControls;
    End;
  End;
end;

procedure TfrmMatrizProdutos.grdMatrizTvKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If fTeclaPermiteSalvarDados(Key) Then
  Begin
    blnSalvouComEnter := True;
    Try
      If FCdsMatriz.State = dsEdit Then
        FCdsMatriz.Post;
      FCdsMatriz.DisableControls;
    Finally
      blnSalvouComEnter := False;
      If FCdsMatriz.ControlsDisabled Then
        FCdsMatriz.EnableControls;
    End;
  End;
end;

function TfrmMatrizProdutos.ShowCOMTB(Idx: Integer): Boolean;
begin
  Result := True;

  if (fCfgSis('PCMPRO') = '1') then
    Exit(False);

  if (VS_strTabPrc[Idx] <> 'S') then
    Exit(False);
end;

function TfrmMatrizProdutos.fCopiaColuna(pgbProgresso: TcxProgressBar): Boolean;
var
  LValue: Variant;
  LFieldName: String;
  LRecNo: Integer;
begin
  Result := False;
  LFieldName := TcxGridDBBandedColumn(grdMatrizTv.Controller.FocusedColumn).DataBinding.FieldName;

  if AnsiMatchStr(LFieldName, ['GRU_CODGRU', 'DESCRI']) then
    Exit;

  LValue := FCdsMatriz.FieldByName(LFieldName).Value;

  pgbProgresso.Properties.Max := FCdsMatriz.RecordCount;
  LRecNo := FCdsMatriz.RecNo;
  FCdsMatriz.DisableControls;
  try
    FCdsMatriz.First;
    while not FCdsMatriz.Eof do
    begin
      FCdsMatriz.Edit;
      FCdsMatriz.FieldByName(LFieldName).Value := LValue;
      FCdsMatriz.Post;

      FCdsMatriz.Next;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    end;
  finally
    FCdsMatriz.RecNo := LRecNo;
    FCdsMatriz.EnableControls;
  end;

  Result := True;
end;

procedure TfrmMatrizProdutos.pAbreConsulta;
var
  LQryMatriz: TUniQuery;
begin
  LQryMatriz := fCriaQuery;
  Try
    LQryMatriz.SQL.Add('SELECT ');
    LQryMatriz.SQL.Add('  PROMAT.*,');
    LQryMatriz.SQL.Add('  CONCAT(COALESCE(GRU_DRELIN, ''''), '' - '', COALESCE(GRU_DESGRU, '''')) AS DESCRI,');
    LQryMatriz.SQL.Add('  GRU_CODGRU ');
    LQryMatriz.SQL.Add('FROM');
    LQryMatriz.SQL.Add('  PROMAT ');
    LQryMatriz.SQL.Add('  RIGHT JOIN CADGRU ON MAT_CODGRU = GRU_CODGRU ');
    LQryMatriz.SQL.Add('ORDER BY GRU_CODGRU ');

    LQryMatriz.Open;

    FCdsMatriz := fCriaClientDatset(LQryMatriz);
    FCdsMatriz.First;
    dsMatriz.DataSet := FCdsMatriz;
    FCdsMatriz.BeforePost := BeforePost;
    FCdsMatriz.AfterPost  := AfterPost;

    grdMatrizTv.ApplyBestFit;
  Finally
    FreeAndNil(LQryMatriz);
  End;
end;

procedure TfrmMatrizProdutos.pValidaDescontoMaximoOperador(Dataset : TDataset);
 begin
  If (IIF(Dataset.FieldByName('MAT_DESMAX').Value = null, -1, Dataset.FieldByName('MAT_DESMAX').Value) > 0) Then
  Begin
    If (Dataset.FieldByName('MAT_DESMAX').Value > Dataset.FieldByName('MAT_DESMSU').Value) And
       (IIF(Dataset.FieldByName('MAT_DESMSU').Value = null, -1, Dataset.FieldByName('MAT_DESMSU').Value) > 0)  Then
    Begin
      fMensagem('ATENÇÃO!', 'Desconto Máx. Vendedor não pode ser Maior que Desconto Máx. Sub-Gerente!', ['&Ok']);
      Abort;
      Exit;
    End;
    If (Dataset.FieldByName('MAT_DESMAX').Value > Dataset.FieldByName('MAT_DESMGE').Value) And
       (IIF(Dataset.FieldByName('MAT_DESMGE').Value = null, -1, Dataset.FieldByName('MAT_DESMGE').Value) > 0)  Then
    Begin
      fMensagem('ATENÇÃO!', 'Desconto Máx. Vendedor não pode ser Maior que Desconto Máx. Gerente!', ['&Ok']);
      Abort;
      Exit;
    End;
  End;
  If (IIF(Dataset.FieldByName('MAT_DESMSU').Value = null, -1, Dataset.FieldByName('MAT_DESMSU').Value) > 0) Then
  Begin
    If (Dataset.FieldByName('MAT_DESMSU').Value < Dataset.FieldByName('MAT_DESMAX').Value) And
       (IIF(Dataset.FieldByName('MAT_DESMAX').Value = null, -1, Dataset.FieldByName('MAT_DESMAX').Value) > 0)  Then
    Begin
      fMensagem('ATENÇÃO!', 'Desconto Máx. Sub-Gerente não pode ser Menor que Desconto Máx. Vendedor!', ['&Ok']);
      Abort;
      Exit;
    End;
    If (Dataset.FieldByName('MAT_DESMSU').Value > Dataset.FieldByName('MAT_DESMSU').Value) And
       (IIF(Dataset.FieldByName('MAT_DESMGE').Value = null, -1, Dataset.FieldByName('MAT_DESMGE').Value) > 0)  Then
    Begin
      fMensagem('ATENÇÃO!', 'Desconto Máx. Sub-Gerente não pode ser Maior que Desconto Máx. Gerente!', ['&Ok']);
      Abort;
      Exit;
    End;
  End;
  If (IIF(Dataset.FieldByName('MAT_DESMGE').Value = null, -1, Dataset.FieldByName('MAT_DESMGE').Value) > 0)  Then
  Begin
    If (Dataset.FieldByName('MAT_DESMGE').Value < Dataset.FieldByName('MAT_DESMAX').Value) And
       (IIF(Dataset.FieldByName('MAT_DESMAX').Value = null, -1, Dataset.FieldByName('MAT_DESMAX').Value) > 0)  Then
    Begin
      fMensagem('ATENÇÃO!', 'Desconto Máx. Gerente não pode ser Menor que Desconto Máx. Vendedor!', ['&Ok']);
      Abort;
      Exit;
    End;
    If (Dataset.FieldByName('MAT_DESMGE').Value < Dataset.FieldByName('MAT_DESMSU').Value) And
       (IIF(Dataset.FieldByName('MAT_DESMSU').Value = null, -1, Dataset.FieldByName('MAT_DESMSU').Value) > 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Desconto Máx. Gerente não pode ser Menor que Desconto Máx. Sub-Gerente!', ['&Ok']);
      Abort;
      Exit;
    End;
  End;
End;

procedure TfrmMatrizProdutos.pValidaMargemMinimaOperador(Dataset : TDataset);
 begin
  If (IIF(Dataset.FieldByName('MAT_MARMIN').Value = null, -1, Dataset.FieldByName('MAT_MARMIN').Value) > 0) Then
  Begin
    If (Dataset.FieldByName('MAT_MARMIN').Value < Dataset.FieldByName('MAT_MARMSG').Value) And
       (IIF(Dataset.FieldByName('MAT_MARMSG').Value = null, -1, Dataset.FieldByName('MAT_MARMSG').Value) > 0)  Then
    Begin
      fMensagem('ATENÇÃO!', 'Margem Min. Vendedor não pode ser Menor que Margem Min. Sub-Gerente!', ['&Ok']);
      Abort;
      Exit;
    End;
    If (Dataset.FieldByName('MAT_MARMIN').Value < Dataset.FieldByName('MAT_MARMGE').Value) And
       (IIF(Dataset.FieldByName('MAT_MARMGE').Value = null, -1, Dataset.FieldByName('MAT_MARMGE').Value) > 0)  Then
    Begin
      fMensagem('ATENÇÃO!', 'Margem Min. Vendedor não pode ser Menor que Margem Min. Gerente!', ['&Ok']);
      Abort;
      Exit;
    End;
  End;
  If (IIF(Dataset.FieldByName('MAT_MARMSG').Value = null, -1, Dataset.FieldByName('MAT_MARMSG').Value) > 0) Then
  Begin
    If (Dataset.FieldByName('MAT_MARMSG').Value > Dataset.FieldByName('MAT_MARMIN').Value) And
       (IIF(Dataset.FieldByName('MAT_MARMIN').Value = null, -1, Dataset.FieldByName('MAT_MARMIN').Value) > 0)  Then
    Begin
      fMensagem('ATENÇÃO!', 'Margem Min. Sub-Gerente não pode ser Maior que Margem Min. Vendedor!', ['&Ok']);
      Abort;
      Exit;
    End;
    If (Dataset.FieldByName('MAT_MARMSG').Value < Dataset.FieldByName('MAT_MARMGE').Value) And
       (IIF(Dataset.FieldByName('MAT_MARMGE').Value = null, -1, Dataset.FieldByName('MAT_MARMGE').Value) > 0)  Then
    Begin
      fMensagem('ATENÇÃO!', 'Margem Min. Sub-Gerente não pode ser Menor que Margem Min. Gerente!', ['&Ok']);
      Abort;
      Exit;
    End;
  End;
  If (IIF(Dataset.FieldByName('MAT_MARMGE').Value = null, -1, Dataset.FieldByName('MAT_MARMGE').Value) > 0)  Then
  Begin
    If (Dataset.FieldByName('MAT_MARMGE').Value > Dataset.FieldByName('MAT_MARMIN').Value) And
       (IIF(Dataset.FieldByName('MAT_MARMIN').Value = null, -1, Dataset.FieldByName('MAT_MARMIN').Value) > 0)  Then
    Begin
      fMensagem('ATENÇÃO!', 'Margem Min. Gerente não pode ser Maior que Margem Min. Vendedor!', ['&Ok']);
      Abort;
      Exit;
    End;
    If (Dataset.FieldByName('MAT_MARMGE').Value > Dataset.FieldByName('MAT_MARMSG').Value) And
       (IIF(Dataset.FieldByName('MAT_MARMSG').Value = null, -1, Dataset.FieldByName('MAT_MARMSG').Value) > 0)  Then
    Begin
      fMensagem('ATENÇÃO!', 'Margem Min. Gerente  não pode ser Maior que Margem Min. Sub-Gerente!', ['&Ok']);
      Abort;
      Exit;
    End;
  End;

End;

end.
