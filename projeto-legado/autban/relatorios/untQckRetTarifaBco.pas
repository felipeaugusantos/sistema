unit untQckRetTarifaBco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, MemDS, DBAccess, Uni,
  RLPreviewForm, RLParser, untPaiQck, RLReport, StrUtils;

type
  TfrmQckRetTarifaBco = class(TfrmPaiQck)
    rllCliente: TRLLabel;
    rllNomeBanco: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel2: TRLLabel;
    RLDBText1: TRLDBText;
    rdbCodCli: TRLDBText;
    rdbNosNum: TRLDBText;
    rdbNumDup: TRLDBText;
    rdbCodEmp: TRLDBText;
    rdbDtaPag: TRLDBText;
    rdbValPago: TRLDBText;
    rdbJurMor: TRLDBText;
    rdbDesCon: TRLDBText;
    rdbValDup: TRLDBText;
    rdbDtaVen: TRLDBText;
    rdbValDif: TRLDBText;
    rdbTarifa: TRLDBText;
    RLLabel11: TRLLabel;
    rdbValPag: TRLDBResult;
    RLDBResult1: TRLDBResult;
    RLDBResult2: TRLDBResult;
    RLDBResult3: TRLDBResult;
    RLDBResult5: TRLDBResult;
    RLDBResult6: TRLDBResult;
    rlbDescOco: TRLBand;
    rllCodOco: TRLLabel;
    rllDescricao: TRLLabel;
    rllTotValDup: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    rllQtdDup: TRLLabel;
    RLLabel18: TRLLabel;
    RLLabel20: TRLLabel;
    rllTotPag: TRLLabel;
    rllTotalGeral: TRLLabel;
    rldSumValPag: TRLDBResult;
    rldSumJurMor: TRLDBResult;
    rldSumDescon: TRLDBResult;
    rldSumValDup: TRLDBResult;
    rldSumValDif: TRLDBResult;
    rldSumTarifa: TRLDBResult;
    rlbDupDiv: TRLBand;
    RLDraw1: TRLDraw;
    rllTitDupDiv: TRLLabel;
    rllCodCli: TRLLabel;
    rllMotDiv: TRLLabel;
    rllNumDup: TRLLabel;
    rllNosNum: TRLLabel;
    RLLabel1: TRLLabel;
    RLLabel21: TRLLabel;
    RLLabel22: TRLLabel;
    RLLabel23: TRLLabel;
    RLLabel25: TRLLabel;
    RLLabel26: TRLLabel;
    RLLabel27: TRLLabel;
    RLLabel28: TRLLabel;
    RLLabel29: TRLLabel;
    RLLabel30: TRLLabel;
    RLLabel31: TRLLabel;
    rllValDup: TRLLabel;
    rllValDes: TRLLabel;
    rllValJur: TRLLabel;
    rllValPag: TRLLabel;
    rllDtaPag: TRLLabel;
    rllDtaVen: TRLLabel;
    rllCodEmp: TRLLabel;
    RLDraw2: TRLDraw;
    dtsDados: TDataSource;
    qryBaixados: TUniQuery;
    dtsBaixadas: TDataSource;
    RLLabel17: TRLLabel;
    rdbValLan: TRLDBText;
    RLDBResult4: TRLDBResult;
    rldSumValLan: TRLDBResult;
    RLLabel24: TRLLabel;
    rllValTar: TRLLabel;
    RLLabel12: TRLLabel;
    qckBaixados: TRLReport;
    RLBand2: TRLBand;
    RLLabel33: TRLLabel;
    RLLabel34: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLLabel35: TRLLabel;
    RLLabel36: TRLLabel;
    rllNomeBanco2: TRLLabel;
    RLBand3: TRLBand;
    RLLabel37: TRLLabel;
    RLLabel38: TRLLabel;
    RLLabel39: TRLLabel;
    RLLabel40: TRLLabel;
    RLLabel41: TRLLabel;
    RLLabel42: TRLLabel;
    RLLabel43: TRLLabel;
    RLLabel44: TRLLabel;
    RLLabel45: TRLLabel;
    RLLabel46: TRLLabel;
    RLLabel47: TRLLabel;
    RLLabel48: TRLLabel;
    RLLabel49: TRLLabel;
    RLGroup1: TRLGroup;
    RLBand4: TRLBand;
    RLBand5: TRLBand;
    RLBand6: TRLBand;
    RLBand7: TRLBand;
    RLDBText13: TRLDBText;
    RLDBText14: TRLDBText;
    RLDBText15: TRLDBText;
    RLDBText16: TRLDBText;
    RLDBText17: TRLDBText;
    rldDtaPag_Bai: TRLDBText;
    rldValPag_Bai: TRLDBText;
    rldValJur_Bai: TRLDBText;
    rlbDescon_Bai: TRLDBText;
    rldValDup_Bai: TRLDBText;
    RLDBText23: TRLDBText;
    RLDBText24: TRLDBText;
    rldValDesCob_Bai: TRLDBText;
    RLBand8: TRLBand;
    RLLabel51: TRLLabel;
    RLPanel2: TRLPanel;
    RLSystemInfo2: TRLSystemInfo;
    RLBand9: TRLBand;
    RLLabel52: TRLLabel;
    rldTotValPag_Bai: TRLDBResult;
    rldTotValJur_Bai: TRLDBResult;
    rldTotDescon_Bai: TRLDBResult;
    rldTotValDup_Bai: TRLDBResult;
    rlbTotDesCob_Bai: TRLDBResult;
    RLLabel50: TRLLabel;
    RLDBText19: TRLDBText;
    RLDBResult9: TRLDBResult;
    RLLabel32: TRLLabel;
    rllTotLan: TRLLabel;
    rdbCodMot: TRLDBText;
    RLLabel55: TRLLabel;
    rllTotCusCar: TRLLabel;
    rlbDetalheOco: TRLBand;
    RLLabel57: TRLLabel;
    rllTotGerQtd: TRLLabel;
    rllTotGerDup: TRLLabel;
    rllTotGerPag: TRLLabel;
    rllTotGerLan: TRLLabel;
    rllTotGerCar: TRLLabel;
    rllDtaRet: TRLLabel;
    rllDtaRet2: TRLLabel;
    RLLabel53: TRLLabel;
    rllTotGerQtdDup: TRLLabel;
    rllTotGerDupDup: TRLLabel;
    RLLabel54: TRLLabel;
    rdbCarBco: TRLDBText;
    RLLabel56: TRLLabel;
    RLLabel58: TRLLabel;
    rdbTxaDes: TRLDBText;
    rdbIofDes: TRLDBText;
    RLDBResult10: TRLDBResult;
    RLDBResult11: TRLDBResult;
    rldSumIOF: TRLDBResult;
    rldSumTaxaDesc: TRLDBResult;
    RLLabel59: TRLLabel;
    rdbVlrCre: TRLDBText;
    RLDBResult14: TRLDBResult;
    rldSumValCre: TRLDBResult;
    RLLabel60: TRLLabel;
    rlbJurOpe: TRLDBText;
    RLDBResult16: TRLDBResult;
    rldSumJurOpe: TRLDBResult;
    qckBaixadosLancaTarifa: TRLReport;
    RLBand1: TRLBand;
    RLBand10: TRLBand;
    RLLabel61: TRLLabel;
    RLLabel62: TRLLabel;
    RLLabel63: TRLLabel;
    RLLabel64: TRLLabel;
    RLLabel65: TRLLabel;
    RLLabel66: TRLLabel;
    RLLabel67: TRLLabel;
    RLLabel68: TRLLabel;
    RLLabel69: TRLLabel;
    RLLabel70: TRLLabel;
    RLLabel71: TRLLabel;
    RLLabel72: TRLLabel;
    RLLabel73: TRLLabel;
    RLLabel74: TRLLabel;
    RLLabel75: TRLLabel;
    RLLabel76: TRLLabel;
    rllDtaRet3: TRLLabel;
    RLLabel78: TRLLabel;
    RLSystemInfo3: TRLSystemInfo;
    rllNomeBanco3: TRLLabel;
    RLLabel80: TRLLabel;
    RLBand11: TRLBand;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    rldValPag_BaixadaLancaTaria: TRLDBText;
    rldTarifa_BaixadaLancaTarifa: TRLDBText;
    rldValJur_BaixadaLancaTarifa: TRLDBText;
    rldDesCob_BaixadaLancaTarifa: TRLDBText;
    rldDesconto_BaixadaLancaTarifa: TRLDBText;
    rldValDup_BaixadaLancaTarifa: TRLDBText;
    RLBand12: TRLBand;
    RLLabel81: TRLLabel;
    RLDBResult18: TRLDBResult;
    RLDBResult19: TRLDBResult;
    RLDBResult20: TRLDBResult;
    RLDBResult21: TRLDBResult;
    RLDBResult22: TRLDBResult;
    RLDBResult23: TRLDBResult;
    RLBand13: TRLBand;
    RLLabel82: TRLLabel;
    RLPanel3: TRLPanel;
    RLSystemInfo4: TRLSystemInfo;
    qryBaixadasLancaTarifa: TUniQuery;
    dtsBaixadasLancaTarifa: TDataSource;
    procedure rllOrdemBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure rdbValDifBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure RLDBText1BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure RLBand7AfterPrint(Sender: TObject);
    procedure rldValPag_BaiBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure rldValJur_BaiBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure rldValDesCob_BaiBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure rldTotValDup_BaiBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure rllPaginaBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure rlbDetalheGrupoBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rlbResumoGrupoAfterPrint(Sender: TObject);
    procedure rdbCodMotBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure rldValDup_BaiBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure rlbDescon_BaiBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure RLDBText19BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure RLLabel36BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure RLLabel51BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure RLLabel82BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure RLSystemInfo2BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure RLSystemInfo4BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure rldValPag_BaixadaLancaTariaBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure rldTarifa_BaixadaLancaTarifaBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure rldValJur_BaixadaLancaTarifaBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure rldDesCob_BaixadaLancaTarifaBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure rldDesconto_BaixadaLancaTarifaBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure rldValDup_BaixadaLancaTarifaBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure RLBand11AfterPrint(Sender: TObject);
    procedure qckPaginaBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rllQtdRegBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
  private
    { Private declarations }
    corCor1: TColor;
    corCor2: TColor;
    strCodMot : String;
  public
    { Public declarations }
    fRetDescOco : function (strCodoco: String): String of Object;
    ABanco, ACnab, AMotivo: String;
  end;

