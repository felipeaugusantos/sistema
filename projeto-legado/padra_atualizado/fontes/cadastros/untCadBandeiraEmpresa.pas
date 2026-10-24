unit untCadBandeiraEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB;

type
  TfrmCadBandeiraEmpresa = class(TfrmPaiCad)
    pnlDados: TPanel;
    Label1: TLabel;
    dbeCodBan: TDBEditFocus;
    Label2: TLabel;
    dbeDesBan: TDBEditFocus;
    dtsTabela: TDataSource;
    lblCorBan: TLabel;
    dbeCorBan: TDBEditFocus;
    cldCores: TColorDialog;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure lblCorBanClick(Sender: TObject);
    procedure dbeCorBanChange(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure dtsTabelaDataChange(Sender: TObject; Field: TField);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

{$R *.dfm}

uses
  untTypesSistema,
  untConsultas,
  untFuncoesSimples;

procedure TfrmCadBandeiraEmpresa.btnAlterarClick(Sender: TObject);
begin
  inherited;

  pHabilitaCodigo(dbeCodBan, dbeDesBan, False);

  dbeCorBanChange(dbeCorBan);
end;

procedure TfrmCadBandeiraEmpresa.btnCancelaClick(Sender: TObject);
begin
  inherited;

  dbeCorBanChange(dbeCorBan);
end;

procedure TfrmCadBandeiraEmpresa.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadBandeiraEmpresa.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  dbeCorBanChange(dbeCorBan);
end;

procedure TfrmCadBandeiraEmpresa.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadBandeiraEmpresa.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadBandeiraEmpresa.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodBan, dbeDesBan, False)
  Else
    pHabilitaCodigo(dbeCodBan, dbeCodBan, True);

  dbeCorBanChange(dbeCorBan);
end;

procedure TfrmCadBandeiraEmpresa.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrSelec: TConsultasArray;
begin
  inherited;
  chrKey := '/';
  If fPesqBandeiraEmpresa(Self, Nil, Nil, qryTabela, chrKey, arrSelec) Then
  Begin
    dbeCorBanChange(dbeCorBan);

    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadBandeiraEmpresa.dbeCorBanChange(Sender: TObject);
  Var
    strColor : String;
begin
  inherited;

  Try

    If TDBEditFocus(Sender).Field = Nil Then
      Exit;

    If qryTabela.IsEmpty Then
    Begin
      TDBEditFocus(Sender).Color      := clWindow;
      TDBEditFocus(Sender).NormalColor:= clWindow;
      TDBEditFocus(Sender).FocusColor := clWindow;
      TDBEditFocus(Sender).Font.Color := clBlack;
    End
    Else
    Begin
      strColor := TDBEditFocus(Sender).Field.AsString;

      if not fEmptyStr(strColor) then
      Begin
        TDBEditFocus(Sender).Color      := StrToIntDef(strColor,0);
        TDBEditFocus(Sender).NormalColor:= StrToIntDef(strColor,0);
        TDBEditFocus(Sender).FocusColor := StrToIntDef(strColor,0);
        TDBEditFocus(Sender).Font.Color := StrToIntDef(strColor,0);
      End
      else
      begin
        TDBEditFocus(Sender).Color      := clWindow;
        TDBEditFocus(Sender).NormalColor:= clWindow;
        TDBEditFocus(Sender).FocusColor := clWindow;
        TDBEditFocus(Sender).Font.Color := clBlack;
      end;
    End;
  except

  End;
end;

procedure TfrmCadBandeiraEmpresa.dtsTabelaDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;

  if Field = dbeCorBan.Field then
    dbeCorBanChange(dbeCorBan);
end;

procedure TfrmCadBandeiraEmpresa.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadBandeiraEmpresa.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela         := 'EMPBAN';
  strNomeCampo          := 'BAN_CODBAN';

  qryTabela             := fCriaQuery(Self);
  dtsTabela.DataSet     := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0]     := dbeCodBan;
end;

function TfrmCadBandeiraEmpresa.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodBan) Then
    Begin

      If (fEmptyStr(dbeCodBan.Text)) And (dbeCodBan.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Bandeira deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;

    End

    Else If (Sender = dbeDesBan) Then
    Begin
      If fEmptyStr(dbeDesBan.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição da Bandeira deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadBandeiraEmpresa.lblCorBanClick(Sender: TObject);
begin
  inherited;

  If Not (qryTabela.State in dsEditModes) Then
    Exit;

  cldCores.Color := StrToIntDef(TDBEditFocus(TLabel(Sender).FocusControl).Field.AsString,0);
  If (cldCores.Execute) Then
  Begin
    TDBEditFocus(TLabel(Sender).FocusControl).Field.AsString := IntToStr(cldCores.Color);
  End;

end;

procedure TfrmCadBandeiraEmpresa.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
end;



end.
