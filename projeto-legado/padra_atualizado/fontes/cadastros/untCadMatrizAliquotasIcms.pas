unit untCadMatrizAliquotasIcms;

interface

uses
  Windows, Classes, Controls, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls,
  Buttons, ExtCtrls, EditFocus, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Mask, DBCtrls, DBEditFocus, UniDataSetProvider, UniClientDataSet, Uni,
  untFuncoesSimples, BitBtnLockedIncrem, cxLookAndFeels, untTypesSistema,
  cxLookAndFeelPainters, cxNavigator, Variants, Vcl.Graphics,
  Provider, frxClass, frxExportCSVTestabilidade, Winapi.Messages,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient,
  RLReport, cxContainer, cxLabel, Vcl.Grids, Vcl.DBGrids, DBGridCitel;

type
  TDBgridCitel = class(DBGridCitel.TDBgridCitel)
  private
    // Removemos as barras de rolagem horizontal e vertical do grid
    procedure WMNCCalcSize(var msg: TMessage); message WM_NCCALCSIZE;
  end;

  TfrmCadMatrizAliquotasIcms = class(TfrmPaiCad)
    pnlDados: TPanel;
    Panel1: TPanel;
    dtsIcmAlq: TDataSource;
    Label4: TLabel;
    dbeDescricao: TDBEditFocus;
    Label3: TLabel;
    dbeCodMat: TDBEditFocus;
    pnlMatriz: TPanel;
    pnlOrigem: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    Label2: TLabel;
    pnlDestino: TPanel;
    lblOrigem: TLabel;
    dbgAlqIcm: TDBgridCitel;
    dtsTabela: TDataSource;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbgAlqIcmColEnter(Sender: TObject);
    procedure dbgAlqIcmDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgAlqIcmKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgAlqIcmCellClick(Column: TColumn);
    procedure dbgAlqIcmKeyPress(Sender: TObject; var Key: Char);
    procedure dbgAlqIcmExit(Sender: TObject);
  private
    { Private declarations }
    cdsIcmAlq: TUniClientDataSet;
    FRecNo: Integer;
    FSelectedField: String;
    procedure pCriarMatriz();
    procedure pCarregarMatriz(); overload;
    procedure pCarregarMatriz(strCodigo: String); overload;
    procedure pGravarMatriz(); overload;
    procedure pGravarMatriz(strCodigo: String); overload;
    procedure pAfterScroll(DataSet: TDataSet);
    procedure pAfterInsert(DataSet: TDataSet);
    procedure pBeforePost(DataSet: TDataSet);
  public
    { Public declarations }
  protected
    { Protected declarations }
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  end;

implementation

{$R *.dfm}

Uses
  SysUtils, Math, Forms, untConsultas, untConstantes;

procedure TfrmCadMatrizAliquotasIcms.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pnlMatriz.Enabled := True;
  pHabilitaCodigo(dbeCodMat, dbeDescricao, False);
end;

procedure TfrmCadMatrizAliquotasIcms.btnCancelaClick(Sender: TObject);
begin
  inherited;
  fExecutarModal(pCarregarMatriz, 'Aguarde, carregando matriz de alíquotas de ICMS ...', '');
  pnlMatriz.Enabled := False;
end;

procedure TfrmCadMatrizAliquotasIcms.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadMatrizAliquotasIcms.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  fExecutarModal(pCarregarMatriz, 'Aguarde, carregando matriz de alíquotas de ICMS ...', '');
end;

procedure TfrmCadMatrizAliquotasIcms.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;

    If blnGravou Then
    Begin
      fExecutarModal(pGravarMatriz, 'Aguarde, gravando matriz de alíquotas de ICMS ...', '');
      fCommit;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadMatrizAliquotasIcms.btnGravarClick]');
    End;
  End;

  pnlMatriz.Enabled := False;
end;

procedure TfrmCadMatrizAliquotasIcms.btnIncluirClick(Sender: TObject);
begin
  inherited;

  pHabilitaCodigo(dbeCodMat, dbeDescricao, Not blnUsaProCodigo);

  If fPergunta('Deseja carregar os valores da ' + ALIQUOTAS_ICMS_TABELA_ANO + ' ?') Then
    pCarregarMatriz(ALIQUOTAS_ICMS_TABELA_ANO)
  Else
    pCarregarMatriz('');

  pnlMatriz.Enabled := True;