var
  frmQckRetTarifaBco: TfrmQckRetTarifaBco;

implementation

{$R *.dfm}

uses untFuncoesSimples, untFuncAutban;

procedure TfrmQckRetTarifaBco.FormCreate(Sender: TObject);
  Var
    strAux: String;
begin
  inherited;

  corCor1 := clWhite;

  strAux := fCfgSis('CORZEB');

  If (Not fEmptyStr(strAux)) Then
    corCor2 := StrToInt(strAux)
  Else
    corCor2 := clWhite;
end;

procedure TfrmQckRetTarifaBco.RLBand11AfterPrint(Sender: TObject);
begin
  inherited;
  If (RLBand11.Color = corCor1) Then
    RLBand11.Color := corCor2
  Else
    RLBand11.Color := corCor1;
end;

procedure TfrmQckRetTarifaBco.RLBand7AfterPrint(Sender: TObject);
begin
  inherited;
  If (RLBand7.Color = corCor1) Then
    RLBand7.Color := corCor2
  Else
    RLBand7.Color := corCor1;
end;

procedure TfrmQckRetTarifaBco.rlbDescon_BaiBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(dtsBaixadas.dataSet.FieldByName('DESCON').AsCurrency,ffNumber,15,2);
end;

procedure TfrmQckRetTarifaBco.rlbDetalheGrupoBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  if (strCodMot<>dtsDados.dataSet.FieldByName('CODMOT').AsString) Then
  Begin
    // Mostra o motivo da rejeição na linha de detalhe
    rdbCodMot.Text := dtsDados.dataSet.FieldByName('CODMOT').AsString + ' ' +
                      dtsDados.dataSet.FieldByName('DESMOT').AsString;
    rdbCodCli.Top := 13;
    rdbCodEmp.Top := 13;
    rdbCarBco.Top := 13;
    rdbDesCon.Top := 13;
    rdbDtaPag.Top := 13;
    rdbDtaVen.Top := 13;
    rdbJurMor.Top := 13;
    rdbNosNum.Top := 13;
    rdbNumDup.Top := 13;
    rdbTarifa.Top := 13;
    rdbIofDes.Top := 13;
    rdbTxaDes.Top := 13;
    rdbVlrCre.Top := 13;
    rdbValDif.Top := 13;
    rdbValDup.Top := 13;
    rdbValLan.Top := 13;
    rdbValPago.Top:= 13;
    rlbJurOpe.Top := 13;
    rlbDetalheGrupo.Height := 27;
  End
  Else
   Begin
    // Não mostra o motivo da rejeição na linha de detalhe
    rdbCodMot.Text := '';
    rdbCodCli.Top := 0;
    rdbCodEmp.Top := 0;
    rdbCarBco.Top := 0;
    rdbDesCon.Top := 0;
    rdbDtaPag.Top := 0;
    rdbDtaVen.Top := 0;
    rdbJurMor.Top := 0;
    rdbNosNum.Top := 0;
    rdbNumDup.Top := 0;
    rdbTarifa.Top := 0;
    rdbIofDes.Top := 0;
    rdbTxaDes.Top := 0;
    rdbVlrCre.Top := 0;
    rdbValDif.Top := 0;
    rdbValDup.Top := 0;
    rdbValLan.Top := 0;
    rdbValPago.Top:= 0;
    rlbJurOpe.Top := 0;
    rlbDetalheGrupo.Height := 15;
   End;

  strCodMot := dtsDados.dataSet.FieldByName('CODMOT').AsString;
