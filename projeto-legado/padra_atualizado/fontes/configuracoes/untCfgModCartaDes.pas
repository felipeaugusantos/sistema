unit untCfgModCartaDes;

interface

uses
  Windows, Classes, Controls, Forms, untPaiSimples, Mask, FilenameEditFocus,
  StdCtrls, EditFocus, Grids, DBGridCitel, DBGrids, AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls,
  UniDataSetProvider, DB, UniClientDataSet, Uni, BitBtnLockedIncrem, Provider,
  frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Datasnap.DBClient, cxTextEdit, cxMaskEdit, cxButtonEdit;

type
  TfrmCfgModCartaDes = class(TfrmPaiSimples)
    grdModelo: TDBGridCitel;
    pnl2: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    edtNomMod: TEditFocus;
    dtsModelo: TDataSource;
    cdsModelo: TUniClientDataSet;
    dspModelo: TUniDataSetProvider;
    btnGravar: TBitBtnLocked;
    btnInserir: TBitBtnLocked;
    edtPatMod: TFilenameEditFocus;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure edtPatModExit(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure grdModeloKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
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

uses SysUtils, StrUtils, untFuncoesSimples;

{$R *.dfm}

{ TfrmCfgModCartaDes }

procedure TfrmCfgModCartaDes.btnGravarClick(Sender: TObject);
begin
  inherited;
  pControlaModelos;
end;

procedure TfrmCfgModCartaDes.btnInserirClick(Sender: TObject);
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

  If (Not fEmptyStr(edtNomMod.Text)) And (Not fEmptyStr(edtPatMod.Text)) And (grdModelo.Enabled) Then
  Begin
    With cdsModelo Do
    Begin
      Append;
      FieldByName('CODCAR').AsString := '1';
      FieldByName('CODEMP').AsString := VS_strCodEmp;
      FieldByName('NOMCAR').AsString := edtNomMod.Text;
      FieldByName('PATCAR').AsString := AnsiReplaceStr(edtPatMod.Text,'"','');
      FieldByName('STATUS').AsString := 'I';
      Post;
    End;
    edtNomMod.Clear;
    edtPatMod.Clear;
    pSetFocus(edtNomMod);
  End
  Else If (Not fEmptyStr(edtNomMod.Text)) And (Not fEmptyStr(edtPatMod.Text)) And (Not grdModelo.Enabled) Then
  Begin
    With cdsModelo Do
    Begin
      Edit;
      FieldByName('NOMCAR').AsString := edtNomMod.Text;
      FieldByName('PATCAR').AsString := AnsiReplaceStr(edtPatMod.Text,'"','');
      FieldByName('STATUS').AsString := 'A';
      Post;
    End;
    grdModelo.Enabled := True;
    edtNomMod.Clear;
    edtPatMod.Clear;
    pSetFocus(edtNomMod);
  End
end;

procedure TfrmCfgModCartaDes.edtPatModExit(Sender: TObject);
begin
  inherited;
  edtPatMod.Text := AnsiReplaceStr(edtPatMod.Text, '"', '');
end;

function TfrmCfgModCartaDes.fApagaModelo(strCodMod: String): Boolean;
  Var
    strSQL: String;
    qryMod: TUniQuery;
begin
  Result := False;
  Try
    qryMod := fCriaQuery(Self);
    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  CARDES    ';
    strSQL := strSQL + 'WHERE       ';
    strSQL := strSQL + '  CAR_CODCAR = :CODCAR AND ';
    strSQL := strSQL + '  CAR_CODEMP = :CODEMP ';
    With qryMod Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCAR').AsString := strCodMod;
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

function TfrmCfgModCartaDes.fAtualizaModelo(strCodMod, strNomMod,
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
    strSQL := strSQL + '  CARDES ';
    strSQL := strSQL + 'SET      ';
    strSQL := strSQL + '  CAR_NOMCAR = :NOMCAR, ';
    strSQL := strSQL + '  CAR_PATCAR = :PATCAR  ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  CAR_CODCAR = :CODCAR AND ';
    strSQL := strSQL + '  CAR_CODEMP = :CODEMP ';
    With qryMod Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NOMCAR').AsString := strNomMod;
      ParamByName('PATCAR').AsString := strPatMod;
      ParamByName('CODCAR').AsString := strCodMod;
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

function TfrmCfgModCartaDes.fInsereModelo(strNomMod,
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
    strSQL := strSQL + '  CARDES(             ';
    strSQL := strSQL + '         CAR_CODCAR,  ';
    strSQL := strSQL + '         CAR_NOMCAR,  ';
    strSQL := strSQL + '         CAR_PATCAR,  ';
    strSQL := strSQL + '         CAR_CODEMP,  ';
    strSQL := strSQL + '         AUTOINCREM   ';
    strSQL := strSQL + '         )            ';
    strSQL := strSQL + '  VALUES(             ';
    strSQL := strSQL + '         :CODCAR,     ';
    strSQL := strSQL + '         :NOMCAR,     ';
    strSQL := strSQL + '         :PATCAR,     ';
    strSQL := strSQL + '         :CODEMP,     ';
    strSQL := strSQL + '         :AUTOIN      ';
    strSQL := strSQL + '         )            ';
    With qryMod Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCAR').AsString := fAtualizaProCod('CARDES', 'CAR_CODCAR');
      ParamByName('NOMCAR').AsString := strNomMod;
      ParamByName('PATCAR').AsString := strPatMod;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('AUTOIN').AsString := fRetAutoIncrem('CARDES', VS_strCodEmp);
      ExecSQL;
      Result := True;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  FreeAndNil(qryMod);
end;

function TfrmCfgModCartaDes.fModeloCadastrado(strNomMod: String): Boolean;
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
      If (FieldByName('NOMCAR').AsString = strNomMod) Then
        Result := True;
      Next;
    End;
  End;
end;

procedure TfrmCfgModCartaDes.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNomMod);
end;

procedure TfrmCfgModCartaDes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(qryModelo);
  inherited;
end;

procedure TfrmCfgModCartaDes.FormShow(Sender: TObject);
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

function TfrmCfgModCartaDes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (Sender = edtNomMod) Then
  Begin
    If (fEmptyStr(edtNomMod.Text)) And (grdModelo.CanFocus) Then
    Begin
      pSetFocus(grdModelo);
      blnMudarFoco := False;
    End;
  End;
  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCfgModCartaDes.grdModeloKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) And (Not cdsModelo.IsEmpty) Then
  Begin
    If (fMensagem('ATENÇÃO!','Deseja realmente excluir o Modelo ' + cdsModelo.FieldByName('NOMCAR').AsString, ['&Sim','&Não'], 2) = 1) Then
    Begin
      cdsModelo.Edit;
      cdsModelo.FieldByName('STATUS').AsString := 'E';
      cdsModelo.Post;
    End;
  End
  Else If (Key = VK_RETURN) And (Not cdsModelo.IsEmpty) Then
  Begin
    edtNomMod.Text    := cdsModelo.FieldByName('NOMCAR').AsString;
    edtPatMod.Text    := cdsModelo.FieldByName('PATCAR').AsString;
    grdModelo.Enabled := False;
    grdModelo.Repaint;
    pSetFocus(edtNomMod);
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    edtNomMod.Clear;
    edtPatMod.Clear;
    pSetFocus(edtNomMod);
  End;
end;

procedure TfrmCfgModCartaDes.pCarregaModelos;
Var
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  CAR_CODCAR AS CODCAR, ';
    strSQL := strSQL + '  CAR_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  CAR_NOMCAR AS NOMCAR, ';
    strSQL := strSQL + '  CAR_PATCAR AS PATCAR, ';
    strSQL := strSQL + '  "C"        AS STATUS  ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CARDES ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  CAR_CODEMP = :CODEMP ';

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

procedure TfrmCfgModCartaDes.pControlaModelos;
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
          fInsereModelo(FieldByName('NOMCAR').AsString, FieldByName('PATCAR').AsString)
        Else If (FieldByName('STATUS').AsString = 'A') Then
          fAtualizaModelo(FieldByName('CODCAR').AsString, FieldByName('NOMCAR').AsString, FieldByName('PATCAR').AsString)
        Else If (FieldByName('STATUS').AsString = 'E') Then
          fApagaModelo(FieldByName('CODCAR').AsString);

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

