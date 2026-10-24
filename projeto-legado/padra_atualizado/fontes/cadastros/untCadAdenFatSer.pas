unit untCadAdenFatSer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass, untCadAdendo,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus,
  Vcl.Mask, Vcl.DBCtrls, DBEditFocus, Data.DB, DBMemoFocus, untTypesSistema, untConsultas;

type
  TfrmCadAdenFatSer = class(TfrmPaiCad)
    dtsCadAde: TDataSource;
    pnlDados: TPanel;
    lblCodigo: TLabel;
    lblDescricao: TLabel;
    lblTexto: TLabel;
    dbeCodAde: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    mmoTexto: TDBMemoFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    objCadAdendo: TCadAdendo;

  public
    { Public declarations }
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples, untConstantes;

{ TfrmPaiCad1 }

procedure TfrmCadAdenFatSer.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodAde , dbeDescri, False);
end;

procedure TfrmCadAdenFatSer.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadAtributos.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadAdenFatSer.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadAdenFatSer.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadAdenFatSer.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodAde, dbeDescri, False);
end;

procedure TfrmCadAdenFatSer.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrAdendo: TConsultasArray;
begin
  chrKey := '/';
  If fPesqCadAdendo(Self, Nil, Nil, qryTabela, chrKey, arrAdendo) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadAdenFatSer.FormCreate(Sender: TObject);
begin
  objCadAdendo := TCadAdendo.Create(Self);

  inherited;

  strNomeTabela     := 'CADADE';
  strNomeCampo      := 'ADE_CODADE';

  qryTabela         := objCadAdendo.qryTabela;
  dtsCadAde.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodAde;
end;

function TfrmCadAdenFatSer.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    Try
      If (Sender = dbeCodAde) Then
        objCadAdendo.strCodAde := dbeCodAde.Text
      Else If (Sender = dbeDescri) Then
      Begin
        objCadAdendo.strDescri := dbeDescri.Text;

        If fEmptyStr(dbeDescri.Text) Then
        Begin
          fMensagem('Atenção', 'Defina uma descrição.', ['&Ok']);
          Result := False;
        End;
      End
      Else If (Sender = mmoTexto) Then
        objCadAdendo.strTexto_ := mmoTexto.Text;
    Except
      On E: ExceptionAutCom Do
      Begin
        Result := False;
        fMensagem('',E.Message,['&Ok']);
      End;

      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '');
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadAdenFatSer.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('ADE_CODADE');
  stlCampos.Add('ADE_DESCRI');
  stlCampos.Add('ADE_TEXTO_');

  stlCamInd.Add('ADE_CODADE');
  stlCamInd.Add('ADE_DESCRI');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

end.
