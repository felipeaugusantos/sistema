unit untQckCtpAnalDebitos;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms, 
  Dialogs, StdCtrls, untPaiQck, RLReport, RLParser, UniClientDataSet,
  StrUtils, DB,   Uni, RLPreviewForm, untIFuncoes;

type
  TfrmQckCtpAnalDebitos = class(TfrmPaiQck)
    rllFornecedor: TRLLabel;
    rllEmpresa: TRLLabel;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    rllTitLoja: TRLLabel;
    rllTitCTA: TRLLabel;
    rllTitForn: TRLLabel;
    rllTitHistorico: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLDBText1: TRLDBText;
    rdbLoja: TRLDBText;
    qrrDupli: TRLLabel;
    rdbCTA: TRLDBText;
    rdbForn: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel13: TRLLabel;
    rlbResumo1: TRLBand;
    RLLabel12: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel11: TRLLabel;
    rllTitBoleto: TRLLabel;
    rdbBoleto: TRLDBText;
    rllEventos: TRLLabel;
    rllTitCheque: TRLLabel;
    rdbCheque: TRLDBText;
    rllBoleto: TRLLabel;
    rllCodCta: TRLLabel;
    rlbResumo2: TRLBand;
    rdbNomFor: TRLDBText;
    rdbValDup: TRLDBText;
    RLLabel19: TRLLabel;
    RLDBResult1: TRLDBResult;
    rlbTitulo2: TRLBand;
    rllNomFor: TRLLabel;
    RLLabel20: TRLLabel;
    rllIncPrevis: TRLLabel;
    rllTitPrevisao: TRLLabel;
    rdbPrevisao: TRLDBText;
    rlbAgrupamento: TRLSubDetail;
    rlbDetalheAgrupa: TRLBand;
    rllAgrEmp: TRLDBText;
    rllAgrValor: TRLDBText;
    rlbAgrupaEmpresa: TRLBand;
    rllAgrEmpresa: TRLLabel;
    rllAgrVl: TRLLabel;
    rlbSummaryAgrupa: TRLBand;
    rllAgrTotal: TRLDBResult;
    rllAgrTotGeral: TRLLabel;
    RLBand1: TRLBand;
    rllValBol: TRLLabel;
    rllValChq: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    rllTitDeposito: TRLLabel;
    rdbDeposito: TRLDBText;
    rllDeposito: TRLLabel;
    rdbHistorico: TRLLabel;
    RLLabel5: TRLLabel;
    rllValDep: TRLLabel;
    RLLabel6: TRLLabel;
    rllValOut: TRLLabel;
    rlbEvento: TRLDBText;
    rllAtividade: TRLLabel;
    rllPortador: TRLLabel;
    rdbHistoricoCompleto: TRLLabel;
    rlbTituloRes: TRLBand;
    RLLabel14: TRLLabel;
    RLLabel17: TRLLabel;
    RLLabel21: TRLLabel;
    RLLabel22: TRLLabel;
    rllTitHistoricoRes: TRLLabel;
    RLLabel24: TRLLabel;
    RLLabel25: TRLLabel;
    RLLabel18: TRLLabel;
    RLLabel26: TRLLabel;
    RLLabel27: TRLLabel;
    rlbGrupoRes: TRLGroup;
    rlbTituloGrupoRes: TRLBand;
    rlbEventoRes: TRLDBText;
    rlbDetalheGrupoRes: TRLBand;
    RLDBText3: TRLDBText;
    RLLabel28: TRLLabel;
    RLDBText5: TRLDBText;
    rdbFornRes: TRLDBText;
    RLDBText9: TRLDBText;
    rdbHistoricoRes: TRLLabel;
    rlbResumoGrupoRes: TRLBand;
    RLLabel31: TRLLabel;
    rllResData: TRLLabel;
    rllResValTot: TRLLabel;
    rllResTotal: TRLLabel;
    rllValOri: TRLDBText;
    rllDesSuj: TRLDBText;
    rlbJurSuj: TRLDBText;
    rllValLiq: TRLLabel;
    rdbHistoricoCompletoRes: TRLLabel;
    dtsRelatorio: TDataSource;
    rllVeioNF: TRLLabel;
    rllForPgt: TRLLabel;
    rllTitFor: TRLLabel;
    rlbValPgt: TRLLabel;
    rllCheque: TRLLabel;
    rllAjuDta: TRLLabel;
    procedure rllOrdemBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel9BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBText1BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel10BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel12BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBText7BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel16BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel15BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure qrrDupliBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBText6BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rdbBoletoBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rdbFornBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rdbChequeBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rdbPrevisaoBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rdbDepositoBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rdbHistoricoBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rlbEventoBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure rllValLiqBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllValOriBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllDesSujBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rlbJurSujBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rlbDetalheGrupoResBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rdbValDupBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllPaginaBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel5BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllTitForBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
  private
    dtaVencimento: TDateTime;
    curValor,curValorTotal: Currency;
    { Private declarations }
  public
    { Public declarations }
    cdsRelatorio : TUniClientDataSet;
    intValorExibido : Integer;
    strTipImp: String;
    procedure pHistoricoCompleto;    
  end;

