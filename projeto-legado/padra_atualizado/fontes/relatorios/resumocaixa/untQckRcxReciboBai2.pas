unit untQckRcxReciboBai2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport, RLParser, StrUtils, Uni, DB, UniClientDataSet, RLFilters,
  RLDraftFilter, Math, untFuncoesGenerica, DateUtils, Datasnap.DBClient,
  RLPreviewForm;

type
  TDocumentos = record
    rllNumDoc : TRLLabel;
    rllCodVen : TRLLabel;
    rllDtaVen : TRLLabel;
    rllDtaRec : TRLLabel;
    rllValDoc : TRLLabel;
    rllValRec : TRLLabel;
End;

type
  TCheques = record
    rllNumAge,
    rllConCor,
    rllNumChq,
    rllDtaVen,
    rllValChq,
    rllNomEmi,
    rllC_G_C_ : TRLLabel;
End;

type
  TfrmQckRcxReciboBai2 = class(TForm)
    qckPagina: TRLReport;
    rlbHeader1: TRLBand;
    rpsSetup: TRLPreviewSetup;
    rllNomEmp: TRLLabel;
    rllNomRel: TRLLabel;
    hedCabDoc: TRLBand;
    rlbFooter1: TRLBand;
    rlbAssinatura: TRLBand;
    RLExpressionParser1: TRLExpressionParser;
    rllNomCli: TRLLabel;
    rllEndCli: TRLLabel;
    rllImportancia: TRLLabel;
    rllValorExtenso: TRLLabel;
    rllParcelas: TRLLabel;
    rlbDuplicatas: TRLBand;
    RLPanel1: TRLPanel;
    rllDescri: TRLLabel;
    rllVencimento1: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel17: TRLLabel;
    RLPanel2: TRLPanel;
    RLPanel5: TRLPanel;
    RLLabel6: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel10: TRLLabel;
    rllCPFCNPJ: TRLLabel;
    rllInsEst: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    rllLocalData: TRLLabel;
    RLLabel1: TRLLabel;
    RLLabel18: TRLLabel;
    rllVencimento2: TRLLabel;
    RLLabel20: TRLLabel;
    rllImpressao: TRLLabel;
    rllTotRec: TRLLabel;
    dtsImpRec: TDataSource;
    rldMatricial: TRLDraftFilter;
    dtsCadChq: TDataSource;
    cdsCadChq: TUniClientDataSet;
    cdsCadChqCHQ_CONCOR: TStringField;
    cdsCadChqCHQ_NUMCHQ: TStringField;
    cdsCadChqCHQ_NOMEMI: TStringField;
    cdsCadChqCHQ_C_G_C_: TStringField;
    cdsCadChqCHQ_DTAVEN: TDateField;
    cdsCadChqCHQ_VALCHQ: TFloatField;
    cdsCadChqCHQ_NUMAGE: TStringField;
    RLBand3: TRLBand;
    pnlCheques: TRLPanel;
    RLPanel4: TRLPanel;
    RLLabel9: TRLLabel;
    RLLabel21: TRLLabel;
    RLLabel22: TRLLabel;
    RLLabel23: TRLLabel;
    RLLabel24: TRLLabel;
    RLLabel25: TRLLabel;
    RLLabel26: TRLLabel;
    pnlLinChe: TRLPanel;
    rllNumAge: TRLLabel;
    rllConCor: TRLLabel;
    rllNumChq: TRLLabel;
    rllDtaVen: TRLLabel;
    rllValChq: TRLLabel;
    rllNomEmi: TRLLabel;
    rllC_G_C_: TRLLabel;
    pnlDocume: TRLPanel;
    rlpColuna1: TRLPanel;
    rllNumDoc1: TRLLabel;
    rllDtaVen1: TRLLabel;
    rllValDoc1: TRLLabel;
    rllValRec1: TRLLabel;
    rlpColuna2: TRLPanel;
    rllNumDoc2: TRLLabel;
    rllDtaVen2: TRLLabel;
    rllValDoc2: TRLLabel;
    rllValRec2: TRLLabel;
    RLPanel3: TRLPanel;
    RLLabel7: TRLLabel;
    RLPanel6: TRLPanel;
    rllRelacCheques: TRLLabel;
    rll1: TRLLabel;
    rll2: TRLLabel;
    rllCodVen1: TRLLabel;
    rllCodVen2: TRLLabel;
    rllDtaRec1: TRLLabel;
    rllDtaRec2: TRLLabel;
    rlbAssinatura2: TRLBand;
    RLLabel2: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel14: TRLLabel;
    rllCPFCNPJ2: TRLLabel;
    rllInsEst2: TRLLabel;
    rllLocalData2: TRLLabel;
    rllAssinatura: TRLLabel;
    RLLabel28: TRLLabel;
    RLDraw1: TRLDraw;
    RLDraw2: TRLDraw;
    rllValCar: TRLLabel;
    rllValOrd: TRLLabel;
    rllValCre: TRLLabel;
    rllValDin: TRLLabel;
    rllValChv: TRLLabel;
    rllValChp: TRLLabel;
    rllCaixa: TRLLabel;

    procedure rllNomEmpBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel6BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel10BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel8BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllCPFCNPJBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllInsEstBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllLocalDataBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rlbDuplicatasBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure qckPaginaBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rllValorExtensoBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure rlbFooter1AfterPrint(Sender: TObject);
    procedure rlbFooter1BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rllTotRecBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel5BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure rlbHeader1BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rlbAssinaturaAfterPrint(Sender: TObject);
    procedure rllNomRelBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllImportanciaBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllParcelasBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllVencimento1BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllImpressaoBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllRelacChequesBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllRecebimento1BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllRecebimento2BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel13BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel14BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel2BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllAssinaturaBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllCPFCNPJ2BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllInsEst2BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllLocalData2BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rlbAssinatura2BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rllCaixaBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);


  private
    { Private declarations }
    intNumReg : Integer;
    blnNewPag : Boolean;
    blnNovPag : Boolean;
    rlbColuna : TRLPanel;

    intqtdLinDoc: Integer;
    intqtdLinChe: Integer;

    FPais: TPais;

    function fAdicionaRlLabels(rlpParent: TRLPanel; rllReferencia: TRLLabel; strTexto: String; blnAlinDireita: Boolean = False): TRLLabel;
    function fCriaNovaPagina: Boolean;

    Function fAdicionaRlLabelsChe(strTexto: String; rllReferencia: TRLLabel; intTop: Integer): TRLLabel;
    Procedure pAjustaPanels;
    Procedure pImprimeCheques;
    procedure pBuscaDescricaoFormaPagamento(strNumDoc, strEspDoc, strCodEmp: string);

  public
    { Public declarations }
    strCodOpe: String;
    intSeqCon: Integer;
    fltTotRec: Double;
    qryGenEmp: TUniQuery;

    cdsImpRec: TUniClientDataSet;
    intQtdReg : Integer;
    arrLabels : Array Of TDocumentos;
    arrCheques: Array Of TCheques;

    intQtdDocImp: Integer;
    intQtdCheImp: Integer;
  end;

