unit untCadCna;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Data.DB, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, MemDS, DBAccess, Uni, ComboBoxFocus, DBComboBoxFocus, QColorLabel,
  Datasnap.DBClient, DBLookupComboBoxFocus, UniClientDataSet;

type
  TfrmCadCna = class(TfrmPaiCad)
    pnlDados: TPanel;
    dtsTabela: TDataSource;
    Label1: TLabel;
    dbeCodCna: TDBEditFocus;
    dbeNomCna: TDBEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    cdsTipoCnae: TUniClientDataSet;
    lkbTipo: TDBLookupComboBoxFocus;
    dtsTipoCnae: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure qryTabelaAfterOpen(DataSet: TDataSet);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    procedure pAtribuiMascara;
    procedure PopulaTipos;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadCna: TfrmCadCna;

implementation

{$R *.dfm}

uses
  untTypesSistema, untConsultas, untFuncoesSimples;

procedure TfrmCadCna.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodCna, dbeNomCna, False);
end;

procedure TfrmCadCna.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadCna.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadCna.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadCna.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadCna.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodCna, dbeCodCna, not blnUsaProCodigo);
  if qryTabela.State in dsEditModes then
    lkbTipo.Field.AsString := 'SC';
end;

procedure TfrmCadCna.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
  arrSelec: TConsultasArray;
  blnRetornoPesquisa: Boolean;
begin
  inherited;
  chrKey := '/';
  blnRetornoPesquisa := fPesqCNAE(conSimples,
                                  Self,
                                  dbeCodCna,
                                  Nil,
                                  qryTabela,
                                  chrKey,
                                  arrSelec,
                                  True,
                                  'Consulta Tabela CNAE',
                                  False);

  If blnRetornoPesquisa Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadCna.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadCna.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela         := 'CADCNA';
  strNomeCampo          := 'CNA_CODCNA';

  qryTabela             := fCriaQuery(Self);
  qryTabela.AfterOpen   := qryTabelaAfterOpen;
  dtsTabela.DataSet     := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0]     := dbeCodCna;

  PopulaTipos;
end;

function TfrmCadCna.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodCna) Then
    Begin
      If (fEmptyStr(dbeCodCna.Text)) And (dbeCodCna.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do CNAE deve ser preenchido!', ['&Ok']);
        pSetFocus(dbeCodCna);
        Result := False;
      End
      else if Length(Trim(dbeCodCna.Text)) <> 7 then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do CNAE informado é inválido!', ['&Ok']);
        pSetFocus(dbeCodCna);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End
    End

    Else If (Sender = dbeNomCna) Then
    Begin
      If fEmptyStr(dbeNomCna.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Nome do CNAE deve ser preenchido!', ['&Ok']);
        pSetFocus(dbeNomCna);
        Result := False;
      End
    End

    Else If (Sender = lkbTipo) Then
    Begin
      If fEmptyStr(lkbTipo.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Tipo do CNAE deve ser preenchido!', ['&Ok']);
        pSetFocus(lkbTipo);
        Result := False;
      End;
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadCna.pAtribuiMascara;
const
  strMASCARA_CNAE = '9999-9/99;0;_';
begin
  if (Assigned(qryTabela.FindField(strNomeCampo))) and
     (TStringField(qryTabela.FieldByName(strNomeCampo)).EditMask <> strMASCARA_CNAE) then
  begin
    TStringField(qryTabela.FieldByName(strNomeCampo)).EditMask := strMASCARA_CNAE;
  end;
end;

procedure TfrmCadCna.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CNA_CODCNA');
  stlCampos.Add('CNA_NOMCNA');
  stlCampos.Add('CNA_TIPCNA');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CNA_CODCNA');
  stlCamInd.Add('CNA_NOMCNA');

  stlDesInd.Add('Código');
  stlDesInd.Add('Nome');
end;

procedure TfrmCadCna.PopulaTipos;
begin
  cdsTipoCnae.CreateDataSet;
  cdsTipoCnae.EmptyDataSet;
  cdsTipoCnae.AppendRecord(['DI', 'DI - DIVISÃO']);
  cdsTipoCnae.AppendRecord(['GR', 'GR - GRUPO']);
  cdsTipoCnae.AppendRecord(['CL', 'CL - CLASSE']);
  cdsTipoCnae.AppendRecord(['SC', 'SC - SUBCLASSE']);
end;

procedure TfrmCadCna.qryTabelaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  pAtribuiMascara;
end;

end.
