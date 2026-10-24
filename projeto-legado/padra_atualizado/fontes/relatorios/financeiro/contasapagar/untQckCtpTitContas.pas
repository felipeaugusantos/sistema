unit untQckCtpTitContas;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiQck, RLReport, strUtils, RLParser, RLPreviewForm,
  Data.DB, untIFuncoes;

type
  TfrmQckCtpTitContas = class(TfrmPaiQck)
    rlbTotalGrupo: TRLBand;
    rlbTotalParcial: TRLBand;
    rdbFornSint: TRLDBText;
    qrrDupli: TRLLabel;
    RLDBText8: TRLDBText;
    rdbDtaVen: TRLDBText;
    rbdData: TRLDBText;
    RLDBText9: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText7: TRLDBText;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    rllData: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel17: TRLLabel;
    RLLabel18: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel20: TRLLabel;
    RLLabel21: TRLLabel;
    RLLabel22: TRLLabel;
    RLLabel23: TRLLabel;
    RLLabel24: TRLLabel;
    RLLabel25: TRLLabel;
    RLLabel26: TRLLabel;
    RLLabel27: TRLLabel;
    RLLabel28: TRLLabel;
    RLBand1: TRLBand;
    RLLabel29: TRLLabel;
    rllTotalGeral: TRLLabel;
    RLLabel31: TRLLabel;
    RLLabel32: TRLLabel;
    RLLabel33: TRLLabel;
    RLLabel34: TRLLabel;
    rllLinha: TRLLabel;
    rllGrupo: TRLLabel;
    rllSubGrupo: TRLLabel;
    rllConta: TRLLabel;
    rllEmpresa: TRLLabel;
    rllEventos: TRLLabel;
    RLLabel6: TRLLabel;
    RLDBText1: TRLDBText;
    rlbGrupo2: TRLGroup;
    rlbGrupo3: TRLGroup;
    rlbTituloGrupo2: TRLBand;
    RLDBText10: TRLDBText;
    rlbTituloGrupo3: TRLBand;
    RLDBText11: TRLDBText;
    rlbDetalheSint: TRLBand;
    rdbFornAna: TRLDBText;
    qrrDupl2: TRLLabel;
    RLDBText13: TRLDBText;
    rdbDtaVen2: TRLDBText;
    rbdData2: TRLDBText;
    RLDBText17: TRLDBText;
    RLDBText18: TRLDBText;
    RLDBText19: TRLDBText;
    RLDBText20: TRLDBText;
    RLDBText21: TRLDBText;
    rlbSumarioGrupo3: TRLBand;
    RLLabel35: TRLLabel;
    RLDBResult4: TRLDBResult;
    RLDBResult1: TRLDBResult;
    RLDBResult2: TRLDBResult;
    rlbSumarioGrupo2: TRLBand;
    rllTotRes: TRLLabel;
    RLDBResult5: TRLDBResult;
    RLDBResult6: TRLDBResult;
    RLDBResult7: TRLDBResult;
    RLDBResult8: TRLDBResult;
    rllTitRes: TRLLabel;
    RLLabel38: TRLLabel;
    rllOrdenacao: TRLLabel;
    RLLabel30: TRLLabel;
    RLDBText16: TRLDBText;
    RLDBText22: TRLDBText;
    RLLabel3: TRLLabel;
    RLLabel39: TRLLabel;
    rdbDtaCad: TRLDBText;
    rdbDtaCad2: TRLDBText;
    RLLabel40: TRLLabel;
    RLDBText23: TRLDBText;
    RLDBText24: TRLDBText;
    rllBoleto: TRLLabel;
    rllForHis: TRLLabel;
    rllFimCta: TRLLabel;
    rllIncPrevis: TRLLabel;
    rllHistorico: TRLLabel;
    rdbHistorico: TRLDBText;
    rdbHitorico2: TRLDBText;
    rllFornecedor: TRLLabel;
    rlbVendorGru1: TRLDBText;
    rlbVendor: TRLDBText;
    rllVendor: TRLLabel;
    rllVendorPar: TRLLabel;
    rllVendorTotGru: TRLLabel;
    rllVendorResGru: TRLLabel;
    rlbVendorGru3: TRLDBResult;
    rlbVendorGru2: TRLDBResult;
    rllVendorRod: TRLLabel;
    rllPorBai: TRLLabel;
    rllValorExibido: TRLLabel;
    RLDBText2: TRLDBText;
    dtsRelatorio: TDataSource;
    RLLabel36: TRLLabel;
    rllPortador: TRLLabel;
    procedure rlbTituloGrupoBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rllLinhaBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllGrupoBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllSubGrupoBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rdbFornSintBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllOrdemBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rlbTotalParcialAfterPrint(Sender: TObject);
    procedure rdbDtaVenBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBText7BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBText5BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBText3BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBText9BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel11BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel17BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel23BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel29BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rbdDataBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel13BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel14BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel15BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel16BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel19BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel20BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel21BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel22BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel25BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel26BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel27BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel28BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel31BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel32BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel33BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel34BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure qrrDupliBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBText8BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBText1BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rdbDtaCadBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rdbHistoricoBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rlbDetalheGrupoBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbDetalheSintBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rdbHitorico2BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rlbGrupo2BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure rlbVendorGru1BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllVendorParBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllVendorTotGruBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllVendorResGruBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rlbVendorBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllVendorRodBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel9BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLLabel10BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLDBResult2BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLDBResult8BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLDBResult1BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLDBResult7BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
  private
    strLinha, strGrupo, strSubGrupo, strCodCta: String;
    curValorParcial1, curValorParcial2, curValorParcial3, curValorParcial4,
    curValorParcial5,
    curValorGrupo1, curValorGrupo2, curValorGrupo3, curValorGrupo4,
    curValorGrupo5,
    curValorLinha1, curValorLinha2, curValorLinha3, curValorLinha4,
    curValorLinha5,
    curValorGeral1, curValorGeral2, curValorGeral3, curValorGeral4,
    curValorGeral5: Currency;
    { Private declarations }
  public
    { Public declarations }
    strForHis: String;
    blnQueEve: Boolean;
    blnQueFor: Boolean;
    strValExi: String;    
  end;