var
  frmQckRcxReciboBai2: TfrmQckRcxReciboBai2;

implementation

uses  untfuncoesSimples, untValorPorExtenso;

{$R *.dfm}

Const
  INT_QTD_MAX_REG_COL    = 12;   // 12 LINHAS POR COLUNA
  INT_NUMERO_COLUNAS     = 2;    // NUMERO DE COLUNAS DE DOCUMENTOS

procedure TfrmQckRcxReciboBai2.rllNomEmpBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  If (qckPagina.DefaultFilter <> Nil) Then
    Text := #27 + 'W1' + 'RECIBO' + #27 + 'W0';
end;

procedure TfrmQckRcxReciboBai2.rllNomRelBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
    Text := 'HEMOS RECEBIDO'
  Else
    Text := 'RECEBEMOS';
end;

procedure TfrmQckRcxReciboBai2.rllRecebimento1BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  Text := 'REC.';
end;

procedure TfrmQckRcxReciboBai2.rllRecebimento2BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  Text := 'REC.';
end;

procedure TfrmQckRcxReciboBai2.rllRelacChequesBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
    Text := 'CHEQUES RELACION'
  Else
    Text := 'RELACAO DE CHEQUES';
end;

procedure TfrmQckRcxReciboBai2.RLLabel6BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := fRetNomeEmpresa;
end;

