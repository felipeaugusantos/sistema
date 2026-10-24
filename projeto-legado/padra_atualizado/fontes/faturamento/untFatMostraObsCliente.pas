unit untFatMostraObsCliente;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  EditFocus, Menus, MemoFocus, AppEvnts, Uni, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmFatMostraObsCliente = class(TfrmPaiSimples)
    Panel1: TPanel;
    Panel2: TPanel;
    btnFechar: TBitBtnLocked;
    Label1: TLabel;
    btnAlterar: TBitBtnLocked;
    memFixo: TMemoFocus;
    memObserv: TMemoFocus;
    procedure btnSairClick(Sender: TObject);
    procedure redtObserv2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure memObservKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    strCodCli: String;
    blnAceTot: Boolean;
    procedure pMostraObsCliente(strCodCli:String;blnExitVazia:Boolean = True);
  end;

var
  frmFatMostraObsCliente: TfrmFatMostraObsCliente;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatMostraObsCliente.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatMostraObsCliente.redtObserv2KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
    btnFechar.Click;
end;

procedure TfrmFatMostraObsCliente.btnAlterarClick(Sender: TObject);
Var
  strSQL : String;
  qryGen : TUniQuery;
  strObs : String;
begin
  inherited;

  If copy(btnAlterar.Caption, 3,2) = 'F2' Then
  Begin
    btnAlterar.Caption := '[ F10 ] Salvar';

    {*************************************************************************}
    {* VERIFICA SE O OPERADOR TEM DIREITO DE ALTERACAO TOTAL NAS OBSERVACOES *}
    {**********************************************************************LU*}
    If blnAceTot Then
      memObserv.ReadOnly := False
    Else
    Begin
      {********************************************************************************}
      {* VERIFICA SE O OPERADOR TEM DIREITO DE ALTERACAO COMPLEMENTAR NAS OBSERVACOES *}
      {*****************************************************************************LU*}
      If Not blnAceTot Then
      Begin
        memFixo.Texto := memObserv.Texto;
        memObserv.Texto := '';
        memObserv.ReadOnly := False;

        memFixo.Visible := True;
        memObserv.Top := 70;
        memObserv.Height := 60;
      End
      Else
      Begin
        btnAlterar.Caption := '[ F2 ] Alterar';
        fMensagem('ATENÇÃO!', 'Esse operador não tem direito para alteração!', ['&O k']);
      End;

    End;

    pSetFocus(memObserv);
  End
  Else
  Begin

    Try
      If blnAceTot Then
        strObs := memObserv.Text
      Else
      Begin
        If fEmptyStr(memFixo.Text) Then
          strObs := memObserv.Text
        Else
          strObs := memFixo.Text + #13 + memObserv.Text;
      End;

      qryGen := fCriaQuery;

      strSQL := '';
      strSQL := strSQL + ' UPDATE ';
      strSQL := strSQL + '   CADCLI ';
      strSQL := strSQL + ' SET ';
      strSQL := strSQL + '   CLI_OBSERV = :OBSERV ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   CLI_CODCLI = :CODCLI ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODCLI').AsString := strCodCli;
        ParamByName('OBSERV').AsString := strObs;
        ExecSQL;
      End;

      memFixo.Visible := False;
      memObserv.Top := 8;
      memObserv.Height := 120;
      memObserv.Texto := strObs;
      memObserv.ReadOnly := True;

      btnAlterar.Caption := '[ F2 ] Alterar';

      fMensagem('AVISO!', 'Alteração efetuada com sucesso!', ['&O k']);
    Finally
      FreeAndNil(qryGen);
    End;

  End;

end;

procedure TfrmFatMostraObsCliente.FormShow(Sender: TObject);
begin
  inherited;

  memFixo.Font.Height   := strToIntDef(fCfgSis('FNTOBS', varInteger), memFixo.Font.Height) ;
  memObserv.Font.Height := strToIntDef(fCfgSis('FNTOBS', varInteger), memObserv.Font.Height) ;

  memFixo.Visible := False;
  memObserv.Top := 8;
  memObserv.Height := 120;
  memObserv.ReadOnly := True;

  If fVerificaAcessoSistema('OBCLAT', strLoginUsuarioLogado) Or
     fVerificaAcessoSistema('OBCLAC', strLoginUsuarioLogado) Then
  Begin
    {*************************************************************************}
    {* VERIFICA SE O OPERADOR TEM DIREITO DE ALTERACAO TOTAL NAS OBSERVACOES *}
    {**********************************************************************LU*}
    If fVerificaAcessoSistema('OBCLAT', strLoginUsuarioLogado) Then
      blnAceTot := True
    Else
    Begin
      {********************************************************************************}
      {* VERIFICA SE O OPERADOR TEM DIREITO DE ALTERACAO COMPLEMENTAR NAS OBSERVACOES *}
      {*****************************************************************************LU*}
      If fVerificaAcessoSistema('OBCLAC', strLoginUsuarioLogado) Then
        blnAceTot := False;
    End;
  End
  Else
    btnAlterar.Visible := False;

  memObserv.SelStart := Length(memObserv.Texto);
end;

procedure TfrmFatMostraObsCliente.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If ((Key = VK_F2) Or (Key = VK_F10)) And btnAlterar.Visible Then
    btnAlterar.Click;
end;

procedure TfrmFatMostraObsCliente.memObservKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_ESCAPE) Then
    btnFechar.Click;
    
end;

procedure TfrmFatMostraObsCliente.pMostraObsCliente(strCodCli: String;blnExitVazia:Boolean = True);
  Var
    qryQuery: TUniQuery;
begin
  If Not fVerificaAcessoSistema('ACEF2_') Then
  Begin
    fMensagem('', 'Operador não tem direito para "F2 - Observação"!', ['&Ok']);
    Exit;
  End;

  Try
    qryQuery := fCriaQuery;
    With qryQuery Do
    Begin
      SQL.Clear;
      SQL.Add(' SELECT ');
      SQL.Add('   CLI_OBSERV ');
      SQL.Add(' FROM CADCLI ');
      SQL.Add(' WHERE CLI_CODCLI = :CODCLI ');
      ParamByName('CODCLI').AsString := strCodCli;
      Open;

      If (fEmptyStr(FieldByName('CLI_OBSERV').AsString) And (blnExitVazia)) Then
        Exit;

      Try
        memObserv.Texto                     := FieldByName('CLI_OBSERV').AsString;
        frmFatMostraObsCliente.strCodCli    := strCodCli;
        frmFatMostraObsCliente.ShowModal;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '');
      End;
      pFreeAndNil(frmFatMostraObsCliente);

    End;
  Finally
    FreeAndNil(qryQuery);
  End;
end;

end.