var
  frmQckCtpTitContas: TfrmQckCtpTitContas;

implementation

uses untfuncoesFactory;

{$R *.dfm}

procedure TfrmQckCtpTitContas.rlbTituloGrupoBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;

  strCodCta := dtsRelatorio.dataSet.FieldByName('CTA_CODCTA').AsString;
  rlbTotalGrupo.Visible   := False;
  rlbResumoGrupo.Visible  := False;

  If (strLinha = '') And (strGrupo = '') And (strSubGrupo = '') Then
  Begin
    rlbTituloGrupo.Height := 73;
    Insert('.',strCodCta,3);
    Insert('.',strCodCta,6);
    strLinha                := LeftStr(strCodCta,2) + '.00.000';
    strGrupo                := LeftStr(strCodCta,5) + '.000';
    strSubGrupo             := strCodCta;
    rllLinha.Visible        := True;
    rllGrupo.Visible        := True;
    rllSubGrupo.Visible     := True;
    rllLinha.Top            := 4;
    rllGrupo.Top            := 28;
    rllSubGrupo.Top         := 52;
    rlbTotalParcial.Visible := True;
  End
  Else
  Begin

    If LeftStr(strCodCta,2) <> LeftStr(strLinha,2) Then
    Begin
      rlbTituloGrupo.Height := 73;
      Insert('.',strCodCta,3);
      Insert('.',strCodCta,6);
      strLinha                := LeftStr(strCodCta,2) + '.00.000';
      strGrupo                := LeftStr(strCodCta,5) + '.000';
      strSubGrupo             := strCodCta;
      rllLinha.Visible        := True;
      rllGrupo.Visible        := True;
      rllSubGrupo.Visible     := True;
      rllLinha.Top            := 4;
      rllGrupo.Top            := 28;
      rllSubGrupo.Top         := 52;
      rlbTotalParcial.Visible := True;
    End
    Else
    If LeftStr(strCodCta,4) <> LeftStr(AnsiReplaceStr(strGrupo,'.',''),4) Then
    Begin
      rlbTituloGrupo.Height := 49;
      Insert('.',strCodCta,3);
      Insert('.',strCodCta,6);
      strLinha                := LeftStr(strCodCta,2) + '.00.000';
      strGrupo                := LeftStr(strCodCta,5) + '.000';
      strSubGrupo             := strCodCta;
      rllLinha.Visible        := False;
      rllGrupo.Visible        := True;
      rllSubGrupo.Visible     := True;
      rllLinha.Top            := 4;
      rllGrupo.Top            := 4;
      rllSubGrupo.Top         := 28;
      rlbTotalParcial.Visible := True;
    End
    Else
    If strCodCta <> AnsiReplaceStr(strSubGrupo,'.','') Then
    Begin
      rlbTituloGrupo.Height := 25;
      Insert('.',strCodCta,3);
      Insert('.',strCodCta,6);
      strLinha                := LeftStr(strCodCta,2) + '.00.000';
      strGrupo                := LeftStr(strCodCta,5) + '.000';
      strSubGrupo             := strCodCta;
      rllLinha.Visible        := False;
      rllGrupo.Visible        := False;
      rllSubGrupo.Visible     := True;
      rllLinha.Top            := 4;
      rllGrupo.Top            := 4;
      rllSubGrupo.Top         := 4;
      rlbTotalParcial.Visible := True;
    End;

  End;