procedure TfrmQckRcxReciboBai2.RLLabel10BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin

  Text := qryGenEmp.FieldByName('EMP_C_E_P_').AsString + ' - ' +
          fRetNomCidade(qryGenEmp.FieldByName('EMP_CODCID').AsString) + ' - ' +
          fRetNomCidade(qryGenEmp.FieldByName('EMP_CODCID').AsString, 1);
end;

procedure TfrmQckRcxReciboBai2.RLLabel13BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  Text := qryGenEmp.FieldByName('EMP_ENDERE').AsString;
end;

procedure TfrmQckRcxReciboBai2.RLLabel14BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  Text := qryGenEmp.FieldByName('EMP_C_E_P_').AsString + ' - ' +
          fRetNomCidade(qryGenEmp.FieldByName('EMP_CODCID').AsString) + ' - ' +
          fRetNomCidade(qryGenEmp.FieldByName('EMP_CODCID').AsString, 1);
end;

procedure TfrmQckRcxReciboBai2.RLLabel2BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  Text := VS_strCodEmp + ' - ' + fRetNomeEmpresa;
end;

procedure TfrmQckRcxReciboBai2.rllImportanciaBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
    Text := 'POR ENCIMA DE LA IMPORTANCIA DE: '
  Else
    Text := 'A IMPORTANCIA ACIMA DE:'
end;

procedure TfrmQckRcxReciboBai2.RLLabel8BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := qryGenEmp.FieldByName('EMP_ENDERE').AsString;
end;

procedure TfrmQckRcxReciboBai2.rllAssinaturaBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  Text := fRetNomeOperador(strCodOpe);
end;

procedure TfrmQckRcxReciboBai2.rllCaixaBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  If (fCfgSis('SIGPAI', varString) = 'PAR') Or
     (dtsImpRec.DataSet.FieldByName('RCX_CAIXA').AsString = '') Then
    Text := ''
  Else
    Text := dtsImpRec.DataSet.FieldByName('RCX_CAIXA').AsString;
end;

procedure TfrmQckRcxReciboBai2.rllCPFCNPJ2BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
    Text := 'RUC: ' + fFormataCpfCgc(qryGenEmp.FieldByName('EMP_C_G_C_').AsString, FPais)
  Else
    Text := 'CNPJ: ' + fFormataCpfCgc(qryGenEmp.FieldByName('EMP_C_G_C_').AsString, FPais);
end;

procedure TfrmQckRcxReciboBai2.rllCPFCNPJBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
    Text := 'RUC: ' + fFormataCpfCgc(qryGenEmp.FieldByName('EMP_C_G_C_').AsString, FPais)
  Else
    Text := 'CNPJ: ' + fFormataCpfCgc(qryGenEmp.FieldByName('EMP_C_G_C_').AsString, FPais);
end;

procedure TfrmQckRcxReciboBai2.rllImpressaoBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
    Text := 'LA IMPRESION CONTINUA EN LA PAGINA SIGUIENTE'
  Else
    Text := 'IMPRESSAO CONTINUA NA PROXIMA PAGINA';
end;

procedure TfrmQckRcxReciboBai2.rllInsEst2BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
    Text := 'SEQ.BAJA: ' + IntToStr(intSeqCon)
  Else
    Text := 'INSCRICAO ESTADUAL: ' + qryGenEmp.FieldByName('EMP_I_E_S_').AsString + '                    SEQ.BAIXA: ' + IntToStr(intSeqCon);
end;

procedure TfrmQckRcxReciboBai2.rllInsEstBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
    Text := 'SEQ.BAJA: ' + IntToStr(intSeqCon)
  Else
    Text := 'INSCRICAO ESTADUAL: ' + qryGenEmp.FieldByName('EMP_I_E_S_').AsString + '                    SEQ.BAIXA: ' + IntToStr(intSeqCon);
end;

procedure TfrmQckRcxReciboBai2.rllLocalData2BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
    Text := fRetDataExtEsp(VS_Date, True)
  Else
    Text := fRetDataExtenso(VS_Date, True);
end;