var
  frmQckCtpAnalDebitos: TfrmQckCtpAnalDebitos;

implementation

uses untModulo, untfuncoesfactory;

{$R *.dfm}

procedure TfrmQckCtpAnalDebitos.rllDesSujBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(dtsRelatorio.dataSet.FieldByName('CTP_DESSUJ').AsFloat,ffNumber,15,2);
end;

procedure TfrmQckCtpAnalDebitos.rllOrdemBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := strOrdem;
end;

procedure TfrmQckCtpAnalDebitos.rllPaginaBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  If strTipImp = 'M' Then
    Text := 'PAGINA ' + IntToStr(qckPagina.PageNumber)
  Else
    Text := 'PÁGINA ' + IntToStr(qckPagina.PageNumber);
end;

procedure TfrmQckCtpAnalDebitos.rllTitForBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  If strTipImp = 'M' Then
    Text := 'FORMAS DE PAGAMENTO (PREVISAO)'
  Else
    Text := 'FORMAS DE PAGAMENTO (PREVISÃO)';
end;

procedure TfrmQckCtpAnalDebitos.RLLabel9BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := '';
end;

procedure TfrmQckCtpAnalDebitos.RLDBText1BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  dtaVencimento := dtsRelatorio.dataSet.FieldByName('CTP_DTAVEN').AsDateTime;
  Text := FormatDateTime('dd/mm/yy',dtsRelatorio.dataSet.FieldByName('CTP_DTAVEN').AsDateTime);
end;

procedure TfrmQckCtpAnalDebitos.rllValOriBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(dtsRelatorio.dataSet.FieldByName('CTP_VALORI').AsFloat,ffNumber,15,2);
end;

procedure TfrmQckCtpAnalDebitos.RLLabel10BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FormatDateTime('dd/mm/yyyy',dtaVencimento);
end;

procedure TfrmQckCtpAnalDebitos.RLLabel12BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := '';
end;

procedure TfrmQckCtpAnalDebitos.RLDBText7BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;

  If intValorExibido = 1 Then
  Begin
    curValor      := curValor + (dtsRelatorio.dataSet.FieldByName('CTP_VALDUP').AsFloat -
                                 dtsRelatorio.dataSet.FieldByName('CTP_DESSUJ').AsFloat +
                                 dtsRelatorio.dataSet.FieldByName('CTP_JURSUJ').AsFloat +
                                 dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsFloat);

    curValorTotal := curValorTotal + (dtsRelatorio.dataSet.FieldByName('CTP_VALDUP').AsFloat -
                                      dtsRelatorio.dataSet.FieldByName('CTP_DESSUJ').AsFloat +
                                      dtsRelatorio.dataSet.FieldByName('CTP_JURSUJ').AsFloat +
                                      dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsFloat);

    Text          := FloatToStrF((dtsRelatorio.dataSet.FieldByName('CTP_VALDUP').AsFloat -
                                  dtsRelatorio.dataSet.FieldByName('CTP_DESSUJ').AsFloat +
                                  dtsRelatorio.dataSet.FieldByName('CTP_JURSUJ').AsFloat +
                                  dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsFloat),ffNumber,15,2);
   End
  Else If intValorExibido = 2 Then
  Begin
    curValor      := curValor + (dtsRelatorio.dataSet.FieldByName('CTP_VALDUP').AsFloat +
                                 dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsFloat);

    curValorTotal := curValorTotal + (dtsRelatorio.dataSet.FieldByName('CTP_VALDUP').AsFloat +
                                      dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsFloat);

    Text          := FloatToStrF((dtsRelatorio.dataSet.FieldByName('CTP_VALDUP').AsFloat +
                                  dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsFloat),ffNumber,15,2);
  End;