end;

procedure TfrmCadMatrizAliquotasIcms.pAfterInsert(DataSet: TDataSet);
begin
  DataSet.Cancel;
end;

procedure TfrmCadMatrizAliquotasIcms.pAfterScroll(DataSet: TDataSet);
begin
  FRecNo := DataSet.RecNo;
  If cdsIcmAlq.RecNo = 1 Then
    cdsIcmAlq.Next;
end;

procedure TfrmCadMatrizAliquotasIcms.pBeforePost(DataSet: TDataSet);
var
  LEstado: String;
begin
  For LEstado In ALIQUOTAS_ICMS_UF Do
    If fStrToFloat(DataSet.FieldByName(LEstado).AsString, -1) < 0 Then
    Begin
      pMensagemOk('Alíquota de ICMS informada para o estado de ' + LEstado +
        ' não é um valor válido!');
      DataSet.FieldByName(LEstado).FocusControl;
      Abort;
    End;
end;

procedure TfrmCadMatrizAliquotasIcms.pCarregarMatriz(strCodigo: String);
Var
  qryIcmAlq: TUniQuery;
  strOrigem: String;
  intDestino: Integer;
  strDestino: String;
Begin
  qryIcmAlq := fCriaQuery();
  Try
    cdsIcmAlq.DisableControls;
    cdsIcmAlq.BeforePost := nil;

    qryIcmAlq.SQL.Text := 'SELECT * FROM ICMALQ WHERE ICM_CODMAT = ' +
      strCodigo.QuotedString;
    qryIcmAlq.Open;
    cdsIcmAlq.First;

    While Not cdsIcmAlq.Eof Do
    Begin
      strOrigem := cdsIcmAlq.FieldByName('ORIGEM').AsString;
      cdsIcmAlq.Edit;

      For intDestino := 0 To High(ALIQUOTAS_ICMS_UF) Do
      Begin
        strDestino := ALIQUOTAS_ICMS_UF[intDestino];

        If strCodigo = ALIQUOTAS_ICMS_TABELA_ANO Then
          cdsIcmAlq.FieldByName(strDestino).AsString :=
            ALIQUOTAS_ICMS_INTERESTADUAIS[cdsIcmAlq.RecNo-2][intDestino].ToString()

        Else If strCodigo.IsEmpty Or Not qryIcmAlq.Locate('ICM_UF_ORI;ICM_UF_DES',
          VarArrayOf([strOrigem, strDestino]), []) Then
          cdsIcmAlq.FieldByName(strDestino).AsString := '0'

        Else
          cdsIcmAlq.FieldByName(strDestino).AsString :=
            qryIcmAlq.FieldByName('ICM_ALQICM').AsString;

      End;

      cdsIcmAlq.Next;
    End;

  Finally
    cdsIcmAlq.EnableControls;
    cdsIcmAlq.BeforePost := pBeforePost;
    FreeAndNil(qryIcmAlq);
  End;

  cdsIcmAlq.First;
End;

procedure TfrmCadMatrizAliquotasIcms.pCarregarMatriz;
begin
  pCarregarMatriz(qryTabela.FieldByName('ICM_CODMAT').AsString);
end;

procedure TfrmCadMatrizAliquotasIcms.pCriarMatriz;
var
  LEstado: String;

  procedure pCriarColuna(AName: String);
  begin
    With cdsIcmAlq.FieldDefs.AddFieldDef Do
    Begin
      Name := AName;
      DataType := ftString;
      DisplayName := AName;
    End;
  end;

  procedure pAdicionarOrigem(AEstado: String);
  Var
    LEstado: String;
  begin
    cdsIcmAlq.Append;
    cdsIcmAlq.FieldByName('ORIGEM').AsString := AEstado;
    For LEstado In ALIQUOTAS_ICMS_UF Do
      If AEstado.IsEmpty Then
        cdsIcmAlq.FieldByName(LEstado).AsString := LEstado
      Else
        cdsIcmAlq.FieldByName(LEstado).AsString := '0';
    cdsIcmAlq.Post;
  end;

  procedure pFormatarColuna(AColumn: TColumn);
  begin
    AColumn.Width := 25;
    AColumn.Title.Alignment := TAlignment.taCenter;
    AColumn.Title.Font.Style := [fsBold];
    AColumn.Title.Font.Color := clRed;
    AColumn.Font.Style := [fsBold];
    AColumn.Color := clWhite;
    cdsIcmAlq.FindField(AColumn.FieldName).ReadOnly := False;
    TStringField(cdsIcmAlq.FindField(AColumn.FieldName)).Alignment :=
      TAlignment.taCenter;
  end;

  procedure pFormatarCampos;
  Var
    LEstado: String;
  begin
    pFormatarColuna(fFindColumnByName(dbgAlqIcm, 'ORIGEM'));

    With fFindColumnByName(dbgAlqIcm, 'ORIGEM') Do
    Begin
      Title.Caption := '';
      Font.Color := clBlue;
      Font.Style := [fsBold];
      Color := Title.Color;
    end;

    cdsIcmAlq.FindField('ORIGEM').ReadOnly := True;

    For LEstado In ALIQUOTAS_ICMS_UF Do
      pFormatarColuna(fFindColumnByName(dbgAlqIcm, LEstado));
  end;

