unit untCfgModContrato;

interface

uses
  Windows,Classes, Controls, Forms, Grids, DBGridCitel, DBGrids, FilenameEditFocus,
  StdCtrls, EditFocus, AppEvnts, Menus, ComCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, UniDataSetProvider, DB, UniClientDataSet, Uni, Provider, Mask,
  untPaiSimples, frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Datasnap.DBClient, cxTextEdit,
  cxMaskEdit, cxButtonEdit;

type
  TfrmCfgModContrato = class(TfrmPaiSimples)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtNomMod: TEditFocus;
    dbgModelo: TDBGridCitel;
    Panel2: TPanel;
    dtsModelo: TDataSource;
    cdsModelo: TUniClientDataSet;
    dspModelo: TUniDataSetProvider;
    btnInserir: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    BitBtnLocked1: TBitBtnLocked;
    edtPatMod: TFilenameEditFocus;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnInserirClick(Sender: TObject);
    procedure dbgModeloKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure edtPatModExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    qryModelo: TUniQuery;
    intRecEdicao: Integer;
    procedure pCarregaModelos;
    procedure pControlaModelos;
    function  fInsereModelo(strNomMod, strPatMod: String; Var AStrCodGerado: String): Boolean;
    function  fAtualizaModelo(strCodMod, strNomMod, strPatMod: String): Boolean;
    function  fApagaModelo(strCodMod: String): Boolean;
    function  fModeloCadastrado(strNomMod: String): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses SysUtils, strUtils, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCfgModContrato.btnGravarClick(Sender: TObject);
begin
  inherited;
  pControlaModelos;
end;

procedure TfrmCfgModContrato.btnInserirClick(Sender: TObject);
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
    cdsModelo.FieldByName('CODEMP').AsString := VS_strCodEmp;
    cdsModelo.FieldByName('NOMSER').AsString := edtNomMod.Text;
    cdsModelo.FieldByName('PATSER').AsString := AnsiReplaceStr(edtPatMod.Text,'"','');
    cdsModelo.FieldByName('STATUS').AsString := 'I';
    cdsModelo.Post;

    edtNomMod.Clear;
    edtPatMod.Clear;
    pSetFocus(edtNomMod);

  End
  Else If (Not fEmptyStr(edtNomMod.Text)) And (Not fEmptyStr(edtPatMod.Text)) And (Not dbgModelo.Enabled) Then
  Begin
    cdsModelo.Edit;
    cdsModelo.FieldByName('NOMSER').AsString := edtNomMod.Text;
    cdsModelo.FieldByName('PATSER').AsString := AnsiReplaceStr(edtPatMod.Text,'"','');

    If cdsModelo.FieldByName('STATUS').AsString <> 'I' Then
      cdsModelo.FieldByName('STATUS').AsString := 'A';

    cdsModelo.Post;

    dbgModelo.Enabled := True;
    intRecEdicao := 0;

    edtNomMod.Clear;
    edtPatMod.Clear;
    pSetFocus(edtNomMod);
  End;
end;

procedure TfrmCfgModContrato.dbgModeloKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) And (Not cdsModelo.IsEmpty) Then
  Begin
    If (fMensagem('ATENÇÃO!','Deseja realmente excluir o Modelo ' + cdsModelo.FieldByName('NOMSER').AsString, ['&Sim','&Não'], 2) = 1) Then
    Begin
      cdsModelo.Edit;
      cdsModelo.FieldByName('STATUS').AsString := 'E';
      cdsModelo.Post;
    End;
  End
  Else If (Key = VK_RETURN) And (Not cdsModelo.IsEmpty) Then
  Begin
    edtNomMod.Text    := cdsModelo.FieldByName('NOMSER').AsString;
    edtPatMod.Text    := cdsModelo.FieldByName('PATSER').AsString;
    intRecEdicao      := cdsModelo.RecNo;
    dbgModelo.Enabled := False;
    dbgModelo.Repaint;
    pSetFocus(edtNomMod);
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    edtNomMod.Clear;
    edtPatMod.Clear;
    intRecEdicao      := 0;
    dbgModelo.Enabled := True;
    dbgModelo.Repaint;
    pSetFocus(edtNomMod);
  End;
end;

procedure TfrmCfgModContrato.edtPatModExit(Sender: TObject);
begin
  inherited;
  edtPatMod.Text := AnsiReplaceStr(edtPatMod.Text, '"', '');
end;

