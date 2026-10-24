unit untCadFuncoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB;

type
  TfrmCadFuncoes = class(TfrmPaiCad)
    pnlDados: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeCodFnc: TDBEditFocus;
    dbeNomFnc: TDBEditFocus;
    dtsCadFnc: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadFuncoes: TfrmCadFuncoes;

implementation

uses
  untFuncoesSimples, untTypesSistema, untConsultas, untGravando, untControlePagtoFunc;

{$R *.dfm}

procedure TfrmCadFuncoes.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodFnc, dbeNomFnc, False);
end;

procedure TfrmCadFuncoes.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFuncoes.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadFuncoes.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[TfrmCadFuncoes.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadFuncoes.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodFnc, dbeNomFnc, False)
  Else
    pHabilitaCodigo(dbeCodFnc, dbeNomFnc, True);

  qryTabela.FieldByName('FNC_ATUALI').AsString := 'S';
  qryTabela.FieldByName('FNC_CODEMP').AsString := fRetEmpresaFisica;
end;

procedure TfrmCadFuncoes.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrFnc: TConsultasArray;
begin
  inherited;
  chrKey := '/';
  If fPesqFuncoes(Self, Nil, Nil, qryTabela, chrKey, arrFnc) Then
  Begin
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadFuncoes.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'CADFNC';
  strNomeCampo  := 'FNC_CODFNC';
  qryTabela     := fCriarQuery('SELECT * FROM CADFNC', Self);

  dtsCadFnc.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodFnc;
end;

procedure TfrmCadFuncoes.FormShow(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(TCadFun.CriaNovosRegistrosDeFuncoes, 'Aguarde... Atualizando registros de versões  anteriores.', '');
  If TCadFun.ExistemFuncoesCadastradasNaFormaAntiga Then
    TfrmGravando.fExecutarModal(TCadFun.CorrigeCadastroDeFuncoes, 'Aguarde... Atualizando registros de versões anteriores.', '');
end;

function TfrmCadFuncoes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
 Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeNomFnc) Then
    Begin
      If fEmptyStr(dbeNomFnc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição da Função deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadFuncoes.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('FNC_CODFNC');
  stlCampos.Add('FNC_NOMFNC');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('FNC_NOMFNC');
  stlCamInd.Add('FNC_CODFNC');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código Função');
end;

end.