end;

procedure TfrmQckCtpTitContas.rllLinhaBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := 'LINHA: ' + strLinha + ' - ' + fRetNomeConta(AnsiReplaceStr(strLinha,'.',''));
end;

procedure TfrmQckCtpTitContas.rllGrupoBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := 'GRUPO: ' + strGrupo + ' - ' + fRetNomeConta(AnsiReplaceStr(strGrupo,'.',''));
end;

procedure TfrmQckCtpTitContas.rllSubGrupoBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := strSubGrupo + ' - ' + fRetNomeConta(AnsiReplaceStr(strSubGrupo,'.',''));
end;

procedure TfrmQckCtpTitContas.rllVendorParBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorParcial5,ffNumber,15,2);
  curValorParcial5 := 0;
end;

procedure TfrmQckCtpTitContas.rllVendorResGruBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorLinha5,ffNumber,15,2);
  curValorLinha5 := 0;
end;

procedure TfrmQckCtpTitContas.rllVendorRodBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorGeral5,ffNumber,15,2);
  curValorGeral5 := 0;
end;

procedure TfrmQckCtpTitContas.rllVendorTotGruBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorGrupo5,ffNumber,15,2);
  curValorGrupo5 := 0;
end;

procedure TfrmQckCtpTitContas.rdbFornSintBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;

  If strForHis = 'F' Then
    Text := dtsRelatorio.dataSet.FieldByName('CTP_CODFOR').AsString + ' - ' +
            dtsRelatorio.dataSet.FieldByName('FOR_NOMFOR').AsString
  Else
    Text := dtsRelatorio.dataSet.FieldByName('CTP_HIST01').AsString;
    
end;

procedure TfrmQckCtpTitContas.rllOrdemBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
Begin
  inherited;
  Text := strOrdem;
end;

procedure TfrmQckCtpTitContas.rlbTotalParcialAfterPrint(Sender: TObject);
begin
  inherited;
  strCodCta := dtsRelatorio.dataSet.FieldByName('CTP_CODCTA').AsString;
  If LeftStr(strCodCta,2) <> LeftStr(strLinha,2) Then
  Begin
    rlbTotalGrupo.Visible   := True;
    rlbTotalParcial.Visible := True;
    rlbResumoGrupo.Visible  := True;
  End
  Else
  If LeftStr(strCodCta,4) <> LeftStr(AnsiReplaceStr(strGrupo,'.',''),4) Then
  Begin
    rlbTotalGrupo.Visible   := True;
    rlbTotalParcial.Visible := True;
  End
  Else
  If dtsRelatorio.dataSet.Eof Then
  Begin
    rlbTotalGrupo.Visible   := True;
    rlbTotalParcial.Visible := True;
    rlbResumoGrupo.Visible  := True;
  End;
end;

procedure TfrmQckCtpTitContas.rlbVendorBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  curValorParcial5 := curValorParcial5 + dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency;
  curValorGrupo5   := curValorGrupo5 + dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency;
  curValorLinha5   := curValorLinha5 + dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency;
  curValorGeral5   := curValorGeral5 + dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency;
  Text := FloatToStrF(dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency,ffNumber,15,2);
  PrintIt := (strValExi = '1');
