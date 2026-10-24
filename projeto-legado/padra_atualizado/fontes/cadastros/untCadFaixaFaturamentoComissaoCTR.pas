unit untCadFaixaFaturamentoComissaoCTR;

interface

uses
  Windows, Classes, Controls, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, DB,
  Grids, DBGridCitel, DBGrids, Mask, DBCtrls, EditFocus, BitBtnLockedIncrem, untPai, UniClientDataSet,
  Uni;

type
  TfrmCadFaixaFaturamentoComissaoCTR = class(TfrmPai)
    pnlFundo: TPanel;
    pnlGrid: TPanel;
    pnlCentro: TPanel;
    dbgCadFct: TDBGridCitel;
    edtFatIni: TEditFocus;
    edtFatFin: TEditFocus;
    edtPercen: TEditFocus;
    Label5: TLabel;
    Label12: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    dtsCadFct: TDataSource;
    btnAdicionar: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    cdsCadFct: TUniClientDataSet;
    cdsCadFctID: TIntegerField;
    cdsCadFctFATINI: TFloatField;
    cdsCadFctFATFIN: TFloatField;
    cdsCadFctPERCEN: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure cdsCadFctAfterPost(DataSet: TDataSet);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure dbgCadFctDblClick(Sender: TObject);
    procedure dbgCadFctKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    blnAlterou: Boolean;
    blnEditando: Boolean;
    procedure pLimpaCampos;
    procedure pAlteraRegistro;
    procedure pEdit;
    function fGetId: Integer;
    function fCheckaOuterRange: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses SysUtils, Forms, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadFaixaFaturamentoComissaoCTR.pAlteraRegistro;
begin
  pEdit;
  
  edtFatIni.Text := FormatFloat('#,##0.00', cdsCadFctFATINI.AsFloat);
  edtFatFin.Text := FormatFloat('#,##0.00', cdsCadFctFATFIN.AsFloat);
  edtPercen.Text := FormatFloat('#,##0.00', cdsCadFctPERCEN.AsFloat);

  pSetFocus(edtFatIni);
end;

procedure TfrmCadFaixaFaturamentoComissaoCTR.pEdit;
begin
  blnEditando := True;
  dbgCadFct.Enabled := False;
end;

procedure TfrmCadFaixaFaturamentoComissaoCTR.pLimpaCampos;
begin
  edtFatIni.Text := '0,00';
  edtFatFin.Text := '0,00';
  edtPercen.Text := '0,00';
  pSetFocus(edtFatIni);
end;

procedure TfrmCadFaixaFaturamentoComissaoCTR.btnAdicionarClick(Sender: TObject);
  Var
    intID: Integer;
begin
  If fVerificaCampos Then
  Begin
    If Not fCheckaOuterRange Then
    Begin
      fMensagem('', 'Já existe um intervalo cadastrado dentro do intervalo especificado!', ['&O k']);
      Exit;
    End;

    intID := fGetId;

    If blnEditando Then
      cdsCadFct.Edit
    Else
      cdsCadFct.Append;

    cdsCadFctID.AsInteger := intID;
    cdsCadFctFATINI.AsFloat := fStrToFloat(edtFatIni.Text);
    cdsCadFctFATFIN.AsFloat := fStrToFloat(edtFatFin.Text);
    cdsCadFctPERCEN.AsFloat := fStrToFloat(edtPercen.Text);

    cdsCadFct.Post;

    pLimpaCampos;
  End;
end;

procedure TfrmCadFaixaFaturamentoComissaoCTR.btnGravarClick(Sender: TObject);
  Var
    qryCad: TUniQuery;