end;

procedure TfrmQckCtpAnalDebitos.RLLabel16BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValor,ffNumber,15,2);
  curValor := 0;
end;

procedure TfrmQckCtpAnalDebitos.RLLabel5BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  If strTipImp = 'M' Then
    Text := 'DEPOSITO'
  Else
    Text := 'DEPÓSITO';
end;

procedure TfrmQckCtpAnalDebitos.rllValLiqBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;

  If intValorExibido = 1 Then
  Begin
    curValor      := curValor + (dtsRelatorio.dataSet.FieldByName('CTP_VALDUP').AsFloat -
                                 dtsRelatorio.dataSet.FieldByName('CTP_DESSUJ').AsFloat +
                                 dtsRelatorio.dataSet.FieldByName('CTP_JURSUJ').AsFloat +
                                 dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsFloat);

    curValorTotal := curValorTotal + (dtsRelatorio.dataSet.FieldByName('CTP_VALDUP').AsFloat -
                                      dtsRelatorio.dataSet.FieldByName('CTP_DESSUJ').AsFloat +
                                      dtsRelatorio.dataSet.FieldByName('CTP_JURSUJ').AsFloat +
                                      dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsFloat);

    Text          := FloatToStrF((dtsRelatorio.dataSet.FieldByName('CTP_VALDUP').AsFloat -
                                  dtsRelatorio.dataSet.FieldByName('CTP_DESSUJ').AsFloat +
                                  dtsRelatorio.dataSet.FieldByName('CTP_JURSUJ').AsFloat +
                                  dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsFloat),ffNumber,15,2);
  End
  Else If intValorExibido = 2 Then
  Begin
    curValor      := curValor + (dtsRelatorio.dataSet.FieldByName('CTP_VALDUP').AsFloat +
                                 dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsFloat);

    curValorTotal := curValorTotal + (dtsRelatorio.dataSet.FieldByName('CTP_VALDUP').AsFloat +
                                      dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsFloat);

    Text          := FloatToStrF((dtsRelatorio.dataSet.FieldByName('CTP_VALDUP').AsFloat +
                                  dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsFloat),ffNumber,15,2);
  End;
end;

procedure TfrmQckCtpAnalDebitos.RLLabel15BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorTotal,ffNumber,15,2);
  curValorTotal := 0;
end;

procedure TfrmQckCtpAnalDebitos.qrrDupliBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := dtsRelatorio.dataSet.FieldByName('CTP_NUMDUP').AsString +
    dtsRelatorio.dataSet.FieldByName('CTP_PARCEL').AsString;
end;

procedure TfrmQckCtpAnalDebitos.RLDBText6BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FormatDateTime('dd/mm/yy',dtsRelatorio.dataSet.FieldByName('CTP_DTACAD').AsDateTime);
end;

procedure TfrmQckCtpAnalDebitos.rdbBoletoBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  If dtsRelatorio.dataSet.FieldByName('CTP_VEIOBO').AsString = 'S' Then
    Text := 'SIM'
  Else
    Text := IfThen(strTipImp = 'M', 'NAO', 'NÃO');
end;