end;

procedure TfrmQckCtpTitContas.rlbVendorGru1BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  curValorParcial5 := curValorParcial5 + dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency;
  curValorGrupo5   := curValorGrupo5 + dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency;
  curValorLinha5   := curValorLinha5 + dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency;
  curValorGeral5   := curValorGeral5 + dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency;
  Text := FloatToStrF(dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency,ffNumber,15,2);
end;

procedure TfrmQckCtpTitContas.rdbDtaVenBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  If Not dtsRelatorio.dataSet.FieldByName('CTP_DTAVEN').IsNull Then
  Begin
    Text := FormatDateTime('dd/mm/yy',dtsRelatorio.dataSet.FieldByName('CTP_DTAVEN').AsDateTime);
  End;
end;

procedure TfrmQckCtpTitContas.RLDBText7BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  curValorParcial4 := curValorParcial4 + dtsRelatorio.dataSet.FieldByName('CTP_VALDES').AsCurrency;
  curValorGrupo4   := curValorGrupo4 + dtsRelatorio.dataSet.FieldByName('CTP_VALDES').AsCurrency;
  curValorLinha4   := curValorLinha4 + dtsRelatorio.dataSet.FieldByName('CTP_VALDES').AsCurrency;
  curValorGeral4   := curValorGeral4 + dtsRelatorio.dataSet.FieldByName('CTP_VALDES').AsCurrency;
  Text := FloatToStrF(dtsRelatorio.dataSet.FieldByName('CTP_VALDES').AsCurrency,ffNumber,15,2);
  PrintIt := (strValExi = '1');
end;

procedure TfrmQckCtpTitContas.RLDBText5BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  curValorParcial3 := curValorParcial3 + dtsRelatorio.dataSet.FieldByName('CTP_VALJUR').AsCurrency;
  curValorGrupo3   := curValorGrupo3 + dtsRelatorio.dataSet.FieldByName('CTP_VALJUR').AsCurrency;
  curValorLinha3   := curValorLinha3 + dtsRelatorio.dataSet.FieldByName('CTP_VALJUR').AsCurrency;
  curValorGeral3   := curValorGeral3 + dtsRelatorio.dataSet.FieldByName('CTP_VALJUR').AsCurrency;
  Text := FloatToStrF(dtsRelatorio.dataSet.FieldByName('CTP_VALJUR').AsCurrency,ffNumber,15,2);
  PrintIt := (strValExi = '1');
end;

procedure TfrmQckCtpTitContas.RLDBText3BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  curValorParcial2 := curValorParcial2 + dtsRelatorio.dataSet.FieldByName('CTP_VALPAG').AsCurrency;
  curValorGrupo2   := curValorGrupo2 + dtsRelatorio.dataSet.FieldByName('CTP_VALPAG').AsCurrency;
  curValorLinha2   := curValorLinha2 + dtsRelatorio.dataSet.FieldByName('CTP_VALPAG').AsCurrency;
  curValorGeral2   := curValorGeral2 + dtsRelatorio.dataSet.FieldByName('CTP_VALPAG').AsCurrency;
  Text := FloatToStrF(dtsRelatorio.dataSet.FieldByName('CTP_VALPAG').AsCurrency,ffNumber,15,2);
end;

