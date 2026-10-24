unit untCfgModCartaExtrajudicial;

interface

uses
  Windows, Classes, Controls, Forms, untPaiSimples, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids, EditFocus, UniDataSetProvider, DB,
  UniClientDataSet, Uni, FilenameEditFocus, BitBtnLockedIncrem, Provider, Mask,
  frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Datasnap.DBClient, cxTextEdit, cxMaskEdit, cxButtonEdit;

type
  TfrmCfgModCartaExtrajudicial = class(TfrmPaiSimples)
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

procedure TfrmCfgModCartaExtrajudicial.btnGravarClick(Sender: TObject);
begin
  inherited;
  pControlaModelos;
end;

procedure TfrmCfgModCartaExtrajudicial.btnInserirClick(Sender: TObject);
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

  If (fModeloCadastrado(edtNomMod.Text)) Then
    Begin
      fMensagem('ATENÇÃO!','Já existe um Modelo com este Nome!',['&O k']);
      pSetFocus(edtNomMod);
      Exit;
    End;

  If (Not fEmptyStr(edtNomMod.Text)) And (Not fEmptyStr(edtPatMod.Text)) And (dbgModelo.Enabled) Then
    Begin
      cdsModelo.Append;
      cdsModelo.FieldByName('CODEXJ').AsString := '1';
      cdsModelo.FieldByName('CODEMP').AsString := VS_strCodEmp;
      cdsModelo.FieldByName('NOMEXJ').AsString := edtNomMod.Text;
      cdsModelo.FieldByName('PATEXJ').AsString := AnsiReplaceStr(edtPatMod.Text,'"','');
      cdsModelo.FieldByName('STATUS').AsString := 'I';
      cdsModelo.Post;
    End
  Else If (Not fEmptyStr(edtNomMod.Text)) And (Not fEmptyStr(edtPatMod.Text)) And (Not dbgModelo.Enabled) Then
    Begin
      cdsModelo.Edit;
      cdsModelo.FieldByName('NOMEXJ').AsString := edtNomMod.Text;
      cdsModelo.FieldByName('PATEXJ').AsString := AnsiReplaceStr(edtPatMod.Text,'"','');
      cdsModelo.FieldByName('STATUS').AsString := 'A';
      cdsModelo.Post;

      dbgModelo.Enabled := True;
    End;

  edtNomMod.Clear;
  edtPatMod.Clear;
  pSetFocus(edtNomMod);
end;

procedure TfrmCfgModCartaExtrajudicial.dbgModeloKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_DELETE) And (Not cdsModelo.IsEmpty) Then
  Begin
    If (fMensagem('ATENÇÃO!','Deseja realmente excluir o Modelo ' + cdsModelo.FieldByName('NOMEXJ').AsString, ['&Sim','&Não'], 2) = 1) Then
    Begin
      cdsModelo.Edit;
      cdsModelo.FieldByName('STATUS').AsString := 'E';
      cdsModelo.Post;
    End;
  End
  Else If (Key = VK_RETURN) And (Not cdsModelo.IsEmpty) Then
  Begin
    edtNomMod.Text    := cdsModelo.FieldByName('NOMEXJ').AsString;
    edtPatMod.Text    := cdsModelo.FieldByName('PATEXJ').AsString;
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

procedure TfrmCfgModCartaExtrajudicial.edtPatModExit(Sender: TObject);
begin
  inherited;
  edtPatMod.Text := AnsiReplaceStr(edtPatMod.Text,'"','');
end;

function TfrmCfgModCartaExtrajudicial.fApagaModelo(strCodMod: String): Boolean;
  Var
    strSQL: String;
    qryMod: TUniQuery;
begin
  Result := False;
  qryMod := fCriaQuery(Self);
  Try
    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  CAREXJ    ';
    strSQL := strSQL + 'WHERE       ';
    strSQL := strSQL + '  EXJ_CODEXJ = :CODEXJ AND ';
    strSQL := strSQL + '  EXJ_CODEMP = :CODEMP ';
    qryMod.Close;
    qryMod.SQL.Clear;
    qryMod.SQL.Add(strSQL);
    qryMod.ParamByName('CODEXJ').AsString := strCodMod;
    qryMod.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryMod.ExecSQL;
    Result := True;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  FreeAndNil(qryMod);
end;

