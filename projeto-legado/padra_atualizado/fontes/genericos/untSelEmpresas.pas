unit untSelEmpresas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Uni, untPaiConfirma, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxDataControllerConditionalFormattingRulesManagerDialog, cxCheckBox;

type
  TfrmSelEmpresas = class(TfrmPaiConfirma)
    dsCadEmp: TDataSource;
    cxGridEmpresas: TcxGridCitel;
    cxGridEmpresasTable: TcxGridDBTableViewCitel;
    cxGridEmpresasTableCODEMP: TcxGridDBColumn;
    cxGridEmpresasTableNOMEMP: TcxGridDBColumn;
    cxGridEmpresasTablemMARDES: TcxGridDBColumn;
    cxGridEmpresasLevel: TcxGridLevel;
    btnMarcaDesmarca: TBitBtnLocked;
    btnDesmarcaTodas: TBitBtnLocked;
    btnMarcaTodas: TBitBtnLocked;
    procedure cxGridEmpresasTableCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMarcaDesmarcaClick(Sender: TObject);
    procedure btnMarcaTodasClick(Sender: TObject);
    procedure btnDesmarcaTodasClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    FCodEmp: String;

    procedure pMarcaDesmarca;
    procedure pMarcaDesmarcaTodas(blnMarcar: Boolean);
    procedure pAbreQuery;

  public
    { Public declarations }
    qryCadEmp: TUniQuery;

    property strCodEmp: String Read FCodEmp Write FCodEmp;
    function fRetEmpresasSel(EmpresasMarcadas: String): string;
    function pAbreEmpresaTipAbf(strCodCfg: String = 'CFG_TIPABF'): TfrmSelEmpresas;
    function fRetSelecionadas: String;
    function pShowModal: TfrmSelEmpresas;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untTypesSistema;

procedure TfrmSelEmpresas.btnMarcaTodasClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodas(True);
end;

procedure TfrmSelEmpresas.btnDesmarcaTodasClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodas(False);
end;

procedure TfrmSelEmpresas.btnConfirmaClick(Sender: TObject);
begin
  If Not dsCadEmp.DataSet.Locate('MARDES', 'M', []) Then
    fMensagem('ATENÇÃO!', 'Marque pelo menos uma Empresa!', ['&Ok'])
  Else
    ModalResult := 1;

  //inherited;
end;

procedure TfrmSelEmpresas.btnMarcaDesmarcaClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarca;
end;

procedure TfrmSelEmpresas.cxGridEmpresasTableCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  With dsCadEmp.DataSet Do
  Begin
    If Not Active Then
      Exit;

    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridEmpresasTablemMARDES.Index]) = 'M' Then
    Begin
      If AViewInfo.Selected Then
        ACanvas.Font.Color := clLime
      Else
        ACanvas.Font.Color := clBlue;
    End;
  End;
end;

procedure TfrmSelEmpresas.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadEmp := fCriaQuery;
  dsCadEmp.DataSet := qryCadEmp;
end;

procedure TfrmSelEmpresas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F5: pMarcaDesmarca;
    VK_F6: pMarcaDesmarcaTodas(True);
    VK_F7: pMarcaDesmarcaTodas(False);
  End;
end;

procedure TfrmSelEmpresas.FormShow(Sender: TObject);
begin
  inherited;
  pAbreQuery;
end;


procedure TfrmSelEmpresas.pAbreQuery;
Begin
  If qryCadEmp.IsEmpty Then
  Begin
    With qryCadEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ');
      SQL.Add('  EMP_CODEMP, ');
      SQL.Add('  EMP_NOMEMP, ');
      SQL.Add('  "D" AS MARDES ');
      SQL.Add('FROM ');
      SQL.Add('  CADEMP ');
      SQL.Add('WHERE ');
      SQL.Add('  EMP_CODEMP <> :CODEMP');
      SQL.Add('  AND EMP_EMPATI = "S"');
      SQL.Add(' ORDER BY EMP_CODEMP');
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;
      pSetaClient(qryCadEmp);
    End;
  End;
End;

