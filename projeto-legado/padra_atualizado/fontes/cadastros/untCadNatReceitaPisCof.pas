unit untCadNatReceitaPisCof;

interface

uses
  Classes, Controls, Forms, StdCtrls, untPaiCad, ComCtrls, ExtCtrls, DBCtrls,
  DBEditFocus, Menus, AppEvnts, cxHint, DB, Uni, Buttons, BitBtnLockedIncrem, EditFocus,
  dxScreenTip, cxClasses, dxCustomHint, Mask, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCadNatReceitaPisCof = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDesNat: TDBEditFocus;
    Label2: TLabel;
    pnlFundo: TPanel;
    HintControler: TcxHintStyleController;
    dtsCadNre: TDataSource;
    Label18: TLabel;
    dbeAlqPis: TDBEditFocus;
    Label6: TLabel;
    dbeAlqCof: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGravarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    qryCadNre: TUniQuery;
    procedure pAfterScroll(Dataset: TDataset);
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses SysUtils, StrUtils, untFuncoesSimples, untPai, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadNatReceitaPisCof.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela         := 'CADNRE';
  strNomeCampo          := 'NRE_CODNAT';

  qryCadNre             := fCriaQuery(Self);
  qryTabela             := qryCadNre;
  dtsCadNre.DataSet     := qryTabela;

  qryTabela.AfterScroll := pAfterScroll;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0]     := dbeCodigo;
end;

function TfrmCadNatReceitaPisCof.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Natureza da Receita de PIS e COFINS deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeDesNat) Then
    Begin
      If fEmptyStr(dbeDesNat.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição da Natureza da Receita de PIS e COFINS deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeAlqPis) Then
    Begin
      If fStrToFloat(dbeAlqPis.Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Alíquota de PIS deve ser maior ou igual a zero!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeAlqCof) Then
    Begin
      If fStrToFloat(dbeAlqCof.Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Alíquota de COFINS deve ser maior ou igual a zero!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadNatReceitaPisCof.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NRE_CODNAT');
  stlCampos.Add('NRE_DESNAT');
  stlCampos.Add('NRE_ALQPIS');
  stlCampos.Add('NRE_ALQCOF');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NRE_DESNAT');
  stlCamInd.Add('NRE_CODNAT');
  
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

procedure TfrmCadNatReceitaPisCof.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeCodigo, True);
end;

procedure TfrmCadNatReceitaPisCof.btnPesquisaClick(Sender: TObject);
var
  chrKey: Char;
  arrNatRec: TConsultasArray;
begin
  chrKey := '/';
  If fPesqNatReceitaPisCof(Self, Nil, Nil, qryTabela, chrKey, arrNatRec) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadNatReceitaPisCof.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDesNat, False);
end;

procedure TfrmCadNatReceitaPisCof.FormShow(Sender: TObject);
begin
  inherited;

  If btnIncluir.Enabled Then
    pSetFocus(btnIncluir);
end;

procedure TfrmCadNatReceitaPisCof.pAfterScroll(Dataset: TDataset);
begin
  TFloatField(Dataset.FieldByName('NRE_ALQPIS')).DisplayFormat := '#,####0.0000';
  TFloatField(Dataset.FieldByName('NRE_ALQPIS')).EditFormat    := '#,####0.0000';

  TFloatField(Dataset.FieldByName('NRE_ALQCOF')).DisplayFormat := '#,####0.0000';
  TFloatField(Dataset.FieldByName('NRE_ALQCOF')).EditFormat    := '#,####0.0000';

  If Dataset.State = dsBrowse Then
    HintControler.HideHint;
end;

procedure TfrmCadNatReceitaPisCof.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadNatReceitaPisCof.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  HintControler.HideHint;

  inherited;

  If (Action <> CaNone) Then
    qryTabela.AfterScroll := Nil;
end;

procedure TfrmCadNatReceitaPisCof.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadNatReceitaPisCof.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadNatReceitaPisCof.btnGravarClick(Sender: TObject);
begin
  blnGravou := False;

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
      pMensagensErro(E.Message, '[untCadNatReceitaPisCof.btnGravarClick]');
    End;
  End;

  Try
    If blnGravou Then
    Begin
      fCommit;
    End
    Else If Not blnGravou Then
    Begin
      fRollBack;
      pnlInfo.Caption := '';
    End;
  Except
    fRollBack;
    pnlInfo.Caption := '';
  End;
end;

end.