procedure TfrmQckCtpAnalDebitos.rdbDepositoBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  If dtsRelatorio.dataSet.FieldByName('CTP_DEPOSI').AsString = 'S' Then
    Text := 'SIM'
  Else
    Text := IfThen(strTipImp = 'M', 'NAO', 'NÃO');
end;

procedure TfrmQckCtpAnalDebitos.rdbFornBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := dtsRelatorio.dataSet.FieldByName('CTP_CODFOR').AsString + '-' +
    dtsRelatorio.dataSet.FieldByName('FOR_NOMFOR').AsString;
end;

procedure TfrmQckCtpAnalDebitos.rdbChequeBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;

  If (dtsRelatorio.dataSet.FieldByName('CTP_USACHQ').AsString = 'S') Then
    Text := 'SIM'
  Else
    Text := IfThen(strTipImp = 'M', 'NAO', 'NÃO');

end;

procedure TfrmQckCtpAnalDebitos.rdbPrevisaoBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;

  If (dtsRelatorio.dataSet.FieldByName('CTP_PREVIS').AsString = 'S') Then
    Text := 'SIM'
  Else
    Text := IfThen(strTipImp = 'M', 'NAO', 'NÃO');

end;

procedure TfrmQckCtpAnalDebitos.rdbValDupBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text  := FloatToStrF(dtsRelatorio.dataSet.FieldByName('CTP_VALDUP').AsFloat,ffNumber,15,2);
end;

procedure TfrmQckCtpAnalDebitos.rlbDetalheGrupoResBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;

  If (rlbDetalheGrupoRes.Color = Cor1) Then
    rlbDetalheGrupoRes.Color := Cor2
  Else
    rlbDetalheGrupoRes.Color := Cor1;

end;

procedure TfrmQckCtpAnalDebitos.rlbEventoBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  If TRLDBText(Sender).DataField = 'CTP_CODEVE' then
    Text := 'CENTRO DE CUSTOS: ' + Text + '-' + fRetNomEvento(Text)
  Else If TRLDBText(Sender).DataField = 'CTP_CODPOR' then
    Text := 'PORTADOR: ' + Text + '-' + fRetNomPortador(Text)
  Else If TRLDBText(Sender).DataField = 'ATI_CODATI' then
    Text := 'ATIVIDADE: ' + Text + '-' + fRetNomAtividade(Text);
end;

procedure TfrmQckCtpAnalDebitos.rlbJurSujBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(dtsRelatorio.dataSet.FieldByName('CTP_JURSUJ').AsFloat,ffNumber,15,2);
end;

procedure TfrmQckCtpAnalDebitos.FormCreate(Sender: TObject);
begin
  inherited;
  If fCfgSis('MODREL_TAP') = '1' Then
    rlbDetalheGrupo.Height := 17
  Else
    rlbDetalheGrupoRes.Height := 17;
end;

procedure TfrmQckCtpAnalDebitos.pHistoricoCompleto;
begin
  If fCfgSis('MODREL_TAP') = '1' Then
  Begin
    rdbHistoricoCompleto.Visible := True;
    rllTitHistorico.Visible      := False;
    rdbHistorico.Visible         := False;
    rlbDetalheGrupo.Height       := 33;

    rllTitCheque.Left            := rllTitCheque.Left + 115;
    rdbCheque.Left               := rdbCheque.Left + 115;
    rllTitPrevisao.Left          := rllTitPrevisao.Left + 115;
    rdbPrevisao.Left             := rdbPrevisao.Left + 115;

    rdbForn.Width                := 253;
  End
  Else
  Begin
    rdbHistoricoCompletoRes.Visible := True;
    rllTitHistoricoRes.Visible      := False;
    rdbHistoricoRes.Visible         := False;
    rlbDetalheGrupoRes.Height       := 33;

    rdbFornRes.Width                := 253;
  End;
end;

procedure TfrmQckCtpAnalDebitos.rdbHistoricoBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := AnsiReplaceStr(AnsiReplaceStr(dtsRelatorio.dataSet.FieldByName('CTP_HISCOM').AsString,#13#10,' '),'<<csq>>',' ');
end;

end.