begin
  If fMensagem('', 'Confirma gravação das faixas?', ['&Sim', '&Não']) = 2 Then
    Exit;

  qryCad := fCriaQuery;
  Try
    // Apaga todas faixas da empresa
    qryCad.SQL.Add('DELETE');
    qryCad.SQL.Add('  FROM CADFCT');

    qryCad.ExecSQL;

    // Insere novas faixas
    qryCad.SQL.Clear;
    qryCad.SQL.Add('INSERT INTO CADFCT(');
    qryCad.SQL.Add('  FCT_FATINI,');
    qryCad.SQL.Add('  FCT_FATFIN,');
    qryCad.SQL.Add('  FCT_PERCEN,');
    qryCad.SQL.Add('  FCT_CODEMP');
    qryCad.SQL.Add(') VALUES (');
    qryCad.SQL.Add('  :FATINI,');
    qryCad.SQL.Add('  :FATFIN,');
    qryCad.SQL.Add('  :PERCEN,');
    qryCad.SQL.Add('  :CODEMP )');

    cdsCadFct.First;
    While Not cdsCadFct.Eof Do
    Begin
      qryCad.ParamByName('FATINI').AsFloat := cdsCadFctFATINI.AsFloat;
      qryCad.ParamByName('FATFIN').AsFloat := cdsCadFctFATFIN.AsFloat;
      qryCad.ParamByName('PERCEN').AsFloat := cdsCadFctPERCEN.AsFloat;
      qryCad.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryCad.ExecSQL;

      cdsCadFct.Next;
    End;

    fMensagem('', 'Faixas salvas com sucesso!', ['&Ok']);
    blnAlterou := False;
    Close;
  Finally
    FreeAndNil(qryCad);
  End;
end;

procedure TfrmCadFaixaFaturamentoComissaoCTR.cdsCadFctAfterPost(DataSet: TDataSet);
begin
  blnAlterou := True;
  btnGravar.Enabled := True;
  blnEditando := False;
  dbgCadFct.Enabled := True;
end;

procedure TfrmCadFaixaFaturamentoComissaoCTR.dbgCadFctDblClick(Sender: TObject);
begin
  If Not cdsCadFct.IsEmpty Then
    pAlteraRegistro
end;

procedure TfrmCadFaixaFaturamentoComissaoCTR.dbgCadFctKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If (Key = VK_RETURN) And (Not cdsCadFct.IsEmpty) Then
    pAlteraRegistro;

  If (Key = VK_DELETE) And (Not cdsCadFct.IsEmpty) And (fMensagem('', 'Deseja apagar registro selecionado?', ['&Sim', '&Não']) = 1) Then
    cdsCadFct.Delete;
end;

function TfrmCadFaixaFaturamentoComissaoCTR.fCheckaOuterRange: Boolean;
  Var
    cdsAux: TUniClientDataSet;
begin
  Result := False;

  cdsAux := TUniClientDataSet.Create(Nil);

  Try
    cdsAux.Data := cdsCadFct.Data;
    cdsAux.First;
    While Not cdsAux.Eof Do
    Begin
      If blnEditando And (cdsAux.FieldByName('ID').AsInteger = fGetId) Then
      Begin
        cdsAux.Next;
        Continue;
      End;

      If (cdsAux.FieldByName('FATINI').AsFloat >= fStrToFloat(edtFatIni.Text)) And (cdsAux.FieldByName('FATINI').AsFloat <= fStrToFloat(edtFatFin.Text)) Then
        Exit;

      If (cdsAux.FieldByName('FATFIN').AsFloat >= fStrToFloat(edtFatIni.Text)) And (cdsAux.FieldByName('FATFIN').AsFloat <= fStrToFloat(edtFatFin.Text)) Then
        Exit;

      cdsAux.Next;
    End;

    Result := True;
  Finally
    FreeAndNil(cdsAux);
  End;
end;

function TfrmCadFaixaFaturamentoComissaoCTR.fGetId: Integer;
  Var
    cdsAux: TUniClientDataSet;
begin
  If blnEditando Then
  Begin
    Result := cdsCadFctID.AsInteger;
    Exit;
  End;

  cdsAux := TUniClientDataSet.Create(Nil);
  Try
    cdsAux.Data := cdsCadFct.Data;

    cdsAux.IndexFieldNames := 'ID';
    cdsAux.Last;
    
    Result := cdsAux.FieldByName('ID').AsInteger + 1;
  Finally
    cdsAux.Free;
  End;
end;

procedure TfrmCadFaixaFaturamentoComissaoCTR.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtFatIni);
end;

