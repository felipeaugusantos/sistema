unit untCadOcorrencias;

interface

uses
  Windows, Classes, Controls, Forms, untTypesSistema,
  untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  Mask, DBCtrls, DBEditFocus, DB, Uni, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, Sysutils, QColorLabel;

type
  TfrmCadOcorrencias = class(TfrmPaiCad)
    pnlCentral: TPanel;
    lbl2: TLabel;
    lbl3: TLabel;
    dbeDesOco: TDBEditFocus;
    dbeCodOco: TDBEditFocus;
    dtsCadOco: TDataSource;
    lblLegendaSituacao: TColorLabel;
    dbeSituac: TDBEditFocus;
    lblSituacao: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    qryCadOco: TUniQuery;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses untFuncoesSimples, untConsultas;

{$R *.dfm}

procedure TfrmCadOcorrencias.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodOco, dbeDesOco, False);
end;

procedure TfrmCadOcorrencias.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadOcorrencias.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadOcorrencias.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadOcorrencias.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadOcorrencias.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodOco, dbeDesOco, False)
  Else
    pHabilitaCodigo(dbeCodOco, dbeDesOco, True);

  qryTabela.FieldByName('OCO_SITUAC').AsString := 'A';
end;

procedure TfrmCadOcorrencias.btnPesquisaClick(Sender: TObject);
  var
    chrKey: Char;
    arrOcor: TConsultasArray;
begin
  {********************************}
  {* NOVA CONSULTA DE OCORRÊNCIAS *}
  {*****************************RV*}
  chrKey := '/';
  If fPesqOcorrencia(Self, Nil, Nil, qryTabela, chrKey, arrOcor, True, False) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadOcorrencias.FormCreate(Sender: TObject);
var
  strSQL: String;
begin
  inherited;
  strNomeTabela     := 'CADOCO';
  strNomeCampo      := 'OCO_CODOCO';

  strSQL            := 'SELECT * FROM CADOCO';
  qryCadOco         := fCriarQuery(strSQL, Self);
  qryTabela         := qryCadOco;
  dtsCadOco.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodOco;
end;

function TfrmCadOcorrencias.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = dbeCodOco) Then
  Begin
    If (fEmptyStr(dbeCodOco.Text)) And (dbeCodOco.Enabled) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Código da Ocorrência deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (blnBuscaPorChave) Then
    Begin
      If Not fBuscaPorCamposChave Then
        pLimparCampos;
    End;
  End

  Else If (Sender = dbeDesOco) Then
  Begin
    If fEmptyStr(dbeDesOco.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Descrição da Ocorrência deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
    If (Length(dbeDesOco.Text) < 15) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Descrição da Ocorrência deve ter no mínimo 15 caracteres!', ['&Ok']);
      Result := False;
    End;
  End
  Else If (Sender = dbeSituac) Then
  Begin
    If fEmptyStr(dbeSituac.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A situação deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else
    If (Pos(dbeSituac.Text, 'A_I_') <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'A situação deve ser preenchida com A ou I!', ['&Ok']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadOcorrencias.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('OCO_CODOCO');
  stlCampos.Add('OCO_DESOCO');
  stlCampos.Add('OCO_SITUAC');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('OCO_DESOCO');
  stlCamInd.Add('OCO_CODOCO');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

end.
