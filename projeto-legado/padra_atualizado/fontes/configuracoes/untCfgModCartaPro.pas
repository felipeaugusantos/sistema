unit untCfgModCartaPro;

interface

uses
  Windows, Classes, Controls, Forms, untPaiSimples, Grids, DBGridCitel, DBGrids, Mask,
  FilenameEditFocus, StdCtrls, EditFocus, AppEvnts, Menus, ComCtrls,
  Buttons, BitBtnLockedIncrem, ExtCtrls, DB, UniClientDataSet, UniDataSetProvider,
  Uni, Provider, frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  Datasnap.DBClient, cxButtonEdit;

type
  TfrmCfgModCartaPro = class(TfrmPaiSimples)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtNomMod: TEditFocus;
    btnInserir: TBitBtnLocked;
    Panel2: TPanel;
    BitBtnLocked1: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    dbgModelo: TDBGridCitel;
    dspModelo: TUniDataSetProvider;
    cdsModelo: TUniClientDataSet;
    dtsModelo: TDataSource;
    edtPatMod: TFilenameEditFocus;
    procedure edtPatModExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnInserirClick(Sender: TObject);
    procedure dbgModeloKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    qryModelo : TUniQuery;
    procedure pCarregaModelos;
    procedure pControlaModelos;
    function  fAtualizaModelo(strCodMod, strNomMod, strPatMod: String): Boolean;
    function  fApagaModelo(strCodMod: String): Boolean;
    function  fInsereModelo(strNomMod, strPatMod: String): Boolean;
    function  fModeloCadastrado(strNomMod: String): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses SysUtils, StrUtils, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCfgModCartaPro.btnGravarClick(Sender: TObject);
begin
  inherited;
  pControlaModelos;
end;

procedure TfrmCfgModCartaPro.btnInserirClick(Sender: TObject);
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
      FieldByName('CODPRO').AsString := '1';
      FieldByName('CODEMP').AsString := VS_strCodEmp;
      FieldByName('NOMPRO').AsString := edtNomMod.Text;
      FieldByName('PATPRO').AsString := edtPatMod.Text;
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
      FieldByName('NOMPRO').AsString := edtNomMod.Text;
      FieldByName('PATPRO').AsString := edtPatMod.Text;
      FieldByName('STATUS').AsString := 'A';
      Post;
    End;
    dbgModelo.Enabled := True;
    edtNomMod.Clear;
    edtPatMod.Clear;
    pSetFocus(edtNomMod);
  End
end;

procedure TfrmCfgModCartaPro.dbgModeloKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  {**********************************}
  {* MARCA O REGISTRO PARA EXCLUSÃO *}
  {*******************************RV*}
  If (Key = VK_DELETE) And (Not cdsModelo.IsEmpty) Then
  Begin
    If (fMensagem('ATENÇÃO!','Deseja realmente excluir o Modelo ' + cdsModelo.FieldByName('NOMPRO').AsString, ['&Sim','&Não'], 2) = 1) Then
    Begin
      cdsModelo.Edit;
      cdsModelo.FieldByName('STATUS').AsString := 'E';
      cdsModelo.Post;
    End;
  End
  Else If (Key = VK_RETURN) And (Not cdsModelo.IsEmpty) Then
  Begin
    edtNomMod.Text    := cdsModelo.FieldByName('NOMPRO').AsString;
    edtPatMod.Text    := cdsModelo.FieldByName('PATPRO').AsString;
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

procedure TfrmCfgModCartaPro.edtPatModExit(Sender: TObject);
begin
  inherited;
  edtPatMod.Text := AnsiReplaceStr(edtPatMod.Text, '"', '');
end;

function TfrmCfgModCartaPro.fApagaModelo(strCodMod: String): Boolean;
  Var
    strSQL: String;
    qryMod: TUniQuery;
