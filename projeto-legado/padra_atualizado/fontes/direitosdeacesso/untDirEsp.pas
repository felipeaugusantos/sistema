unit untDirEsp;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, ExtCtrls, ComCtrls, DB, strUtils, StdCtrls, EditFocus,
  Mask, DBCtrls, CheckLst, Menus, Buttons, Uni, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade {Qt,} {QTypes,};

type
  TfrmDirEsp = class(TfrmPai)
    lblLogin: TLabel;
    lblNomForm: TLabel;
    grpOpcoes: TGroupBox;
    lstOpcoes: TCheckListBox;
    dbeCadOpe: TDBEdit;
    Label1: TLabel;
    dbeLogOpe: TEditFocus;
    dtsGenOpe: TDataSource;
    btnMarcar: TBitBtnLocked;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pCarregalstOpcoes;
    procedure FormShow(Sender: TObject);
    procedure dbeLogOpeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbeLogOpeCloseUp(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lstOpcoesClickCheck(Sender: TObject);
    procedure btnMarcarClick(Sender: TObject);
  private
    { Private declarations }
    qryCadOpe: TUniQuery;
  public
    { Public declarations }
    qryGenOpe, qryOpe02: TUniQuery;

  end;


implementation

uses untModulo,  untfuncoesSimples;

{$R *.dfm}

procedure TfrmDirEsp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  // necessário gravar um _ no início pois a função que verifica os acessos
  // ignora as verificações caso nenhum acesso foi concedido e a string estiver em branco ''
  if Trim(frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString) = EmptyStr then
    frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString := '_';

  If (frmModulo.qryDirOpe.State = dsEdit) Or (frmModulo.qryDirOpe.State = dsInsert) Then
    frmModulo.qryDirOpe.Post;

  qryCadOpe.Close;
end;

procedure TfrmDirEsp.pCarregalstOpcoes;
Begin
  If frmModulo.qryDirOpe.State = dsEdit Then
  Begin
    // necessário remover o _ pois o campo da tabela só tem 3 posições, específicas para IAE
    frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString := AnsiReplaceStr(frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString, '_', '');

    If Pos('I', frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString) > 0 Then
      lstOpcoes.Checked[0] := True
    Else
      lstOpcoes.Checked[0] := False;

    If Pos('A', frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString) > 0 Then
      lstOpcoes.Checked[1] := True
    Else
      lstOpcoes.Checked[1] := False;

    If Pos('E', frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString) > 0 Then
      lstOpcoes.Checked[2] := True
    Else
      lstOpcoes.Checked[2] := False;
  End;
End;

procedure TfrmDirEsp.FormShow(Sender: TObject);
begin
  inherited;

  dtsGenOpe.DataSet := qryGenOpe;

  qryCadOpe.Open;
  pCarregalstOpcoes;
end;

procedure TfrmDirEsp.dbeLogOpeKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
  Var
    intCont: Integer;
begin
  inherited;
  If (Key = VK_UP) Or (Key = VK_DOWN) Then
  Begin
    If (frmModulo.qryDirOpe.State = dsEdit) Or (frmModulo.qryDirOpe.State = dsInsert) Then
      frmModulo.qryDirOpe.Post;

    If Key = VK_DOWN Then
      qryOpe02.Next
    Else
      qryOpe02.Prior;

    If frmModulo.qryDirOpe.Locate('OPE_CODOPE;DIR_NOMFRM', VarArrayOf([qryOpe02.FieldByName('OPE_LOGOPE').AsVariant ,lblNomForm.Caption]), [loCaseInSensitive]) Then
    Begin
      frmModulo.qryDirOpe.Edit;
      pCarregalstOpcoes;
    End
    Else
    Begin
      frmModulo.qryDirOpe.Insert;
      frmModulo.qryDirOpe.FieldByName('ESP_LOGOPE').AsString := qryOpe02.FieldByName('OPE_LOGOPE').AsString;
      frmModulo.qryDirOpe.FieldByName('ESP_NOMFRM').AsString := lblNomForm.Caption;
      For intCont := 0 To lstOpcoes.Items.Count - 1 Do
        lstOpcoes.Checked[intCont] := False;
    End;
    qryGenOpe.Locate('OPE_CODOPE', qryOpe02.FieldByName('OPE_CODOPE').AsString, [loCaseInSensitive]);
  End;
end;

procedure TfrmDirEsp.dbeLogOpeCloseUp(Sender: TObject);
  Var
    intCont: Integer;
begin
  inherited;
  If (frmModulo.qryDirOpe.State = dsEdit) Or (frmModulo.qryDirOpe.State = dsInsert) Then
    frmModulo.qryDirOpe.Post;

  If frmModulo.qryDirOpe.Locate('OPE_CODOPE;DIR_NOMFRM', VarArrayOf([dbeLogOpe.Text,lblNomForm.Caption]), [loCaseInSensitive]) Then
  Begin
    frmModulo.qryDirOpe.Edit;
    pCarregalstOpcoes;
  End
  Else
  Begin
    frmModulo.qryDirOpe.Insert;
    frmModulo.qryDirOpe.FieldByName('OPE_CODOPE').AsString := dbeLogOpe.Text;
    frmModulo.qryDirOpe.FieldByName('DIR_NOMFRM').AsString := lblNomForm.Caption;
    For intCont := 0 To lstOpcoes.Items.Count - 1 Do
      lstOpcoes.Checked[intCont] := False;
  End;

  qryGenOpe.Locate('OPE_CODOPE', dbeLogOpe.Text, [loCaseInSensitive]);
end;

procedure TfrmDirEsp.FormCreate(Sender: TObject);
begin
  inherited;
  qryGenOpe := fCriaQuery(Self);
  qryCadOpe := fCriarQuery('SELECT * FROM CADOPE', Self);
  Self.Caption := 'Direitos Específicos';
end;

procedure TfrmDirEsp.lstOpcoesClickCheck(Sender: TObject);
begin
  inherited;
  If lstOpcoes.ItemIndex = 0 Then
  Begin
    If lstOpcoes.Checked[0] Then
      frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString := frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString + 'I'
    Else
      frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString := AnsiReplaceStr(frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString, 'I', '');
  End
  Else If lstOpcoes.ItemIndex = 1 Then
  Begin
    If lstOpcoes.Checked[1] Then
      frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString := frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString + 'A'
    Else
      frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString := AnsiReplaceStr(frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString, 'A', '');
  End
  Else If lstOpcoes.ItemIndex = 2 Then
  Begin
    If lstOpcoes.Checked[2] Then
      frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString := frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString + 'E'
    Else
      frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString := AnsiReplaceStr(frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString, 'E', '');
  End;
end;

procedure TfrmDirEsp.btnMarcarClick(Sender: TObject);
begin
  inherited;
  If lstOpcoes.Checked[0] = True And
    lstOpcoes.Checked[1] = True And
    lstOpcoes.Checked[2] = True Then
  Begin
    frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString := AnsiReplaceStr(frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString, 'I', '');
    frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString := AnsiReplaceStr(frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString, 'A', '');
    frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString := AnsiReplaceStr(frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString, 'E', '');

    lstOpcoes.Checked[0] := False;
    lstOpcoes.Checked[1] := False;
    lstOpcoes.Checked[2] := False;
  End
  Else If lstOpcoes.Checked[0] = False And
    lstOpcoes.Checked[1] = False And
    lstOpcoes.Checked[2] = False Then
  Begin
    frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString := frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString + 'I';
    frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString := frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString + 'A';
    frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString := frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString + 'E';

    lstOpcoes.Checked[0] := True;
    lstOpcoes.Checked[1] := True;
    lstOpcoes.Checked[2] := True;
  End
  Else
  Begin
    frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString := AnsiReplaceStr(frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString, 'I', '');
    frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString := AnsiReplaceStr(frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString, 'A', '');
    frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString := AnsiReplaceStr(frmModulo.qryDirOpe.FieldByName('DIR_ACAOUS').AsString, 'E', '');

    lstOpcoes.Checked[0] := True;
    lstOpcoes.Checked[1] := True;
    lstOpcoes.Checked[2] := True;
  End;
end;

end.


