unit untCadCodTipoServico;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, AppEvnts, ComCtrls, StdCtrls,
  ExtCtrls, DBEditFocus, DB, Uni, untCadLote, BitBtnLockedIncrem, Mask, DBCtrls,
  Menus, Buttons, frxClass, frxExportCSVTestabilidade, DBMemoFocus, SysUtils;

type
  TfrmCadCodTipoServico = class(TfrmPaiCad)
    pnlFundo: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeCdServ: TDBEditFocus;
    dtsCadCDS: TDataSource;
    dbedescri: TDBMemoFocus;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadCodTipoServico.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCdServ, dbeDescri, False);
end;

procedure TfrmCadCodTipoServico.btnExcluirClick(Sender: TObject);
  var
    strLocCodTipoServico: string;
begin
  strLocCodTipoServico:= fCampoTabela('GROUP_CONCAT(FIS_CDSERV)', 'CADFIS', ['FIS_CDSERV'], [dbeCdServ.Text]);
  if not fEmptyStr(strLocCodTipoServico) then
    pMensagemOk('Código Tipo Serviço não pode ser excluido, pois existem Referências ' +
    'cadastradas com esse Código Tipo Serviço:' + ' ( ' + dbeCdServ.Text + ' )!')
  else
  Begin
    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

    Try
      inherited;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[untCadCodTipoServico.btnExcluirClick]');
      End;
    End;

    If blnExcluiu Then
      fCommit
    Else
      fRollBack;
  End;



end;

procedure TfrmCadCodTipoServico.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadCodTipoServico.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadCodTipoServico.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCdServ, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCdServ, dbeCdServ, True);
end;

procedure TfrmCadCodTipoServico.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrCds: TConsultasArray;
begin
  chrKey := '/';
  If fPesqCodTipoServico(Self, Nil, Nil, qryTabela, chrKey, arrCds) Then Begin
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadCodTipoServico.FormCreate(Sender: TObject);
begin
  inherited;

  blnVerificaProCod     := False;
  strNomeTabela         := 'CADCDS';
  strNomeCampo          := 'CDS_CDSERV';

  qryTabela             := fCriaQuery(Self);
  dtsCadCDS.DataSet     := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0]     := dbeCdServ;
end;

procedure TfrmCadCodTipoServico.FormShow(Sender: TObject);
begin
  inherited;

  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

procedure TfrmCadCodTipoServico.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CDS_CDSERV');
  stlCampos.Add('CDS_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CDS_DESCRI');
  stlCamInd.Add('CDS_CDSERV');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

function TfrmCadCodTipoServico.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
  Var
    strChecked: string;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCdServ) Then
    Begin
      If (fEmptyStr(dbeCdServ.Text)) And (dbeCdServ.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do tipo de serviço deve ser preenchido!', ['&Ok']);
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
      strChecked:= dbeDescri.Text;
      If fEmptyStr(strChecked) Then
      Begin
        fMensagem('ATENÇÃO!', 'A descrição do tipo de serviço deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

end.