begin
  cdsIcmAlq := TUniClientDataSet.Create(Self);

  pCriarColuna('ORIGEM');

  For LEstado In ALIQUOTAS_ICMS_UF Do
    pCriarColuna(LEstado);

  cdsIcmAlq.CreateDataSet;

  pAdicionarOrigem('');
  For LEstado In ALIQUOTAS_ICMS_UF Do
    pAdicionarOrigem(LEstado);

  cdsIcmAlq.AfterScroll := pAfterScroll;
  cdsIcmAlq.AfterInsert := pAfterInsert;
  cdsIcmAlq.BeforePost := pBeforePost;

  dtsIcmAlq.DataSet := cdsIcmAlq;

  dbgAlqIcm.Columns.RebuildColumns;

  pFormatarCampos;

  cdsIcmAlq.First;
end;

procedure TfrmCadMatrizAliquotasIcms.pGravarMatriz;
begin
  pGravarMatriz(qryTabela.FieldByName('ICM_CODMAT').AsString);
end;

procedure TfrmCadMatrizAliquotasIcms.pGravarMatriz(strCodigo: String);
Var
  qryIcmAlq: TUniQuery;
  strOrigem: String;
  strDestino: String;
Begin
  qryIcmAlq := fCriaQuery();
  Try
    cdsIcmAlq.DisableControls;
    qryIcmAlq.SQL.Text := 'SELECT * FROM ICMALQ WHERE ICM_CODMAT = ' +
      strCodigo.QuotedString;
    qryIcmAlq.Open;
    cdsIcmAlq.First;

    While Not cdsIcmAlq.Eof Do
    Begin
      strOrigem := cdsIcmAlq.FieldByName('ORIGEM').AsString;

      For strDestino In ALIQUOTAS_ICMS_UF Do
        If qryIcmAlq.Locate('ICM_UF_ORI;ICM_UF_DES',
          VarArrayOf([strOrigem, strDestino]), []) Then
        Begin
          qryIcmAlq.Edit;
          qryIcmAlq.FieldByName('ICM_ALQICM').AsFloat :=
            fStrToFloat(cdsIcmAlq.FieldByName(strDestino).AsString);
          qryIcmAlq.Post;
        End
        Else
        Begin
          qryIcmAlq.Append;
          qryIcmAlq.FieldByName('AUTOINCREM').AsString :=
            fRetAutoIncrem('ICMALQ', VS_strCodEmp);
          qryIcmAlq.FieldByName('ICM_CODMAT').AsString := strCodigo;
          qryIcmAlq.FieldByName('ICM_UF_ORI').AsString := strOrigem;
          qryIcmAlq.FieldByName('ICM_UF_DES').AsString := strDestino;
          qryIcmAlq.FieldByName('ICM_ALQICM').AsFloat :=
            fStrToFloat(cdsIcmAlq.FieldByName(strDestino).AsString);
          qryIcmAlq.Post;
        End;

      cdsIcmAlq.Next;
    End;
  Finally
    cdsIcmAlq.EnableControls;
    FreeAndNil(qryIcmAlq);
  End;
end;

procedure TfrmCadMatrizAliquotasIcms.pInicializaIndices;
begin
  inherited;
end;

procedure TfrmCadMatrizAliquotasIcms.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
  arrSel: TConsultasArray;
