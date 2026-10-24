unit untQckRetBco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiQck, RLParser, RLReport, RLPreviewForm, Data.DB, MemDS,
  DBAccess, Uni;

type
  TfrmQckRetBco = class(TfrmPaiQck)
    rllCliente: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    rllNomeBanco: TRLLabel;
    rlbDescOco: TRLBand;
    RLLabel12: TRLLabel;
    rllCodOco: TRLLabel;
    rllDescricao: TRLLabel;
    rllTotValDup: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel16: TRLLabel;
    rllQtdDup: TRLLabel;
    RLLabel18: TRLLabel;
    rlbDupDiv: TRLBand;
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
    RLDraw1: TRLDraw;
    dtsDados: TDataSource;
    RLLabel17: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel20: TRLLabel;
    rllTotPag: TRLLabel;
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
    rdbValCor: TRLDBText;
    rdbValDif: TRLDBText;
    RLDBText1: TRLDBText;
    RLLabel11: TRLLabel;
    rdbValPag: TRLDBResult;
    RLDBResult1: TRLDBResult;
    RLDBResult2: TRLDBResult;
    RLDBResult3: TRLDBResult;
    RLDBResult4: TRLDBResult;
    RLDBResult5: TRLDBResult;
    rllTotalGeral: TRLLabel;
    rldSumValPag: TRLDBResult;
    rldSumJurMor: TRLDBResult;
    rldSumDescon: TRLDBResult;
    rldSumValDup: TRLDBResult;
    rldSumValCor: TRLDBResult;
    rldSumValDif: TRLDBResult;
    qckBaixados: TRLReport;
    RLBand2: TRLBand;
    RLLabel32: TRLLabel;
    RLLabel33: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLLabel34: TRLLabel;
    RLLabel35: TRLLabel;
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
    qryBaixados: TUniQuery;
    dtsBaixadas: TDataSource;
    RLLabel2: TRLLabel;
    rdbOutVal: TRLDBText;
    RLDBResult6: TRLDBResult;
    rldSumDesCob: TRLDBResult;
    rdbCodMot: TRLDBText;
    RLLabel53: TRLLabel;
    rllTotCusCar: TRLLabel;
    RLBand1: TRLBand;
    RLLabel56: TRLLabel;
    rllTotGerQtd: TRLLabel;
    rllTotGerDup: TRLLabel;
    rllTotGerPag: TRLLabel;
    rllTotGerCar: TRLLabel;
    rllDtaRet: TRLLabel;
    rllDtaRet2: TRLLabel;
    RLLabel24: TRLLabel;
    rllTotGerQtdDup: TRLLabel;
    rllTotGerDupDup: TRLLabel;
    procedure rllOrdemBeforePrint(Sender: TObject; var Text: String; var PrintIt: Boolean);
    procedure rdbValDifBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure RLDBText1BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure RLBand7AfterPrint(Sender: TObject);
    procedure rldValPag_BaiBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure rldValJur_BaiBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure rldValDesCob_BaiBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure rlbDescon_BaiBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure rldValDup_BaiBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure rllPaginaBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure rdbCodMotBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure rlbDetalheGrupoBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rlbResumoGrupoAfterPrint(Sender: TObject);
    procedure RLLabel35BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure qckPaginaBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rllQtdRegBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
  private
    { Private declarations }
    corCor1: TColor;
    corCor2: TColor;
    strCodMot : String;
    fltTotGerQtd,
    fltTotGerDup,
    fltTotGerPag,
    fltTotGerCar: Double;
    function pRetornaDescricaoBeforePrint(strTexto, ABanco: String; iTam: Integer): String;

  public
    fRetDescOco : function (strCodoco: String): String of Object;
    ABanco, ACnab, AMotivo: String;
  end;

var
  frmQckRetBco: TfrmQckRetBco;

implementation

{$R *.dfm}

uses untFuncoesSimples, untFuncAutban;

procedure TfrmQckRetBco.FormCreate(Sender: TObject);
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

  fltTotGerQtd := 0;
  fltTotGerDup := 0;
  fltTotGerPag := 0;
  fltTotGerCar := 0;
end;

procedure TfrmQckRetBco.RLBand7AfterPrint(Sender: TObject);
begin
  inherited;
  If (RLBand7.Color = corCor1) Then
    RLBand7.Color := corCor2
  Else
    RLBand7.Color := corCor1;
end;

procedure TfrmQckRetBco.rlbDescon_BaiBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(dtsBaixadas.dataSet.FieldByName('DESCON').AsCurrency,ffNumber,15,2);
end;