procedure TfrmQckRcxReciboBai2.rllLocalDataBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
    Text := fRetDataExtEsp(VS_Date, True)
  Else
    Text := fRetDataExtenso(VS_Date, True);

end;

procedure TfrmQckRcxReciboBai2.rllVencimento1BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
    Text := 'MADUR.'
  Else
    Text := 'VENC.';
end;

function TfrmQckRcxReciboBai2.fAdicionaRlLabels(rlpParent: TRLPanel; rllReferencia: TRLLabel; strTexto: String; blnAlinDireita: Boolean = False): TRLLabel;
  Var
    rllTemp: TRLLabel;

begin

  rllTemp := TRLLabel.Create(qckPagina);
  With rllTemp Do
  Begin
    AutoSize   := False;
    Parent     := rlpParent;

    If blnAlinDireita Then
      Alignment  := taRightJustify;

    Left       := rllReferencia.Left;
    Height     := rllReferencia.Height;
    Top        := rllReferencia.Top + rllReferencia.Height + 6;
    Width      := rllReferencia.Width;
    Caption    := strTexto;
  End;

  Result := rllTemp;

end;

Function TfrmQckRcxReciboBai2.fAdicionaRlLabelsChe(strTexto: String; rllReferencia: TRLLabel; intTop: Integer): TRLLabel;
  Var
    rllTemp: TRLLabel;
begin

  rllTemp := TRLLabel.Create(Self);
  With rllTemp Do
  Begin
    AutoSize   := False;
    Parent     := pnlLinChe;
    Alignment  := rllReferencia.Alignment;
    Left       := rllReferencia.Left;
    Height     := rllReferencia.Height;
    Top        := intTop;
    Width      := rllReferencia.Width;
    Caption    := strTexto;
  End;

  Result := rllTemp;
end;


procedure TfrmQckRcxReciboBai2.rlbAssinatura2BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  pBuscaDescricaoFormaPagamento(cdsImpRec.FieldByName('NUMDOC').AsString, cdsImpRec.FieldByName('ESPDOC').AsString, cdsImpRec.FieldByName('CODEMP').AsString);
end;

procedure TfrmQckRcxReciboBai2.rlbAssinaturaAfterPrint(Sender: TObject);
begin
  If (Not pnlCheques.Visible) And (Not cdsCadChq.IsEmpty) Then
  Begin
    qckPagina.NewPage;

    pnlCheques.Visible := True;
    hedCabDoc.Visible := False;
    pnlDocume.Visible := False;
  End;
end;

procedure TfrmQckRcxReciboBai2.rlbDuplicatasBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin

  fCriaNovaPagina;

end;

procedure TfrmQckRcxReciboBai2.qckPaginaBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
  Var
    intContador : Integer;

begin

  intNumReg := 1;

  For intContador := 0 To intQtdReg-1 Do
  Begin
    FreeAndNil(arrLabels[intContador].rllNumDoc);
    FreeAndNil(arrLabels[intContador].rllCodVen);
    FreeAndNil(arrLabels[intContador].rllDtaVen);
    FreeAndNil(arrLabels[intContador].rllDtaRec);
    FreeAndNil(arrLabels[intContador].rllValDoc);
    FreeAndNil(arrLabels[intContador].rllValRec);
  End;

  For intContador := Low(ArrCheques) To High(ArrCheques) Do
  With arrCheques[intContador] Do
  Begin
    FreeAndNil(rllNumAge);
    FreeAndNil(rllConCor);
    FreeAndNil(rllNumChq);
    FreeAndNil(rllDtaVen);
    FreeAndNil(rllValChq);
    FreeAndNil(rllNomEmi);
    FreeAndNil(rllC_G_C_);
  End;

end;

procedure TfrmQckRcxReciboBai2.rllValorExtensoBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin

  If fCfgSis('SIGPAI', varString) = 'PAR' Then
    Text := FGet_Extens(FormatFloat('#,##0.00', fltTotRec), 'E')
  Else
    Text := fRetExtensoNumero(FormatFloat('#,##0.00', fltTotRec));

end;

procedure TfrmQckRcxReciboBai2.rllParcelasBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
    Text := 'RESPECT AL PAGO DE LA(S) QUOTA(S): '
  Else
    Text := 'REFERENTE AO PAGAMENTO DA(S) PARCELA(S): ';
