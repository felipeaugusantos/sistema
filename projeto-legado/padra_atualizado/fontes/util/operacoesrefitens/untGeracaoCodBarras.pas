unit untGeracaoCodBarras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, ComCtrls, AppEvnts,
  EditFocus, Mask, MaskEditFocus, Grids, DBGridCitel, DBGrids, QColorLabel, Uni,
  DB, UniClientDataSet, UniDataSetProvider,  
  BitBtnLockedIncrem, MemDS, DBAccess, Datasnap.Provider, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient, untIteBar;

type
  TfrmGeracaoCodBarras = class(TfrmPai)
    pgbGeracao: TProgressBar;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesIte: TEditFocus;
    edtRefere: TEditFocus;
    edtCodUni: TEditFocus;
    edtCodMar: TEditFocus;
    edtCodFor: TEditFocus;
    edtDesGru: TEditFocus;
    edtDesMar: TEditFocus;
    edtNomFor: TEditFocus;
    edtIteAti: TEditFocus;
    dbgItens: TDBGridCitel;
    Label5: TLabel;
    ColorLabel1: TColorLabel;
    qryItens: TUniQuery;
    dspItens: TUniDataSetProvider;
    cdsItens: TUniClientDataSet;
    dtsItens: TDataSource;
    Label7: TLabel;
    GroupBox1: TGroupBox;
    Shape1: TShape;
    Label9: TLabel;
    btnConfirmaDados: TBitBtnLocked;
    btnMarcarTudo: TBitBtnLocked;
    btnDesmarcarTudo: TBitBtnLocked;
    btnAdicionar: TBitBtnLocked;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAdicionarClick(Sender: TObject);
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMarcarTudoClick(Sender: TObject);
    procedure btnDesmarcarTudoClick(Sender: TObject);
    procedure dbgItensDblClick(Sender: TObject);
    procedure cdsItensAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    intRecNo : Integer;
    qryConGru: TUniQuery;
    qryConUni: TUniQuery;
    qryConMar: TUniQuery;
    qryConFor: TUniQuery;

    objIteBar: TIteBar;

    stlItens: TStringList;

    procedure pCarregaLinGru;
    procedure pCarregaCadUni;
    procedure pCarregaMarca;
    procedure pCarregaFornecedor;

    procedure pCarregaItens;
    procedure pCancelaItens;

    procedure pSelecionaItem;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmGeracaoCodBarras: TfrmGeracaoCodBarras;

implementation

uses untfuncoesSimples, untPesqAux, StrUtils, untModulo,
     untConsultas, System.UITypes, untTypesSistema;

{$R *.dfm}

procedure TfrmGeracaoCodBarras.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  If (stlItens.Count <= 0) Then
  Begin
    fMensagem('', 'É necessário selecionar pelo menos um produto.', ['&Ok']);;
    Exit;
  End;

  If (fMensagem('', 'Confirma geração de código de barras?', ['&Sim', '&Não']) = 2) Then
    Exit;

  btnConfirmaDados.Enabled := False;
  btnMarcarTudo.Enabled := False;
  btnDesmarcarTudo.Enabled := False;
  btnSair.Enabled := False;
  Screen.Cursor := crHourGlass;

  qryTabela := fCriaQuery(Self);
  qryTabela.SQL.Add('SELECT        ');
  qryTabela.SQL.Add('  ITE_CODITE, ');
  qryTabela.SQL.Add('  ITE_CODGRU, ');
  qryTabela.SQL.Add('  ITE_CODBAR, ');
  qryTabela.SQL.Add('  ITE_BAREMB  ');
  qryTabela.SQL.Add('FROM          ');
  qryTabela.SQL.Add('  CADITE      ');
  qryTabela.SQL.Add('WHERE ');
  qryTabela.SQL.Add('  ITE_CODITE IN (' + stlItens.CommaText + ') AND ');
  qryTabela.SQL.Add('  TRIM(IFNULL(ITE_CODBAR, "")) = "" ');

  qryTabela.Open;
  pgbGeracao.Max := qryTabela.RecordCount;
  pgbGeracao.Position := 0;

  While (Not qryTabela.Eof) Do
  Begin

    If (Not fEmptyStr(qryTabela.FieldByName('ITE_CODBAR').AsString)) Then
    Begin
      qryTabela.Next;
      pgbGeracao.StepBy(1);
      Application.ProcessMessages;
      Continue;
    End;

    Try
      fStartTransaction;

      qryTabela.Edit;

      If fCfgSis('TIPBAR') = '2' Then
        qryTabela.FieldByName('ITE_CODBAR').AsString := fGeraCodBarraEAN39(qryTabela.FieldByName('ITE_CODITE').AsString)
      Else
        qryTabela.FieldByName('ITE_CODBAR').AsString := fGeraCodBarraEAN13('1' + fStrZero(qryTabela.FieldByName('ITE_CODITE').AsString, 11));

      qryTabela.Post;

      objIteBar.pCarregaDados(qryTabela.FieldByName('ITE_CODITE').AsString);

      objIteBar.pIncluiCodigo(qryTabela.FieldByName('ITE_CODBAR').AsString, 1,
                              True,
                              fEmptyStr(qryTabela.FieldByName('ITE_BAREMB').AsString),
                              True, 0, '', '', '',
                              0, 0, 0, 0, 0, 0, 0, 0,
                              False);

      objIteBar.pSalvaDados(qryTabela.FieldByName('ITE_CODITE').AsString);

      fAtualizaBarFabIte(qryTabela.FieldByName('ITE_CODITE').AsString);

      fCommit;

    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmGeracaoCodBarras.btnConfirmaDados]');
      End;
    End;

    qryTabela.Next;

    pgbGeracao.StepBy(1);
    Application.ProcessMessages;
  End;

  btnConfirmaDados.Enabled := True;
  btnMarcarTudo.Enabled := True;
  btnDesmarcarTudo.Enabled := True;
  btnSair.Enabled := True;
  pgbGeracao.Position := 0;
  Screen.Cursor := crDefault;

  fMensagem('', 'Geração concluída!', ['&Ok']);
  pCancelaItens;