procedure TfrmQckCtpTitContas.RLDBText9BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;

  If dtsRelatorio.dataSet.FieldByName('CTP_DTAPAG').IsNull Then
  Begin

    If (strValExi = '1') Then
    Begin
      curValorParcial1 := curValorParcial1 + (dtsRelatorio.dataSet.FieldByName('CTP_VALDUP').AsCurrency -
                                              dtsRelatorio.dataSet.FieldByName('CTP_DESSUJ').AsCurrency +
                                              dtsRelatorio.dataSet.FieldByName('CTP_JURSUJ').AsCurrency +
                                              dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency);

      curValorGrupo1   := curValorGrupo1 + (dtsRelatorio.dataSet.FieldByName('CTP_VALDUP').AsCurrency -
                                            dtsRelatorio.dataSet.FieldByName('CTP_DESSUJ').AsCurrency +
                                            dtsRelatorio.dataSet.FieldByName('CTP_JURSUJ').AsCurrency +
                                            dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency);

      curValorLinha1   := curValorLinha1 + (dtsRelatorio.dataSet.FieldByName('CTP_VALDUP').AsCurrency -
                                            dtsRelatorio.dataSet.FieldByName('CTP_DESSUJ').AsCurrency +
                                            dtsRelatorio.dataSet.FieldByName('CTP_JURSUJ').AsCurrency +
                                            dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency);

      curValorGeral1   := curValorGeral1 + (dtsRelatorio.dataSet.FieldByName('CTP_VALDUP').AsCurrency -
                                            dtsRelatorio.dataSet.FieldByName('CTP_DESSUJ').AsCurrency +
                                            dtsRelatorio.dataSet.FieldByName('CTP_JURSUJ').AsCurrency +
                                            dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency);

      Text := FloatToStrF((dtsRelatorio.dataSet.FieldByName('CTP_VALDUP').AsCurrency -
                           dtsRelatorio.dataSet.FieldByName('CTP_DESSUJ').AsCurrency +
                           dtsRelatorio.dataSet.FieldByName('CTP_JURSUJ').AsCurrency +
                           dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency),ffNumber,15,2);
    End
    Else
    Begin
      curValorParcial1 := curValorParcial1 + (dtsRelatorio.dataSet.FieldByName('CTP_VALDUP').AsCurrency +
                                              dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency);

      curValorGrupo1   := curValorGrupo1 + (dtsRelatorio.dataSet.FieldByName('CTP_VALDUP').AsCurrency +
                                            dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency);

      curValorLinha1   := curValorLinha1 + (dtsRelatorio.dataSet.FieldByName('CTP_VALDUP').AsCurrency +
                                            dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency);

      curValorGeral1   := curValorGeral1 + (dtsRelatorio.dataSet.FieldByName('CTP_VALDUP').AsCurrency +
                                            dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency);

      Text := FloatToStrF((dtsRelatorio.dataSet.FieldByName('CTP_VALDUP').AsCurrency +
                           dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency),ffNumber,15,2);
    End;
  End
  Else
  Begin
    If (strValExi = '1') Then
    Begin
      curValorParcial1 := curValorParcial1 + dtsRelatorio.dataSet.FieldByName('CTP_VALORI').AsFloat-
                                             dtsRelatorio.dataSet.FieldByName('CTP_VALDES').AsCurrency +
                                             dtsRelatorio.dataSet.FieldByName('CTP_VALJUR').AsCurrency +
                                             dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency;

      curValorGrupo1   := curValorGrupo1   + dtsRelatorio.dataSet.FieldByName('CTP_VALORI').AsFloat-
                                             dtsRelatorio.dataSet.FieldByName('CTP_VALDES').AsCurrency +
                                             dtsRelatorio.dataSet.FieldByName('CTP_VALJUR').AsCurrency +
                                             dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency;

      curValorLinha1   := curValorLinha1   + dtsRelatorio.dataSet.FieldByName('CTP_VALORI').AsFloat-
                                             dtsRelatorio.dataSet.FieldByName('CTP_VALDES').AsCurrency +
                                             dtsRelatorio.dataSet.FieldByName('CTP_VALJUR').AsCurrency +
                                             dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency;

      curValorGeral1   := curValorGeral1   + dtsRelatorio.dataSet.FieldByName('CTP_VALORI').AsFloat-
                                             dtsRelatorio.dataSet.FieldByName('CTP_VALDES').AsCurrency +
                                             dtsRelatorio.dataSet.FieldByName('CTP_VALJUR').AsCurrency +
                                             dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency;

      Text             := FloatToStrF(dtsRelatorio.dataSet.FieldByName('CTP_VALORI').AsFloat-
                                      dtsRelatorio.dataSet.FieldByName('CTP_VALDES').AsCurrency +
                                      dtsRelatorio.dataSet.FieldByName('CTP_VALJUR').AsCurrency +
                                      dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency, ffNumber,15,2);
    end
    else
    begin
      curValorParcial1 := curValorParcial1 + dtsRelatorio.dataSet.FieldByName('CTP_VALORI').AsFloat+
                                             dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency;

      curValorGrupo1   := curValorGrupo1   + dtsRelatorio.dataSet.FieldByName('CTP_VALORI').AsFloat+
                                             dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency;

      curValorLinha1   := curValorLinha1   + dtsRelatorio.dataSet.FieldByName('CTP_VALORI').AsFloat+
                                             dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency;

      curValorGeral1   := curValorGeral1   + dtsRelatorio.dataSet.FieldByName('CTP_VALORI').AsFloat+
                                             dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency;

      Text             := FloatToStrF(dtsRelatorio.dataSet.FieldByName('CTP_VALORI').AsFloat+
                                      dtsRelatorio.dataSet.FieldByName('CTP_VENDOR').AsCurrency, ffNumber,15,2);
    end;

  End;