begin
  Result := False;
  Try
    qryMod := fCriaQuery(Self);
    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  CARPRO    ';
    strSQL := strSQL + 'WHERE       ';
    strSQL := strSQL + '  PRO_CODPRO = :CODPRO AND ';
    strSQL := strSQL + '  PRO_CODEMP = :CODEMP ';
    With qryMod Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODPRO').AsString := strCodMod;
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

function TfrmCfgModCartaPro.fAtualizaModelo(strCodMod, strNomMod,
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
    strSQL := strSQL + '  CARPRO ';
    strSQL := strSQL + 'SET      ';
    strSQL := strSQL + '  PRO_NOMPRO = :NOMPRO, ';
    strSQL := strSQL + '  PRO_PATPRO = :PATPRO  ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  PRO_CODPRO = :CODPRO AND ';
    strSQL := strSQL + '  PRO_CODEMP = :CODEMP ';
    With qryMod Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NOMPRO').AsString := strNomMod;
      ParamByName('PATPRO').AsString := strPatMod;
      ParamByName('CODPRO').AsString := strCodMod;
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

function TfrmCfgModCartaPro.fInsereModelo(strNomMod,
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
    strSQL := strSQL + '  CARPRO(             ';
    strSQL := strSQL + '         PRO_CODPRO,  ';
    strSQL := strSQL + '         PRO_NOMPRO,  ';
    strSQL := strSQL + '         PRO_PATPRO,  ';
    strSQL := strSQL + '         PRO_CODEMP,  ';
    strSQL := strSQL + '         AUTOINCREM   ';
    strSQL := strSQL + '         )            ';
    strSQL := strSQL + '  VALUES(             ';
    strSQL := strSQL + '         :CODPRO,     ';
    strSQL := strSQL + '         :NOMPRO,     ';
    strSQL := strSQL + '         :PATPRO,     ';
    strSQL := strSQL + '         :CODEMP,     ';
    strSQL := strSQL + '         :AUTOIN      ';
    strSQL := strSQL + '         )            ';
    With qryMod Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODPRO').AsString := fAtualizaProCod('CARPRO', 'PRO_CODPRO');
      ParamByName('NOMPRO').AsString := strNomMod;
      ParamByName('PATPRO').AsString := strPatMod;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('AUTOIN').AsString := fRetAutoIncrem('CARPRO', VS_strCodEmp);
      ExecSQL;
      Result := True;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  FreeAndNil(qryMod);
end;

function TfrmCfgModCartaPro.fModeloCadastrado(strNomMod: String): Boolean;
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
      If (FieldByName('NOMPRO').AsString = strNomMod) Then
        Result := True;
      Next;
    End;
  End;
end;

procedure TfrmCfgModCartaPro.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(qryModelo);
  inherited;
end;

procedure TfrmCfgModCartaPro.FormCreate(Sender: TObject);
begin
  inherited;
  edtPatMod.Dialog.Dialog.InitialDir := ExtractFilePath(Application.ExeName);
end;

procedure TfrmCfgModCartaPro.FormShow(Sender: TObject);
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
end;

function TfrmCfgModCartaPro.fValidaCampos(Sender: TWinControl;
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

procedure TfrmCfgModCartaPro.pCarregaModelos;
Var
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  PRO_CODPRO AS CODPRO, ';
    strSQL := strSQL + '  PRO_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  PRO_NOMPRO AS NOMPRO, ';
    strSQL := strSQL + '  PRO_PATPRO AS PATPRO, ';
    strSQL := strSQL + '  "C"        AS STATUS  ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CARPRO ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  PRO_CODEMP = :CODEMP ';

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

procedure TfrmCfgModCartaPro.pControlaModelos;
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
          fInsereModelo(FieldByName('NOMPRO').AsString, FieldByName('PATPRO').AsString)
        Else If (FieldByName('STATUS').AsString = 'A') Then
          fAtualizaModelo(FieldByName('CODPRO').AsString, FieldByName('NOMPRO').AsString, FieldByName('PATPRO').AsString)
        Else If (FieldByName('STATUS').AsString = 'E') Then
          fApagaModelo(FieldByName('CODPRO').AsString);

        Next;
      End;
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