end;

procedure TfrmGeracaoCodBarras.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;

begin
  inherited;

  If fPesqGrupo(Self, mskLinGru, edtDesGru, qryConGru, Key, arrSel) Then
  Begin
    If (fValidaCampos(mskLinGru, True)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmGeracaoCodBarras.edtCodUniKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqUnidade(Self, edtCodUni, nil, nil, qryConUni, Key, arrSel) Then    
  Begin
    If (fValidaCampos(edtCodUni, True)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmGeracaoCodBarras.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrMarca : TConsultasArray;
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGeracaoCodBarras.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin

  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, qryConFor, Key, arrSel) Then
  Begin
    If (fValidaCampos(edtCodFor, True)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmGeracaoCodBarras.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = mskLinGru) Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(mskLinGru.Text)) Then
    Begin
      edtDesGru.Text := 'TODOS';
    End
    Else
    Begin
      pCarregaLinGru;
      If qryConGru.FieldByName('GRU_CODGRU').IsNull Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa Linha / Grupo não está cadastrada!', ['&O k']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtCodUni) Then
  Begin
    If (Not fEmptyStr(edtCodUni.Text)) Then
    Begin
      pCarregaCadUni;
      If qryConUni.FieldByName('UNI_CODUNI').IsNull Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa Unidade não está cadastrada!', ['&O k']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtCodMar) Then
  Begin
    If fEmptyStr(edtCodMar.Text) Then
    Begin
      edtDesMar.Text := 'TODOS';
    End
    Else
    Begin
      pCarregaMarca;
      If qryConMar.FieldByName('MAR_CODMAR').IsNull Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa Marca não está cadastrada!', ['&O k']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtCodFor) Then
  Begin
    If fEmptyStr(edtCodFor.Text) Then
    Begin
      edtNomFor.Text := 'TODOS';
    End
    Else
    Begin
      pCarregaFornecedor;
      If qryConFor.FieldByName('FOR_CODFOR').IsNull Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Fornecedor não está cadastrado!', ['&O k']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtIteAti) Then
  Begin
    Result := (Pos(edtIteAti.Text, 'SNT') > 0);
  End;

end;

procedure TfrmGeracaoCodBarras.FormCreate(Sender: TObject);
begin
  inherited;
  qryItens.Connection := frmModulo.GetCurrentConnection;

  stlItens := TStringList.Create;
  stlItens.Duplicates := dupIgnore;

  qryConGru := fCriaQuery(Self);
  qryConUni := fCriaQuery(Self);
  qryConMar := fCriaQuery(Self);
  qryConFor := fCriaQuery(Self);

  objIteBar := TIteBar.Create(opcOperacoes);
end;

