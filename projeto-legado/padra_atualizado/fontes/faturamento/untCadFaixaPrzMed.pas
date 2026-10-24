unit untCadFaixaPrzMed;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, DB;

type
  TfrmCadFaixaPrzMed = class(TfrmPaiCad)
    dbeCodIni: TDBEditFocus;
    lblPrzMedIni: TLabel;
    dbeCodFin: TDBEditFocus;
    lblPrzMedFin: TLabel;
    dbeCodMax: TDBEditFocus;
    lblPrzMedMax: TLabel;
    lblCodigo: TLabel;
    dbeCodigo: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    dtsTabela : TDataSource;
  public
    { Public declarations }
  Protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean):Boolean; Override;
  end;

implementation

{$R *.dfm}

uses untTypesSistema, untConsultas, untFuncoesSimples;

procedure TfrmCadFaixaPrzMed.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFaixaPrzMed.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  qryTabela.Close;

  dbeCodIni.Clear;
  dbeCodFin.Clear;
  dbeCodMax.Clear;

end;

procedure TfrmCadFaixaPrzMed.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[TfrmCadFaixaPrzMed.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadFaixaPrzMed.btnIncluirClick(Sender: TObject);
begin

  dbeCodIni.Clear;
  dbeCodFin.Clear;
  dbeCodMax.Clear;

  inherited;

  pSetFocus(dbeCodIni);

end;

procedure TfrmCadFaixaPrzMed.btnPesquisaClick(Sender: TObject);
Var
  arrSel : TConsultasArray;
  Key    : Char;
Begin

  Key := '/';

  If fPesqPrzMed(Self, dbeCodigo, qryTabela, Key, arrSel) then
  Begin
    fValidaCampos(dbeCodigo, False);
    pSetFocus(btnAlterar);
  End;

End;

procedure TfrmCadFaixaPrzMed.FormCreate(Sender: TObject);
Var
  intIndex : Integer;
Begin

  qryTabela := fCriaQuery(Self);
  dtsTabela := fCriaDataSource(qryTabela);

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  inherited;

  strNomeTabela := 'PRZMED';
  strNomeCampo  := 'PRZ_CODIGO';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  For intIndex := 0 To Self.ControlCount -1 Do
  Begin
    if (Self.Controls[intIndex] is TDBEditFocus) Then
      TDBEditFocus(Self.Controls[intIndex]).DataSource := dtsTabela;
  End;

End;

procedure TfrmCadFaixaPrzMed.FormDestroy(Sender: TObject);
begin

  FreeAndNil(stlCampos);
  FreeAndNil(stlCamInd);
  FreeAndNil(stlDesInd);

  FreeAndNil(dtsTabela);
  FreeAndNil(qryTabela);

  inherited;

end;

procedure TfrmCadFaixaPrzMed.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadFaixaPrzMed.pInicializaIndices;
begin

  inherited;

  stlCampos.Add('AUTOINCREM');
  stlCampos.Add('PRZ_CODIGO');
  stlCampos.Add('PRZ_MEDINI');
  stlCampos.Add('PRZ_MEDFIN');
  stlCampos.Add('PRZ_MEDMAX');

  stlCamInd.Add('PRZ_CODIGO');
  stlCamInd.Add('PRZ_MEDINI');
  stlCamInd.Add('PRZ_MEDFIN');
  stlCamInd.Add('PRZ_MEDMAX');

  stlDesInd.Add('Código');
  stlDesInd.Add('Prz. Méd. Ini.');
  stlDesInd.Add('Prz. Méd. Fin.');
  stlDesInd.Add('Prz. Méd. Max.');

end;

function TfrmCadFaixaPrzMed.fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean) : Boolean;
begin

  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin

    If (Sender = dbeCodIni) Then
    Begin
      If fEmptyStr(dbeCodIni.Text) Then
      Begin
        fMensagem('', 'Prz. Méd. Ini. não informado!', ['&OK']);
        Result := False;
      End;
    End
    Else
    If (Sender = dbeCodFin) Then
    Begin
      If fEmptyStr(dbeCodFin.Text) Then
      Begin
        fMensagem('', 'Prz. Méd. Fin. não informado!', ['&OK']);
        Result := False;
      End;
    End
    Else
    If (Sender = dbeCodMax) Then
    Begin
      If fEmptyStr(dbeCodMax.Text) Then
      Begin
        fMensagem('', 'Prz. Méd. Máx. não informado!', ['&OK']);
        Result := False;
      End;
    End;

  End;

  If not Result Then
    pSetFocus(Sender);

end;

end.