function TfrmCfgModContrato.fApagaModelo(strCodMod: String): Boolean;
Var
  strSQL: String;
  qryMod: TUniQuery;
begin
  Result := False;
  qryMod := Nil;
  Try
    Try
      qryMod := fCriaQuery(Self);
      strSQL := '';
      strSQL := strSQL + 'DELETE FROM ';
      strSQL := strSQL + '  CTRSER    ';
      strSQL := strSQL + 'WHERE       ';
      strSQL := strSQL + '  SER_CODSER = :CODSER AND ';
      strSQL := strSQL + '  SER_CODEMP = :CODEMP ';

      qryMod.Close;
      qryMod.SQL.Clear;
      qryMod.SQL.Add(strSQL);
      qryMod.ParamByName('CODSER').AsString := strCodMod;
      qryMod.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryMod.ExecSQL;

      Result := True;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
        Raise;
      End;
    End;
  Finally
    FreeAndNil(qryMod);
  End;
end;


function TfrmCfgModContrato.fAtualizaModelo(strCodMod, strNomMod,
  strPatMod: String): Boolean;
  Var
    strSQL: String;
    qryMod: TUniQuery;
begin
  Result := False;
  qryMod := Nil;
  try
    Try
      qryMod := fCriaQuery(Self);
      strSQL := '';
      strSQL := strSQL + 'UPDATE   ';
      strSQL := strSQL + '  CTRSER ';
      strSQL := strSQL + 'SET      ';
      strSQL := strSQL + '  SER_NOMSER = :NOMSER, ';
      strSQL := strSQL + '  SER_PATSER = :PATSER  ';
      strSQL := strSQL + 'WHERE    ';
      strSQL := strSQL + '  SER_CODSER = :CODSER AND ';
      strSQL := strSQL + '  SER_CODEMP = :CODEMP ';

      qryMod.Close;
      qryMod.SQL.Clear;
      qryMod.SQL.Add(strSQL);
      qryMod.ParamByName('NOMSER').AsString := strNomMod;
      qryMod.ParamByName('PATSER').AsString := strPatMod;
      qryMod.ParamByName('CODSER').AsString := strCodMod;
      qryMod.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryMod.ExecSQL;

      Result := True;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
        Raise;
      End;
    End;
  Finally
    FreeAndNil(qryMod);
  End;
end;

function TfrmCfgModContrato.fInsereModelo(strNomMod, strPatMod: String;
  Var AStrCodGerado: String): Boolean;
  Var
    strSQL: String;
    qryMod: TUniQuery;
begin
  Result := False;
  qryMod := fCriaQuery(Self);
  Try
    Try
      strSQL := '';
      strSQL := strSQL + 'INSERT INTO ';
      strSQL := strSQL + '  CTRSER(             ';
      strSQL := strSQL + '         SER_CODSER,  ';
      strSQL := strSQL + '         SER_NOMSER,  ';
      strSQL := strSQL + '         SER_PATSER,  ';
      strSQL := strSQL + '         SER_CODEMP,  ';
      strSQL := strSQL + '         AUTOINCREM   ';
      strSQL := strSQL + '         )            ';
      strSQL := strSQL + '  VALUES(             ';
      strSQL := strSQL + '         :CODSER,     ';
      strSQL := strSQL + '         :NOMSER,     ';
      strSQL := strSQL + '         :PATSER,     ';
      strSQL := strSQL + '         :CODEMP,     ';
      strSQL := strSQL + '         :AUTOIN      ';
      strSQL := strSQL + '         )            ';

      qryMod.Close;
      qryMod.SQL.Clear;
      qryMod.SQL.Add(strSQL);

      AStrCodGerado := fAtualizaProCod('CTRSER', 'SER_CODSER');

      qryMod.ParamByName('CODSER').AsString := AStrCodGerado;
      qryMod.ParamByName('NOMSER').AsString := strNomMod;
      qryMod.ParamByName('PATSER').AsString := strPatMod;
      qryMod.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryMod.ParamByName('AUTOIN').AsString := fRetAutoIncrem('CTRSER', VS_strCodEmp);
      qryMod.ExecSQL;

      Result := True;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
        Raise;
      End;
    End;
  Finally
    FreeAndNil(qryMod);
  End;
end;

function TfrmCfgModContrato.fModeloCadastrado(strNomMod: String): Boolean;
  Var
    cdsModTmp: TUniClientDataSet;
