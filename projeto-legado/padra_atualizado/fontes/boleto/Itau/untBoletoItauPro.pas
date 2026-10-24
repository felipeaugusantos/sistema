unit untBoletoItauPro;

interface

uses
  Windows, Classes, Controls, Forms, QRCtrls, QuickRpt, RLReport, QRPDFFilt,
  Graphics, ExtCtrls;

type
  TfrmQckBoletoItauPro = class(TForm)
    QckBoleto: TQuickRep;
    TitleBand1: TQRBand;
    LinhaHorizontal6: TQRShape;
    LinhaHorizontal5: TQRShape;
    LinhaHorizontal4: TQRShape;
    LinhaHorizontal3: TQRShape;
    LinhaHorizontal1: TQRShape;
    LinhaHorizontal2: TQRShape;
    LinhaVertical1: TQRShape;
    LinhaHorizontal7: TQRShape;
    LabelNrBanco: TQRLabel;
    LabelVencimento: TQRLabel;
    LinhaVertical2: TQRShape;
    LabelLocalPagamento: TQRLabel;
    LabelCedente: TQRLabel;
    LabelAgenciaCodigoCedente: TQRLabel;
    LabelDataDocumento: TQRLabel;
    LabelNrDocumento: TQRLabel;
    LabelEspecieDoc: TQRLabel;
    LabelAceite: TQRLabel;
    LabelDataProcessamento: TQRLabel;
    LabelNossoNumero: TQRLabel;
    LabelUsoBanco: TQRLabel;
    LabelCarteira: TQRLabel;
    LabelEspecie: TQRLabel;
    LabelReal: TQRLabel;
    LabelQuantidade: TQRLabel;
    LabelValor: TQRLabel;
    LabelX: TQRLabel;
    LabelValorDocumento: TQRLabel;
    QRLabel1: TQRLabel;
    LabelDesconto: TQRLabel;
    LabelMoraMulta: TQRLabel;
    LabelValorCobrado: TQRLabel;
    LabelSacado: TQRLabel;
    LabelSacadorAvalista: TQRLabel;
    LabelCodigoBaixa: TQRLabel;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    LabelNomeTitular: TQRLabel;
    LabelEndereco: TQRLabel;
    LabelCidade: TQRLabel;
    QRShape1: TQRShape;
    LabelInformacao1: TQRLabel;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape8: TQRShape;
    QRShape10: TQRShape;
    QRShape12: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRLabel40: TQRLabel;
    QRShape25: TQRShape;
    QRLabel42: TQRLabel;
    QRShape9: TQRShape;
    QRImage2: TQRImage;
    QRShape13: TQRShape;
    QRLabel6: TQRLabel;
    QRLabel50: TQRLabel;
    QRLabel51: TQRLabel;
    QRLabel56: TQRLabel;
    QRLabel54: TQRLabel;
    QRLabel57: TQRLabel;
    QRLabel58: TQRLabel;
    QRLabel59: TQRLabel;
    QRLabel60: TQRLabel;
    QRLabel61: TQRLabel;
    QRLabel62: TQRLabel;
    QRLabel63: TQRLabel;
    QRLabel64: TQRLabel;
    QRLabel65: TQRLabel;
    QRLabel66: TQRLabel;
    QRLabel68: TQRLabel;
    QRShape7: TQRShape;
    QRShape11: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRShape21: TQRShape;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRShape22: TQRShape;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel28: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel32: TQRLabel;
    QRLabel33: TQRLabel;
    QRLabel34: TQRLabel;
    QRShape23: TQRShape;
    QRShape24: TQRShape;
    QRLabel35: TQRLabel;
    QRLabel36: TQRLabel;
    QRLabel37: TQRLabel;
    QRShape26: TQRShape;
    QRShape27: TQRShape;
    QRShape29: TQRShape;
    QRShape30: TQRShape;
    QRShape31: TQRShape;
    QRShape32: TQRShape;
    QRShape33: TQRShape;
    QRShape34: TQRShape;
    QRShape35: TQRShape;
    QRLabel44: TQRLabel;
    QRShape36: TQRShape;
    QRLabel45: TQRLabel;
    QRImage1: TQRImage;
    QRShape37: TQRShape;
    QRLabel48: TQRLabel;
    QRLabel49: TQRLabel;
    QRLabel52: TQRLabel;
    QRLabel53: TQRLabel;
    QRLabel55: TQRLabel;
    QRLabel69: TQRLabel;
    QRLabel70: TQRLabel;
    QRLabel71: TQRLabel;
    QRLabel72: TQRLabel;
    QRLabel78: TQRLabel;
    QRLabel80: TQRLabel;
    QRLabel81: TQRLabel;
    QRLabel82: TQRLabel;
    QRLabel83: TQRLabel;
    QRLabel84: TQRLabel;
    InsSac: TQRLabel;
    QRLabel39: TQRLabel;
    QRLabel74: TQRLabel;
    QRLabel75: TQRLabel;
    QRLabel76: TQRLabel;
    QRLabel77: TQRLabel;
    QRLabel85: TQRLabel;
    QRLabel86: TQRLabel;
    QRLabel87: TQRLabel;
    QRLabel89: TQRLabel;
    QRLabel41: TQRLabel;
    QRLabel90: TQRLabel;
    QRLabel2: TQRLabel;
    qrlLinDig: TQRLabel;
    QRShape28: TQRShape;
    QRShape38: TQRShape;
    QRShape39: TQRShape;
    QRShape40: TQRShape;
    QRShape41: TQRShape;
    QRShape42: TQRShape;
    QRShape43: TQRShape;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRShape45: TQRShape;
    QRLabel38: TQRLabel;
    QRLabel43: TQRLabel;
    QRLabel47: TQRLabel;
    QRLabel67: TQRLabel;
    QRLabel79: TQRLabel;
    QRLabel91: TQRLabel;
    QRLabel92: TQRLabel;
    QRLabel93: TQRLabel;
    QRLabel94: TQRLabel;
    QRLabel95: TQRLabel;
    QRLabel96: TQRLabel;
    QRLabel97: TQRLabel;
    QRLabel98: TQRLabel;
    QRLabel99: TQRLabel;
    QRLabel100: TQRLabel;
    QRLabel101: TQRLabel;
    QRLabel102: TQRLabel;
    QRLabel103: TQRLabel;
    QRLabel104: TQRLabel;
    QRLabel105: TQRLabel;
    QRLabel106: TQRLabel;
    QRLabel107: TQRLabel;
    QRLabel108: TQRLabel;
    QRLabel109: TQRLabel;
    QRShape46: TQRShape;
    QRShape47: TQRShape;
    QRLabel111: TQRLabel;
    QRLabel112: TQRLabel;
    QRLabel113: TQRLabel;
    QRShape48: TQRShape;
    QRLabel114: TQRLabel;
    QRShape49: TQRShape;
    QRShape50: TQRShape;
    QRShape51: TQRShape;
    QRShape52: TQRShape;
    QRShape53: TQRShape;
    QRShape54: TQRShape;
    QRShape55: TQRShape;
    QRShape56: TQRShape;
    QRLabel115: TQRLabel;
    QRShape57: TQRShape;
    QRLabel116: TQRLabel;
    QRImage3: TQRImage;
    QRShape58: TQRShape;
    QRLabel117: TQRLabel;
    QRLabel118: TQRLabel;
    QRLabel119: TQRLabel;
    QRLabel120: TQRLabel;
    QRLabel121: TQRLabel;
    QRLabel122: TQRLabel;
    QRLabel123: TQRLabel;
    QRLabel124: TQRLabel;
    QRLabel125: TQRLabel;
    QRLabel126: TQRLabel;
    QRLabel127: TQRLabel;
    QRLabel128: TQRLabel;
    QRLabel129: TQRLabel;
    QRLabel130: TQRLabel;
    QRLabel131: TQRLabel;
    QRLabel132: TQRLabel;
    QRLabel133: TQRLabel;
    QRLabel134: TQRLabel;
    QRLabel136: TQRLabel;
    QRLabel137: TQRLabel;
    QRShape71: TQRShape;
    QRLabel166: TQRLabel;
    QRLabel146: TQRLabel;
    QRShape61: TQRShape;
    QRShape62: TQRShape;
    QRLabel167: TQRLabel;
    QRLabel143: TQRLabel;
    qrlNomeCedente1: TQRLabel;
    QRLabel148: TQRLabel;
    QRLabel149: TQRLabel;
    QRShape66: TQRShape;
    QRLabel151: TQRLabel;
    QRLabel150: TQRLabel;
    QRShape67: TQRShape;
    QRShape70: TQRShape;
    QRLabel153: TQRLabel;
    QRLabel152: TQRLabel;
    QRLabel154: TQRLabel;
    QRLabel155: TQRLabel;
    QRShape68: TQRShape;
    QRLabel156: TQRLabel;
    QRLabel157: TQRLabel;
    QRShape69: TQRShape;
    QRLabel158: TQRLabel;
    QRLabel159: TQRLabel;
    QRLabel160: TQRLabel;
    QRLabel161: TQRLabel;
    QRLabel73: TQRLabel;
    QRLabel162: TQRLabel;
    QRShape86: TQRShape;
    QRLabel163: TQRLabel;
    QRShape65: TQRShape;
    QRLabel181: TQRLabel;
    QRShape73: TQRShape;
    QRShape74: TQRShape;
    QRShape75: TQRShape;
    QRShape76: TQRShape;
    QRLabel172: TQRLabel;
    QRLabel171: TQRLabel;
    QRLabel170: TQRLabel;
    QRLabel168: TQRLabel;
    QRShape77: TQRShape;
    QRLabel173: TQRLabel;
    QRLabel174: TQRLabel;
    QRShape78: TQRShape;
    QRShape79: TQRShape;
    QRLabel175: TQRLabel;
    QRShape82: TQRShape;
    QRLabel178: TQRLabel;
    QRLabel177: TQRLabel;
    QRShape81: TQRShape;
    QRShape80: TQRShape;
    QRLabel176: TQRLabel;
    QRLabel180: TQRLabel;
    QRShape84: TQRShape;
    QRShape83: TQRShape;
    QRLabel179: TQRLabel;
    QRShape87: TQRShape;
    QRLabel164: TQRLabel;
    QRLabel165: TQRLabel;
    QRShape44: TQRShape;
    QRShape63: TQRShape;
    QRShape85: TQRShape;
    QRShape59: TQRShape;
    QRImage4: TQRImage;
    QRLabel3: TQRLabel;
    qrlEnderecoCedente1: TQRLabel;
    QRLabel46: TQRLabel;
    QRLabel88: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel110: TQRLabel;
    QRLabel135: TQRLabel;
    QRLabel138: TQRLabel;
    procedure LabelNomeTitularPrint(sender: TObject; var Value: String);
    procedure LabelEnderecoPrint(sender: TObject; var Value: String);
    procedure LabelCidadePrint(sender: TObject; var Value: String);
    procedure LabelNomeTitular2Print(sender: TObject; var Value: String);
    procedure LabelEndereco2Print(sender: TObject; var Value: String);
    procedure LabelCidade2Print(sender: TObject; var Value: String);
    procedure LabelNomeTitular3Print(sender: TObject; var Value: String);
    procedure LabelEndereco3Print(sender: TObject; var Value: String);
    procedure LabelCidade3Print(sender: TObject; var Value: String);
    procedure LabelNomeCedentePrint(sender: TObject; var Value: String);
    procedure QRLabel50Print(sender: TObject; var Value: String);
    procedure QRLabel51Print(sender: TObject; var Value: String);
    procedure QRLabel56Print(sender: TObject; var Value: String);
    procedure QRLabel54Print(sender: TObject; var Value: String);
    procedure QRLabel42Print(sender: TObject; var Value: String);
    procedure QRLabel57Print(sender: TObject; var Value: String);
    procedure QRLabel58Print(sender: TObject; var Value: String);
    procedure QRLabel59Print(sender: TObject; var Value: String);
    procedure QRLabel60Print(sender: TObject; var Value: String);
    procedure QRLabel40Print(sender: TObject; var Value: String);
    procedure QRLabel61Print(sender: TObject; var Value: String);
    procedure QRLabel62Print(sender: TObject; var Value: String);
    procedure QRLabel63Print(sender: TObject; var Value: String);
    procedure QRLabel64Print(sender: TObject; var Value: String);
    procedure QRLabel65Print(sender: TObject; var Value: String);
    procedure QRLabel67Print(sender: TObject; var Value: String);
    procedure QRLabel68Print(sender: TObject; var Value: String);
    procedure QRLabel83Print(sender: TObject; var Value: String);
    procedure QRLabel84Print(sender: TObject; var Value: String);
    procedure QRLabel70Print(sender: TObject; var Value: String);
    procedure QRLabel71Print(sender: TObject; var Value: String);
    procedure QRLabel66Print(sender: TObject; var Value: String);
    procedure QRLabel78Print(sender: TObject; var Value: String);
    procedure InsSacPrint(sender: TObject; var Value: String);
    procedure QRLabel6Print(sender: TObject; var Value: String);
    procedure QRLabel48Print(sender: TObject; var Value: String);
    procedure qrlLinDigPrint(sender: TObject; var Value: String);
    procedure FormCreate(Sender: TObject);
    procedure qrlEnderecoCedente1Print(sender: TObject; var Value: string);
  private
    { Private declarations }
    strNossoNu: String;
    StrCedent: String;

  public
    { Public declarations }
  end;

