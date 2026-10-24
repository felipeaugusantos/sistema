unit untCadBaseFreteCFOP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxTextEdit, cxCalendar, Vcl.Mask, Vcl.DBCtrls, DBEditFocus, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, EditFocus, Uni, UniClientDataset, Datasnap.Provider,
  UniDataSetProvider, Datasnap.DBClient;

type
  TfrmCadBaseFreteCFOP = class(TfrmPai)
    pnlDados: TPanel;
    pnlTotal: TPanel;
    Label9: TLabel;
    edtTotPar: TEditFocus;
    grdDados: TcxGrid;
    grdDadosDBTableView1: TcxGridDBTableView;
    grdDadosBCF_CODBFR: TcxGridDBColumn;
    grdDadosBCF_CODCFO: TcxGridDBColumn;
    grdDadosLevel1: TcxGridLevel;
    pnlCamAlt: TPanel;
    btnConfirmar: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    lblCFOP: TLabel;
    edtDesBasFre: TEditFocus;
    Label1: TLabel;
    edtDesCfo: TEditFocus;
    edtBasFre: TEditFocus;
    edtCodCfo: TEditFocus;
    btnGravar: TBitBtnLocked;
    dtsBfrCfo: TDataSource;
    grdDadosCFO_DESCR1: TcxGridDBColumn;
    grdDadosBFR_DESBFR: TcxGridDBColumn;
    btnExcluir: TBitBtnLocked;
    procedure edtCodCfoKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtBasFreKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    qryBfrCfo: TUniQuery;
    cdsBfrCfo: TUniClientDataSet;
    function fBuscaCFOP(ACodCFOP: string): string;
    procedure pAbreDados;
    procedure pInsereDados;
    function fCFOPJaAssociado(ACodCfo: String): Boolean;
    procedure pGravaDados;
    function fBuscaBaseFrete(ACodBfr: string): string;
    procedure pGravaRegistro(ABasFre, ACodCfo: String);
    function fTemAlteracoesPendentes: Boolean;
    procedure pLimpaCampos;
    procedure pExcluiRegistro(ACodCfo, ABasFre: String);
    { Private declarations }
  protected
    function  fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadBaseFreteCFOP.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pLimpaCampos;
end;

procedure TfrmCadBaseFreteCFOP.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  If (Not fValidaCampos(edtBasFre)) Or (Not fValidaCampos(edtCodCfo)) Then
    Exit;

  pInsereDados;
  pLimpaCampos;
end;

procedure TfrmCadBaseFreteCFOP.pExcluiRegistro(ACodCfo: String; ABasFre: String);
var
  LStrSQL: string;
  LQryDel: TUniQuery;
begin
  try
    LQryDel := fCriaQuery;

    LStrSQL := '';
    LStrSQL := LStrSQL + 'DELETE FROM BFRCFO ';
    LStrSQL := LStrSQL + 'WHERE BCF_CODBFR = :CODBFR ';
    LStrSQL := LStrSQL + '  AND BCF_CODCFO = :CODCFO ';

    LQryDel.SQL.Clear;
    LQryDel.SQL.Add(LStrSQL);
    LQryDel.ParamByName('CODBFR').AsString := ABasFre;
    LQryDel.ParamByName('CODCFO').AsString := ACodCfo;
    Try
      LQryDel.ExecSQL;
    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[TfrmCadBaseFreteCFOP.pExcluiRegistro]');
    End;
  Finally
    FreeAndNil(LQryDel);
  End;

end;