procedure TfrmGeracaoCodBarras.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(stlItens);
end;

procedure TfrmGeracaoCodBarras.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryConGru);
  FreeAndNil(qryConUni);
  FreeAndNil(qryConMar);
  FreeAndNil(qryConFor);
end;

procedure TfrmGeracaoCodBarras.pCarregaCadUni;
begin
  pPesquisaCadUni(Nil, qryConUni, edtCodUni.Text);
end;

procedure TfrmGeracaoCodBarras.pCarregaFornecedor;
begin
  pPesquisaCadFor(Nil, qryConFor, edtCodFor.Text);
  edtNomFor.Text := qryConFor.FieldByName('FOR_NOMFOR').AsString;
end;

procedure TfrmGeracaoCodBarras.pCarregaLinGru;
begin
  pPesquisaLinGru(Nil, qryConGru, mskLinGru.Text);
  edtDesGru.Text := qryConGru.FieldByName('GRU_DESGRU').AsString;
end;

procedure TfrmGeracaoCodBarras.pCarregaMarca;
begin
  pPesquisaCadMar(Nil, qryConMar, edtCodMar.Text);
  edtDesMar.Text := qryConMar.FieldByName('MAR_DESMAR').AsString;
end;

procedure TfrmGeracaoCodBarras.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  pCancelaItens;
  pCarregaItens;
  pSetFocus(dbgItens);
end;

procedure TfrmGeracaoCodBarras.pCarregaItens;
begin

  stlItens.Clear;

  qryItens.SQL.Clear;
  qryItens.SQL.Add('SELECT ');
  qryItens.SQL.Add('  ITE_CODITE, ');
  qryItens.SQL.Add('  ITE_DESITE, ');
  qryItens.SQL.Add('  ITE_REFERE, ');
  qryItens.SQL.Add('  UNI_SIGUNI, ');
  qryItens.SQL.Add('  "M" ITE_MARDES ');
  qryItens.SQL.Add('FROM ');
  qryItens.SQL.Add('  CADITE ');
  qryItens.SQL.Add('JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ');
  qryItens.SQL.Add('WHERE ');
  qryItens.SQL.Add('  TRIM(IFNULL(ITE_CODBAR, "")) = "" ');

  If Not fEmptyStr(mskLinGru.Text) Then
  Begin
    If RightStr(mskLinGru.Text, 03) = '000' Then
      qryItens.SQL.Add('  AND LEFT(ITE_CODGRU, 3) = LEFT(:CODGRU, 3) ')
    Else
      qryItens.SQL.Add('  AND ITE_CODGRU = :CODGRU ');

    qryItens.ParamByName('CODGRU').AsString := mskLinGru.Text;
  End;

  If Not fEmptyStr(edtDesIte.Text) Then
  Begin
    qryItens.SQL.Add('  AND ITE_DESITE LIKE :DESITE ');

    qryItens.ParamByName('DESITE').AsString := edtDesIte.Text + '%';
  End;

  If Not fEmptyStr(edtRefere.Text) Then
  Begin
    qryItens.SQL.Add('  AND ITE_REFERE LIKE :REFERE ');

    qryItens.ParamByName('REFERE').AsString := edtRefere.Text + '%';
  End;

  If Not fEmptyStr(edtCodUni.Text) Then
  Begin
    qryItens.SQL.Add('  AND ITE_CODUNI = :CODUNI ');

    qryItens.ParamByName('CODUNI').AsString := edtCodUni.Text;
  End;

  If Not fEmptyStr(edtCodMar.Text) Then
  Begin
    qryItens.SQL.Add('  AND ITE_CODMAR = :CODMAR ');

    qryItens.ParamByName('CODMAR').AsString := edtCodMar.Text;
  End;

  If Not fEmptyStr(edtCodFor.Text) Then
  Begin
    qryItens.SQL.Add('  AND ITE_CODFOR = :CODFOR ');

    qryItens.ParamByName('CODFOR').AsString := edtCodFor.Text;
  End;

  If edtIteAti.Text <> 'T' Then
  Begin
    qryItens.SQL.Add('  AND ITE_ITEATI = :ITEATI ');

    qryItens.ParamByName('ITEATI').AsString := edtIteAti.Text;
  End;

  qryItens.Open;
  pSetaClient(qryItens);

  cdsItens.Close;
  cdsItens.Open;

  cdsItens.DisableControls;

  cdsItens.First;
  While (Not cdsItens.Eof) Do
  Begin
    stlItens.Add(cdsItens.FieldByName('ITE_CODITE').AsString);
    cdsItens.Next;
  End;

  cdsItens.EnableControls;
  cdsItens.FieldByName('ITE_DESITE').DisplayWidth := 414;