var
  frmQckBoletoItauPro: TfrmQckBoletoItauPro;

implementation

uses
   SysUtils, StrUtils, untFuncoesBoleto, untFuncoesSimples;

{$R *.dfm}

procedure TfrmQckBoletoItauPro.LabelNomeTitularPrint(sender: TObject;
  var Value: String);
begin

  Value := strNomSac;

end;

procedure TfrmQckBoletoItauPro.LabelEnderecoPrint(sender: TObject;
  var Value: String);
begin

  Value := strEndSac + ' - ' + strBaiSac;

end;

procedure TfrmQckBoletoItauPro.LabelCidadePrint(sender: TObject;
  var Value: String);
begin

  Value := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac

end;

procedure TfrmQckBoletoItauPro.LabelNomeTitular2Print(sender: TObject;
  var Value: String);
begin

	Value := strNomSac;

end;

procedure TfrmQckBoletoItauPro.LabelEndereco2Print(sender: TObject;
  var Value: String);
begin

  Value := strEndSac + ' - ' + strBaiSac;

end;

procedure TfrmQckBoletoItauPro.LabelCidade2Print(sender: TObject;
  var Value: String);
begin

  Value := fMaskCEP(strCep001) + ' ' + strCidSac + ' ' + strEstSac;

end;

