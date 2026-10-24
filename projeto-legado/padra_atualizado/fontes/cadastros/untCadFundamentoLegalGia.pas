unit untCadFundamentoLegalGia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.AppEvnts, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls, DBEditFocus, Data.DB, MemDS,
  DBAccess, Uni, frxClass, frxExportCSVTestabilidade, Vcl.Menus, Vcl.ComCtrls,
  BitBtnLockedIncrem, untTypesSistema;

type
  TfrmCadFundamentoLegalGia = class(TfrmPaiCad)
    dtsTabela: TDataSource;
    pnlCentral: TPanel;
    Label1: TLabel;
    dbeDescricaoFundamentoLegal: TDBEditFocus;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    qryCadFul: TUniQuery;
  protected
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

var
  frmCadFundamentoLegalGia: TfrmCadFundamentoLegalGia;

implementation

uses untFuncoesSimples, untConsultas, untFuncoes;

{$R *.dfm}

procedure TfrmCadFundamentoLegalGia.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFornecedores.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadFundamentoLegalGia.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadFundamentoLegalGia.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadFundamentoLegalGia.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeDescricaoFundamentoLegal);
end;

procedure TfrmCadFundamentoLegalGia.btnPesquisaClick(Sender: TObject);
  var
    chrKey: Char;
    arrConsulta: TConsultasArray;
begin
  chrKey := '/';
  If fPesqFundamentoLegalGIA(Self, qryTabela, chrKey, arrConsulta) Then
  Begin
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadFundamentoLegalGia.FormCreate(Sender: TObject);
var
  strSQL: String;
begin
  inherited;
  strNomeTabela := 'CADFUL';
  strNomeCampo  := 'AUTOINCREM';

  strSQL            := 'SELECT * FROM CADFUL';
  qryCadFul         := fCriarQuery(strSQL, Self);
  qryTabela         := qryCadFul;
  dtsTabela.DataSet := qryTabela;
end;

procedure TfrmCadFundamentoLegalGia.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;

  stlCampos.Add('FUL_DESFUL');
  stlCampos.Add('AUTOINCREM');
  stlCamInd.Add('FUL_DESFUL');
  stlCamInd.Add('AUTOINCREM');
end;

end.
