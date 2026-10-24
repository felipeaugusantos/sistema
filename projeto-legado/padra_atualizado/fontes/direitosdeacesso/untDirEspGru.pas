unit untDirEspGru;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Forms,
  Dialogs, untPai, ExtCtrls, ComCtrls, StdCtrls, EditFocus, Controls,
  CheckLst, Mask, DBCtrls, Menus, Buttons, {Qt,} DB, strUtils, AppEvnts,
  Uni, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmDirEspGru = class(TfrmPai)
    lblCodGrup: TLabel;
    dbeDescGrup: TDBEdit;
    dbgOpcoes: TGroupBox;
    lstOpcoes: TCheckListBox;
    lblNomForm: TLabel;
    Label1: TLabel;
    dbeCodGru: TEditFocus;
    dtsGru02: TDataSource;
    btnMarcar: TBitBtnLocked;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pCarregalstOpcoes;
    procedure lstOpcoesClickCheck(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbeCodGruCloseUp(Sender: TObject);
    procedure dbeCodGruKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMarcarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    qryGru02: TUniQuery;
  end;


implementation

uses untModulo;

{$R *.dfm}

procedure TfrmDirEspGru.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  // necessário gravar um _ no início pois a função que verifica os acessos
  // ignora as verificações caso nenhum acesso foi concedido e a string estiver em branco ''
  if Trim(frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString) = EmptyStr then
    frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString := '_';

  If (frmModulo.qryDirGpo.State = dsEdit) Or (frmModulo.qryDirGpo.State = dsInsert) Then
    frmModulo.qryDirGpo.Post;

  frmModulo.qryCadGpo.Close;
end;

procedure TfrmDirEspGru.lstOpcoesClickCheck(Sender: TObject);
begin
  inherited;

  If lstOpcoes.ItemIndex = 0 Then
  Begin
    If lstOpcoes.Checked[0] Then
      frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString := frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString + 'I'
    Else
      frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString := AnsiReplaceStr(frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString, 'I', '');
  End

  Else If lstOpcoes.ItemIndex = 1 Then
  Begin
    If lstOpcoes.Checked[1] Then
      frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString := frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString + 'A'
    Else
      frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString := AnsiReplaceStr(frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString, 'A', '');
  End

  Else If lstOpcoes.ItemIndex = 2 Then
  Begin
    If lstOpcoes.Checked[2] Then
      frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString := frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString + 'E'
    Else
      frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString := AnsiReplaceStr(frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString, 'E', '');
  End;
end;

procedure TfrmDirEspGru.FormCreate(Sender: TObject);
begin
  inherited;
  Self.Caption := 'Direitos Específicos de Grupo';
end;

procedure TfrmDirEspGru.FormShow(Sender: TObject);
begin
  inherited;
  dtsGru02.DataSet := qryGru02;
  frmModulo.qryCadGpo.Open;
  pCarregalstOpcoes;
end;

procedure TfrmDirEspGru.pCarregalstOpcoes;
Begin
  If frmModulo.qryDirGpo.State = dsEdit Then
  Begin
    // necessário remover o _ pois o campo da tabela só tem 3 posições, específicas para IAE
    frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString := AnsiReplaceStr(frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString, '_', '');

    If Pos('I', frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString) > 0 Then
      lstOpcoes.Checked[0] := True
    Else
      lstOpcoes.Checked[0] := False;

    If Pos('A', frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString) > 0 Then
      lstOpcoes.Checked[1] := True
    Else
      lstOpcoes.Checked[1] := False;

    If Pos('E', frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString) > 0 Then
      lstOpcoes.Checked[2] := True
    Else
      lstOpcoes.Checked[2] := False;
  End;
End;


procedure TfrmDirEspGru.dbeCodGruCloseUp(Sender: TObject);
  Var
    intCont: Integer;
begin
  inherited;
  If (frmModulo.qryDirGpo.State = dsEdit) Or (frmModulo.qryDirGpo.State = dsInsert) Then
    frmModulo.qryDirGpo.Post;

  If frmModulo.qryDirGpo.Locate('GPO_CODGPO;DIR_NOMFRM', VarArrayOf([dbeCodGru.Text,lblNomForm.Caption]), [loCaseInSensitive]) Then
  Begin
    frmModulo.qryDirGpo.Edit;
    pCarregalstOpcoes;
  End
  Else
  Begin
    frmModulo.qryDirGpo.Insert;
    frmModulo.qryDirGpo.FieldByName('GPO_CODGPO').AsString := dbeCodGru.Text;
    frmModulo.qryDirGpo.FieldByName('DIR_NOMFRM').AsString := lblNomForm.Caption;

    For intCont := 0 To lstOpcoes.Items.Count - 1 Do
      lstOpcoes.Checked[intCont] := False;
  End;
end;

procedure TfrmDirEspGru.dbeCodGruKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  Var
    intCont: Integer;
begin
  inherited;
  If (Key = VK_UP) Or (Key = VK_DOWN) Then
  Begin
    If (frmModulo.qryDirGpo.State = dsEdit) Or (frmModulo.qryDirGpo.State = dsInsert) Then
      frmModulo.qryDirGpo.Post;

    If Key = VK_DOWN Then
      qryGru02.Next
    Else
      qryGru02.Prior;

    If frmModulo.qryDirGpo.Locate('GPO_CODGPO;DIR_NOMFRM', VarArrayOf([qryGru02.FieldByName('GPO_CODGPO').AsVariant ,lblNomForm.Caption]), [loCaseInSensitive]) Then
    Begin
      frmModulo.qryDirGpo.Edit;
      pCarregalstOpcoes;
    End
    Else
    Begin
      frmModulo.qryDirGpo.Insert;
      frmModulo.qryDirGpo.FieldByName('GPO_CODGPO').AsString := qryGru02.FieldByName('GPO_CODGPO').AsString;
      frmModulo.qryDirGpo.FieldByName('DIR_NOMFRM').AsString := lblNomForm.Caption;

      For intCont := 0 To lstOpcoes.Items.Count - 1 Do
        lstOpcoes.Checked[intCont] := False;
    End;
  End;
end;

procedure TfrmDirEspGru.btnMarcarClick(Sender: TObject);
begin
  inherited;
  If lstOpcoes.Checked[0] = True And
    lstOpcoes.Checked[1] = True And
    lstOpcoes.Checked[2] = True Then
  Begin
    frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString := AnsiReplaceStr(frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString, 'I', '');
    frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString := AnsiReplaceStr(frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString, 'A', '');
    frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString := AnsiReplaceStr(frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString, 'E', '');

    lstOpcoes.Checked[0] := False;
    lstOpcoes.Checked[1] := False;
    lstOpcoes.Checked[2] := False;
  End

  Else If lstOpcoes.Checked[0] = False And
    lstOpcoes.Checked[1] = False And
    lstOpcoes.Checked[2] = False Then
  Begin
    frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString := frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString + 'I';
    frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString := frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString + 'A';
    frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString := frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString + 'E';

    lstOpcoes.Checked[0] := True;
    lstOpcoes.Checked[1] := True;
    lstOpcoes.Checked[2] := True;
  End
  Else
  Begin
    frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString := AnsiReplaceStr(frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString, 'I', '');
    frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString := AnsiReplaceStr(frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString, 'A', '');
    frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString := AnsiReplaceStr(frmModulo.qryDirGpo.FieldByName('DIR_ACAOUS').AsString, 'E', '');

    lstOpcoes.Checked[0] := True;
    lstOpcoes.Checked[1] := True;
    lstOpcoes.Checked[2] := True;
  End;
end;

end.
