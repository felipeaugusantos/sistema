unit untCfgModCartaCob;

interface

uses
  Windows, Classes, Controls, Forms, untPaiSimples, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids, EditFocus, UniDataSetProvider, DB,
  UniClientDataSet, Uni, FilenameEditFocus, BitBtnLockedIncrem, Provider, Mask,
  frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Datasnap.DBClient, cxTextEdit, cxMaskEdit, cxButtonEdit;

type
  TfrmCfgModCartaCob = class(TfrmPaiSimples)
    Panel1: TPanel;
    Label1: TLabel;
    edtNomMod: TEditFocus;
    Label2: TLabel;
    dbgModelo: TDBGridCitel;
    dtsModelo: TDataSource;
    cdsModelo: TUniClientDataSet;
    dspModelo: TUniDataSetProvider;
    btnGravar: TBitBtnLocked;
    btnInserir: TBitBtnLocked;
    edtPatMod: TFilenameEditFocus;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnInserirClick(Sender: TObject);
    procedure dbgModeloKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure edtPatModExit(Sender: TObject);
  private
    { Private declarations }
    qryModelo: TUniQuery;
    procedure pCarregaModelos;
    procedure pControlaModelos;
    function  fInsereModelo(strNomMod, strPatMod: String): Boolean;
    function  fAtualizaModelo(strCodMod, strNomMod, strPatMod: String): Boolean;
    function  fApagaModelo(strCodMod: String): Boolean;
    function  fModeloCadastrado(strNomMod: String): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses  SysUtils, strUtils, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCfgModCartaCob.btnGravarClick(Sender: TObject);
begin
  inherited;
  pControlaModelos;
end;

procedure TfrmCfgModCartaCob.btnInserirClick(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtNomMod.Text)) Then
  Begin
    fMensagem('ATENÇÃO!','O Nome do Modelo não pode ficar em branco!',['&O k']);
    pSetFocus(edtNomMod);
    Exit;
  End;
  If (fEmptyStr(edtPatMod.Text)) Then
  Begin
    fMensagem('ATENÇÃO!','O Caminho do Modelo não pode ficar em branco!',['&O k']);
    pSetFocus(edtPatMod);
    Exit;
  End;
  {*****************************************}
  {* VERIFICA SE MODELO JÁ ESTÁ CADASTRADO *}
  {***************************************RV*}
  If (fModeloCadastrado(edtNomMod.Text)) Then
  Begin
    fMensagem('ATENÇÃO!','Já existe um Modelo com este Nome!',['&O k']);
    pSetFocus(edtNomMod);
    Exit;
  End;

  If (Not fEmptyStr(edtNomMod.Text)) And (Not fEmptyStr(edtPatMod.Text)) And (dbgModelo.Enabled) Then
  Begin
    With cdsModelo Do
    Begin
      Append;
      FieldByName('CODCOB').AsString := '1';
      FieldByName('CODEMP').AsString := VS_strCodEmp;
      FieldByName('NOMCOB').AsString := edtNomMod.Text;
      FieldByName('PATCOB').AsString := AnsiReplaceStr(edtPatMod.Text,'"','');
      FieldByName('STATUS').AsString := 'I';
      Post;
    End;
    edtNomMod.Clear;
    edtPatMod.Clear;
    pSetFocus(edtNomMod);
  End
  Else If (Not fEmptyStr(edtNomMod.Text)) And (Not fEmptyStr(edtPatMod.Text)) And (Not dbgModelo.Enabled) Then
  Begin
    With cdsModelo Do
    Begin
      Edit;
      FieldByName('NOMCOB').AsString := edtNomMod.Text;
      FieldByName('PATCOB').AsString := AnsiReplaceStr(edtPatMod.Text,'"','');
      FieldByName('STATUS').AsString := 'A';
      Post;
    End;
    dbgModelo.Enabled := True;
    edtNomMod.Clear;
    edtPatMod.Clear;
    pSetFocus(edtNomMod);
  End
