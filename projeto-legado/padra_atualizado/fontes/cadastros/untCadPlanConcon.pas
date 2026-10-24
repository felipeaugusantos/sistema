unit untCadPlanConcon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, frxClass, frxExportCSVTestabilidade, AppEvnts, Menus,
  StdCtrls, ComCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxDBEdit, Mask,
  DBCtrls, DBEditFocus, DB, Uni, MaskEditFocus, untMskC_G_C_;

type
  TfrmCadPlanConCon = class(TfrmPaiCad)
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label9: TLabel;
    edtCodPlan: TDBEditFocus;
    edtNivel: TDBEditFocus;
    edtNome: TDBEditFocus;
    Label3: TLabel;
    Label5: TLabel;
    edtCodCorrelacionado: TDBEditFocus;
    Label6: TLabel;
    Label7: TLabel;
    edtCodNcm: TDBEditFocus;
    dsPlaCon: TDataSource;
    lcbCodNat: TDBLookupComboBox;
    dsCodigoNatureza: TDataSource;
    lcbIndicador: TDBLookupComboBox;
    dsIndicador: TDataSource;
    mskEdtCnpj: TMaskEditC_G_C_;
    edtCodEmp: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
  private
    qryCodNat: TUniQuery;
    qryIndicador: TUniQuery;

    procedure pCarregaDadosComboBox;
    procedure pLimpaCampos;
  public
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema, System.MaskUtils;

{$R *.dfm}

procedure TfrmCadPlanConCon.btnCancelaClick(Sender: TObject);
begin
  inherited;
  if qryTabela.IsEmpty then
    mskEdtCnpj.Clear
  else
    mskEdtCnpj.Text := qryTabela.FieldByName('CON_C_G_C_').AsString;
end;

procedure TfrmCadPlanConCon.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadPlanConCon.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  if qryTabela.IsEmpty then
    mskEdtCnpj.Clear
  else
    mskEdtCnpj.Text := qryTabela.FieldByName('CON_C_G_C_').AsString;

end;

procedure TfrmCadPlanConCon.btnGravarClick(Sender: TObject);
begin


  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    qryTabela.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PLACON', VS_strCodEmp);
    qryTabela.FieldByName('CON_CODEMP').AsString := VS_strCodEmp;
    qryTabela.FieldByName('CON_DTAINC').AsDateTime := VS_Date;
    qryTabela.FieldByName('CON_C_G_C_').AsString := mskEdtCnpj.Text;
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadPlanConCon.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadPlanConCon.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNome);
  pLimpaCampos;
end;

procedure TfrmCadPlanConCon.btnPesquisaClick(Sender: TObject);
  var
    chrKey: Char;
    arrConsulta: TConsultasArray;
begin
  chrKey := '/';
  If fPesqPlanoContasContabil(Self, nil, nil, qryTabela, chrKey, arrConsulta) Then
  Begin
    mskEdtCnpj.Text := qryTabela.FieldByName('CON_C_G_C_').AsString;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadPlanConCon.FormCreate(Sender: TObject);
begin
  inherited;

  qryCodNat := fCriaQuery(nil);
  qryIndicador := fCriaQuery(nil);

  pCarregaDadosComboBox;

  pVerificaProCod;
  pValidaProCod('PLACON');

  strNomeTabela := 'PLACON';
  strNomeCampo  := 'AUTOINCREM';

  qryTabela := fCriarQuery('SELECT * FROM PLACON WHERE FALSE ', Self);

  dsPlaCon.DataSet := qryTabela;

  SetLength(arrCamposChave, 5);
  arrCamposChave[0] := edtCodPlan;
  arrCamposChave[1] := edtCodCorrelacionado;
  arrCamposChave[2] := edtCodEmp;
  arrCamposChave[3] := edtCodNcm;
  arrCamposChave[4] := edtNivel;
end;

procedure TfrmCadPlanConCon.FormDestroy(Sender: TObject);
begin
  qryCodNat.Free;
  qryIndicador.Free;

  inherited;
end;

procedure TfrmCadPlanConCon.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

function TfrmCadPlanConCon.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadPlanConCon.pCarregaDadosComboBox;
begin
  qryCodNat.Close;
  qryCodNat.SQL.Clear;
  qryCodNat.SQL.Text := 'SELECT * FROM CADNAT';
  qryCodNat.Open;
  dsCodigoNatureza.DataSet := qryCodNat;

  qryIndicador.Close;
  qryIndicador.SQL.Clear;
  qryIndicador.SQL.Text := 'SELECT * FROM CADIND';
  qryIndicador.Open;
  dsIndicador.DataSet := qryIndicador;
end;

procedure TfrmCadPlanConCon.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;

  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CON_CODCTA');
  stlCamInd.Add('CON_CDCTAC');
  stlCamInd.Add('CON_CODEMP');
end;

procedure TfrmCadPlanConCon.pLimpaCampos;
begin
  edtCodPlan.Clear;
  edtNivel.Clear;
  edtNome.Clear;
  edtCodCorrelacionado.Clear;
  edtCodNcm.Clear;
  mskEdtCnpj.Clear;
  lcbCodNat.ListFieldIndex := 0;
  lcbIndicador.ListFieldIndex := 0;
end;

end.