procedure TfrmQckBoletoItauPro.LabelNomeTitular3Print(sender: TObject;
  var Value: String);
begin

	Value := strNomSac;

end;

procedure TfrmQckBoletoItauPro.LabelEndereco3Print(sender: TObject;
  var Value: String);
begin

  Value := strEndSac + ' - ' + strBaiSac;

end;

procedure TfrmQckBoletoItauPro.LabelCidade3Print(sender: TObject;
  var Value: String);
begin

  Value := strCep001 + ' ' + strCidSac + ' ' + strEstSac;

end;


procedure TfrmQckBoletoItauPro.LabelNomeCedentePrint(sender: TObject;
  var Value: String);
begin

  If Trim(strNumIns) <> '' Then
  Begin

    If strTipIns = '01' Then
      Value := strNomCed + '   ' + fMaskCNPJ(strNumIns)
    Else
      Value := strNomCed + '   ' + fMaskCPF(strNumIns);

  End
  Else
    Value := strNomCed;


end;

procedure TfrmQckBoletoItauPro.QRLabel50Print(sender: TObject;
  var Value: String);
begin
  Value := FormatDateTime('dd/mm/yyyy', dtaDtaVen);

end;

procedure TfrmQckBoletoItauPro.QRLabel51Print(sender: TObject;
  var Value: String);