end;

procedure TfrmCfgModCartaCob.dbgModeloKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  {**********************************}
  {* MARCA O REGISTRO PARA EXCLUSÃO *}
  {*******************************RV*}
  If (Key = VK_DELETE) And (Not cdsModelo.IsEmpty) Then
  Begin
    If (fMensagem('ATENÇÃO!','Deseja realmente excluir o Modelo ' + cdsModelo.FieldByName('NOMCOB').AsString, ['&Sim','&Não'], 2) = 1) Then
    Begin
      cdsModelo.Edit;
      cdsModelo.FieldByName('STATUS').AsString := 'E';
      cdsModelo.Post;
    End;
  End
  Else If (Key = VK_RETURN) And (Not cdsModelo.IsEmpty) Then
  Begin
    edtNomMod.Text    := cdsModelo.FieldByName('NOMCOB').AsString;
    edtPatMod.Text    := cdsModelo.FieldByName('PATCOB').AsString;
    dbgModelo.Enabled := False;
    dbgModelo.Repaint;
    pSetFocus(edtNomMod);
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    edtNomMod.Clear;
    edtPatMod.Clear;
    pSetFocus(edtNomMod);
  End;
end;

procedure TfrmCfgModCartaCob.edtPatModExit(Sender: TObject);
begin
  inherited;
  edtPatMod.Text := AnsiReplaceStr(edtPatMod.Text,'"','');
end;

function TfrmCfgModCartaCob.fApagaModelo(strCodMod: String): Boolean;
  Var
    strSQL: String;
    qryMod: TUniQuery;
begin
  Result := False;
  Try
    qryMod := fCriaQuery(Self);
    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  CARCOB    ';
    strSQL := strSQL + 'WHERE       ';
    strSQL := strSQL + '  COB_CODCOB = :CODCOB AND ';
    strSQL := strSQL + '  COB_CODEMP = :CODEMP ';
    With qryMod Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCOB').AsString := strCodMod;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ExecSQL;
      Result := True;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  FreeAndNil(qryMod);
end;

function TfrmCfgModCartaCob.fAtualizaModelo(strCodMod, strNomMod,
  strPatMod: String): Boolean;
  Var
    strSQL: String;
    qryMod: TUniQuery;
begin
  Result := False;
  Try
    qryMod := fCriaQuery(Self);
    strSQL := '';
    strSQL := strSQL + 'UPDATE   ';
    strSQL := strSQL + '  CARCOB ';
    strSQL := strSQL + 'SET      ';
    strSQL := strSQL + '  COB_NOMCOB = :NOMCOB, ';
    strSQL := strSQL + '  COB_PATCOB = :PATCOB  ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  COB_CODCOB = :CODCOB AND ';
    strSQL := strSQL + '  COB_CODEMP = :CODEMP ';
    With qryMod Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NOMCOB').AsString := strNomMod;
      ParamByName('PATCOB').AsString := strPatMod;
      ParamByName('CODCOB').AsString := strCodMod;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ExecSQL;
      Result := True;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  FreeAndNil(qryMod);
end;

function TfrmCfgModCartaCob.fInsereModelo(strNomMod,
  strPatMod: String): Boolean;
  Var
    strSQL: String;
    qryMod: TUniQuery;