procedure TfrmCadBaseFreteCFOP.btnExcluirClick(Sender: TObject);
begin
  If (cdsBfrCfo.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO','Não há dados a serem excluídos!',['&OK']);
    Exit;
  End;

  If fMensagem('ATENÇÃO!', 'Deseja realmente excluir o registro selecionado?', ['&Sim', '&Não'],2) = 1 Then
  Begin
    If (fEmptyStr(cdsBfrCfo.FieldByName('STATUS').AsString)) Then
      pExcluiRegistro(cdsBfrCfo.FieldByName('BCF_CODCFO').AsString, cdsBfrCfo.FieldByName('BCF_CODBFR').AsString);
    cdsBfrCfo.Delete;
  End;
end;

procedure TfrmCadBaseFreteCFOP.pLimpaCampos;
begin
  edtBasFre.Clear;
  edtCodCFo.Clear;
  edtDesBasFre.Clear;
  edtDesCfo.Clear;
  pSetFocus(edtBasFre);
end;

procedure TfrmCadBaseFreteCFOP.pAbreDados;
begin
  If (qryBfrCfo = Nil) Then
    qryBfrCfo := fCriaQuery;

  qryBfrCfo.Close;

  qryBfrCfo.SQL.Clear;
  qryBfrCfo.SQL.Add('SELECT BC.BCF_CODCFO, ');
  qryBfrCfo.SQL.Add('       BC.BCF_CODBFR, ');
  qryBfrCfo.SQL.Add('       CF.CFO_DESCR1, ');
  qryBfrCfo.SQL.Add('       BF.BFR_DESBFR, ');
  qryBfrCfo.SQL.Add('       "" AS STATUS   ');
  qryBfrCfo.SQL.Add('FROM BFRCFO BC  ');
  qryBfrCfo.SQL.Add('INNER JOIN CADCFO CF ON BC.BCF_CODCFO = CF.CFO_CODCFO ');
  qryBfrCfo.SQL.Add('INNER JOIN BASFRE BF ON BC.BCF_CODBFR = BF.BFR_CODBFR ');
  qryBfrCfo.SQL.Add('ORDER BY BC.BCF_CODBFR ');
  qryBfrCfo.Open;

  cdsBfrCfo := fCriaClientDatset(qryBfrCfo);
  pSetaClient(cdsBfrCfo);

  cdsBfrCfo.Open;
  dtsBfrCfo.DataSet := cdsBfrCfo;
end;

procedure TfrmCadBaseFreteCFOP.pGravaRegistro(ABasFre, ACodCfo: String);
var
  LStrSQL: string;
  LQryIns: TUniQuery;
begin
  try
    LQryIns := fCriaQuery(Self);

    LStrSQL := '';
    LStrSQL := LStrSQL + 'INSERT INTO BFRCFO (BCF_CODBFR, BCF_CODCFO) ';
    LStrSQL := LStrSQL + ' VALUES (:CODBFR , :CODCFO) ';

    LQryIns.SQL.Clear;
    LQryIns.SQL.Add(LStrSQL);
    LQryIns.ParamByName('CODBFR').AsString := ABasFre;
    LQryIns.ParamByName('CODCFO').AsString := ACodCfo;
    Try
      LQryIns.ExecSQL;
    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[TfrmCadBaseFreteCFOP.pGravaRegistro]');
    End;
  Finally
    FreeAndNil(LQryIns);
  End;
end;

procedure TfrmCadBaseFreteCFOP.pGravaDados;
begin
  cdsBfrCfo.DisableControls;
  cdsBfrCfo.First;
  While Not cdsBfrCfo.EOF Do
  Begin
    If cdsBfrCfo.FieldByName('STATUS').AsString = 'I' Then
    Begin
      pGravaRegistro(cdsBfrCfo.FieldByName('BCF_CODBFR').AsString,
                     cdsBfrCfo.FieldByName('BCF_CODCFO').AsString);
      cdsBfrCfo.Edit;
      cdsBfrCfo.FieldByName('STATUS').Clear;
      cdsBfrCfo.Post;
    End;

    cdsBfrCfo.Next;
  End;
  cdsBfrCfo.EnableControls;
  btnGravar.Enabled := False;
end;

procedure TfrmCadBaseFreteCFOP.pInsereDados;
begin
  cdsBfrCfo.Insert;
  cdsBfrCfo.FieldByName('BCF_CODBFR').AsString := edtBasFre.Text;
  cdsBfrCfo.FieldByName('BCF_CODCFO').AsString := edtCodCfo.Text;
  cdsBfrCfo.FieldByName('CFO_DESCR1').AsString := edtDesCfo.Text;
  cdsBfrCfo.FieldByName('BFR_DESBFR').AsString := edtDesBasFre.Text;
  cdsBfrCfo.FieldByName('STATUS').AsString := 'I';
  cdsBfrCfo.Post;
  btnGravar.Enabled := True;
end;

procedure TfrmCadBaseFreteCFOP.btnGravarClick(Sender: TObject);
begin
  inherited;
  pGravaDados;
  fMensagem('', 'Dados salvos!', ['&OK']);
end;

procedure TfrmCadBaseFreteCFOP.edtBasFreKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrBaseFrete: TConsultasArray;
begin
  inherited;
  If fPesqCodBaseFrete(Self, TEditFocus(Sender), Nil, Nil, Key, arrBaseFrete) Then
  Begin
    fValidaCampos(TEditFocus(Sender));
  End;
end;

procedure TfrmCadBaseFreteCFOP.edtCodCfoKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrSitTrib: TConsultasArray;
begin
  inherited;
  If fPesqCFOP(Self, TEditFocus(Sender), Nil, Nil, Key, arrSitTrib) Then
  Begin
    fValidaCampos(TEditFocus(Sender));
  End;
end;

function TfrmCadBaseFreteCFOP.fCFOPJaAssociado(ACodCfo: String): Boolean;
var
  LStrSQL: string;
  LQryBcf: TUniQuery;
  LRecNo : Integer;
begin
  Result := False;
  Try
    LQryBcf := fCriaQuery;

    LStrSQL := '';
    LStrSQL := LStrSQL + 'SELECT COUNT(1) AS QTD ';
    LStrSQL := LStrSQL + '  FROM BFRCFO ';
    LStrSQL := LStrSQL + ' WHERE BCF_CODCFO = :CODCFO ';

    LQryBcf.Close;
    LQryBcf.SQL.Clear;
    LQryBcf.SQL.Add(LStrSQL);
    LQryBcf.ParamByName('CODCFO').AsString := ACodCfo;
    LQryBcf.Open;

    If (Not LQryBcf.IsEmpty) Then
      Result := LQryBcf.FieldByName('QTD').AsInteger > 0;

    If (Not Result) Then
    Begin
      LRecNo := cdsBfrCfo.RecNo;
      cdsBfrCfo.DisableControls;
      cdsBfrCfo.Filter := 'BCF_CODCFO = ' + QuotedStr(ACodCfo);
      cdsBfrCfo.Filtered := True;
      Result := cdsBfrCfo.RecordCount > 0;
      cdsBfrCfo.Filtered := False;
      cdsBfrCfo.RecNo := LRecNo;
      cdsBfrCfo.EnableControls;
    End;
  Finally
    FreeAndNil(LQryBcf);
  End;

end;

function TfrmCadBaseFreteCFOP.fTemAlteracoesPendentes: Boolean;
var
  LRecNo : Integer;
begin
  LRecNo := 0;
  Try
    LRecNo := cdsBfrCfo.RecNo;
    cdsBfrCfo.DisableControls;
    cdsBfrCfo.Filter := 'STATUS = ''I'' ';
    cdsBfrCfo.Filtered := True;
    Result := cdsBfrCfo.RecordCount > 0;
  Finally
    cdsBfrCfo.Filtered := False;
    cdsBfrCfo.RecNo := LRecNo;
    cdsBfrCfo.EnableControls;
  End;

end;

function TfrmCadBaseFreteCFOP.fBuscaBaseFrete(ACodBfr: string): string;
begin
  Result := fCampoTabela('BFR_DESBFR', 'BASFRE',['BFR_CODBFR'],[ACodBfr]);
end;

function TfrmCadBaseFreteCFOP.fBuscaCFOP(ACodCFOP: string): string;
begin
  Result := fCampoTabela('CFO_DESCR1', 'CADCFO',['CFO_CODCFO'],[ACodCFOP]);
end;

procedure TfrmCadBaseFreteCFOP.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  If (fTemAlteracoesPendentes) Then
  Begin
    If fMensagem('ATENÇÃO!', 'Existem alterações que não foram salvas! Deseja sair e cancelar as alterações?', ['&Sim', '&Não'],2) = 1 Then
    Begin
      cdsBfrCfo.Cancel;
      CanClose := True;
    End
    Else
    Begin
      CanClose := False;
    End;
  End;
end;

procedure TfrmCadBaseFreteCFOP.FormCreate(Sender: TObject);
begin
  inherited;
  btnGravar.Enabled := False;
  pAbreDados;
end;

procedure TfrmCadBaseFreteCFOP.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsBfrCfo);
  FreeAndNil(qryBfrCfo);
