unit untCfgModCartaAnu;

interface

uses
  Windows,Classes, Controls, Forms, Grids, DBGridCitel, DBGrids, FilenameEditFocus,
  StdCtrls, EditFocus, AppEvnts, Menus, ComCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, UniDataSetProvider, DB, UniClientDataSet, Uni, Provider, Mask,
  untPaiSimples, frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Datasnap.DBClient, cxTextEdit,
  cxMaskEdit, cxButtonEdit;

type
  TfrmCfgModCartaAnu = class(TfrmPaiSimples)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtNomMod: TEditFocus;
    btnInserir: TBitBtnLocked;
    dbgModelo: TDBGridCitel;
    Panel2: TPanel;
    BitBtnLocked1: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    dtsModelo: TDataSource;
    cdsModelo: TUniClientDataSet;
    dspModelo: TUniDataSetProvider;
    edtPatMod: TFilenameEditFocus;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnInserirClick(Sender: TObject);
    procedure dbgModeloKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure edtPatModExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
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

uses SysUtils, strUtils, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCfgModCartaAnu.btnGravarClick(Sender: TObject);
begin
  inherited;
  pControlaModelos;
end;

procedure TfrmCfgModCartaAnu.btnInserirClick(Sender: TObject);
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

  If (Not fEmptyStr(edtNomMod.Text)) And (Not fEmptyStr(edtPatMod.Text)) Then
  Begin
    With cdsModelo Do
    Begin
      Append;
      FieldByName('CODANU').AsString := '1';
      FieldByName('CODEMP').AsString := VS_strCodEmp;
      FieldByName('NOMANU').AsString := edtNomMod.Text;
      FieldByName('PATANU').AsString := AnsiReplaceStr(edtPatMod.Text,'"','');
      FieldByName('STATUS').AsString := 'I';
      Post;
    End;
    edtNomMod.Clear;
    edtPatMod.Clear;
    pSetFocus(edtNomMod);
  End;
end;

procedure TfrmCfgModCartaAnu.dbgModeloKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) And (Not cdsModelo.IsEmpty) Then
  Begin
    If (fMensagem('ATENÇÃO!','Deseja realmente excluir o Modelo ' + cdsModelo.FieldByName('NOMANU').AsString, ['&Sim','&Não'], 2) = 1) Then
    Begin
      cdsModelo.Edit;
      cdsModelo.FieldByName('STATUS').AsString := 'E';
      cdsModelo.Post;
    End;
  End
  Else If (Key = VK_RETURN) And (Not cdsModelo.IsEmpty) Then
  Begin
    edtNomMod.Text    := cdsModelo.FieldByName('NOMANU').AsString;
    edtPatMod.Text    := cdsModelo.FieldByName('PATANU').AsString;
    pSetFocus(edtNomMod);
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    edtNomMod.Clear;
    edtPatMod.Clear;
    pSetFocus(edtNomMod);
  End;
end;

procedure TfrmCfgModCartaAnu.edtPatModExit(Sender: TObject);
begin
  inherited;
  edtPatMod.Text := AnsiReplaceStr(edtPatMod.Text, '"', '');
end;

function TfrmCfgModCartaAnu.fApagaModelo(strCodMod: String): Boolean;
  Var
    strSQL: String;
    qryMod: TUniQuery;
begin
  Result := False;
  Try
    qryMod := fCriaQuery(Self);
    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  CARANU    ';
    strSQL := strSQL + 'WHERE       ';
    strSQL := strSQL + '  ANU_CODANU = :CODANU AND ';
    strSQL := strSQL + '  ANU_CODEMP = :CODEMP ';
    With qryMod Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODANU').AsString := strCodMod;
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