begin
  Result := False;
  Try
    qryMod := fCriaQuery(Self);
    strSQL := '';
    strSQL := strSQL + 'INSERT INTO ';
    strSQL := strSQL + '  CARCOB(             ';
    strSQL := strSQL + '         COB_CODCOB,  ';
    strSQL := strSQL + '         COB_NOMCOB,  ';
    strSQL := strSQL + '         COB_PATCOB,  ';
    strSQL := strSQL + '         COB_CODEMP,  ';
    strSQL := strSQL + '         AUTOINCREM   ';
    strSQL := strSQL + '         )            ';
    strSQL := strSQL + '  VALUES(             ';
    strSQL := strSQL + '         :CODCOB,     ';
    strSQL := strSQL + '         :NOMCOB,     ';
    strSQL := strSQL + '         :PATCOB,     ';
    strSQL := strSQL + '         :CODEMP,     ';
    strSQL := strSQL + '         :AUTOIN      ';
    strSQL := strSQL + '         )            ';
    With qryMod Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCOB').AsString := fAtualizaProCod('CARCOB', 'COB_CODCOB');
      ParamByName('NOMCOB').AsString := strNomMod;
      ParamByName('PATCOB').AsString := strPatMod;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('AUTOIN').AsString := fRetAutoIncrem('CARCOB', VS_strCodEmp);
      ExecSQL;
      Result := True;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  FreeAndNil(qryMod);
end;

function TfrmCfgModCartaCob.fModeloCadastrado(strNomMod: String): Boolean;
  Var
    cdsModTmp: TUniClientDataSet;
begin
  cdsModTmp := TUniClientDataSet.Create(Self);
  cdsModTmp.Data := cdsModelo.Data;
  Result := False;
  With cdsModTmp Do
  Begin
    First;
    While Not Eof Do
    Begin
      If (FieldByName('NOMCOB').AsString = strNomMod) Then
        Result := True;
      Next;
    End;
  End;
end;

procedure TfrmCfgModCartaCob.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(qryModelo);
  inherited;
end;

procedure TfrmCfgModCartaCob.FormShow(Sender: TObject);
begin
  inherited;
  Try
    Screen.Cursor := crHourGlass;

    qryModelo := fCriaQuery(Self);
    dspModelo.DataSet := qryModelo;
    cdsModelo.SetProvider(dspModelo);
    dtsModelo.DataSet := cdsModelo;

    pCarregaModelos;

    cdsModelo.Filter   := 'STATUS <> ' + QuotedStr('E');
    cdsModelo.Filtered := True;
    pSetFocus(edtNomMod);
  Finally
    Screen.Cursor := crDefault;
  End;
  pSetFocus(edtNomMod);
end;

function TfrmCfgModCartaCob.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (Sender = edtNomMod) Then
  Begin
    If (fEmptyStr(edtNomMod.Text)) And (dbgModelo.CanFocus) Then
    Begin
      pSetFocus(dbgModelo);
      blnMudarFoco := False;
    End;
  End;
  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCfgModCartaCob.pCarregaModelos;
Var
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  COB_CODCOB AS CODCOB, ';
    strSQL := strSQL + '  COB_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  COB_NOMCOB AS NOMCOB, ';
    strSQL := strSQL + '  COB_PATCOB AS PATCOB, ';
    strSQL := strSQL + '  "C"        AS STATUS  ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CARCOB ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  COB_CODEMP = :CODEMP ';

    With qryModelo Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      pSetaClient(qryModelo);
    End;

    cdsModelo.Close;
    cdsModelo.Open;
    pSetaClient(cdsModelo);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
end;

procedure TfrmCfgModCartaCob.pControlaModelos;
begin
  Try
    With cdsModelo Do
    Begin
      DisableControls;
      Filtered := False;
      First;

      While Not Eof Do
      Begin
        If (FieldByName('STATUS').AsString = 'I') Then
          fInsereModelo(FieldByName('NOMCOB').AsString, FieldByName('PATCOB').AsString)
        Else If (FieldByName('STATUS').AsString = 'A') Then
          fAtualizaModelo(FieldByName('CODCOB').AsString, FieldByName('NOMCOB').AsString, FieldByName('PATCOB').AsString)
        Else If (FieldByName('STATUS').AsString = 'E') Then
          fApagaModelo(FieldByName('CODCOB').AsString);

        Next;
      End;
      Filtered := True;
      EnableControls;
    End;
    fMensagem('','Dados gravados com sucesso!',['&O k']);
  Except
    On E: Exception Do
    Begin
       cdsModelo.EnableControls;
       pMensagensErro(E.Message, '');
    End;
  End;
end;

end.