end;

procedure TfrmQckRcxReciboBai2.FormCreate(Sender: TObject);
begin
  blnNovPag := True;

  intQtdDocImp := 0;
  intQtdCheImp := 0;

  FPais := fSetaPais;
end;

Procedure TfrmQckRcxReciboBai2.pAjustaPanels;
  Const
    INT_ALTURA_MAX_DOCS    = 208;  // 12 LINHAS POR COLUNA
    INT_NUM_LIN_CABEC_CHE  = 4;    // NUMERO DE LINHA DO CABECALHO DOS CHEQUES
  Var
    intQtdDocRes: Integer;
//    intQtdCheRes: Integer;
Begin
  intQtdDocRes := cdsImpRec.RecordCount - intQtdDocImp;
//  intQtdCheRes := cdsCadChq.RecordCount - intQtdCheImp;

                          // NAO TEM ESPAÇO PARA OS CHEQUES QUE VAO OCUPAR NO MINIMO 4 LINHAS (CABEÇALHO + 1 CHEQUE)
                          // OS CHEQUES VAO FICAR PARA A PROXIMA PAGINA  14 = 24 - (INT_NUMERO_COLUNAS * (INT_NUM_LIN_CABEC_CHE + 1))
  If cdsCadChq.IsEmpty Or (intQtdDocRes > 14) Then
  Begin
    pnlCheques.Visible := False;
    pnlDocume.Height   := INT_ALTURA_MAX_DOCS;
    intQtdLinDoc       := INT_QTD_MAX_REG_COL;
  End Else
  Begin
    pnlCheques.Visible := True;

    If intQtdDocRes <= 0 Then
    Begin
      hedCabDoc.Visible := False;
      pnlDocume.Visible := False;
    End;

    intQtdLinDoc := Ceil(intQtdDocRes / INT_NUMERO_COLUNAS);
    intQtdLinChe := INT_QTD_MAX_REG_COL - INT_NUM_LIN_CABEC_CHE - intQtdLinDoc + 1;

    pnlDocume.Height := Trunc( Ceil(INT_ALTURA_MAX_DOCS / INT_QTD_MAX_REG_COL) * intQtdLinDoc )
  End;
End;

procedure TfrmQckRcxReciboBai2.pBuscaDescricaoFormaPagamento(strNumDoc,
  strEspDoc, strCodEmp: string);
var
  qryFormaPagto: TUniQuery;
begin
  qryFormaPagto := fCriaQuery();

  try
    qryFormaPagto.Close;
    qryFormaPagto.SQL.Clear;
    qryFormaPagto.SQL.Add('SELECT ADT_VALCAR, ADT_VALCHP, ADT_VALCHV, ADT_VALCRE, ADT_VALDIN, ADT_VALORD, ADT_RECPIX');
    qryFormaPagto.SQL.Add('FROM ADTCLI');
    qryFormaPagto.SQL.Add('WHERE ADT_CODEMP = :CODEMP');
    qryFormaPagto.SQL.Add('AND ADT_ESPDOC = :ESPDOC');
    qryFormaPagto.SQL.Add('AND ADT_NUMDOC = :NUMDOC');

    qryFormaPagto.ParamByName('CODEMP').AsString := strCodEmp;
    qryFormaPagto.ParamByName('ESPDOC').AsString := strEspDoc;
    qryFormaPagto.ParamByName('NUMDOC').AsString := strNumDoc;

    qryFormaPagto.Open;

    if not qryFormaPagto.IsEmpty then
    begin
      rllValDin.Caption := 'DINHEIRO: '          + FormatFloat('#,##0.00', qryFormaPagto.FieldByName('ADT_VALDIN').AsFloat);
      rllValCar.Caption := 'CARTÃO: '            + FormatFloat('#,##0.00', qryFormaPagto.FieldByName('ADT_VALCAR').AsFloat);
      rllValChv.Caption := 'CHEQUE A VISTA: '    + FormatFloat('#,##0.00', qryFormaPagto.FieldByName('ADT_VALCHV').AsFloat);

      rllValOrd.Caption := 'ORDEM DE PGTO.: '    + FormatFloat('#,##0.00', qryFormaPagto.FieldByName('ADT_VALORD').AsFloat);
      If qryFormaPagto.FieldByName('ADT_RECPIX').AsString = 'S' Then
        rllValOrd.Caption := 'PIX: '    + FormatFloat('#,##0.00', qryFormaPagto.FieldByName('ADT_VALORD').AsFloat);

      rllValChp.Caption := 'CHEQUE-PRÉ: '        + FormatFloat('#,##0.00', qryFormaPagto.FieldByName('ADT_VALCHP').AsFloat);
      rllValCre.Caption := 'CRÉDITO UTILIZADO: ' + FormatFloat('#,##0.00', qryFormaPagto.FieldByName('ADT_VALCRE').AsFloat);
    end
    else
    begin
      rllValDin.Caption := 'DINHEIRO: '          + FormatFloat('#,##0.00', 0);
      rllValCar.Caption := 'CARTÃO: '            + FormatFloat('#,##0.00', 0);
      rllValChv.Caption := 'CHEQUE A VISTA: '    + FormatFloat('#,##0.00', 0);
      rllValOrd.Caption := 'ORDEM DE PGTO.: '    + FormatFloat('#,##0.00', 0);
      rllValChp.Caption := 'CHEQUE-PRÉ: '        + FormatFloat('#,##0.00', 0);
      rllValCre.Caption := 'CRÉDITO UTILIZADO: ' + FormatFloat('#,##0.00', 0);
    end;
  finally
    FreeAndNil(qryFormaPagto);
  end;