end;

procedure TfrmGeracaoCodBarras.dbgItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  If (Not cdsItens.Active) Or (cdsItens.IsEmpty) Then
  Begin
    Exit;
  End;

  If (cdsItens.FieldByName('ITE_MARDES').AsString = 'M') Then
  Begin
    If dbgItens.Canvas.Brush.Color = clHighLight Then
    Begin
      //dbgItens.Canvas.Font.Color := clHighLightText;
      dbgItens.Canvas.Font.Color := clLime;
    End Else
    Begin
      dbgItens.Canvas.Brush.Color := clAqua;
    End;
  End;

  dbgItens.Canvas.FillRect(Rect);
  dbgItens.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmGeracaoCodBarras.pSelecionaItem;
  Var
    intIndex: Integer;
begin

  If (Not cdsItens.Active) Or (cdsItens.IsEmpty) Then
    Exit;

  If (cdsItens.FieldByName('ITE_MARDES').AsString = 'M') Then
  Begin
    cdsItens.Edit;
    cdsItens.FieldByName('ITE_MARDES').AsString := 'D';
    cdsItens.Post;

    intIndex := stlItens.IndexOf(cdsItens.FieldByName('ITE_CODITE').AsString);
    If intIndex >= 0 Then
      stlItens.Delete(intIndex);
  End
  Else
  Begin
    cdsItens.Edit;
    cdsItens.FieldByName('ITE_MARDES').AsString := 'M';
    cdsItens.Post;

    stlItens.Add(cdsItens.FieldByName('ITE_CODITE').AsString);
  End;

end;

procedure TfrmGeracaoCodBarras.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
  Begin
    pSelecionaItem;
  End
  Else If Key = VK_ESCAPE Then
  Begin
    pCancelaItens;
  End
  Else If Key = VK_F10 Then
  Begin
    btnConfirmaDados.Click;
  End
  Else If Key = VK_F9 Then
  Begin
    btnMarcarTudo.Click;
  End
  Else If Key = VK_F8 Then
  Begin
    btnDesmarcarTudo.Click;
  End;
end;

procedure TfrmGeracaoCodBarras.pCancelaItens;
begin
  cdsItens.Close;
  stlItens.Clear;
  pSetFocus(mskLinGru);
end;

procedure TfrmGeracaoCodBarras.btnMarcarTudoClick(Sender: TObject);
begin
  inherited;
  Screen.Cursor := crHourGlass;
  cdsItens.DisableControls;
  cdsItens.First;

  While (Not cdsItens.Eof) Do
  Begin
    cdsItens.Edit;
    cdsItens.FieldByName('ITE_MARDES').AsString := 'M';
    cdsItens.Post;

    stlItens.Add(cdsItens.FieldByName('ITE_CODITE').AsString);

    cdsItens.Next;
  End;

  cdsItens.First;
  cdsItens.EnableControls;
  Screen.Cursor := crDefault;
end;

procedure TfrmGeracaoCodBarras.btnDesmarcarTudoClick(Sender: TObject);
  Var
    intIndex: Integer;
begin
  inherited;
  Screen.Cursor := crHourGlass;
  cdsItens.DisableControls;
  cdsItens.First;

  While (Not cdsItens.Eof) Do
  Begin
    cdsItens.Edit;
    cdsItens.FieldByName('ITE_MARDES').AsString := 'D';
    cdsItens.Post;


    intIndex := stlItens.IndexOf(cdsItens.FieldByName('ITE_CODITE').AsString);
    If (intIndex >= 0) Then
      stlItens.Delete(intIndex);

    cdsItens.Next;
  End;

  cdsItens.First;
  cdsItens.EnableControls;
  Screen.Cursor := crDefault;
end;

procedure TfrmGeracaoCodBarras.dbgItensDblClick(Sender: TObject);
begin
  inherited;
  pSelecionaItem;
end;

procedure TfrmGeracaoCodBarras.cdsItensAfterScroll(DataSet: TDataSet);
begin
  inherited;
  intRecNo := DataSet.RecNo;
end;

procedure TfrmGeracaoCodBarras.FormShow(Sender: TObject);
begin
  //inherited;

end;

end.


