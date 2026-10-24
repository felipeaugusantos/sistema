unit untCadMatrizAliquotasFCP;

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

  TfrmCadMatrizAliquotasFCP = class(TfrmPaiCad)
    pnlDados: TPanel;
    Panel1: TPanel;
    dtsFCPAlq: TDataSource;
    Label4: TLabel;
    dbeDescricao: TDBEditFocus;
    Label3: TLabel;
    dbeCodMat: TDBEditFocus;
    pnlMatriz: TPanel;
    pnlOrigem: TPanel;
    Label1: TLabel;
    dbgAlqFCP: TDBgridCitel;
    dtsTabela: TDataSource;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbgAlqFCPDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgAlqFCPKeyPress(Sender: TObject; var Key: Char);
    procedure dbgAlqFCPKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgAlqFCPEnter(Sender: TObject);
  private
    { Private declarations }
    cdsFCPAlq: TUniClientDataSet;
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

procedure TfrmCadMatrizAliquotasFCP.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pnlMatriz.Enabled := True;
  pHabilitaCodigo(dbeCodMat, dbeDescricao, False);
end;

procedure TfrmCadMatrizAliquotasFCP.btnCancelaClick(Sender: TObject);
begin
  inherited;
  fExecutarModal(pCarregarMatriz, 'Aguarde, carregando matriz de alíquotas de FCP ...', '');
  pnlMatriz.Enabled := False;
end;

procedure TfrmCadMatrizAliquotasFCP.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadMatrizAliquotasFCP.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  fExecutarModal(pCarregarMatriz, 'Aguarde, carregando matriz de alíquotas de FCP ...', '');
end;

procedure TfrmCadMatrizAliquotasFCP.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;

    If blnGravou Then
    Begin
      fExecutarModal(pGravarMatriz, 'Aguarde, gravando matriz de alíquotas de FCP ...', '');
      fCommit;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadMatrizAliquotasFCP.btnGravarClick]');
    End;
  End;

  fExecutarModal(pCarregarMatriz, 'Aguarde, carregando matriz de alíquotas de FCP ...', '');
  pnlMatriz.Enabled := False;
end;

procedure TfrmCadMatrizAliquotasFCP.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodMat, dbeDescricao, Not blnUsaProCodigo);
  pCarregarMatriz('');
  pnlMatriz.Enabled := True;
end;

procedure TfrmCadMatrizAliquotasFCP.pAfterInsert(DataSet: TDataSet);
begin
  DataSet.Cancel;
end;

procedure TfrmCadMatrizAliquotasFCP.pAfterScroll(DataSet: TDataSet);
begin
  If cdsFCPAlq.RecNo = 1 Then
    cdsFCPAlq.Next;
end;

procedure TfrmCadMatrizAliquotasFCP.pBeforePost(DataSet: TDataSet);
var
  LEstado: String;
begin
  For LEstado In ALIQUOTAS_FCP_UF Do
    If fStrToFloat(DataSet.FieldByName(LEstado).AsString, -1) < 0 Then
    Begin
      pMensagemOk('Alíquota de FCP informada para o estado de ' + LEstado +
        ' não é um valor válido!');
      DataSet.FieldByName(LEstado).FocusControl;
      Abort;
    End;
end;

procedure TfrmCadMatrizAliquotasFCP.pCarregarMatriz(strCodigo: String);
Var
  qryFCPAlq: TUniQuery;
  intDestino: Integer;
  strDestino: String;