end;

function TfrmQckRcxReciboBai2.fCriaNovaPagina: Boolean;
  Var
    intContador : Integer;
begin

  Try
    Result := True;

    rlbColuna := rlpColuna1;

    //*************************************************//
    // VERIFICA SE DEVE IMPRIMIR UM OU MAIS REGISTROS  //
    // SE FOR APENAS UM REGISTRO, ENTAO NAO HA NECES.  //
    // DE CRIAR COMPONENTES EM TEMPO DE EXECUCAO       //
    //**********************************************ED*//
    With cdsImpRec Do
    Begin

      For intContador := 0 To INT_NUMERO_COLUNAS * intqtdLinDoc Do
      Begin
        //*************************************************//
        // AO EFETUAR O WHILE VERIFICA QUAL REGISTRO ESTA  //
        // SENDO IMPRESSO, SE FOR <= OU IGUAL A 12 ENTAO,  //
        // ATRIBUI OS VALORES NA PRIMEIRA COLUNA           //
        //**********************************************ED*//
        If intContador = 0 Then
        Begin
          rllNumDoc2.Visible := False;
          rllCodVen2.Visible := False;
          rllDtaVen2.Visible := False;
          rllDtaRec2.Visible := False;
          rllValDoc2.Visible := False;
          rllValRec2.Visible := False;

          arrLabels[intContador].rllNumDoc := rllNumDoc1;
          arrLabels[intContador].rllCodVen := rllCodVen1;
          arrLabels[intContador].rllDtaVen := rllDtaVen1;
          arrLabels[intContador].rllDtaRec := rllDtaRec1;
          arrLabels[intContador].rllValDoc := rllValDoc1;
          arrLabels[intContador].rllValRec := rllValRec1;
          rlbColuna := rlpColuna1;

          rllNumDoc1.Caption := FieldByName('NUMDOC').AsString + '-' +
                                FieldByName('PARCEL').AsString + '-' +
                                FieldByName('ESPDOC').AsString + '-' +
                                FieldByName('CODEMP').AsString;

          rllCodVen1.Caption := FieldByName('CODVEN').AsString;
          rllDtaVen1.Caption := FormatDateTime( 'dd/mm/yy', FieldByName('DTAVEN').AsDateTime);
          rllDtaRec1.Caption := FormatDateTime( 'dd/mm/yy', FieldByName('DTAREC').AsDateTime);
          rllValDoc1.Caption := FormatFloat   ( '#,##0.00', FieldByName('VALDOC').AsFloat);
          rllValRec1.Caption := FormatFloat   ( '#,##0.00', FieldByName('VALREC').AsFloat);
        End

        //*************************************************//
        // SE FOR MAIS DE 12 REGISTRO ENTAO ATRIBUI O 13,  //
        // PARA A SEGUNDA COLUNA                           //
        //**********************************************ED*//
        Else If intContador = intqtdLinDoc Then
        Begin
          arrLabels[intContador].rllNumDoc := rllNumDoc2;
          arrLabels[intContador].rllCodVen := rllCodVen2;          
          arrLabels[intContador].rllDtaVen := rllDtaVen2;
          arrLabels[intContador].rllDtaRec := rllDtaRec2;
          arrLabels[intContador].rllValDoc := rllValDoc2;
          arrLabels[intContador].rllValRec := rllValRec2;
          rlbColuna := rlpColuna2;

          rllNumDoc2.Visible := True;
          rllCodVen2.Visible := True;
          rllDtaVen2.Visible := True;
          rllValDoc2.Visible := True;
          rllValRec2.Visible := True;

          rllNumDoc2.Caption := FieldByName('NUMDOC').AsString + '-' +
                                FieldByName('PARCEL').AsString + '-' +
                                FieldByName('ESPDOC').AsString + '-' +
                                FieldByName('CODEMP').AsString;

          rllCodVen2.Caption := FieldByName('CODVEN').AsString;
          rllDtaVen2.Caption := FormatDateTime( 'dd/mm/yy', FieldByName('DTAVEN').AsDateTime);
          rllDtaRec2.Caption := FormatDateTime( 'dd/mm/yy', FieldByName('DTAREC').AsDateTime);
          rllValDoc2.Caption := FormatFloat   ( '#,##0.00', FieldByName('VALDOC').AsFloat);
          rllValRec2.Caption := FormatFloat   ( '#,##0.00', FieldByName('VALREC').AsFloat);
        End
        Else If intContador = INT_NUMERO_COLUNAS * intQtdLinDoc Then
        Begin
          blnNovPag := False;
          Break;
        End
        Else
        Begin
          arrLabels[intContador].rllNumDoc := fAdicionaRlLabels(rlbColuna, arrLabels[intContador-1].rllNumDoc,
                                              FieldByName('NUMDOC').AsString + '-' +
                                              FieldByName('PARCEL').AsString + '-' +
                                              FieldByName('ESPDOC').AsString + '-' +
                                              FieldByName('CODEMP').AsString);

          arrLabels[intContador].rllCodVen := fAdicionaRlLabels(rlbColuna, arrLabels[intContador-1].rllCodVen,
                                              FieldByName('CODVEN').AsString);

          arrLabels[intContador].rllDtaVen := fAdicionaRlLabels(rlbColuna, arrLabels[intContador-1].rllDtaVen,
                                              FormatDateTime('dd/mm/yy', FieldByName('DTAVEN').AsDateTime));

          arrLabels[intContador].rllDtaRec := fAdicionaRlLabels(rlbColuna, arrLabels[intContador-1].rllDtaRec,
                                              FormatDateTime('dd/mm/yy', FieldByName('DTAREC').AsDateTime));
                                              
          arrLabels[intContador].rllValDoc := fAdicionaRlLabels(rlbColuna, arrLabels[intContador-1].rllValDoc,
                                              FormatFloat('#,##0.00' ,     FieldByName('VALDOC').AsFloat), True);

          arrLabels[intContador].rllValRec := fAdicionaRlLabels(rlbColuna, arrLabels[intContador-1].rllValRec,
                                                FormatFloat('#,##0.00' ,   FieldByName('VALREC').AsFloat), True);
        End;

        Inc(intQtdDocImp);

        Next;

        If Eof Then
          Break;
      End;  // END FOR

    End;

    pImprimeCheques;

  Except
    Result := False;
  End;