end;

procedure TfrmQckCtpTitContas.RLLabel10BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  PrintIt := (strValExi = '1');
end;

procedure TfrmQckCtpTitContas.RLLabel11BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := '';
end;

procedure TfrmQckCtpTitContas.RLLabel17BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := '';
end;

procedure TfrmQckCtpTitContas.RLLabel23BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := '';
end;

procedure TfrmQckCtpTitContas.RLLabel29BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := '';
end;

procedure TfrmQckCtpTitContas.rbdDataBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  If Text <> '' Then
    Text := FormatDateTime('dd/mm/yy',StrToDate(Text));
end;

procedure TfrmQckCtpTitContas.RLLabel13BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorParcial1,ffNumber,15,2);
  curValorParcial1 := 0;
end;

procedure TfrmQckCtpTitContas.RLLabel14BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorParcial2,ffNumber,15,2);
  curValorParcial2 := 0;
end;

procedure TfrmQckCtpTitContas.RLLabel15BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorParcial3,ffNumber,15,2);
  curValorParcial3 := 0;
  PrintIt := (strValExi = '1');
end;

procedure TfrmQckCtpTitContas.RLLabel16BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorParcial4,ffNumber,15,2);
  curValorParcial4 := 0;
  PrintIt := (strValExi = '1');
end;

procedure TfrmQckCtpTitContas.RLLabel19BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorGrupo1,ffNumber,15,2);
  curValorGrupo1 := 0;
end;

procedure TfrmQckCtpTitContas.RLLabel20BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorGrupo2,ffNumber,15,2);
  curValorGrupo2 := 0;
end;

procedure TfrmQckCtpTitContas.RLLabel21BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorGrupo3,ffNumber,15,2);
  curValorGrupo3 := 0;
  PrintIt := (strValExi = '1');
end;

procedure TfrmQckCtpTitContas.RLLabel22BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorGrupo4,ffNumber,15,2);
  curValorGrupo4 := 0;
  PrintIt := (strValExi = '1');
end;

procedure TfrmQckCtpTitContas.RLLabel25BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorLinha1,ffNumber,15,2);
  curValorLinha1 := 0;
end;

procedure TfrmQckCtpTitContas.RLLabel26BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorLinha2,ffNumber,15,2);
  curValorLinha2 := 0;
end;

procedure TfrmQckCtpTitContas.RLLabel27BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorLinha3,ffNumber,15,2);
  curValorLinha3 := 0;
  PrintIt := (strValExi = '1');
end;

procedure TfrmQckCtpTitContas.RLLabel28BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorLinha4,ffNumber,15,2);
  curValorLinha4 := 0;
  PrintIt := (strValExi = '1');
end;

procedure TfrmQckCtpTitContas.RLLabel31BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorGeral1,ffNumber,15,2);
  curValorGeral1 := 0;
end;

procedure TfrmQckCtpTitContas.RLLabel32BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorGeral2,ffNumber,15,2);
  curValorGeral2 := 0;
end;

procedure TfrmQckCtpTitContas.RLLabel33BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorGeral3,ffNumber,15,2);
  curValorGeral3 := 0;
  PrintIt := (strValExi = '1');
end;

procedure TfrmQckCtpTitContas.RLLabel34BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(curValorGeral4,ffNumber,15,2);
  curValorGeral4 := 0;
  PrintIt := (strValExi = '1');