function TfrmCfgModCartaExtrajudicial.fAtualizaModelo(strCodMod, strNomMod,
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
    strSQL := strSQL + '  CAREXJ ';
    strSQL := strSQL + 'SET      ';
    strSQL := strSQL + '  EXJ_NOMEXJ = :NOMEXJ, ';
    strSQL := strSQL + '  EXJ_PATEXJ = :PATEXJ  ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  EXJ_CODEXJ = :CODEXJ AND ';
    strSQL := strSQL + '  EXJ_CODEMP = :CODEMP ';

    qryMod.Close;
    qryMod.SQL.Clear;
    qryMod.SQL.Add(strSQL);
    qryMod.ParamByName('NOMEXJ').AsString := strNomMod;
    qryMod.ParamByName('PATEXJ').AsString := strPatMod;
    qryMod.ParamByName('CODEXJ').AsString := strCodMod;
    qryMod.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryMod.ExecSQL;

    Result := True;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  FreeAndNil(qryMod);
end;

function TfrmCfgModCartaExtrajudicial.fInsereModelo(strNomMod,
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
    strSQL := strSQL + '  CAREXJ(             ';
    strSQL := strSQL + '         EXJ_CODEXJ,  ';
    strSQL := strSQL + '         EXJ_NOMEXJ,  ';
    strSQL := strSQL + '         EXJ_PATEXJ,  ';
    strSQL := strSQL + '         EXJ_CODEMP,  ';
    strSQL := strSQL + '         AUTOINCREM   ';
    strSQL := strSQL + '         )            ';
    strSQL := strSQL + '  VALUES(             ';
    strSQL := strSQL + '         :CODEXJ,     ';
    strSQL := strSQL + '         :NOMEXJ,     ';
    strSQL := strSQL + '         :PATEXJ,     ';
    strSQL := strSQL + '         :CODEMP,     ';
    strSQL := strSQL + '         :AUTOIN      ';
    strSQL := strSQL + '         )            ';

    qryMod.Close;
    qryMod.SQL.Clear;
    qryMod.SQL.Add(strSQL);
    qryMod.ParamByName('CODEXJ').AsString := fAtualizaProCod('CAREXJ', 'EXJ_CODEXJ');
    qryMod.ParamByName('NOMEXJ').AsString := strNomMod;
    qryMod.ParamByName('PATEXJ').AsString := strPatMod;
    qryMod.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryMod.ParamByName('AUTOIN').AsString := fRetAutoIncrem('CAREXJ', VS_strCodEmp);
    qryMod.ExecSQL;

    Result := True;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  FreeAndNil(qryMod);
end;

function TfrmCfgModCartaExtrajudicial.fModeloCadastrado(strNomMod: String): Boolean;
  Var
    cdsModTmp: TUniClientDataSet;
begin
  cdsModTmp := TUniClientDataSet.Create(Self);
  cdsModTmp.Data := cdsModelo.Data;
  Result := False;

  cdsModTmp.First;
  While Not cdsModTmp.Eof Do
    Begin
      Result := (cdsModTmp.FieldByName('NOMEXJ').AsString = strNomMod);
      cdsModTmp.Next;
    End;
end;

procedure TfrmCfgModCartaExtrajudicial.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(qryModelo);
  inherited;
end;

procedure TfrmCfgModCartaExtrajudicial.FormShow(Sender: TObject);
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

function TfrmCfgModCartaExtrajudicial.fValidaCampos(Sender: TWinControl;
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

procedure TfrmCfgModCartaExtrajudicial.pCarregaModelos;
Var
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  EXJ_CODEXJ AS CODEXJ, ';
    strSQL := strSQL + '  EXJ_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  EXJ_NOMEXJ AS NOMEXJ, ';
    strSQL := strSQL + '  EXJ_PATEXJ AS PATEXJ, ';
    strSQL := strSQL + '  "C"        AS STATUS  ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CAREXJ ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  EXJ_CODEMP = :CODEMP ';

    qryModelo.Close;
    qryModelo.SQL.Clear;
    qryModelo.SQL.Add(strSQL);
    qryModelo.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryModelo.Open;
    pSetaClient(qryModelo);

    cdsModelo.Close;
    cdsModelo.Open;
    pSetaClient(cdsModelo);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
end;

procedure TfrmCfgModCartaExtrajudicial.pControlaModelos;
begin
  Try
    cdsModelo.DisableControls;
    cdsModelo.Filtered := False;
    cdsModelo.First;

    While Not cdsModelo.Eof Do
    Begin
      If (cdsModelo.FieldByName('STATUS').AsString = 'I') Then
        fInsereModelo(cdsModelo.FieldByName('NOMEXJ').AsString, cdsModelo.FieldByName('PATEXJ').AsString)
      Else If (cdsModelo.FieldByName('STATUS').AsString = 'A') Then
        fAtualizaModelo(cdsModelo.FieldByName('CODEXJ').AsString, cdsModelo.FieldByName('NOMEXJ').AsString, cdsModelo.FieldByName('PATEXJ').AsString)
      Else If (cdsModelo.FieldByName('STATUS').AsString = 'E') Then
        fApagaModelo(cdsModelo.FieldByName('CODEXJ').AsString);

      If (cdsModelo.FieldByName('STATUS').AsString <> 'E') Then
         begin
           cdsModelo.Edit;
           cdsModelo.FieldByName('STATUS').AsString := 'C';
           cdsModelo.Post;
         end;

      cdsModelo.Next;
    End;

    cdsModelo.Filtered := True;
    cdsModelo.EnableControls;

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