procedure TfrmCadFaixaFaturamentoComissaoCTR.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  If blnAlterou And (fMensagem('', 'Deseja cancelar edição?', ['&Sim','&Não']) = 2) Then
    CanClose := False;
end;

procedure TfrmCadFaixaFaturamentoComissaoCTR.FormCreate(Sender: TObject);
  Var
    qryCadFct: TUniQuery;
begin
  inherited;

  qryCadFct := fCriaQuery;
  Try

    qryCadFct.SQL.Add('SELECT *');
    qryCadFct.SQL.Add('  FROM CADFCT');
    qryCadFct.SQL.Add(' ORDER BY FCT_FATINI ASC');

    qryCadFct.Open;

    cdsCadFct.CreateDataSet;
    cdsCadFct.Open;
    cdsCadFct.IndexFieldNames := 'FATINI';

    While Not qryCadFct.Eof Do
    Begin
      cdsCadFct.Append;

      cdsCadFctID.AsInteger := qryCadFct.RecNo;
      cdsCadFctFATINI.AsFloat := qryCadFct.FieldByName('FCT_FATINI').AsFloat;
      cdsCadFctFATFIN.AsFloat := qryCadFct.FieldByName('FCT_FATFIN').AsFloat;
      cdsCadFctPERCEN.AsFloat := qryCadFct.FieldByName('FCT_PERCEN').AsFloat;

      cdsCadFct.Post;

      qryCadFct.Next;
    End;    
  Finally
    FreeAndNil(qryCadFct);
  End;              
end;

procedure TfrmCadFaixaFaturamentoComissaoCTR.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) And blnEditando Then
  Begin
    Key := 0;
    blnEditando := False;
    pLimpaCampos;
    dbgCadFct.Enabled := True;
  End;
end;

procedure TfrmCadFaixaFaturamentoComissaoCTR.FormShow(Sender: TObject);
begin
  inherited;
  blnAlterou := False;
end;

function TfrmCadFaixaFaturamentoComissaoCTR.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  Var
    strMsg: String;
  function fCheckRange(fltFat: Double): Boolean;
    Var
      cdsAux: TUniClientDataSet;
  begin
    Result := True;

    cdsAux := TUniClientDataSet.Create(Nil);

    Try
      cdsAux.Data := cdsCadFct.Data;
      cdsAux.First;
      While Not cdsAux.Eof Do
      Begin
        If blnEditando And (cdsAux.FieldByName('ID').AsInteger = fGetId) Then
        Begin
          cdsAux.Next;
          Continue;
        End;

        If (fltFat >= cdsAux.FieldByName('FATINI').AsFloat) And (fltFat <= cdsAux.FieldByName('FATFIN').AsFloat) Then
        Begin
          Result := False;
          Exit;
        End;

        cdsAux.Next;
      End;    

    Finally
      FreeAndNil(cdsAux);
    End;              
  end;
begin
  Result := True;

  If Sender = edtFatIni Then
  Begin
    If fStrToFloat(edtFatIni.Text) <= 0 Then
      strMsg := 'Faturamento Inicial deve ser maior que zero!'

    Else If Not fCheckRange(fStrToFloat(edtFatIni.Text)) Then
      strMsg := 'Faturamento Inicial inválido! Já existe um intervalo contendo o valor especificado.'
  End

  Else If Sender = edtFatFin Then
  Begin
    If fStrToFloat(edtFatFin.Text) < fStrToFloat(edtFatIni.Text) Then
      strMsg := 'Faturamento Final deve ser maior ou igual ao Faturamento Inicial'

    Else If Not fCheckRange(fStrToFloat(edtFatFin.Text)) Then
      strMsg := 'Faturamento Final inválido! Já existe um intervalo contendo o valor especificado.'
  End

  Else If Sender = edtPercen Then
  Begin
    If fStrToFloat(edtPercen.Text) <= 0 Then
      strMsg := 'Percentual de comissão deve ser maior que zero!'
  End;

  If Not fEmptyStr(strMsg) Then
  Begin
    fMensagem('', strMsg, ['&O k']);
    Result := False;
    pSetFocus(Sender);
  End;
end;

End.