function TfrmCfgModCartaAnu.fAtualizaModelo(strCodMod, strNomMod,
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
    strSQL := strSQL + '  CARANU ';
    strSQL := strSQL + 'SET      ';
    strSQL := strSQL + '  ANU_NOMANU = :NOMANU, ';
    strSQL := strSQL + '  ANU_PATANU = :PATANU  ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  ANU_CODANU = :CODANU AND ';
    strSQL := strSQL + '  ANU_CODEMP = :CODEMP ';
    With qryMod Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NOMANU').AsString := strNomMod;
      ParamByName('PATANU').AsString := strPatMod;
      ParamByName('CODANU').AsString := strCodMod;
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

function TfrmCfgModCartaAnu.fInsereModelo(strNomMod,
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
    strSQL := strSQL + '  CARANU(             ';
    strSQL := strSQL + '         ANU_CODANU,  ';
    strSQL := strSQL + '         ANU_NOMANU,  ';
    strSQL := strSQL + '         ANU_PATANU,  ';
    strSQL := strSQL + '         ANU_CODEMP,  ';
    strSQL := strSQL + '         AUTOINCREM   ';
    strSQL := strSQL + '         )            ';
    strSQL := strSQL + '  VALUES(             ';
    strSQL := strSQL + '         :CODANU,     ';
    strSQL := strSQL + '         :NOMANU,     ';
    strSQL := strSQL + '         :PATANU,     ';
    strSQL := strSQL + '         :CODEMP,     ';
    strSQL := strSQL + '         :AUTOIN      ';
    strSQL := strSQL + '         )            ';
    With qryMod Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODANU').AsString := fAtualizaProCod('CARANU', 'ANU_CODANU');
      ParamByName('NOMANU').AsString := strNomMod;
      ParamByName('PATANU').AsString := strPatMod;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('AUTOIN').AsString := fRetAutoIncrem('CARANU', VS_strCodEmp);
      ExecSQL;
      Result := True;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  FreeAndNil(qryMod);
end;

function TfrmCfgModCartaAnu.fModeloCadastrado(strNomMod: String): Boolean;
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
      If ((FieldByName('NOMANU').AsString = strNomMod) And ((FieldByName('STATUS').AsString <> 'E'))) Then
        Result := True;
      Next;
    End;
  End;
end;

procedure TfrmCfgModCartaAnu.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNomMod);
end;

procedure TfrmCfgModCartaAnu.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(qryModelo);
  inherited;            
end;

procedure TfrmCfgModCartaAnu.FormCreate(Sender: TObject);
begin
  inherited;
  
  If Not DirectoryExists(ExtractFilePath(Application.ExeName) + 'Modelos\') Then
    edtPatMod.Dialog.Dialog.InitialDir := ExtractFilePath(Application.ExeName)
  Else
    edtPatMod.Dialog.Dialog.InitialDir := ExtractFilePath(Application.ExeName) + 'Modelos\';

end;

procedure TfrmCfgModCartaAnu.FormShow(Sender: TObject);
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

function TfrmCfgModCartaAnu.fValidaCampos(Sender: TWinControl;
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

procedure TfrmCfgModCartaAnu.pCarregaModelos;
  Var
    strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  ANU_CODANU AS CODANU, ';
    strSQL := strSQL + '  ANU_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  ANU_NOMANU AS NOMANU, ';
    strSQL := strSQL + '  ANU_PATANU AS PATANU, ';
    strSQL := strSQL + '  "C"        AS STATUS  ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CARANU ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  ANU_CODEMP = :CODEMP ';

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

procedure TfrmCfgModCartaAnu.pControlaModelos;
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
        Begin
          If (fInsereModelo(FieldByName('NOMANU').AsString, FieldByName('PATANU').AsString)) Then
          Begin
            Edit;
            FieldByName('STATUS').AsString := 'A';
            Post;
          End;
        End
        Else If (FieldByName('STATUS').AsString = 'A') Then
          fAtualizaModelo(FieldByName('CODANU').AsString, FieldByName('NOMANU').AsString, FieldByName('PATANU').AsString)
        Else If (FieldByName('STATUS').AsString = 'E') Then
          fApagaModelo(FieldByName('CODANU').AsString);

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
