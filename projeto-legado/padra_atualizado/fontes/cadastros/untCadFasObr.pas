unit untCadFasObr;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, Data.DB, untFasObr;

type
  TfrmCadFasObr = class(TfrmPaiCad)
    pnlFundo: TPanel;
    dbeCodigo: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    lblCodigo: TLabel;
    lblDescri: TLabel;
    dtsFasObr: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodigoExit(Sender: TObject);
  private
    { Private declarations }
    objFasObr: TFasObr;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses untConsultas, untTypesSistema, untFuncoesSimples, untConstantes;

procedure TfrmCadFasObr.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFasObr.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadFasObr.btnGravarClick(Sender: TObject);
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
      pnlInfo.Caption := '';
      pMensagensErro(E.Message, '[TfrmCadFasObr.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
  Begin
    pnlInfo.Caption := '';
    fRollBack;
  End;
end;

procedure TfrmCadFasObr.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

end;

procedure TfrmCadFasObr.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    chrKey: Char;
begin
  chrKey := '?';

  If fPesqFaseObra(Self,
                   nil,
                   nil,
                   qryTabela,
                   chrKey,
                   arrSel) Then
  Begin

    If fValidaCampos(dbeCodigo) Then
    Begin
      If (btnAlterar.Enabled) And (btnAlterar.Visible) Then
        pSetFocus(btnAlterar);
    End;
  End;

end;

procedure TfrmCadFasObr.dbeCodigoExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(dbeCodigo);
end;

procedure TfrmCadFasObr.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadFasObr.FormCreate(Sender: TObject);
begin
  objFasObr := TFasObr.Create(Self);

  inherited;
  strNomeTabela := 'FASOBR';
  strNomeCampo  := 'FAS_CODFAS';
  qryTabela     := objFasObr.qryTabela;

  dtsFasObr.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

function TfrmCadFasObr.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    Try

      If (Sender = dbeCodigo) Then
      Begin
        If dbeCodigo.Enabled Then objFasObr.strCodFas := dbeCodigo.Text;

        If blnBuscaPorChave Then
          fBuscaPorCamposChave;

      End

      Else If (Sender = dbeDescri) Then
        objFasObr.strDescri := dbeDescri.Text;


    Except
      On E: ExceptionAutcom Do
      Begin
        fMensagem('',E.Message,['&OK']);
        Result := False;
      End;

      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'');
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadFasObr.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('FAS_CODFAS');
  stlCampos.Add('FAS_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('FAS_DESCRI');
  stlCamInd.Add('FAS_CODFAS');

  stlDesInd.Add('Nome');
  stlDesInd.Add('Código');
end;

end.
