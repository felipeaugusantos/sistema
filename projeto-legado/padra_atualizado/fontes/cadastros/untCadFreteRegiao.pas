unit untCadFreteRegiao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls,
  Data.DB;

type
  TfrmCadFreteRegiao = class(TfrmPaiCad)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    dbeCodFre: TDBEditFocus;
    dbeNomFre: TDBEditFocus;
    dtsFreReg: TDataSource;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  end;

implementation

uses
  untConsultas, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadFreteRegiao.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodFre, dbeNomFre, False);
end;

procedure TfrmCadFreteRegiao.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFreteRegiao.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadFreteRegiao.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[TfrmCadFreteRegiao.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadFreteRegiao.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodFre, dbeNomFre, Not blnUsaProCodigo);
end;

procedure TfrmCadFreteRegiao.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
begin
  inherited;
  chrKey := '/';
  If fPesqFreteRegiao(Self, dbeCodFre, dbeNomFre, qryTabela, chrKey) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadFreteRegiao.FormCreate(Sender: TObject);
begin
  inherited;
  qryTabela := fCriaQuery(Self);
  strNomeTabela := 'FREREG';
  strNomeCampo  := 'FRE_CODFRE';

  dtsFreReg.DataSet := qryTabela;

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeCodFre;
  arrCamposChave[1] := dbeNomFre;
end;


function TfrmCadFreteRegiao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = dbeCodFre) Then
  Begin
    If (fEmptyStr(dbeCodFre.Text)) And (dbeCodFre.Enabled) Then
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

  Else If (Sender = dbeNomFre) Then
  Begin
    If fEmptyStr(dbeNomFre.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Nome deve ser preenchido!', ['&Ok']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadFreteRegiao.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('FRE_CODFRE');
  stlCampos.Add('FRE_NOMFRE');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('FRE_NOMFRE');
  stlCamInd.Add('FRE_CODFRE');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

end.