Begin
  qryFCPAlq := fCriaQuery();
  Try
    cdsFCPAlq.DisableControls;
    cdsFCPAlq.BeforePost := nil;

    qryFCPAlq.SQL.Text := 'SELECT * FROM FCPALQ WHERE FCP_CODMAT = ' +
      strCodigo.QuotedString;
    qryFCPAlq.Open;
    cdsFCPAlq.First;

    While Not cdsFCPAlq.Eof Do
    Begin
      cdsFCPAlq.Edit;

      For intDestino := 0 To High(ALIQUOTAS_FCP_UF) Do
      Begin
        strDestino := ALIQUOTAS_FCP_UF[intDestino];

        If qryTabela.State In [dsInsert] Then
          cdsFCPAlq.FieldByName(strDestino).AsString := '0'
            //ALIQUOTAS_FCP_DESTINO[intDestino].ToString()

        Else If strCodigo.IsEmpty Or Not qryFCPAlq.Locate('FCP_UF_DES', strDestino, []) Then
          cdsFCPAlq.FieldByName(strDestino).AsString := '0'

        Else
          cdsFCPAlq.FieldByName(strDestino).AsString :=
            qryFCPAlq.FieldByName('FCP_ALQFCP').AsString;

      End;

      cdsFCPAlq.Next;
    End;

  Finally
    cdsFCPAlq.EnableControls;
    cdsFCPAlq.BeforePost := pBeforePost;
    FreeAndNil(qryFCPAlq);
  End;

  cdsFCPAlq.First;
End;

procedure TfrmCadMatrizAliquotasFCP.pCarregarMatriz;
begin
  pCarregarMatriz(qryTabela.FieldByName('FCP_CODMAT').AsString);
end;

procedure TfrmCadMatrizAliquotasFCP.pCriarMatriz;
var
  LEstado: String;

  procedure pCriarColuna(AName: String);
  begin
    With cdsFCPAlq.FieldDefs.AddFieldDef Do
    Begin
      Name := AName;
      DataType := ftString;
      DisplayName := AName;
    End;
  end;

  procedure pAdicionarLinhas();
  Var
    LEstado: String;
  begin
    cdsFCPAlq.Append;
    For LEstado In ALIQUOTAS_FCP_UF Do
      cdsFCPAlq.FieldByName(LEstado).AsString := LEstado;
    cdsFCPAlq.Post;

    cdsFCPAlq.Append;
    For LEstado In ALIQUOTAS_FCP_UF Do
      cdsFCPAlq.FieldByName(LEstado).AsString := '0';
    cdsFCPAlq.Post;
  end;

  procedure pFormatarColuna(AColumn: TColumn);
  begin
    AColumn.Width := 25;
    AColumn.Title.Alignment := TAlignment.taCenter;
    AColumn.Title.Font.Style := [fsBold];
    AColumn.Title.Font.Color := clRed;
    AColumn.Font.Style := [fsBold];
    AColumn.Color := clWhite;
    cdsFCPAlq.FindField(AColumn.FieldName).ReadOnly := False;
    TStringField(cdsFCPAlq.FindField(AColumn.FieldName)).Alignment :=
      TAlignment.taCenter;
  end;

  procedure pFormatarCampos;
  Var
    LEstado: String;
  begin
    For LEstado In ALIQUOTAS_FCP_UF Do
      pFormatarColuna(fFindColumnByName(dbgAlqFCP, LEstado));
  end;

begin
  cdsFCPAlq := TUniClientDataSet.Create(Self);

  For LEstado In ALIQUOTAS_FCP_UF Do
    pCriarColuna(LEstado);

  cdsFCPAlq.CreateDataSet;

  pAdicionarLinhas();

  cdsFCPAlq.AfterScroll := pAfterScroll;
  cdsFCPAlq.AfterInsert := pAfterInsert;
  cdsFCPAlq.BeforePost := pBeforePost;

  dtsFCPAlq.DataSet := cdsFCPAlq;

  dbgAlqFCP.Columns.RebuildColumns;

  pFormatarCampos;

  cdsFCPAlq.First;
end;

procedure TfrmCadMatrizAliquotasFCP.pGravarMatriz;
begin
  pGravarMatriz(qryTabela.FieldByName('FCP_CODMAT').AsString);
end;