end;

procedure TfrmQckRcxReciboBai2.pImprimeCheques;
  Var
    intContador : Integer;
    intTop: Integer;
Begin
  If pnlCheques.Visible Then
  Begin
    intContador := 0;
    
    With cdsCadChq Do
    Begin
      intTop := rllNumAge.Top;

      While Not Eof Do
      Begin

        If intContador = 0 Then
        Begin
          rllNumAge.Caption := FieldByName('CHQ_NUMAGE').AsString;
          rllConCor.Caption := FieldByName('CHQ_CONCOR').AsString;
          rllNumChq.Caption := FieldByName('CHQ_NUMCHQ').AsString;
          rllDtaVen.Caption := FormatDateTime('dd/mm/yyyy', FieldByName('CHQ_DTAVEN').AsDateTime);
          rllValChq.Caption := FormatFloat(   '#,##0.00',   FieldByName('CHQ_VALCHQ').AsFloat);
          rllNomEmi.Caption := FieldByName('CHQ_NOMEMI').AsString;
          rllC_G_C_.Caption := FieldByName('CHQ_C_G_C_').AsString;
        End Else
        Begin
          arrCheques[Pred(intContador)].rllNumAge := fAdicionaRlLabelsChe(FieldByName('CHQ_NUMAGE').AsString, rllNumAge, intTop);
          arrCheques[Pred(intContador)].rllConCor := fAdicionaRlLabelsChe(FieldByName('CHQ_CONCOR').AsString, rllConCor, intTop);
          arrCheques[Pred(intContador)].rllNumChq := fAdicionaRlLabelsChe(FieldByName('CHQ_NUMCHQ').AsString, rllNumChq, intTop);
          arrCheques[Pred(intContador)].rllDtaVen := fAdicionaRlLabelsChe(FormatDateTime('dd/mm/yyyy', FieldByName('CHQ_DTAVEN').AsDateTime), rllDtaVen, intTop);
          arrCheques[Pred(intContador)].rllValChq := fAdicionaRlLabelsChe(FormatFloat(   '#,##0.00',   FieldByName('CHQ_VALCHQ').AsFloat), rllValChq, intTop);
          arrCheques[Pred(intContador)].rllNomEmi := fAdicionaRlLabelsChe(FieldByName('CHQ_NOMEMI').AsString, rllNomEmi, intTop);
          arrCheques[Pred(intContador)].rllC_G_C_ := fAdicionaRlLabelsChe(FieldByName('CHQ_C_G_C_').AsString, rllC_G_C_, intTop);
        End;

        inc(intContador);
        inc(intQtdCheImp);
        inc(intTop, rllNumAge.Height + 6);
        Next;

        If intQtdCheImp = intqtdLinChe Then
          Break;
      End;

      blnNovPag := Eof;
    End;
  End;
