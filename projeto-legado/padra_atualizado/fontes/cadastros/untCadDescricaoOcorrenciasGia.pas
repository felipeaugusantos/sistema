unit untCadDescricaoOcorrenciasGia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.AppEvnts, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls, DBEditFocus, Data.DB,
  frxClass, frxExportCSVTestabilidade, Vcl.Menus, Vcl.ComCtrls,
  BitBtnLockedIncrem, Uni, untTypesSistema;

type
  TfrmCadDescricaoOcorrenciasGia = class(TfrmPaiCad)
    dtsTabela: TDataSource;
    pnlCentral: TPanel;
    Label1: TLabel;
    dbeDescricaoOcorrencia: TDBEditFocus;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    qryCadDoc: TUniQuery;
  protected
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

var
  frmCadDescricaoOcorrenciasGia: TfrmCadDescricaoOcorrenciasGia;

implementation

uses untFuncoesSimples, untConsultas, untFuncoes;

{$R *.dfm}

procedure TfrmCadDescricaoOcorrenciasGia.btnExcluirClick(Sender: TObject);
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

procedure TfrmCadDescricaoOcorrenciasGia.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadDescricaoOcorrenciasGia.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadDescricaoOcorrenciasGia.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeDescricaoOcorrencia);
end;

procedure TfrmCadDescricaoOcorrenciasGia.btnPesquisaClick(Sender: TObject);
  var
    chrKey: Char;
    arrConsulta: TConsultasArray;
begin
  chrKey := '/';
  If fPesqDescOcorrenciasGIA(Self, qryTabela, chrKey, arrConsulta) Then
  Begin
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadDescricaoOcorrenciasGia.FormCreate(Sender: TObject);
var
  strSQL: String;
begin
  inherited;
  strNomeTabela := 'CADDOC';
  strNomeCampo  := 'AUTOINCREM';

  strSQL            := 'SELECT * FROM CADDOC';
  qryCadDoc         := fCriarQuery(strSQL, Self);
  qryTabela         := qryCadDoc;
  dtsTabela.DataSet := qryTabela;
end;

procedure TfrmCadDescricaoOcorrenciasGia.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;

  stlCampos.Add('DOC_DESDOC');
  stlCampos.Add('AUTOINCREM');
  stlCamInd.Add('DOC_DESDOC');
  stlCamInd.Add('AUTOINCREM');
end;

end.
