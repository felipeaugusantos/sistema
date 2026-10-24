unit untCadSitOco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Data.DB, QColorLabel, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, EditFocus;

type
  TfrmCadSitOco = class(TfrmPaiCad)
    dtsSitOco: TDataSource;
    Panel1: TPanel;
    dbeDesSit: TDBEditFocus;
    ColorLabel22: TColorLabel;
    dbeAtivo: TDBEditFocus;
    Label4: TLabel;
    Label2: TLabel;
    dbeCodigo: TDBEditFocus;
    Label1: TLabel;
    Label5: TLabel;
    dbeCodToc: TDBEditFocus;
    edtDesTipOco: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure dbeCodTocKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean):Boolean;override;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untTypesSistema, untConsultas;

procedure TfrmCadSitOco.btnCancelaClick(Sender: TObject);
begin
  inherited;
  edtDesTipOco.Text := fRetDescTipoOcorrencia(dbeCodToc.Text);
end;

procedure TfrmCadSitOco.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadSitOco.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  if qryTabela.IsEmpty Then
    edtDesTipOco.Clear;

end;

procedure TfrmCadSitOco.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[TfrmCadSitOco.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadSitOco.btnIncluirClick(Sender: TObject);
begin
  inherited;
  edtDesTipOco.Clear;
  qryTabela.FieldByName('SIT_ATIVO_').AsString := 'S';
  pHabilitaCodigo(dbeCodigo, dbeDesSit, False);
end;

procedure TfrmCadSitOco.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
begin
  inherited;
  chrKey := '/';
  If fPesqSitOcorrencias(Self, nil, nil, qryTabela, chrKey, arrSel, True, False) Then
  Begin
    pSetFocus(btnAlterar);
    edtDesTipOco.Text := fRetDescTipoOcorrencia(dbeCodToc.Text);
  End;
end;

procedure TfrmCadSitOco.dbeCodTocKeyPress(Sender: TObject; var Key: Char);
  Var
    arrTOcorr: TConsultasArray;
begin
  {**************************************}
  {* NOVA CONSULTA TIPOS DE OCORRENCIAS *}
  {***********************************AC*}
  If fPesqTiposOcorrencias(Self, dbeCodToc, edtDesTipOco, nil, Key, arrTOcorr, True, '') Then
  Begin
    If fValidaCampos(dbeCodToc, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadSitOco.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'SITOCO';
  strNomeCampo      := 'SIT_CODSIT';
  qryTabela         := fCriarQuery(' SELECT * FROM SITOCO ', Self);
  dtsSitOco.DataSet := qryTabela;
end;

function TfrmCadSitOco.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If (Sender = dbeDesSit) Then
    Begin
      Result := not fEmptyStr(dbeDesSit.Text);
      If Not Result Then
        fMensagem('','Preencha a descrição!', ['&OK']);
    End

    Else
    If (Sender = dbeCodToc) Then
    Begin
      If fEmptyStr(dbeCodToc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Tipo de Ocorrência deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        edtDesTipOco.Text := fRetDescTipoOcorrencia(dbeCodToc.Text);
        If fEmptyStr(edtDesTipOco.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Código de Tipo de Ocorrência não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = dbeAtivo) Then
    Begin
      Result := Pos(dbeAtivo.Text, 'S_N_') > 0;
      If Not Result Then
        fMensagem('','O campo ativo deve conter "S" ou "N"!', ['&OK']);
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadSitOco.pInicializaIndices;
begin
  inherited;
  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

end.