begin
  cdsModTmp := TUniClientDataSet.Create(Self);
  Try
    cdsModTmp.Data := cdsModelo.Data;
    cdsModTmp.Filter := cdsModelo.Filter;
    cdsModTmp.Filtered := True;
    Result := False;

    cdsModTmp.First;
    While Not cdsModTmp.Eof Do
    Begin
      If ((cdsModTmp.FieldByName('NOMSER').AsString = strNomMod) And
          (cdsModTmp.FieldByName('STATUS').AsString <> 'E') And
          (cdsModTmp.RecNo <> intRecEdicao)) Then
        Result := True;
      cdsModTmp.Next;
    End;
  Finally
    FreeAndNil(cdsModTmp);
  End;
end;

procedure TfrmCfgModContrato.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNomMod);
end;

procedure TfrmCfgModContrato.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(qryModelo);
  inherited;
end;

procedure TfrmCfgModContrato.FormCreate(Sender: TObject);
begin
  inherited;

  If Not DirectoryExists(ExtractFilePath(Application.ExeName) + 'Modelos\') Then
    edtPatMod.Dialog.Dialog.InitialDir := ExtractFilePath(Application.ExeName)
  Else
    edtPatMod.Dialog.Dialog.InitialDir := ExtractFilePath(Application.ExeName) + 'Modelos\';

end;

procedure TfrmCfgModContrato.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) And (Not dbgModelo.Enabled) Then
  Begin
    edtNomMod.Clear;
    edtPatMod.Clear;
    intRecEdicao      := 0;
    dbgModelo.Enabled := True;
    dbgModelo.Repaint;
    pSetFocus(edtNomMod);
    Key := 0;
  End;
end;

procedure TfrmCfgModContrato.FormShow(Sender: TObject);
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
End;

function TfrmCfgModContrato.fValidaCampos(Sender: TWinControl;
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
end;

procedure TfrmCfgModContrato.pCarregaModelos;
  Var
    strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  SER_CODSER AS CODSER, ';
    strSQL := strSQL + '  SER_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  SER_NOMSER AS NOMSER, ';
    strSQL := strSQL + '  SER_PATSER AS PATSER, ';
    strSQL := strSQL + '  "C"        AS STATUS  ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CTRSER ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  SER_CODEMP = :CODEMP ';

    qryModelo.Close;
    qryModelo.SQL.Clear;
    qryModelo.SQL.Add(strSQL);
    qryModelo.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryModelo.Open;
    pSetaClient(qryModelo);

    cdsModelo.Close;
    cdsModelo.SetProvider(dspModelo);
    cdsModelo.Open;
    pSetaClient(cdsModelo);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
end;

procedure TfrmCfgModContrato.pControlaModelos;
  Var
    intGravados: Integer;
    strCodGerado: String;
begin
  cdsModelo.Filtered := False;
  intGravados := 0;

  cdsModelo.DisableControls;
  Try
    fStartTransaction;

    Try
      cdsModelo.First;
      While Not cdsModelo.Eof Do
      Begin
        If (cdsModelo.FieldByName('STATUS').AsString = 'I') Then
        Begin
          strCodGerado := '';
          If (fInsereModelo(cdsModelo.FieldByName('NOMSER').AsString,
                            cdsModelo.FieldByName('PATSER').AsString,
                            strCodGerado)) Then
            Inc(intGravados);
        End
        Else If (cdsModelo.FieldByName('STATUS').AsString = 'A') Then
        Begin
          If (fAtualizaModelo(cdsModelo.FieldByName('CODSER').AsString,
                              cdsModelo.FieldByName('NOMSER').AsString,
                              cdsModelo.FieldByName('PATSER').AsString)) Then
            Inc(intGravados);
        End
        Else If (cdsModelo.FieldByName('STATUS').AsString = 'E') Then
        Begin
          If (fApagaModelo(cdsModelo.FieldByName('CODSER').AsString)) Then
            Inc(intGravados);
        End;

        cdsModelo.Next;
      End;

      fCommit;
    Except
      On E: Exception Do
      Begin
         fRollBack;
         intGravados := -1;
      End;
    End;
  Finally
    cdsModelo.Filtered := True;
    cdsModelo.EnableControls;
  End;

  If intGravados > 0 Then
  Begin
    pCarregaModelos;
    fMensagem('','Dados gravados com sucesso!',['&O k']);
  End
  Else If intGravados = 0 Then
    fMensagem('ATENÇÃO!','Nenhuma alteração pendente para gravar!',['&O k']);

end;

end.
