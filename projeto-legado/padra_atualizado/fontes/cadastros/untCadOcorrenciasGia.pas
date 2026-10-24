unit untCadOcorrenciasGia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.AppEvnts, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, cxTextEdit, cxMaskEdit, cxDBEdit, Data.DB, Uni,
  frxClass, frxExportCSVTestabilidade, Vcl.Menus, Vcl.ComCtrls,
  BitBtnLockedIncrem, untTypesSistema;

type
  TfrmCadOcorrenciasGia = class(TfrmPaiCad)
    dtsCadOcr: TDataSource;
    dtsDescricaoFundamentoLegal: TDataSource;
    dtsDescricaoOcorrencia: TDataSource;
    pnlCentral: TPanel;
    Label5: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label18: TLabel;
    mskDtaMes: TcxDBMaskEdit;
    rgIndicaOperacaoPropriaOuSt: TRadioGroup;
    edtCodSubIte: TDBEditFocus;
    edtValSubIte: TDBEditFocus;
    lcbFundamentoLegal: TDBLookupComboBox;
    lcbDescricaoOcorrencia: TDBLookupComboBox;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dtsCadOcrStateChange(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    FstrAutoIncrem: String;
    qryCadOcr: TUniQuery;
    qryFundamentoLegal: TUniQuery;
    qryDescricaoOcorrencia: TUniQuery;

    procedure pFormataCampos;

  protected
    procedure pInicializaIndices; override;
  public
    { Public declarations }
    function fAutoIncrem(strAutoIncrem: String): TfrmCadOcorrenciasGia;
    function fConsultar : TfrmCadOcorrenciasGia;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadOcorrenciasGia: TfrmCadOcorrenciasGia;

implementation

uses untFuncoesSimples, untConsultas, untFuncoes;

{$R *.dfm}

{ TfrmCadOcorrenciasGia }

procedure TfrmCadOcorrenciasGia.btnExcluirClick(Sender: TObject);
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

procedure TfrmCadOcorrenciasGia.btnGravarClick(Sender: TObject);
begin

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    qryTabela.FieldByName('OCR_CODEMP').AsString := VS_strCodEmp;
    qryTabela.FieldByName('OCR_PROPST').AsInteger := rgIndicaOperacaoPropriaOuSt.ItemIndex;
    qryTabela.FieldByName('OCR_SEQFIS').AsString := FstrAutoIncrem;
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadOcorrenciasGia.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadOcorrenciasGia.pFormataCampos;
begin
  TFloatField(qryTabela.FieldByName('OCR_VALITE')).EditFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('OCR_VALITE')).DisplayFormat := '#,##0.00';
end;

procedure TfrmCadOcorrenciasGia.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaMes);
end;

procedure TfrmCadOcorrenciasGia.btnPesquisaClick(Sender: TObject);
  var
    chrKey: Char;
    arrConsulta: TConsultasArray;
begin
  chrKey := '/';
  If fPesqOcorrenciasGIA(Self, qryTabela, chrKey, arrConsulta) Then
  Begin
    rgIndicaOperacaoPropriaOuSt.ItemIndex := qryTabela.FieldByName('OCR_PROPST').AsInteger;
    pFormataCampos;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadOcorrenciasGia.dtsCadOcrStateChange(Sender: TObject);
begin
  inherited;
  rgIndicaOperacaoPropriaOuSt.Enabled := dtsCadOcr.State in [dsInsert, dsEdit];
end;

procedure TfrmCadOcorrenciasGia.FormCreate(Sender: TObject);
var
  strSQL: String;
begin
  inherited;
  strNomeTabela := 'CADOCR';
  strNomeCampo  := 'AUTOINCREM';

  strSQL            := 'SELECT * FROM CADOCR';
  qryCadOcr         := fCriarQuery(strSQL, Self);
  qryTabela         := qryCadOcr;
  dtsCadOcr.DataSet := qryTabela;
end;

procedure TfrmCadOcorrenciasGia.FormShow(Sender: TObject);
begin
  inherited;

  qryFundamentoLegal := fCriarQuery('SELECT * FROM CADFUL', Self);
  dtsDescricaoFundamentoLegal.DataSet := qryFundamentoLegal;
  qryFundamentoLegal.Open;

  qryDescricaoOcorrencia := fCriarQuery('SELECT * FROM CADDOC', Self);
  dtsDescricaoOcorrencia.DataSet := qryDescricaoOcorrencia;
  qryDescricaoOcorrencia.Open;

  pFormataCampos;
end;

function TfrmCadOcorrenciasGia.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If Sender = edtValSubIte Then
    Begin
      If fStrToFloat(edtValSubIte.Text) <= 0 Then
      Begin
        fMensagem('', 'Valor do item deve ser maior que zero!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadOcorrenciasGia.pInicializaIndices;
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;

  stlCampos.Add('AUTOINCREM');
  stlCampos.Add('OCR_CODEMP');
  stlCampos.Add('OCR_CODITE');
  stlCampos.Add('OCR_DTAOCR');
  stlCampos.Add('OCR_FLAITE');
  stlCampos.Add('OCR_OCORRE');
  stlCampos.Add('OCR_PROPST');
  stlCampos.Add('OCR_VALITE');

  stlCamInd.Add('AUTOINCREM');
  stlCamInd.Add('OCR_DTAOCR');
  stlCamInd.Add('OUT_MESANO');
end;

function TfrmCadOcorrenciasGia.fConsultar: TfrmCadOcorrenciasGia;
begin
  Result := Self;
  qryCadOcr.SQL.Clear;
  qryCadOcr.SQL.Text := 'SELECT * FROM CADOCR WHERE OCR_SEQFIS = ' + FstrAutoIncrem.QuotedString;
  qryCadOcr.Open;
end;

function TfrmCadOcorrenciasGia.fAutoIncrem(
  strAutoIncrem: String): TfrmCadOcorrenciasGia;
begin
  Result := Self;
  FstrAutoIncrem := strAutoIncrem;
end;



end.
