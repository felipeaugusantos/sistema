unit untCadComplVidro;

interface

uses
  Windows, Classes, Controls, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls,
  Buttons, ExtCtrls, Mask, DBCtrls, DBEditFocus, DB, Uni, untCadLote, EditFocus,
  BitBtnLockedIncrem, QColorLabel, DBMemoFocus, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCadComplVidro = class(TfrmPaiCad)
    pnlFundo: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeDescri: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    dtsCadCpl: TDataSource;
    Label8: TLabel;
    dbeFatCus: TDBEditFocus;
    Label9: TLabel;
    dbeFatVen: TDBEditFocus;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    procedure pAfterScroll(DataSet: TDataSet);
  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses SysUtils, Forms, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadComplVidro.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
end;

procedure TfrmCadComplVidro.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadComplVidro.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadComplVidro.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadComplVidro.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadComplVidro.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  If dbeCodigo.Enabled Then
    pSetFocus(dbeCodigo)
  Else
    pSetFocus(dbeDescri);
end;

procedure TfrmCadComplVidro.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrCom: TConsultasArray;
begin
  chrKey := '/';
  If fPesqComplVidro(Self, Nil, Nil, qryTabela, chrKey, arrCom) Then
    pSetFocus(btnAlterar);
 end;

procedure TfrmCadComplVidro.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela         := 'CADCPL';
  strNomeCampo          := 'CPL_CODIGO';

  qryTabela             := fCriaQuery(Self);
  qryTabela.AfterScroll := pAfterScroll;
  dtsCadCpl.DataSet     := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0]     := dbeCodigo;
end;

procedure TfrmCadComplVidro.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

procedure TfrmCadComplVidro.pAfterScroll(DataSet: TDataSet);
begin
  If DataSet.Active Then
  Begin
    TFloatField(dbeFatCus.Field).DisplayFormat := fMskDigitos(2);
    TFloatField(dbeFatVen.Field).DisplayFormat := fMskDigitos(2);
  End;
end;

procedure TfrmCadComplVidro.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CPL_CODIGO');
  stlCampos.Add('CPL_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CPL_DESCRI');
  stlCamInd.Add('CPL_CODIGO');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

function TfrmCadComplVidro.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
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
        fMensagem('ATENÇÃO!', 'A descrição deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeFatCus) Then
    Begin
      If fStrToFloat(dbeFatCus.Text) <= 0 Then
      Begin
        pMensagemOk('O Fator sobre o Preço de Custo deve ser informado corretamente!');
        Result := False;
      End;
    End

    Else If (Sender = dbeFatVen) Then
    Begin
      If fStrToFloat(dbeFatVen.Text) <= 0 Then
      Begin
        pMensagemOk('O Fator sobre o Preço de Venda deve ser informado corretamente!');
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.