begin
  Value := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);

end;

procedure TfrmQckBoletoItauPro.QRLabel56Print(sender: TObject;
  var Value: String);
begin
  value := strNumDoc;
end;

procedure TfrmQckBoletoItauPro.QRLabel54Print(sender: TObject;
  var Value: String);
begin
  Value := strEspDoc;
end;

procedure TfrmQckBoletoItauPro.QRLabel42Print(sender: TObject;
  var Value: String);
begin
  If strIdeAce = 'A' Then
    Value := 'S'
  Else
    Value := 'N';
end;

procedure TfrmQckBoletoItauPro.QRLabel57Print(sender: TObject;
  var Value: String);
begin

  Value := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
end;

procedure TfrmQckBoletoItauPro.QRLabel58Print(sender: TObject;
  var Value: String);
begin

  strCedent := strNumAge + strCodCed;
  Insert('/', strCedent, 5);
  Insert('-', strCedent, 11);
  Value := strCedent;

end;

procedure TfrmQckBoletoItauPro.QRLabel59Print(sender: TObject;
  var Value: String);

begin

  strNossoNu := strCodCar + strNosNum;
  Insert('/',strNossoNu, 4);
  Insert('-',strNossoNu, 13);
  Value := strNossoNu;

end;

procedure TfrmQckBoletoItauPro.QRLabel60Print(sender: TObject;
  var Value: String);
begin

  Value := FormatFloat('#,##0.00', fStrToFloat(LeftStr(strVlrTit, 8) + ',' + RightStr(strVlrTit, 2)));

end;

procedure TfrmQckBoletoItauPro.QRLabel40Print(sender: TObject;
  var Value: String);
begin
  Value := strUsoBan;
end;

procedure TfrmQckBoletoItauPro.QRLabel61Print(sender: TObject;
  var Value: String);
begin
   If Trim(strInstr1) <> '' Then
    Value := strInstr1;
end;

procedure TfrmQckBoletoItauPro.QRLabel62Print(sender: TObject;
  var Value: String);