end;

procedure TfrmCadBaseFreteCFOP.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10:
    Begin
      If btnGravar.Enabled Then
        btnGravar.Click;
    End;
  End;
end;

function TfrmCadBaseFreteCFOP.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = edtBasFre) Then
    Begin
      If (fEmptyStr(edtBasFre.Text)) or (Length(Trim(edtBasFre.Text)) <> 2) Then
      Begin
        fMensagem('','Preencher corretamente o Código de Base de Frete!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        edtDesBasFre.Text := fBuscaBaseFrete(edtBasFre.Text);

        If Trim(edtDesBasFre.Text) = '' Then
        Begin
          fMensagem('','Código para Base de Frete não encontrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodCfo) Then
    Begin
      If (fEmptyStr(edtCodCfo.Text)) or (Length(Trim(edtCodCfo.Text)) <> 4) Then
      Begin
        fMensagem('','Preencher corretamente o CFOP!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        edtDesCfo.Text := fBuscaCFOP(edtCodCfo.Text);

        If Trim(edtDesCfo.Text) = '' Then
        Begin
          fMensagem('','Código CFOP não encontrado!', ['&Ok']);
          Result := False;
        End
        Else If fCFOPJaAssociado(edtCodCfo.Text) Then
        Begin
          fMensagem('ATENÇÃO','O CFOP ' + edtCodCfo.Text + ' já está ssociado a um Código de Base de Frete!',['&OK']);
          Result := False;
        End;

      End;

      If Result And fCFOPJaAssociado(edtCodCfo.Text) Then
      Begin
        fMensagem('ATENÇÃO','O CFOP ' + edtCodCfo.Text + ' já está ssociado a um Código de Base de Frete!',['&OK']);
        Result := False;
      End;
    End
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.