end;

procedure TfrmQckCtpTitContas.RLLabel9BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  PrintIt := (strValExi = '1');
end;

procedure TfrmQckCtpTitContas.FormCreate(Sender: TObject);
begin
  inherited;
  blnQueEve := False;
  blnQueFor := False;
end;

procedure TfrmQckCtpTitContas.qrrDupliBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := dtsRelatorio.dataSet.FieldByName('CTP_NUMDUP').AsString +
    dtsRelatorio.dataSet.FieldByName('CTP_PARCEL').AsString +
    ifthen(fEmptyStr(dtsRelatorio.dataSet.FieldByName('CTP_SERIE_').AsString) , '', '-' +
                  dtsRelatorio.dataSet.FieldByName('CTP_SERIE_').AsString);
end;

procedure TfrmQckCtpTitContas.RLDBText8BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  If dtsRelatorio.dataSet.FieldByName('CTP_VEIOBO').AsString = 'S' Then
    Text := 'SIM'
  Else
    Text := 'NAO';
end;

procedure TfrmQckCtpTitContas.RLDBResult1BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  PrintIt := (strValExi = '1');
end;

procedure TfrmQckCtpTitContas.RLDBResult2BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  PrintIt := (strValExi = '1');
end;

procedure TfrmQckCtpTitContas.RLDBResult7BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  PrintIt := (strValExi = '1');
end;

procedure TfrmQckCtpTitContas.RLDBResult8BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  PrintIt := (strValExi = '1');
end;

procedure TfrmQckCtpTitContas.RLDBText1BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;

  If (dtsRelatorio.dataSet.FieldByName('CTP_USACHQ').AsString = 'S') Then
    Text := 'SIM'
  Else
    Text := 'NAO';

end;

procedure TfrmQckCtpTitContas.rdbDtaCadBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;

  If Not dtsRelatorio.dataSet.FieldByName('CTP_DTACAD').IsNull Then
  Begin
    Text := FormatDateTime('dd/mm/yy',dtsRelatorio.dataSet.FieldByName('CTP_DTACAD').AsDateTime);
  End;

end;

procedure TfrmQckCtpTitContas.rdbHistoricoBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := AnsiReplaceStr(dtsRelatorio.dataSet.FieldByName('CTP_HIST01').AsString,'<<csq>>',' ') + ' ' +
          AnsiReplaceStr(dtsRelatorio.dataSet.FieldByName('CTP_HIST02').AsString,'<<csq>>',' ');
end;

procedure TfrmQckCtpTitContas.rlbDetalheGrupoBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  If (fEmptyStr(dtsRelatorio.dataSet.FieldByName('CTP_HIST01').AsString)) Or (strForHis = 'H') Then
  Begin
    rllHistorico.Visible := False;
    rdbHistorico.Visible := False;
    rlbDetalheGrupo.Height := 14;
  End
  Else
  Begin
    rllHistorico.Visible := True;
    rdbHistorico.Visible := True;
    rlbDetalheGrupo.Height := 27;
  End;
end;

procedure TfrmQckCtpTitContas.rlbDetalheSintBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  If (fEmptyStr(dtsRelatorio.dataSet.FieldByName('CTP_HIST01').AsString)) Or (strForHis = 'H') Then
  Begin
    rllHistorico.Visible := False;
    rdbHitorico2.Visible := False;
    rlbDetalheSint.Height := 14;
  End
  Else
  Begin
    rllHistorico.Visible := True;
    rdbHitorico2.Visible := True;
    rlbDetalheSint.Height := 27;
  End;
end;

procedure TfrmQckCtpTitContas.rlbGrupo2BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  If (blnQueEve) Then
    frmQckCtpTitContas.qckPagina.NewPage;

//  If (blnQueFor) Then
//    frmQckCtpTitContas.qckPagina.NewPage;
end;

procedure TfrmQckCtpTitContas.rdbHitorico2BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := AnsiReplaceStr(dtsRelatorio.dataSet.FieldByName('CTP_HIST01').AsString,'<<csq>>',' ') + ' ' +
          AnsiReplaceStr(dtsRelatorio.dataSet.FieldByName('CTP_HIST02').AsString,'<<csq>>',' ');
end;

end.