procedure TfrmQckRetBco.rlbDetalheGrupoBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  if (strCodMot<>dtsDados.dataSet.FieldByName('CODMOT').AsString) Then
  Begin
    // Mostra o motivo da rejeição na linha de detalhe
    rdbCodMot.Text := dtsDados.dataSet.FieldByName('CODMOT').AsString + ' ' +
                      dtsDados.dataSet.FieldByName('DESMOT').AsString;
    rdbNumDup.Top := 13;
    rdbCodCli.Top := 13;
    rdbCodEmp.Top := 13;
    rdbDesCon.Top := 13;
    rdbDtaPag.Top := 13;
    rdbDtaVen.Top := 13;
    rdbJurMor.Top := 13;
    rdbNosNum.Top := 13;
    rdbNumDup.Top := 13;
    rdbOutVal.Top := 13;
    rdbValCor.Top := 13;
    rdbValDif.Top := 13;
    rdbValDup.Top := 13;
    rdbValPago.Top := 13;
    rlbDetalheGrupo.Height := 27;
  End
  Else
  Begin
    // Não mostra o motivo da rejeição na linha de detalhe
    rdbCodMot.Text := '';
    rdbNumDup.Top := 0;
    rdbCodCli.Top := 0;
    rdbCodEmp.Top := 0;
    rdbDesCon.Top := 0;
    rdbDtaPag.Top := 0;
    rdbDtaVen.Top := 0;
    rdbJurMor.Top := 0;
    rdbNosNum.Top := 0;
    rdbNumDup.Top := 0;
    rdbOutVal.Top := 0;
    rdbValCor.Top := 0;
    rdbValDif.Top := 0;
    rdbValDup.Top := 0;
    rdbValPago.Top := 0;
    rlbDetalheGrupo.Height := 15;
  End;

  strCodMot := dtsDados.dataSet.FieldByName('CODMOT').AsString;
end;

procedure TfrmQckRetBco.rlbResumoGrupoAfterPrint(Sender: TObject);
begin
  inherited;
  strCodMot := '';
end;

procedure TfrmQckRetBco.rdbValDifBeforePrint(Sender: TObject; var Text: string;
  var PrintIt: Boolean);
begin
  inherited;
  if fStrToFloat(Text) = 0 Then
    Text := '';
end;

procedure TfrmQckRetBco.qckPaginaBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  rpsSetup.ZoomFactor := 140;
end;

procedure TfrmQckRetBco.rdbCodMotBeforePrint(Sender: TObject; var Text: string;
  var PrintIt: Boolean);
begin
  inherited;
  PrintIt := (Text<>'');
end;

procedure TfrmQckRetBco.RLDBText1BeforePrint(Sender: TObject; var Text: string;
  var PrintIt: Boolean);
  Var strText : String;
Begin
  inherited;

  strText := '';
  if (ABanco = '001') or
     (ABanco = '748') or
     (ABanco = '237') then
  begin

     strText := Text;
     Text    := pRetornaDescricaoBeforePrint( strText, ABanco, Length(Text) );

  end
  Else
    if Assigned(fRetDescOco) then
       Text := Text + ' - ' + fRetDescOco(Text);

end;

Function TfrmQckRetBco.pRetornaDescricaoBeforePrint( strTexto : String; ABanco : String; iTam : Integer ) : String;
Begin

   Result := strTexto + ' - ' + RetornaOcorrencia(ABanco, Copy(strTexto, 1, 2), ACnab);

   If iTam > 2 Then
   Begin

      If (ABanco = '237') Then
      Begin
         Result := Copy(strTexto, 1, 2) + '-'    + RetornaOcorrencia(ABanco, Copy(strTexto, 1, 2), ACnab)
                                        + ' /. ' + RetornaOcorrencia(ABanco, Copy(strTexto, 1, 2), ACnab, Copy(strTexto, 4, 2));
      End
      Else
      Begin
         Result := Copy(strTexto, 1, 2) + '.' + RetornaOcorrencia(ABanco, Copy(strTexto, 1, 2), ACnab, Copy(strTexto, 4, 2));
      End;

   End;

End;

procedure TfrmQckRetBco.rldValDesCob_BaiBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(dtsBaixadas.dataSet.FieldByName('OUTVAL').AsCurrency,ffNumber,15,2);
end;

procedure TfrmQckRetBco.rldValDup_BaiBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(dtsBaixadas.dataSet.FieldByName('VALDUP').AsCurrency,ffNumber,15,2);
end;

procedure TfrmQckRetBco.rldValJur_BaiBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(dtsBaixadas.dataSet.FieldByName('JURMOR').AsCurrency,ffNumber,15,2);
end;

procedure TfrmQckRetBco.rldValPag_BaiBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(dtsBaixadas.dataSet.FieldByName('VALPAG').AsCurrency,ffNumber,15,2);
end;

procedure TfrmQckRetBco.RLLabel35BeforePrint(Sender: TObject; var Text: string;
  var PrintIt: Boolean);
begin
  inherited;
  Text := 'PÁGINA ' + IntToStr(qckBaixados.PageNumber);
end;

procedure TfrmQckRetBco.rllOrdemBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := strOrdem;
end;

procedure TfrmQckRetBco.rllPaginaBeforePrint(Sender: TObject; var Text: string;
  var PrintIt: Boolean);
begin
  inherited;
  Text := 'PÁGINA ' + IntToStr(qckPagina.PageNumber);

end;

procedure TfrmQckRetBco.rllQtdRegBeforePrint(Sender: TObject; var Text: string;
  var PrintIt: Boolean);
begin
  inherited;
  if fPadL(Text, 6, '0') = '000000' then
    Text := ''
  else
    Text := 'REGISTROS IMPRESSOS: ' + fPadL(Text, 6, '0');
end;

end.