function TfrmSelEmpresas.pAbreEmpresaTipAbf(strCodCfg: String = 'CFG_TIPABF'): TfrmSelEmpresas;
Begin
  Result := Self;
  If qryCadEmp.IsEmpty Then
  Begin
    With qryCadEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ');
      SQL.Add('  EMP_CODEMP, ');
      SQL.Add('  EMP_NOMEMP, ');
      SQL.Add('  "D" AS MARDES ');
      SQL.Add('FROM ');
      SQL.Add('  CADEMP ');
      SQL.Add('WHERE ');
      SQL.Add('  EMP_CODEMP <> :CODEMP');
      SQL.Add('  AND fCfgSis("'+strCodCfg+'",EMP_CODEMP) = 2');
      SQL.Add('  AND EMP_EMPATI = "S"');
      SQL.Add(' ORDER BY EMP_CODEMP');
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;
      pSetaClient(qryCadEmp);
    End;
  End;
End;

function TfrmSelEmpresas.fRetEmpresasSel(EmpresasMarcadas: String): string;
begin
  Result := '';
  If Not fEmptyStr(EmpresasMarcadas) Then
  Begin
    pAbreQuery;
    while not dsCadEmp.DataSet.Eof Do
    Begin
      If Pos(dsCadEmp.DataSet.FieldByName('EMP_CODEMP').AsString, EmpresasMarcadas) > 0 Then
      Begin
        dsCadEmp.DataSet.Edit;
        dsCadEmp.DataSet.FieldByName('MARDES').AsString := 'M';
        dsCadEmp.DataSet.Post;
      End;
      dsCadEmp.DataSet.Next;
    End;
    dsCadEmp.DataSet.First;
  End;

  Result := EmpresasMarcadas;
  If Showmodal = mrOk Then
  Begin
    dsCadEmp.DataSet.Filtered := False;
    dsCadEmp.DataSet.Filter := 'MARDES = ' + QuotedStr('M');
    dsCadEmp.DataSet.Filtered := True;
    Result := '';
    While not dsCadEmp.DataSet.Eof do
    Begin
      Result := Result + dsCadEmp.DataSet.FieldByName('EMP_CODEMP').AsString;
      If Not(dsCadEmp.DataSet.RecordCount = dsCadEmp.DataSet.RecNo) Then
        Result := Result + ',';
      dsCadEmp.DataSet.Next;
    End;
  End
end;

function TfrmSelEmpresas.fRetSelecionadas: String;
Begin
  dsCadEmp.DataSet.Filtered := False;
  dsCadEmp.DataSet.Filter := 'MARDES = ' + QuotedStr('M');
  dsCadEmp.DataSet.Filtered := True;
  Result := '';
  While not dsCadEmp.DataSet.Eof do
  Begin
    Result := Result + dsCadEmp.DataSet.FieldByName('EMP_CODEMP').AsString;
    If Not(dsCadEmp.DataSet.RecordCount = dsCadEmp.DataSet.RecNo) Then
      Result := Result + ',';
    dsCadEmp.DataSet.Next;
  End;
End;

procedure TfrmSelEmpresas.pMarcaDesmarca;
begin
  With dsCadEmp.DataSet Do
  Begin
    If Not IsEmpty Then
    Begin
      Edit;

      If FieldByName('MARDES').AsString = 'M' Then
        FieldByName('MARDES').AsString := 'D'
      Else
        FieldByName('MARDES').AsString := 'M';

      Post;
    End;
  End;
end;

procedure TfrmSelEmpresas.pMarcaDesmarcaTodas(blnMarcar: Boolean);
  Var
    prcScroll: TprcScroll;
    intRecNo: Integer;
begin
  intRecNo := dsCadEmp.DataSet.RecNo;
  pDisableControls(dsCadEmp.DataSet, prcScroll);

  With dsCadEmp.DataSet Do
  Begin
    If Not IsEmpty Then
    Begin
      First;

      While Not Eof Do
      Begin
        Edit;

        If blnMarcar Then
          FieldByName('MARDES').AsString := 'M'
        Else
          FieldByName('MARDES').AsString := 'D';

        Post;
        Next;
      End;
    End;
  End;

  dsCadEmp.DataSet.RecNo := intRecNo;
  pEnableControls(dsCadEmp.DataSet, prcScroll);


end;

function TfrmSelEmpresas.pShowModal: TfrmSelEmpresas;
begin
  Result := Self;
  If Not qryCadEmp.IsEmpty Then
  	ShowModal;
end;

end.