End;

procedure TfrmQckRcxReciboBai2.rlbFooter1AfterPrint(Sender: TObject);
begin

  If Not ( blnNovPag ) Then
  Begin
    blnNovPag := True;

    If (Not cdsImpRec.Eof) Or (Not cdsCadChq.Eof) Then
      qckPagina.NewPage;

  End;

end;

procedure TfrmQckRcxReciboBai2.rlbFooter1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin

  If ( blnNovPag ) Then
    rllImpressao.Visible := False;

end;

procedure TfrmQckRcxReciboBai2.rllTotRecBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
  Begin
    Text := 'G$ ' + FormatFloat('#,##0.00', fltTotRec);
    If (qckPagina.DefaultFilter <> Nil) Then
      Text := #27 + 'W1' + 'G$ ' + FormatFloat('#,##0.00', fltTotRec) + #27 + 'W0';
  End
  Else
  Begin
    Text := 'R$ ' + FormatFloat('#,##0.00', fltTotRec);
    If (qckPagina.DefaultFilter <> Nil) Then
      Text := #27 + 'W1' + 'R$ ' + FormatFloat('#,##0.00', fltTotRec) + #27 + 'W0';
  End;
end;

procedure TfrmQckRcxReciboBai2.RLLabel5BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := fRetNomeOperador(strCodOpe);
end;

procedure TfrmQckRcxReciboBai2.FormDestroy(Sender: TObject);
begin

  SetLength(arrCheques, 0);

end;

procedure TfrmQckRcxReciboBai2.rlbHeader1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin

  If Not( blnNewPag ) Then
  Begin
    cdsImpRec.First;
    cdsCadChq.First;
    blnNewPag := True;

    intQtdDocImp := 0;
    intQtdCheImp := 0;
  End;

  pAjustaPanels;

end;

end.