begin
  If Trim(strInstr2) <> '' Then
    Value := strInstr2;
end;

procedure TfrmQckBoletoItauPro.QRLabel63Print(sender: TObject;
  var Value: String);
begin

  If Trim(strInstr3) <> '' Then
    Value := strInstr3;

end;

procedure TfrmQckBoletoItauPro.QRLabel64Print(sender: TObject;
  var Value: String);
begin

  If Trim(strInstr4) <> '' Then
    Value := strInstr4;

end;

procedure TfrmQckBoletoItauPro.QRLabel65Print(sender: TObject;
  var Value: String);
begin

  If Trim(strInstr5) <> '' Then
    Value := strInstr5;

end;

procedure TfrmQckBoletoItauPro.QRLabel67Print(sender: TObject;
  var Value: String);
begin
  Value := strLinDig;
end;

procedure TfrmQckBoletoItauPro.QRLabel68Print(sender: TObject;
  var Value: String);
begin
  Value := strCodBar;
end;

procedure TfrmQckBoletoItauPro.QRLabel83Print(sender: TObject;
  var Value: String);
begin
  If fltVlrMor > 0 Then
    Value := 'Após o vencimento cobrar ' + FormatFloat('R$ #,##0.00', fltVlrMor) +
             ' por dia de atraso.';

  If fltVlrMul > 0 Then
    Value := Trim(Value  + ' Após o vencimento cobrar multa de ' + FormatFloat('R$ #,##0.00', fltVlrMul));

end;

procedure TfrmQckBoletoItauPro.QRLabel84Print(sender: TObject;
  var Value: String);
  Var
    intProtesto : Integer;
begin

  Try
    intProtesto := StrToInt(strPraPro);
  Except
    intProtesto := 0;
  End;

  If intProtesto = 1 Then
  Begin
    Value := 'PROTESTAR APOS ' + strPraPro + ' DIA ' + IIF(strTipDia='1','UTIL', 'CORRIDO') + ' DO VENCIMENTO';
  End
  Else If intProtesto > 1 Then
  Begin
    Value := 'PROTESTAR APOS ' + strPraPro + ' DIAS ' + IIF(strTipDia='1','UTEIS', 'CORRIDOS') + ' DO VENCIMENTO';
  End;

end;

procedure TfrmQckBoletoItauPro.QRLabel70Print(sender: TObject;
  var Value: String);
begin
  Value := strCedent; 
end;

procedure TfrmQckBoletoItauPro.QRLabel71Print(sender: TObject;
  var Value: String);
begin

  Value := strNossoNu;
  
end;

procedure TfrmQckBoletoItauPro.QRLabel66Print(sender: TObject;
  var Value: String);
begin

  Value := strNossoNu;

end;

procedure TfrmQckBoletoItauPro.QRLabel78Print(sender: TObject;
  var Value: String);
begin

  Value := strNossoNu;

end;

procedure TfrmQckBoletoItauPro.InsSacPrint(sender: TObject;
  var Value: String);
begin

  If (strNuInSa <> '') Then
  Begin

    If (Length(Trim(strNuInSa)) > 11) Then
      Value := fMaskCNPJ(strNuInSa)
    Else
      Value := fMaskCPF(strNuInSa);

  End;

end;

procedure TfrmQckBoletoItauPro.QRLabel6Print(sender: TObject;
  var Value: String);
begin
  Value := strCodCar;
end;

procedure TfrmQckBoletoItauPro.QRLabel48Print(sender: TObject;
  var Value: String);
begin
  Value := strCodCar
end;

procedure TfrmQckBoletoItauPro.qrlEnderecoCedente1Print(sender: TObject;
  var Value: string);
begin
  If Trim(strEndere) <> '' Then
  Begin
    Value := strEndere;
  End
  Else
    Value := '';
end;

procedure TfrmQckBoletoItauPro.qrlLinDigPrint(sender: TObject;
  var Value: String);
begin
  Value := strLinDig;
end;

procedure TfrmQckBoletoItauPro.FormCreate(Sender: TObject);
  Var
    aPDF : TQRPDFDocumentFilter;
begin

  If blnBolPdf Then
  Begin
    aPDF := TQRPDFDocumentFilter.Create(ExtractFilePath(Application.ExeName) + '\Boletos\' + strNumDoc + '.pdf');
    aPDF.FontHandling := fhNoEmbedding;
    QckBoleto.ExportToFilter(aPDF);
    aPDF.Free;
  End
  Else
  Begin
    If Not( blnPegImp ) Then
      QckBoleto.Print
    Else
      QckBoleto.Preview;
  End;

end;

end.