end;

procedure TfrmQckRetTarifaBco.rlbResumoGrupoAfterPrint(Sender: TObject);
begin
  inherited;
  strCodMot := '';
end;

procedure TfrmQckRetTarifaBco.qckPaginaBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  rpsSetup.ZoomFactor := 140;
end;

procedure TfrmQckRetTarifaBco.rdbCodMotBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  PrintIt := (Text<>'');
end;

procedure TfrmQckRetTarifaBco.rdbValDifBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  if fStrToFloat(Text) = 0 Then
    Text := '';
end;

procedure TfrmQckRetTarifaBco.RLDBText19BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(dtsBaixadas.dataSet.FieldByName('TARIFA').AsCurrency,ffNumber,15,2);
end;

procedure TfrmQckRetTarifaBco.RLDBText1BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  if (MatchStr(ABanco, ['001', '748', '077'])) then
  begin
    If Length(Text) = 2 then
      Text := Text + ' - ' + RetornaOcorrencia(ABanco, Copy(Text, 1, 2), ACnab)
    else
      Text := Copy(Text, 1, 2) + '.' + RetornaOcorrencia(ABanco, Copy(Text, 1, 2), ACnab, Copy(Text, 4, 2));
  end
  Else
    if Assigned(fRetDescOco) then
      Text := Text + ' - ' + fRetDescOco(Text);
