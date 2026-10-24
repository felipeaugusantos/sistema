unit untCadLocFisAmostraProducao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Data.DB, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus;

type
  TfrmCadLocFisAmostraProducao = class(TfrmPaiCad)
    Panel1: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeDescri: TDBEditFocus;
    dbeLocFis: TDBEditFocus;
    dtsLocOrP: TDataSource;
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
  public
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean):Boolean;Override;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untTypesSistema, untConsultas;

{ TfrmCadLocFisAmostraProducao }

procedure TfrmCadLocFisAmostraProducao.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeLocFis);
end;

procedure TfrmCadLocFisAmostraProducao.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadLocFisAmostraProducao.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadLocFisAmostraProducao.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[TfrmCadLocFisAmostraProducao.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadLocFisAmostraProducao.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeLocFis);
end;

procedure TfrmCadLocFisAmostraProducao.btnPesquisaClick(Sender: TObject);
  Var
    chrKey : Char;
    arrSel: TConsultasArray;
begin
  inherited;
  chrKey := '/';
  If fPesqLocFisAmostraProducao(Self, dbeLocFis, dbeDescri, qryTabela, chrKey, arrSel) Then
    pSetFocus(btnAlterar);

end;

procedure TfrmCadLocFisAmostraProducao.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'LOCORP';
  strNomeCampo      := 'LOP_LOCFIS';
  qryTabela         := fCriarQuery(' SELECT * FROM LOCORP', Self);
  dtsLocOrP.DataSet := qryTabela;
end;

function TfrmCadLocFisAmostraProducao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If (Sender = dbeLocFis) Then
    Begin
      Result := not fEmptyStr(dbeLocFis.Text);

      If Not Result Then
        fMensagem('','Preenchimento obrigatório!', ['&Ok']);

    End

    Else
    If (Sender = dbeDescri) Then
    Begin
      Result := not fEmptyStr(dbeDescri.Text);

      If Not Result Then
        fMensagem('','Preenchimento obrigatório!', ['&Ok']);
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadLocFisAmostraProducao.pInicializaIndices;
begin
  inherited;
  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeLocFis;
end;

end.
