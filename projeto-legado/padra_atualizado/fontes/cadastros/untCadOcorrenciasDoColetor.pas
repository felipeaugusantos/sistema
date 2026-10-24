unit untCadOcorrenciasDoColetor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass, Uni,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB, untFuncoesSimples, untTypesSistema, untConsultas;

type
  TfrmCadOcorrenciasDoColetor = class(TfrmPaiCad)
    Panel1: TPanel;
    lblCODIGO: TLabel;
    dbeCodigo: TDBEditFocus;
    lblDESCRI: TLabel;
    dbeDescri: TDBEditFocus;
    dtsCadOcc: TDataSource;
    rdgTipoOperacao: TDBRadioGroup;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    qryCadOcc: TUniQuery;
  protected
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

var
  frmCadOcorrenciasDoColetor: TfrmCadOcorrenciasDoColetor;

implementation

{$R *.dfm}

procedure TfrmCadOcorrenciasDoColetor.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
end;

procedure TfrmCadOcorrenciasDoColetor.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadOcorrenciasDoColetor.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadOcorrenciasDoColetor.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadOcorrenciasDoColetor.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadOcorrenciasDoColetor.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeDescri, True);

  qryTabela.FieldByName('OCC_TIPOCO').AsString := 'CN';
end;

procedure TfrmCadOcorrenciasDoColetor.btnPesquisaClick(Sender: TObject);
  var
    chrKey: Char;
    arrOcor: TConsultasArray;
begin
  chrKey := '/';
  If fPesqOcorrenciaDoColetor(Self, Nil, Nil, qryTabela, chrKey, arrOcor, True) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadOcorrenciasDoColetor.FormCreate(Sender: TObject);
var
  strSQL: String;
begin
  inherited;
  strNomeTabela     := 'CADOCC';
  strNomeCampo      := 'OCC_CODIGO';

  strSQL            := 'SELECT * FROM CADOCC';
  qryCadOcc         := fCriarQuery(strSQL, Self);
  qryTabela         := qryCadOcc;
  dtsCadOcc.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

function TfrmCadOcorrenciasDoColetor.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = dbeCodigo) Then
  Begin
    If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Código da Ocorrência do Coletor deve ser preenchido!', ['&Ok']);
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
      fMensagem('ATENÇÃO!', 'A Descrição da Ocorrência do Coletor deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
    If (Length(dbeDescri.Text) < 15) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Descrição da Ocorrência do Coletor deve ter no mínimo 15 caracteres!', ['&Ok']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadOcorrenciasDoColetor.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('OCC_CODIGO');
  stlCampos.Add('OCC_DESCRI');
  stlCampos.Add('OCC_TIPOCO');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('OCC_DESCRI');
  stlCamInd.Add('OCC_CODIGO');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

end.