procedure TfrmCadMatrizAliquotasFCP.pGravarMatriz(strCodigo: String);
Var
  qryFCPAlq: TUniQuery;
  strDestino: String;
Begin
  qryFCPAlq := fCriaQuery();
  Try
    cdsFCPAlq.DisableControls;
    qryFCPAlq.SQL.Text := 'SELECT * FROM FCPALQ WHERE FCP_CODMAT = ' +
      strCodigo.QuotedString;
    qryFCPAlq.Open;
    cdsFCPAlq.First;

    While Not cdsFCPAlq.Eof Do
    Begin
      For strDestino In ALIQUOTAS_FCP_UF Do
        If qryFCPAlq.Locate('FCP_UF_DES', strDestino, []) Then
        Begin
          qryFCPAlq.Edit;
          qryFCPAlq.FieldByName('FCP_ALQFCP').AsFloat :=
            fStrToFloat(cdsFCPAlq.FieldByName(strDestino).AsString);
          qryFCPAlq.Post;
        End
        Else
        Begin
          qryFCPAlq.Append;
          qryFCPAlq.FieldByName('AUTOINCREM').AsString :=
            fRetAutoIncrem('FCPALQ', VS_strCodEmp);
          qryFCPAlq.FieldByName('FCP_CODMAT').AsString := strCodigo;
          qryFCPAlq.FieldByName('FCP_UF_DES').AsString := strDestino;
          qryFCPAlq.FieldByName('FCP_ALQFCP').AsFloat :=
            fStrToFloat(cdsFCPAlq.FieldByName(strDestino).AsString);
          qryFCPAlq.Post;
        End;

      cdsFCPAlq.Next;
    End;
  Finally
    cdsFCPAlq.EnableControls;
    FreeAndNil(qryFCPAlq);
  End;
end;

procedure TfrmCadMatrizAliquotasFCP.pInicializaIndices;
begin
  inherited;
end;

procedure TfrmCadMatrizAliquotasFCP.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
  arrSel: TConsultasArray;
begin
  inherited;
  chrKey := '?';
  If fPesqMatrizAliquotasFCP(Self, Nil, Nil, qryTabela, chrKey, arrSel) Then
  Begin
    fExecutarModal(pCarregarMatriz, 'Aguarde, carregando matriz de alíquotas de FCP ...', '');
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadMatrizAliquotasFCP.dbgAlqFCPDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  If cdsFCPAlq.RecNo.ToString.Equals('1') Then
  Begin
    dbgAlqFCP.Canvas.Brush.Color := clMoneyGreen;
    dbgAlqFCP.Canvas.Font.Color  := clRed;
  End;
  dbgAlqFCP.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmCadMatrizAliquotasFCP.dbgAlqFCPEnter(Sender: TObject);
begin
  inherited;
  dbgAlqFCP.SelectedIndex := 0;
end;

procedure TfrmCadMatrizAliquotasFCP.dbgAlqFCPKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: Begin
                 If cdsFCPAlq.State = dsEdit Then
                   cdsFCPAlq.Post;

                 If dbgAlqFCP.SelectedIndex = dbgAlqFCP.ColCount -1 Then
                   SelectNext(ActiveControl, True, True)
                 Else
                   dbgAlqFCP.SelectedIndex := dbgAlqFCP.SelectedIndex + 1;
               End;
  End;
end;

procedure TfrmCadMatrizAliquotasFCP.dbgAlqFCPKeyPress(Sender: TObject;
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

procedure TfrmCadMatrizAliquotasFCP.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'MATFCP';
  strNomeCampo := 'FCP_CODMAT';

  qryTabela := fCriarQuery('SELECT * FROM MATFCP WHERE FALSE', Self);

  dtsTabela.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodMat;

  pCriarMatriz();

  pnlMatriz.Enabled := False;
end;

function TfrmCadMatrizAliquotasFCP.fValidaCampos(Sender: TWinControl;
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