begin
  inherited;
  chrKey := '?';
  If fPesqMatrizAliquotasIcms(Self, Nil, Nil, qryTabela, chrKey, arrSel) Then
  Begin
    fExecutarModal(pCarregarMatriz, 'Aguarde, carregando matriz de alíquotas de ICMS ...', '');
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadMatrizAliquotasIcms.dbgAlqIcmCellClick(Column: TColumn);
begin
  inherited;
  dbgAlqIcm.Repaint;
end;

procedure TfrmCadMatrizAliquotasIcms.dbgAlqIcmColEnter(Sender: TObject);
begin
  inherited;
  If dbgAlqIcm.SelectedField.FieldName = 'ORIGEM' Then
    cdsIcmAlq.FieldByName(ALIQUOTAS_ICMS_UF[0]).FocusControl;
  FSelectedField := dbgAlqIcm.SelectedField.FieldName;
  dbgAlqIcm.Repaint;
end;

procedure TfrmCadMatrizAliquotasIcms.dbgAlqIcmDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  If cdsIcmAlq.FieldByName('ORIGEM').AsString.Equals(Column.Title.Caption) Then
  Begin
    dbgAlqIcm.Canvas.Brush.Color := clBlack;
    dbgAlqIcm.Canvas.Font.Color := clWhite;
  End
  Else If cdsIcmAlq.RecNo.ToString.Equals('1') Then
  Begin
    dbgAlqIcm.Canvas.Brush.Color := clWhite;
    dbgAlqIcm.Canvas.Font.Color := clRed;
  End
  Else If Column.FieldName.Equals('ORIGEM') Then
  Begin
    dbgAlqIcm.Canvas.Brush.Color := clWhite;
    dbgAlqIcm.Canvas.Font.Color := clBlue;
  End
  Else If Column.Field.FieldName.Equals(FSelectedField) And
    (cdsIcmAlq.RecNo < FRecNo) Then
  Begin
    dbgAlqIcm.Canvas.Brush.Color := $00A6FFFF;
    dbgAlqIcm.Canvas.Font.Color := clBlack;
  End
  Else If (FSelectedField <> '') And (cdsIcmAlq.RecNo = FRecNo) And
    (Column.Index < fFindColumnByName(dbgAlqIcm, FSelectedField).Index) Then
  Begin
    dbgAlqIcm.Canvas.Brush.Color := $00A6FFFF;
    dbgAlqIcm.Canvas.Font.Color := clBlack;
  End;
  dbgAlqIcm.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmCadMatrizAliquotasIcms.dbgAlqIcmExit(Sender: TObject);
begin
  inherited;
  dbgAlqIcm.Repaint;
end;

procedure TfrmCadMatrizAliquotasIcms.dbgAlqIcmKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Key = '.' Then
    Key := FormatSettings.DecimalSeparator;
  If Key = ',' Then
    Key := FormatSettings.DecimalSeparator;

  If Not(CharInSet(Key, ['0' .. '9', #13, #8,
    FormatSettings.DecimalSeparator])) Then
  Begin
    Key := #0;
  End;
end;

procedure TfrmCadMatrizAliquotasIcms.dbgAlqIcmKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  dbgAlqIcm.Repaint;
end;

procedure TfrmCadMatrizAliquotasIcms.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'MATICM';
  strNomeCampo := 'ICM_CODMAT';

  qryTabela := fCriarQuery('SELECT * FROM MATICM WHERE FALSE', Self);

  dtsTabela.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodMat;

  pCriarMatriz();

  pnlMatriz.Enabled := False;
end;

function TfrmCadMatrizAliquotasIcms.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Not blnUsaProCodigo) And (Sender = dbeCodMat) Then
    Begin
      If fEmptyStr(dbeCodMat.Text) Then
      Begin
        fMensagem('', 'Informe o código!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = dbeDescricao) Then
    Begin
      If fEmptyStr(dbeDescricao.Text) Then
      Begin
        fMensagem('', 'Informe a descrição!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

{ TDBgridCitel }

procedure TDBgridCitel.WMNCCalcSize(var msg: TMessage);
Var
  Style: Integer;
begin
  // Removemos as barras de rolagem horizontal e vertical do grid
  Style := getWindowLong(handle, GWL_STYLE);
  SetWindowLong(handle, GWL_STYLE, Style and not WS_HSCROLL and not WS_VSCROLL);
  inherited;
end;

end.
