unit untSacMotivosAtend;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.StdCtrls, Vcl.Mask, Uni,
  Vcl.DBCtrls, DBEditFocus, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls,
  Data.DB;

type
  TfrmSacMotivosAtend = class(TfrmPaiCad)
    pnlFundo: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeDescri: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    chkDigInf: TDBCheckBox;
    dtsMotAte: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    qryMotAte: TUniQuery;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untTypesSistema;

procedure TfrmSacMotivosAtend.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
end;

procedure TfrmSacMotivosAtend.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmSacMotivosAtend.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmSacMotivosAtend.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[TfrmSacMotivosAtend.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmSacMotivosAtend.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  chkDigInf.Field.Value := 'N';

end;

procedure TfrmSacMotivosAtend.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrMotiv: TConsultasArray;
begin
//  inherited;

  chrKey := '/';
  If fPesqMotivosAtend(Self, Nil, Nil, qryTabela, chrKey, arrMotiv) Then
    pSetFocus(btnAlterar);

end;

procedure TfrmSacMotivosAtend.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmSacMotivosAtend.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela         := 'MOTATE';
  strNomeCampo          := 'MOT_CODMOT';

  qryMotAte             := fCriaQuery(Self);
  qryTabela             := qryMotAte;
  dtsMotAte.DataSet     := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0]     := dbeCodigo;
end;

function TfrmSacMotivosAtend.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        pMensagemOk('O Código do Motivo de Atendimento deve ser preenchido!');
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        pMensagemOk('A Descrição do Motivo de Atendimento deve ser preenchida!');
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmSacMotivosAtend.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('MOT_CODMOT');
  stlCampos.Add('MOT_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('MOT_DESCRI');
  stlCamInd.Add('MOT_CODMOT');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

end.