end;

procedure TfrmQckRetTarifaBco.rldDesCob_BaixadaLancaTarifaBeforePrint(
  Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(dtsBaixadasLancaTarifa.dataSet.FieldByName('OUTVAL').AsCurrency,ffNumber,15,2);
end;

procedure TfrmQckRetTarifaBco.rldDesconto_BaixadaLancaTarifaBeforePrint(
  Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(dtsBaixadasLancaTarifa.dataSet.FieldByName('DESCON').AsCurrency,ffNumber,15,2);
end;

procedure TfrmQckRetTarifaBco.rldTarifa_BaixadaLancaTarifaBeforePrint(
  Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(dtsBaixadasLancaTarifa.dataSet.FieldByName('TARIFA').AsCurrency,ffNumber,15,2);
end;

procedure TfrmQckRetTarifaBco.rldTotValDup_BaiBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(dtsBaixadas.dataSet.FieldByName('VALDUP').AsCurrency,ffNumber,15,2);
end;

procedure TfrmQckRetTarifaBco.rldValDesCob_BaiBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(dtsBaixadas.dataSet.FieldByName('OUTVAL').AsCurrency,ffNumber,15,2);
end;

procedure TfrmQckRetTarifaBco.rldValDup_BaiBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(dtsBaixadas.dataSet.FieldByName('VALDUP').AsCurrency,ffNumber,15,2);
end;

procedure TfrmQckRetTarifaBco.rldValDup_BaixadaLancaTarifaBeforePrint(
  Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(dtsBaixadasLancaTarifa.dataSet.FieldByName('VALDUP').AsCurrency,ffNumber,15,2);
end;

procedure TfrmQckRetTarifaBco.rldValJur_BaiBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(dtsBaixadas.dataSet.FieldByName('JURMOR').AsCurrency,ffNumber,15,2);
end;

procedure TfrmQckRetTarifaBco.rldValJur_BaixadaLancaTarifaBeforePrint(
  Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(dtsBaixadasLancaTarifa.dataSet.FieldByName('JURMOR').AsCurrency,ffNumber,15,2);
end;

procedure TfrmQckRetTarifaBco.rldValPag_BaiBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(dtsBaixadas.dataSet.FieldByName('VALPAG').AsCurrency,ffNumber,15,2);
end;

procedure TfrmQckRetTarifaBco.rldValPag_BaixadaLancaTariaBeforePrint(
  Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(dtsBaixadasLancaTarifa.dataSet.FieldByName('VALPAG').AsCurrency,ffNumber,15,2);
end;

procedure TfrmQckRetTarifaBco.RLLabel36BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := 'PÁGINA ' + IntToStr(qckBaixados.PageNumber);
end;

procedure TfrmQckRetTarifaBco.RLLabel51BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := '[ ' + Self.Name + ' ]';
end;

procedure TfrmQckRetTarifaBco.RLLabel82BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := '[ ' + Self.Name + ' ]';
end;

procedure TfrmQckRetTarifaBco.rllOrdemBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := strOrdem;
end;

procedure TfrmQckRetTarifaBco.rllPaginaBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := 'PÁGINA ' + IntToStr(qckPagina.PageNumber);

end;

procedure TfrmQckRetTarifaBco.rllQtdRegBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  if fPadL(Text, 6, '0') = '000000' then
    Text := ''
  else
    Text := 'REGISTROS IMPRESSOS: ' + fPadL(Text, 6, '0');
end;

procedure TfrmQckRetTarifaBco.RLSystemInfo2BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  if fPadL(Text, 6, '0') = '000000' then
    Text := ''
  else
    Text := 'REGISTROS IMPRESSOS: ' + fPadL(Text, 6, '0');
end;

procedure TfrmQckRetTarifaBco.RLSystemInfo4BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  if fPadL(Text, 6, '0') = '000000' then
    Text := ''
  else
    Text := 'REGISTROS IMPRESSOS: ' + fPadL(Text, 6, '0');
end;

end.
